routerAdd(
  "POST",
  "/api/getlist",
  (c) => {
    let page = 1;
    let perPage = 50;
    let totalPages = 0;
    try {
      //this does not work outside the scope
      const helpers = require($filepath.join(__hooks, "helpers.js"));
      const { Buffer } = require($filepath.join(__hooks, "bufferPolyfill.js"));
      const reqInfo = $apis.requestInfo(c);
      //get the body of the request
      const body = reqInfo.data || {};
      // --- External URLs ---
      const extscheme = c.scheme(); // "http" or "https"
      const exthost = c.request().host; // full host from the request
      let extport = null;
      if (exthost.includes(":")) {
        // if host has port
        extport = exthost.split(":")[1];
      } else {
        extport = extscheme === "https" ? "443" : "80";
      }

      // internal and external URLs
      const inhost = `127.0.0.1:${extport}`; // always use local host internally
      const inBaseUrl = `${extscheme}://${inhost}`; // for local file fetches
      const outBaseUrl = `${extscheme}://${exthost}`; // public URL for clients

      //we want to get base64 of file fields
      const getFiles = body.getFiles || false;
      const fullList = body.fullList || false;
      // get the collection name
      const collection = body.collection;
      if (!collection)
        return c.json(400, { error: "getlist: Collection is required" });

      let coll;
      try {
        // Use the application's DAO to find the collection by its name or ID
        coll = $app.dao().findCollectionByNameOrId(collection);
      } catch (err) {
        // If the collection is not found, return a 404 error
        return c.json(404, {
          code: 404,
          message: `getlist: Collection '${collection}' not found.`,
        });
      }
      //get the schema of the collection
      const schema = coll.schema;
      //the schema is not a normal javascript object, so stringify and parse it
      const schemaText = JSON.stringify(schema);
      const fldList = JSON.parse(schemaText);
      //find all fields that are files
      const fileFields = [];
      const allFields = [];
      for (const field of fldList) {
        if (field.type === "file") {
          fileFields.push(field.name);
        }
        allFields.push(field.name);
      }
      // ✅ Add system fields based on collection type
      if (coll.type === "auth") {
        allFields.push(
          "id",
          "username",
          "email",
          "emailVisibility",
          "verified",
          "lastResetSentAt",
          "lastVerificationSentAt",
          "lastLogin",
          "created",
          "updated"
        );
      } else {
        // Base collection: add standard system fields
        allFields.push("id", "created", "updated");
      }

      //which page do we want to get
      page = parseInt(body.page) || 1;
      //how many items should there be per page
      perPage = parseInt(body.perPage) || 50;
      //should we skip records counting or not
      const skipTotal = body.skipTotal ? true : false;
      //which fields to select from the collection
      const fields = body.fields
        ? body.fields
            .split(",")
            .map((f) => f.trim())
            .filter((f) => f.length > 0)
        : allFields;
      //always include the id field
      if (!fields.includes("id")) {
        fields.push("id");
      }
      //do we have a sort order
      const sort = body.sort
        ? body.sort
            .split(",")
            .map((f) => f.trim())
            .filter((f) => f.length > 0)
        : [];
      //do we have filters
      let filter = body.filter
        ? body.filter
            .split(",")
            .map((f) => f.trim())
            .filter((f) => f.length > 0)
        : [];
      //do we have an own filter
      let ownFilter = body.ownFilter ? body.ownFilter.trim() : null;
      // --- Build ORDER BY clause ---
      let orderClause = "";
      if (sort.length > 0) {
        const orders = sort.map((f) => {
          let direction = "ASC";
          let fieldName = f;
          if (f.startsWith("-")) {
            fieldName = f.slice(1);
            direction = "DESC";
          }
          return `${fieldName} ${direction}`;
        });
        orderClause = " ORDER BY " + orders.join(", ");
      }

      // --- Build WHERE clause ---
      let conditions = [];

      if (ownFilter) {
        ownFilter = ownFilter.replace(/!=/g, "<>");
        ownFilter = ownFilter.replace(/&&/g, "AND");
        ownFilter = ownFilter.replace(/\|\|/g, "OR");
        ownFilter = ownFilter.replace(/~/g, "LIKE");
        conditions.push(`${ownFilter}`);
      }

      if (filter.length > 0) {
        // Loop through each item in the array
        for (let i = 0; i < filter.length; i++) {
          // Replace all occurrences of '!=' with '<>'
          filter[i] = filter[i].replace(/!=/g, " <> ");
          // Replace all occurrences of '~' with 'LIKE'
          filter[i] = filter[i].replace(/~/g, "LIKE");
        }

        const wrappedFilters = filter.map((f) => `(${f})`);
        conditions.push(...wrappedFilters);
      }

      let whereClause = "";
      if (conditions.length > 0) {
        whereClause = " WHERE " + conditions.join(" AND ");
      }

      // --- Build SELECT clause ---
      const fieldList = fields.join(", ");

      // Build the model shape first from the fields we want
      const modelShape = {};
      fields.forEach((f) => (modelShape[f] = ""));
      //add the file fields if any
      fileFields.forEach((f) => (modelShape[`${f}url`] = ""));

      let batch;
      let allRecords = [];
      let offset = 0;
      let sql;

      if (fullList) {
        //get all records
        do {
          sql = `SELECT ${fieldList} FROM ${collection}${whereClause}${orderClause} LIMIT ${perPage} OFFSET ${offset}`;
          // Initialize DynamicModel with shape
          batch = arrayOf(new DynamicModel(modelShape));
          $app.db().newQuery(sql).all(batch);
          allRecords = allRecords.concat(batch);
          offset += parseInt(perPage);
        } while (batch.length > 0);
      } else {
        //get this single page
        offset = (page - 1) * perPage;
        sql = `SELECT ${fieldList} FROM ${collection}${whereClause}${orderClause} LIMIT ${perPage} OFFSET ${offset}`;
        // Initialize DynamicModel with shape
        batch = arrayOf(new DynamicModel(modelShape));
        $app.db().newQuery(sql).all(batch);
        allRecords = allRecords.concat(batch);
      }

      // If we have file fields, we need to process them
      if (fileFields) {
        allRecords = allRecords.map((record) => {
          fileFields.forEach((field) => {
            const urlFieldName = `${field}url`;
            const fileFld = record[field];
            const idFld = record["id"];
            if (fileFld) {
              // create public URL for file
              const fileUrl = `${outBaseUrl}/api/files/${collection}/${idFld}/${fileFld}`;
              record[urlFieldName] = fileUrl;
              if (getFiles) {
                // get local file
                let fo = $filesystem.fileFromUrl(
                  `${inBaseUrl}/api/files/${collection}/${idFld}/${fileFld}`
                );
                const mimeType = helpers.detectMimeType(fo.reader.bytes);
                const base64String = Buffer.from(fo.reader.bytes).toString(
                  "base64"
                );
                const encoded = "data:" + mimeType + ";base64," + base64String;
                record[field] = encoded;
              }
            } else {
              record[urlFieldName] = "";
            }
          });
          return record;
        });
      }

      // --- Total count ---
      let rowcount = allRecords.length;
      totalPages = Math.ceil(rowcount / perPage);
      if (!skipTotal) {
        const countSql = `SELECT COUNT(*) AS total FROM ${collection}${whereClause}`;
        const countModel = new DynamicModel({ total: 0 });
        const countArr = arrayOf(countModel);
        $app.db().newQuery(countSql).all(countArr);
        rowcount = countArr[0]?.total || 0;
        totalPages = Math.ceil(rowcount / perPage);
      }

      return c.json(200, {
        items: allRecords,
        page,
        perPage,
        totalItems: rowcount,
        totalPages,
      });
    } catch (err) {
      return c.json(400, {
        page,
        perPage,
        items: [],
        error: err.message,
        totalPages,
        totalItems: 0,
      });
    }
  },
  $apis.activityLogger($app)
);

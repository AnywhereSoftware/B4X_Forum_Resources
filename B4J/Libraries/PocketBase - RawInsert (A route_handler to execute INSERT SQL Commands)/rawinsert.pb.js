routerAdd("POST", "/api/rawinsert/:collection/:id", async (c) => {
  const collection = c.pathParam("collection");
  const id = c.pathParam("id");

  // --- Validate required path params ---
  if (!collection || !id) {
    return c.json(400, {
      error: "Both collection and id path parameters are required",
    });
  }

  // --- Get request body ---
  const reqInfo = $apis.requestInfo(c);
  const body = reqInfo.data; // read the record to insert
  const data = body.record;
  if (!data) {
    return c.json(400, { error: "Request body is required" });
  }

  // --- Optional fields to return ---
  let returnFields = body.fields || "id,created";

  const dao = $app.dao();
  const coll = dao.findCollectionByNameOrId(collection);
  if (!coll) {
    return c.json(404, { error: "Collection not found" });
  }

  // --- Extract schema fields ---
  const schemaText = JSON.stringify(coll.schema);
  const fldList = JSON.parse(schemaText);
  const schemaFields = fldList.map((f) => f.name);
  // ✅ Add system fields based on collection type
  if (coll.type === "auth") {
    schemaFields.push(
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
    schemaFields.push("id", "created", "updated");
  }

  // --- Prepare insert fields & named bindings dynamically ---
  const fields = [];
  const bindings = {};

  for (let key in data) {
    if (schemaFields.includes(key)) {
      fields.push(key);
      bindings[key] = data[key];
    }
  }

  if (fields.length === 0) {
    return c.json(400, { error: "No valid fields provided" });
  }

  // --- Add required fields ---
  const now = new Date().toISOString();
  fields.push("id", "created", "updated");
  bindings["id"] = id;
  bindings["created"] = now;
  bindings["updated"] = now;

  // --- Build SQL using named bindings ---
  const placeholders = fields.map((f) => `{:${f}}`);
  const sql = `INSERT INTO ${collection} (${fields.join(
    ","
  )}) VALUES (${placeholders.join(",")})`;

  try {
    // --- Execute SQL asynchronously ---
    await $app.db().newQuery(sql).bind(bindings).execute();

    // --- Validate requested return fields against schema ---
    const returnFieldsArray = returnFields
      .split(",")
      .map((f) => f.trim())
      .filter((f) => schemaFields.includes(f) || ["id", "created"].includes(f));
    if (returnFieldsArray.length === 0) returnFieldsArray.push("id", "created");

    // --- Build DynamicModel based on return fields ---
    const resultObj = {};
    returnFieldsArray.forEach((f) => (resultObj[f] = ""));
    const result = new DynamicModel(resultObj);

    // --- Fetch the inserted record with requested fields ---
    const selectSQL = `SELECT ${returnFieldsArray.join(
      ", "
    )} FROM ${collection} WHERE id = {:id}`;
    await $app.db().newQuery(selectSQL).bind({ id: id }).one(result);

    return c.json(200, { success: true, record: result });
  } catch (err) {
    return c.json(500, { success: false, record: {id:""}, error: err.message});
  }
});

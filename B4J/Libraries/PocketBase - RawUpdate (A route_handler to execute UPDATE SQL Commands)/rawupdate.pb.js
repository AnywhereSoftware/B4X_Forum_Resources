routerAdd("POST", "/api/rawupdate/:collection", async (c) => {
  // 👉 Step 1: Get the collection name from the URL
  const collection = c.pathParam("collection");
  if (!collection) {
    return c.json(400, {
      error: "You must tell me which collection to update",
    });
  }

  // 👉 Step 2: Get the request body (the data sent to us)
  const reqInfo = $apis.requestInfo(c);
  const body = reqInfo.data;

  // The "record" part is what we want to update
  const data = body.record;
  if (!data) {
    return c.json(400, { error: "I need a record to update" });
  }

  // 👉 Step 3: Which fields should we give back to the user?
  // If the user didn’t say, we give back "id,updated" by default
  let returnFields = body.fields || "id,updated";

  // 👉 Step 4: Get the filter rules (like id='123')
  let filter = body.filter
    ? body.filter
        .split(",")
        .map((f) => f.trim())
        .filter((f) => f.length > 0)
    : [];

  if (filter.length === 0) {
    return c.json(400, {
      error: "You must tell me which record(s) to update with a filter",
    });
  }

  // 👉 Step 5: Look at the collection schema (all field names)
  const dao = $app.dao();
  const coll = dao.findCollectionByNameOrId(collection);
  if (!coll) {
    return c.json(404, { error: "Collection not found" });
  }

  // Get the schema fields
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

  // 👉 Step 6: Build the list of fields to update
  const setClauses = [];
  const bindings = {};

  for (let key in data) {
    // Only update fields that are in the schema (skip unknowns & "created")
    if (schemaFields.includes(key) && key !== "created") {
      setClauses.push(`${key} = {:${key}}`);
      bindings[key] = data[key];
    }
  }

  // If there are no valid fields to update, stop
  if (setClauses.length === 0) {
    return c.json(400, { error: "No valid fields to update were provided" });
  }

  // Always update the "updated" field with the current time
  setClauses.push("updated = {:updated}");
  bindings["updated"] = new Date().toISOString();

  // 👉 Step 7: Build WHERE clause from the filter rules
  const whereClauses = [];
  filter.forEach((f, idx) => {
    // Match patterns like: name='Anele' or age>30
    const match = f.match(/^(\w+)\s*(=|!=|<>|>|<|>=|<=|~)\s*['"]?(.*?)['"]?$/);
    if (!match) return;

    const [, field, op, value] = match;
    if (!schemaFields.includes(field)) return;

    // Fix operators: != becomes <> ; ~ becomes LIKE
    let sqlOp = op;
    if (sqlOp === "!=") sqlOp = "<>";
    if (sqlOp === "~") sqlOp = "LIKE";

    // Give each filter its own name (to avoid mix-ups)
    const paramName = `filter_${field}_${idx}`;
    whereClauses.push(`${field} ${sqlOp} {:${paramName}}`);
    bindings[paramName] = value;
  });

  if (whereClauses.length === 0) {
    return c.json(400, { error: "No valid filters provided" });
  }

  // 👉 Step 8: Build the final UPDATE SQL
  const sql = `UPDATE ${collection} SET ${setClauses.join(
    ", "
  )} WHERE ${whereClauses.join(" AND ")}`;
  console.log(sql, bindings);

  try {
    // 👉 Step 9: Run the UPDATE query
    await $app.db().newQuery(sql).bind(bindings).execute();

    // 👉 Step 10: Decide which fields to return
    const returnFieldsArray = returnFields
      .split(",")
      .map((f) => f.trim())
      .filter((f) => schemaFields.includes(f) || ["id", "updated"].includes(f));

    // If nothing valid, always return id and updated
    if (returnFieldsArray.length === 0) returnFieldsArray.push("id", "updated");

    // 👉 Step 11: Make a result object with empty values
    const resultObj = {};
    returnFieldsArray.forEach((f) => (resultObj[f] = ""));
    const result = new DynamicModel(resultObj);

    // 👉 Step 12: Fetch the updated record(s) back
    const selectSQL = `SELECT ${returnFieldsArray.join(
      ", "
    )} FROM ${collection} WHERE ${whereClauses.join(" AND ")}`;
    await $app.db().newQuery(selectSQL).bind(bindings).one(result);

    // 👉 Step 13: Send success back to the user
    return c.json(200, { success: true, record: result });
  } catch (err) {
    // 👉 Step 14: If something breaks, show the error
    return c.json(500, { success: false, record: {id:""}, error: err.message });
  }
});

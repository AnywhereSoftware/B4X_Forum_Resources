routerAdd(
  "POST",
  "/api/rawselect",
  (c) => {
    let perPage = 50;
    let totalPages = 0
    try {
      const reqInfo = $apis.requestInfo(c);
      //get the body we are passing
      const body = reqInfo.data || {};
      //get the sql comman
      let sqlQuery = body.query;
      //how many records per page
      perPage = parseInt(body.perPage) || 50;
      // Security checks
      const forbidden =
        /\b(DELETE|UPDATE|INSERT|DROP|ALTER|TRUNCATE|REPLACE|CREATE)\b/i;
      if (!/^SELECT\s+/i.test(sqlQuery.trim())) {
        return c.json(400, { error: "Only SELECT statements are allowed" });
      }
      //only SELECT is allowed
      if (forbidden.test(sqlQuery)) {
        return c.json(400, { error: "Dangerous SQL keyword detected" });
      }
      //avoid sql injection
      if (sqlQuery.includes(";")) {
        return c.json(400, { error: "Multiple statements are not allowed" });
      }

      /**
       * PocketBase JSVM helper: build a DynamicModel (and arrayOf DynamicModel)
       * from a SQL SELECT statement by extracting output column names safely.
       *
       * Goals:
       *  - Robustly parse the top-level SELECT list (handles functions, nested parens, quoted identifiers)
       *  - Respect aliases (AS ...) and fall back to sensible names if missing
       *  - Provide best-effort default values by heuristics (aggregates → 0, boolean-ish → false, timestamp-ish → "")
       *  - Never throw on normal SQL; returns an empty model if it cannot parse
       *
       * Works in PocketBase v0.22.x JavaScript hooks.
       */

      // ---------- Utilities ----------

      /** Strip SQL comments ( -- line and /* block *\ ) to simplify scanning */
      function stripSqlComments(sql) {
        let out = "";
        let i = 0;
        const n = sql.length;
        let inSingle = false,
          inDouble = false,
          inBacktick = false;
        while (i < n) {
          const ch = sql[i],
            next = i + 1 < n ? sql[i + 1] : "";

          // toggle quoted strings, respecting escapes by doubling ('') in SQL
          if (!inDouble && !inBacktick && ch === "'") {
            out += ch;
            i++;
            inSingle = !inSingle;
            while (inSingle && i < n) {
              out += sql[i];
              if (sql[i] === "'" && sql[i + 1] === "'") {
                // escaped single quote
                out += sql[i + 1];
                i += 2;
                continue;
              }
              if (sql[i] === "'") {
                inSingle = false;
                i++;
                break;
              }
              i++;
            }
            continue;
          }
          if (!inSingle && !inBacktick && ch === '"') {
            out += ch;
            i++;
            inDouble = !inDouble;
            while (inDouble && i < n) {
              out += sql[i];
              if (sql[i] === '"' && sql[i + 1] === '"') {
                // escaped double
                out += sql[i + 1];
                i += 2;
                continue;
              }
              if (sql[i] === '"') {
                inDouble = false;
                i++;
                break;
              }
              i++;
            }
            continue;
          }
          if (!inSingle && !inDouble && ch === "`") {
            out += ch;
            i++;
            inBacktick = !inBacktick;
            while (inBacktick && i < n) {
              out += sql[i];
              if (sql[i] === "`" && sql[i + 1] === "`") {
                // escaped backtick
                out += sql[i + 1];
                i += 2;
                continue;
              }
              if (sql[i] === "`") {
                inBacktick = false;
                i++;
                break;
              }
              i++;
            }
            continue;
          }

          // remove comments only if not in quotes
          if (!inSingle && !inDouble && !inBacktick) {
            // line comment -- ...\n
            if (ch === "-" && next === "-") {
              // skip until line end
              i += 2;
              while (i < n && sql[i] !== "\n") i++;
              continue;
            }
            // block comment /* ... */
            if (ch === "/" && next === "*") {
              i += 2;
              while (i < n && !(sql[i] === "*" && sql[i + 1] === "/")) i++;
              i += 2; // skip */
              continue;
            }
          }

          out += ch;
          i++;
        }
        return out;
      }

      /** Find the top-level SELECT ... FROM span (ignores nested selects inside the list) */
      function getTopLevelSelectList(sql) {
        const cleaned = stripSqlComments(sql);
        const lower = cleaned.toLowerCase();
        const n = cleaned.length;

        let i = 0;
        let inSingle = false,
          inDouble = false,
          inBacktick = false;
        let depth = 0;
        // find the first top-level 'select'
        let selStart = -1;
        while (i < n) {
          const ch = cleaned[i];
          const two = lower.slice(i, i + 6);
          // toggle quotes
          if (!inDouble && !inBacktick && ch === "'") {
            inSingle = !inSingle;
            i++;
            continue;
          }
          if (!inSingle && !inBacktick && ch === '"') {
            inDouble = !inDouble;
            i++;
            continue;
          }
          if (!inSingle && !inDouble && ch === "`") {
            inBacktick = !inBacktick;
            i++;
            continue;
          }
          if (inSingle || inDouble || inBacktick) {
            i++;
            continue;
          }

          if (ch === "(") {
            depth++;
            i++;
            continue;
          }
          if (ch === ")") {
            depth = Math.max(0, depth - 1);
            i++;
            continue;
          }

          if (depth === 0 && two === "select") {
            selStart = i + 6;
            i += 6;
            break;
          }
          i++;
        }
        if (selStart === -1) return ""; // no select

        // find the matching top-level FROM after selStart
        let fromIdx = -1;
        inSingle = inDouble = inBacktick = false;
        depth = 0;
        while (i < n) {
          const ch = cleaned[i];
          const four = lower.slice(i, i + 4);
          if (!inDouble && !inBacktick && ch === "'") {
            inSingle = !inSingle;
            i++;
            continue;
          }
          if (!inSingle && !inBacktick && ch === '"') {
            inDouble = !inDouble;
            i++;
            continue;
          }
          if (!inSingle && !inDouble && ch === "`") {
            inBacktick = !inBacktick;
            i++;
            continue;
          }
          if (inSingle || inDouble || inBacktick) {
            i++;
            continue;
          }

          if (ch === "(") {
            depth++;
            i++;
            continue;
          }
          if (ch === ")") {
            depth = Math.max(0, depth - 1);
            i++;
            continue;
          }

          if (depth === 0 && four === "from") {
            fromIdx = i;
            break;
          }
          i++;
        }
        if (fromIdx === -1) return "";

        return cleaned.slice(selStart, fromIdx).trim();
      }

      /** Split the SELECT list by commas at top level (ignore commas inside parens or quotes) */
      function splitTopLevel(selectList) {
        const items = [];
        let buf = "";
        let i = 0;
        const n = selectList.length;
        let inSingle = false,
          inDouble = false,
          inBacktick = false,
          depth = 0;
        while (i < n) {
          const ch = selectList[i];
          if (!inDouble && !inBacktick && ch === "'") {
            inSingle = !inSingle;
            buf += ch;
            i++;
            continue;
          }
          if (!inSingle && !inBacktick && ch === '"') {
            inDouble = !inDouble;
            buf += ch;
            i++;
            continue;
          }
          if (!inSingle && !inDouble && ch === "`") {
            inBacktick = !inBacktick;
            buf += ch;
            i++;
            continue;
          }

          if (!(inSingle || inDouble || inBacktick)) {
            if (ch === "(") {
              depth++;
              buf += ch;
              i++;
              continue;
            }
            if (ch === ")") {
              depth = Math.max(0, depth - 1);
              buf += ch;
              i++;
              continue;
            }
            if (ch === "," && depth === 0) {
              items.push(buf.trim());
              buf = "";
              i++;
              continue;
            }
          }

          buf += ch;
          i++;
        }
        if (buf.trim()) items.push(buf.trim());
        return items;
      }

      /** Unquote identifiers: "name", `name`, [name] → name */
      function unquoteIdent(id) {
        if (!id) return id;
        id = id.trim();
        const first = id[0],
          last = id[id.length - 1];
        if (
          (first === '"' && last === '"') ||
          (first === "`" && last === "`")
        ) {
          return id
            .slice(1, -1)
            .replace(/''/g, "'")
            .replace(/""/g, '"')
            .replace(/``/g, "`");
        }
        if (first === "[" && last === "]") return id.slice(1, -1);
        return id;
      }

      /** Extract output column name and classify expr */
      function parseSelectItem(raw, idx) {
        // Match trailing AS alias (case-insensitive), with optional quoting
        const asMatch = raw.match(
          /\s+as\s+((?:`[^`]+`)|(?:"[^"]+")|(?:\[[^\]]+\])|(?:[a-zA-Z_][a-zA-Z0-9_$]*))\s*$/i
        );
        if (asMatch) {
          const alias = unquoteIdent(asMatch[1]);
          const expr = raw.slice(0, asMatch.index).trim();
          return { name: alias, expr };
        }

        // If no AS, try to get the last token after a dot: table.column → column
        // Also handle quoted identifiers
        const dotParts = raw.split(".");
        let candidate = dotParts[dotParts.length - 1].trim();
        // Remove trailing casts like ::text if used
        candidate = candidate.replace(/::\w+$/i, "").trim();

        // If expression (contains spaces or parens) without alias, fallback name
        const isSimpleIdent = /^[`\"\[]?[a-zA-Z_][a-zA-Z0-9_$]*[\]\"`]?$/;
        if (!isSimpleIdent.test(candidate)) {
          return { name: `expr_${idx + 1}`, expr: raw };
        }

        return { name: unquoteIdent(candidate), expr: raw };
      }

      /** Heuristic default by expression and field name */
      function defaultFor(name, expr) {
        const nl = (name || "").toLowerCase();
        const el = (expr || "").toLowerCase();

        // Numeric aggregates and math
        if (/\b(count|sum|avg|total|min|max)\s*\(/.test(el)) return 0;
        if (/[+\-*/]/.test(el) && /\(|\)/.test(el)) return 0; // arithmetic expr

        // JSON aggregates → string (safe default). Customize if you expect arrays.
        if (/json_\w+\s*\(/.test(el) || /->>?/.test(el)) return "";

        // Boolean-ish names
        if (
          /^(is|has|can)[a-z0-9_]*$/.test(nl) ||
          /(active|enabled|disabled|status)$/.test(nl)
        )
          return false;

        // Timestamps / dates
        if (
          nl === "created" ||
          nl === "updated" ||
          /(\b|_)(created|updated|deleted)_?at\b/.test(nl) ||
          /(date|time)$/.test(nl)
        )
          return "";

        // Common counters
        if (nl === "records" || /count$/.test(nl)) return 0;

        // IDs often textual in PB/SQLite (may contain non-numeric)
        if (nl === "id" || /id$/.test(nl)) return "";

        // Fallback string
        return "";
      }

      /** Main: build a DynamicModel object (fields → defaults) from a SQL SELECT */
      function buildDynamicModelFromSQLSorted(sql) {
        try {
          const selectList = getTopLevelSelectList(sql);
          if (!selectList) return new DynamicModel({});

          const items = splitTopLevel(selectList);
          const modelObj = {};

          // Collect parsed fields first
          const fields = items.map((item, i) => parseSelectItem(item, i));

          // Sort by field name
          fields.sort((a, b) => a.name.localeCompare(b.name));

          // Populate model with defaults
          fields.forEach((f) => {
            if (!f.name) return;
            modelObj[f.name] = defaultFor(f.name, f.expr);
          });

          return new DynamicModel(modelObj);
        } catch (e) {
          return new DynamicModel({});
        }
      }

      /** Convenience: build arrayOf(DynamicModel) for .all() */
      function buildDynamicModelArrayFromSQL(sql) {
        return arrayOf(buildDynamicModelFromSQLSorted(sql));
      }
      //we have build everything, ready to execute
      let offset = 0;
      let batch;
      let allRecords = [];
      //execute the calls in batches until done
      do {
        batch = buildDynamicModelArrayFromSQL(
          sqlQuery + ` LIMIT ${perPage} OFFSET ${offset}`
        );
        $app
          .db()
          .newQuery(sqlQuery + ` LIMIT ${perPage} OFFSET ${offset}`)
          .all(batch);

        allRecords = allRecords.concat(batch);

        offset += parseInt(perPage);
      } while (batch.length > 0);

      // --- Total count ---
      let rowcount = allRecords.length;
      totalPages = Math.ceil(rowcount / perPage);      
      
      return c.json(200, {
        items: allRecords,
        totalItems: allRecords.length,
        perPage,
        totalPages
      });
    } catch (err) {
      return c.json(400, {
        items: [],
        error: err.message,
        totalItems: 0,
        perPage,
        totalPages
      });
    }
  },
  $apis.activityLogger($app)
);
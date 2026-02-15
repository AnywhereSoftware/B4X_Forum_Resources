### [Web] BANanoServer CRUD REST API by Mashiane
### 02/10/2026
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/170274/)

Hi Fam  
  
[Download Source & Demo](https://github.com/Mashiane/SithasoDaisy5-BANanoServer-CRUD-REST-API)  
  
As promised, here is the CRUD REST API for your BANanoServer Applications (you can do a little connection tweak it for pure jetty apps). Developed in partnership with [USER=74499]@aeric[/USER] , a big thank you.  
  
This project has been fully inspired by the [PHP-CRUD-API](https://github.com/mevdschee/php-crud-api). As this is used via jetty server (webserver), ***there is no need for PHP***  
  
This source code defines a **RESTful API class** built for the **B4J** framework, designed to handle automated database interactions via HTTP requests. It acts as a **middleware layer** that translates web methods like **GET, POST, PUT, and DELETE** into structured SQL commands for **MySQL** or **SQLite** backends. The script includes robust features for **data filtering, pagination, and sorting**, allowing clients to query specific records through URL parameters. **Security** is managed through integrated **API key validation** and a safety check that prevents unauthorized or destructive SQL injections. Additionally, the module handles **CORS headers** for browser compatibility and formats all outgoing data into standardized **JSON responses**. This implementation serves as a comprehensive **CRUD interface**, simplifying the process of managing database tables over a network.  
  
Thus, you do not need to create multiple controllers/handlers for CRUD for your back-end, you can just use this handler.  
  

```B4X
The base route for database operations is /api/records, while a specific route exists for custom queries at /api/query.  
Here are the endpoints defined in the code:  
1. Custom SQL Query  
• Endpoint: POST /api/query  
• Function: Executes a raw SQL SELECT statement provided in the request body.  
• Details:  
    ◦ The body must be a JSON object containing the query string.  
    ◦ It includes security checks to reject unsafe queries (e.g., INSERT, DELETE, DROP) or those containing multiple statements.  
    ◦ It returns the rows found and the count of affected rows.  
2. Read Records (GET)  
• Endpoint: GET /api/records/{table}  
• Function: Retrieves a list of records from the specified table.  
• Details:  
    ◦ This endpoint supports query parameters for filtering (e.g., filter=col,eq,val), ordering (order=col,asc), field selection (include=col1,col2), and paging (page=1&size=20).  
    ◦ It returns the records and the total result count if paging is used.  
• Endpoint: GET /api/records/{table}/{id}  
• Function: Retrieves a single record by its ID.  
• Details: Returns a 404 error if the record is not found.  
• Endpoint: GET /api/records/{table}/{id1,id2,…}  
• Function: Retrieves multiple specific records based on a comma-separated list of IDs.  
• Details: Returns a list of records matching the provided IDs.  
3. Create Records (POST)  
• Endpoint: POST /api/records/{table}  
• Function: Inserts one or more new records into the table.  
• Details:  
    ◦ The request body can be a single JSON object (to insert one row) or an array of objects (batch insert).  
    ◦ It returns the affected row count or a list of new IDs.  
    ◦ Requests that include an ID in the URL (e.g., /api/records/table/1) are rejected as "Bad request".  
4. Update Records (PUT)  
• Endpoint: PUT /api/records/{table}/{id}  
• Function: Updates a single record identified by the ID in the URL.  
• Details: The body must be a JSON object containing the fields to update.  
• Endpoint: PUT /api/records/{table}/{id1,id2,…}  
• Function: Updates multiple records identified by the comma-separated IDs in the URL.  
• Details:  
    ◦ If the body is a single map, that update is applied to all specified IDs.  
    ◦ If the body is a list, it must match the size of the ID list, applying specific updates to specific IDs.  
    ◦ It performs the updates inside a transaction.  
5. Delete Records (DELETE)  
• Endpoint: DELETE /api/records/{table}/{id}  
• Function: Deletes a single record identified by the ID.  
• Details: Returns the number of affected rows.  
• Endpoint: DELETE /api/records/{table}/{id1,id2,…}  
• Function: Deletes multiple records identified by the comma-separated IDs.  
• Details: Uses a transaction to delete the records and returns the results for each operation.  
6. CORS Support (OPTIONS)  
• Endpoint: OPTIONS (Any Valid Path)  
• Function: Handles Cross-Origin Resource Sharing (CORS) preflight checks.  
• Details: If EnableCORS is set to true, this returns a 204 success status to the browser.  
Authorization  
All endpoints check for an API key in the header X-API-Key. If the key does not match the server configuration, the request returns a 401 "Authorization Required" error.
```

  
  
  
[MEDIA=spotify]episode/68MikXnlRI24NrMry1LIrK[/MEDIA]  
  
  
[How does the BANanoServer CRUD REST API really work?](https://open.spotify.com/episode/2w4UGWCpCrlbiLLbIlpKMZ?si=VWjT2X0hTIWPsEalettQQA)
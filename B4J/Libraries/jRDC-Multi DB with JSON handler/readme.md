### jRDC-Multi DB with JSON handler by cheveguerra
### 11/22/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/168578/)

[HEADING=2]jRDC2-Multi Mod (B4J Server)[/HEADING]  
  
[SIZE=5][FONT=trebuchet ms]For the last version, check [here](https://www.b4x.com/android/forum/threads/jrdc2-multidb-server-json-hikaricp.169171/).[/FONT][/SIZE]  
  
[HEADING=2]1. Overview[/HEADING]  
  
> This post was written with the help of an AI, so if you notice too much formality, too much words, or too few words, I am 'totally innocent'. 😅

  
This project is a modded version of the original [jRDC2 Server](https://www.b4x.com/android/forum/threads/b4x-jrdc2-b4j-implementation-of-rdc-remote-database-connector.61801/), and the multi-database support is based on [this](https://www.b4x.com/android/forum/threads/jrdc2-multiple-database.112013/) modification, also by Erel.  
  
This version builds upon those concepts by adding a new **JSON-based** handler for modern web clients, while maintaining **full compatibility** with B4X clients.  
  
The primary motivation for creating the [ICODE]JSON[/ICODE] handler was the need for my **NodeJS-based WhatsApp Bot** to securely access the **same database** as my other B4A applications.  
  
This opens up connectivity to any modern technology stack that can handle HTTP requests and JSON ([ICODE]JavaScript, NodeJS, React, Vue, etc.[/ICODE]).  
  
By using the implicit security of the jRDC server architecture ([ICODE]the config.properties files[/ICODE]), this modification avoids the need to expose database credentials in client-side code or other backend scripts (like PHP), keeping all SQL commands and connection details safely on the server.  
  

---

  
  
[HEADING=2]2. Key Enhancements[/HEADING]  
  

- **Multi-Database Support**: Natively manage connections to up to 4 different databases simultaneously, each with its own configuration file.
- **Dual Request Handlers**:

- **Classic Handler:** Full compatibility with the B4X [ICODE]DBRequestManager[/ICODE].
- **JSON Handler:** A new endpoint that allows web clients to interact with the server using JSON requests and responses.

- **Dynamic Database Selection:** Choose which database to query directly from the request URL, making it easy to switch between data sources.
- **Remote Administration:** Check the server status, reload all configuration files (without restarting the server), or restart the server via simple HTTP requests.
- **Security Validations:** Automatically validates command existence and parameter counts on all incoming requests to prevent common errors.

  

---

  
  
[HEADING=2]3. Configuration[/HEADING]  
  
[HEADING=3]3.1. Configuration Files[/HEADING]  
  
The server can load up to four database configurations. It will only load the ones it finds, so you don't need to create all four.  
  
The file naming convention is crucial:  
  

- For the primary database (**DB1**): config.properties
- For the second database (**DB2**): config.**DB2**.properties
- For the third database (**DB3**): config.**DB3**.properties
- For the fourth database (**DB4**): config.**DB4**.properties

  
**Important Notes:**  
  

- The server port is taken **only** from the **main** [ICODE]config.properties[/ICODE] file. **Port** settings in other files are **ignored**.
- Connection details ([ICODE]JdbcUrl, User, Password, etc.[/ICODE]) are read from their corresponding configuration file.

  
[HEADING=3]3.2. Adding Additional Database Drivers[/HEADING]  
  
To connect to other database types (e.g. [ICODE]Oracle[/ICODE]), you must add the driver's .jar file to the project before compiling. In the Main module, add a line like this:  
  
> ' The name of the .jar file, in this case located at "C:\Path\To\Libs\ojdbc11.jar"  
> #AdditionalJar: ojdbc11

  
When compiled, the driver will be included in the final server [ICODE].jar[/ICODE], so there's no need to copy it separately to the production directory.  
  

---

  
  
[HEADING=2]4. Security Validations[/HEADING]  
  
The server performs two automatic checks on all incoming requests (both B4X and JSON handlers) **before** executing a database query:  
  

1. **Command Existence Check:** The server verifies that the requested command name (e.g., "[ICODE]get\_user[/ICODE]") exists as a valid SQL command key in the corresponding [ICODE].properties[/ICODE] file. If not found, it returns an error.
2. **Parameter Count Match:** If the SQL command expects parameters (contains [ICODE]?[/ICODE] placeholders), the server compares the expected count with the number of parameters received in the request. If they do not match, it returns an error.

These validations provide immediate and clear feedback for malformed requests.  
  

---

  
  
[HEADING=2]5. Using the Classic Handler (for B4X Clients)[/HEADING]  
  
This handler maintains **full compatibility** with [ICODE]DBRequestManager[/ICODE]. The database is selected dynamically by adding a path to the **URL**.  
  

- To use config.properties => <http://your-domain.com:8090>
- To use config.DB2.properties => <http://your-domain.com:8090/DB2>
- To use config.DB3.properties => <http://your-domain.com:8090/DB3>
- To use config.DB4.properties => <http://your-domain.com:8090/DB4>

  

---

  
  
[HEADING=2]6. Using the JSON Handler (for Web Clients)[/HEADING]  
  
This handler is designed for clients that communicate via **JSON**, such as **JavaScript** web applications.  
  
[HEADING=3]6.1. Endpoint and Request Methods[/HEADING]  
  
All requests are sent to the [ICODE]/DBJ[/ICODE] endpoint. The handler is flexible and accepts data in two ways:  
  
Recommended Method: [ICODE]POST[/ICODE] with a [ICODE]JSON[/ICODE] Body  
  
This is the standard and cleanest way for modern APIs.  

- HTTP Method: POST
- URL: <http://your-domain.com:8090/DBJ>
- Required Header: Content-Type: application/json
- Body (Payload): The [ICODE]JSON[/ICODE] object is sent directly in the request body.

Example Body:  
  

```B4X
{  
  "dbx": "DB2",  
  "query": "get_user",  
  "exec": "executeQuery",  
  "params": [  
    "CDAZA"  
  ]  
}
```

  
  
Legacy Method: [ICODE]GET[/ICODE] with [ICODE]'j'[/ICODE] Parameter  
  
This method is maintained for backward compatibility or for simple [ICODE]GET[/ICODE] requests.  

- HTTP Method: GET
- URL: The entire URL-encoded [ICODE]JSON[/ICODE] is sent as the value of the [ICODE]j[/ICODE] parameter.

Example with [ICODE]GET[/ICODE]:  
  
> <http://your-domain.com:8090/DBJ?j=>{"dbx":"DB2","query":"get\_user","exec":"executeQuery","params":["CDAZA"]}

  
[HEADING=3]6.2. JSON Payload Format[/HEADING]  
  
The structure of the [ICODE]JSON[/ICODE] object is the same for both methods:  
  
  

```B4X
{  
  "exec": "executeQuery",  
  "query": "sql_command_name",  
  "dbx": "DB1",  
  "params": [  
    "value1",  
    123  
  ]  
}
```

  
  

- **exec**: Either [ICODE]executeQuery[/ICODE] (for [ICODE]SELECT[/ICODE] statements) or [ICODE]executeCommand[/ICODE] (for [ICODE]INSERT, UPDATE, DELETE[/ICODE]).
- **query**: The name of the SQL command as defined in the corresponding config file (e.g., [ICODE]select\_user[/ICODE]).
- **dbx** (optional): The database key ([ICODE]DB1, DB2, etc[/ICODE].). If omitted, [ICODE]DB1[/ICODE] is used by default.
- **params** (optional): An object containing the parameters for the SQL query.

  
[HEADING=3]6.3. JSON Responses[/HEADING]  
  
The server's response is always in [ICODE]JSON[/ICODE] format and includes a boolean success field.  
  

- If [ICODE]success[/ICODE] is true, the data will be in the [ICODE]result[/ICODE] key.
- If [ICODE]success[/ICODE] is false, the error message will be in the [ICODE]error[/ICODE] key.

  

---

  
  
[HEADING=2]7. Server Administration[/HEADING]  
  
You can run management commands directly from a browser.  
  
Note: Access to the [ICODE]/manager[/ICODE] endpoint is protected. The credentials are:  
  

- **Username:** [ICODE]admin[/ICODE] (this is hardcoded in the server).
- **Default Password:** [ICODE]12345[/ICODE]

It is strongly recommended to change the password after your first login.  
  
**7.1. Public Commands (No Authentication)**  
  

- **Ping Server:**[ICODE]<http://your-domain.com:8090/ping>[/ICODE]

- Returns a simple [ICODE]PONG[/ICODE] to confirm the server is running.

- **Check Detailed Status:**[ICODE]<http://your-domain.com:8090/test>[/ICODE]

- Shows information about the database connections and general status.

**7.2. Protected Commands (Authentication Required)**  
  
These commands require an admin username and password to be configured in the main [ICODE]config.properties[/ICODE] file.  
  

- **Reload Configuration:** [ICODE]<http://your-domain.com:8090/manager?command=reload>[/ICODE]

- Rereads all [ICODE]config.\*.properties[/ICODE] files without restarting the server.

- **Restart Server (Standard):**[ICODE]<http://your-domain.com:8090/manager?command=rsx>[/ICODE]

- Executes the [ICODE]start.bat, start2.bat, and stop.bat[/ICODE] scripts.

- **Restart Server (with PM2):** [ICODE]<http://your-domain.com:8090/manager?command=rpm2>[/ICODE]

- Executes [ICODE]reiniciaProcesoPM2.bat[/ICODE] and assumes the process name is [ICODE]RDC-Multi[/ICODE]. The [ICODE].bat[/ICODE] file may need to be modified if your process name is different.
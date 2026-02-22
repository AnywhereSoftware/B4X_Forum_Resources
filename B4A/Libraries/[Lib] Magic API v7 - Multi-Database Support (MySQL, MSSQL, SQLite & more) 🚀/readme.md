### [Lib] Magic API v7 - Multi-Database Support (MySQL, MSSQL, SQLite & more) 🚀 by fernando1987
### 02/20/2026
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/170377/)

Hello everyone!  
  
I'm excited to announce the **Version 7** of **Magic API**. This update is a major milestone, transforming the library from a specialized MySQL tool into a **Universal Database Bridge** for B4X.  
  
Now, you can use the same B4X code to interact with different database engines, handling all the complex SQL syntax differences (quoting, schemas, and identifiers) automatically on the server side.  
  
[HEADING=2]🌟 Key Features in v7[/HEADING]  

- **Multi-Engine Compatibility:** Full support for **MySQL, MSSQL, SQLite, PostgreSQL, Oracle, and Firebird**.
- **Intelligent Quoting:** New server-side logic that automatically detects schemas (e.g., sys.databases) and applies the correct identifiers ([ ], ` or " ") based on the engine.
- **Unified Initialization:** A cleaner, single-method entry point for all your projects.
- **SQLite Ready:** Zero configuration for SQLite! Just drop your .db file in the same folder as the api.php and you're good to go.
- **Performance:** Refactored core to handle larger datasets and optimized memory usage.

[HEADING=2]🛠️ How to use it[/HEADING]  
The library is now smarter. You only need to tell it which engine your server is running:  
  

```B4X
Dim api as MagicApi  
' Initialize the connection  
api.Initialize("https://your-site.com", "1234", Me, "api")  
  
' Select your engine using the new constants  
api.DatabaseType = api.DB_MSSQL ' Options: DB_MYSQL, DB_MSSQL, DB_SQLITE, DB_POSTGRESQL, etc.  
  
' Get data as usual - Syntax is handled automatically!  
api.GetTable("users")  
Wait For api_GetTable(Result As List, Success As Boolean)  
if Success then  
log(Result)  
End if
```

  
[HEADING=2]📋 Server Side Setup[/HEADING]  

1. Upload the new api.php to your server.
2. Configure your credentials for **one** database engine inside the PHP file.
3. **Important:** When testing manually or via browser, it is recommended to add &db\_type=your\_engine to the URL.

> **Note on SQLite:** For SQLite deployments, the database file must be in the same directory as the script. Ensure your server has write permissions on that folder.
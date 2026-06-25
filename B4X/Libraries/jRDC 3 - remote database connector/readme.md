###  jRDC 3 - remote database connector by Erel
### 06/22/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/171345/)

This is version 3 of the beloved RDC feature - a middleware server that makes it simple to safely connect clients and remote SQL database servers.  
This update simplifies the clients API (the previous API was implemented before Resumable Subs feature was fully implemented). The data returned as a [ListOfArrays](https://www.b4x.com/android/forum/threads/b4x-loa-listofarrays-lightweight-powerful-and-flexible-collection.170543). It is no longer needed to add the annoying DBCommand / DBResult types to the main module. Note that the server is compatible with clients running v2+.  
  
RDC is made of two components:  
  
- B4J server. The server receives the requests from the clients, issues the SQL commands against the database and returns the results.  
In many cases the server will be hosted on the same computer that hosts the database server.  
  
- Client library. The client which is compatible with B4A, B4J and B4i is responsible for sending the requests and handling the responses.  
  
jRDC can work with any database that provides a JDBC driver. All popular databases are supported.  
The commands are configured on the server side.  
  
**Server configuration**  
  
1. Add the relevant JDBC jar file to the additional libraries folder.  
2. Add a reference to this jar. For example:  

```B4X
#AdditionalJar: mysql-connector-j-9.1.0
```

  
3. Configure the db server and SQL commands in the config.properties file. It is loaded from the assets folder in the example project. Starting with v3, it can be loaded from other places.  
  
Note that the configuration fields are case sensitive.  
  
*DriverClass / JdbcUrl* - The values of these two fields are specific to each database platform. You will usually find the specification together with the required driver jar file.  
  
*User / Password* - Database user and password.  
  
*ServerPort* - The Java server will listen to this provided port.  
  
*SQL Commands* - A list of commands. Each command starts with 'sql.'. The commands can include question marks (parameterised queries). Question marks will be replaced with the values provided by the Android clients. Note that the command name is case sensitive and it doesn't include the 'sql.' prefix.  
  
4. Run the program and test it locally by putting this link in the local browser: <http://localhost:17178/test>  
  
Note that the server port must be open for incoming connections in the firewall.  
  
**Client configuration**  
  
Add RDC\_Client library to the project.  
Initialize RDCManager with the server url. For example: "<http://192.168.1.102:17178/rdc>"  
Make queries with rdc.ExecuteQuery:  

```B4X
Wait For (rdc.ExecuteQuery("select_animal", Array(15))) Complete (Result As RDCResult) 'example of query that expects a single parameter
```

  
See attached example for more information.  
  
Attached files:  
RDC\_Client.b4xlib - the cross platform client library.  
RDC\_Server.zip - B4J server project.  
ClientExample - Client example.
###  jRDC2 - B4J implementation of RDC (Remote Database Connector) by Erel
### 03/13/2024
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/61801/)

[MEDIA=vimeo]260642577[/MEDIA]  
  
RDC is a middleware server that makes it simple to safely connect clients and remote SQL database servers.  
  
jRDC2 is the latest version. All new projects should use this version.  
  
jRDC2 is made of two components:  
  
- B4J server. The server receives the requests from the clients, issues the SQL commands against the database and returns the results.  
In many cases the server will be hosted on the same computer that hosts the database server.  
- Client module. The client which is compatible with B4A, B4J and B4i is responsible for sending the requests and handling the responses.  
  
jRDC2 can work with any database that provides a JDBC driver. All popular databases are supported.  
It is much more powerful than the PHP based solution and it has excellent performance.  
It is also safer as the SQL commands are set in the server side.  
  
**Server configuration**  
  
1. Add the relevant JDBC jar file to the additional libraries folder.  
2. Add a reference to this jar with:  

```B4X
#AdditionalJar: mysql-connector-java-5.1.27-bin
```

  
3. Edit config.properties file that is located in the Files tab.  
  
  
For example:  
  
![](http://www.b4x.com/basic4android/images/SS-2013-08-04_16.10.20.png)  
  
Note that the configuration fields are case sensitive.  
  
*DriverClass / JdbcUrl* - The values of these two fields are specific to each database platform. You will usually find the specification together with the required driver jar file.  
  
*User / Password* - Database user and password.  
  
*ServerPort* - The Java server will listen to this provided port.  
  
*Debug* - Option not used any more. It is automatically enabled when you run the server in debug mode (from the IDE).  
  
*SQL Commands* - A list of commands. Each command starts with 'sql.'. The commands can include question marks (parameterised queries). Question marks will be replaced with the values provided by the Android clients. Note that the command name is case sensitive and it doesn't include the 'sql.' prefix.  
  
4. Run the program and test it locally by putting this link in the local browser: [plain]<http://localhost:17178/test>[/plain]  
  
Note that the server port must be open for incoming connections in the firewall.  
  
**Client configuration**  
  
1. Add to **Main** module (must be in Main module):  

```B4X
Sub Process_Globals  
   Type DBResult (Tag As Object, Columns As Map, Rows As List)  
   Type DBCommand (Name As String, Parameters() As Object)  
   Private const rdcLink As String = "http://192.168.0.6:17178/rdc"  
End Sub
```

  
Change the link with the ip address or host name of the server hosting jRDC2. It must end with /rdc.  
  
2. Add DBRequestManager class to your project.  
It depends on RandomAccessFile and OkHttpUtils2 libraries (or the matching libraries in B4J or B4i).  
  
3. Add these two subs:  

```B4X
Sub CreateRequest As DBRequestManager  
   Dim req As DBRequestManager  
   req.Initialize(Me, rdcLink)  
   Return req  
End Sub  
  
Sub CreateCommand(Name As String, Parameters() As Object) As DBCommand  
   Dim cmd As DBCommand  
   cmd.Initialize  
   cmd.Name = Name  
   If Parameters <> Null Then cmd.Parameters = Parameters  
   Return cmd  
End Sub
```

  
  
A new DBRequestManager is created for each request.  
  
Example of sending a SELECT request:  

```B4X
Sub GetRecord (id As Int)  
   Dim req As DBRequestManager = CreateRequest  
   Dim cmd As DBCommand = CreateCommand("select_animal", Array(id))  
   Wait For (req.ExecuteQuery(cmd, 0, Null)) JobDone(j As HttpJob)  
   If j.Success Then  
       req.HandleJobAsync(j, "req")  
       Wait For (req) req_Result(res As DBResult)  
       'work with result  
       req.PrintTable(res)  
   Else  
       Log("ERROR: " & j.ErrorMessage)  
   End If  
   j.Release  
End Sub
```

  
The select\_animal command is defined in the config file:  

```B4X
sql.select_animal=SELECT name, image, id FROM animals WHERE id = ?
```

  
  
Note that you can make multiple requests at the same time.  
The result is a DBResult object.  
  
Example of sending an INSERT request:  

```B4X
Sub InsertRecord (Name As String)  
   Dim cmd As DBCommand = CreateCommand("insert_animal", Array(Name, Null))  
   Dim j As HttpJob = CreateRequest.ExecuteBatch(Array(cmd), Null)  
   Wait For(j) JobDone(j As HttpJob)  
   If j.Success Then  
       Log("Inserted successfully!")  
   End If  
   j.Release  
End Sub
```

  
In this case a single command was sent. You can send multiple commands at once.  
The insert\_animal command is defined in the config file:  

```B4X
sql.create_table=CREATE TABLE IF NOT EXISTS animals (\  
     id INTEGER PRIMARY KEY AUTO_INCREMENT,\  
     name CHAR(30) NOT NULL,\  
     image BLOB)  
sql.insert_animal=INSERT INTO animals VALUES (null, ?,?)
```

  
  
  
**Notes**  
  
- Running a B4J server program on your hosted server: [[server] Run a Server on a VPS](https://www.b4x.com/android/forum/threads/60378/#content)  
- There are three utility methods in DBRequestManager: FileToBytes, ImageToBytes and BytesToImage. You can use them when working with blobs.  
- Extending jRDC2 to support B4R: <https://www.b4x.com/android/forum/threads/rdc-based-on-mqtt.72416/#content>  
  
**Updates**  
  
v2.23 - Adds support for CLOB fields (large strings).  
v2.22 - Fixes an issue with null time values.  
v2.21 - Date and time fields are converted to ticks (long numbers) automatically in select queries.  
Note that the VERSION1 code is excluded by default. It is only relevant if there are clients running the old RDC code.  
  
  
**Please start a new thread for any question you have.**
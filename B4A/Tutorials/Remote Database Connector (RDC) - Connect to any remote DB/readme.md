### Remote Database Connector (RDC) - Connect to any remote DB by Erel
### 01/10/2021
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/31540/)

****jRDC version 2 is available here: [https://www.b4x.com/android/forum/t...ation-of-rdc-remote-database-connector.61801/](https://www.b4x.com/android/forum/threads/class-jrdc2-b4j-implementation-of-rdc-remote-database-connector.61801/)****  
  
[SPOILER="Old and shouldn't be open"]This tutorial covers a new framework named Remote Database Connector (RDC). The purpose of RDC is to make it simple to develop Android applications that interact with remote database servers.  
  
There are two components in this framework: a lightweight Java web server (the middleware) and a B4A class named DBRequestManager that interacts with this web server.  
  
The Java web server can connect to any database platform that provides a JDBC driver.  
  
This includes: MySQL, SQL Server, Oracle, Sybase, DB2, postgreSQL, Firebird and [many others](http://www.oracle.com/technetwork/java/index-136695.html).  
  
You can also use the web server without a database server by [connecting to a local SQLite database file](http://www.b4x.com/android/forum/threads/rdc-simple-way-to-create-your-own-back-end-database.31616/).  
  
The Java web-server is a simple server that connects to the database server and to the Android clients.  
As this is a Java app you can run it on Linux or Windows computers. It requires Java JRE 6 or 7.  
  
This solution is much more powerful than the PHP (MySQL) and ASP.Net (MS SQL) solutions that are already available.  
  
Main advantages over previous solutions:  

- Support for many types of database platforms.
- Significantly better performance.
- SQL statements are configured in the server (safer).
- Support for all types of statements, including batch statements.
- Support for BLOBs.

  
**Server Configuration**  
  
JDBC is a Java API that provides a standard method to access any database. A database driver (jar file) is required for each type of database. You will need to download the driver for your database and put it in the jdbc\_driver folder.  
  
The Java server configuration is saved in a file named config.properties.  
This file includes two sections: general configuration and a list of SQL commands.  
  
For example:  
  
![](http://www.b4x.com/basic4android/images/SS-2013-08-04_16.10.20.png)  
  
Note that the configuration fields are case sensitive.  
  
*DriverClass / JdbcUrl* - The values of these two fields are specific to each database platform. You will usually find the specification together with the required driver jar file.  
  
*User / Password* - Database user and password.  
  
*ServerPort* - The Java server will listen to this provided port.  
  
*Debug* - If Debug is set to true then the SQL commands list will be loaded on every request. This is useful during development as it allows you to modify the commands without restarting the server process.  
  
*SQL Commands* - A list of commands. Each command starts with 'sql.'. The commands can include question marks (parameterised queries). Question marks will be replaced with the values provided by the Android clients. Note that the command name is case sensitive and it doesn't include the 'sql.' prefix.  
  
**Client Code**  
The client sends requests to the server. There are two types of requests: query requests (usually SELECT statements) and batch requests (any other statement).  
  
Note that both the client and the server can manage multiple requests in parallel.  
Usually you will only need a single DBRequestManager object.  
  
Each request is made of a command (or a list of commands) and a tag. The tag can be any object you like. You can use it later when the result is ready. The tag is not sent to the server.  
  
A command is an object of type DBCommand:  

```B4X
Type DBCommand (Name As String, Parameters() As Object)
```

  
*Name* - The case sensitive command name as configured in the server configuration (without sql.).  
*Parameters* - An array of objects that will be sent to the server and will replace the question marks in the command.  
  
For example to send a SELECT request:  

```B4X
Dim cmd As DBCommand  
cmd.Initialize  
cmd.Name = "select_animal"  
cmd.Parameters = Array As Object("cat 1")  
reqManager.ExecuteQuery(cmd, 0, "cat 1")
```

  
*ExecuteQuery* expects three parameters: the command, maximum number of rows to return or 0 if there is no limit and the tag value.  
  
Under the hood DBRequestManager creates a HttpJob for each request. The job name is always "DBRequest".  
  
You should handle the JobDone event in your activity or service:  

```B4X
Sub JobDone(Job As HttpJob)  
   If Job.Success = False Then  
     Log("Error: " & Job.ErrorMessage)  
   Else  
     If Job.JobName = "DBRequest" Then  
       Dim result As DBResult = reqManager.HandleJob(Job)  
       If result.Tag = "cat 1" Then 'query tag  
         For Each records() As Object In result.Rows  
           Dim name As String = records(0) 'or records(result.Columns.Get("name"))  
           Log(name)  
         Next  
       End If  
     End If  
   End If  
   Job.Release  
End Sub
```

  
  
As you can see in the above code, DBRequestManager.HandleJob method takes the Job and returns a DBResult object:  

```B4X
Type DBResult (Tag As Object, Columns As Map, Rows As List)
```

  
*Tag* - The request tag.  
*Columns* - A Map with the columns names as keys and the columns ordinals as values.  
*Rows* - A list that holds an array of objects for each row in the result set.  
  
Non-select commands are sent with ExecuteCommand (single command) or ExecuteBatch (any number of commands). It is significantly faster to send one request with multiple commands over multiple requests. Batch statements are executed in a single transaction. If one of the commands fail all the batch commands will be cancelled (roll-backed).  
  
Note that for non-select requests, Rows field in the results will hold an array with a single int for each command. The int value is the number of affected rows (for each command separately).  
  
Initializing DBRequestManager:  

```B4X
Sub Activity_Create(FirstTime As Boolean)  
   If FirstTime Then  
     reqManager.Initialize(Me, "http://192.168.0.100:17178")  
   End If  
End Sub
```

  
The first parameter is the module that will handle the JobDone event.  
The second parameter is the link to the Java server (with the port number).  
  
DBRequestManager provides the following helper methods for common tasks related to BLOB fields: *FileToBytes, ImageToBytes* and *BytesToImage.*It also includes a method named *PrintTable* that prints DBTable objects to the logs.  
  
**Framework Setup**  

1. Unpack the server zip file.
2. You will need to download the driver for your database platform and copy the jar file to jdbc\_driver folder.
3. Edit config.properties as discussed above.
4. Edit RunRLC.bat and set the path to java.exe. If you are running it on Linux then you need to create a similar script with the path to java. On Linux you should change the ';' separator to ':'.
5. Run the server :)
You should see something like:
![](http://www.b4x.com/basic4android/images/SS-2013-08-04_17.05.16.png)
Note that the path to config.properties is printed in the second line.6. Add an exception for the server port in your firewall.
7. Try to access the server from the browser:
![](http://www.b4x.com/basic4android/images/SS-2013-08-04_17.06.17.png)
You will probably not see the above message on the first run :(. Instead you will need to check the server output and read the error message.
If you are able to call the server from the local computer and not from other devices then it is a firewall issue.
  
**Tips**  
  

- MySQL driver is available here: <http://dev.mysql.com/downloads/connector/j/>
- Google for <your database> JDBC Driver to find the required driver. For SQL Server you can use this open source project: <http://jtds.sourceforge.net/>
- The server uses an open source project named c3p0 to manage the database connection pool. It can be configured if needed by modifying the c3p0.properties file.
- Use a text editor such as Notepad++ to edit the properties file.
- If you are running the server on Linux then you can run it with nohup to prevent the OS from killing the process when you log out.
- Java doesn't need to be installed. You can just unpack the files.

The server is based on the two following open source projects:  
Jetty - <http://www.eclipse.org/jetty/>  
c3p0 - <http://www.mchange.com/projects/c3p0/index.html>[/SPOILER]
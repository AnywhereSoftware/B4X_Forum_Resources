### Modded jRDC2 w/SQLite support and more by OliverA
### 07/29/2024
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/85578/)

Attached you'll find a modified version of jRDC2 (source <https://www.b4x.com/android/forum/threads/class-jrdc2-b4j-implementation-of-rdc-remote-database-connector.61801/>) that supports SQLite as the datastore out of the box. Support for V1 has been removed and therefore this is not a drop in replacement for jRDC2. This is more meant for people starting new with jRDC2. Comments are welcome (pro and con). Other modifications are listed in the main file and are relisted here:  
  
Note: The stored procedures add-on is technically unnecessary. Out of the box, jRDC2 can handle simple stored procedures (that just return a result set) via ExecuteQuery. If anyone is interested in fleshing this out, PM me. I would rely on you to be knowledgeable in stored procedures and have your own DB available to test the jRDC2 server against. Finally, you have to have patience with me, I'm slow.  
  
Client example can be found here: <https://www.b4x.com/android/forum/threads/jrdc2-client-example-using-modded-jrdc2.85581/#content>  
  
'2024.07.27:  
' Moved notes from Main to here (code module AppNotes)  
' Merge changes from [USER=1]@Erel[/USER]'s jRDC2 version 2.23  
' Merged MSSQL date issue from <https://www.b4x.com/android/forum/threads/jrdc2-errors-when-querying-sql-server-datetimeoffset-column.129256/post-812054>  
' This should also take care of <https://www.b4x.com/android/forum/threads/jrdc2-retrieve-sql-server-datetime2-as-utc.129255/>  
  
'2020/05/28 Removed show-stopping bug in /test handler. Cannot close DB if it is SQLite.  
'  
'2020/04/24 Changes:  
'  
'Updated source to match updates/features of jRDC2 2.22  
'  
'Added ability to use "simple" stored procedures. Modified DBRequestManager to allow usage of  
'new feature. This was done with the help of [USER=105083]@Chris Guanzon[/USER].  
'In config properties, set up SQL statement to call stored procedure  
'

```B4X
sql.sLogin=CALL sLogin(?,?)  
'
```

  
'Usage sample on client side (using updated DBRequestManager):  
'  
'

```B4X
Dim req As DBRequestManager = CreateRequest  
Dim cmd As DBCommand = CreateCommand("sLogin", Array(EditText1.Text, EditText2.Text))  
Wait For (req.ExecuteCall(cmd, 0, Null)) JobDone (j As HttpJob)  
If j.Success Then  
    req.HandleJobAsync(j, "req")  
    Wait For (req) req_Result (res As DBResult)  
    'work with result  
    req.PrintTable(res)  
Else  
    Log("ERROR: " & j.ErrorMessage)  
End If  
j.Release  
'
```

  
  
'\*\*\*\*\*\*  
'2017/10/30 Update  
'\*\*\*\*\*\*  
'Main module changes:  
'——————-  
'Added the logging of one of the IP addresses that the server is bound to. The method.  
' to retrieve the IP address is similar to ServerSocket's GetMyIP method. It was adapted  
' from <https://issues.apache.org/jira/browse/JCS-40>.  
'Added ability to assign server to a specific IP address.  
  
'RDCConnector changes:  
'——————–  
'Added IPAddress configuration option. Allows to set the jRDC server's IP address. An un-bindable  
' address will crash the server.  
'Added HasIPAddress and GetIPAddress to access IPAddress configuration.  
'Added support for SQLite. If the DriverClass contains SQLite (case insensitive), then jRDC  
' is configured for SQLite usage. SQLite does not use pools. Pool/non-pool handling gleaned  
' from DBM.bas module of ABMaterial.  
'Added CreateFile configuration option. This option is used for the SQLite backend  
' (if used). If set to True or set to 1, then the SQLite database will be created in  
' case it does not exist yet. Any other settings are interpreted as False.  
'Added PoolSize configuration option. This is the size of the pool that should be used  
' for pooled JDBC databases. This option was gleaned from the DBM.bas module of ABMaterial.  
'Modified GetCommand to return empty string ("") when no command found.  
'Modified GetConnection to handle non-pool SQL connections (SQLite).  
  
'RDCHandler changes:  
'——————-  
'Modified Handler to not close the databas connection in case a pool is not used, else SQLite  
' will not function properly  
'Modified ExecuteQuery2 and ExecuteBatch2 to check cmd.Parameters for Null. This removed a  
' Null pointer exception error message in case cmd.Parameters was Null. Also call  
' ExecQuery/ExecNonQuery when no cmd.Parameters are given.  
'Modified ExecuteQuery2 and ExecuteBatch2 to check for valid command. If no valid command found,  
' return 500 error with proper response. This takes care of a syntax exception error for the DB.  
' in case of MySQL it looks something like this:  
' com.mysql.jdbc.exceptions.jdbc4.MySQLSyntaxErrorException: You have an error in your SQL syntax;  
' check the manual that corresponds to your MySQL server version for the right syntax to use near 'null' at line 1  
'Modified Try/Catch block in ExecuteBatch2. Moved the code below the End Try that dealt with  
' converting the DBResult object and sending it to the client into end of the Try block. This  
' took care of an java.lang.IllegalStateException: WRITER exception caused by OutputStream when  
' called after the Catch's SendError.  
'Added Try/Catch block to ExecuteQuery2. This should prevent the following on the B4X client  
' side: java.io.EOFException: Unexpected end of ZLIB input stream  
'**Removed all jRDC v1 functionality.**  
  
'Miscellaneous notes:  
'——————-  
'The config.properties contains sql. directives that pertain to a jRDC version of the DBUtils  
' demo.  
'Per usual, please ensure you have the proper #AdditionalJar set for the database backend  
' of your choice (even for SQLite).
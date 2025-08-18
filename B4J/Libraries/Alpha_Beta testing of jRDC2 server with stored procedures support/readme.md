### Alpha/Beta testing of jRDC2 server with stored procedures support by OliverA
### 10/10/2020
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/123294/)

Looking for testers!!!!  
  
This modification adds support for calling stored procedures that can return zero or more result sets and zero or more output parameters to my previously modified jRDC2 server (<https://www.b4x.com/android/forum/threads/modded-jrdc2-w-sqlite-support-and-more.85578/>). It uses JDBC’s CallableStatement (<https://docs.oracle.com/javase/8/docs/api/java/sql/CallableStatement.html>) and has the ability to use named parameters. For all JDBC drivers, this allows you to name parameters that are passed to the CallableStatement. As for using named parameters as part of your SQL statement, that is JDBC driver specific (and version 5.1.49 for MySQL does not seem to support them).  
  
In order to support CallableStatment, an additional method (ExecuteCall2) was added to the jRDC2 code and two methods (ExecuteCall and HandleCallJobAsync) have been added to the DBRequestManager.  
  
Example Usage:  
  
In config.properties:  

```B4X
sql.UserLogin=CALL spUserLogin_GET(?, ?, ?)
```

  
Note: No named parameters as part of the SQL statement. Connector/J 5.1.49 does not seem to support it. I may be wrong and will be gladly corrected on this.  
  
In MySQL (this is just for testing. You’ll have to create your own routine):  

```B4X
CREATE DEFINER=`root`@`%` PROCEDURE `spUserLogin_GET`(       IN varUserName VARCHAR(255),  
       IN varPassword VARCHAR (255),  
       OUT varResponse LONGTEXT)  
sp:  
BEGIN  
     DECLARE tempUserId VARCHAR(20) DEFAULT "";  
     
     #check if all required fields are not empty  
     IF varUserName = '' OR varPassword = '' THEN  
        SET varResponse = '{"status": 105, "message": "Please fill up all required fields."}';  
        LEAVE sp;  
     END IF;  
     
     SELECT id  
     INTO tempUserId  
     FROM user_accounts  
     WHERE username = varUserName AND password = varPassword;  
     
     IF tempUserId = '' THEN  
        SET varResponse = '{"status": 104, "message": "Invalid user credentials."}';  
        LEAVE sp;  
     END IF;  
     
     SET varResponse = '{"status": 100, "message": "Login Successfully!"}';  
     
     SELECT @varResponse as response;  
END
```

  
  
On the client, setting up the DBCommand for the above would be something like this:  

```B4X
    Dim cmd As DBCommand = CreateCommand("UserLogin", _  
        Array("John", CreateMap("value":"Doe"), CreateMap("name":"varResponse", "type":"OUT", "sqlType": "VARCHAR")))
```

  
Note the parameter array. This array will now contain either values only, maps only, or a combination thereof. If the array item is a value only (such as “John” above) it will set the parameter via the setObject method (just like the SQL library does). If a map is used, then the following happens:  
  
The type of parameter (IN, INOUT, OUT) is determined by the key “type”. If that key is missing, the parameter defaults to IN.  
  
The SQL type that should be used for a given parameter can get set by using the “sqlType” key. This should be set to a string of the desired type available for a given “sqlTypeClass”. As is, the only “sqlTypeClass” supported is “JDBC” (and if “sqlTypeClass” is not set, will default to “JDBC”). The “JDBC” type class is mapped to “java.sql.Types” and he values for this class can be found here: <https://docs.microsoft.com/en-us/sql/connect/jdbc/using-basic-data-types?view=sql-server-ver15>. Other type classes can be added, but require a modification of the jRDC2 servers code (It happens in the few lines of code follwing AppStart).  
  
To pass on a SQL NULL value for an IN/INOUT parameter, the “sqlType” must be set and the “value” key must not be present. So  

```B4X
CreateMap(“sqlType”:”VARCHAR”)
```

  
Will call CallableStatement’s setNull method, passing it the VARCHAR SQL type.  
  
For OUT parameters, the minimum requirements are the “type” key (can be OUT or INOUT) and the “sqlType” key. If the “name” key is missing, then the index position (plus one) within the parameters array will be used to set the parameter. If the “name” key is set, then the value of the “name” key will be used to set the parameter. In the example above  

```B4X
CreateMap("name":"varResponse", "type":"OUT", "sqlType": "VARCHAR")
```

  
will translate to the following method call  

```B4X
registerOutParameter(“varResponse”, 12)
```

  
Whereas if the map would be  

```B4X
CreateMap("type":"OUT", "sqlType": "VARCHAR")
```

  
would produce the following call  

```B4X
registerOutParameter(3, 12)
```

  
  
To execute the command, use the new ExecuteCall method  

```B4X
Wait For (req.ExecuteCall(cmd, 0, Null)) JobDone(j As HttpJob)
```

  
  
If this call is successful, use the new HandleCallJobAsync method with its associated \_CallResult callback event to process the results  
  

```B4X
    If j.Success Then  
        Log("Call executed successfully")  
        req.HandleCallJobAsync(j, "req")  
        Wait For (req) req_CallResult(resultSets As List, parameters As Map)  
        'Let's print out the returned result sets. resultSets is a list containing 0 or more DBResult objects.  
        For Each res As DBResult In resultSets  
            req.PrintTable(res)  
        Next  
        'Let's print the returned OUT parameters  
        Log($"Parameters map content: ${parameters}"$)  
    Else  
        Log($"ERROR: ${j.ErrorMessage}"$)  
    End If
```

  
  
Note: This jRDC2 modification is for testing purposes only (and I hope some of you will test this code). Run the modified jRDC2 server in DEBUG mode. There should be plenty of Log() statements to inform one of what is going on. Any issues encountered, please relay them to me in this thread.  
  
Note2: Thanks to [USER=105083]@Chris Guanzon[/USER] for kick starting this journey  
  
Note3: This write-up probably leaves a lot of details out. The source should help with some questions, otherwise, feel free to ask.  
  
Updates:  
2020/10/09: Update (jRDCv2\_mod.2020.10.09.02a\_published.zip) contains the code change to check if more ResultSets are available (see post[#5](https://www.b4x.com/android/forum/threads/alpha-beta-testing-of-jrdc2-server-with-stored-procedures-support.123294/post-770277))
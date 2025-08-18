### Heavily modified jRDC2 testing server code dump by OliverA
### 03/03/2021
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/128258/)

This is the source code dump of a heavily modified jRDC2 server used for testing different databases, different connection pools, JDBC driver properties, etc. This server should not be used in production environments! This server is based on jRDC2 2.21 (yeah a little old) and may contain additional bugs (SQLite closing when using /test URL is one of them).  
  
1) Beyond the /rdc and the /test URL's, this server also exposes /shutdown and /restart. As their names imply, /shutdown will shut down jRDC2 and exit the program. /restart will cause the jRDC2 server instance to be restarted (without restarting the complete application), which in turn allows it to reload the configuration file  
2) In this source, the configuration file's location is set to File.DirApp. If the configuration file is not located there, the server will copy the one in File.DirAssets to File.DirApp. From then on (until deleted), the server will use the configuration file located in File.DirApp. This file and the /restart URL can be used to change things (and break things) on the fly  
3) This has a lot of new features in the config.properties file  
a) You can pick which database pool to use. The option is called PoolType and the values can be C3P0, H2, HSQLDB, Hikari, Vibur, Tomcat  
b) You can turn pool usage off, via the option UsePool and setting it to False (or 0)  
c) You can set the pool size via PoolSize  
d) Pool properties can be set via the pool. option. Since pool options are pool specific, prefix the options with the pool. prefix combined with the pool type used. For example, to set C3P0's MaxStatements options, use pool.C3P0.MaxStatements=50  
e) You can set driver properties. The property DriverShortName needs to be set. For example, when using the MySQL driver, you could set DriverShortName=mysql . Then use driver.mysql.cachePrepStmts=true to enable the driver's caching of prepared statements  
f) DriverShortName needs to also be setup to allow for database specific queries. For example  

```B4X
sql.create_table_students2=CREATE TABLE IF NOT EXISTS Students2 (\  
    Id VARCHAR(255) PRIMARY KEY,\  
    `First Name` TEXT,\  
    `Last Name` TEXT,\  
    Birthday BIGINT,\  
    Image BLOB)
```

  
is a generic entry for creating the Students2 table and  

```B4X
sql_mysql.create_table_students2=CREATE TABLE IF NOT EXISTS Students2 (\  
    Id VARCHAR(255) PRIMARY KEY,\  
    `First Name` TEXT,\  
    `Last Name` TEXT,\  
    Birthday BIGINT,\  
    Image MEDIUMBLOB)
```

  
will be used for MySQL  
  
For more examples on how to use these, see the config.properties file located in the Objects folder of the jRDC2 server and the various class modules for the database pools  
  
Included in this dump is also a GUI test program for the jRDC2 server and a command line tool for stress testing the jRDC2 server. Both are B4J projects. the command line tool has an associated batch file that can be used to launch it. As is, it presumes you are using Java 8, but can be easily modified to be used with Java 11 (as is, the batch file uses no path prefixes for the java.exe file)  
  
Let me reiterate  
A) This is a code dump. In order for the various pools and DB's to work and be tested, you'll have to download additional .jar files. I have many of the links in the Main module. The versions used in this dump are from way back, so you will need to update them  
C) Check the config.properties file for the various settings available. Also check the class modules for the various pools.  
B) Read the code first if you have issues. If you are on a total road block, then get with me (through here).  
  
Happy testing (and with enough requests maybe I port some of the features to the modded jRDC2 server)
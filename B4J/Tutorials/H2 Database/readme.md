### H2 Database by tchart
### 07/19/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/132688/)

This is a very quick tutorial on the H2 database - <https://www.h2database.com/html/main.html>  
  
The main features of H2 are:  

- Very fast, open source, JDBC API
- Embedded and server modes; in-memory databases
- Browser based Console application
- Small footprint: around 2 MB jar file size

Other advantages over SQLite are;  

- Its pure Java so JDBC driver is only 2Mb vs SQLite 7mb (since SQLite has platform specific binaries)
- Encryption is out of the box
- Richer feature set - users, roles etc
- RDBMS compatability modes (eg run in Postgres mode - this means you can migrate to a full blown RDBMS with very little work in the future)

Feature comparison;  
  
![](https://www.b4x.com/android/forum/attachments/116638)  
  
There are some speed comparisions with SQLite here <https://www.b4x.com/android/forum/threads/jserver-sqlite-multiple-request-stress-test.130575> (in my tests its about 600% faster than SQLite in WAL mode).  
  
To use you need to download the jar file and add to additional jars in your project;  
  

```B4X
#AdditionalJar: h2-1.4.200
```

  
  
Conenction examples…  
  
1. Embedded Mode  
  

```B4X
Dim driver As String = "org.h2.Driver"  
Dim url As String = $"jdbc:h2:C:\temp\mydatabase"$  
DB.Initialize2(driver,url,"sa","sa")
```

  
  
2. Embedded In memory database  
  

```B4X
DBtemp.Initialize2("org.h2.Driver","jdbc:h2:mem:mydatabase","sa","sa")
```

  
  
3. Connect to remote server (in Potsgres Mode)  
  

```B4X
Dim driver As String = "org.h2.Driver"  
Dim url As String = "jdbc:h2:tcp://db_host/~/mydatabase;MODE=PostgreSQL;DATABASE_TO_LOWER=TRUE"  
DBdest.Initialize2(driver,url,"sa","sa")
```

  
  
To run the database in server mode there is a start up batch file called h2w.bat in the download from the H2 web site.  
  
4. Encrypted database connection  
  

```B4X
Dim DB As SQL  
    
Dim driver As String = "org.h2.Driver"  
Dim url As String = $"jdbc:h2:${File.DirApp}\report.h2;CIPHER=AES"$  
DB.Initialize2(driver,url,"user","cipherpassword userpassword")  
    
DB.ExecNonQuery("CREATE TABLE table1 (col1 TEXT , col2 INTEGER, col3 INTEGER)")  
    
DB.Close
```
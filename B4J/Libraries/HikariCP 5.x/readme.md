### HikariCP 5.x by tchart
### 03/21/2022
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/138846/)

This is a wrapper for HikariCP which is a database connection pool manager (<https://github.com/brettwooldridge/HikariCP>)  
  
From the github page; *Fast, simple, reliable. HikariCP is a "zero-overhead" production ready JDBC connection pool. At roughly 130Kb, the library is very light.*  
  
A user called "mindful" had previously wrapped this library but he hasnt been on the forum since March 2021 - see [here](https://www.b4x.com/android/forum/threads/hikaricp-high-performance-connection-pool.88430/) - and his wrapper was for an older version.  
  
A while back I wrote a semi-functional wrapper for HikariCP 5.x for some testing I was doing so I thought I should mention it here.  
  
**DOWNLOAD LINK;** <https://ope.nz/public/HikariCP_5.01.zip>  
  
Library code; <https://github.com/ope-nz/HikariCP>  
  
To create a connection pool (in this case is for SQLite)  
  

```B4X
Dim url As String = $"jdbc:sqlite:${File.DirApp}\test.db"$  
'Initialize(String JdbcUrl, String user, String password, String ConnectionTestQuery)  
cp.Initialize(url,Null,Null,Null)
```

  
  
To use the connection pool (eg in a handler class);  
  

```B4X
'Handler class  
Sub Class_Globals  
    Dim DB As SQL  
End Sub  
  
Public Sub Initialize  
    Dim DB As SQL  
    DB = Main.cp.GetConnection  
   
    'Use DB as per normal SQL connection  
  
    ' Close the connecton to return to the pool, otherwise another connection will created until this one is deemed idle  
    DB.Close  
End Sub
```

  
  
You can adjust some settings directly via the library eg  
  

```B4X
    cp.MaximumPoolSize = 100  
    cp.MaxLifetime = 1000  
    cp.MinimumIdle = 1000  
   
    Log(cp.MaximumPoolSize)  
    Log(cp.MaxLifetime)  
    Log(cp.MinimumIdle)
```

  
  
To get stats use these methods below. Note that calling these methods before requesting a connection results in a null exception so the library will return -1 to avoid any errors.  
  

```B4X
    Log(cp.ActiveConnections)  
    Log(cp.IdleConnections)  
    Log(cp.ThreadsAwaitingConnection)  
    Log(cp.TotalConnections)
```

  
  
Note: There are many config options and I have only implemented the ones I needed. If there is enough interest I can implement more or you can simply use JavaObject to change the config as per mindfuls post.  
  
Config documentation; <https://github.com/brettwooldridge/HikariCP#gear-configuration-knobs-baby>  
  
If you wish to create a read only connection to a SQLite database you need to initialize this way. The connection is faster as a result.  
  

```B4X
    Dim url As String = $"jdbc:sqlite:${File.DirApp}\db.sqlite?open_mode=1"$  
    cp.Initialize(url,Null,Null,Null)  
    Log(cp.IsInitialised)  
   
    cp.MaximumPoolSize = 50  
    cp.MinimumIdle = 10  
    cp.ReadOnly = True  
    cp.AutoCommit = False
```
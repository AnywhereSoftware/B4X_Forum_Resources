### JRDC2 connect to MSSQLLocalDb by aeric
### 01/13/2021
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/126513/)

```B4X
# MS SQL Server Express Edition  
DriverClass=net.sourceforge.jtds.jdbc.Driver  
JdbcUrl=jdbc:jtds:sqlserver://./DatabaseName;instance=LOCALDB#AC2F9943;namedPipe=true;domain=DomainName
```

  
  
You need to use jTDS 1.3.2  
  
Reference: <https://stackoverflow.com/questions/11345746/connecting-to-sql-server-localdb-using-jdbc>
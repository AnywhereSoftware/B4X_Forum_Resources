### MySQL / MariaDB jar, driver and jdbc url by Erel
### 08/13/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/168207/)

[HEADING=3]MySQL[/HEADING]  
  
1. Jar is available here: <https://dev.mysql.com/downloads/connector/j/>  
Choose the Platform Independent option.  
  
Put the jar in the additional libraries folder.  
  
2. Add jSQL library and a reference to the jar (change version as needed):  

```B4X
#AdditionalJar: mysql-connector-j-9.4.0
```

  
  
3. Driver + url:  

```B4X
sql.Initialize2("com.mysql.cj.jdbc.Driver", "jdbc:mysql://localhost/database_here", Username, Password)
```

  
  
[HEADING=2]MariaDB[/HEADING]  
  
1. Jar: <https://mariadb.com/downloads/connectors/connectors-data-access/java8-connector/> (Java 8+ connector)  
2.  

```B4X
#AdditionalJar: mariadb-java-client-3.5.5
```

  
3.  

```B4X
sql.Initialize2("org.mariadb.jdbc.Driver", "jdbc:mariadb://localhost/database_here", Username, Password)
```
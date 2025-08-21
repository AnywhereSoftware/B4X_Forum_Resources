### [BANanoMSSQL] PDO CRUD Class for MSSQL by Mashiane
### 05/23/2020
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/110015/)

Ola  
  
**UPDATE 2020-05-23:** [**Please use this library instead**](https://www.b4x.com/android/forum/threads/bananoconnect-bananosql-sqlite-mysql-mssql-library.117956/)  
  
This class is for CRUD functionality via a BANano and SQL Server BackEnd.  
  
Usage.  
  
1. Update the connection settings in msconnect.php to your database. Add this to the Files tab of your BANano project.  
2. Include the attached class to your project.  
3. [Download PHP Drivers for Microsoft SQL Server](https://docs.microsoft.com/en-us/sql/connect/php/download-drivers-php-sql-server?view=sql-server-2017), install and copy these to your PHP\ext folders and activate the php\_pdo\_sqlsvr\_73\_ts  
  
In Main.AppStart, configure your php settings.  
  

```B4X
'set php settings  
    BANano.PHP_NAME = "mssql.php"  
    BANano.PHPHost = $"http://localhost/myapp/"$  
    BANano.PHPAddHeader("Access-Control-Allow-Origin: *")
```

  
  
Let's look at the CRUD Below.
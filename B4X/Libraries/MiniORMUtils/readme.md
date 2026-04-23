###  MiniORMUtils by aeric
### 04/18/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/166030/)

**MiniORMUtils**  
Version: 5.40  

---

  
This library can be use for creating database tables and performing CRUD operations.  
It is suitable for B4X apps, non-UI web app or REST API servers.  
It is useful to return the query results as JSON since the rows are list of maps.  
Currently it supports **SQLite** (for B4A, B4i, B4J), **MariaDB** and **MySQL** (for B4J only).  
  
![](https://www.b4x.com/android/forum/attachments/164272)  
  
Project Template:  
[[B4X] [Project Template] MiniORM](https://www.b4x.com/android/forum/threads/b4x-project-template-miniorm.165499/)  
  
[HEADING=2]**Examples:**[/HEADING]  
  
Initialize MiniORM  

```B4X
Private DB As MiniORM  
DB.Initialize
```

  
  
Set file name for SQLite  

```B4X
DB.Settings.DBFile = "blog.db"
```

  
  
Set ORMSettings for MySQL  

```B4X
DB.Initialize  
Dim MS As ORMSettings  
MS.Initialize  
MS.DBType = DB.MYSQL  
MS.JdbcUrl = "jdbc:mysql://{DbHost}:{DbPort}/{DbName}?characterEncoding=utf8&useSSL=False"  
MS.DriverClass = "com.mysql.cj.jdbc.Driver"  
MS.DBName = "blog"  
MS.DbHost = "localhost"  
MS.User = "root"  
MS.Password = "password"  
DB.Settings = MS
```

  
  
Check if database exist (SQLite)  

```B4X
If Not(DB.Exist) Then  
    LogColor($"${DB.DBType} database not found!"$, COLOR_RED)  
    CreateDatabase  
End If
```

  
  
Create Database  

```B4X
Dim Success As Boolean = DB.CreateSQLite
```

  
  
Connect to Database  

```B4X
DB.Open
```

  
  
Create Table  

```B4X
DB.Table = "categories"  
DB.Columns = Array("category_code", "category_name")  
DB.Create
```

  
  
Create Table (with column definitions)  

```B4X
DB.Table = "products"  
DB.Columns.Add(CreateMap("N": "category_id", "T": DB.INTEGER))  
DB.Columns.Add(CreateMap("N": "product_code", "S": 12))  
DB.Columns.Add(CreateMap("N": "product_name"))  
DB.Columns.Add(CreateMap("N": "product_price", "T": DB.DECIMAL, "S": "10,2", "D": 0.0))  
DB.Columns.Add(CreateMap("N": "product_image", "T": DB.BLOB))  
DB.Foreign = "category_id"  
DB.References("categories", "id")  
DB.Create
```

  
  
Insert Rows  

```B4X
DB.Columns = Array("category_id", "product_code", "product_name", "product_price")  
DB.Inserts = Array(2, "T001", "Teddy Bear", 99.9)  
DB.Inserts = Array(1, "H001", "Hammer", 15.75)  
DB.Inserts = Array(2, "T002", "Optimus Prime", 1000)
```

  
  
Execute NonQuery Batch  

```B4X
Wait For (DB.ExecuteBatchAsync) Complete (Success As Boolean)  
If Success Then  
    Log("Database is created successfully!")  
Else  
    Log("Database creation failed!")  
End If
```

  
  
Select All Rows  

```B4X
DB.Table = "categories"  
DB.Query  
If DB.Error.IsInitialized Then  
    Log(DB.Error.Message)  
Else  
    Dim Items As List = DB.Results  
End If
```

  
  
Return single row  

```B4X
DB.Find(3)  
If DB.Found Then  
    Log(DB.First)  
End If
```

  
  
Update Row  

```B4X
DB.Table = "products"  
DB.Columns = Array("category_id", "product_code", "product_name", "product_price")  
DB.Id = 2  
DB.Save2 = Array(Category_Id, Product_Code, Product_Name, Product_Price)
```

  
  
GitHub: <https://github.com/pyhoon/MiniORMUtils-B4X>  
  
[SPOILER="Version 1"]<https://www.b4x.com/android/forum/threads/b4x-miniormutils-sql-query-builder.141446/>[/SPOILER]
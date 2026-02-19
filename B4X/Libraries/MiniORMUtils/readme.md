###  MiniORMUtils by aeric
### 02/17/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/166030/)

**MiniORMUtils**  
Version: 4.20  

---

  
This library can be use for creating database tables and performing CRUD operations.  
It is suitable for B4X apps, non-UI web app or REST API servers.  
Currently it supports **SQLite** (for B4A, B4i, B4J), **MariaDB** and **MySQL** (for B4J only).  
  
![](https://www.b4x.com/android/forum/attachments/164272)  
  
Project Template:  
[[B4X] [Project Template] MiniORM](https://www.b4x.com/android/forum/threads/b4x-project-template-miniorm.165499/)  
  
**Examples:**  
Initialize MiniORM  

```B4X
Private DB As MiniORM  
Private MS As ORMSettings  
  
MS.Initialize  
MS.DBType = "SQLite"  
MS.DBFile = "data.db"  
MS.DBDir = File.DirApp  
  
DB.Initialize  
DB.Settings = MS
```

  
  
Check if database exist  

```B4X
If Not(DB.Exist) Then  
    LogColor($"${MS.DBType} database not found!"$, COLOR_RED)  
    CreateDatabase  
End If
```

  
  
Create Database  

```B4X
Dim Success As Boolean = DB.InitializeSQLite
```

  
  
Create Table  

```B4X
DB.Table = "tbl_category"  
DB.Columns.Add(DB.CreateColumn2(CreateMap("Name": "category_name")))  
DB.Create
```

  
  
Insert Rows  

```B4X
DB.Columns = Array("category_name")  
DB.Insert2(Array("Hardwares"))  
DB.Insert2(Array("Toys"))
```

  
  
Execute NonQuery Batch  

```B4X
Wait For (DB.ExecuteBatchAsync) Complete (Success As Boolean)  
If Success Then  
    Log("Database is created successfully!")  
Else  
    Log("Database creation failed!")  
End If  
DB.Close
```

  
  
Select All Rows  

```B4X
DB.Table = "tbl_category"  
DB.Query  
Dim Items As List = DB.Results
```

  
  
Update Row  

```B4X
DB.Table = "tbl_products"  
DB.Columns = Array("category_id", "product_code", "product_name", "product_price")  
DB.Id = 2  
DB.Save2(Array(Category_Id, Product_Code, Product_Name, Product_Price))
```

  
  
GitHub: <https://github.com/pyhoon/MiniORMUtils-B4X>  
  
[SPOILER="Version 1"]<https://www.b4x.com/android/forum/threads/b4x-miniormutils-sql-query-builder.141446/>[/SPOILER]
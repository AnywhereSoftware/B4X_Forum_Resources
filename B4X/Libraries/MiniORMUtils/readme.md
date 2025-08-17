###  MiniORMUtils by aeric
### 07/11/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/166030/)

**MiniORMUtils**  
Version: 3.30  

---

  
This library can be use for creating db schema and performing CRUD operations.  
It is suitable for Web API Template or any database system.  
Currently it supports **SQLite** and **MySQL** (B4J).  
  
![](https://www.b4x.com/android/forum/attachments/164272)  
  
Project Template:  
[[B4X] [Project Template] MiniORM](https://www.b4x.com/android/forum/threads/b4x-project-template-miniorm.165499/)  
  
**Examples:**  
Create ConnectionInfo object  

```B4X
Dim Info As ConnectionInfo  
Info.Initialize  
info.DBType = "SQLite"  
Info.DBFile = "data.db"
```

  
  
Create ORMConnector object  

```B4X
Dim Conn As ORMConnector  
Conn.Initialize(Info)
```

  
  
Check if database exist  

```B4X
Dim DBFound As Boolean = Conn.DBExist  
If DBFound = False Then  
    LogColor($"${Conn.DBType} database not found!"$, COLOR_RED)  
    CreateDatabase  
End If
```

  
  
Create database  

```B4X
Private Sub CreateDatabase  
    Dim Success As Boolean = Conn.DBCreate  
    If Success = False Then  
        Log("Database creation failed!")  
        Return  
    End If  
    ' The rest of code for creating tables  
End Sub
```

  
  
Initialize MiniORM object  

```B4X
Dim DB As MiniORM  
DB.Initialize(DBType, DBOpen)  
DB.QueryAddToBatch = True
```

  
  
Create table  

```B4X
DB.Table = "tbl_category"  
DB.Columns.Add(DB.CreateColumn2(CreateMap("Name": "category_name")))  
DB.Create
```

  
  
Insert rows  

```B4X
DB.Columns = Array("category_name")  
DB.Insert2(Array("Hardwares"))  
DB.Insert2(Array("Toys"))
```

  
  
Execute NonQuery Batch  

```B4X
Wait For (DB.ExecuteBatch) Complete (Success As Boolean)  
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

  
  
Update row  

```B4X
DB.Table = "tbl_products"  
DB.Columns = Array("category_id", "product_code", "product_name", "product_price")  
DB.Id = 2  
DB.Save2(Array(Category_Id, Product_Code, Product_Name, Product_Price))
```

  
  
More examples on GitHub README page  
<https://github.com/pyhoon/MiniORMUtils-B4X>  
  
[SPOILER="Version 1"]<https://www.b4x.com/android/forum/threads/b4x-miniormutils-sql-query-builder.141446/>[/SPOILER]
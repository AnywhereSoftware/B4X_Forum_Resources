###  MiniORMUtils - SQL Query Builder by aeric
### 03/09/2025
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/141446/)

[TABLE]  
[TR]  
[TH]Updates[/TH]  
[/TR]  
[TR]  
[TD]Version 2.00 is available  
<https://www.b4x.com/android/forum/threads/b4x-miniormutils.166030/>[/TD]  
[/TR]  
[/TABLE]  
  
**MiniORMUtils**  
Version: 1.17  

---

  
This library can be use for creating db schema and performing CRUD operations.  
It is suitable for Web API Template or any database system.  
Currently it supports **SQLite** and **MySQL** (B4J).  

---

  
  
**B4X project template**  
Version: 1.06  
<https://www.b4x.com/android/forum/threads/b4x-project-template-miniorm.165499/>  
  
**Examples:**  
  
Initialization  

```B4X
Dim MDB As MiniORM  
MDB.Initialize(Main.DBOpen, Main.DBEngine)  
MDB.UseTimestamps = True  
MDB.AddAfterCreate = True  
MDB.AddAfterInsert = True
```

  
> Take note: Before calling MDB.**Create** and MDB.**Insert**, set **AddAfterCreate** and **AddAfterInsert** to True.

  
Create Table  

```B4X
MDB.Table = "tbl_category"  
MDB.Columns.Add(MDB.CreateORMColumn2(CreateMap("Name": "category_name")))  
MDB.Create
```

  
  
Insert Data  

```B4X
MDB.Columns = Array("category_name")  
MDB.Insert2(Array As String("Hardwares"))  
MDB.Insert2(Array As String("Toys"))
```

  
  
Execute Batch NonQuery  

```B4X
Wait For (MDB.ExecuteBatch) Complete (Success As Boolean)  
If Success Then  
    Log("Database is created successfully!")  
Else  
    Log("Database creation failed!")  
    Log(LastException)  
End If  
MDB.Close
```

  
  
Select All Rows  

```B4X
MDB.Table = "tbl_category"  
MDB.Query  
Dim Items As List = MDB.Results
```

  
  
Joining Table  

```B4X
MDB.Table = "tbl_products p"  
MDB.Select = Array("p.*", "c.category_name")  
MDB.Join = MDB.CreateORMJoin("tbl_category c", "p.category_id = c.id", "")  
MDB.WhereValue(Array("c.id = ?"), Array As String(CategoryId))  
MDB.Query  
Dim Items As List = MDB.Results
```

  
  
GitHub:  
<https://github.com/pyhoon/MiniORMUtils-B4X>  
<https://github.com/pyhoon/MiniORM-B4X>  
<https://github.com/pyhoon/MiniORM-Demo-B4X>
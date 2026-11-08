# MiniORMUtils-B4X
Version: 1.17

A mini object–relational mapping (ORM) that can be use for creating db schema and SQL queries.
It is suitable for Web API Template or any database system.
Currently it supports **SQLite** and **MySQL** (B4J).

# Usage example

## Initialize object
```
Dim MDB As MiniORM
MDB.Initialize(Main.DBOpen, Main.DBEngine)
MDB.UseTimestamps = True
MDB.AddAfterCreate = True
MDB.AddAfterInsert = True
```
Note: Before calling MDB.Create and MDB.Insert, set AddAfterCreate and AddAfterInsert to True.

## Create table
```
MDB.Table = "tbl_category"
MDB.Columns.Add(MDB.CreateORMColumn2(CreateMap("Name": "category_name")))
MDB.Create
```

## Insert rows
```
MDB.Columns = Array("category_name")
MDB.Insert2(Array As String("Hardwares"))
MDB.Insert2(Array As String("Toys"))
```

## Execute NonQuery Batch
```
Wait For (MDB.ExecuteBatch) Complete (Success As Boolean)
If Success Then
    Log("Database is created successfully!")
Else
    Log("Database creation failed!")
End If
MDB.Close
```

## Select All Rows
```
MDB.Table = "tbl_category"
MDB.Query
Dim Items As List = MDB.Results
```

## Update row
```
MDB.Table = "tbl_products"
MDB.Columns = Array As String("category_id", "product_code", "product_name", "product_price")
MDB.Id = 2
MDB.Save2(Array As String(Category_Id, Product_Code, Product_Name, Product_Price))
```

## Soft delete row
```
MDB.Id = 3
MDB.SoftDelete
```

## Permanent delete row
```
MDB.Id = 4
MDB.Delete
```

## Batch delete rows
```
MDB.Destroy(Array As Int(2, 3))
```

## Return number of rows in query results
```
Dim Rows As Int = MDB.RowCount
```

## Return single row
```
Dim Data As Map = MDB.Find(2)
```

## Return multiple rows
```
MDB.Table = "tbl_products"
MDB.Where = Array As String("category_id = ?")
MDB.Parameters = Array As String(2)
MDB.OrderBy = CreateMap("id": "DESC")
MDB.Query
Dim Data As List = MDB.Results
```

## Join tables
```
MDB.Table = "tbl_products p"
MDB.Select = Array("p.*", "c.category_name")
MDB.Join = MDB.CreateORMJoin("tbl_category c", "p.category_id = c.id", "")
MDB.WhereValue(Array As String("c.id = ?"), Array(CategoryId))
MDB.Query
Dim Data As List = MDB.Results
```

### [BANanoSQLUtils] A BANanoSQL helper class for CRUD functionality by Mashiane
### 06/29/2020
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/107488/)

Good day  
  
**UPDATE 2020-05-19:** [**Please use this library instead**](https://www.b4x.com/android/forum/threads/bananoconnect-bananosql-sqlite-mysql-mssql-library.117956/)  
  
![](https://www.b4x.com/android/forum/attachments/82004)  
  
The attached class will help you in creating basic [sql](https://www.b4x.com/glossary/sql/) statements for CRUD functionality using BANanoSQL.  
  
We feature CREATE, UPDATE, UPDATE & DELETE statements, we also have added, creating a table. Whilst this class will work using BANanoSQL callbacks, I have found out that using .ExecuteWait is far more better. This is the same approach that we have followed with  
  
[BANanoSQLite - Accessing SQLite DB using (inline) PHP](https://www.b4x.com/android/forum/threads/bananosqlite-sqlitedb-php-crud-class-for-banano.107461/#content) and  
[BANanoMySQL - Accessing MySQL DB using (inline) PHP](https://www.b4x.com/android/forum/threads/bananomysql-an-inline-php-class-for-your-mysqli-crud-functionality.106858/#content)  
  
**Reproduction.**  
  
In Main.Process\_Globals, we define BANanoSQL  
  

```B4X
Private SQL As BANanoSQL
```

  
  
In Main.BANano\_Ready, we open the DB and then create a table.  
  

```B4X
Sub BANano_Ready()  
    Dim alasql As BANanoSQLUtils  
    alasql.Initialize  
    'open the bananosql db called tests  
    SQL.OpenWait("tests","tests")  
    'create items table with the structure  
    Dim els As Map = CreateMap()  
    els.Put("id", alasql.DB_STRING)  
    els.Put("jsoncontent", alasql.DB_STRING)  
    els.Put("tabindex", alasql.DB_INT)  
    els.put("parentid", alasql.DB_STRING)  
    Dim rs As ResultSet = alasql.CreateTable("items", els, "id")  
    rs.result = SQL.ExecuteWait(rs.query,Null)  
    Log(rs)  
    'open another page  
    pgIndex.init  
End Sub
```

  
  
We start to open another page as soon as this is done. On that page, we define our BANanoUtils class and also the BANanoSQL object in Process\_Globals.  
  

```B4X
    Private alasql As BANanoSQLUtils  
    Private SQL As BANanoSQL
```

  
  
On Init, we open the db and then when a user selects the buttons we process some CRUD. As we are using .ExecuteWait in our subs, we need to add the word Wait at the end of each sub routine name.  
  
Let's look at simple inserts… i.e. WHERE CLAUSE  
  
**CREATE / INSERT**  
  

```B4X
Sub insert1wait  
    ClearFirst  
    'initialize bananosqlite  
    alasql.Initialize()  
    'create a record  
    Dim rec As Map = CreateMap()  
    rec.Put("id", "A")  
    rec.Put("jsoncontent", "B")  
    rec.Put("tabindex", 1)  
    rec.put("parentid", "form")  
    'indicate field data types  
    alasql.AddStrings(Array("id"))  
    alasql.AddIntegers(Array("tabindex"))  
    'execute the insert  
    Dim rs As ResultSet = alasql.Insert("items", rec)  
    rs.result = SQL.ExecuteWait(rs.query, rs.args)  
    '  
    elCommand.SetText("Command: " & rs.query)  
    elArgs.SetText("Arguements: " & BANano.ToJson(rs.args))  
    elNotif.SetText("Result: " & BANano.ToJson(rs.result) & " rowid!")  
End Sub
```

  
  
  
**READ**  
  

```B4X
Sub Select1wait  
    ClearFirst  
    'initialize bananosqlite  
    alasql.Initialize()  
    'indicate field data types  
    alasql.AddStrings(Array("id"))  
    'execute select where  
    Dim rs As ResultSet = alasql.SelectWhere("items", Array("*"), CreateMap("id":"A"), Array("id"))  
    rs.result = SQL.ExecuteWait(rs.query, rs.args)  
    '  
    elCommand.SetText("Command: " & rs.query)  
    elArgs.SetText("Arguements: " & BANano.ToJson(rs.args))  
    elNotif.SetText("Result: " & BANano.ToJson(rs.result))  
End Sub
```

  
  
  
**UPDATE**  
  

```B4X
Sub update1wait  
    ClearFirst  
    'initialize bananosqlite  
    alasql.Initialize()  
    'define field types  
    alasql.AddStrings(Array("id","parentid"))  
    'generate random data  
    dummy.Initialize  
    Dim parentid As String = dummy.Rand_Company_Name  
    'define query data & execute  
    Dim rs As ResultSet = alasql.UpdateWhere("items", CreateMap("parentid":parentid), CreateMap("id":"A"))  
    rs.result = SQL.ExecuteWait(rs.query, rs.args)  
    '  
    elCommand.SetText("Command: " & rs.query)  
    elArgs.SetText("Arguements: " & BANano.ToJson(rs.args))  
    elNotif.SetText("Result: " & BANano.ToJson(rs.result))  
  
End Sub
```

  
  
**DELETE**  
  

```B4X
Sub Delete1wait  
    ClearFirst  
    'initialize bananosqlite  
    alasql.Initialize()  
    'define field types  
    alasql.AddStrings(Array("id"))  
    'define query data & execute  
    Dim rs As ResultSet = alasql.DeleteWhere("items", CreateMap("id":"A"))  
    rs.result = SQL.ExecuteWait(rs.query, rs.args)  
  
    elCommand.SetText("Command: " & rs.query)  
    elArgs.SetText("Arguements: ")  
    elNotif.SetText("Result: " & BANano.ToJson(rs.result))  
End Sub
```

  
  
The other included inserts, updates and deletes demonstrate how to do bulk operations.  
  
**NB: DELETE ALL Records from a table.**  
  
Currently to delete all records from a table, one needs to tweak the delete a little and use..  
  

```B4X
DELETE FROM [Table] WHERE 1=1
```

  
  
Otherwise it does not work. This is a documented error as of writing.  
  
Ta!
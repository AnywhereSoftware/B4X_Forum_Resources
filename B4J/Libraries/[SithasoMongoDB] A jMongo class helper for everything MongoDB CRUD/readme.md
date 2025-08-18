### [SithasoMongoDB] A jMongo class helper for everything MongoDB CRUD by Mashiane
### 03/05/2022
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/138924/)

Hi there  
  
This helper class is to help anyone explore the jMongo library for CRUD for the less adventurous. Demo attached.  
  
**SithasoMongoDB**  

- **Initialize** (sHost As String, iPort As Int, dbName As String, tblName As String) **As SithasoMongoDB**
'

```B4X
'initialize the class  
Dim dbMongo As SithasoMongoDB  
dbMongo.Initialize("127.0.0.1", 27017, "test", "users")
```

- **PrepareRecord As SithasoMongoDB**
prepare the record for insert/update- **SetField** (fld As String, value As Object) **As SithasoMongoDB**
set a field on the record- **SetLimit** (l As Int) **As SithasoMongoDB**
set limit- **SetSkip** (l As Int) **As SithasoMongoDB**
set skip- **MoveFirst**
movefirst- **MoveLast**
movelast- **MovePrevious**
moveprevious- **MoveNext**
movenext- **ClearWhere As SithasoMongoDB**
clear where clause- **AddFields** (flds As List) **As SithasoMongoDB**
add projection- **AddSort** (fld As String, desc As Boolean) **As SithasoMongoDB**
add a sort order- **AddWhere** (fld As String, operator As String, value As Object) **As SithasoMongoDB**
add a where clause for your select where statement
\_id will be ignored- **Update As Int**

```B4X
'update a record, returns number of records updated  
'you can specify a where clause optionally  
'dbConnect.ClearWhere  
'dbConnect.AddWhere("name", dbConnect.EQ_OP, "Anele")  
dbConnect.PrepareRecord  
dbConnect.SetField("age", 50)  
dbConnect.SetField("work", "Software Engineer")  
dbConnect.Update  
if dbConnect.RowCount >= 1 then  
'the records were updated  
end if
```

- **Delete** (id As String) **As Int**

```B4X
'delete record and returns number of records deleted  
dbMongo.Delete("1234567")  
if dbMongo.RowCount = 1 then  
'the record was deleted  
end if
```

- **DeleteWhere As Int**

```B4X
'delete record by id or where clause returns number of records deleted  
'dbConnect.ClearWhere  
'dbConnect.AddWhere("name", dbConnect.EQ_OP, "Anele")  
dbMongo.DeleteWhere  
if dbMongo.RowCount = 1 then  
'the record was deleted  
end if
```

- **DeleteAll As Int**

```B4X
'delete all records  
dbMongo.DeleteAll  
if dbMongo.RowCount > 0 then  
'the records were deleted  
end if
```

- **Read** (id As String) **As Map**

```B4X
'read record by id, get result  
dbMongo.Read("1234567")  
if dbMongo.RowCount = 1 then  
'the record was read  
'dbConnect.MoveFirst  
dim sname As String = dbMongo.GetString("name")  
log(sname)  
end if
```

- **Insert**

```B4X
'insert record, returns the number of records inserted  
'_id will be ignore  
dbMongo.PrepareRecord  
dbMongo.SetField("name", "Anele")  
dbMongo.SetField("email", "[EMAIL]email@email.com[/EMAIL]")  
dbConnect.Insert
```

- **SelectAll() As List**

```B4X
'select where records and show specific fields  
dbConnect.ClearWhere  
dbConnect.AddFields(array("name", "lastname", "_id"))  
dbConnect.AddWhere("name", dbConnect.EQ_OP, "Anele")  
dbConnect.SetSkip(1)  
dbConnect.SetLimit(1)  
dbConnect.SelectAll  
if dbConnect.RowCount >= 1 then  
'the records were selected  
end if
```

- **setPosition** (pos As Int)
set the position of the current record- **GetInt** (fld As String) **As Int**
get an integer from the current record- **GetLong** (fld As String) **As Long**
get a long from the current record- **GetID As String**
get the id of this record- **GetString** (fld As String) **As String**
get a string from the current record- **GetBoolean** (fld As String) **As Boolean**
get a boolean from the current record- **GetDouble** (fld As String) **As Double**
get a double from the current record
**Related Content**  
[BANanoMongoDB - A helper class for MongoDB (PHP) for BANano.](https://www.b4x.com/android/forum/threads/bananomongodb-a-helper-class-for-everything-mongodb-php-crud.138804/#content)
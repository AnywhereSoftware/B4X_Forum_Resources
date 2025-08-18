### Build parametized SQL queries for Insert,Update and Delete by spsp
### 02/25/2021
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/128058/)

This is a small class to easily build SQL queries  
  
declare an instance of the class clBuildSQL and initialize it  

```B4X
Private fBuildSQL As clBuildSQL  
….  
  
fBuildSQL.initialize
```

  
  
Insert record  
Just pass as first parameter the table name and as second parameter a map with pairs keys/values FieldName/value  

```B4X
    Dim s As TSQLQuery=fBuildSQL.insertSQL("t_persons",CreateMap("name":"Alan","age":35))  
    fDB.ExecNonQuery2(s.fSQL,s.fValues)
```

  
the sql will be "insert into t\_persons(name,age) values(?,?)" with parameters array as object("Alan",35)  
  
  
update record  
Just pass as first parameter the table name, as second parameter a map with pairs keys/values FieldName/value and as third parameter a map with pairs keys/values FieldName|Operator/value for the where clause.  

```B4X
    Dim s As TSQLQuery=fBuildSQL.UpdateSQL("t_persons",CreateMap("age":30),CreateMap("name=":"Mary"))  
    fDB.ExecNonQuery2(s.fSQL,s.fValues)
```

  
the sql will be "update t\_persons set name=?,,age=? where name=?" with parameters array as object(30,"Mary")  
  
Delete record  
Just pass as first parameter the table name, and as second parameter a map with pairs keys/values FieldName|Operator/value for the where clause  
In the where clause you can combine more criteria  

```B4X
    Dim s As TSQLQuery=fBuildSQL.deleteSQL("t_persons",CreateMap("name=":"Alan","or age>":32))  
    fDB.ExecNonQuery2(s.fSQL,s.fValues)
```

  
the sql will be "delete from t\_persons where name=? or age>?" with parameters array as object("Alan",32)  
  
  
Don't use space in your table name or column name!  
  
  
A B4X sample (B4A and B4J) shows the result
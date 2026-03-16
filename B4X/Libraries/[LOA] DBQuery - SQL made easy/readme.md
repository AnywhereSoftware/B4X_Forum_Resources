### [LOA] DBQuery - SQL made easy by Erel
### 03/11/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/170560/)

DBQuery is a thin wrapper around the platforms' SQL libraries: SQL, iSQL and jSQL.  
Features:  

- A simpler and more coherent API. It fixes several issues in the original libraries, which date back to B4A v1.0. The most notorious one is SQL.ExecQuerySingleResult returning Null as a string result.
- Returns a [ListOfArrays](https://www.b4x.com/android/forum/threads/b4x-loa-listofarrays-lightweight-powerful-and-flexible-collection.170543/#content) instead of ResultSet. This is a new data collection built for managing tabular data.
- Automatically retrieves values based on the value type.
- Cross platform API. Note that in B4A and B4i it works with SQLite. In B4J it works with any type of database.
- The wrapped SQL object is accessible for features not exposed through DBQuery (async methods for example).

How to use?  
  
Initialize the SQL object as usual and then initialize DBQuery.  

```B4X
sql1.Initialize(xui.DefaultFolder, DBFile, True)  
db.Initialize(sql1)  
Dim All As ListOfArrays = db.ExecQuery($"SELECT * FROM table1"$, Null)  
Log(All.ToString(10)) 'print first 10 rows  
Dim res As ListOfArrays = db.ExecQuery($"SELECT name, age FROM table1 WHERE age > ?"$, Array(17))  
Log("Age > 17")  
Log(res.ToString(0)) 'print all rows
```

  
  
ListOfArrays library is available here: <https://www.b4x.com/android/forum/threads/b4x-loa-listofarrays-lightweight-powerful-and-flexible-collection.170543/#content>  
It will become an internal library in the future.
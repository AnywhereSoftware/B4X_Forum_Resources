### DBQuery - Execute query and get all results as a table by Erel
### 03/02/2026
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/170471/)

Not exactly a code snippet, but felt too small for a library. The code is based on jRDC2 implementation, which reads the records from the ResultSet and returns a list of rows and columns mapping. Best of all - it doesn't forget to close the ResultSet.  
  
Each row in the list of rows is an array of objects. The values are stored with the correct data type, check the code to see how it is done.  
The columns map, maps between the column names and the column index in the rows arrays. It is not mandatory to use the columns map as the query order is kept.  
  

```B4X
Dim q As DBResult = DBQuery.ExecQuery(sql, $"SELECT value from data WHERE id = ? and type = ?"$, _  
            Array(Place.EntityId, DATA_TYPE))  
For Each row() As Object In q.Rows  
  Dim value As Double = row(0)  
 'or Dim value As Double = row(q.Columns.Get("value"))  
Next
```

  
  
There is also an option to set a limit on the max number of rows returned.
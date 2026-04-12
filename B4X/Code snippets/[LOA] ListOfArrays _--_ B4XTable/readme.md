###  [LOA] ListOfArrays <--> B4XTable by Erel
### 04/09/2026
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/170779/)

Visualize a LOA with B4XTable:  

```B4X
Private Sub ShowLoaInTable(loa As ListOfArrays, table As B4XTable, DateColumns As List)  
    table.Clear  
    If loa.IsEmpty Then Return  
    If loa.FirstRowIsHeader = False Then  
        Log("Missing header names")  
        Return  
    End If  
    For Each col As Int In loa.ColumnIndices  
        Dim ColType As Int  
        Dim ColName As String = loa.Header(col)  
        If Initialized(DateColumns) And DateColumns.IndexOf(ColName) > -1 Then  
            ColType = table.COLUMN_TYPE_DATE  
        Else  
            Dim FirstValue As Object = loa.GetValueDefault(0, col, "")  
            If FirstValue Is String Then  
                ColType = table.COLUMN_TYPE_TEXT  
            Else  
                ColType = table.COLUMN_TYPE_NUMBERS  
            End If  
        End If  
        table.AddColumn(ColName, ColType)  
    Next  
    table.SetData(B4XCollections.SubList(loa.mInternalArray, loa.mFirstDataRowIndex, loa.mInternalArray.Size))  
End Sub
```

  
  
Usage example, based on DBQuery: <https://www.b4x.com/android/forum/threads/b4x-loa-dbquery-sql-made-easy.170560/#content>  

```B4X
ShowLoaInTable(db.ExecQuery($"SELECT name, age As [Nice Age], created_at FROM table1"$, Null), B4XTable1, Array("created_at"))
```

  
  
The last parameter is an array with the names of the columns that will be treated as date columns. Pass Null if not needed.  
  
![](https://www.b4x.com/android/forum/attachments/171081)  
  
Example is attached.
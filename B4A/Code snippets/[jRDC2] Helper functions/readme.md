### [jRDC2] Helper functions... by Mashiane
### 01/19/2021
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/126708/)

Ola  
  
**Intends to be a collection of some helper functions for jRDC2. Let's share please.**  
  
This one I will use to convert the records from DBResult to a list of objects / maps. It returns a list of maps with each map being a record from your resultset. Resultset fields in lowercase. You might recall something almost like this from DBUtils. Just added this to my DBRequestManager.  
  

```B4X
'convert DBResult to list of objects i.e maps  
public Sub ToList(table As DBResult) As List  
    Dim nl As List  
    nl.Initialize  
    For Each row() As Object In table.Rows  
        Dim nm As Map = CreateMap()  
        For Each col As String In table.Columns.Keys  
            'get index of column  
            Dim colIdx As Object = table.Columns.Get(col)  
            'get value row at index  
            Dim colVal As Object = row(colIdx)  
            nm.Put(col.tolowercase, colVal)  
        Next  
        nl.Add(nm)  
    Next  
    Return nl  
End Sub
```

  
  
Enjoy.  
  
PS: If you have something useful that could help ease jDRC2 etc please add.
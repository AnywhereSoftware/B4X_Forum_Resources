### DBUTILS.executememorytable return a map by moore_it
### 07/05/2022
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/141583/)

if, like me, don't remember the position of the table fields in the array of string when use executememorytable , put the array strings into a map with table fields names.  
  

```B4X
private Sub MakeMap(tables() As String,selections() As String,dati() As String) As Map  
    Dim retmap As Map  
    retmap.Initialize  
    Dim tpl As Int = 0  
      
    For i = 0 To tables.Length-1  
        Dim l As List = DBUtils.GetFieldsInfo(Main.DATABASE,tables(i))  
        For n = 0 To l.Size - 1  
            Dim sfo As Int = 0  
            Dim dbf As DBFieldInfo = l.Get(n)  
            If selections(0) <> "*" Then   
                For s = 0 To selections.Length-1   
                    If dbf.FieldName.ToLowerCase = selections(s) Then  
                        retmap.Put(dbf.FieldName.ToLowerCase,dati(n+sfo))  
                        sfo = sfo + 1  
                    End If  
                Next  
            Else  
                retmap.Put(dbf.FieldName.ToLowerCase,dati(n+tpl))  
            End If                  
        Next  
        If selections(0) <> "*" Then  
            tpl = tpl + sfo  
        Else  
            tpl = tpl + n  
        End If      
    Next  
      
    Return retmap  
End Sub
```

  
  
Tables() array if you use a innerjoin
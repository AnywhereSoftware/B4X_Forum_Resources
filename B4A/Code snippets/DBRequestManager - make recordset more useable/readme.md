### DBRequestManager - make recordset more useable. by MrKim
### 07/10/2021
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/130168/)

**Edit: There is a bug in this. The field list doesn't come back in order in B4i change:** [ICODE]ColNames(X) = Col[/ICODE] **To:** [ICODE]ColNames(Res.Columns.Get(Col)) = Col[/ICODE]**. Then you can delete the variable X.**  
I added this to the DBRequestManager module. Converts the data into a list of maps which I find more manageable.  
It seems to be EXTREMELY fast. Make sure there is at least one row before using it.  

```B4X
'takes results from server and converts is to a List (the Rows) of Maps (the columns by name)  
'This will convert 30 records of 6 columns in 9 milliseconds on computer - on Lenovo Tablet onlu ONE millisecond  
Sub DBResultToListOfMaps(Res As DBResult) As List  
    Dim ColNames(Res.Columns.Size) As String, X As Int  
    For Each Col In Res.Columns.Keys  
        ColNames(X) = Col  
        X = X + 1  
    Next  
  
    Dim Rows As List, X As Int, Y As Int  
    Rows.Initialize  
    For Each Row() As Object In Res.Rows  
        X = 0  
        Dim Cols As Map  
        Cols.Initialize  
        Y = 0  
        For Each Fld As Object In Row  
            Cols.Put(ColNames(Y), Fld)  
            Y = Y + 1  
        Next  
        Rows.Add(Cols)  
    Next  
    Log(DateTime.Now)  
    Log(Rows.Size)  
    Return Rows  
End Sub
```

  
  
Usage:  

```B4X
            Dim Rows As List = req.DBResultToListOfMaps(res)  
            Dim Cols As Map = Rows.Get(0)  
            Log(Cols.Get("Fld1") & " - " & Cols.Get("Fld2"))
```
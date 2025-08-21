### B4XTable by Yafuhenk
### 04/02/2020
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/115732/)

I am working on app where I need the B4XTable.  
With the help of this forum I learnt a lot already.  
The following functions are very handy to me, maybe you can use them too.  
  
1) Getting the column type from the database pragma  

```B4X
Sql1.InitializeSQLite(File.DirApp, "DatabaseName.db",True)
```

  

```B4X
Sub GetColumnType(MyTable As String, MyField As String) As Int  
    Dim Alignment As Int  
    Dim MyResultTables As ResultSet = Sql1.ExecQuery("Select name FROM sqlite_master WHERE Type='table' ORDER BY name")  
    Do While MyResultTables.NextRow  
        If MyTable = MyResultTables.GetString2(0) Then  
            Dim MyResultTableInfo As ResultSet=Sql1.ExecQuery("PRAGMA table_info(" & MyTable & ")")  
            Do While MyResultTableInfo.NextRow  
                If MyField = MyResultTableInfo.GetString2(1) Then  
                    Select Case True  
                        Case MyResultTableInfo.GetString2(2).ToLowerCase.Contains("varchar")  
                            Alignment = 1  
                        Case MyResultTableInfo.GetString2(2).ToLowerCase.Contains("numeric")  
                            Alignment = 2             
                        Case MyResultTableInfo.GetString2(2).ToLowerCase.Contains("integer")  
                            Alignment = 2  
                        Case MyResultTableInfo.GetString2(2).ToLowerCase.Contains("datetime")  
                            Alignment = 3  
                        Case Else  
                            Alignment = 1  
                    End Select  
                End If  
            Loop  
            MyResultTableInfo.Close  
        End If  
    Loop  
    MyResultTables.Close  
    Return Alignment  
End Sub
```

  
  
2) Adding a column to B4XTable with GetColumnType  

```B4X
B4XTable1.AddColumn("MyHeader", GetColumnType("MyTable", "MyField"))
```

  
  
3) Alignment and formatting based on column type  

```B4X
Private Formatter As B4XFormatter
```

  

```B4X
Formatter.Initialize  
    Dim DefaultFormat As B4XFormatData = Formatter.GetDefaultFormat  
    DefaultFormat.MaximumFractions = 2  
    DefaultFormat.MinimumFractions = 2
```

  

```B4X
Sub SetColumnAlignmentAndFormat(columnID As String)  
    Dim Column As B4XTableColumn = B4XTable1.GetColumn(columnID)  
    Dim Alignment As String  
    For i = 1 To Column.CellsLayouts.Size - 1  
        Dim pnl As B4XView = Column.CellsLayouts.Get(i)  
        If Column.ColumnType = 2 Then '2 is numeric  
            Alignment = "RIGHT"  
            Dim lbl As B4XView = pnl.GetView(0)  
            If lbl.Text <> "" Then  
                lbl.Text = lbl.Text.Replace(",","")  
                lbl.Text =Formatter.Format(lbl.Text)  
            End If  
        Else  
            Alignment = "LEFT"  
        End If  
        pnl.GetView(0).SetTextAlignment("CENTER", Alignment)  
    Next  
End Sub
```

  
  
4) Get sum of a column and add the result to the column title  

```B4X
Sub SetColumnSum(columnID As String)  
    Dim Column As B4XTableColumn = B4XTable1.GetColumn(columnID)  
    Dim o() As Object = B4XTable1.BuildQuery(False) 'no page limit  
    Dim total As Double  
    Dim rs As ResultSet = B4XTable1.sql1.ExecQuery2(o(0), o(1))  
    Do While rs.NextRow  
        total = total + rs.GetDouble(Column.SQLID)  
    Loop  
    rs.Close  
    Dim pnl As B4XView = Column.CellsLayouts.Get(0)  
    Dim lbl As B4XView = pnl.GetView(0)  
    'add totals to column header  
    lbl.Text = columnID & CRLF & "∑ " & Formatter.Format(total)  
End Sub
```
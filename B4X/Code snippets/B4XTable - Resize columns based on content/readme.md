###  B4XTable - Resize columns based on content by Erel
### 04/01/2020
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/102678/)

This code measures the required width based on the cells text and set it:  
  

```B4X
Sub B4XTable1_DataUpdated  
    Dim ShouldRefresh As Boolean  
    'NameColumn and NumberColumn are global B4XTableColumns that we want to measure  
    For Each column As B4XTableColumn In Array(NameColumn, NumberColumn)  
        Dim MaxWidth As Int  
        For i = 0 To B4XTable1.VisibleRowIds.Size - 1  
            Dim RowId As Long = B4XTable1.VisibleRowIds.Get(i)  
            If RowId > 0 Then  
                Dim pnl As B4XView = column.CellsLayouts.Get(i + 1)  
                Dim lbl As B4XView = pnl.GetView(0)  
                Dim txt As String = B4XTable1.GetRow(RowId).Get(column.Id)  
                MaxWidth = Max(MaxWidth, cvs.MeasureText(txt, lbl.Font).Width + 10dip)  
            End If  
        Next  
        If MaxWidth > column.ComputedWidth Or MaxWidth < column.ComputedWidth - 20dip Then  
            column.Width = MaxWidth  
            ShouldRefresh = True  
        End If  
    Next  
    If ShouldRefresh Then  
        B4XTable1.Refresh  
    End If  
End Sub
```

  
  
cvs is a global B4XCanvas. Create it with this code when the app starts:  

```B4X
Dim p As B4XView = xui.CreatePanel("")  
   p.SetLayoutAnimated(0, 0, 0, 1dip, 1dip)  
   cvs.Initialize(p)
```
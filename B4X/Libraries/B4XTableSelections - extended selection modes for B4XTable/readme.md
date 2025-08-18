###  B4XTableSelections - extended selection modes for B4XTable by Erel
### 01/13/2022
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/114294/)

![](https://www.b4x.com/basic4android/images/java_pBh7rhOHqQ.png)  
  
B4XTableSelections extends B4XTable and adds new selection modes:  
  
SINGLE\_CELL\_TEMP - this is the built-in selection mode. Unlike the other selection modes it disappears automatically.  
SINGLE\_CELL\_PERMANENT - selection of a single cell.  
SINGLE\_LINE\_PERMANENT - selection of a single line.  
MULTIPLE\_CELLS - selection of multiple cells.  
MULTIPLE\_LINES - selection of multiple lines  
  
Usage:  
Initialize B4XTableSelections and set the mode:  

```B4X
XSelections.Initialize(B4XTable1)  
XSelections.Mode = XSelections.MODE_SINGLE_CELL_TEMP
```

  
  
Implement these two events like this:  

```B4X
Sub B4XTable1_CellClicked (ColumnId As String, RowId As Long)  
    XSelections.CellClicked(ColumnId, RowId)  
End Sub  
  
Sub B4XTable1_DataUpdated  
    XSelections.Refresh  
End Sub
```

  
  
The example shows how to get the selected lines or cells.  
In lines mode:  

```B4X
For Each rowid As Long In XSelections.SelectedLines.Keys  
        
Next
```

  
In cells mode:  

```B4X
For Each rowid As Long In XSelections.SelectedLines.Keys  
    Dim cols As List = XSelections.SelectedLines.Get(rowid)  
    For Each col As String In cols  
       'cell is defined by (rowid, col)  
    Next  
Next
```

  
In single selection modes (SINGLE\_CELL\_PERMANENT and SINGLE\_LINE\_PERMANENT) you can use FirstSelectedRowId and FirstSelectedColumnId to get the selected line and column.  
  
You can also make selections programmatically by modifying SelectedLines collection and calling Refresh.  
  
The class is included in the attached B4J example.  
  
**Updates**  
  
V1.04 - Fixes an issue with hidden columns.  
V1.03 - New SelectedTextColor field.  
V1.02 - Bug fix. New IsSelected property.  
New FirstSelectedRowId and FirstSelectedColumnId methods. Especially useful in the single mode selections.  
**Depends on B4XCollections.**  
  
V1.01 - New AutoRemoveInvisibleSelections field. When True selections are removed automatically when the selected lines or cells are not visible.
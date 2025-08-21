###  B4XTable - Multiple rows selection by Erel
### 05/25/2020
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/102364/)

**Edit: Don't use this code. Use B4XTableSelections class instead:** <https://www.b4x.com/android/forum/threads/b4x-b4xtableselections-extended-selection-modes-for-b4xtable.114294/>  
  
This example depends on B4XTable v1.02+ and [B4XCollections](https://www.b4x.com/android/forum/threads/101071/#content).  
  
![](https://www.b4x.com/basic4android/images/SS-2019-02-06_15.44.21.png)  
  
It is quite simple to implement custom selection logic.  
  
Step #1: The Selection Color property in the designer should be set to transparent. This will disable the default cell click animation.  
  
Step #2: We maintain a B4XSet with the selected rows ids. This set is updated in the CellClicked event:  

```B4X
Sub B4XTable1_CellClicked (ColumnId As String, RowId As Long)  
   Dim Selected As Boolean  
   If SelectedRows.Contains(RowId) Then  
       SelectedRows.Remove(RowId)  
       Selected = False  
   Else  
       SelectedRows.Add(RowId)  
       Selected = True  
   End If  
   Dim Index As Int = B4XTable1.VisibleRowIds.IndexOf(RowId) 'Find the index of the visible row  
   SetRowColor(Index, Selected) 'Set its color  
End Sub
```

  
  
Step #3: Whenever the data is updated, we need to go over the visible rows and update their visual state:  

```B4X
Sub B4XTable1_DataUpdated  
   For i = 0 To B4XTable1.VisibleRowIds.Size - 1  
       Dim RowId As Long = B4XTable1.VisibleRowIds.Get(i)  
       SetRowColor(i, SelectedRows.Contains(RowId))  
   Next      
End Sub
```

  
  
A B4J example is attached.
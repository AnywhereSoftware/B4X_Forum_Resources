### InlineEditing - extends B4XTable with inline editing features by Erel
### 03/02/2020
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/112686/)

![](https://www.b4x.com/basic4android/images/MQZ4DtUtlv.gif)  
  
This class helps with adding inline editing features to B4XTable.  
  
Usage instructions:  
  
1. Initialize an InlineEditing object, named 'ie' in the example.  
2. Delegate the following events:  

```B4X
Private Sub MainForm_Resize (Width As Double, Height As Double)  
    ie.TableResized  
End Sub  
  
Sub B4XTable1_CellClicked (ColumnId As String, RowId As Long)  
    'avoid calling ie.CellClicked if the column is not editable.  
    ie.CellClicked(ColumnId, RowId)  
End Sub  
  
Sub B4XTable1_DataUpdated  
    ie.DataUpdated  
End Sub
```

  
  
Now for the real work. You need to implement two events:  
  
1. EnterEditMode - this event is called when the table enters edit mode. You need to prepare the control that will be used and assign it to FC.View:  

```B4X
Private Sub IE_EnterEditMode (FC As FocusedCell)  
    'FC.PrevValue holds the current value. It can also be used later to revert changes  
    Select FC.ColumnId  
        Case "Number"  
            B4XPlusMinus1.SetNumericRange(0, 100, 1)  
            B4XPlusMinus1.SelectedValue = FC.PrevValue  
            FC.View = B4XPlusMinus1.mBase  
        Case "String"  
            SetTextField  
            TextField1.Text = FC.PrevValue  
            FC.View = TextField1  
        Case "Color"  
            B4XPlusMinus1.SetStringItems(ColorsList)  
            B4XPlusMinus1.SelectedValue = FC.PrevValue  
            FC.View = B4XPlusMinus1.mBase  
        Case "Date"  
            SetTextField  
            TextField1.Text = DateTime.Date(FC.PrevValue)  
            FC.View = TextField1  
    End Select  
End Sub
```

  
2. GetUpdatedValue - this event is called when exiting edit mode. You need to return the value that will be saved in the table.  
  

```B4X
Private Sub IE_GetUpdatedValue (FC As FocusedCell) As Object  
    Select FC.ColumnId  
        Case "Number"  
            Return B4XPlusMinus1.SelectedValue  
        Case "String"  
            Return TextField1.Text  
        Case "Color"  
            Return B4XPlusMinus1.SelectedValue  
        Case "Date"  
            Try  
                Return DateTime.DateParse(TextField1.Text)  
            Catch  
                Return FC.PrevValue  
            End Try  
    End Select  
    Return Null  
End Sub
```

  
  
Make sure to use the latest version of B4XTable.
### B4xTable: Property Bag Use Case by Mashiane
### 10/01/2023
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/154371/)

Hi  
  
I am attempting to use a B4xTable as a property bag. I found B4xTable Inline Editing fit for this as i can set and get any component. You can use that as reference.  
  
The magic is keeping which components use what e.g. e.g B4XPlusMinus1 will have a secondary map of Numbers.  
A TextArea will have a secondary map of LongText etc etc.  
  
![](https://www.b4x.com/android/forum/attachments/146548)  
  
Creating a property bag… propBag is a B4xTable.  
  

```B4X
Sub PagePropBag As ResumableSub  
    Try  
    Numbers.Initialize  
    Choices.Initialize  
    LongText.Initialize   
    Sleep(0)  
    propBag.Clear  
    propBag.lblFirst.Parent.Visible = False  
    propBag.SearchVisible = False  
    propBag.RowHeight = 60dip  
      
    colDetails = propBag.AddColumn("Details", propBag.COLUMN_TYPE_TEXT)  
    colDetails.Sortable = False  
    colDetails.Width = 100dip  
    colValue = propBag.AddColumn("Value", propBag.COLUMN_TYPE_TEXT)  
    colValue.Sortable = False  
    '  
    propBag.HeaderFont = xui.CreateDefaultBoldFont(12)  
    propBag.LabelsFont = xui.CreateDefaultFont(12)  
    '  
    propBag.MaximumRowsPerPage = 9  
    propBag.BuildLayoutsCache(propBag.MaximumRowsPerPage)  
    propBag.HighlightSearchResults = False  
    '  
    SetColumnHorizontalAlignment(colDetails, "left")  
    SetColumnHorizontalAlignment(colValue, "center")  
    '  
    Dim data As List  
    data.Initialize  
      
    data.Add(Array("Name", "index"))  
    data.Add(Array("Page Tag", "div"))  
    data.Add(Array("Title", "Home"))  
    data.Add(Array("Icon", "logo-ionic"))  
    data.Add(Array("Classes", ""))  
    data.Add(Array("Styles", ""))  
    data.Add(Array("Attributes", ""))  
    'data.Add(Array("Row", 1))  
    'data.Add(Array("Column", 1))  
    data.Add(Array("Active", "yes"))  
    data.Add(Array("Save", "Apply"))  
    propBag.SetData(data)  
    '  
    'define all numeric fields  
    'Numbers.Put("Row", "")  
    'Numbers.Put("Column", "")  
    'define all switches  
    Choices.Put("Active", "")  
    Choices.Put("Page Tag", "")  
    LongText.Put("Classes", "")  
    LongText.Put("Styles", "")  
    LongText.Put("Attributes", "")  
    propBag.RefreshNow  
    Return True  
    Catch  
        Log(LastException)  
        Return True  
    End Try      
End Sub
```

  
  
In my controls I have also added a TextArea  
  
![](https://www.b4x.com/android/forum/attachments/146549)  
  
Important: On CellClicked, ignore anything that is not on "Value" column.  
  

```B4X
If ColumnId <> "Value" Then Return
```

  
  
For editing, we detect the row column type based on Numbers, Choices, LongText for example and show the approprivate editor for that XY position.  
  

```B4X
Private Sub IE_EnterEditMode (FC As FocusedCell)  
    Try  
        'get the row of data  
        Dim rowData As Map = propBag.GetRow(FC.RowId)  
        'get the details content  
        Dim sDetails As String = rowData.Get("Details")  
        'FC.PrevValue holds the current value. It can also be used later to revert changes  
        Select FC.ColumnId  
        Case "Value"  
            'use numeric  
            If Numbers.ContainsKey(sDetails) Then  
                B4XPlusMinus1.SetNumericRange(0, 100, 1)  
                B4XPlusMinus1.SelectedValue = FC.PrevValue  
                FC.View = B4XPlusMinus1.mBase  
                Return  
            End If  
            'use switch  
            If Choices.ContainsKey(sDetails) Then  
                Select Case sDetails  
                Case "Page Tag"  
                    B4XPlusMinus1.SetStringItems(Array("div", "ion-content"))  
                    B4XPlusMinus1.SelectedValue = FC.PrevValue  
                    FC.View = B4XPlusMinus1.mBase  
                    Return  
                Case "Active"  
                    B4XPlusMinus1.SetStringItems(Array("yes", "no"))  
                    B4XPlusMinus1.SelectedValue = FC.PrevValue  
                    FC.View = B4XPlusMinus1.mBase  
                    Return  
                End Select  
            End If  
            If LongText.ContainsKey(sDetails) Then  
                SetTextArea  
                TextArea1.Text = FC.PrevValue  
                FC.View = TextArea1  
                Return  
            End If  
            'default to text  
            SetTextField  
            TextField1.Text = FC.PrevValue  
            FC.View = TextField1  
        End Select  
    Catch  
          
    End Try    'ignore          
          
End Sub  
  
Private Sub IE_GetUpdatedValue (FC As FocusedCell) As Object  
    Try  
        'get the row of data  
        Dim rowData As Map = propBag.GetRow(FC.RowId)  
        'get the details content  
        Dim sDetails As String = rowData.Get("Details")  
        Select FC.ColumnId  
        Case "Value"  
            If Numbers.ContainsKey(sDetails) Then Return NumberFormat(B4XPlusMinus1.SelectedValue,1,0)  
            If Choices.ContainsKey(sDetails) Then Return B4XPlusMinus1.SelectedValue  
            If LongText.ContainsKey(sDetails) Then Return TextArea1.Text  
            'default to text  
            Return TextField1.Text  
        End Select  
    Catch  
        Return Null  
    End Try          
    Return Null  
End Sub  
  
Private Sub SetTextArea  
    Try  
        TextArea1.SetColorAndBorder(xui.Color_Transparent, 0, 0, 0)  
        Dim tf As TextArea = TextArea1  
        Sleep(0)  
        tf.SelectAll  
    Catch  
          
    End Try        'ignore  
End Sub  
  
  
Private Sub SetTextField  
    Try  
        TextField1.SetColorAndBorder(xui.Color_Transparent, 0, 0, 0)  
        Dim tf As TextField = TextField1  
        Sleep(0)  
        tf.SelectAll  
    Catch  
          
    End Try        'ignore          
End Sub  
  
Sub TextArea1_Action  
    Try  
        ie.ExitEditMode  
    Catch  
    End Try    'ignore  
End Sub  
  
Sub TextField1_Action  
    Try  
        ie.ExitEditMode  
    Catch  
    End Try    'ignore          
End Sub  
  
Sub TextArea1_TextChanged (Old As String, New As String)  
'    If ie.IsInEditingState And ie.CurrentlyFocusedCell.ColumnId = "Date" Then  
'        Try  
'            DateTime.DateParse(New)  
'            TextField1.SetColorAndBorder(xui.Color_Transparent, 0, 0, 0)  
'        Catch  
'            TextField1.SetColorAndBorder(xui.Color_Transparent, 2, xui.Color_Red, 0)  
'        End Try  
'    End If  
End Sub  
  
Sub TextField1_TextChanged (Old As String, New As String)  
'    If ie.IsInEditingState And ie.CurrentlyFocusedCell.ColumnId = "Date" Then  
'        Try  
'            DateTime.DateParse(New)  
'            TextField1.SetColorAndBorder(xui.Color_Transparent, 0, 0, 0)  
'        Catch  
'            TextField1.SetColorAndBorder(xui.Color_Transparent, 2, xui.Color_Red, 0)  
'        End Try  
'    End If  
End Sub
```

  
  
Happy Coding..
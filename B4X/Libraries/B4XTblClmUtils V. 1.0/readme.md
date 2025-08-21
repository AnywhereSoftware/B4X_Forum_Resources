###  B4XTblClmUtils V. 1.0 by LucaMs
### 04/22/2020
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/116672/)

B4XTblClmUtils is a b4x library (<https://www.b4x.com/android/forum/threads/100383/#content>).  
  
Allows you to set some properties of a B4XTableColumn (simple and default cells):  
  
- Text Size  
- Text Color  
- Font  
- Background color and border  
- Padding (B4A only).  
  
Example:  

```B4X
Sub Globals  
    Private B4XTable1 As B4XTable  
    Private mB4XTblClmUtils As B4XTblClmUtils  
''''  
End Sub  
  
Sub Activity_Create  
    Activity_LoadLayout("layMain")  
  
    ' B4XTable1 must be inside the layout loaded, of course.  
    B4XTable1.MaximumRowsPerPage = 10  
    B4XTable1.BuildLayoutsCache(10)  
    '  Add a column and data to the B4XTable1.  
    B4XTable1.AddColumn("Name", B4XTable1.COLUMN_TYPE_TEXT)  
    B4XTable1.SetData(Array As String("Erel", "Anywhere", "Software"))  
  
    ' Initialize it on B4XTable1.  
    mB4XTblClmUtils.Initialize(B4XTable1)  
  
    ' Sets some properties of column 0 cells.  
    mB4XTblClmUtils.SetFont2(0, "Action_Man_Shaded.ttf", 16)  
    mB4XTblClmUtils.SetTextSize(0, 16)  
    mB4XTblClmUtils.SetTextColor(0, xui.Color_Blue)  
    mB4XTblClmUtils.SetColorAndBorder(0, xui.Color_LightGray, 1, xui.Color_Blue, 5)  
    mB4XTblClmUtils.SetPadding(0, 5dip, 5dip, 5dip, 5dip) '  SetPadding is for B4A only
```

  
  
[It's based on [this my code](https://www.b4x.com/android/forum/threads/b4x-b4xtable-setting-cell-default-label-properties.116616/#post-728681)]
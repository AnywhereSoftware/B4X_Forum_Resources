###  B4XTable - Setting cell (default label) properties by LucaMs
### 04/22/2020
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/116616/)

**EDIT: created a more comfortable library (b4xlib) based on this code, B4XTblClmUtils**:  
<https://www.b4x.com/android/forum/threads/b4x-b4xtblclmutils-v-1-0.116672/post-729034>  
  
  
  

```B4X
    Public Const XCLMN_PROP_TEXTSIZE As String = "TextSize"  
    Public Const XCLMN_PROP_TEXTCOLOR As String = "TextColor"    'XUI colors  
    Public Const XCLMN_PROP_FONT As String = "Font"                    'B4XFont  
    Public Const XCLMN_PROP_PADDING As String = "Padding"            'B4A only.  
    Public Const XCLMN_PROP_COLORANDBORDER As String = "ColorAndBorder"  
       Public Const CAB_BGCOLOR As String = "BGC"  
       Public Const CAB_BWIDTH As String = "BW"  
       Public Const CAB_BCOLOR As String = "BC"  
       Public Const CAB_BCRADIUS As String = "BCR"
```

  
  

```B4X
B4XTable1.MaximumRowsPerPage = 10  
B4XTable1.BuildLayoutsCache(10)
```

  
  

```B4X
Dim mapProps As Map  
mapProps.Initialize  
  
Dim xFnt As B4XFont  
xFnt = xui.CreateFont(fx.LoadFont(File.DirAssets, "FontFileNameHere", 16), 16)  
mapProps.Put(XCLMN_PROP_FONT, xFnt)  
mapProps.Put(XCLMN_PROP_TEXTSIZE, 20) ' This is an example; fnt text size previously "set" to 16!  
mapProps.Put(XCLMN_PROP_TEXTCOLOR, xui.Color_Blue)  
mapProps.Put(XCLMN_PROP_COLORANDBORDER, CreateMap(CAB_BGCOLOR:xui.Color_LightGray))  
  
SetColumnCellProps(B4XTable1, 0, mapProps)
```

  
  

```B4X
' Note:  
' 1 - you should first set BuildLayoutsCache, like:  
'    B4XTable1.MaximumRowsPerPage = 10  
'    B4XTable1.BuildLayoutsCache(B4XTable1.MaximumRowsPerPage)  
'  
' 2 - for XCLMN_PROP_COLORANDBORDER, pass a map with BAC_ constants as keys:  
'    SetColumnCellProps(B4XTable1, 0, CreateMap(CAB_BGCOLOR:xui.Color_LightGray))  
Sub SetColumnCellProps(xTable As B4XTable, ColumnIndex As Int, Properties As Map)  
    Dim xColumn As B4XTableColumn = xTable.Columns.Get(ColumnIndex)  
    For i = 1 To xColumn.CellsLayouts.Size - 1  
        Dim pnl As B4XView = xColumn.CellsLayouts.Get(i)  
        Dim lbl As Label = pnl.GetView(0)  
        Dim xLbl As B4XView = lbl  
        ' Here set the lbl properties.  
        Dim PropName As String  
        Dim PropValue As Object  
        For Each PropName As String In Properties.Keys  
            PropValue = Properties.Get(PropName)  
            Select PropName  
                Case XCLMN_PROP_TEXTSIZE  
                    lbl.TextSize = PropValue  
                Case XCLMN_PROP_FONT  
                    xLbl.Font = PropValue  
                Case XCLMN_PROP_TEXTCOLOR  
                    xLbl.TextColor = PropValue  
                Case XCLMN_PROP_PADDING  
                    #If B4A  
                        lbl.Padding = PropValue  
                    #End If  
                Case XCLMN_PROP_COLORANDBORDER  
                    Dim mCAB As Map = PropValue  
                    xLbl.SetColorAndBorder(mCAB.GetDefault(CAB_BGCOLOR, xui.Color_White), _  
                                           mCAB.GetDefault(CAB_BWIDTH, 1), _  
                                           mCAB.GetDefault(CAB_BCOLOR, xui.Color_Black), _  
                                           mCAB.GetDefault(CAB_BCRADIUS, 0))  
            End Select  
        Next  
    Next  
End Sub
```
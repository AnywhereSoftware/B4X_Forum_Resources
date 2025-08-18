###  [XUI] SD: XUI_DragView by Star-Dust
### 09/14/2021
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/92512/)

This library handles drag and drop of XUI views.  
It is a simple library with few methods but it only serves to drag the space already indicated.  
(required XUI 1.72+)  
  
Good fun  
  
**SD\_XUI\_DragView  
  
Author:** Star-Dust  
**Version:** 0.03  

- **DragDropView**

- **Events:**

- **DragViewMoving** (DragView As B4XView)
- **PlacedCoordinate** (DragView As B4XView)
- **PlacedView** (DragView As B4XView, PlaceView As B4XView)

- **Fields:**

- **OverPlaceMoreView** As Boolean

- **Functions:**

- **AddDragView** (View As B4XView, AddAlsoPlaceCoordinate As Boolean) As DragDropView
 *View is mobible View (Label,Panel ecc..)  
 AddAlsoPlaceCoordinate (boolean) Add Initial View Coordinate to AddPlaceCoordinate*- **AddPlaceCoordinate** (Left As Int, Top As Int, Width As Int, Height As Int) As DragDropView
- **AddPlaceView** (View As B4XView) As DragDropView
- **Class\_Globals** As String
- **ClearDrag** As String
- **ClearPlaceCoordinate** As String
- **ClearPlaceView** As String
- **Initialize** (mCallBack As Object, mEventName As String) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*
- **DragLabel**

- **Events:**

- **BoardMoved**
- **ClickAddElement** (ColumnName As String)
- **ClickModifyColumn** (ColumnPosition As Int)
- **ClickModifyElement** (ColumnPosition As Int, ItemPosition As Int)
- **ItemClickRightMenu** (Position As Int, Value As Object)

- **Fields:**

- **BoardBackGroundColor** As Int
- **LabelSingleLine** As Boolean
- **SpaceBetweenBoard** As Int
- **SpaceBetweenColumn** As Int
- **SpaceBetweenTitleColumn** As Int

- **Functions:**

- **AddColumnEmpty** (ColumnName As String, Movible As Boolean) As Boolean
 *Add a column empy*- **AddColumnList** (ColumnName As String, ColumnList As List, TextColor As Int, Movible As Boolean) As Boolean
 *Add a entire list - don't isert a duplicate Name  
 ColumnName= Colum Title  
 ColumnList = List of String*- **AddElement** (ColumnName As String, Item As String, ID As String, TextColor As Int, RefreshView As Boolean) As String
 *Add a sigle element on column, if column don't exist create it*- **AddElementTo** (ColumnPos As Int, Item As String, ID As String, TextColor As Int, RefreshView As Boolean) As String
 *Add a sigle element on column, Column select with position*- **AddItemRightMenu** (Text1 As String, Text2 As String, Bitmap As Bitmap, ReturnValue As Object) As String
- **Class\_Globals** As String
- **Clear** As String
- **ClearRightMenu** As String
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **GetBase** As Panel
- **getID** (ColumnPos As Int, ItemPos As Int) As String
 *Retun ID List from Column position and Row (Item) position*- **getItem** (ColumnPos As Int, ItemPos As Int) As String
 *Retun Item List from Column position and Row (Item) position*- **Height** As Int
- **Initialize** (vCallBack As Object, vEventName As String) As String
- **Invalidate** As String
- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **LeftPanelAddElement** (ColumnName As String, Item As String) As String
- **LeftPanelClear** As String
- **LeftPanelGetColumn** As List
- **LeftPanelGetListElement** (ColumnName As String) As List
- **LeftPanelRemoveColumn** (ColumnName As String) As String
- **LeftPanelRemoveElement** (ColumnName As String, Item As String) As String
- **RemoveColumn** (ColumnName As String) As Boolean
*Remove entire column*- **RemoveColumnFromPosition** (ColumnPosition As Int) As String
 *ColumnNumber = 0… n*- **RemoveElelentFromPosition** (ColumnPosition As Int, ItemPosition As Int) As Boolean
 *Delete a sigle item on coumn from position*- **RemoveElement** (ColumnName As String, Item As String) As Boolean
 *Delete a sigle item on coumn*- **SetBoardToHome** As String
- **SetDimension** (WidthItem As Int, HeightItem As Int) As String
*Width >=50dip  
 Height >=20dip*- **SetMovibleColumn** (ColumnName As String, Movible As Boolean) As String
- **SortColumn** (ColumnName As String, Ascending As Boolean) As String
- **SortColumnFromPosition** (ColumnPosition As String, Ascending As Boolean) As String
*ColumnPositione = 0 .. n*- **Width** As Int

- **Properties:**

- **ColumNameList** As List [read only]
 *Retun List of Column Title*- **TitleBackgroundColor**
 *Set Title BackGround Color*- **TitleTextColor**
 *Set Title Text Color*
- **TLeft**

- **Fields:**

- **Column** As String
- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **Item** As String

- **Functions:**

- **Initialize**
*Inizializza i campi al loro valore predefinito.*
  
  
  
*![](https://www.b4x.com/android/forum/attachments/67401)*  
-
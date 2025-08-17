###  [XUI] [B4XLib] SD_ShopListView by Star-Dust
### 08/31/2023
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/136104/)

This new view allows you to have an ordered and distributed list of images (left) and their name, description and info (right)  
Or you can view the images in grid (if the screen size allows it, otherwise in column) where there will be related images with the name just below  
There is an add button and a close button that makes the visit invisible (mBase.Visible = False so to speak)  
**Note**: In the asset file you must always put the **empty.png** file. The file can be found in the examples  
  
**NOTE**: *You can use this library for personal and commercial use. Include it in your projects.. Attention, even if it is a **B4XLib** library, it is not allowed to decompress it, modify it, change its name or redistribute it without the permission of the author*  
  
**SD\_ShopListView  
  
Author:** Star-Dust  
**Version:** 0.13  

- **ShopListView**

- **Events:**

- **Add**
- **Clicked** (Pos As Int, ID As String)

- **Fields:**

- **Animated** As Boolean
- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **AddItem** (ID As String, Image As B4XBitmap, Name As String, Description As String, Info As String)
*Add Item - with Image*- **AddItemAsync** (ID As String, FileName As String, Name As String, Description As String, Info As String)
*Add Item - with local file image*- **AddItemNoImage** (ID As String, Name As String, Description As String, Info As String)
*Add Item - Without image - The image can be set later asynchronously*- **AddToParent** (MainPane As B4XView, Left As Int, Top As Int, Width As Int, Height As Int)
- **Base\_Resize** (Width As Double, Height As Double)
- **BringToFront**
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map)
*Base type must be Object*- **GetBase** As B4XView
- **GetDescription** (ID As String) As String
- **Getid** (position As Int) As String
- **GetInfo** (ID As String) As String
- **GetName** (ID As String) As String
- **GrayBitmap** (bmp As B4XBitmap) As B4XBitmap
- **ImageView** (EventName As String) As B4XView
- **Initialize** (Callback As Object, EventName As String)
- **Invalidate**
- **isGrid** As Boolean
- **RequestFocus**
- **SendToBack**
- **SetImage** (ID As String, Image As B4XBitmap)
- **SetItem** (ID As String, NewName As String, NewDescription As String, NewInfo As String)
- **SetVisibleAnimated** (Duration As Int, Visible As Boolean)
- **size** As Int
- **Snapshot** As B4XView
- **TurnToGrid**
- **TurnToList**

- **Properties:**

- **ButtonAddVisible** As Boolean [write only]
- **ButtonExitVisible** As Boolean [write only]
- **ButtonsGridListVisible** As Boolean [write only]
- **Enable** As Boolean
- **FilterFont** As B4XFont ' Hint Font
- **FilterHint** As String
- **FilterSearchText** As String
- **FilterVisible** As Boolean [write only]
- **Height** As Int
- **Left** As Int
- **Top** As Int
- **Visible** As Boolean
- **Width** As Int

- **xSD\_Scroll**

- **Events:**

- **ScrollChanged** (X As Double, Y As Double)
- **ScrollChangedX** (X As Double)
- **ScrollChangedY** (Y As Double)

- **Fields:**

- **PX** As Double
- **PY** As Double

- **Functions:**

- **AddToParent** (MainPane As B4XView, Left As Int, Top As Int, Width As Int, Height As Int)
*Create from codice*- **AddView** (View As B4XView, Left As Int, Top As Int, Width As Int, Height As Int)
- **BringToFront**
- **ClearAll**
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map)
*Base type must be Object*- **FullScroll** (Bottom As Boolean)
- **GetAllViewsRecursive** As List
- **GetBase** As B4XView
- **GetView** (Index As Int) As B4XView
- **Initialize** (Callback As Object, EventName As String)
- **IsInitialized** As Boolean
- **LoadLayout** (LayoutFile As String)
- **NativeObject** As Object
- **NumberOfViews** As Int
- **Parent** As B4XView
- **RemoveAllViews**
- **RemoveViewFromParent**
- **RequestFocus**
- **SendToBack**
- **SetBitmap** (bmp As B4XBitmap)
- **SetColorAndBorder** (Backgroundcolor As Int, BorderWidth As Int, BorderColor As Int, BorderCornerRadius As Int)
- **SetColorAnimated** (Duration As Int, FromColor As Int, ToColor As Int)
- **SetLayoutAnimated** (Duration As Int, Left As Int, Top As Int, Width As Int, Height As Int)
- **SetPanelBitmap** (bmp As B4XBitmap)
- **SetRotationAnimated** (Duration As Int, Degree As Int)
- **SetVisibleAnimated** (Duration As Int, Visible As Boolean)
- **Snapshot** As B4XView

- **Properties:**

- **Color** As Int
- **Enable** As Boolean
- **Height** As Int
- **HorizontalBar** As Boolean
- **Left** As Int
- **Panel** As B4XView [read only]
- **PanelHeight** As Int
- **PanelWidth** As Int
- **PositionX** As Double
- **PositionY** As Double
- **Tag** As Object
- **Top** As Int
- **VerticalBar** As Boolean
- **Visible** As Boolean
- **Width** As Int

  
  
![](https://www.b4x.com/android/forum/attachments/121807) ![](https://www.b4x.com/android/forum/attachments/121812)
###  [XUI] SD XUIScrollView2D by Star-Dust
### 04/30/2024
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/106476/)

I develop the cross-platform version of the ScrollView2D library.  
**XUIScrollView** was developed all from scratch.  
**xScrollView** is a wrapping of the native ScrollView but which standardizes the commands so that they can be used cross-platform.  
Everyone can choose which one is best suited to their purpose  
  
**NOTE**: *You can use this library for personal and commercial use. Include it in your projects.. Attention, even if it is a **B4XLib** library, it is not allowed to decompress it, modify it, change its name or redistribute it without the permission of the author*  
  
**SD\_XUIScrollView2D  
  
Author:** Star-Dust  
**Version:** 0.14  

- **XUIScrollView**

- **Events:**

- **ScrollChanged** (X As Float, Y As Float)

- **Fields:**

- **Tag** As Object
- **ScrollingX** As Boolean
- **ScrollingY** As Boolean

- **Functions:**

- **AddView** (View As B4XView, Left As Int, Top As Int, Width As Int, Height As Int)
- **BringToFront**
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map)
*Base type must be Object*- **FullScroll** (Bottom As Boolean)
- **GetAllViewsRecursive** As List
- **GetBase** As B4XView
- **GetView** (Index As Int) As B4XView
- **Initialize** (Callback As Object, EventName As String)
- **Initialize2** (Callback As Object, EventName As String, PanelParent As B4XView, Width As Int, Height As Int)
- **Invalidate**
- **LoadLayout** (LayoutFile As String)
- **NumberOfViews** As Int
- **Parent** As B4XView
- **RemoveAllViews**
- **RemoveViewFromParent**
- **RequestFocus**
- **ScrollPositionX** (X As Float)
- **ScrollPositionY** (Y As Float)
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
- **FastScroll** As Boolean
- **Height** As Int
- **HorizontalBar** As Boolean
- **Left** As Int
- **Panel** As B4XView [read only]
- **PanelHeight** As Int
- **PanelWidth** As Int
- **PositionX** As Float
- **PositionY** As Float
- **Top** As Int
- **VerticalBar** As Boolean
- **Visible** As Boolean
- **Width** As Int

- **xScrollView**

- **Events:**

- **ScrollChanged** (X As Double, Y As Double)
- **ScrollChangedX** (X As Double)
- **ScrollChangedY** (Y As Double)

- **Fields:**

- **Tag** As Object

- **Functions:**

- **AddToParent** (MainPane As B4XView, Left As Int, Top As Int, Width As Int, Height As Int)
*Create from codice*- **AddView** (View As B4XView, Left As Int, Top As Int, Width As Int, Height As Int)
- **BringToFront**
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
- **Top** As Int
- **VerticalBar** As Boolean
- **Visible** As Boolean
- **Width** As Int

  
  
![](https://www.b4x.com/android/forum/attachments/video1-gif.81039/)  
  
\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_  
**Log version  
0.02**  
Rounded scroll bars  
**0.03**  
Fix bugs of bars  
Add B4J Version  
**0.04**  
B4XLib now  
BUGS flicker correction  
**0.06**  
BUGS flicker correction  
**0.07**  
Add RemoveAllViews method  
**0.08**  
Fix bugs. Add Panel member  
**0.09**  
Fix bugs.  
**0.11**  
Touch interception improved.  
**0.12**  
New class added. XScrollView. It uses the native scrollView classes (ScrollView2D for b4a) by standardizing the use  
fix bugs (B4a)  
Updated examples (B4XPages)  
**0.13**  
fix bugs  
**0.14**  
Added ScrollingY and ScrollingY to enable or disable scrolling
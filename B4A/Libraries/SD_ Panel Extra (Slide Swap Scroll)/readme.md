### SD: Panel Extra (Slide Swap Scroll) by Star-Dust
### 06/30/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/83673/)

**(No WRAP, No Java Only B4A)   
  
[SIZE=4]The PanelExtra library contains these classes[/SIZE]  
PanelNavigator ([Example](https://www.b4x.com/android/forum/threads/sd-panel-extra-slide-swap-scroll.83673/#post-529949))**  
![](https://www.b4x.com/android/forum/attachments/61861) ![](https://www.b4x.com/android/forum/attachments/61862)  
**SlidePanel ([Example](https://www.b4x.com/android/forum/threads/sd-panel-extra-slide-swap-scroll.83673/#post-545567))**  
![](https://www.b4x.com/android/forum/attachments/67835) ![](https://www.b4x.com/android/forum/attachments/67836)  
**TitleScrollView ([Example](https://www.b4x.com/android/forum/threads/sd-panel-extra-slide-swap-scroll.83673/#post-529949))**  
![](https://www.b4x.com/android/forum/attachments/61863)  
**SwipePanel ([Example](https://www.b4x.com/android/forum/threads/sd-panel-extra-slide-swap-scroll.83673/#post-546345))**  
![](https://www.b4x.com/android/forum/attachments/67840)  
**ManagerPanel ([Example](https://www.b4x.com/android/forum/threads/sd-panel-extra-slide-swap-scroll.83673/#post-564808))**  
![](https://www.b4x.com/android/forum/attachments/64480)  
  
**SD\_PanelExtra  
  
Author:** Star-Dust  
**Version:** 0.11  

- **PanelNavigator**

- **Events:**

- **ChangePanel** (NumberPanel As Int)

- **Fields:**

- **BallSize** As Int
- **NameDrawable** As String

- **Functions:**

- **Add** (Name As String, Color As Int, Icon As Bitmap) As Int
*Add Name Panel, Color panel, Icon and return index of panel*- **Add2** (Name As String, Color As Int, Icon As Bitmap) As Panel
*Add Name Panel, Color panel, Icon and return panel*- **AddAt** (Name As String, Color As Int, Icon As Bitmap, Index As Int) As String
*Add Name Panel, Color panel, Icon at specific position*- **AddMyPanel** (Index As Int, Panel As Panel) As String
 *PanelNavigator.AddMyPanel(0,Panel3)*- **Class\_Globals** As String
- **Clear** As String
*Remove all panel*- **DesignerCreateView** (Base As Panel, Lbl As Label, Props As Map) As String
- **GetBase** As Panel
- **GetPanel** (Index As Int) As Panel
*Get Panel at Index*- **GetPanelName** (Index As Int) As String
*Get Name of Panel*- **GetSelectPanel** As Int
*Get Panel to be Visible*- **GetVisible** As Boolean
- **Initialize** (vCallback As Object, vEventName As String) As String
- **Invalidate** As String
*Rewrite all design*- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **SetBackGroundColor** (Color As Int) As String
*Change color of background*- **SetIcon** (Index As Int, B As Bitmap) As String
*Set Icon at panel position*- **SetIconPanelVisible** (Visible As Boolean) As String
*Set Visible/Invisible Icon Panel*- **SetLayout** (Left As Int, Top As Int, Width As Int, Height As Long) As String
- **SetNamePanelVisible** (Visible As Boolean) As String
*Set Visible/Invisible Label with NamePanel*- **setPadding** (Left As Int, Top As Int, Right As Int, Bottom As Int) As String
- **SetPanelName** (Index As Int, Name As String) As String
*Set Name of Panel*- **SetSelectPanel** (Index As Int) As String
*Set Panel to be Visible*- **SetTextColorNamePanel** (Color As Int) As String
*Set text Color ofa Name Panel if visible*- **SetVisible** (Visible As Boolean) As String
- **Size** As Int
*Number of panel insert*
- **SlidePanel** ' Slide Up/Down/Left/Right

- **Events:**

- **Close** (FromCode As Boolean)
- **Open** (FromCode As Boolean)

- **Fields:**

- **PanelSlide** As Panel
- **SlidePanelAnchor** As Int
- **CloseAutomatically** As Boolean
- **IsOpen** As Boolean

- **Functions:**

- **Class\_Globals** As String
- **CloseSlidePanel** As String
- **DesignerCreateView** (Base As Panel, Lbl As Label, Props As Map) As String
- **GetBase** As Panel
- **Initialize** (vCallback As Object, vEventName As String) As String
- **Invalidate** As String
- **IsInitialized** As Boolean
- **OpenSlidePanel** As String
- **SetSlideLeft** As String
- **SetSlideRight** As String
- **SetSlideUp** As String
- **SetSlideDown** As String

- **Properties:**

- **SlidePanelWidth** As Int
- **SlidePanelHeight** As Int

- **TitleScrollView**

- **Fields:**

- **FullHeight** As Int
- **MyTitleFull** As Panel
- **MyTitleReduced** As Panel
- **ReduceHeight** As Int
- **Scroll** As Panel

- **Functions:**

- **AddTitleFull** (Panel As Panel) As String
- **AddTitleReduce** (Panel As Panel) As String
- **Class\_Globals** As String
- **DesignerCreateView** (Base As Panel, Lbl As Label, Props As Map) As String
- **GetBase** As Panel
- **Initialize** (vCallback As Object, vEventName As String) As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*
- **ManagerPanel**

- **Events:**

- **Change** (FromCode As Boolean, ID As String)

- **Functions:**

- **Class\_Globals** As String
- **Clear** As String
- **DesignerCreateView** (Base As Panel, Lbl As Label, Props As Map) As String
- **GetBase** As Panel
- **getPanel** (Position As Int) As Panel
- **getPanelfromID** (ID As String) As Panel
- **getPanelOnScreen** As Int
- **Initialize** (vCallback As Object, vEventName As String) As String
- **Invalidate** As String
- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **NewPanel** (Title As String, ID As String, ColorTitle As Int, ColorPanel As Int) As Panel
- **setPanelOnScreen** (Position As Int) As String

- **Properties:**

- **PanelOnScreen** As Int

**This library is in a limited version, some classes will only run one week to allow testing. You can receive the full version by making a donation.** Contact me in private.  
  
For other panel libraries see also this **[thread](https://www.b4x.com/android/forum/threads/sd-menu-with-animation.80908/#content)**  
  
![](https://www.b4x.com/android/forum/attachments/61245) ![](https://www.b4x.com/android/forum/attachments/61246) ![](https://www.b4x.com/android/forum/attachments/61247)
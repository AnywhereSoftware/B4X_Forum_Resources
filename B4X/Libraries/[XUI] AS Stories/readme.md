###  [XUI] AS Stories by Alexander Stolte
### 11/18/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/148898/)

Library that shows a horizontal progress like Instagram stories. You can add your own layout like on the AS\_ViewPager. The AS\_Stories supports lazy loading too.  
  
I spend a lot of time in creating views, like this and to create a high quality view cost a lot of time. If you want to support me and further views, then you can do it [here by Paypal](https://www.paypal.me/stoltex) or with a [coffee](https://www.buymeacoffee.com/astolte). :)  
  
**This is the 1st version, it may contain bugs and errors.**  
  
AutoPlay = True | Default = False  
![](https://www.b4x.com/android/forum/attachments/143527)  
Tap to skip a page or hold, to hide infos from the layout  
![](https://www.b4x.com/android/forum/attachments/143528)  
**AS\_Stories  
Author: Alexander Stolte  
Version: 1.02**  

- **AS\_Stories**

- **Events:**

- **AutoPlayContinue**
- **AutoPlayEnd**
- **AutoPlayPause**
- **LazyLoadingAddContent** (Parent As B4XView, Value As Object)
- **PageChanged** (Index As Int)

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **AddPage** (PagePanel As B4XView, Value As Object) As String
- **AddPage2** (PagePanel As B4XView, CustomAutoPlayInterval As Long, Value As Object) As String
*CustomAutoPlayInterval - A custom auto play interval is set for this page, all other pages where none is set have the normal AutoPlayInterval*- **Base\_Resize** (Width As Double, Height As Double) As String
- **Class\_Globals** As String
- **Clear** As String
- **Commit** As String
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map)
*Base type must be Object*- **getAutoPlayInterval** As Long
- **getHeaderPanel** As B4XView
- **getIndex** As Int
- **GetPage** (Index As Int) As AS\_Stories\_Page
- **GetPanel** (Index As Int) As B4XView
*Returns the Panel stored at the specified index.*- **getSize** As Int
- **getTouchWidth** As Float
*Gets or sets the touch panel width  
 Default: 100dip*- **GetValue** (Index As Int) As Object
*Returns the Value stored at the specified index.*- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **NextPage** As String
- **Pause** As String
*Call Resume to start*- **PreviousPage** As String
- **RemovePageAt** (Index As Int) As String
- **ResetAutoPlay** As String
*Reset the auto play on the current index*- **Resume** As String
*Call Pause to stop*- **setAutoPlay** (Enabled As Boolean) As String
- **setAutoPlayInterval** (AutoPlayInterval As Long) As String
- **setIndex** (Index As Int) As String
- **setTouchWidth** (Width As Float) As String

- **Properties:**

- **AutoPlay**
- **AutoPlayInterval** As Long
- **HeaderPanel** As B4XView [read only]
- **Index** As Int
- **Size** As Int [read only]
- **TouchWidth** As Float
*Gets or sets the touch panel width  
 Default: 100dip*
- **AS\_Stories\_Page**

- **Fields:**

- **CustomAutoPlayInterval** As Long
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **Value** As Object

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
**Changelog**  

- **1.00**

- Release

- **1.01**

- B4A - Click events of views are now triggered
- Add ResetAutoPlay - Resets the autplay on the current index

- **1.02**

- Add AddPage2 - with a CustomAutoPlayInterval parameter
- Add GetPage
- Add get and set AutoPlayInterval

Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.me/stoltex)
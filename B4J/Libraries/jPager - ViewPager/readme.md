### jPager - ViewPager by Alexander Stolte
### 07/12/2024
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/146255/)

This is a high performance pager, optimized for large lists. No flickering or other unwanted behavior when changing index in large lists.  
Page change via arrow keys on the keyboard, or with the NextPage/PreviousPage function.  
  
I spend a lot of time in creating views, some views i need by my self, but some views not and to create a high quality view cost a lot of time. If you want to support me, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG) or with a [coffee](https://www.buymeacoffee.com/astolte). :)  
  
![](https://www.b4x.com/android/forum/attachments/139449)  
**jPager  
Author: Alexander Stolte  
Version: 1.00**  

- **jPager**

- **Events:**

- **LazyLoadingAddContent** (Parent As B4XView, Value As Object)
- **PageChanged** (Index As Int)

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **AddPage** (PagePanel As B4XView, Value As Object) As String
- **AddPageAt** (Index As Int, PagePanel As B4XView, Value As Object) As String
- **Base\_Resize** (Width As Double, Height As Double) As String
- **Class\_Globals** As String
- **Clear** As String
- **Commit** As String
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **getIndex** As Int
- **GetPanel** (Index As Int) As B4XView
*Returns the Panel stored at the specified index.*- **getSize** As Int
- **GetValue** (Index As Int) As Object
*Returns the Value stored at the specified index.*- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **NextPage** As String
- **PreviousPage** As String
- **RemovePageAt** (Index As Int) As String
- **setIndex** (Index As Int) As String

- **Properties:**

- **Index** As Int
- **Size** As Int [read only]

**Changelog**  

- **1.00**

- Release

- **1.01**

- BugFix

- **1.02**

- Add get and set LazyLoading
- Add get and set LazyLoadingExtraSize

- **1.03**

- Add AllowNext

- Default: True
- If False: Prevents the user from moving to the next page

- The NextPage function will not work
- The CurrentIndex property can be used without restrictions

- Add AllowBack

- Default: True
- If False: Prevents the user from moving to the previous page

- The PreviousPage function will not work
- The CurrentIndex property can be used without restrictions

Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)
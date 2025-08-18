###  [XUI] AS ViewPagerNative based on AHViewPager and iTabstrip by Alexander Stolte
### 10/29/2021
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/135514/)

The goal was to create a cross-platform viewpager based on existing viewpagers. Since AHViewPager and iTabstrip are very different, the view helps to create a unified interface.  
  
I spend a lot of time in creating views, some views i need by my self, but some views not and to create a high quality view cost a lot of time. If you want to support me, then you can do it [here by Paypal](https://www.paypal.me/stoltex). :)  
  
This library is compatible and tested with **B4A** and **B4I.**  
B4J is currently not compatible, maybe this will change in the future.  
[SPOILER="Dependencies/Libraries you need for this view"]  
**B4a**: XUi,AHViewPager  
**B4i**: iXUI,iTabStrip  
[/SPOILER]  
B4A: Make sure you have the [AHViewPager](https://www.b4x.com/android/forum/threads/ahviewpager-library-sliding-panels-now-perfect.14165/#content) V3.00  
B4I: Make sure you have the [ButtonCell.xib](https://www.b4x.com/android/forum/threads/tabstrip.80277/#content) in the Special folder  
B4A and B4I  
![](https://www.b4x.com/android/forum/attachments/120874)![](https://www.b4x.com/android/forum/attachments/120875)  
**ASViewPagerNative  
Author: Alexander Stolte  
Version: 1.01**  

- **ASViewPagerNative**

- **Events:**

- **PageChanged** (Index As Int)
- **ReachEnd**

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **AddPages** (ListOfPanels As List, Text As String) As String
- **Base\_Resize** (Width As Double, Height As Double) As String
- **Class\_Globals** As String
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **getCurrentIndex** As Int
*gets or sets the current index*- **getNativeViewPager** As de.amberhome.viewpager.AHViewPager
- **getSize** As Int
*Gets the number of pages*- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **NextPage** As String
*Smooth goes to next page*- **PreviousPage** As String
*Smooth goes to previous page*- **setCurrentIndex** (Index As Int) As String
*gets or sets the current index*- **setCurrentIndexAnimated** (Index As Int) As String
*sets the current index animated*
- **Properties:**

- **CurrentIndex** As Int
*gets or sets the current index*- **CurrentIndexAnimated**
*sets the current index animated*- **NativeViewPager** As de.amberhome.viewpager.AHViewPager [read only]
- **Size** As Int [read only]
*Gets the number of pages*
**Changelog**  

- **1.00**

- Add Event ReachEnd - Triggers if the last page is selected
- Add get NativeViewPager - Gets the native ViewPager View in B4A: AHViewPager B4I: iTabstrip
- Add get CurrentIndex - Gets the current index
- Add set CurrentIndexAnimated - Sets the current index animated
- BreakingChange set CurrentPage renamed to set CurrentIndex
- Add get Size - Gets the number of pages
- Base\_Resize is now Public
- Add NextPage - Smooth goes to next page
- Add PreviousPage - Smooth goes to previous page

- **1.01**

- AddPages - Remove "Text" Parameter

Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.me/stoltex)
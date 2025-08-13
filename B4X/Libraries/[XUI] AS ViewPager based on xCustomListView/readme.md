###  [XUI] AS ViewPager based on xCustomListView by Alexander Stolte
### 09/18/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/116709/)

Hey,  
thanks to [USER=11186]@KZero[/USER] for his good [zPager](https://www.b4x.com/android/forum/threads/zpager.116537/) class, i was able to extract a few things from it to make this cross platform view.  
  
I spend a lot of time in creating views, some views i need by my self, but some views not and to create a high quality view cost a lot of time. If you want to support me, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG) or with a [coffee](https://www.buymeacoffee.com/astolte). :)  
  
This library is compatible and tested with **B4A**,**B4I** and **B4J**!  
If you have bugs or a wish then tell me it in the comments.  
  
**Don't use autoscale in the layouts that are added to the viewpager.**  
  
On **B4J** use the LEFT and RIGHT keys on your keyboard to change the page.  
On **B4I** you need the GestureRecognizer class. Download it down below.  
[SPOILER="Dependencies/Libraries you need for this view"]  
**B4j**: jXUI,JavaObject,[jPager](https://www.b4x.com/android/forum/threads/jpager-viewpager.146255/),jReflection  
**B4a**: XUi,Reflection,xCustomListView  
**B4i**: iXUI,xCustomListView  
[/SPOILER]  
**Features**  

- cross-platform compatible
- based on a cross-platform ListView
- add and remove pages
- scroll to pages
- a good swipe feeling
- Vertical
- Carousel
- Lazy Loading
- **NEW** - AllowNext and AllowBack

Horizontal and Vertical  
![](https://www.b4x.com/android/forum/attachments/92400) ![](https://www.b4x.com/android/forum/attachments/98599)  
B4A Carousel and B4I Carousel  
![](https://www.b4x.com/android/forum/attachments/110402) ![](https://www.b4x.com/android/forum/attachments/110403)  
**ASViewPager  
Author: Alexander Stolte  
Version: 2.00**  
[SPOILER="Properties, Functions, Events, etc."]  

- **ASViewPager**

- **Events:**

- **LazyLoadingAddContent** (Parent As B4XView, Value As Object)
- **PageChange** (Index As Int)
- **PageChanged** (Index As Int)
- **PageChanged2** (NewIndex As Int, OldIndex As Int)
- **PageClick** (Index As Int, Value As Object)
- **ReachEnd**
- **ScrollChanged** (Offset As Int)
- **TouchBegin**
- **TouchEnd**

- **Fields:**

- **Tag** As Object

- **Functions:**

- **AddPage** (LayoutPanel As B4XView, Value As Object) As String
- **AddPageAt** (index As Int, LayoutPanel As B4XView, Value As Object) As String
*Adds an page at a special position*- **AllowBack** (Allow As Boolean) As String
*If False: Prevents the user from moving to the previous page  
 -The PreviousPage function will not work  
 -The CurrentIndex property can be used without restrictions*- **AllowNext** (Allow As Boolean) As String
*If False: Prevents the user from moving to the next page  
 -The NextPage function will not work  
 -The CurrentIndex property can be used without restrictions*- **Base\_Resize** (Width As Double, Height As Double)
- **Class\_Globals** As String
- **Clear** As String
- **Commit** As String
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **getBase** As B4XView
- **getCurrentIndex** As Int
- **getCustomListView** As b4a.example3.customlistview
- **getisScrollEnabled** As Boolean
*Checks if the swipe/scroll is enabled or disabled*- **getLazyLoading** As Boolean
- **getLazyLoadingExtraSize** As Int
- **getLoadingPanelColor** As Int
- **GetPanel** (Index As Int) As B4XView
- **getSize** As Int
- **GetValue** (Index As Int) As Object
- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **NextPage** As String
- **NextPage2** As String
*Jump to next page*- **PreviousPage** As String
- **PreviousPage2** As String
*jump to previous page*- **RemovePage** (index As Int) As String
- **ResetLazyloadingIndex** As String
- **ResetLazyLoadingPanels** As String
*Removes all child views from all visible pages  
 Usage:  
 <code>  
 xASVP\_Horizontal.ResetLazyLoadingPanels  
 Sleep(0)  
 xASVP\_Horizontal.ResetLazyloadingIndex  
 xASVP\_Horizontal.Commit</code>*- **Scroll2Value** (Value As String) As String
*sets the current index by the value - smooth scrolls to the item*- **Scroll2Value2** (Value As String) As String
*sets the current index by the value - jumps to the item*- **setCurrentIndex** (index As Int)
- **setCurrentIndex2** (index As Int)
*sets the current index - jumps to the item*- **setIgnoreLazyLoading** (Ignore As Boolean) As String
*If True, the Lazy Loading event is not triggered*- **setIgnorePageChangedEvent** (ignore As Boolean) As String
- **setIgnorePageChangeEvent** (ignore As Boolean) As String
- **setLazyLoading** (Enabled As Boolean) As String
- **setLazyLoadingExtraSize** (ExtraSize As Int) As String
- **setLoadingPanelColor** (Color As Int) As String
*The color of the Loading panel if Base\_Resize is executed*- **setLoadingPanelHideDuration** (Duration As Int) As String
- **setScroll** (enabled As Boolean) As String
*B4I and B4A only  
 enabled - False the scroll is deactivated*
- **Properties:**

- **Base** As B4XView [read only]
- **CurrentIndex** As Int
- **CurrentIndex2**
*sets the current index - jumps to the item*- **CustomListView** As b4a.example3.customlistview [read only]
- **IgnoreLazyLoading**
*If True, the Lazy Loading event is not triggered*- **IgnorePageChangedEvent**
- **IgnorePageChangeEvent**
- **isScrollEnabled** As Boolean [read only]
*Checks if the swipe/scroll is enabled or disabled*- **LazyLoading** As Boolean
- **LazyLoadingExtraSize** As Int
- **LoadingPanelColor** As Int
*The color of the Loading panel if Base\_Resize is executed*- **LoadingPanelHideDuration**
- **Scroll**
*B4I and B4A only  
 enabled - False the scroll is deactivated*- **Size** As Int [read only]

[/SPOILER]  
**Changelog**  
[SPOILER="Version 1.0-2.07"]  

- **1.00**

- Release

- **1.01**

- Base\_Resize is now public
- NextPage and PreviousPage Bug Fix
- setCurrentIndex Bug Fix
- PageChangeEvent Bug Fix

- **1.02**

- B4I Bug Fixes
- NextPage and PreviousPage Bug Fix

- **1.03**

- Resize BugFix

- **1.04**

- B4I Page-Height BugFix
- B4I Page-Swipe BugFix

- **1.05**

- BugFix

- **1.06**

- Add Designer Property "Orientation" - Vertical is now supported

- **1.07**

- BugFix getCurrentIndex
- BugFix PageChanged event is now only firing if the index is changed
- Add setIgnorePageChangedEvent Property
- Add TouchBegin Event
- Add TouchEnd Event
- BugFix PageChanged is now firing if you press on a emulator, for example the arrow up or down keys on yor keyboard

- **1.08**

- Add Tag Property

- <https://www.b4x.com/android/forum/threads/b4x-how-to-get-custom-view-here-from-clv-or-any-other-container.117992/#content>

- Add Clear - clears the list and sets the index to 0
- BugFix xCustomListview Top was always 0

- **1.09**

- B4I BugFixes for Release Mode - swiping is now better

- **1.10**

- Add AddPageAt (experimental it works for my need, if you have issuses, then tell me) - Adds an page at a special position
- Add set CurrentIndex2 - sets the current index - jumps to the item
- Better resize handling

- **1.11**

- RemovePage Bugfixes
- B4J ScrollPane under the hood is now Transparent
- Add NextPage2 -Jump to next page
- Add PrevoiusPage2 - Jump to previous page

- **1.12**

- [**BETA**] Add DesignerProperty Carousel - infinite swipe

- On B4I Bounce Effect is disabled

- B4I ScrollView Paging is now activated, this can improve the handling

- **1.13**

- Add PageClick Event

- **1.14 -** [**read more about this update here**](https://www.b4x.com/android/forum/threads/b4x-xui-as-viewpager-based-on-xcustomlistview.116709/post-828408)

- [B4I only] Add Scroll - enable or disable scroll with finger

- [ICODE]ASViewPager1.Scroll(False)'disable scroll with finger[/ICODE]

- **1.15**

- Intern Function IIF renamed to iif2

- **1.16**

- set Scroll is now B4X - disable the swipe/scroll

- In B4J the arrow keys (Left/Right/Up/Down) are disabled if you deactivate the swipe/scroll

- New property isScrollEnabled - checks if the swipe/scroll is enabled or disabled
- Intern Function iif2 removed and the core iif is now used

- B4A V11+ - B4J V9.10+ - B4I V7.50+

- **1.18**

- PageChanged Event is now firing in some cases with a delay, because of a scroll animation
- BugFix B4A setScroll - Events from other views are now no longer blocked

- **1.19**

- BugFix on NextPage and PreviousPage

- **1.20 (**[**read more about this update**](https://www.b4x.com/android/forum/threads/b4x-xui-as-viewpager-based-on-xcustomlistview.116709/post-839868)**)**

- Add Event PageChange - This event is triggered immediately after the page is changed, no delay because of animations
- Add setIgnorePageChangeEvent - prevents the PageChange event from being triggered

- **1.21**

- BugFixes

- **1.22**

- B4I Scroll = False BugFix

- **1.24**

- BugFix AddPageAt is now working better on B4A

- **1.25**

- Add Scroll2Value - sets the current index by the value - smooth scrolls to the item

- from the AddPage and AddPageAt function the "Value" property
- must be a string to be found

- Add Scroll2Value2 - sets the current index by the value - jump to the item

- **1.26** [**(read more about this update)**](https://www.b4x.com/android/forum/threads/b4x-xui-as-viewpager-based-on-xcustomlistview.116709/post-873849)

- Add Designer Property LazyLoading - activates lazy loading

- Default: False

- Add Designer Property LazyLoadingExtraSize - How many pages to load in advance

- Default: 5

- Add Event LazyLoadingAddContent - Add here your layout or views

- **1.27**

- Add get and set LazyLoadingExtraSize

- **1.28**

- Important LazyLoading improvments

- **1.29**

- Add Commit - Triggers the LazyLoadingAddContent event

- Call this after you have filled the list

- LazyLoading BugFixes

- **1.30**

- Add ResetLazyloadingIndex - when you call "commit" afterwards, it is guaranteed to check if there are empty panels in the lazy loading range, if so, the LazyLoading event is triggered

- **1.31**

- important resize improvments
- Add Loading Panel if Base\_Resize is calling
- Add Designer Property LoadingPanelColor
- Add set IgnoreLazyLoading - If True, the Lazy Loading event is not triggered
- Add ResetLazyLoadingPanels - Removes all child views from all visible pages
- LazyLoading Improvments

- **1.32**

- Carousel works now in Vertical mode

- **1.33**

- B4I Native paging is now used

- The paging feels smoother now
- In debug mode, the swiping should now also run better

- **1.34**

- B4I The GestureRecognizer is no longer needed

- **1.35 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-viewpager-based-on-xcustomlistview.116709/post-919049)**)**

- Add Designer Property BackGestureGap - Only for B4I. If you use the ViewPager on a 2nd page and still want to close the page with the swipe gesture then set the checkbox to true

- Default: False

- **2.00 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-viewpager-based-on-xcustomlistview.116709/post-927359)**)**

- New dependency in B4J: [jPager](https://www.b4x.com/android/forum/threads/jpager-viewpager.146255/)
- Removed dependency in B4J: xCustomListView
- Add GetPanel
- Add GetValue
- In B4J, the jPager is now used instead of the xCustomListView

- Better performance
- No more unwanted scrolling with the mouse

- **2.01**

- BugFixes and Improvements
- Add Event PageChanged2

- **2.02**

- Add set LoadingPanelHideDuration - The duration of how quickly the loading panel is hidden

- Default: 500

- **2.03**

- B4I BugFix - Prevents vertical scrolling when in horizontal mode and vice versa

- **2.04**

- B4I BugFix - The safe area is no longer observed

- Fixes unwanted behavior when the viewpager is in the safe area

- **2.05**

- BugFix - by setting the set CurrentIndex or set CurrentIndex2, the PageChange and PageChanged event have been triggered multiple times

- **2.06**

- B4A BugFix

- **2.07**

- B4I BugFix

[/SPOILER]  

- **2.08**

- B4I - PageChange event is now triggered as soon as you lift your finger when changing pages, just like in B4A
- **B4J - You need** [**jPager V1.03**](https://www.b4x.com/android/forum/threads/jpager-viewpager.146255/)
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
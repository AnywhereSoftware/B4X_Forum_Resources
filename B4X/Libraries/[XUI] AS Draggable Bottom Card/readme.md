###  [XUI] AS Draggable Bottom Card by Alexander Stolte
### 05/26/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/121219/)

This is my 2k'th post on this Forum and i want to share a nice library with you i made some months ago.  
It was not easy to create this library, it took many hours of testing and programming to make the user experience as good as possible.  
  
If you want to support me, then you can do this [here](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG) or with a [coffee](https://www.buymeacoffee.com/astolte). Thanks :)  
  
**B4J is now supported**  
  
**Features**  

- cross-platform compatible
- easy to use
- use your own header and body layout
- 2 states - half expanded and full expanded
- Events
- and more…

Some design inspiration:  
![](https://www.b4x.com/android/forum/attachments/98535)  
![](https://www.b4x.com/android/forum/attachments/98536)![](https://www.b4x.com/android/forum/attachments/98537)![](https://www.b4x.com/android/forum/attachments/98539)![](https://www.b4x.com/android/forum/attachments/98540)![](https://www.b4x.com/android/forum/attachments/98541)  
![](https://www.b4x.com/android/forum/attachments/98538)![](https://www.b4x.com/android/forum/attachments/108599)![](https://www.b4x.com/android/forum/attachments/108600)![](https://www.b4x.com/android/forum/attachments/128859)  
  
<https://www.b4x.com/android/forum/threads/b4x-as-draggablebottomcard-drag-indicator-confirm-button.157554/>  
<https://www.b4x.com/android/forum/threads/b4x-xui-as-bottomphonenumberflagpicker.157781/#post-968586>  
<https://www.b4x.com/android/forum/threads/b4x-xui-as-bottomemojipicker.157648/>  
<https://www.b4x.com/android/forum/threads/b4x-xui-as-bottomactionmenu.157513/#content>  
<https://www.b4x.com/android/forum/threads/b4x-xui-as-bottomdatepicker.149266/#content>  
<https://www.b4x.com/android/forum/threads/b4x-xui-as-bottomactionsheet.159328/>  
<https://www.b4x.com/android/forum/threads/b4x-xui-as-bottomcolorchooser.164296/>  
<https://www.b4x.com/android/forum/threads/b4x-xui-as-bottomselectionlist.164319/>  
  
**ASDraggableBottomCard  
Author: Alexander Stolte  
Version: 1.05  
[SPOILER="Properties, Functions, Events, etc."][/SPOILER]**[SPOILER="Properties, Functions, Events, etc."]  

- **ASDraggableBottomCard**

- **Events:**

- **Close**
- **Closed**
- **Open**
- **Opened**
- **VisibleBodyHeightChanged** (height As Double)

- **Fields:**

- **g\_hide\_duration** As Int
- **g\_show\_duration** As Int

- **Functions:**

- **Base\_Resize** (Width As Double, Height As Double) As String
- **BodyPanel** As B4XView
*gets the body panel - Load your body layout*- **Class\_Globals** As String
- **Create** (Parent As B4XView, first\_height As Float, second\_height As Float, header\_height As Float, width As Float, orientation As Int) As String
*Base type must be Object*- **ExpandFull** As String
*expand the view full - second height + header height*- **ExpandHalf** As String
*expand the view in half mode - first height + header height*- **getCardBase** As B4XView
*gets the card base - the main panel that hold the body- and header-panel*- **getDarkPanelAlpha** As Int
- **getFirstHeight** As Float
- **getHeaderHeight** As Float
*gets the header height*- **getIsDraggable** As Boolean
- **getIsOpen** As Boolean
*Returns True if the view is expanded/open*- **getIsOpenFull** As Boolean
*Returns True if the view is full expanded*- **getIsOpenHalf** As Boolean
*Returns True if the view is half expanded*- **getSecondHeight** As Float
- **HeaderPanel** As B4XView
*gets the header panel - Load your header layout*- **Hide** (ignore\_event As Boolean)
*hides/close the view*- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **Orientation\_LEFT** As Int
- **Orientation\_MIDDLE** As Int
- **Orientation\_RIGHT** As Int
- **setCornerRadius\_Header** (radius As Float) As String
*sets the corner radius of the header*- **setDarkPanelAlpha** (alpha As Int) As String
- **setFirstHeight** (height As Float) As String
*sets or gets the first height - body height  
 The Event VisibleBodyHeightChanged is triggered if the menu is currently open at the first height*- **setIsDraggable** (draggable As Boolean) As String
*set it to false to disable touch gestures on header panel*- **setSecondHeight** (height As Float) As String
*sets or gets the second height - body height  
 The Event VisibleBodyHeightChanged is triggered if the menu is currently open at the second height*- **Show** (ignore\_event As Boolean) As String

- **Properties:**

- **CardBase** As B4XView [read only]
*gets the card base - the main panel that hold the body- and header-panel*- **CornerRadius\_Header**
*sets the corner radius of the header*- **DarkPanelAlpha** As Int
- **FirstHeight** As Float
*sets or gets the first height - body height  
 The Event VisibleBodyHeightChanged is triggered if the menu is currently open at the first height*- **HeaderHeight** As Float [read only]
*gets the header height*- **IsDraggable** As Boolean
*set it to false to disable touch gestures on header panel*- **IsOpen** As Boolean [read only]
*Returns True if the view is expanded/open*- **IsOpenFull** As Boolean [read only]
*Returns True if the view is full expanded*- **IsOpenHalf** As Boolean [read only]
*Returns True if the view is half expanded*- **SecondHeight** As Float
*sets or gets the second height - body height  
 The Event VisibleBodyHeightChanged is triggered if the menu is currently open at the second height*
[/SPOILER]  
**Changelog  
[SPOILER="Version 1.00-1.12"][/SPOILER][SPOILER="Version 1.0-1.12"][/SPOILER][SPOILER="Version 1.0-1.12"][/spoiler]**[SPOILER="Version 1.0-1.12"]  

- **1.00**

- Release

- **1.01**

- Various bug fixes and improvements
- The menu no longer closes when the last swipe went up, so it is now possible for the user to cancel a full close

- **1.02**

- Add CornerRadius\_Header - sets the CornerRadius of the header

- dont use asdbc\_main.HeaderPanel.Height if your set the corner radius, the returning height is not the display height
- use HeaderHeight instead

- Add HeaderHeight - gets the displayed header height
- Supports now B4J

- **1.03**

- Add set FirstHeight - sets the FirstHeight - The Event VisibleBodyHeightChanged is triggered if the menu is currently open at the first height
- Add set SecondHeight - sets the SecondHeight - The Event VisibleBodyHeightChanged is triggered if the menu is currently open at the second height
- Important BugFixes!

- **1.04**

- BugFix on Drag with finger - much more better experience now!

- **1.05**

- Add get IsOpenHalf - Returns True if the view is half expanded
- Add get IsOpenFull - Returns True if the view is full expanded
- Add IsDraggable - set it to false to disable touch gestures on header
- Add some property descriptions

- **1.06**

- B4I and B4J - Body can now be dragged too

- **1.07**

- BugFixes
- Significant handling improvements when working with 2 heights

- **1.08**

- Add get DarkPanel
- Add DarkPanelClickable - If false then does the menu not close when you click on the dark area

- Default: True

- **1.09**

- Add UserCanClose - If False then the user can expand the menu, but not close

- **1.10**

- BugFixes
- Add set and get BodyDrag - Call it before "Create"

- If True then you can drag the body too
- Not working if a list is in the body

- **1.11**

- Add BodyDragPanel

- **1.12**

- B4I only remove GestureRecognizer

[/SPOILER]  

- **1.13**

- BugFix

- **1.14**

- B4J BugFix

- **1.15**

- B4I Improvements - the entire screen is now used for the background shadow

- When the navigation bar was hidden, there was an area at the top that did not go dark when the menu was opened
- The height of the area is now determined and the gap closed
- B4XPages is now required in B4I

- **1.16**

- BugFix

- **1.17**

- BugFixes and Improvements
- [ICODE]Change[/ICODE] The menu now has the DarkPanel as parent and no longer the root page

- You don't notice it in use
- This allows you to add custom views to the DarkPanel and these are then above the BodyPanel and do not have to work on the root form

- [ICODE]New[/ICODE] get and set BottomOffset - A value to display the menu above the keyboard, for example, if you set the value to the keyboard height

- Default: 0

- [ICODE]Change [/ICODE] The corner radius is now only applied to the top corners

- **1.18**

- New ShowCustom - You have to extend the menu manually

- The Open Event is triggered and the DarkPanel becomes visible

Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)
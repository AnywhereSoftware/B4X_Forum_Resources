###  [XUI] AS Popup Menu by Alexander Stolte
### 07/01/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/121832/)

This is a simple cross platform Popup Menu.  
  
I spend a lot of time in creating views, like this and to create a high quality view cost a lot of time. If you want to support me and further views, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG) or with a [coffee](https://www.buymeacoffee.com/astolte). :)  
  
Left: B4J Right: B4A  
  
![](https://www.b4x.com/android/forum/attachments/99402)![](https://www.b4x.com/android/forum/attachments/99404)![](https://www.b4x.com/android/forum/attachments/99405)![](https://www.b4x.com/android/forum/attachments/103495)![](https://www.b4x.com/android/forum/attachments/107567)![](https://www.b4x.com/android/forum/attachments/125171)  
<https://www.b4x.com/android/forum/threads/b4x-as-popupmenu-with-icons.158623/#post-973772>  
![](https://www.b4x.com/android/forum/attachments/149656)  

```B4X
aspm_MoreOptions.Initialize(Root,Me,"aspm_MoreOptions")  
   
aspm_MoreOptions.ItemLabelProperties.ItemBackgroundColor = xui.Color_ARGB(255,19, 20, 22) 'Change the Background Color of the item  
aspm_MoreOptions.AddMenuItem("Share location",1)'Add item  
aspm_MoreOptions.AddMenuItem("Settings",2)'Add item  
  
aspm_MoreOptions.OrientationHorizontal = aspm_MoreOptions.OrientationHorizontal_RIGHT  
aspm_MoreOptions.OrientationVertical = aspm_MoreOptions.OrientationVertical_BOTTOM  
   
aspm_MoreOptions.ItemLabelProperties.BackgroundColor = xui.Color_ARGB(200,0,0,0)'black  
   
aspm_MoreOptions.OpenMenu(xlbl_MoreOptions,150dip)
```

  
**ASPopupMenu  
Author: Alexander Stolte  
Version: 1.08**  

- **ASPM\_ItemLabelProperties**

- **Fields:**

- **BackgroundColor** As Int
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **ItemBackgroundColor** As Int
- **LeftRightPadding** As Float
- **TextAlignment\_Horizontal** As String
- **TextAlignment\_Vertical** As String
- **TextColor** As Int
- **xFont** As B4XFont

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASPM\_TitleLabelProperties**

- **Fields:**

- **BackgroundColor** As Int
- **Height** As Float
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **ItemBackgroundColor** As Int
- **LeftRightPadding** As Float
- **TextAlignment\_Horizontal** As String
- **TextAlignment\_Vertical** As String
- **TextColor** As Int
- **xFont** As B4XFont

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASPopupMenu**

- **Events:**

- **ItemClicked** (Index As Int, Tag As Object)

- **Fields:**

- **AutoHideMs** As Int
- **CloseDurationMs** As Int
- **OpenDurationMs** As Int

- **Functions:**

- **AddMenuItem** (text As String, tag As Object) As String
- **AddTitle** (Text As String, height As Float) As String
- **Class\_Globals** As String
- **Clear** As String
*clears the list*- **CloseMenu** As String
- **CreateASPM\_ItemLabelProperties** (TextColor As Int, xFont As B4XFont, TextAlignment\_Vertical As String, TextAlignment\_Horizontal As String, BackgroundColor As Int, ItemBackgroundColor As Int, LeftRightPadding As Float) As ASPM\_ItemLabelProperties
- **CreateASPM\_TitleLabelProperties** (TextColor As Int, xFont As B4XFont, TextAlignment\_Vertical As String, TextAlignment\_Horizontal As String, BackgroundColor As Int, ItemBackgroundColor As Int, LeftRightPadding As Float, Height As Float) As ASPM\_TitleLabelProperties
- **getBase** As B4XView
- **getisOpen** As Boolean
*checks if the menu is open*- **getItemLabelProperties** As ASPM\_ItemLabelProperties
*change the label properties, call it before you add items  
 <code>ASScrollingTags1.LabelProperties.xFont = xui.CreateDefaultBoldFont(15)</code>*- **GetMenuItemAt\_Background** (index As Int) As B4XView
*gets a menu item background (parent of label)*- **GetMenuItemAt\_Label** (index As Int) As B4XView
*gets a menu item label - the label with the text*- **getOrientationHorizontal\_LEFT** As String
- **getOrientationHorizontal\_MIDDLE** As String
- **getOrientationHorizontal\_RIGHT** As String
- **getOrientationVertical\_BOTTOM** As String
- **getOrientationVertical\_TOP** As String
*Vertical = Top,Bottom  
 Horizontal = Left,Middle,Right*- **getSize** As Int
*gets the list size*- **getTitleLabelProperties** As ASPM\_TitleLabelProperties
*change the label properties, call it before you add the title  
 <code>ASScrollingTags1.TitleLabelProperties.xFont = xui.CreateDefaultBoldFont(20)</code>*- **Initialize** (Parent As B4XView, CallBack As Object, EventName As String) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **OpenMenu** (view As B4XView, width As Float)
*Opens the menu on a view*- **OpenMenu2** (parent As B4XView, width As Float)
*Open the menu on center of parent/view*- **RemoveTitle** As String
*Removes the title if exists*- **Resize** (parent\_width As Float, parent\_height As Float) As String
- **setActivityHasActionBar** (value As Boolean) As String
- **setCloseAfterItemClick** (enabled As Boolean) As String
*closes the menu automatically after clicking on an item  
 standard is True*- **setDividerColor** (color As Int) As String
*the color of the dividers*- **setDividerEnabled** (enable As Boolean) As String
*Adds or Removes the dividers*- **setDividerHeight** (height As Float) As String
*the height of the dividers*- **setIsInSpecialContainer** (value As Boolean) As String
*set it true if the target is on a listview or as a child on a panel where the left and top values differ from the form*- **setItemBackgroundColor** (crl As Int) As String
*sets the item background color for all items*- **setMenuCornerRadius** (radius As Int) As String
- **setOrientationHorizontal** (orientation As String) As String
- **setOrientationVertical** (orientation As String) As String
- **ViewScreenPosition** (view As B4XView) As Int()

- **Properties:**

- **ActivityHasActionBar**
- **Base** As B4XView [read only]
- **CloseAfterItemClick**
*closes the menu automatically after clicking on an item  
 standard is True*- **DividerColor**
*the color of the dividers*- **DividerEnabled**
*Adds or Removes the dividers*- **DividerHeight**
*the height of the dividers*- **IsInSpecialContainer**
*set it true if the target is on a listview or as a child on a panel where the left and top values differ from the form*- **isOpen** As Boolean [read only]
*checks if the menu is open*- **ItemBackgroundColor**
*sets the item background color for all items*- **ItemLabelProperties** As ASPM\_ItemLabelProperties [read only]
*change the label properties, call it before you add items  
 <code>ASScrollingTags1.LabelProperties.xFont = xui.CreateDefaultBoldFont(15)</code>*- **MenuCornerRadius**
- **OrientationHorizontal**
- **OrientationHorizontal\_LEFT** As String [read only]
- **OrientationHorizontal\_MIDDLE** As String [read only]
- **OrientationHorizontal\_RIGHT** As String [read only]
- **OrientationVertical**
- **OrientationVertical\_BOTTOM** As String [read only]
- **OrientationVertical\_TOP** As String [read only]
*Vertical = Top,Bottom  
 Horizontal = Left,Middle,Right*- **Size** As Int [read only]
*gets the list size*- **TitleLabelProperties** As ASPM\_TitleLabelProperties [read only]
*change the label properties, call it before you add the title  
 <code>ASScrollingTags1.TitleLabelProperties.xFont = xui.CreateDefaultBoldFont(20)</code>*
**Changelog**  

- **1.00**

- Release

- **1.01**

- Adds background\_color global variable - the background color of the parent view during the menu is open
- Adds setItemBackgroundColor - change the items background color
- Better Handling in "Nested Layouts"
- Add ActivityHasActionBar - set to true if you have a ActionBar enabled
- Add IsInSpecialContainer - set it true if the target is on a listview or as a child on a panel where the left and top values differ from the form
- Add setOrientationVertical
- Add setOrientationHorizontal
- Adds "Enums" for Orientations -TOP,BOTTOM -LEFT,MIDDLE,RIGHT

- **1.02**

- Add OpenMenu2 - Opens the menu in center of the parent view
- Add Clear - clear all
- Add getBase - gets the base view to customize it
- Add getLabelProperties - customize it if you want, before you add a new menu item

- ![](https://www.b4x.com/android/forum/attachments/103494)
- this is now possible

- [ICODE]aspm\_main.LabelProperties.ItemBackgroundColor = xui.Color\_ARGB(255,Rnd(1,256), Rnd(1,256), Rnd(1,256))[/ICODE]

- Remove background\_color and itembackground\_color

- Added to getLabelProperties

- Add GetMenuItemAt\_Label
- Add GetMenuItemAt\_Background
- Add getSize
- Add setMenuCornerRadius - sets the corner radius for the menu (works only in B4A and B4I)

- ![](https://www.b4x.com/android/forum/attachments/103495)

- **1.03**

- Add LeftRightPadding to ASPM\_LabelProperties - label padding to have more space left and right for example HorizontalCenter = LEFT
- OpenMenu the background is now smoother on show
- setMenuCornerRadius is now available on B4J (thanks [USER=1]@Erel[/USER])

- **1.04**

- getLabelProperties is renamed to getItemLabelProperties
- Add AddTitle - you can now add a title to the menu

- Add TitleLabelProperties - you can change the title properties with it

- Add RemoveTitle - Removes the title if exists
- Add AutoHideMs
- Add DividerEnabled - you can now show dividers between the items

- Add DividerHeight - the height of the dividers
- Add DividerColor - the color of the dividers

- **1.05**

- OpenMenu Show Animation with the background is now animated
- BugFixes

- **1.06**

- BugFixes

- **1.07**

- Add get isOpen - checks if the menu is open
- BugFix - if you called OpenMenu several times without closing the menu, then the menu was added several times
- Add set CloseAfterItemClick - closes the menu automatically after clicking on an item

- standard is True

- Add set and get CloseDurationMs - the duration it takes for the menu to be completely closed
- Add set and get OpenDurationMs - the duration it takes for the menu to be fully visible

- **1.08**

- Intern Function IIF renamed to iif2

- **1.09**

- Add set MenuViewGap - sets the gap between the menu and the attached view
- Add get TriangleProperties
- Add set ShowTriangle - only visible if you open the menu with OpenMenu

- Default: False

- **1.10**

- BugFix

- **1.11**

- Add OpenMenuAdvanced - You can set the Left, Top and Width value to show the menu on the parent
- Add MenuHeight - gets the MenuHeight even if the menu is not yet visible
- BugFixes

- **1.12 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-popup-menu.121832/post-901338)**)**

- Add get and set ClickColor
- Add get and set BackgroundPanelColor
- B4J Only - Hover Over Item with color

- **1.13 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-popup-menu.121832/post-973771)**)**

- Add AddMenuItemWithIcon
- Add get IconProperties
- Add get and set ItemHeight

- **1.14**

- Text can now be multiline

- **1.15**

- B4I Improvements - the entire screen is now used for the background shadow

- When the navigation bar was hidden, there was an area at the top that did not go dark when the menu was opened
- The height of the area is now determined and the gap closed
- B4XPages is now required in B4I

- **1.16**

- BugFix If the icon horizontal alignment is set to center and there is no text, the icon is now displayed in the center

- **1.17**

- BugFix on CloseMenu thanks to [USER=98801]@Mike1970[/USER]

Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)
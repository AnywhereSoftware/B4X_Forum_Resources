###  [XUI] AS PopupMenuAdvanced based on xCustomListView by Alexander Stolte
### 12/16/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/135874/)

This is a PopupMenu with a xCustomListView, so you can add simply new rows. And also add build in separator or title without having to worry about it yourself.  
  
Not all functions of the normal PopupMenu are available yet. For now it has only the functions I needed for my project.  
  
I spend a lot of time in creating views, like this and to create a high quality view cost a lot of time. If you want to support me and further views, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG) or with a [coffee](https://www.buymeacoffee.com/astolte). :)  
  
This view is tested on B4A, B4I and B4J. Screenshot from my project.  
![](https://www.b4x.com/android/forum/attachments/121420)![](https://www.b4x.com/android/forum/attachments/121421)![](https://www.b4x.com/android/forum/attachments/121603)![](https://www.b4x.com/android/forum/attachments/121604)  
**ASPopupMenuAdvanced  
Author: Alexander Stolte  
Version: 1.01**  

- **ASPM\_SeparatorPropertiesAdvanced**

- **Fields:**

- **BackgroundColor** As Int
- **Height** As Float
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*
- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASPM\_TitleLabelPropertiesAdvanced**

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
- **ASPopupMenuAdvanced**

- **Events:**

- **ItemClick** (Index As Int, Tag As Object)
- **ItemLongClick** (Index As Int, Tag As Object)
- **MenuClosed**

- **Fields:**

- **AutoHideMs** As Int
- **CloseDurationMs** As Int
- **OpenDurationMs** As Int

- **Functions:**

- **AddItem** (xPnl As B4XView, Value As Object) As String
*Add a item e.g. a panel with checkboxes*- **AddItemAt** (Index As Int, xPnl As B4XView, Value As Object) As String
*Add a item at a special index*- **AddSeparator** As String
*Add a separator*- **AddTitle** (Text As String, Height As Float) As String
*Add a title*- **Class\_Globals** As String
- **Clear** As String
*Clears the list*- **CloseMenu** As String
*Close the menu*- **CreateASPM\_SeparatorPropertiesAdvanced** (Height As Float, BackgroundColor As Int) As ASPM\_SeparatorPropertiesAdvanced
- **CreateASPM\_TitleLabelPropertiesAdvanced** (TextColor As Int, xFont As B4XFont, TextAlignment\_Vertical As String, TextAlignment\_Horizontal As String, BackgroundColor As Int, ItemBackgroundColor As Int, LeftRightPadding As Float, Height As Float) As ASPM\_TitleLabelPropertiesAdvanced
- **getCustomListView** As b4a.example3.customlistview
*gets the xCustomListView*- **getOrientationHorizontal\_LEFT** As String
- **getOrientationHorizontal\_MIDDLE** As String
- **getOrientationHorizontal\_RIGHT** As String
- **getOrientationVertical\_BOTTOM** As String
- **getOrientationVertical\_TOP** As String
*Vertical = Top,Bottom  
 Horizontal = Left,Middle,Right*- **getSeparatorProperties** As ASPM\_SeparatorPropertiesAdvanced
*change the separator properties, call it before you add the title  
 <code>ASScrollingTags1.TitleLabelProperties.xFont = xui.CreateDefaultBoldFont(20)</code>*- **getTitleLabelProperties** As ASPM\_TitleLabelPropertiesAdvanced
*change the label properties, call it before you add the title  
 <code>ASScrollingTags1.TitleLabelProperties.xFont = xui.CreateDefaultBoldFont(20)</code>*- **Initialize** (Parent As B4XView, CallBack As Object, EventName As String) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **OpenMenu** (Width As Float, Height As Float)
*Opens the menu*- **OpenMenuOnView** (xView As B4XView, Width As Float, Height As Float)
*Opens the menu attached to a view*- **Resize** (ParentWidth As Float, ParentHeight As Float) As String
- **setActivityHasActionBar** (value As Boolean) As String
- **setCornerRadius** (radius As Int) As String
*sets the corner radius from the menu*- **setDividerHeight** (height As Int) As String
- **setIsInSpecialContainer** (value As Boolean) As String
*set it true if the target is on a listview or as a child on a panel where the left and top values differ from the form*- **setMenuViewGap** (Gap As Float) As String
*sets the gap between the menu and the attached view  
 only affected if you open the menu with OpenMenuOnView*- **setOrientationVertical** (orientation As String) As String
- **ViewScreenPosition** (view As B4XView) As Int()

- **Properties:**

- **ActivityHasActionBar**
- **CornerRadius**
*sets the corner radius from the menu*- **CustomListView** As b4a.example3.customlistview [read only]
*gets the xCustomListView*- **DividerHeight**
- **IsInSpecialContainer**
*set it true if the target is on a listview or as a child on a panel where the left and top values differ from the form*- **MenuViewGap**
*sets the gap between the menu and the attached view  
 only affected if you open the menu with OpenMenuOnView*- **OrientationHorizontal\_LEFT** As String [read only]
- **OrientationHorizontal\_MIDDLE** As String [read only]
- **OrientationHorizontal\_RIGHT** As String [read only]
- **OrientationVertical**
- **OrientationVertical\_BOTTOM** As String [read only]
- **OrientationVertical\_TOP** As String [read only]
*Vertical = Top,Bottom  
 Horizontal = Left,Middle,Right*- **SeparatorProperties** As ASPM\_SeparatorPropertiesAdvanced [read only]
*change the separator properties, call it before you add the title  
 <code>ASScrollingTags1.TitleLabelProperties.xFont = xui.CreateDefaultBoldFont(20)</code>*- **TitleLabelProperties** As ASPM\_TitleLabelPropertiesAdvanced [read only]
*change the label properties, call it before you add the title  
 <code>ASScrollingTags1.TitleLabelProperties.xFont = xui.CreateDefaultBoldFont(20)</code>*
**Changelog**  

- **1.00**

- Release

- **1.01**

- Add OpenMenuOnView - opens the view attached on a view
- Add set IsInSpecialContainer - set it true if the target is on a listview or as a child on a panel where the left and top values differ from the form
- Add set ActivityHasActionBar
- Add set OrientationVertical
- Add set MenuViewGap - sets the gap between the menu and the attached view

- only affected if you open the menu with OpenMenuOnView

- **1.02**

- Add get isOpen - checks if the menu is open

- **1.03**

- Add set MenuViewGap - sets the gap between the menu and the attached view
- Add get TriangleProperties
- Add set ShowTriangle - only visible if you open the menu with OpenMenu

- Default: False

- **1.04**

- BugFix

- **1.05**

- BugFixes
- Add OpenMenuAdvanced - You can set the Left, Top and Width value to show the menu on the parent

- **1.06**

- Add get BackgroundPanel

- **1.07**

- B4I Improvements - the entire screen is now used for the background shadow

- When the navigation bar was hidden, there was an area at the top that did not go dark when the menu was opened
- The height of the area is now determined and the gap closed
- B4XPages is now required in B4I

Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)
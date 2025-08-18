### [XUI] WobbleMenu - a cross platform animated bottom navigation by Biswajit
### 01/25/2021
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/118412/)

Hi everyone,  
  
This is a B4X compatible bottom navigation. It has 4 types of tab changing animation and 3 types of icon revealing animation.  
  
![](https://www.b4x.com/android/forum/attachments/94944)  
  
**WobbleMenu  
Author:** [USER=100215]@Biswajit[/USER]  
**Version:** 1.5  
**Dependency:** JavaObject, BitmapCreator, XUI  

- **WobbleMenu**

- **Functions**:

- **GetCurrentTab** As Int
*Get the current tab id (1 to 5)*- **GetHeight** As Int
*Get menu height.*- **SetAnimationType**(Animation\_Type As Int)
*Set the tab changing animation type. Check properties* - **SetCurrentTab**(TabID As Int)
*Set the current tab from 1 to 5*- **SetCurrentTab2**(TabID As Int, triggerEvent As Boolean) **[SIZE=2]NEW[/SIZE]**
*Same as SetCurrentTab. If you set triggerEvent = false then it will not trigger the tab click event.*- **SetIconAppearStyle**(Icon\_Appear\_Style As Int)
*Set icon revealing animation type. Check properties*- **SetTabTextIcon**(TabID As Int, Text As String, Icon As String, IconFont As Typeface)
*Set the tab text and icons (TabID must be between 1 to 5)*- **SetTabTextIcon2**(TabID As Int, Text As String, Icon As Bitmap, tinted As Boolean) **[SIZE=2]NEW[/SIZE]**
*Set the tab text and image icon (TabID must be between 1 to 5)*- **SetBadge**(TabID As Int, Count As Int, BackColor As Int, TxtColor As Int)
*Set tab badge. (after 99 it will show 99+)*- **RemoveBadge**(TabID As Int)
*Remove badge from a tab.*- **SetTabCount**(count As Int)
*Set tab count at runtime.  
Count must be either 5 or 3  
 Note: You can't change the tab count to 3 if your selected tab id is 4 or 5*- **SetEnableTab**(TabID As Int, enable As Boolean)
*Enable or disable a tab.*- **GetEnableTab**(TabID As Int) As Boolean
*Check if a tab is enabled or not.*- **SetVisible**(show As Boolean, animate As Boolean) **[SIZE=2]NEW[/SIZE]**
*Set menu visibility*
- **Events**:

- Tab1Click
- Tab2Click
- Tab3Click
- Tab4Click
- Tab5Click

- **Properties:**

- **ANIMATION\_TYPE\_ELASTIC\_OUT** As Int
- **ANIMATION\_TYPE\_ELASTIC\_IN** As Int
- **ANIMATION\_TYPE\_EASE\_OUT** As Int
- **ANIMATION\_TYPE\_EASE\_IN** As Int
- **ANIMATION\_TYPE\_NONE** As Int
- **ICON\_APPEAR\_FROM\_CENTER** As Int
- **ICON\_APPEAR\_FROM\_EDGE** As Int
- **ICON\_APPEAR\_FADE\_IN** As Int
- **ICON\_APPEAR\_NO\_ANIMATION** As Int

- **Designer Properties:**

- No. of Tabs (Default: 5)
- Active Tab (Default 3) **[SIZE=2]NEW[/SIZE]**
- Background Color (Default: 0xFFFFFFFF)
- Shadow Color (Default: Dark)
- Icon Color (Default: 0xFFBBBBBB)
- Icon Size (Default: 18)
- Text Color (Default: 0xFFFFFFFF)
- Text Size (Default: 14)
- Selected Icon Color (Default: 0xFF000000)
- Icon Appear Style (Default: FROM EDGE)
- Animation Type (Default: ELASTIC OUT)
- Animation Duration (Default: 500)

You can implement your own animation. Check this [link](http://www.timotheegroleau.com/Flash/experiments/easing_function_generator.htm).  
Copy the library to the additional library folder then run the examples. Have fun!  
  
**UPDATE v1.2** (Latest Examples and Library Attached):  

1. Added 3 Tabs option to designer properties
2. Added Icon Fade In and no animation option
3. Fixed SetTabIcon method, previously it was unable to handle any TabID value other than 1 to 5

**UPDATE v1.3**:  

1. Added Shadow Type (Light/Dark) Option

**UPDATE v1.4**:  

1. Now you can add text under icons
2. Now you can add a badge to each tab
3. Control icon size, text color, and text size from the designer.
4. More smooth curve.

**UPDATE v1.41**: Fixed a variable mismatch error.  
**UPDATE v1.42**: Added getHeight method.  
**UPDATE v1.43**:  

1. Change tab count at runtime
2. Get or set the tab enable status.

**UPDATE v1.44**:  

1. Minor animation bug fixed.
2. Added b4xpage+viewpager example.

**UPDATE v1.5**:  

1. Added image icon support.
2. Added setVisible method.
3. Added setCurrentTab2 method which supports changing active tab without triggering click event.
4. Now the default active tab can be selected from the designer.

**UPDATE v1.51**: Badge visibility bug fix.
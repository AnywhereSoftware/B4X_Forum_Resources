###  [XUI] AS WheelPicker - Spinner - a modern single/multiple choice picker view - based on xCustomListView [Payware] by Alexander Stolte
### 01/12/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/127505/)

Hello,  
this is a modern wheel picker, like the IOS-PickerView.  
WheelPicker/Spinner  
  
This library is **not free**, because, it cost a lot of time and gray hair to create such views.  
<https://payhip.com/b/IvqnN>  
Thanks for your understanding. :)  
  
V3.00-Preview  
[MEDIA=youtube]xzrcl6aT6bw[/MEDIA]  
![](https://www.b4x.com/android/forum/attachments/137977)  
B4I-Preview - looks nicer and smoother in real  
![](https://www.b4x.com/android/forum/attachments/107748)  
B4I-Preview - the WheelPicker in the use in an app  
![](https://www.b4x.com/android/forum/attachments/107749)![](https://www.b4x.com/android/forum/attachments/107750)  
B4A-Preview  
![](https://www.b4x.com/android/forum/attachments/107752)  
**NEW** Seperators with text or without text  
![](https://www.b4x.com/android/forum/attachments/109342)![](https://www.b4x.com/android/forum/attachments/109344)  
**NEW** Next- and Previous-Item - scrolls to the next or previous item animated and male rounded corners  
![](https://www.b4x.com/android/forum/attachments/111479)  
![](https://www.b4x.com/android/forum/attachments/122875)  
Based on ASWheelPicker:  
<https://www.b4x.com/android/forum/threads/b4x-as-wheeldatetimepicker-based-on-aswheelpickeradvanced.141588/>  
[SPOILER="Dependencies/Libraries you need for this view"]  
**B4j**: jXUI,jBitmapCreator,jReflection,xCustomListView,XUI Views  
**B4a**: XUi,BitmapCreator,Reflection,xCustomListView,XUI Views  
**B4i**: iXUI,iBitmapCreator,xCustomListView,XUI Views  
[/SPOILER]  
On B4I you need the [GestureRecognize](https://www.b4x.com/android/forum/threads/gesturerecognizer-native-uigesturerecognizer.52836/)r or download a version without errors down below. **No longer needed V1.06+**  
Examples:  

```B4X
Dim tmp_lst As List : tmp_lst.Initialize 'Create and Initialize the list  
    'Fill the list with dummy items  
    For i = 0 To 50 -1  
    'text - the text to display in the wheel  
    'value - any value you want to identify the text E.g. a id  
    tmp_lst.Add(CreateMap("text":"Test " & i,"value":i))  
Next  
ASWheelPicker1.AddWheelAdvanced(tmp_lst)'adds the list to the view and adds a wheel
```

  

```B4X
'gets the item of the first wheel  
'use this function when you have added the wheel with AddWheelAdvanced  
Dim tmp_m As Map = ASWheelPicker1.GetSelectedItemAdvanced(0)  
Log("Text: " & tmp_m.Get("text"))  
Log("Value: " & tmp_m.Get("value"))  
  
'use this function when you have added the wheel with AddWheel  
Log("Text: " & ASWheelPicker1.GetSelectedItem(0))
```

  
**ASWheelPicker  
Author: Alexander Stolte  
Version: 3.01  
[SPOILER="Properties, Functions, Events, etc."][/SPOILER][SPOILER="Properties, Functions, Events, etc."][/SPOILER]**[SPOILER="Properties, Functions, Events, etc."]  

- **ASWheelPicker**

- **Events:**

- **BaseResize** (Width As Float)
- **ItemChange** (Column As Int, ListIndex As Int)
- **ItemSnapped** (wheel\_index As Int, list\_index As Int)
- **WheelReachEnd** (wheel\_index As Int)

- **Fields:**

- **InactiveDuration** As Int
- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **AddItems** (Items As List) As String
*Examples  
 Normal Text Item  
 <code>Dim tmp\_lst As List : tmp\_lst.Initialize  
 For i = 0 To 50 -1  
 tmp\_lst.Add("Test " & i)  
 Next  
 ASWheelPicker1.AddItems(tmp\_lst)</code>  
 Item Object Example:  
 <code> Dim Items As List : Items.Initialize  
 For i = 0 To 50 -1  
 Dim Item As ASWheelPicker\_Item  
 Item.Initialize  
 Item.Text = "Test " & i  
 Item.Value = i  
 Items.Add(ASWheelPicker1.CreateASWheelPicker\_Item("Test " & i,i))  
 Next  
 ASWheelPicker1.AddItems(Items)</code>*- **Base\_Resize** (Width As Double, Height As Double) As String
- **Class\_Globals** As String
- **CreateASWheelPicker\_Item** (Text As String, Value As Object) As ASWheelPicker\_Item
- **CreateASWheelPicker\_ItemTextProperties** (TextColor As Int, TextFont As B4XFont, TextAlignment\_Vertical As String, TextAlignment\_Horizontal As String, BackgroundColor As Int) As ASWheelPicker\_ItemTextProperties
- **CreateASWheelPicker\_SeperatorProperties** (Width As Float, BackgroundColor As Int, TextColor As Int, TextFont As B4XFont, TextAlignment\_Horizontal As String, index As Int) As ASWheelPicker\_SeperatorProperties
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **getBase** As B4XView
*gets the base view (mBase)*- **getBottomFadePanel** As B4XView
- **getEvents** As Boolean
- **GetIndex** (wheel\_index As Int) As Int
*gets the selected index*- **getItemTextProperties** As ASWheelPicker\_ItemTextProperties
*gets or sets the global Item Text Properties*- **getNumberOfColumns** As Int
*the number of wheels you have*- **getNumberOfSeperators** As Int
*the number of seperators*- **GetSelectedItem** (Column As Int) As ASWheelPicker\_Item
*Returns a string with the item text of the selected index of a wheel  
 <code>Log("Text: " & ASWheelPicker1.GetSelectedItem(0))</code>*- **getSelectorPanel** As B4XView
- **getSeperatorProperties** As ASWheelPicker\_SeperatorProperties
*gets or sets the global Seperator Properties*- **getTopFadePanel** As B4XView
- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **NextItem** (wheel\_index As Int, animated As Boolean)
*scrolls to the next item, jump to the first item if the next item is out of index*- **PreviousItem** (Column As Int, Animated As Boolean)
*scrolls to the previous item, jump to the last item if the previous item is out of index*- **Refresh** As String
- **RemoveColumn** (Column As Int) As String
*removes a wheel  
 <code>ASWheelPicker1.RemoveWheelAt(0)</code>*- **RemoveSeperatorAt** (Column As Int) As String
*removes a seperator  
 <code>ASWheelPicker1.RemoveSeperatorAt(0)</code>*- **SelectRow** (Column As Int, Row As Int, Animated As Boolean)
*scrolls to an item on a wheel*- **setBackgroundColor** (clr As Int) As String
*sets the background color*- **setCornerRadius** (Radius As Int) As String
*sets the corner radius of the view*- **setEvents** (Enabled As Boolean) As String
*Enables or disables the events  
 Default: True*- **setFadeColor** (clr As Int) As String
- **setFadeEnabled** (enable As Boolean) As String
*set it to false to disable the fade effect on top and bottom*- **setHapticFeedback** (enabled As Boolean) As String
- **setHapticFeedbackOnSnapIn** (Enabled As Boolean) As String
- **SetItems** (Column As Int, Items As List) As String
*Examples  
 Normal Text Item  
 <code>Dim tmp\_lst As List : tmp\_lst.Initialize  
 For i = 0 To 50 -1  
 tmp\_lst.Add("Test " & i)  
 Next  
 ASWheelPicker1.SetItems(0,tmp\_lst)</code>  
 Item Object Example:  
 <code> Dim Items As List : Items.Initialize  
 For i = 0 To 50 -1  
 Dim Item As ASWheelPicker\_Item  
 Item.Initialize  
 Item.Text = "Test " & i  
 Item.Value = i  
 Items.Add(ASWheelPicker1.CreateASWheelPicker\_Item("Test " & i,i))  
 Next  
 ASWheelPicker1.SetItems(0,Items)</code>*- **setRowHeightSelected** (height As Float) As String
*sets the Selected RowHeight default is 30dip - and changes the wheel items height + selector*- **setRowHeightUnSelected** (height As Float) As String
*sets the Unselected RowHeight default is 30dip - and changes the wheel items height*- **setSelectionBarColor** (clr As Int) As String
- **SetSeperator** (Column As Int, Width As Float, Text As String) As String
*wheel\_index - after wich wheel do you want to show the seperator - set it to -1 to place it before the first wheel  
 width - the width of the seperator  
 text - if you want text, then set the text here*- **SetWheelWidth** (Column As Int, ColumnWidth As Float) As String
*Sets the width of an wheel  
 Only working if you set the Width Mode to Manual*- **Size** (wheel\_index As Int) As Int
*gets size of a list*
- **Properties:**

- **BackgroundColor**
*sets the background color*- **Base** As B4XView [read only]
*gets the base view (mBase)*- **BottomFadePanel** As B4XView [read only]
- **CornerRadius**
*sets the corner radius of the view*- **Events** As Boolean
*Enables or disables the events  
 Default: True*- **FadeColor**
- **FadeEnabled**
*set it to false to disable the fade effect on top and bottom*- **HapticFeedback**
- **HapticFeedbackOnSnapIn**
- **ItemTextProperties** As ASWheelPicker\_ItemTextProperties [read only]
*gets or sets the global Item Text Properties*- **NumberOfColumns** As Int [read only]
*the number of wheels you have*- **NumberOfSeperators** As Int [read only]
*the number of seperators*- **RowHeightSelected**
*sets the Selected RowHeight default is 30dip - and changes the wheel items height + selector*- **RowHeightUnSelected**
*sets the Unselected RowHeight default is 30dip - and changes the wheel items height*- **SelectionBarColor**
- **SelectorPanel** As B4XView [read only]
- **SeperatorProperties** As ASWheelPicker\_SeperatorProperties [read only]
*gets or sets the global Seperator Properties*- **TopFadePanel** As B4XView [read only]

- **ASWheelPicker\_Item**

- **Fields:**

- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **ItemTextProperties** As ASWheelPicker\_ItemTextProperties
- **Text** As String
- **Value** As Object

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASWheelPicker\_ItemTextProperties**

- **Fields:**

- **BackgroundColor** As Int
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **Left** As Float
- **TextAlignment\_Horizontal** As String
- **TextAlignment\_Vertical** As String
- **TextColor** As Int
- **TextFont** As B4XFont
- **Width** As Float

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASWheelPicker\_SeperatorProperties**

- **Fields:**

- **BackgroundColor** As Int
- **index** As Int
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **TextAlignment\_Horizontal** As String
- **TextColor** As Int
- **TextFont** As B4XFont
- **Width** As Float

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
[/SPOILER]  
**Changelog  
[SPOILER="Version 1.00-3.23"][/SPOILER][SPOILER="Version 1.0-3.23"][/SPOILER][SPOILER="Version 1.0-3.23"][/spoiler]**[SPOILER="Version 1.0-3.23"]  

- **1.00**

- Release

- **1.01**

- Adds the Type ASWheelPicker\_ItemTextProperties - hold the style propterties for the wheel text

- Adds get ItemTextProperties - change the properties before you add a new wheel

- Adds set RowHeight - changes the row height of the items and the selector
- Adds UpdateStyleOfWheel - update the style of a particular wheel - changes the style to the properties of this: ItemTextProperties
- Adds UpdateStyleOfAllWheels - update the style of all wheels - changes the style to the properties of this: ItemTextProperties
- Adds RemoveWheelAt - removes a wheel

- **1.02**

- Adds FadeEnabled - set it to false to disable the fade effect on top and bottom
- Adds RowHeightSelected - sets the Selected RowHeight default is 30dip - and changes the wheel items height + selector
- Adds RowHeightUnSelected - sets the Unselected RowHeight default is 30dip - and changes the wheel items height
- Removed RowHeight - use RowHeightSelected and RowHeightUnSelected

- **1.03**

- Add get Base - gets the base view (mBase)
- Add Scroll2Index - scrolls to an item on a wheel
- Add get Index - gets the selected index

- **1.04**

- Add Size - gets size of a list
- the index of a list now starts at 0

- **1.05**

- Add AddSeperator - adds an seperator after a wheel. IF you want a placeholder before the first wheel, then set the index to -1

- seperators can display text
- seperators can be customized

- Add RemoveSeperatorAt - removes a seperator

- **2.00**

- Better Handling if you set an invalid wheel\_index as parameter to the functions
- Add get TopFadePanel
- Add get BottomFadePanel
- Fade Panels are now above and under the selector panel
- Add Next - scrolls to the next item, jump to the last item if the next item is out of index

- ![](https://www.b4x.com/android/forum/attachments/111479)

- Add Previous - scrolls to the previous item, jump to the last item if the previous item is out of index
- Add set CornerRadius - sets the corner radius of the view

- Add Designer Property CornerRadius

- SnapIn Improved - Immediately snaps into place without moving again
- BugFixes
- **new depency**: XUIViews, is needed for the HapticFeedback

- **2.01**

- Add get NumberOfSeperators - the number of seperators
- BugFix View Resizing

- **2.03**

- Add Event BaseResize - Triggers as soon as the width in the view has changed
- Add Event ItemChange - Triggers when an item reaches the center while scrolling, so you can display the results e.g. in a label instant
- B4I Item snap is now smooth

- **2.04 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-wheelpicker-spinner-a-modern-single-multiple-choice-picker-view-based-on-xcustomlistview.127505/post-865951)**)**

- Complete rework of the wheel sizing
- Add Designer Property WidthMode - Default: Automatic

- Automatic - You don't have to worry about anything, the view calculates the right size for all wheels
- Manual - Set the wheel sizes you need via "SetWheelWidth"

- Add WheelWidth to ItemTextProperties - This allows you to set the width of a wheel manually, only working if WidthMode = Manual - Default: 0
- Add SetWheelWidth - Sets the width of an wheel, only working if WidthMode = Manual
- Add get and set Events - Enables or disables the events
- Haptic feedback disabled if you call Scroll2Index
- BugFixes

- **2.06**

- BugFixes
- GestureRecognizer is now inside the B4XLib

- **3.00**

- Complete rewrite of the view
- Designer properties now have all default values

- If you add the view by code, you have less to consider

- The lists now use LazyLoading
- Breaking Changes on properties and functions

- **3.01**

- Add GetItem

- **3.02**

- Add GetSeperator

- **3.03**

- BugFixes
- Add AddItemAt
- Add RemoveItemAt
- Add GetListView - gets the xCustomListView for a column

- **3.04 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-wheelpicker-spinner-a-modern-single-multiple-choice-picker-view-based-on-xcustomlistview-payware.127505/post-904022)**)**

- Add Event CustomDrawItemChange

- **3.05**

- BugFixes

- **3.06**

- BugFixes

- **3.07**

- BugFixes

- **3.08**

- BugFixes B4I

- **3.09**

- GestureRecongnizer intern renamings

- **3.10**

- BugFix - in function GetItem

- **3.11 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-wheelpicker-spinner-a-modern-single-multiple-choice-picker-view-based-on-xcustomlistview-payware.127505/post-921549)**)**

- Add Designer Property TextColor
- Add Designer Property SelectionBarStyle

- Default: Rounded

- **3.12**

- Add SelectRow2 - Select a row with the Value, no index needed, just the value
- BugFixes

- **3.13**

- If the FadeColor is Transparent, then no fade will be displayed now

- **3.14**

- BugFixes

- **3.15 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-wheelpicker-spinner-a-modern-single-multiple-choice-picker-view-based-on-xcustomlistview-payware.127505/post-945217)**)**

- Add EnabledRow - Disable a specific row. When the user goes on it, he is automatically brought back to an item that is active. Events are not triggered when a row is disabled
- Add Designer Property DisabledTextColor

- **3.16**

- Add get and set BorderWidth
- Add get and set BorderColor

- **3.17**

- B4A Border BugFix

- **3.18**

- B4A Border BugFix

- **3.19**

- Add RefreshCustomDraw - Triggers the CustomDrawEvent

- Dont forget a Sleep(0) before you call this function

- **3.20**

- BugFixes

- **3.21**

- Add Event CustomDrawItem
- Fade Effect BugFixes

- **3.22**

- Important B4I BugFix

- **3.23**

- Add Clear - Clears a column

- SetItems already clears the list if you set a new list

[/SPOILER]  

- **3.24**

- BugFix If you changed the FadeColor, some of the old color remained

Have Fun :)  
<https://payhip.com/b/IvqnN>
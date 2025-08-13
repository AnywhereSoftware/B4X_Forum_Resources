###  [XUI] AS SegmentedTab by Alexander Stolte
### 03/19/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/126563/)

New year, new ASViews :)  
  
I spend a lot of time in creating views, like this and to create a high quality view cost a lot of time. If you want to support me and further views, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG) or with a [coffee](https://www.buymeacoffee.com/astolte). :)  
[SPOILER="Dependencies/Libraries you need for this view"]  
**B4j**: jXUI,JavaObject  
**B4a**: XUi,JavaObject  
**B4i**: iXUI  
[/SPOILER]  
  
![](https://www.b4x.com/android/forum/attachments/162747)  
![](https://www.b4x.com/android/forum/attachments/162748)  
  
![](https://www.b4x.com/android/forum/attachments/106906)  
**NEW** PaddingSelectionPanel - Picture Value: 5  
![](https://www.b4x.com/android/forum/attachments/114351)  
**NEW** ShowSeperators  
![](https://www.b4x.com/android/forum/attachments/114716)  
**Custom Tab Width Example**  
![](https://www.b4x.com/android/forum/attachments/147333)  
<https://www.b4x.com/android/forum/threads/b4x-as-segmentedtab-custom-tab-width.157090/>  
**AS\_SegmentedTab  
Author: Alexander Stolte  
Version: 2.00  
[SPOILER="Properties, Functions, Events, etc."][/SPOILER][SPOILER="Properties, Functions, Events, etc."][/SPOILER][SPOILER="Properties, Functions, Events, etc."][/SPOILER]**[SPOILER="Properties, Functions, Events, etc."]  

- **ASSegmentedTab**

- **Events:**

- **DisabledTabClicked** (xTab As ASSegmentedTab\_Tab)
- **TabChanged** (Index As Int)

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **AddTab** (Text As String, icon As B4XBitmap) As ASSegmentedTab\_Tab
- **AddTab2** (Text As String, icon As B4XBitmap, Value As Object) As ASSegmentedTab\_Tab
- **AddTabAdvanced** (xTab As ASSegmentedTab\_Tab) As ASSegmentedTab\_Tab
- **CreateASSegmentedTab\_DisabledTabProperties** (TextColor As Int, BackgroundColor As Int) As ASSegmentedTab\_DisabledTabProperties
- **CreateASSegmentedTab\_ItemTextProperties** (TextColor As Int, SelectedTextColor As Int, TextFont As B4XFont, TextAlignment\_Vertical As String, TextAlignment\_Horizontal As String, BackgroundColor As Int) As ASSegmentedTab\_ItemTextProperties
- **CreateASSegmentedTab\_SeperatorProperties** (Color As Int, Width As Float, HeightPercentage As Int, CornerRadius As Float) As ASSegmentedTab\_SeperatorProperties
- **CreateASSegmentedTab\_Tab** (Text As String, Icon As B4XBitmap, Value As Object, Enabled As Boolean, ItemTextProperties As ASSegmentedTab\_ItemTextProperties) As ASSegmentedTab\_Tab
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map)
*Base type must be Object*- **DisabledTabProperties** As ASSegmentedTab\_DisabledTabProperties
- **FontToBitmap** (text As String, IsMaterialIcons As Boolean, FontSize As Float, color As Int) As B4XBitmap
*<https://www.b4x.com/android/forum/threads/fontawesome-to-bitmap.95155/post-603250>*- **GetTab** (Index As Int) As ASSegmentedTab\_Tab
*Call RefreshTabs if you change something*- **GetValue** (Index As Int) As Object
- **Initialize** (Callback As Object, EventName As String)
- **RebuildTabs**
*Removes all tabs And adds them again*- **RefreshTabs**
- **RemoveTab** (Index As Int)
*Removes a tab at the specified index*- **RemoveTab2** (Value As Object)
*Removes a tab with the specified value*- **SelectedIndex** (index As Int, Duration As Int)
- **UpdateSeperators**

- **Properties:**

- **AutoDecreaseTextSize** As Boolean
*The text size is automatically adjusted to the space, if the text should not fit on one line  
 Default: False*- **BackgroundColor** As Int
- **BackgroundPanel** As B4XView [read only]
*the child panel of mBase*- **Base** As B4XView [read only]
- **CornerRadiusBackground** As Float [write only]
*changes the CornerRadius of the view*- **CornerRadiusSelectionPanel** As Float [write only]
*changes the CornerRadius of the selector*- **HapticFeedback** As Boolean
- **ImageHeight** As Float [write only]
- **Index** As Int
- **Index2** As Int [write only]
*Sets the index without the TabChanged Event*- **ItemTextProperties** As ASSegmentedTab\_ItemTextProperties [read only]
*change the properties before you add atab, then this settings will be change the on the next added tab  
 <code>ASSegmentedTab1.ItemTextProperties.TextFont = xui.CreateDefaultBoldFont(15)</code>*- **PaddingSelectionPanel** As Float [write only]
*set a distance from the corners for the selector*- **SelectionColor** As Int
- **SelectionPanel** As B4XView [read only]
*gets the selection panel - the panel that highlight the selected tab*- **SeperatorProperties** As ASSegmentedTab\_SeperatorProperties [read only]
- **SeperatorsHeight** As Float [read only]
- **ShowSeperators** As Boolean [write only]
- **Size** As Int [read only]
- **Theme** As ASSegmentedTab\_Theme [write only]
- **Theme\_Dark** As ASSegmentedTab\_Theme [read only]
- **Theme\_Light** As ASSegmentedTab\_Theme [read only]

[/SPOILER]  
**Changelog  
[SPOILER="Version 1.00-1.22"][/SPOILER][SPOILER="Version 1.0-1.22"][/SPOILER][SPOILER="Version 1.0-1.22"][/spoiler]**[SPOILER="Version 1.0-1.22"]  

- **1.00**

- Release

- **1.01**

- BugFix the selected tab is now keeping if the view is resizing

- **1.02**

- Adds getSelectionPanel - gets the selection panel - the panel that highlight a tab on click

- this is now possible:
- ![](https://www.b4x.com/android/forum/attachments/106906)

- Adds getBackgroundPanel - the child panel of mBase
- TabChanged is now only triggered on a new tab, if you click on the same tab, nothing happens

- **1.03**

- Adds getItemTextProperties - change the properties before you add atab, then this settings will be change the on the next added tab

- now you can add Material- or FontAwesome-Icons on the Text parameter

- **1.04 (**[**read more about this update**](https://www.b4x.com/android/forum/threads/b4x-xui-as-segmentedtab.126563/post-826710)**)**

- B4A and B4J - Corner Radius Fix
- Add DesignerProperty CornerRadiusBackground - changes the CornerRadius of the view
- Add DesignerProperty CornerRadiusSelectionPanel - changes the CornerRadius of the selector
- Add DesignerProperty PaddingSelectionPanel - set a distance from the corners for the selector

- ![](https://www.b4x.com/android/forum/attachments/114351)

- **1.05 (**[**read more about this update**](https://www.b4x.com/android/forum/threads/b4x-xui-as-segmentedtab.126563/post-828829)**)**

- Add Seperators - displays seperator items between non selected tabs

- Add Designer Property "ShowSeperators" - default: False
- Add UpdateSeperators - commit style changes
- Add get SeperatorProperties - change the properties and call UpdateSeperators
- ![](https://www.b4x.com/android/forum/attachments/114716)

- **1.06 (**[**read more about this update**](https://www.b4x.com/android/forum/threads/b4x-xui-as-segmentedtab.126563/post-842229)**)**

- Performance Improvements

- Seperators only added if ShowSeperators = True

- If you set the ShowSeperators = False then the seperators will be removed and vice versa

- Seperators - Add HeightPercentage - default:50% - 50% from the view height

- ASSegmentedTab1.SeperatorProperties.HeightPercentage = 50

- Seperators - Add CornerRadius - default:0 - set the corner radius of the seperators

- ASSegmentedTab2.SeperatorProperties.CornerRadius = ASSegmentedTab2.SeperatorProperties.Width/2'round seperators

- Add get SeperatorProperties - gets the seperators height
- B4J and B4I Resize BugFixes
- Add set ImageHeight - sets the image Height/Width

- **1.07**

- BugFix - SelectedIndex the index was not set
- Add set Index - change the index without animation, do the same as SelectedIndex(1,0)

- **1.08**

- BugFix - get Index

- **1.09**

- BugFix - The new index at getIndex was assigned only after the TabChanged event

- **1.10**

- BugFix - SelectedIndex the PaddingSelectionPanel is now observed with

- **1.11** [**(read more about this update)**](https://www.b4x.com/android/forum/threads/b4x-xui-as-segmentedtab.126563/post-869081)

- Add get and set AutoDecreaseTextSize - The text size is automatically adjusted to the space, if the text should not fit on one line

- **1.12**

- Add GetTab - Gets the tab text, icon and the text properties
- Add RefreshTab - If you change something on the tab, then call this

- **1.13**

- Add Designer Porperty TabBackgroundColor
- Add Designer Porperty SelectionColor
- Add Designer Porperty SeperatorColor
- Add Designer Porperty TextColor

- **1.14**

- Designer Properties are now converted into dip

- **1.15 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-segmentedtab.126563/post-937630)**)**

- Add AddTab2
- Add GetValue
- Add Value to Type ASSegmentedTab\_Tab

- **1.16**

- Add Designer Property SelectionTextColor
- Add SelectionTextColor to Type ASSegmentedTab\_ItemTextProperties

- **1.17**

- BugFix

- **1.18**

- Add get Size - Number of tabs

- **1.19 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-segmentedtab.126563/post-964455)**)**

- Add AddTabAdvanced - Add a tab with the ASSegmentedTab\_Tab type
- Add Width to the ASSegmentedTab\_Tab type

- It's a optional tab property
- If 0, then the width of the tab is calculated automatically
- Default: 0

- **1.20**

- B4J BugFix

- **1.21**

- AutoDecreaseTextSize BugFix

- **1.22**

- Add set Index2 - Sets the index without the TabChanged Event

[/SPOILER]  

- **2.00 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-segmentedtab.126563/post-1019163)**)**

- BugFixes and Improvements
- New RemoveTab and RemoveTab2
- New get and set BackgroundColor
- New get and set SelectionColor
- New RebuildTabs - Removes all tabs And adds them again
- New "Enabled" to ASSegmentedTab\_Tab type

- please check if enabled = true is set when using AddTabAdvanced

- New Event DisabledTabClicked - Is triggered when the user clicks on a deactivated tab
- New Designer Property HapticFeedback

- Default: False

- New Themes - You can now switch to Light or Dark mode
- New set Theme
- New get Theme\_Dark
- New get Theme\_Light
- New Designer Property ThemeChangeTransition

- Default: None

**Github:** [github.com/StolteX/AS\_SegmentedTab](https://github.com/StolteX/AS_SegmentedTab)  
  
Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)
###  [XUI] AS ScrollingChips based on xCustomListView - Display your Hashtags or Categories by Alexander Stolte
### 06/03/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/123425/)

I removed the old code and took the code from the [AS\_Chips](https://www.b4x.com/android/forum/threads/b4x-xui-as-chips-display-your-hashtags-filters-or-categories.139896/) to make this view even better.  
  
I spend a lot of time in creating views, like this and to create a high quality view cost a lot of time. If you want to support me and further views, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG). :)  
  
Without scroll alternative:  
<https://www.b4x.com/android/forum/threads/b4x-xui-as-chips-display-your-hashtags-filters-or-categories.139896/>  
  
[SPOILER="Dependencies/Libraries you need for this view"]  
**B4j**: jXUI,xCustomListView  
**B4a**: XUi,xCustomListView  
**B4i**: iXUI,xCustomListView  
[/SPOILER]  
![](https://www.b4x.com/android/forum/attachments/141357)![](https://www.b4x.com/android/forum/attachments/141358)  
**AS\_ScrollingChips  
Author: Alexander Stolte  
Version: 2.00  
[SPOILER="Properties, Functions, Events, etc."][/SPOILER][SPOILER="Properties, Functions, Events, etc."][/SPOILER]**[SPOILER="Properties, Functions, Events, etc."]  

- **ASScrollingChips\_Chip**

- **Fields:**

- **Icon** As B4XBitmap
- **Index** As Int
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **Tag** As Object
- **Text** As String

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASScrollingChips\_ChipProperties**

- **Fields:**

- **BackgroundColor** As Int
- **BorderSize** As Float
- **CornerRadius** As Float
- **Height** As Float
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **TextColor** As Int
- **TextGap** As Float
- **xFont** As B4XFont

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASScrollingChips\_CustomDraw**

- **Fields:**

- **Chip** As ASScrollingChips\_Chip
- **ChipProperties** As ASScrollingChips\_ChipProperties
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **Views** As ASScrollingChips\_Views

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASScrollingChips\_RemoveIconProperties**

- **Fields:**

- **BackgroundColor** As Int
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **TextColor** As Int

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASScrollingChips\_Views**

- **Fields:**

- **BackgroundPanel** As B4XView
- **IconImageView** As B4XView
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **RemoveIconLabel** As B4XView
- **TextLabel** As B4XView

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **AS\_ScrollingChips**

- **Events:**

- **ChipClick** (Chip As ASScrollingChips\_Chip)
- **ChipLongClick** (Chip As ASScrollingChips\_Chip)
- **ChipRemoved** (Chip As ASScrollingChips\_Chip)
- **CustomDrawChip** (Item As ASScrollingChips\_CustomDraw)

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **AddChip** (Text As String, Icon As B4XBitmap, xTag As Object) As String
- **AddChip2** (Text As String, Icon As B4XBitmap, ChipColor As Int, xTag As Object) As String
- **Class\_Globals** As String
- **Clear** As String
- **CreateASScrollingChips\_ChipProperties** (Height As Float, BackgroundColor As Int, TextColor As Int, xFont As B4XFont, CornerRadius As Float, BorderSize As Float, TextGap As Float) As ASScrollingChips\_ChipProperties
- **CreateASScrollingChips\_CustomDraw** (Chip As ASScrollingChips\_Chip, ChipProperties As ASScrollingChips\_ChipProperties, Views As ASScrollingChips\_Views) As ASScrollingChips\_CustomDraw
- **CreateASScrollingChips\_RemoveIconProperties** (BackgroundColor As Int, TextColor As Int) As ASScrollingChips\_RemoveIconProperties
- **CreateASScrollingChips\_Views** (BackgroundPanel As B4XView, TextLabel As B4XView, IconImageView As B4XView, RemoveIconLabel As B4XView) As ASScrollingChips\_Views
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **FontToBitmap** (text As String, IsMaterialIcons As Boolean, FontSize As Float, color As Int) As B4XBitmap
*<https://www.b4x.com/android/forum/threads/fontawesome-to-bitmap.95155/post-603250>*- **GetBackgroundAt** (index As Int) As B4XView
- **getBackgroundColor** As Int
*Call RefreshChips if you change something*- **GetChip** (Index As Int) As ASScrollingChips\_Chip
- **GetChipProperties** (Index As Int) As ASScrollingChips\_ChipProperties
- **getChipPropertiesGlobal** As ASScrollingChips\_ChipProperties
*Can only influence the appearance before the respective chip has been added*- **getCLV** As b4j.example.customlistview
- **getGapBetween** As Float
- **GetLabelAt** (index As Int) As B4XView
- **getRemoveIconProperties** As ASScrollingChips\_RemoveIconProperties
*Call RefreshChips if you change something*- **getRound** As Boolean
- **getShowRemoveIcon** As Boolean
- **getSize** As Int
- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **RefreshChips** As String
- **RemoveChip** (Index As Int) As String
- **setBackgroundColor** (Color As Int) As String
- **SetChipProperties** (Index As Int, Properties As ASScrollingChips\_ChipProperties) As String
*Call RefreshChips if you change something*- **setGapBetween** (Gap As Float) As String
- **setRound** (isRound As Boolean) As String
*Call RefreshChips if you change something*- **setShowRemoveIcon** (Show As Boolean) As String

- **Properties:**

- **BackgroundColor** As Int
*Call RefreshChips if you change something*- **ChipPropertiesGlobal** As ASScrollingChips\_ChipProperties [read only]
*Can only influence the appearance before the respective chip has been added*- **CLV** As b4j.example.customlistview [read only]
- **GapBetween** As Float
- **RemoveIconProperties** As ASScrollingChips\_RemoveIconProperties [read only]
*Call RefreshChips if you change something*- **Round** As Boolean
*Call RefreshChips if you change something*- **ShowRemoveIcon** As Boolean
- **Size** As Int [read only]

[/SPOILER]  
**Changelog  
[SPOILER="Version 1.00-2.08"][/SPOILER][SPOILER="Version 1.0-2.08"][/SPOILER][SPOILER="Version 1.0-2.08"][/spoiler]**[SPOILER="Version 1.0-2.08"]  

- **1.00**

- Release

- **1.01**

- BugFix - labels with different heights

- **2.00**

- Complete new development
- Now works like AS\_Chips

- **2.01 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-scrollingchips-based-on-xcustomlistview-display-your-hashtags-or-categories.123425/post-966019)**)**

- Add Designer Property SelectionMode - An integrated selection system

- Modes

- None
- Single
- Multi

- Default: None

- Add Designer Property CanDeselect - If true, then the user can remove the selection by clicking again

- Default: True

- Add set Selection
- Add ClearSelections
- Add get Selections
- Add Width to ASScrollingChips\_ChipProperties - If > 0 then this value is used instead of the calculated value by the text
- Add AddChipCustom
- Add CopyChipPropertiesGlobal
- Add RefreshProperties - Updates just the font and colors

- **2.02**

- Property SelectionColor renamed to SelectionBorderColor
- Add Designer Property SelectionBackgroundColor

- Default: Transparent

- **2.03**

- BugFix

- **2.04 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-scrollingchips-based-on-xcustomlistview-display-your-hashtags-or-categories.123425/post-968168)**)**

- BugFixes
- Add Designer Proeprty Alignment - IF center then a stub item are added left and right so the chips looks centered

- Default: Left

- **2.05**

- Add Designer Property SelectionTextColor

- Default: White

- Add SetSelections

- **2.06**

- Add SetSelections2 - Set the selected items via a list of indexes
- Add SetSelections3 - Set the selected items via a map of chip tags

- **2.07**

- BugFix
- Add get and set MaxSelectionCount - Only in SelectionMode = Multi - Defines the maximum number of items that may be selected

- Default: 0

- **2.08**

- BugFix on get Size - Has returned an incorrect value

[/SPOILER]  

- **2.09**

- BugFixes

- **2.10**

- New GetChip2 - Get the chip via the tag value of the item

- **2.11**

- BugFix - The chips are now resized when you call RefreshChips, if you change text etc.

- **2.12**

- New - ShowRemoveIcon added to ASScrollingChips\_ChipProperties type
- New - xFont and Icon added to ASScrollingChips\_RemoveIconProperties type
- New - GetChipProperties2 Get the chip props via the tag value of the item
- New - RemoveChipClicked Event - if the event is used, automatic deletion is deactivated

**Github:** [github.com/StolteX/AS\_ScrollingChips](https://github.com/StolteX/AS_ScrollingChips)  
  
Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)
###  [XUI] AS Chips - Display your Hashtags, Filters or Categories by Alexander Stolte
### 02/03/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/139896/)

With this view you can display and interact with your hashtags, filters or categories. The view can expand itself if more chips are added than there is space for. (AutoExpand = True)  
  
I spend a lot of time in creating views, like this and to create a high quality view cost a lot of time. If you want to support me and further views, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG) or with a [coffee](https://www.buymeacoffee.com/astolte). :)  
  
Scrolling alternative:  
<https://www.b4x.com/android/forum/threads/b4x-xui-as-scrollingchips-based-on-xcustomlistview-display-your-hashtags-or-categories.123425/#content>  
  
![](https://www.b4x.com/android/forum/attachments/127920)![](https://www.b4x.com/android/forum/attachments/127921)  
[MEDIA=youtube]FkFZjbkLvaI[/MEDIA]  
  
**ASChips  
Author: Alexander Stolte  
Version: 1.00**  

- **ASChips\_Chip**

- **Fields:**

- **Icon** As B4XBitmap
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **Tag** As Object
- **Text** As String

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASChips\_ChipProperties**

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
- **ASChips\_RemoveIconProperties**

- **Fields:**

- **BackgroundColor** As Int
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **TextColor** As Int

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **AS\_Chips**

- **Events:**

- **ChipClick** (Chip As ASChips\_Chip)
- **ChipLongClick** (Chip As ASChips\_Chip)
- **ChipRemoved** (Chip As ASChips\_Chip)
- **HeightChanged** (Height As Float)
- **HiddenChipsClicked** (ListChips As List)

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **AddChip** (Text As String, Icon As B4XBitmap, xTag As Object) As String
- **Class\_Globals** As String
- **CreateASChips\_ChipProperties** (Height As Float, BackgroundColor As Int, TextColor As Int, xFont As B4XFont, CornerRadius As Float, BorderSize As Float, TextGap As Float) As ASChips\_ChipProperties
- **CreateASChips\_RemoveIconProperties** (BackgroundColor As Int, TextColor As Int) As ASChips\_RemoveIconProperties
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **FontToBitmap** (text As String, IsMaterialIcons As Boolean, FontSize As Float, color As Int) As B4XBitmap
*<https://www.b4x.com/android/forum/threads/fontawesome-to-bitmap.95155/post-603250>*- **getAutoExpand** As Boolean
- **GetChip** (Index As Int) As ASChips\_Chip
- **GetChipProperties** (Index As Int) As ASChips\_ChipProperties
- **getChipPropertiesGlobal** As ASChips\_ChipProperties
*Can only influence the appearance before the respective chip has been added*- **getRemoveIconProperties** As ASChips\_RemoveIconProperties
*Call RefreshChips if you change something*- **getShowRemoveIcon** As Boolean
- **getSize** As Int
- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **RefreshChips** As String
- **RemoveChip** (Index As Int) As String
- **setAutoExpand** (Expand As Boolean) As String
- **SetChipProperties** (Index As Int, Properties As ASChips\_ChipProperties) As String
*Call RefreshChips if you change something*- **setShowRemoveIcon** (Show As Boolean) As String

- **Properties:**

- **AutoExpand** As Boolean
- **ChipPropertiesGlobal** As ASChips\_ChipProperties [read only]
*Can only influence the appearance before the respective chip has been added*- **RemoveIconProperties** As ASChips\_RemoveIconProperties [read only]
*Call RefreshChips if you change something*- **ShowRemoveIcon** As Boolean
- **Size** As Int [read only]

**Changelog**  

- **1.00**

- Release

- **1.01**

- Add some properties

- **1.02**

- Add AddChip2 - with one more parameter

- ChipColor

- **1.03**

- Add Clear - removes all chips
- Add get and set GapBetween

- **1.04 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-chips-display-your-hashtags-filters-or-categories.139896/post-904255)**)**

- Add Event CustomDrawChip
- Add Event EmptyAreaClick

- **1.05**

- Add Index to ASChips\_Chip Type

- **1.06**

- Add get and set TopGap - Gap between items vertical

- Default: 5dip

- **1.07**

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
- Add CopyChipPropertiesGlobal
- Add RefreshProperties - Updates just the font and colors
- Add Designer Property SelectionBackgroundColor

- Default: Transparent

- **1.08**

- BugFix

- **1.09**

- Add Designer Property SelectionTextColor

- Default: White

- Add SetSelections

- **1.10**

- BugFixes

- **1.11**

- Add SetSelections2 - Set the selected items via a list of indexes
- Add SetSelections3 - Set the selected items via a map of chip tags

- **1.12**

- BugFixes
- Add get and set MaxSelectionCount - Only in SelectionMode = Multi - Defines the maximum number of items that may be selected

- Default: 0

- **1.13**

- Add GetLabelAt - Gets the chip text label
- Add GetBackgroundAt - Gets the chip background panel

**Github:** [github.com/StolteX/AS\_Chips](https://github.com/StolteX/AS_Chips)  
  
Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)
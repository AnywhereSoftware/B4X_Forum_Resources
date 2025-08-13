###  [XUI] AS SelectionList - Single or multiple selection by Alexander Stolte
### 05/26/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/164050/)

This view makes it easy to quickly provide a good looking single or multiple selection list.  
  
I spend a lot of time in creating views, like this and to create a high quality view cost a lot of time. If you want to support me and further views, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG) or with a [coffee](https://www.buymeacoffee.com/astolte). :)  
  
![](https://www.b4x.com/android/forum/attachments/158487) ![](https://www.b4x.com/android/forum/attachments/158488)  
  
**Examples**  

```B4X
    For i = 0 To 80 -1  
        AS_SelectionList1.AddItem("Test " & (i+1),Null,i)  
    Next
```

  
**Search**  
There is a built-in search that makes it easy to search for something while maintaining the selection.  

```B4X
AS_SelectionList1.SearchByText("Test")
```

  
Search with the value that was passed in the “Value” parameter when the item was added  

```B4X
AS_SelectionList1.SearchByValue(3)
```

  
**Theming**  

```B4X
    AS_SelectionList1.Theme = AS_SelectionList1.Theme_Light  
    AS_SelectionList1.Theme = AS_SelectionList1.Theme_Dark
```

  
**Get Selection**  

```B4X
Private Sub AS_SelectionList1_SelectionChanged  
   
    For Each Item As AS_SelectionList_Item In AS_SelectionList1.GetSelections  
        Log("Item selected: " & Item.Text)  
    Next  
  
End Sub
```

  
**SubItems**  

```B4X
    Dim RootItem2 As AS_SelectionList_Item = AS_SelectionList1.AddItem("Car", AS_SelectionList1.FontToBitmap(Chr(0xF179),False,30,xui.Color_White), "Car")  
    AS_SelectionList1.AddSubItem(RootItem2, "Steering Wheel", AS_SelectionList1.FontToBitmap(Chr(0xF179),False,30,xui.Color_White), "Steeringwheel")  
    AS_SelectionList1.AddSubItem(RootItem2, "Air Conditioning", AS_SelectionList1.FontToBitmap(Chr(0xF179),False,30,xui.Color_White), "Climate")  
    AS_SelectionList1.AddSubItem(RootItem2, "Rearview Mirror", AS_SelectionList1.FontToBitmap(Chr(0xF179),False,30,xui.Color_White), "BackMirror")  
    AS_SelectionList1.AddSubItem(RootItem2, "Side Mirror", AS_SelectionList1.FontToBitmap(Chr(0xF179),False,30,xui.Color_White), "SideMirror")
```

  
![](https://www.b4x.com/android/forum/attachments/159763) [MEDIA=youtube]f9mlc63dcl4[/MEDIA]  
  
**BottomSelectionList**  
<https://www.b4x.com/android/forum/threads/b4x-xui-as-bottomselectionlist.164319/>  
![](https://www.b4x.com/android/forum/attachments/159764)  
  
**AS\_SelectionList  
Author: Alexander Stolte  
Version: 2.00  
[SPOILER="Properties, Functions, Events, etc."][/SPOILER][SPOILER="Properties, Functions, Events, etc."][/SPOILER]**[SPOILER="Properties, Functions, Events, etc."]  

- **AS\_SelectionList**

- **Events:**

- **SelectionChanged**

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **AddItem** (Text As String, Icon As B4XBitmap, Value As Object) As AS\_SelectionList\_Item
- **AddSubItem** (RootItem As AS\_SelectionList\_Item, Text As String, Icon As B4XBitmap, Value As Object) As AS\_SelectionList\_SubItem
- **Base\_Resize** (Width As Double, Height As Double)
- **Clear**
- **ClearSearch**
- **ClearSelections**
- **CloseSubMenu**
- **CreateViewPerCode** (Parent As B4XView, Left As Float, Top As Float, Width As Float, Height As Float)
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map)
*Base type must be Object*- **FontToBitmap** (text As String, IsMaterialIcons As Boolean, FontSize As Float, color As Int) As B4XBitmap
*<https://www.b4x.com/android/forum/threads/fontawesome-to-bitmap.95155/post-603250>*- **GetItems** As List
*Get all items as list of AS\_SelectionList\_Item*- **GetSelections** As List
*<code>  
 For Each Item As Object In AS\_SelectionList1.GetSelections  
 Log("Item selected: " & Item.Text)  
 Next  
 </code>*- **Initialize** (Callback As Object, EventName As String)
- **RebuildList**
- **SearchByText** (Text As String)
- **SearchByValue** (Value As Object)
- **SetSelections** (Values As Object)
*<code>AS\_SelectionList1.SetSelections(Array As Object(1,3))</code>*- **SetSelections2** (Values As List)
*<code>  
 Dim lst As List  
 lst.Initialize  
 lst.Add(1)  
 lst.Add(3)  
 AS\_SelectionList1.SetSelections2(lst)  
 </code>*
- **Properties:**

- **BackgroundColor** As Int
- **CornerRadius** As Float
- **HapticFeedback** As Boolean
- **ItemProperties** As AS\_SelectionList\_ItemProperties [read only]
*Height: Default: 50dip*- **MaxSelectionCount** As Int
*Only in SelectionMode = Multi - Defines the maximum number of items that may be selected  
 Default: 0*- **RootItemClickBehavior** As String
*<code>AS\_SelectionList1.RootItemClickBehavior = AS\_SelectionList1.RootItemClickBehavior\_CloseSubMenu</code>*- **RootItemClickBehavior\_CloseSubMenu** As String [read only]
- **RootItemClickBehavior\_SelectAllSubItems** As String [read only]
*Takes into account the SelectionMode and MaxSelectionCount*- **RootItemClickBehavior\_SelectRootItem** As String [read only]
- **SelectedItemProperties** As AS\_SelectionList\_SelectedItemProperties [read only]
- **SelectedSubItemPropertiess** As AS\_SelectionList\_SelectedSubItemProperties [read only]
- **SelectionMode** As String
*Single or Multi*- **SelectionMode\_Multi** As String [read only]
- **SelectionMode\_Single** As String [read only]
- **SeperatorWidth\_BeginWithIcon** As String [read only]
- **SeperatorWidth\_BeginWithText** As String [read only]
- **SeperatorWidth\_FullWidth** As String [read only]
- **SideGap** As Float
*Default: 10dip*- **Size** As Int [read only]
- **SubItemProperties** As AS\_SelectionList\_SubItemProperties [read only]
*Height: Default: 50dip*- **Theme** As AS\_SelectionList\_Theme [write only]
- **Theme\_Dark** As AS\_SelectionList\_Theme [read only]
- **Theme\_Light** As AS\_SelectionList\_Theme [read only]
- **ThemeChangeTransition** As String
*Fade or None*- **ThemeChangeTransition\_Fade** As String [read only]
- **ThemeChangeTransition\_None** As String [read only]

[/SPOILER]  
**Changelog  
[SPOILER="Version 1.00-1.06"][/SPOILER][SPOILER="Version 1.0-1.06"][/SPOILER][SPOILER="Version 1.0-1.06"][/spoiler]**[SPOILER="Version 1.0-1.06"]  

- **1.00**

- Release

- **1.01**

- BugFixes
- Add get and set MaxSelectionCount - Only in SelectionMode = Multi - Defines the maximum number of items that may be selected

- Default: 0

- **1.02**

- Add Designer Property HapticFeedback

- Default: True

- BugFix on SearchByText - No longer takes capitalization into account

- **1.03**

- BugFixes and Improvemets
- Add Clear
- Add RebuildList
- Add CreateViewPerCode
- Add "Height" to AS\_SelectionList\_ItemProperties Type

- **1.04**

- BugFixes

- **1.05**

- Add GetItems - Get all items as list of AS\_SelectionList\_Item

- **1.06 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-selectionlist-single-or-multiple-selection.164050/post-1008104)**)**

- Add SetSelections2 - Set the Selections via a list
- Add Type AS\_SelectionList\_SelectedItemProperties

- Per Default the same settings as the AS\_SelectionList\_ItemProperties

- Add get and set SideGap

- Default: 10dip

- Add Desginer Property SeperatorWidth

- Default: BeginWithText
- BeginWithText - The separator begins where the text begins
- FullWidth - Full width
- BeginWithIcon - The separator starts where the icon begins, if there is no icon, then where the text begins

[/SPOILER]  

- **2.00 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-selectionlist-single-or-multiple-selection.164050/post-1009256)**)**

- BugFixes and Improvements
- Add AddSubItem
- Add Designer Property RootItemClickBehavior - What should happen if you click on the root item when the sub menu is open

- Default: CloseSubMenu

- Add Type AS\_SelectionList\_SubItem
- Add Type AS\_SelectionList\_SubItemProperties
- Add Type AS\_SelectionList\_SelectedSubItemProperties
- Add get and set CornerRadius - First and Last Item corner radius

- **2.01**

- Search BugFix

- **2.02 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-selectionlist-single-or-multiple-selection.164050/post-1009932)**)**

- New SelectionIconAlignment - Alignment of the check icon of an item when it is selected

- Default: Right
- Left or Right

- New Designer Property SelectionIconAlignment

- Default: Right

- New get and set ShowSeperators

- **2.03 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-selectionlist-single-or-multiple-selection.164050/post-1010592)**)**

- New RefreshList - Removes the layout of the items and rebuilds the layout
- New Designer Property SearchTextHighlightedColor - The text color of the searched text when searching for something via SearchByText

- Default: Red

- New EmptyListTextLabel - Text that is displayed in the middle of the view if the list is empty, e.g. in a search if no items match the search
- New get EmptyListTextLabel
- New get and set EmptyListText
- New get and set EmptySearchListText
- New get and set EmptyListTextVisibility - If False then no Empty list text is displayed

- Default: True

- New CustomDrawItem Event
- New AS\_SelectionList\_CustomDrawItemViews Type
- New AddItem2 - Adding an item with AS\_SelectionList\_Item parameter
- Update Base\_Resize - if the width changes, the items are recreated
- Change The ItemText is now based on BBLabel

- **2.04 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-selectionlist-single-or-multiple-selection.164050/post-1011675)**)**

- New SelectionItemChanged Event - In the event, the item that was checked/unchecked is returned in order to be able to react better instead of always having to go through the complete selected item list

- **2.05 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-selectionlist-single-or-multiple-selection.164050/post-1012077)**)**

- New DeselectItem - Deselect by AS\_SelectionList\_Item or AS\_SelectionList\_SubItem
- New DeselectItem2 - Deselect by Value

- **2.06**

- BugFix subitems list height is now maximum as high as the space below

- **2.07**

- BugFix highlight text sometimes causes crashes

- **2.08**

- New AS\_SelectionList\_CheckItemProperties Type
- New get CheckItemProperties

- **2.09**

- BugFixes - Thanks to [USER=102955]@Peter Meares[/USER]

- **2.10**

- BugFix - SelectionChanged is now also triggered when you deselect items using code
- New SelectAll - Selects all items + subitems

**Github:** [github.com/StolteX/AS\_SelectionList](https://github.com/StolteX/AS_SelectionList)  
  
Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)
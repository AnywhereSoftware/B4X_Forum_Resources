###  [XUI] AS BottomSelectionList by Alexander Stolte
### 01/13/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/164319/)

This view makes it easy to quickly provide a good looking single or multiple selection list, based on the [AS\_SelectionList](https://www.b4x.com/android/forum/threads/b4x-xui-as-selectionlist-single-or-multiple-selection.164050/), built into a ready to use bottom menu.  
  
You need:  

- [AS\_DraggableBottomCard](https://www.b4x.com/android/forum/threads/b4x-xui-as-draggable-bottom-card.121219/) **V1.14+**
- [AS\_SelectionList](https://www.b4x.com/android/forum/threads/b4x-xui-as-selectionlist-single-or-multiple-selection.164050/) **V1.05+**

I spend a lot of time in creating views, like this and to create a high quality view cost a lot of time. If you want to support me and further views, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG) or with a [coffee](https://www.buymeacoffee.com/astolte). :)  
  
![](https://www.b4x.com/android/forum/attachments/158948) ![](https://www.b4x.com/android/forum/attachments/158949)  

```B4X
Private Sub OpenSheet(DarkMode As Boolean)  
    BottomSelectionList.Initialize(Me,"BottomSelectionList",Root)  
   
    BottomSelectionList.Theme = IIf(DarkMode,BottomSelectionList.Theme_Dark,BottomSelectionList.Theme_Light)  
    BottomSelectionList.ActionButtonVisible = True  
  
    For i = 0 To 20 -1  
        BottomSelectionList.AddItem("Test " & i,Null,i)  
    Next  
   
    BottomSelectionList.ShowPicker  
   
    BottomSelectionList.ActionButton.Text = "Confirm"  
   
End Sub
```

  
**Events**  

```B4X
Private Sub BottomSelectionList_SelectionChanged  
   
    For Each Item As AS_SelectionList_Item In BottomSelectionList.GetSelections  
        Log("SelectionChanged: " & Item.Text)  
    Next  
  
End Sub
```

  

```B4X
Private Sub BottomSelectionList_ActionButtonClicked  
    Log("ActionButtonClicked")  
    BottomSelectionList.HidePicker  
End Sub
```

  
**SelectionMode**  
You can change the selection mode from single to multi  

```B4X
BottomSelectionList.SelectionMode = BottomSelectionList.SelectionMode_Multi
```

  

```B4X
BottomSelectionList.SelectionMode = BottomSelectionList.SelectionMode_Single
```

  
**MaxVisibleItems**  
The maximum number of items that are visible before it becomes a list and must be scrolled.  
Default: 5  

```B4X
BottomSelectionList.MaxVisibleItems = 5
```

  
  
**AS\_BottomSelectionList  
Author: Alexander Stolte  
Version: 1.00  
[SPOILER="Properties, Functions, Events, etc."][/SPOILER][SPOILER="Properties, Functions, Events, etc."][/SPOILER]**[SPOILER="Properties, Functions, Events, etc."]  

- **AS\_BottomActionSheet\_Theme**

- **Fields:**

- **ActionButtonBackgroundColor** As Int
- **ActionButtonTextColor** As Int
- **BodyColor** As Int
- **DragIndicatorColor** As Int
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **SelectionList** As b4j.example.as\_selectionlist.\_as\_selectionlist\_theme
- **TextColor** As Int

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **AS\_BottomSelectionList**

- **Events:**

- **ActionButtonClicked**
- **Close**
- **SelectionChanged**

- **Fields:**

- **Tag** As Object

- **Functions:**

- **AddItem** (Text As String, Icon As B4XBitmap, Value As Object) As b4j.example.as\_selectionlist.\_as\_selectionlist\_item
- **Class\_Globals** As String
- **Clear** As String
- **FontToBitmap** (text As String, IsMaterialIcons As Boolean, FontSize As Float, color As Int) As B4XBitmap
*<https://www.b4x.com/android/forum/threads/fontawesome-to-bitmap.95155/post-603250>*- **getActionButton** As B4XView
- **getActionButtonVisible** As Boolean
- **getColor** As Int
- **getDragIndicatorColor** As Int
- **getMaxVisibleItems** As Int
- **getSelectionList** As b4j.example.as\_selectionlist
- **getSelectionMode** As String
*Single or Multi*- **getSelectionMode\_Multi** As String
- **getSelectionMode\_Single** As String
- **GetSelections** As List
*<code>  
 For Each Item As AS\_SelectionList\_Item In BottomSelectionList.GetSelections  
 Log("Item selected: " & Item.Text)  
 Next  
 </code>*- **getSheetWidth** As Float
- **getSize** As Int
*Get the number of items*- **getTheme\_Dark** As AS\_BottomActionSheet\_Theme
- **getTheme\_Light** As AS\_BottomActionSheet\_Theme
- **getThemeChangeTransition** As String
- **getThemeChangeTransition\_Fade** As String
- **getThemeChangeTransition\_None** As String
- **HidePicker** As String
- **Initialize** (Callback As Object, EventName As String, Parent As B4XView) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **setActionButtonVisible** (Visible As Boolean) As String
- **setColor** (Color As Int) As String
- **setDragIndicatorColor** (Color As Int) As String
- **setMaxVisibleItems** (MaxVisibleItems As Int) As String
*The maximum number of items that are visible before it becomes a list and must be scrolled  
 Default: 5*- **setSelectionMode** (SelectionMode As String) As String
- **SetSelections** (Values As Object()) As String
*<code>BottomSelectionList.SetSelections(Array As Object(1,3))</code>*- **setSheetWidth** (SheetWidth As Float) As String
*Set the value to greater than 0 to set a custom width  
 Set the value to 0 to use the full screen width  
 Default: 0*- **setTheme** (Theme As AS\_BottomActionSheet\_Theme) As String
- **setThemeChangeTransition** (ThemeChangeTransition As String) As String
*Fade or None*- **ShowPicker**

- **Properties:**

- **ActionButton** As B4XView [read only]
- **ActionButtonVisible** As Boolean
- **Color** As Int
- **DragIndicatorColor** As Int
- **MaxVisibleItems** As Int
*The maximum number of items that are visible before it becomes a list and must be scrolled  
 Default: 5*- **SelectionList** As b4j.example.as\_selectionlist [read only]
- **SelectionMode** As String
*Single or Multi*- **SelectionMode\_Multi** As String [read only]
- **SelectionMode\_Single** As String [read only]
- **SheetWidth** As Float
*Set the value to greater than 0 to set a custom width  
 Set the value to 0 to use the full screen width  
 Default: 0*- **Size** As Int [read only]
*Get the number of items*- **Theme**
- **Theme\_Dark** As AS\_BottomActionSheet\_Theme [read only]
- **Theme\_Light** As AS\_BottomActionSheet\_Theme [read only]
- **ThemeChangeTransition** As String
*Fade or None*- **ThemeChangeTransition\_Fade** As String [read only]
- **ThemeChangeTransition\_None** As String [read only]

[/SPOILER]  
**Changelog**  

- **1.00**

- Release

- **1.01**

- BugFixes
- Add GetItems - Get all items as list of AS\_SelectionList\_Item

- **1.02**

- Improvements
- Add SetSelections2 - Set the Selections via a list
- Add get and set SideGap

- Default: 10dip

- Add get SelectedItemProperties
- Add get ItemProperties

- **1.03**

- New SelectionIconAlignment - Alignment of the check icon of an item when it is selected

- Default: Right
- Left or Right

- New - get and set ShowSeperators
- Update - If you set MaxVisibleItems to 0 then no limit is now set

- **1.04**

- New SelectionItemChanged Event - In the event, the item that was checked/unchecked is returned in order to be able to react better instead of always having to go through the complete selected item list

- **1.05**

- New DeselectItem - Deselect by AS\_SelectionList\_Item or AS\_SelectionList\_SubItem
- New DeselectItem2 - Deselect by Value

Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)
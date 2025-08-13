###  [XUI] [B4XLib] B4XMenuPlus by Gfy
### 10/09/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/163335/)

Extension for B4XPages menu. Replacing B4XPages.AddMenuItem().  
  
When a menu item is selected, an event ( **EventName\_Tag()** ) is triggered.  
  
New features are added:  

- Add text item, checkbox, toogle or submenu on 3dot menu.
- Add separator on 3dot menu. (two consecutive separators are not allowed and automatic suppressed ) (separator are not clickable)
- Icons/Bitmaps can be displayed on the bar. Icons are created by FONTAWESOME and MATERIALICONS. Icon/bitmaps can also be toggle elements.
- All items can be set enabled/disabled (gray out)
- All items can be set visible/hidden.
- All 3dot items can have also a icon.
- Checkbox item. When selected, the status changes and the event is called with **EventName\_Tag( Checked )**.
- Toggle item. 1 to x rotating states possible. All elements of a toggle have the same Tag, but can have different icons. When selected, the state rotates to the next position and the event is called with **EventName\_Tag( State )**. The state is 0 based.
- Submenu. Multi level submenus can be created. These can also contain checkbox and/or toggle elements.
For all instances using submenu, add this lines in Main:

```B4X
Sub Activity_WindowFocusChanged (Focused As Boolean)  
    If B4XPages.[page].[B4XMenuPlus].IsInitialized Then B4XPages.[page].[B4XMenuPlus].WindowFocusChanged( Focused )  
End Sub
```

- All interaction based on the item Tag.

Code Example:  

```B4X
Private mp As B4XMenuPlus  
  
mp.Initialize( Me, Root, "MenuClick" )  
mp.AddItem( "Test", "Test Menu Item" )  
mp.ShowMenu  
  
Private Sub B4XPage_MenuClick( Tag As String )  
   mp.MenuClick( Tag )  
  
End Sub  
  
Private Sub MenuClick_Test()  
    …  
End Sub
```

  
  
> Remark:  
> The Tag and Title should be unique, to avoid collisions between multiple menus on the same page.

  
A method returns True or a value.  
If False or -1, there is an error. This can be determined using **Error()** :  
  
0 - ERROR\_NO\_ERROR  
-1 - ERROR\_TITLE\_NOT\_FOUND  
-2 - ERROR\_TAG\_NOT\_FOUND  
-3 - ERROR\_ITEM\_NOT\_CHECK  
-4 - ERROR\_ITEM\_NOT\_TOGGLE  
-5 - ERROR\_PARENTTAG\_NOT\_FOUND  
-6 - ERROR\_PARENTTAG\_NOT\_SUBMENU  
-7 - ERROR\_WRONG\_MENU\_TYPE  
-8 - ERROR\_ITEM\_WRONG\_TYPE  
-9 - ERROR\_STATE\_OUT\_OF\_RANGE  
-10 - ERROR\_ITEM\_IS\_DISABLED  
-11 - ERROR\_MENU\_NOT\_ACTIVE  
-12 - ERROR\_CALLBACK\_NOT\_FOUND  
-13 - ERROR\_ITEM\_WITHOUT\_ICON  
  
> In debug mode all errors are output via log.  
>   
> Format: **B4XMenuPlus [ EventName – Tag/Title ] ErrorText**

  
![](https://www.b4x.com/android/forum/attachments/157375)\_\_\_\_ ![](https://www.b4x.com/android/forum/attachments/157376) \_\_\_\_ ![](https://www.b4x.com/android/forum/attachments/157377)  
  
  
![](https://www.b4x.com/android/forum/attachments/157370)\_\_\_\_![](https://www.b4x.com/android/forum/attachments/157371)  
  
DepenseOn: XUI, BitmapCreator  
  
[INDENT][SIZE=7]**Fields:**[/SIZE][/INDENT]  
  
[INDENT]**ERROR\_NO\_ERROR** As Int[/INDENT]  
[INDENT]**ERROR\_TITLE\_NOT\_FOUND** As Int[/INDENT]  
[INDENT]**ERROR\_TAG\_NOT\_FOUND** As Int[/INDENT]  
[INDENT]**ERROR\_ITEM\_NOT\_CHECK** As Int[/INDENT]  
[INDENT]**ERROR\_ITEM\_NOT\_TOGGLE** As Int[/INDENT]  
[INDENT]**ERROR\_PARENTTAG\_NOT\_FOUND** As Int[/INDENT]  
[INDENT]**ERROR\_PARENTTAG\_NOT\_SUBMENU** As Int[/INDENT]  
[INDENT]**ERROR\_WRONG\_MENU\_TYPE** As Int[/INDENT]  
[INDENT]**ERROR\_ITEM\_WRONG\_TYPE** As Int[/INDENT]  
[INDENT]**ERROR\_STATE\_OUT\_OF\_RANGE** As Int[/INDENT]  
[INDENT]**ERROR\_ITEM\_IS\_DISABLED** As Int[/INDENT]  
[INDENT]**ERROR\_MENU\_NOT\_ACTIVE** As Int[/INDENT]  
[INDENT]**ERROR\_CALLBACK\_NOT\_FOUND** As Int[/INDENT]  
[INDENT]**ERROR\_ITEM\_WITHOUT\_ICON** As Int[/INDENT]  
[INDENT][/INDENT]  
[INDENT]**isActive** As Boolean[/INDENT]  
  
[INDENT][SIZE=7]**Properties:**[/SIZE][/INDENT]  
  
[INDENT]**Error** As Int[/INDENT]  
  
[INDENT][SIZE=7]**Methods:**[/SIZE][/INDENT]  
  
[INDENT]**Initialize**(Callback As Object, Root As B4XView, EventName As String)[/INDENT]  
[INDENT]**AddBarBmp**(Tag As String, Title As String, bmp As B4XBitmap)[/INDENT]  
[INDENT]**AddBarIcon**(Tag As String, Title As String, isAwesome As Boolean, mChar As String, color As Int) As Boolean[/INDENT]  
[INDENT]**AddBarToggleBmp**(Tag As String, Title As String, bmp As B4XBitmap) As Boolean[/INDENT]  
[INDENT]**AddBarToggleIcon**(Tag As String, Title As String, isAwesome As Boolean, mChar As String, color As Int) As Boolean[/INDENT]  
[INDENT]**AddItem**(Tag As String, Title As String)[/INDENT]  
[INDENT]**AddItemIcon**(Tag As String, Title As String, isAwesome As Boolean, mChar As String, color As Int)[/INDENT]  
[INDENT]**AddCheckbox**(Tag As String, Title As String, checked As Boolean)[/INDENT]  
[INDENT]**AddToggle**(Tag As String, Title As String) As Boolean[/INDENT]  
[INDENT]**AddToggleIcon**(Tag As String, Title As String, isAwesome As Boolean, mChar As String, color As Int) As Boolean[/INDENT]  
[INDENT]**AddSeparator**[/INDENT]  
[INDENT]**AddSubMenu**(Tag As String, Title As String) As Boolean[/INDENT]  
[INDENT]**AddSubSubMenu**(parentTag As String, Tag As String, Title As String) As Boolean[/INDENT]  
[INDENT]**AddSubItem**(parentTag As String, Tag As String, Title As String) As Boolean[/INDENT]  
[INDENT]**AddSubItemIcon**(parentTag As String, Tag As String, Title As String, isAwesome As Boolean, mChar As String, color As Int) As Boolean[/INDENT]  
[INDENT]**AddSubCheckbox**(parentTag As String, Tag As String, Title As String, checked As Boolean) As Boolean[/INDENT]  
[INDENT]**AddSubToggle**(parentTag As String, Tag As String, Title As String) As Boolean[/INDENT]  
[INDENT]**AddSubToggleIcon**(parentTag As String, Tag As String, Title As String, isAwesome As Boolean, mChar As String, color As Int) As Boolean[/INDENT]  
[INDENT]**AddSubSeparator**(parentTag As String) As Boolean[/INDENT]  
[INDENT]**GetEnabled**(Tag As String) As Boolean[/INDENT]  
[INDENT]**SetEnabled**(Tag As String, enabled As Boolean) As Boolean[/INDENT]  
[INDENT]**GetVisible**(Tag As String) As Boolean[/INDENT]  
[INDENT]**SetVisible**(Tag As String, visible As Boolean) As Boolean[/INDENT]  
[INDENT]**GetCheck**(Tag As String) As Boolean[/INDENT]  
[INDENT]**SetCheck**(Tag As String, checked As Boolean) As Boolean[/INDENT]  
[INDENT]**GetToggleState**(Tag As String) As Int[/INDENT]  
[INDENT]**SetToggleState**(Tag As String, state As Int) As Boolean[/INDENT]  
[INDENT]**SetIconColor**(Tag As String, color As Int) As Boolean[/INDENT]  
[INDENT]**SetToggleIconColor**(Tag As String, state As Int, color As Int) As Boolean[/INDENT]  
[INDENT]**ShowMenu**[/INDENT]  
[INDENT]**MenuClick**(Title As String) As Boolean[/INDENT]  
[INDENT]**WindowFocusChanged**(Focused As Boolean)[/INDENT]  
[INDENT][/INDENT]  
  
**[SIZE=6]History:[/SIZE]**  
  

- 1.00
[INDENT]First release[/INDENT]- 1.01
[INDENT]3Dot: Finetuning of icon size and position.[/INDENT]
[INDENT]Bar: Toggle icon color change missing.[/INDENT]
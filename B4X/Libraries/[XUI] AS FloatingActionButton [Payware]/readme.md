###  [XUI] AS FloatingActionButton [Payware] by Alexander Stolte
### 12/16/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/125687/)

HeyHo,  
this is a cross platform Floating Action Button.  
  
This library is **not free**, because, it cost a lot of time and gray hair to create such views.  
<https://payhip.com/b/q5oIT>  
Thanks for your understanding. :)  
  
![](https://www.b4x.com/android/forum/attachments/104554)![](https://www.b4x.com/android/forum/attachments/104555)![](https://www.b4x.com/android/forum/attachments/104556)![](https://www.b4x.com/android/forum/attachments/104653)![](https://www.b4x.com/android/forum/attachments/104654)![](https://www.b4x.com/android/forum/attachments/107552)  

```B4X
Sub ASFloatingActionButton1_ButtonClicked(open As Boolean)  
    If open = True Then  
        ASFloatingActionButton1.Base.GetView(1).SetRotationAnimated(250,135)  
    Else  
        ASFloatingActionButton1.Base.GetView(1).SetRotationAnimated(250,0)  
    End If  
End Sub
```

  
[SPOILER="Orientation declaration/tutorial/example"]  
The orientation property is always based on the position of the view on your screen. That is, if you position the view at the bottom right, then use "BottomRight".  

```B4X
ASFloatingActionButton1.Orientation = ASFloatingActionButton1.Orientation_BottomRight
```

  
The menu opens from bottom to top and the text is flush on the left.  
![](https://www.b4x.com/android/forum/attachments/104554)  

```B4X
ASFloatingActionButton1.Orientation = ASFloatingActionButton1.Orientation_TopLeft
```

  
The menu opens from top to bottom and the text is flush on the right  
![](https://www.b4x.com/android/forum/attachments/104653)  
[/SPOILER]  
Since 1.03 you can set FontAwesome and Material Icons to the view. Examples:  

```B4X
ASFloatingActionButton1.ButtonIconText.Font = xui.CreateMaterialIcons(24)'because the icon we want to display is an Material Icon  
ASFloatingActionButton1.ButtonIconText.Text = Chr(0xE145)
```

  

```B4X
ASFloatingActionButton1.ItemButtonProperties.IconText_Font = xui.CreateMaterialIcons(20)'because the next 2 item we want to add is a Material Icon  
ASFloatingActionButton1.AddItem(Null,Chr(0xE859),"Test Text","")  
ASFloatingActionButton1.AddItem(Null,Chr(0xE87D),"Test Text","")  
  
ASFloatingActionButton1.ItemButtonProperties.BackgroundColor = xui.Color_ARGB(255,73, 98, 164)'the next item should be a blue button  
ASFloatingActionButton1.ItemButtonProperties.IconText_Font = xui.CreateFontAwesome(20)'because the next item we want to add is a FontAwesome Icon  
ASFloatingActionButton1.AddItem(Null,Chr(0xF179),"Test Text","")
```

  
**ASFloatingActionButton  
Author: Alexander Stolte  
Version: 1.05**  

- **ASFloatingActionButton**

- **Events:**

- **ButtonClicked** (open As Boolean)
- **ItemClicked** (index As Int, Value As Object)

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **AddItem** (Icon As B4XBitmap, IconText As String, Text As String, Value As Object) As String
*Adds a child button to the menu  
 Icon - the bitmap for this item.  
 IconText - set FontAwesome or MaterialIcons - dont forget to set the right font  
 Text - the text for this item. Put a "" if you dont want to show a text label*- **Class\_Globals** As String
- **CloseMenu** As String
*closes the menu if the menu is open*- **CreateASFloatingButton\_ItemButtonProperties** (BackgroundColor As Int, IconText\_Font As B4XFont, IconText\_Color As Int) As ASFloatingButton\_ItemButtonProperties
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **FontToBitmap** (text As String, IsMaterialIcons As Boolean, FontSize As Float, color As Int) As B4XBitmap
*<https://www.b4x.com/android/forum/threads/fontawesome-to-bitmap.95155/post-603250>*- **getBackground** As B4XView
*gets the background panel*- **getBase** As B4XView
*gets the mbase*- **getButton** As B4XView
*gets the main button panel*- **getButtonIconText** As B4XView
*gets the main button label for FontAwesome- or Material-Icons*- **getItemButtonProperties** As ASFloatingButton\_ItemButtonProperties
*gets or sets the Item Button Properties  
 BackgroundColor - the background color of the child buttons*- **GetItemPanel** (index As Int) As B4XView
*gets the main panel of a item  
 <code>ASFloatingButton1.GetItemPanel(0).GetView(0) 'xpnl\_item\_button - the round button panel</code>  
 <code>ASFloatingButton1.GetItemPanel(0).GetView(1) 'xiv\_item - the icon</code>  
 <code>ASFloatingButton1.GetItemPanel(0).GetView(2) 'xlbl\_item\_text - the text label</code>*- **getItemTextProperties** As ASFloatingButton\_ItemTextProperties
*gets or sets the Item Text Properties*- **getMainButtonBackgroundColor** As Int
*gets or sets the background color of the main button*- **getOrientation** As String
- **getOrientation\_BottomLeft** As String
*view is on bottom, the items opens to the top and the text is right*- **getOrientation\_BottomRight** As String
*view is on bottom, the items opens to the top and the text is left*- **getOrientation\_TopLeft** As String
*view is on top, the items opens to the bottom and the text is right*- **getOrientation\_TopRight** As String
*view is on top, the items opens to the bottom and the text is left*- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **OpenMenu** As String
*opens the menu if the menu is not open*- **RemoveAll** As String
*removes all child items*- **RemoveAt** (Index As Int) As String
*Removes a special child item*- **setButtonIcon** (icon As B4XBitmap) As String
*sets the icon of the main button*- **setMainButtonBackgroundColor** (clr As Int) As String
*gets or sets the background color of the main button*- **setOrientation** (orient As String) As String
*gets or sets the orientation of the items if the menu is open  
 <code>ASFloatingButton1.Orientation = ASFloatingButton1.Orientation\_BottomRight</code>*
- **Properties:**

- **Background** As B4XView [read only]
*gets the background panel*- **Base** As B4XView [read only]
*gets the mbase*- **Button** As B4XView [read only]
*gets the main button panel*- **ButtonIcon**
*sets the icon of the main button*- **ButtonIconText** As B4XView [read only]
*gets the main button label for FontAwesome- or Material-Icons*- **ItemButtonProperties** As ASFloatingButton\_ItemButtonProperties [read only]
*gets or sets the Item Button Properties  
 BackgroundColor - the background color of the child buttons*- **ItemTextProperties** As ASFloatingButton\_ItemTextProperties [read only]
*gets or sets the Item Text Properties*- **MainButtonBackgroundColor** As Int
*gets or sets the background color of the main button*- **Orientation** As String
*gets or sets the orientation of the items if the menu is open  
 <code>ASFloatingButton1.Orientation = ASFloatingButton1.Orientation\_BottomRight</code>*- **Orientation\_BottomLeft** As String [read only]
*view is on bottom, the items opens to the top and the text is right*- **Orientation\_BottomRight** As String [read only]
*view is on bottom, the items opens to the top and the text is left*- **Orientation\_TopLeft** As String [read only]
*view is on top, the items opens to the bottom and the text is right*- **Orientation\_TopRight** As String [read only]
*view is on top, the items opens to the bottom and the text is left*
- **ASFloatingButton\_ItemButtonProperties**

- **Fields:**

- **BackgroundColor** As Int
- **IconText\_Color** As Int
- **IconText\_Font** As B4XFont
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*
- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASFloatingButton\_ItemTextProperties**

- **Fields:**

- **BackgroundColor** As Int
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **TextAlignment\_Horizontal** As String
- **TextAlignment\_Vertical** As String
- **TextColor** As Int
- **TextFont** As B4XFont

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
**Changelog**  

- **1.00**

- Release

- **1.01**

- BugFixes
- AddItem - New Value Parameter
- ItemClicked - New Value Parameter
- Adds get and set Orientation and Designer Property
- Adds Orientation enums

- Orientation\_BottomRight
- Orientation\_BottomLeft
- Orientation\_TopRight
- Orientation\_TopLeft

- **1.02**

- ButtonClicked-Event-Value Open is now always True if no childs exists
- Add RemoveAt - removes a special child item
- Add RemoveAll - removes all child items

- **1.03**

- **Detailed Informations about the update, you find** [**here**](https://www.b4x.com/android/forum/threads/b4x-xui-as-floatingactionbutton.125687/post-797579)
- Adds ButtonIconText - gets the main button label for FontAwesome- or Material-Icons
- Adds the following parameter to ItemButtonProperties

- IconText\_Font
- IconText\_Color

- Adds new parameter IconText to AddItem - set FontAwesome or MaterialIcons - dont forget to set the right font

- **1.04**

- Add Event ItemTextClicked - triggers if you click on a text item

- **1.05**

- Intern Function IIF renamed to iif2

- **1.06**

- B4J BugFixes

- **1.07**

- Add get isOpen
- Add Event Open - is triggered when the button is opened
- Add Event Closed - is triggered when the button is collasped again
- BugFix

- **1.08**

- B4I Improvements - the entire screen is now used for the background shadow

- When the navigation bar was hidden, there was an area at the top that did not go dark when the menu was opened
- The height of the area is now determined and the gap closed
- B4XPages is now required in B4I

Have Fun :)  
<https://payhip.com/b/q5oIT>
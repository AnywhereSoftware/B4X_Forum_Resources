### Menu Manager by stevel05
### 08/24/2022
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/84401/)

Since this was written the access to menu items in B4j has changed, making this library largely redundant. I will leave it here for interest as there is some code in it that extends the menus.  
  
Create menu's in code for menubar and context menus.  
  
This library supports Text Menu Items, Checkbox Menu items, Custom menu items and menu dividers.  
  
Features:  

- Add Icons to menu items. Image, Fontawesome and MaterialIcons
- Add Shortcut keys to menu items
- Default and assignable style classes to style via css
- Set tags
- Set alternate eventnames for individual menu items
- Create sub menus
- Create Simple menus from a String array
- Add tooltips to custom menus content Nodes
- Change attributes for menuitems
- Most set methods return it's own class so they can be chained

  
**Documentation**: Courtesy of Informatix **: **[LibDoc](https://www.b4x.com/android/forum/threads/libdoc-creation-of-documentation-for-libraries.83215/)****  
  
[SPOILER="Documentation"]**jMenuManager  
  
Author:** Steve Laming  
**Version:** 0.03  

- **KeyCombinations**

- **Fields:**

- **KC\_ALT** As String
- **KC\_CONTROL** As String
- **KC\_SHIFT** As String
- **KC\_SHORTCUT** As String

- **Functions:**

- **GetKeyCombination** (Combination As String()) As Object
- **Process\_Globals** As String

- **MenuCheckBoxClass**

- **Functions:**

- **AsJavaObject** As JavaObject
*Get the underlying Native menuitem as a JavaObject*- **AsObject** As Object
*Get the underlying Native menuitem as a JavaObject*- **Class\_Globals** As String
- **GetEnabled** As Boolean
*Get the enabled state for the menu item*- **GetEventName** As String
*get the alternate eventname*- **GetGraphic** As Node
*Get the graphic set on this menu item*- **GetSelected** As Boolean
*Get the selected state for this menu item*- **getStyleClass** As List
*Get the style class*- **GetTag** As Object
*Set a tag for the menu item*- **getText** As String
*Get/Set the text on this menu item*- **Initialize** (Module As Object, Event\_Name As String, Text As String) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **SetEnabled** (Enabled As Boolean) As MenuCheckBoxClass
*Set the enabled state for the menu item.  
 Returns the menu item*- **SetEventName** (Name As String) As MenuCheckBoxClass
*Set an alternate eventname*- **SetGraphic** (Graphic As Node) As MenuCheckBoxClass
*Set a Graphic for this menu item  
 Returns the menu item*- **SetSelected** (Checked As Boolean) As MenuCheckBoxClass
*Set the selected state for this menu item  
 Returns the menu item*- **SetShortCutKey** (Combination As String()) As MenuCheckBoxClass
*Set a shortut key for this menu item  
 Returns the menu item*- **SetStyleClass** (Class As String) As MenuCheckBoxClass
*Add a style class for this menuitem, checks it is not already added  
 Returns the menu item*- **SetTag** (TTag As Object) As MenuCheckBoxClass
*Set a tag for the menu item  
 Returns the menu item*- **setText** (Text As String) As String

- **Properties:**

- **Text** As String
*Get/Set the text on this menu item*
- **MenuCustomClass**

- **Functions:**

- **AsJavaObject** As JavaObject
*Get the native menu item as a Javaobject*- **AsObject** As Object
*Get the native menu item as an object*- **Class\_Globals** As String
- **GetContent** As Node
*Gets the value of the property content.*- **GetEnabled** As Boolean
*Get the enabled state for this menu item*- **GetEventName** As String
*Get the alternate Event name for this menu item*- **GetGraphic** As Node
*Get the graphic set on this menu item*- **GetStyleClass** As List
*Get the list of style classes set on this menu item*- **GetTag** As Object
*Get the tag for this menu item*- **getText** As String
*Get / Set the text of the menu item*- **Initialize** (Module As Object, EventName As String, TNode As Node) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsHideOnClick** As Boolean
*Gets the value of the property hideOnClick.*- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **SetContent** (Value As Node) As MenuCustomClass
*Sets the value of the property content.*- **SetEnabled** (Enabled As Boolean) As MenuCustomClass
*Set the enabled state for this menu item  
 Returns the menu item*- **SetEventName** (Name As String) As MenuCustomClass
*Set an alternate event name for this menu item  
 Returns the menu item*- **SetGraphic** (Graphic As Node) As MenuCustomClass
*Set a Graphic on this menu item  
 Returns the menu item*- **SetHideOnClick** (Value As Boolean, MouseTransparent As Boolean) As MenuCustomClass
*Sets the value of the property hideOnClick. Selecting MouseTransparent will make it non responsive to mouse hover and focus*- **SetShortCutKey** (Combination As String()) As MenuCustomClass
*Set a shortcut key for this menu item  
 Returns the menu item*- **SetStyleClass** (Class As String) As MenuCustomClass
*Set a style class for this menu item, checks it is not already added  
 Returns the menu item*- **SetTag** (TTag As Object) As MenuCustomClass
*Set a tag for this menu item  
 Returns the menu item*- **setText** (Text As String) As String

- **Properties:**

- **Text** As String
*Get / Set the text of the menu item*
- **MenuItemTextClass**

- **Functions:**

- **AsJavaObject** As JavaObject
*Get the native menu item as a Javaobject*- **AsObject** As Object
*Get the native menu item as an object*- **Class\_Globals** As String
- **GetEnabled** As Boolean
*Get the enabled state for this menu item*- **GetEventName** As String
*Get the alternate Event name for this menu item*- **GetGraphic** As Node
*Get the graphic set on this menu item*- **getStyleClass** As List
*Get the list of style classes set on this menu item*- **GetTag** As Object
*Get the tag for this menu item*- **getText** As String
*Get / Set the text of the menu item*- **Initialize** (Module As Object, EventName As String, Text As String) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **isMnemonicParsing** As Boolean
- **SetEnabled** (Enabled As Boolean) As MenuItemTextClass
*Set the enabled state for this menu item  
 Returns the menu item*- **SetEventName** (Name As String) As MenuItemTextClass
*Set an alternate event name for this menu item  
 Returns the menu item*- **SetGraphic** (Graphic As Node) As MenuItemTextClass
*Set a Graphic on this menu item  
 Returns the menu item*- **SetMnemonicParsing** (value As Boolean) As MenuItemTextClass
- **SetShortCutKey** (Combination As String()) As MenuItemTextClass
*Set a shortcut key for this menu item  
 Returns the menu item*- **SetStyleClass** (Class As String) As MenuItemTextClass
*Set a style class for this menu item, checks it is not already added  
 Returns the menu item*- **SetTag** (TTag As Object) As MenuItemTextClass
*Set a tag for this menu item  
 Returns the menu item*- **setText** (Text As String) As String

- **Properties:**

- **Text** As String
*Get / Set the text of the menu item*
- **MenuItemType**

- **Fields:**

- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **mType** As String
- **Text** As String

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **MenuManager**

- **Events:**

- **Action** (MI As MenuItemTextClass)
- **CustomAction** (MC As MenuCustomClass)
- **MenuOpening** (M As Menu)
- **SelectedChanged** (MCB As MenuCheckBoxClass)

- **Fields:**

- **MENUTYPE\_CONTEXTMENU** As String
- **MENUTYPE\_MENU** As String

- **Functions:**

- **AddItems** (Items As List, Clear As Boolean) As String
*Add text or Menuitems items to the menu, as an array, Pass a '-' to add a text seperator  
 <code>FM.AddItems(Array As String("Test","-","Test1"))</code>*- **Class\_Globals** As String
- **getMenu** As Object
- **getMenuType** As String
- **getTag** As Object
- **Initialize** (Module As Object, EventName As String, MenuTitleText As String) As String
*Initializes the object  
 Default menuType is MENUTYPE\_MENU*- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **MenuCheckBox** (Text As String) As MenuCheckBoxClass
*Create and Return a CheckMenuItem and set a changelistener  
 SelectedCChanged(MSB As MenuCheckBoxClass)*- **MenuCustom** (N As Node) As MenuCustomClass
*Create and return a MenuCustom Object*- **MenuSeparator** As JavaObject
*Create and return a SeperatorMenuItem Object*- **MenuSubMenu** (Title As String, SubMenu As List) As MenuSubMenuType
*Create a sub menu with title and content*- **MenuText** (Text As String) As MenuItemTextClass
*Create and return a TextMenuItem Object*- **MenuTitle** (Text As String) As MenuCustomClass
*Create and return a MenuTitle Object, make it not hide when clicked*- **NewFontAwesome** (FA As Char, Color As Paint) As Node
*Create and return a Label containing the defined FontAwesome Character*- **NewImage** (FilePath As String, FileName As String) As ImageView
*Helper to create an image view from a filepath/filename to add to the menu item*- **NewMaterialIcon** (FA As Char, Color As Paint) As Node
*Create and return a Label containing the defined MaterialIcon Character*- **setMenuType** (MenuType As String) As String
*Get / Set MenuType one of the constants: MENUTYPE\_MENU or MENUTYPE\_CONTEXTMENU*- **SetStyleSheet** (FilePath As String, FileName As String) As String
- **setTag** (Tag As Object) As String
*Get/Set a tag on the menumanager object*- **SimpleMenuArray** (Simple As String()) As MenuItemTextClass()
*Create a simple menu Array from a string array  
 No Seperators. Pass the result to MM.AddItems  
 Configure extras e.g. <code>A(2).SetTag("Tag 2")</code>*- **SimpleMenuList** (Simple As String()) As List
*Create a simple menu List from a string array  
 Use '-' for a separator. Pass the result to MM.AddItems*
- **Properties:**

- **Menu** As Object [read only]
- **MenuType** As String
*Get / Set MenuType one of the constants: MENUTYPE\_MENU or MENUTYPE\_CONTEXTMENU*- **Tag** As Object
*Get/Set a tag on the menumanager object*
- **MenuManagerUtils**

- **Functions:**

- **AsJO** (JO As JavaObject) As JavaObject
*Return a JavaObject*- **Process\_Globals** As String

- **MenuSubMenuType**

- **Fields:**

- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **SubMenu** As List
- **Title** As String

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
[/SPOILER]  
  
  
Requires:  

- B4j 5.9+
- JavaObject

The attached project contains the source code and examples which can be compiled to a library if required.  
  
Update:  

- Fixes a bug when adding a tooltip on a MenuCustomClass item to a context menu
- Added a parameter MouseTransparent to the hideonclick sub in the MenuCustomClass
- Changed css menu class names to avoid conflict.
- Rewritten the demo to make it clearer.

  
Update v0.3:  

- Bugfixes

  
153
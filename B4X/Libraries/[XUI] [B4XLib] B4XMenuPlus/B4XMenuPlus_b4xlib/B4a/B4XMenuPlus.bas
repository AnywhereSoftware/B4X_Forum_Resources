B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=12.2
@EndOfDesignText@
' Class 
'
' B4XMenuPlus
' Version: 1.00
'
' Ver.	1.01		05.10.2024
'	3Dot: 	Finetuning of icon size and position.
' 	Bar: 	Toggle icon color change missing.
'	
' Ver.  1.00		28.09.2024
' 	First release.	
'
' Ver.	0.01		15.05.2023
' by: Gfy

'Extension For B4XPages menu. Replacing B4XPages.AddMenuItem().
'When a menu item Is selected, an event ( EventName_Tag() ) Is triggered.
'
'New features are added:
'	
'    • Add text item, checkbox, toogle or submenu on 3dot menu.
'    • Add separator on 3dot menu. (two consecutive separators are not allowed and automatic suppressed ) 
'	   (separator are not clickable)
'    • Icons/Bitmaps can be displayed on the bar. Icons are created by FONTAWESOME and MATERIALICONS. 
'	   Icon/bitmaps can also be toggle elements.
'    • All items can be set enabled/disabled (gray out)
'    • All items can be set visible/hidden.
'    • All 3dot items can have also a icon.
'    • Checkbox item. When selected, the status changes and the event is called with EventName_Tag( Checked ).
'    • Toggle item. 1 to x rotating states possible. All elements of a toggle have the same Tag, 
'	   but can have different icons. When selected, the state rotates to the next position
'	   and the event is called with EventName_Tag( State ). The state is 0 based.
'    • Submenu. Multi level submenus can be created. These can also contain checkbox And/Or toggle elements.
'    • All interaction based on the item Tag.
'
' DepenseOn: XUI, BitmapCreator
Sub Class_Globals

	' ----------------------------------------------
	' Class.
	' ----------------------------------------------
	Private xui As XUI 'ignor

	' ----------------------------------------------
	' Type
	' ----------------------------------------------

	Type tMenuToggleItem( _
		title As String, _			' Title of item.
		bmp As B4XBitmap, _			' Bitmap for MENUITEM_ICON & MENUITEM_BMP. Enable = True.
		bmpDis As B4XBitmap, _		' Bitmap for MENUITEM_ICON & MENUITEM_BMP. Enable = False.
		withIcon As Boolean, _		' Only MENU_3DOT, if Icon used.
		iconData As tMenuItemIcon _	' Only MENUITEM_ICON or if withIcon=True. Icon data.
		)
					   
	Type tMenuItemIcon( _
		isAwesome As Boolean, _		' True = FONTAWESOME, False = MATERIALICONS
		mChar As String, _			' Char() to show.
		color As Int _				' color of the icon.
		)
						
	Type tMenuItemData( _
		title As String, _			' Menu text. Shown in menu. (on toggle, active item)
		mType As Int, _				' Menu type. (MENU_3DOT or MENU_BAR)
		iType As Int, _				' Menu item type. (MENUITEM_...)
		parentTag As String, _		' MainMenu if "" or Tag of the submenu.
		enabled As Boolean, _		' Enabled = True, Disabled = False (grayout).
		visible As Boolean, _		' Visible = True, Hidden = False.
		checked As Boolean, _		' Only MENUITEM_CHECK. Checked = True, Unchecked = False.
		state As Int, _				' Only MENUITEM_TOGGLE. Active toggle item. (0 based)
		tItems As List, _			' Only MENUITEM_TOGGLE. Items used for toggle, format in tMenuToggleItem.
		withIcon As Boolean, _		' Only MENU_3DOT. Item has additional Icon.
		bmp As B4XBitmap, _			' Bitmap on enable. Icon and BMP items. (on toggle, active item)
		bmpDis As B4XBitmap, _		' Bitmap on disable. Icon and BMP items. (on toggle, active item)
		iconData As tMenuItemIcon _	' Only MENUITEM_ICON and if withIcon is True. Icon data.
		) 

	' ----------------------------------------------
	' Global Variabels. (Field)
	' ----------------------------------------------

'	Public const FONTAWESOME As Int 	= 1
'	Public const MATERIALICONS As Int 	= 2
	
	Public const ERROR_NO_ERROR As Int 				= 0
	Public const ERROR_TITLE_NOT_FOUND As Int		= -1
	Public const ERROR_TAG_NOT_FOUND As Int			= -2
	Public const ERROR_ITEM_NOT_CHECK As Int		= -3
	Public const ERROR_ITEM_NOT_TOGGLE As Int 		= -4
	Public const ERROR_PARENTTAG_NOT_FOUND As Int	= -5
	Public const ERROR_PARENTTAG_NOT_SUBMENU As Int	= -6
	Public const ERROR_WRONG_MENU_TYPE As Int		= -7
	Public const ERROR_ITEM_WRONG_TYPE As Int 		= -8
	Public const ERROR_STATE_OUT_OF_RANGE As Int	= -9
	Public const ERROR_ITEM_IS_DISABLED As Int 		= -10
	Public const ERROR_MENU_NOT_ACTIVE As Int		= -11
	Public const ERROR_CALLBACK_NOT_FOUND As Int	= -12
	Public const ERROR_ITEM_WITHOUT_ICON As Int		= -13
	
	' Set B4XMenuClick active mode. Default is False, ShowMenu() set it to True.
	' 	True 	- Menu is active, Callback and ShowMenu() is called on Set_...()
	'	False	- Menu is inactive. No Callback or ShowMenu is called on Set_...()
	'			- MenuClick() will by return ERROR_NOT_ACTIVE.
	Public isActive As Boolean = False
	
	' ----------------------------------------------
	' Intern Constants.
	' ----------------------------------------------
	Private const MENUITEM_NORMAL As Int 	= 1
	Private const MENUITEM_CHECK As Int 	= 2
	Private const MENUITEM_ICON As Int 		= 3
	Private const MENUITEM_BMP As Int		= 4
	Private const MENUITEM_TOGGLE As Int	= 5
	Private const MENUITEM_SUB As Int 		= 6
	Private const MENUITEM_SEPARATOR As Int = 7
	
	Private const MENU_3DOT As Int			= 10
	Private const MENU_BAR As Int			= 11
	
	' Icons used to create menu text.
	Private const ICON_CHECK As Char = Chr( 0xF046 )		' FONTAWESOME
	Private const ICON_UNCHECK As Char = Chr( 0xF096 )		' FONTAWESOME
	Private const ICON_SUBMENU As Char = Chr( 0xF0DA )		' FONTAWESOME
	Private const ICON_SEPARATOR As Char = Chr( 0xF068 )	' FONTAWESOME
	
	' ----------------------------------------------
	' Intern variabels for Gets / Sets
	' ----------------------------------------------
	
	Private mErr As Int						' Error code. (ERROR_...)
	
	' ----------------------------------------------
	' Designer properties
	' ----------------------------------------------

	' ----------------------------------------------
	' Intern variabels.
	' ----------------------------------------------
	Private mCallback As Object
	Private mB4XPage As Object
	Private mEventName As String
	Private mRoot As B4XView
	
	Private mMenuItemList As Map			' Key = Tag, Value = MenuItemData

	Private const SUBCREATION_WAIT As Int	 	= 0
	Private const SUBCREATION_CREATE As Int		= 1
	Private const SUBCREATION_CLOSEMAIN As Int	= 2
	
	Private subCreationState As Int = SUBCREATION_WAIT		' 0 - Wait, 1 - create Sub, 2 - Close main menu
	Private subIsOpen As Boolean = False	' Set if SubMenu is open.
	
	Private const SEP_TAG As String = "_SepTag_"		' Only MENUITEM_SEPARATOR - Fix part of separation tag.
	Private const SEP_TITLE As String = "_SepTitle_"	' Only MENUITEM_SEPARATOR - Separation title.
	Private separatorCounter As Int = 0					' Only MENUITEM_SEPARATOR - Auto increase counter for Tag and Title creation.
	
	' ----------------------------------------------
	' Panel item data.
	' ----------------------------------------------

End Sub ' Class_Globals()

#Region -------------------- CLASS CREATION

' Initialize the object.
'	Callback:	Callback module
'	Root:		B4XView that call
'	EventName:	Generic event name
'
' Code Example: <code>
' Private mp As B4XMenuPlus
'
' mp.Initialize( Me, Root, "MenuClick" )
' mp.AddNItem( "Test", "Test Menu Item" )
' mp.ShowMenu
'
' Private Sub B4XPage_MenuClick( Tag As String )
'	mp.MenuClick( Tag )
' End Sub
'
' Private Sub MenuClick_Test()
' 	...
' End Sub</code>
Public Sub Initialize( Callback As Object, Root As B4XView, EventName As String )
	
	mCallback = Callback
	mB4XPage = Callback
	mRoot = Root
	mEventName = EventName
	
	mMenuItemList.Initialize
	
End Sub ' Initialize()

#End Region

' Public Functions.
#Region -------------------- Add Items

' Add bitmap menu item. (on Bar)
' The bitmap for disabled is generated. (gray out)
'	Tag:		Event to call. Format: EventName_Tag()
'	Title:		Text shown on menu item.
'	bmp:		Bitmap for enable, bitmap for disable is generated. (grayout)
Public Sub AddBarBmp( Tag As String, Title As String, bmp As B4XBitmap )
	
	Dim data As tMenuItemData
	
	data.Initialize
	data.title = Title
	data.iType = MENUITEM_BMP
	data.mType = MENU_BAR
	
	data.enabled = True
	data.visible = True
	
	data.bmp = bmp
	data.bmpDis = GreyScale( bmp )
	
	mMenuItemList.Put( Tag, data )
	
End Sub ' AddBarBmp()

' Add icon menu item. (on Bar)
' The icon for disabled is generated. (gray out)
'	Tag:		Event to call. Format: EventName_Tag()
'	Title:		Text shown on menu item.
' 	isAwesome	True = FONTAWESOME, False = MATERIALICONS
'	mChar:		Icon Picker Char.
'	color:		Color of icon.
Public Sub AddBarIcon( Tag As String, Title As String, isAwesome As Boolean, mChar As String, color As Int ) As Boolean
	
	Dim data As tMenuItemData
	
	data.Initialize
	data.title = Title
	data.iType = MENUITEM_ICON
	data.mType = MENU_BAR
	
	data.enabled = True
	data.visible = True
	data.withIcon = True

	data.iconData.Initialize
	data.iconData.isAwesome = isAwesome
	data.iconData.mChar = mChar
	data.iconData.color = color
	
	' Create bitmaps from icon.
	data.bmp = FontToBitmap( mChar, isAwesome, color )
	data.bmpDis = FontToBitmap( mChar, isAwesome, xui.Color_LightGray )

	mMenuItemList.Put( Tag, data )

	Return True
	
End Sub ' AddBarIcon()

' Add bitmap toggle menu item. (on Bar)
' All items with the same Tag are in the same toggle item. These items rotate on every selection.
'	Tag:		Event to call. Format: EventName_Tag( state )
'	Title:		Text shown on menu item.
'	bmp:		Bitmap for enable, bitmap for disable is generated. (grayout)
'	Return:		True = ok, False = see Error for details.
Public Sub AddBarToggleBmp( Tag As String, Title As String, bmp As B4XBitmap ) As Boolean
	
	Dim data As tMenuItemData
	Dim item As tMenuToggleItem
	
	mErr = ERROR_NO_ERROR
	
	If mMenuItemList.ContainsKey( Tag ) Then
		' Event exist, add item to the list.
		
		data = mMenuItemList.Get( Tag )
		
		' Same type as 1te item.
		If Not( data.mType = MENU_BAR ) Then
			setErrorAndLog( Tag, ERROR_WRONG_MENU_TYPE )
			Return False
		End If
	
		If Not( data.iType = MENUITEM_TOGGLE ) Then
			setErrorAndLog( Tag, ERROR_ITEM_NOT_TOGGLE )
			Return False
		End If
							
	Else
		' Event not found, create new list.
		
		data = CreateNewToggleData
		
		' 1te Item.
		data.title = Title
		data.mType = MENU_BAR
		
		data.bmp = bmp
		data.bmpDis = GreyScale( bmp )
		
	End If

	item.title = Title
	item.bmp = bmp
	item.bmpDis = GreyScale( bmp )
	
	data.tItems.Add( item )		' Add to List.
	
	mMenuItemList.Put( Tag, data )
	
	Return True
	
End Sub ' AddBarToggleBmp()

' Add icon toggle menu item. (on Bar)
' All items with the same Tag are in the same toggle item. These items rotate on every selection.
'	Tag:		Event to call. Format: EventName_Tag( state )
'	Title:		Text shown on menu item.
' 	isAwesome	True = FONTAWESOME, False = MATERIALICONS
'	mChar:		Icon Picker Char.
'	color:		Color of icon.
'	Return:		True = ok, False = see Error for details.
Public Sub AddBarToggleIcon( Tag As String, Title As String, isAwesome As Boolean, mChar As String, color As Int ) As Boolean
	
	Dim data As tMenuItemData
	Dim item As tMenuToggleItem
	Dim icon As tMenuItemIcon

	mErr = ERROR_NO_ERROR
	
	If mMenuItemList.ContainsKey( Tag ) Then
		' Tag exist, add item to the list.
		
		data = mMenuItemList.Get( Tag )
		
		' Same type as 1te item.
		If Not( data.mType = MENU_BAR ) Then
			setErrorAndLog( Tag, ERROR_WRONG_MENU_TYPE )
			Return False
		End If

		If Not( data.iType = MENUITEM_TOGGLE ) Then
			setErrorAndLog( Tag, ERROR_ITEM_NOT_TOGGLE )
			Return False
		End If
					
	Else
		' Tag not found, create new list.
		
		data = CreateNewToggleData
		
		' 1te Item.
		data.title = Title
		data.mType = MENU_BAR
		
		data.bmp = FontToBitmap( mChar, isAwesome, color )
		data.bmpDis = FontToBitmap( mChar, isAwesome, xui.Color_LightGray )
		
	End If

	item.title = Title

	icon.Initialize
	icon.isAwesome = isAwesome
	icon.mChar = mChar
	icon.color = color
	
	item.withIcon = True
	item.iconData = icon
	data.tItems.Add( item )		' Add to List.
	
	item.bmp = FontToBitmap( mChar, isAwesome, color )
	item.bmpDis = FontToBitmap( mChar, isAwesome, xui.Color_LightGray )
	
	mMenuItemList.Put( Tag, data )
	
	Return True
	
End Sub ' AddBarToggleIcon()

' Add text menu item. (in 3-dot menu)
'	Tag:		Event to call. Format: EventName_Tag()
'	Title:		Text shown on menu item.
Public Sub AddItem( Tag As String, Title As String )
	
	AddSubItem( "", Tag, Title )		' Main menu
	
End Sub ' AddItem()

' Add text menu item with icon. (in 3-dot menu)
'	Tag:		Event to call. Format: EventName_Tag()
'	Title:		Text shown on menu item.
' 	isAwesome	True = FONTAWESOME, False = MATERIALICONS
'	mChar:		Icon Picker Char.
'	color:		Color of icon.
Public Sub AddItemIcon( Tag As String, Title As String, isAwesome As Boolean, mChar As String, color As Int )

	AddSubItemIcon( "", Tag, Title, isAwesome, mChar, color )		' Main menu
	
End Sub ' AddItemIcon()

' Add checkbox menu item. (in 3-dot menu)
'	Tag:		Event to call. Format: EventName_Tag( checked )
'	Title:		Text shown on menu item.
'	checked:	Checked or unchecked.
Public Sub AddCheckbox( Tag As String, Title As String, checked As Boolean )
	
	AddSubCheckbox( "", Tag, Title, checked )
	
End Sub ' AddCheckbox()

' Add toggle menu item. (in 3-dot menu)
' All items with the same Tag are in the same toggle item. These items rotate on every selection.
'	Tag:		Event to call. Format: EventName_Tag( state )
'	Title:		Text shown on menu item.
'	Return:		True = ok, False = see Error for details.
Public Sub AddToggle( Tag As String, Title As String ) As Boolean
	
	Return AddSubToggle( "", Tag, Title )
	
End Sub ' AddToggle()

' Add toggle menu item with icon. (in 3-dot menu)
' All items with the same Tag are in the same toggle item. These items rotate on every selection.
'	Tag:		Event to call. Format: EventName_Tag( state )
'	Title:		Text shown on menu item.
' 	isAwesome	True = FONTAWESOME, False = MATERIALICONS
'	mChar:		Icon Picker Char.
'	color:		Color of icon.
'	Return:		True = ok, False = see Error for details.
Public Sub AddToggleIcon( Tag As String, Title As String, isAwesome As Boolean, mChar As String, color As Int ) As Boolean
	
	Return AddSubToggleIcon( "", Tag, Title, isAwesome, mChar, color )
	
End Sub ' AddToggleIcon()

' Add separator menu item. (in 3-dot menu)
Public Sub AddSeparator
	
	AddSubSeparator( "" )
	 
End Sub ' AddSeparator()

' Creata a new submenu item. (in 3-dot menu)
' This item is the parentTag for items inside the sub.
' The submenu can be composed of text, checkbox or toggle items.
'	Tag:		ParentTag. (no event called)
'	Title:		Text shown on menu item.
'	Return:		True = ok, False = see Error for details.
'
' For all instances using submenu, add this lines in Main.<code>
' Sub Activity_WindowFocusChanged (Focused As Boolean)
'	 If B4XPages.[page].[B4XMenuPlus].IsInitialized Then B4XPages.[page].[B4XMenuPlus].WindowFocusChanged( Focused )
' End Sub</code>
Public Sub AddSubMenu( Tag As String, Title As String ) As Boolean
	
	Return AddSubSubMenu( "", Tag, Title )
	
End Sub ' AddSubMenu()

' Creata a new submenu item in submenu. (in 3-dot menu)
' This item is the parentTag for items inside the sub.
' The submenu can be composed of text, checkbox or toggle items.
'	parentTag:	Tag of the submenu.
'	Tag:		ParentTag. (no event called)
'	Title:		Text shown on menu item.
'	Return:		True = ok, False = see Error for details.
'
' For all instances using submenu, add this lines in Main.<code>
' Sub Activity_WindowFocusChanged (Focused As Boolean)
'	 If B4XPages.[page].[B4XMenuPlus].IsInitialized Then B4XPages.[page].[B4XMenuPlus].WindowFocusChanged( Focused )
' End Sub</code>
Public Sub AddSubSubMenu( parentTag As String, Tag As String, Title As String ) As Boolean
	
	' Parameter valide?
	If Not( isParentTagValide( parentTag ) ) Then Return False
	
	Dim data As tMenuItemData
	
	data.Initialize
	data.title = Title
	data.mType = MENU_3DOT
	data.iType = MENUITEM_SUB
	data.parentTag = parentTag
	
	data.enabled = True
	data.visible = True
	data.withIcon = True
	
	mMenuItemList.Put( Tag, data )

	Return True
	
End Sub ' AddSubSubMenu()

' Add text menu item to a submenu. (in 3-dot menu)
'	parentTag:	Tag of the submenu.
'	Tag:		Event to call. Format: EventName_Tag()
'	Title:		Text shown on menu item.
'	Return:		True = ok, False = see Error for details.
Public Sub AddSubItem( parentTag As String, Tag As String, Title As String ) As Boolean
	
	' Parameter valide?
	If Not( isParentTagValide( parentTag ) ) Then Return False
	
	Dim data As tMenuItemData
	
	data.Initialize
	data.title = Title
	data.mType = MENU_3DOT
	data.iType = MENUITEM_NORMAL
	data.parentTag = parentTag
	
	data.enabled = True
	data.visible = True
	data.withIcon = False
	
	mMenuItemList.Put( Tag, data )

	Return True
	
End Sub ' AddSubItem()

' Add text menu item to a submenu with icon. (in 3-dot menu)
'	parentTag:	Tag of the submenu.
'	Title:		Text shown on menu item.
' 	isAwesome	True = FONTAWESOME, False = MATERIALICONS
'	mChar:		Icon Picker Char.
'	color:		Color of icon.
'	Return:		True = ok, False = see Error for details.
Public Sub AddSubItemIcon( parentTag As String, Tag As String, Title As String, isAwesome As Boolean, mChar As String, color As Int ) As Boolean
	
	' Parameter valide?
	If Not( AddSubItem( parentTag, Tag, Title ) ) Then Return False
	
	' Add Icon.
	Dim data As tMenuItemData = mMenuItemList.Get( Tag )
	
	' Add icon data.
	data.withIcon = True
	
	data.iconData.Initialize
	data.iconData.isAwesome = isAwesome
	data.iconData.mChar = mChar
	data.iconData.color = color
	
	mMenuItemList.Put( Tag, data )

	Return True
	
End Sub ' AddSubItemIcon()

' Add checkbox menu item to a submenu. (in 3-dot menu)
'	parentTag:	Tag of the submenu.
'	Tag:		Event to call. Format: EventName_Tag()
'	Title:		Text shown on menu item.
'	checked:	Checked or unchecked.
'	Return:		True = ok, False = see Error for details.
Public Sub AddSubCheckbox( parentTag As String, Tag As String, Title As String, checked As Boolean ) As Boolean
	
	' Parameter valide?
	If Not( isParentTagValide( parentTag ) ) Then Return False
	
	Dim data As tMenuItemData
	
	data.Initialize
	data.title = Title
	data.mType = MENU_3DOT
	data.iType = MENUITEM_CHECK
	data.parentTag = parentTag
	
	data.enabled = True
	data.visible = True
	data.withIcon = True		' Default.
	
	data.checked = checked
	
	mMenuItemList.Put( Tag, data )

	Return True
	
End Sub ' AddSubCheckbox()

' Add toggle menu item to a submenu. (in 3-dot menu)
'	parentTag:	Tag of the submenu.
'	Tag:		Event to call. Format: EventName_Tag()
'	Title:		Text shown on menu item.
'	Return:		True = ok, False = see Error for details.
Public Sub AddSubToggle( parentTag As String, Tag As String, Title As String ) As Boolean
	
	' Parameter valide?
	If Not( isParentTagValide( parentTag ) ) Then Return False

	Dim data As tMenuItemData
	Dim item As tMenuToggleItem
	
	mErr = ERROR_NO_ERROR
	
	If mMenuItemList.ContainsKey( Tag ) Then
		' Event exist, add item to the list.
		
		data = mMenuItemList.Get( Tag )
		
		' Same type as 1te item.
		If Not( data.mType = MENU_3DOT ) Then
			setErrorAndLog( Tag, ERROR_WRONG_MENU_TYPE )
			Return False
		End If
		
		If Not( data.iType = MENUITEM_TOGGLE ) Then
			setErrorAndLog( Tag, ERROR_ITEM_NOT_TOGGLE )
			Return False
		End If
					
	Else
		' Toggle not found, create new.
		
		data = CreateNewToggleData
		
		' 1te Item.
		data.title = Title
		data.mType = MENU_3DOT
		data.iType = MENUITEM_TOGGLE
		data.parentTag = parentTag
		
		data.enabled = True
		data.visible = True
		data.withIcon = False
	End If

	item.title = Title
	item.withIcon = False
	
	data.tItems.Add( item )		' Add to List.
	
	mMenuItemList.Put( Tag, data )
	
	Return True
	
End Sub ' AddSubToggle()

' Add toggle menu item to a submenu with icon. (in 3-dot menu)
'	parentTag:	Tag of the submenu.
'	Tag:		Event to call. Format: EventName_Tag()
'	Title:		Text shown on menu item.
' 	isAwesome	True = FONTAWESOME, False = MATERIALICONS
'	mChar:		Icon Picker Char.
'	color:		Color of icon.
'	Return:		True = ok, False = see Error for details.
Public Sub AddSubToggleIcon( parentTag As String, Tag As String, Title As String, isAwesome As Boolean, mChar As String, color As Int ) As Boolean
	
	' Parameter valide?
	If Not( isParentTagValide( parentTag ) ) Then Return False

	If Not( AddSubToggle( parentTag, Tag, Title ) ) Then Return False		' Error from AddSubToggle().
	
	Dim data As tMenuItemData = mMenuItemList.Get( Tag )
	
	Dim item As tMenuToggleItem
	Dim icon As tMenuItemIcon
	
	' Replace toggle item to get icon stored.
	Dim tItemsSize As Int = data.tItems.Size
	data.tItems.RemoveAt( tItemsSize-1 )		' Delete last entry.
	
	If tItemsSize = 1 Then
		' First entry.
		data.withIcon = True
		
		data.iconData.Initialize
		data.iconData.isAwesome = isAwesome
		data.iconData.mChar = mChar
		data.iconData.color = color
		
		icon = data.iconData
	Else
		' Icon data to toggle items.
		icon.Initialize
		
		icon.isAwesome = isAwesome
		icon.mChar = mChar
		icon.color = color
	
	End If
	
	item.title = Title
	item.withIcon = True
	item.iconData = icon
	
	data.tItems.Add( item )		' Add to toggle item list.
	
	mMenuItemList.Put( Tag, data )

	Return True
	
End Sub ' AddSubToggleIcon()

' Add separator menu item. (in 3-dot menu)
'	parentTag:	Tag of the submenu.
'	Return:		True = ok, False = see Error for details.
Public Sub AddSubSeparator( parentTag As String ) As Boolean
	
	' Parameter valide?
	If Not( isParentTagValide( parentTag ) ) Then Return False
	
	Dim tag As String = SEP_TAG & (separatorCounter)
	
	Dim data As tMenuItemData
	
	data.Initialize
	data.title = SEP_TITLE & separatorCounter
	data.mType = MENU_3DOT
	data.iType = MENUITEM_SEPARATOR
	data.parentTag = parentTag
	
	data.enabled = False		' Default
	data.visible = True
	data.withIcon = False
	
	mMenuItemList.Put( tag, data )
	
	separatorCounter = separatorCounter + 1		' For next.
	
	Return True
	
End Sub ' AddSeparator()

#End Region

#Region -------------------- Item Parameter

' Gets whether the menu item is enabled. (gray out)
'	Tag:		Tag to get enable.
'	Return:		True = enabled, False = disabled or see Error for details.
Public Sub GetEnabled( Tag As String ) As Boolean
	
	mErr = ERROR_NO_ERROR
	
	Dim data As tMenuItemData = mMenuItemList.Get( Tag )
	
	If data = Null Then
		setErrorAndLog( Tag, ERROR_TAG_NOT_FOUND )
		Return False
	End If
	
	Return data.enabled
	
End Sub ' GetEnabled()

' Set enabled of the menu item. (gray out)
'	Tag:		Tag to enable.
'	enable:		True = enable, False = disable
'	Return:		True = ok, False = nok, see Error for details.
Public Sub SetEnabled( Tag As String, enabled As Boolean ) As Boolean

	mErr = ERROR_NO_ERROR

	Dim data As tMenuItemData = mMenuItemList.Get( Tag )
	
	If data = Null Then
		setErrorAndLog( Tag, ERROR_TAG_NOT_FOUND )
		Return False
	End If
	
	data.enabled = enabled
	mMenuItemList.Put( Tag, data )		' Save data.
	
	If isActive Then ShowMenu
	
	Return True
	
End Sub ' SetEnabled()

' Gets whether the menu item is visible or not.
'	Tag:		Tag to get visible.
'	Return:		True = hide, False = show or see Error for details.
Public Sub GetVisible( Tag As String ) As Boolean
	
	mErr = ERROR_NO_ERROR
	
	Dim data As tMenuItemData = mMenuItemList.Get( Tag )
	
	If data = Null Then
		setErrorAndLog( Tag, ERROR_TAG_NOT_FOUND )
		Return False
	End If
	
	Return data.visible
	
End Sub ' GetVisible()

' Set visible of the menu item.
'	Tag:		Tag set the visible
'	visible		True = visible, False = hidden
'	Return:		True = ok, False = nok, see Error for details.
Public Sub SetVisible( Tag As String, visible As Boolean ) As Boolean
	
	mErr = ERROR_NO_ERROR

	Dim data As tMenuItemData = mMenuItemList.Get( Tag )
	
	If data = Null Then
		setErrorAndLog( Tag, ERROR_TAG_NOT_FOUND )
		Return False
	End If
	
	data.visible = visible
	
	mMenuItemList.Put( Tag, data )		' Save data.
	
	If isActive Then ShowMenu
	
	Return True

End Sub ' SetVisible()

' ----------  CHECKBOX ONLY  -------------------

' Gets whether the Checkbox menu item is checked or not.
'	Tag:		Tag to get check.
'	Return:		True = checked, False = unchecked or see Error for details.
Public Sub GetCheck( Tag As String ) As Boolean

	mErr = ERROR_NO_ERROR
	
	Dim data As tMenuItemData = mMenuItemList.Get( Tag )
	
	If data = Null Then
		setErrorAndLog( Tag, ERROR_TAG_NOT_FOUND )
		Return False
	End If
	
	If Not( data.iType = MENUITEM_CHECK ) Then
		setErrorAndLog( Tag, ERROR_ITEM_NOT_CHECK )
		Return False
	End If
	
	Return data.checked
	
End Sub ' GetCheck()

' CheckBox Item set check.
'	Tag:		Tag to get checked.
'	checked		True = check, False = uncheck
'	Return:		True = ok, False = nok, see Error for details.
Public Sub SetCheck( Tag As String, checked As Boolean ) As Boolean
	
	mErr = ERROR_NO_ERROR

	Dim data As tMenuItemData = mMenuItemList.Get( Tag )
	
	If data = Null Then
		setErrorAndLog( Tag, ERROR_TAG_NOT_FOUND )
		Return False
	End If
	
	If Not( data.iType = MENUITEM_CHECK ) Then
		setErrorAndLog( Tag, ERROR_ITEM_NOT_CHECK )
		Return False
	End If
	
	data.checked = checked
	
	mMenuItemList.Put( Tag, data )		' Save data.
	
	If isActive Then 
		ShowMenu
		Return CheckCallback( Tag, checked )
	End If
	
	Return True
	
End Sub ' SetCheck()

' ----------  TOGGLE ONLY  ---------------------

' Get the state for Toggle item. (0 based)
'	Tag:		Tag of the Topggle-item.
'	Return:		State value or -1 = error, see Error for details.
Public Sub GetToggleState( Tag As String ) As Int
	
	mErr = ERROR_NO_ERROR
	
	Dim data As tMenuItemData = mMenuItemList.Get( Tag )
	
	If data = Null Then
		setErrorAndLog( Tag, ERROR_TAG_NOT_FOUND )
		Return -1
	End If
	
	If Not( data.iType = MENUITEM_TOGGLE ) Then
		setErrorAndLog( Tag, ERROR_ITEM_NOT_TOGGLE )
		Return -1
	End If

	Return data.state

End Sub ' GetToggleState()

' Set the state for Toggle item. (0 based)
'	Tag:		Tag of the Topggle-item.
'	state:		New state value.
'	Return:		True = ok, False = nok, see Error for details.
Public Sub SetToggleState( Tag As String, state As Int ) As Boolean
	
	mErr = ERROR_NO_ERROR

	Dim data As tMenuItemData = mMenuItemList.Get( Tag )
	
	If data = Null Then
		setErrorAndLog( Tag, ERROR_TAG_NOT_FOUND )
		Return False
	End If
	
	If Not( data.iType = MENUITEM_TOGGLE ) Then
		setErrorAndLog( Tag, ERROR_ITEM_NOT_TOGGLE )
		Return False
	End If

	If state < 0 Or state >= data.tItems.Size Then
		setErrorAndLog( Tag, ERROR_STATE_OUT_OF_RANGE )
		Return False
	End If
	
	data.state = state
	CopyStateData( Tag, data )		' Copy selected item to active.
	
	If isActive Then
		ShowMenu
		Return ToggleCallback( Tag, state )
	End If
	
	Return True
	
End Sub ' SetToggleState()

' ----------  ICON ONLY  -----------------------

' Set the color of the icon. (Bar icon and 3dot item with icon)
'	Tag:		Tag to change color.
'	color:		New color.
'	Return:		True = ok, False = nok, see Error for details.
Public Sub SetIconColor( Tag As String, color As Int ) As Boolean
	
	mErr = ERROR_NO_ERROR

	Dim data As tMenuItemData = mMenuItemList.Get( Tag )
	
	If data = Null Then
		setErrorAndLog( Tag, ERROR_TAG_NOT_FOUND )
		Return False
	End If
	
	If data.iType <> MENUITEM_NORMAL And _
		data.iType <> MENUITEM_ICON Then
		
		setErrorAndLog( Tag, ERROR_ITEM_WRONG_TYPE )
		Return False
	End If
	
	If Not(data.withIcon ) Then
		setErrorAndLog( Tag, ERROR_ITEM_WITHOUT_ICON )
		Return False
	End If

	data.iconData.color = color
	
	If data.iType = MENUITEM_ICON Then
		' Create BMP from icon.
		data.bmp = FontToBitmap( data.iconData.mChar, data.iconData.isAwesome, color )
	End If
	
	mMenuItemList.Put( Tag, data )	' Save data.
	
	If isActive Then ShowMenu
	
	Return True

End Sub ' SetIconColor()

' Set the color of the icon. (toggle item only)
'	Tag:		Tag to change color.
'	state		Toggle state.
'	color:		New color.
'	Return:		True = ok, False = nok, see Error for details.
Public Sub SetToggleIconColor( Tag As String, state As Int, color As Int ) As Boolean
	
	mErr = ERROR_NO_ERROR

	Dim data As tMenuItemData = mMenuItemList.Get( Tag )
	
	If data = Null Then
		setErrorAndLog( Tag, ERROR_TAG_NOT_FOUND )
		Return False
	End If
	
	If Not( data.iType = MENUITEM_TOGGLE ) Then
		setErrorAndLog( Tag, ERROR_ITEM_NOT_TOGGLE )
		Return False
	End If
	
	Dim item As tMenuToggleItem
	
	If state < 0 Or state >= data.tItems.Size Then
		setErrorAndLog( Tag, ERROR_STATE_OUT_OF_RANGE )
		Return False
	End If
	
	item = data.tItems.Get( state )		' Copy state data.
	
	If Not( item.withIcon ) Then
		setErrorAndLog( Tag, ERROR_ITEM_WITHOUT_ICON )
		Return False
	End If
	
	item.iconData.color = color			' If state is active, active color change because it is the same object.
	
	If data.mType = MENU_BAR Then
		' Create BMP.
		item.bmp = FontToBitmap( item.iconData.mChar, item.iconData.isAwesome, color )
		
		If state = data.state Then
			data.bmp = item.bmp
		End If
	End If
	
	' Replace item.
	data.tItems.RemoveAt( state )
	data.tItems.InsertAt( state, item )
	
	mMenuItemList.Put( Tag, data )	' Save data.
	
	If isActive Then ShowMenu
	
	Return True

End Sub ' SetToggleIconColor()

#End Region

#Region -------------------- Menu Interaction

' Build  and show the menu with saved data.
' isActive is set to True.
Public Sub ShowMenu
	
	CreateMenu( "" )			' Create mainMenu.
	
End Sub ' ShowMenu()

' Click on Menu item.
'	Title:		Title clicked on
'	Return:		True = ok, False = nok, see Error for details.
Public Sub MenuClick( Title As String ) As Boolean
	
	Dim tag As String
	Dim data As tMenuItemData
	
	mErr = ERROR_NO_ERROR
	
	' Instance is in setup mode.
	If Not( isActive ) Then
		setErrorAndLog( Title, ERROR_MENU_NOT_ACTIVE )
		Return False
	End If
	
	subCreationState = SUBCREATION_WAIT		' Click on menu close the menu.
	If subIsOpen Then
		' Click on sub menu, auto close it, rebuild main menu.
		ShowMenu
		subIsOpen = False
	End If
	
	' Search for Tag.
	tag = GetTagFromTitle( Title )
	
	If tag = "" Then
		setErrorAndLog( Title, ERROR_TITLE_NOT_FOUND )
		Return False
	End If
	
	data = mMenuItemList.Get( tag )
	
	If Not( data.enabled ) Then
		setErrorAndLog( tag, ERROR_ITEM_IS_DISABLED )
		Return False
	End If
	
	If data.iType = MENUITEM_SUB Then
		' SubMenu clicked
		' Create sub menu and show.
		
		CreateMenu( tag )
		Dim act As Activity = B4XPages.GetNativeParent(mB4XPage)
		act.OpenMenu

		subCreationState = SUBCREATION_CREATE		' Submenu create.

	Else If data.iType = MENUITEM_TOGGLE Then
		' Toggle clicked.
		' Rotate to next state.
		' Update and save data.
		' Toogle-callback.
		
		data.state = IIf( data.state = data.tItems.Size-1, 0, data.state+1 )
		CopyStateData( tag, data )			' Copy selected item to active.
		
		ShowMenu
		
		Return ToggleCallback( tag, data.state )
			
	Else If data.iType = MENUITEM_CHECK Then
		' Checkbox clicked
		' Invert checked.
		' Update and save data.
		' Checkbox-callback.
		
		data.checked = IIf( data.checked, False, True )
		mMenuItemList.Put( tag, data )
		
		ShowMenu
	
		Return CheckCallback( tag, data.checked )

	Else
		' Text, Icon or BMP clicked.
		' Item-callback.
		
		If Not( SubExists( mCallback, mEventName & "_" & tag ) ) Then
			setErrorAndLog( tag, ERROR_CALLBACK_NOT_FOUND )
			Return False
		End If
		
		CallSub( mCallback, mEventName & "_" & tag )
		
	End If

	Return True
	
End Sub ' MenuClick()

' Activity window focus changed. Used when submenu is closed without clicking on it.
' For all instances using submenu, add in this line Main.<code>
' Sub Activity_WindowFocusChanged (Focused As Boolean)
'	 If B4XPages.[page].[B4XMenuPlus].IsInitialized Then B4XPages.[page].[B4XMenuPlus].WindowFocusChanged( Focused )
' End Sub</code>
Public Sub WindowFocusChanged( Focused As Boolean )
	' This is used to detect if a submenu is closed without clicking on it. (Be loosing the focus)
	' subCreationState:	0 - Wait, 1 - create Sub, 2 - Close main Menu (fosused=True)

	If subCreationState = SUBCREATION_CREATE And Focused Then subCreationState = SUBCREATION_CLOSEMAIN
	
	If subCreationState = SUBCREATION_CLOSEMAIN And Focused = False Then subIsOpen = True
	
	If subIsOpen And Focused Then
		' Sub menu loose the focus, it is closed, rebuild main menu.
		subCreationState = SUBCREATION_WAIT
		subIsOpen = False
		ShowMenu
	End If

End Sub ' WindowFocusChanged()

#End Region

' Public Gets and Sets from Designer
#Region -------------------- Properties Designer


#End Region

' Public Gets and Sets
#Region -------------------- Properties

' Gets or sets the B4XMenuClick active mode.
' 	mode:	True 	- Menu is active, Callback and ShowMenu() is called on Set_...()
'			False	- Menu is inactive. NO Callback or ShowMenu is called on Set_...()
'					- MenuClick() will by return ERROR_MENU_NOT_ACTIVE.
Public Sub getIsActive() As Boolean
	
	Return isActive 
		
End Sub ' getIsActive()

Public Sub setIsActive( active As Boolean )
	
	isActive = active
		
End Sub ' setIsActive()

' Get the Error of the last used function.
' 	Return:		Error code. (ERROR_...)
'		ERROR_NO_ERROR = 0
'		ERROR_TITLE_NOT_FOUND = -1, ERROR_TAG_NOT_FOUND = -2, ERROR_ITEM_NOT_CHECK = -3
'		ERROR_ITEM_NOT_TOGGLE = -4, ERROR_PARENTTAG_NOT_FOUND = -5, ERROR_PARENTTAG_NOT_SUBMENU = -6
'		ERROR_WRONG_MENU_TYPE = -7, ERROR_ITEM_WRONG_TYPE = -8, ERROR_STATE_OUT_OF_RANGE = -9
'		ERROR_ITEM_IS_DISABLED = -10, ERROR_MENU_NOT_ACTIVE = -11
'		ERROR_CALLBACK_NOT_FOUND = -12, ERROR_ITEM_WITHOUT_ICON = -13
Public Sub getError() As Int

	Return mErr
	
End Sub ' getError()

#End Region

' Intern Functions.
#Region -------------------- PRIVATE - Find Items

' Get Tag from Title.
'	Title:	Find Tag from this.
'	Return:	Tag found.
'			If Tag is empty, see Error for details.
Private Sub GetTagFromTitle( Title As String ) As String
	
	Dim tag As String = ""
	Dim index As Int
	
	mErr = ERROR_NO_ERROR
	
	index = GetIndexFromTitle( Title )
	
	If index = ERROR_TITLE_NOT_FOUND Then Return tag
	
	tag = mMenuItemList.GetKeyAt( index )
	
	Return tag
	
End Sub ' GetTagFromTitle()

' Get the index of Title in data.
'	title:	To be found.
'	Return:	Index or see Error for details.
Private Sub GetIndexFromTitle( Title As String ) As Int
	
	Dim data As tMenuItemData
	Dim index As Int = ERROR_TITLE_NOT_FOUND
	Dim titleStart As Int
	
	Dim correctTitle As String
	
	' Get start pos of title. (Cut icons of)
	For i=0 To Title.Length-1
		If Not( Asc( Title.CharAt(i) ) > 255 ) Then
			' First char found, that is not a icon. (Use from her as title)
			correctTitle = Title.SubString( i )
			Exit
		End If
	Next
	
	For i=0 To mMenuItemList.Size-1
		data = mMenuItemList.GetValueAt(i)
		
		titleStart = data.title.IndexOf( correctTitle )

		' The title can start with a icon, so eliminate it.
		If titleStart >= 0 And data.title.Length = correctTitle.Length Then
			' Tag found.
			index = i
			Exit
		End If
	Next

	Return index
	
End Sub ' GetIndexFromItemTxt()

#End Region

#Region -------------------- PRIVATE - Items change

' Create the menu with saved data.
' Only MENU_3DOT.
'	parentTag:		"" for mainMenu, parentTag for subMenu.
Private Sub CreateMenu( parentTag As String )
	
	Dim data As tMenuItemData
	Dim mItem As B4AMenuItem
	Dim csb As CSBuilder
	Dim separatorLastItem As Boolean = False
	
	Dim spearatorText As String = CreateSeparatorTitle( parentTag )
	Dim IconIn3DotMenu As Boolean = is3DotUseIcons( parentTag )

	' Create menu.
	Dim menuS As List = B4XPages.GetManager.GetPageInfoFromRoot(mRoot).Parent.MenuItems
	menuS.Clear

	If parentTag <> "" Then
		' SubMenu. 1te itemis subMenu title.
		data = mMenuItemList.Get( parentTag )
		csb.Initialize.Size(16).Color( xui.Color_Gray ). _
			Typeface(Typeface.CreateNew(Typeface.DEFAULT,Typeface.STYLE_ITALIC)). _
			Append( data.title ).PopAll
		B4XPages.AddMenuItem( mB4XPage, csb )
	End If
	
	For i=0 To mMenuItemList.Size-1
		data = mMenuItemList.GetValueAt(i)
		
		If data.parentTag <> parentTag Then Continue
		
		If data.mType = MENU_3DOT Then
			If Not(data.visible) Then Continue
			
			If data.iType = MENUITEM_SEPARATOR Then 
				If separatorLastItem Then
					' No separator folow twice.
					Continue
				Else
					separatorLastItem = True
				End If
			Else
				separatorLastItem = False
			End If
			
			B4XPages.AddMenuItem( mB4XPage, BuildItemText( data, IconIn3DotMenu, spearatorText ) )
			
		Else If data.mType = MENU_BAR Then
			If Not(data.visible) Then Continue
		
			mItem = B4XPages.AddMenuItem( mB4XPage, data.title )
			mItem.AddToBar = True
			mItem.Bitmap = IIf( data.enabled, data.bmp, data.bmpDis )
			
		End If

	Next
	
	' Update Menu change.
	Dim ctxt As JavaObject
	ctxt.InitializeContext
	ctxt.RunMethod("invalidateOptionsMenu", Null)

	If isActive=False Then isActive = True

End Sub ' CreateMenu()

' Create new toggle menu item.
'	Return:		New toggle menu item data.
Private Sub CreateNewToggleData() As tMenuItemData
	
	Dim data As tMenuItemData
	
	data.Initialize
	data.iType = MENUITEM_TOGGLE
	
	data.enabled = True
	data.visible = True
	
	data.state = 0
	
	' Toggle items.
	Dim ti As List
	ti.Initialize
	data.tItems = ti

	Return data
	
End Sub ' CreateNewToggleData()

' Copy the active toggle state data to use.
'	tag:	Tag of the toggle item.
'	data:	Data of item from tag.
Private Sub CopyStateData( tag As String, data As tMenuItemData )
	
	Dim toggleItem As tMenuToggleItem = data.tItems.Get( data.state )
		
	' Copy new item data to toggle menu item.
	data.title = toggleItem.title
	data.bmp = toggleItem.bmp
	data.bmpDis = toggleItem.bmpDis
	data.withIcon = toggleItem.withIcon
	data.iconData = toggleItem.iconData
	
	mMenuItemList.Put( tag, data )		' Save data.
	
End Sub ' CopyStateData()

' Build the text base menu item. 
' On MENU_CHECK or MENU_SUB put the icon befor the text.
'	data:			Data block.
'	iconUsed:		True if icon is used in menu.
'	separatorText:	Separator text.
'	Return:			Item title formated to show.
Private Sub BuildItemText( data As tMenuItemData, iconUsed As Boolean, separatorText As String ) As CSBuilder
	
	Dim ICON_DUMMY As Char = Chr( 0xF096 )		' FONTAWESOME

	Dim csb As CSBuilder
	Dim const iconSize As Int = 24
	Dim const textSize As Int = 16
	Dim const dummySize As Int = 14
	Dim const dummyColor As Int = 0xFaFaFa		' Same as background.
'	Dim const dummyColor As Int = xui.Color_Green
	
	csb.Initialize.Size( textSize )
'	csb.BackgroundColor( xui.Color_Cyan)
	
	If data.enabled=False Then csb.Color(Colors.LightGray )
	
	If data.iType = MENUITEM_CHECK Then
		' Check icon to draw.
		
		csb.Size(20).VerticalAlign(3dip)		' Size of Submenu icon.
		
		If data.checked=True Then
			' Item with check, checked.
			csb.Typeface(Typeface.FONTAWESOME).Append(ICON_CHECK)

		Else
			' Item with check, unchecked.
			csb.Typeface(Typeface.FONTAWESOME).Append(ICON_UNCHECK)

		End If
		
		csb.Size(dummySize).Color(dummyColor).Append(ICON_DUMMY).Pop.Pop.Pop.Pop.Pop
		
	Else if data.iType = MENUITEM_SUB Then
		' Submenu icon to draw.
		csb.Typeface(Typeface.FONTAWESOME).Size(iconSize).VerticalAlign(3dip).Append(ICON_SUBMENU).Pop
		csb.size(dummySize).Color(dummyColor).Append(ICON_DUMMY).Append(ICON_DUMMY).Pop.Pop.Pop
		
	Else if data.withIcon Then
		' Draw Icon. (Icon max = 48)
		
		csb.size( iconSize )
		
		If data.enabled Then 
			csb.Color(data.iconData.color)
		Else
			csb.Color(Colors.LightGray)
		End If
	
		csb.Typeface( IIf( data.iconData.isAwesome, Typeface.FONTAWESOME, Typeface.MATERIALICONS ) ). _
			VerticalAlign(5dip).Append(data.iconData.mChar).Pop.Pop.Pop.Pop
			
		csb.Color(dummyColor).Typeface(Typeface.FONTAWESOME).Size(dummySize).Append(ICON_DUMMY).Pop.Pop.Pop
		
	Else
		' No Icon in menu used.
		If iconUsed Then
			' Normal text with Checkbox hidden as placeholder.
			
			csb.Color(dummyColor).Typeface(Typeface.FONTAWESOME).Size(iconSize).Append(ICON_DUMMY)
			csb.Pop.Size(dummySize).Append(ICON_DUMMY).Pop.Pop.Pop
		End If

	End If

	If data.iType = MENUITEM_SEPARATOR Then
		' Separator draw.
		
		csb.Size(10).VerticalAlign(-6dip)		' Size of Separator icon.
		csb.Typeface(Typeface.FONTAWESOME).Append(separatorText).PopAll
		
	Else
		csb.Append(data.title).PopAll
		
	End If
	
	Return csb
	
End Sub ' BuildItemText()

' Create a text string for separator title, based on icons.
'	parentTag:	"" for mainMenu or subMenu tag.
'	Return:		Separatorstring.
private Sub CreateSeparatorTitle( parentTag As String ) As String
	
	Dim const minLength As Int = 16		' Minimum length of separator.
	
	Dim data As tMenuItemData
	Dim titleLen As Int = 0
	
	Dim sep As String = ICON_SEPARATOR

	For i=0 To mMenuItemList.Size-1
		data = mMenuItemList.GetValueAt(i)
		
		If parentTag <> data.parentTag Then Continue
		
		If data.title.Length > titleLen Then
			titleLen = data.title.Length
		End If
	Next
	
	titleLen = Max( titleLen, minLength )

	For i = 0 To titleLen
		sep = sep & ICON_SEPARATOR
	Next
	
	Return sep

End Sub ' CreateSeparatorTitle()

' Do the callback for Checkbox-item.
'	Tag:		Tag of the Checkbox-item.
'	check:		New state value.
'	Return:		True = ok, False = nok, see Error for details.
Private Sub CheckCallback( tag As String, check As Boolean ) As Boolean
	
	If Not( SubExists( mCallback, mEventName & "_" & tag ) ) Then
		setErrorAndLog( tag, ERROR_CALLBACK_NOT_FOUND )
		Return False
	End If
		
	CallSub2( mCallback, mEventName & "_" & tag, check )
	
	Return True
	
End Sub ' CheckCallback()

' Do the callback for Toggle-item.
'	Tag:		Tag of the Topggle-item.
'	state:		New state value.
'	Return:		True = ok, False = nok, see Error for details.
Private Sub ToggleCallback( tag As String, state As Int ) As Boolean
	
	If Not( SubExists( mCallback, mEventName & "_" & tag ) ) Then
		setErrorAndLog( tag, ERROR_CALLBACK_NOT_FOUND )
		Return False
	End If
	
	CallSub2( mCallback, mEventName & "_" & tag, state )
	
	Return True

End Sub ' ToggleCallback()

#End Region

#Region -------------------- PRIVATE - Utilitys

' Set error and output error text in debug mode.
'	err:	Active error code.
'	info:	Wrong part. (Tag or Title)
Private Sub setErrorAndLog( info As String, err As Int )
	
	mErr = err
	info = info		' For IDE warning reduction!
	
	#if debug
		Dim errText() As String = Array As String( _
			"No Error", _
			"Title not found", _
			"Tag not found", _
			"Item is not checkbox", _
			"Item is not toggle", _
			"Parent tag not found", _
			"Parent tag is not MENUITEM_SUBMENU", _
			"Wrong menu type", _
			"Item wrong type", _
			"Toggle state out of range", _
			"Item is disabled", _
			"Menu is not active", _
			"Callback not found", _
			"Item without icon" _
			)
									   
		LogColor( "B4XMenuPlus [ " & mEventName & " -> " & info & " ] " & mErr & "  " & _
			errText( Abs( mErr ) ), xui.Color_ARGB( 255, 255, 126, 0 )  )
		  
	#end if
							   
End Sub

' Convert font to bitmap. (for Icon Picker)
'	text :		Text to convert. (Icon Picker Char)
' 	isAwesome	True = FONTAWESOME, False = MATERIALICONS
'	color:		color of the icon
'	Return:		New bitmap.
Private Sub FontToBitmap( text As String, isAwesome As Boolean, color As Int ) As B4XBitmap
	
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, 32dip, 32dip)
	Dim cvs1 As B4XCanvas
	cvs1.Initialize(p)
	
	Dim fnt As B4XFont = IIf( isAwesome, xui.CreateFontAwesome(28), xui.CreateMaterialIcons(28) )
	Dim r As B4XRect = cvs1.MeasureText(text, fnt)
	Dim BaseLine As Int = cvs1.TargetRect.CenterY - r.Height / 2 - r.Top
	cvs1.DrawText(text, cvs1.TargetRect.CenterX, BaseLine, fnt, color, "CENTER")
	
	Dim b As B4XBitmap = cvs1.CreateBitmap
	cvs1.Release
	
	Return b
	
End Sub ' FontToBitmap()

' Convert bitmap to grayscale. (by Earl from BitmapCreatorEffects class)
'	bmp:	Bitmap to convert.
'	Return:	Grayscale bitmap.
Private Sub GreyScale (bmp As B4XBitmap) As B4XBitmap

	Dim bc As BitmapCreator
	bc.Initialize(bmp.Width / bmp.Scale, bmp.Height / bmp.Scale)
	bc.CopyPixelsFromBitmap(bmp)

	Dim argb As ARGBColor
	For x = 0 To bc.mWidth - 1
		For y = 0 To bc.mHeight - 1
			bc.GetARGB(x, y, argb)
			Dim c As Int = argb.r * 0.21 + argb.g * 0.72 + argb.b * 0.07
			argb.r = c
			argb.g = c
			argb.b = c
			bc.SetARGB(x, y, argb)
		Next
	Next
	Return bc.Bitmap
	
End Sub ' GreySacle()

' Find if in 3Dot menu are icons used.
'	parentTag:	"" for mainMenu or subMenu tag.
'	Return:		True if icon used.
private Sub is3DotUseIcons( parentTag As String ) As Boolean
	
	Dim data As tMenuItemData
	
	For i=0 To mMenuItemList.Size-1
		data = mMenuItemList.GetValueAt(i)
		
		If parentTag <> data.parentTag Then Continue
		
		If data.withIcon Then
			Return True
		End If
	Next
	
	Return False
	
End Sub	' is3DotUseIcons()

' Check is parentTag is present. "" for mainMenu exclude.
'	parentTag:		To be checked.
'	Return:			True = ok, False = see Error for details.
private Sub isParentTagValide( parentTag As String ) As Boolean
	
	If parentTag = "" Then Return True
	
	Dim data As tMenuItemData = mMenuItemList.Get( parentTag )
	
	If data = Null Then
		setErrorAndLog( ERROR_PARENTTAG_NOT_FOUND, parentTag )
		Return False
	End If

	If Not( data.iType = MENUITEM_SUB ) Then
		setErrorAndLog( ERROR_PARENTTAG_NOT_SUBMENU, parentTag )
		Return False
	End If
	
	Return True
	
End Sub ' isParentTagValide()

#End Region

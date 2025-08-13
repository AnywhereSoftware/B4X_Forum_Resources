B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=5.9
@EndOfDesignText@
#Event: CustomAction(MC AS MenuCustomClass)
#Event: Action(MI as MenuItemTextClass)
#Event: SelectedChanged(MCB as MenuCheckBoxClass)
#Event: MenuOpening(M as Menu)
Sub Class_Globals
	Private fx As JFX
	Type MenuItemType(mType As String,Text As String)
	Type MenuSubMenuType(Title As String, SubMenu As List)
	
	Public Const MENUTYPE_MENU As String = "menu"
	Public Const MENUTYPE_CONTEXTMENU As String = "context"
	Private mMenuType As String = MENUTYPE_MENU
	Private mMenuTitle As String
	Private CM As ContextMenu
	Private MU As Menu
	Private mModule As Object
	Private mEventName As String
	Private CustomNodeList As List
End Sub

'Initializes the object
'Default menuType is MENUTYPE_MENU
Public Sub Initialize(Module As Object, EventName As String, MenuTitleText As String)
	mModule = Module
	mEventName = EventName
	mMenuTitle = MenuTitleText
	MU.Initialize(mMenuTitle,"MU")
	AddStyle(MU,Array As String(""))
	Dim MUJO As JavaObject = MU
	Dim O As Object = MUJO.CreateEventFromUI("javafx.event.EventHandler","MU",Null)
	MUJO.RunMethod("setOnShowing",Array(O))
End Sub

'Get / Set MenuType one of the constants: MENUTYPE_MENU or MENUTYPE_CONTEXTMENU
Public Sub setMenuType(MenuType As String)
	mMenuType = MenuType
	If mMenuType = MENUTYPE_CONTEXTMENU Then
		If CM.IsInitialized = False Then 
			CM.Initialize("CM")
			AddStyle(CM,Array As String(""))
		End If
	End If
End Sub

Public Sub getMenuType As String
	Return mMenuType
End Sub


'Add text or Menuitems items to the menu, as an array, Pass a '-' to add a text seperator
'<code>FM.AddItems(Array As String("Test","-","Test1"))</code>
Public Sub AddItems(Items As List,Clear As Boolean)
	If mMenuType = MENUTYPE_CONTEXTMENU Then
		If Clear Then 
			CM.MenuItems.Clear
			If CustomNodeList.IsInitialized Then CustomNodeList.Clear
		End If
		BuildContextMenu (Items)
	End If
	
	If mMenuType = MENUTYPE_MENU Then
		If Clear Then MU.MenuItems.Clear
		BuildMenu(Items)
	End If
	
End Sub

Private Sub BuildMenu (Items As List)
	
	'Populate the context menu
	For Each It As Object In Items
		If It Is MenuSubMenuType Then
			Dim SMT As MenuSubMenuType = It
			MU.MenuItems.Add(BuildSubMenu(SMT.Title,SMT.SubMenu))
		Else IF It Is MenuCheckBoxClass Then
			Dim MCB As MenuCheckBoxClass = It
			MU.MenuItems.Add(MCB.AsObject)
		Else If It Is MenuItemTextClass Then
			Dim MIT As MenuItemTextClass = It
			MU.MenuItems.Add(MIT.AsObject)
		Else IF It Is MenuCustomClass Then
			Dim CIT As MenuCustomClass = It
			MU.MenuItems.Add(CIT.AsObject)
		Else
			MU.MenuItems.Add(It)
		End If
	Next
End Sub


Private Sub BuildContextMenu (Items As List)
	'Populate the context menu
	For Each It As Object In Items
		If It Is MenuSubMenuType Then
			Dim SMT As MenuSubMenuType = It
			CM.MenuItems.Add(BuildSubMenu(SMT.Title,SMT.SubMenu))
		Else IF It Is MenuCheckBoxClass Then
			Dim MCB As MenuCheckBoxClass = It
			CM.MenuItems.Add(MCB.AsObject)
		Else If It Is MenuItemTextClass Then
			Dim MIT As MenuItemTextClass = It
			CM.MenuItems.Add(MIT.AsObject)
		Else IF It Is MenuCustomClass Then
			Dim CIT As MenuCustomClass = It
			CM.MenuItems.Add(CIT.AsObject)
		Else
			CM.MenuItems.Add(It)
		End If
	Next
End Sub

'Build and return a submenu
Private Sub BuildSubMenu(Title As String,Items As List) As Menu
	Dim M As Menu
	M.Initialize(Title,"MI")
	'Process the menu Items
	For Each It As Object In Items
		If It Is MenuSubMenuType Then
			Dim SMT As MenuSubMenuType = It
			M.MenuItems.Add(BuildSubMenu(SMT.Title,SMT.SubMenu))
		Else IF It Is MenuCheckBoxClass Then
			Dim MCB As MenuCheckBoxClass = It
			M.MenuItems.Add(MCB.AsObject)
			AddStyle(MCB.AsJavaObject,Array As String(""))
		Else If It Is MenuItemTextClass Then
			Dim MIT As MenuItemTextClass = It
			M.MenuItems.Add(MIT.AsObject)
			AddStyle(MIT.AsJavaObject,Array As String(""))
		Else IF It Is MenuCustomClass Then
			Dim CIT As MenuCustomClass = It
			M.MenuItems.Add(CIT.AsObject)
			AddStyle(CIT.AsJavaObject,Array As String(""))
		End If
	Next
	'Add a style to the SubMenu
	AddStyle(M,Array As String(""))
	Return M
End Sub

Private Sub AddStyle(Target As JavaObject,Styles() As String)
	
	Dim S() As String
	Dim MString As String
	
	If mMenuType = MENUTYPE_MENU Then
		MString = "mm-menu"
	Else
		MString = "mm-cmenu"
	End If
	
	Dim L As List = Target.RunMethodJO("getStyleClass",Null)
	If L.IndexOf(MString) = -1 Then
		Dim S(Styles.Length + 1) As String
		For i = 0 To Styles.Length -1
			S(i+1) = Styles(i)
		Next
		S(0) = MString
	Else
		S = Styles
	End If
	Target.RunMethodJO("getStyleClass",Null).RunMethod("addAll",Array(S))
	
End Sub

Public Sub getMenu As Object
	If mMenuType = MENUTYPE_CONTEXTMENU Then Return CM
	If mMenuType = MENUTYPE_MENU Then Return MU
	Return Null
End Sub

'Menu item clicked, pass it back to the originating module
Private Sub MI_Action
	Dim MI As MenuItemTextClass = Sender
	Dim EName As String = mEventName
	If MI.GetEventName <> "" Then EName = MI.GetEventName
	If SubExists(mModule,EName & "_Action") Then CallSub2(mModule,EName & "_Action",MI)
End Sub

'Custom Menu item clicked, pass it back to the originating module
Private Sub MC_Action
	Dim MC As MenuCustomClass = Sender
	Dim EName As String = mEventName
	If MC.GetEventName <> "" Then EName = MC.GetEventName
	If SubExists(mModule,EName & "_CustomAction") Then CallSub2(mModule,EName & "_CustomAction",MC)
End Sub

Private Sub MU_Event (MethodName As String, Args() As Object)
	Dim M As Menu = Sender
	If SubExists(mModule,mEventName & "_MenuOpening") Then CallSub2(mModule,mEventName & "_MenuOpening",M)
End Sub

Private Sub CB_SelectedChanged(MCB As MenuCheckBoxClass)
	Dim EName As String = mEventName
	If MCB.GetEventName <> "" Then EName = MCB.GetEventName
	If SubExists(mModule,EName &"_SelectedChanged") Then CallSub2(mModule,EName & "_SelectedChanged",MCB)
End Sub

Private Sub CB_Action(MCB As MenuCheckBoxClass)
	Dim EName As String = mEventName
	If MCB.GetEventName <> "" Then EName = MCB.GetEventName
	If SubExists(mModule,EName &"_Action") Then CallSub2(mModule,EName & "_Action",MCB)
End Sub


'Create a simple menu List from a string array
'Use '-' for a separator. Pass the result to MM.AddItems
Public Sub SimpleMenuList(Simple() As String) As List
	Dim L As List
	L.Initialize
	For Each S As String In Simple
		If S = "-" Then
			L.Add(MenuSeparator)
		Else
			L.Add(MenuText(S))
		End If
	Next
	Return L
End Sub

'Create a simple menu Array from a string array
'No Seperators. Pass the result to MM.AddItems
'Configure extras e.g. <code>A(2).SetTag("Tag 2")</code>
Public Sub SimpleMenuArray(Simple() As String) As MenuItemTextClass()
	Dim A(Simple.length) As MenuItemTextClass
	For i = 0 To Simple.Length -1
		A(i) = MenuText(Simple(i))
	Next
	Return A
End Sub

'Create a sub menu with title and content
Public Sub MenuSubMenu(Title As String,SubMenu As List) As MenuSubMenuType
	Dim SM As MenuSubMenuType
	SM.Initialize
	SM.Title = Title
	SM.SubMenu = SubMenu
'	AddStyle(SM,Array As String(""))
	Return SM
End Sub

'Create and return a SeperatorMenuItem Object
Public Sub MenuSeparator As Object
	Dim JO As JavaObject
	JO.InitializeNewInstance("javafx.scene.control.SeparatorMenuItem",Null)
	'Add a style to the Separator
'	JO.RunMethodJO("getStyleClass",Null).RunMethod("add",Array("cmenu"))
	AddStyle(JO,Array As String("mm-separator"))
	Return JO
End Sub

'Create and return a TextMenuItem Object
Public Sub MenuText(Text As String) As MenuItemTextClass
	Dim MI As MenuItemTextClass
	MI.Initialize(Me,"MI",Text)
	'Add a style to the MenuItem
'	MI.ASJavaObject.RunMethodJO("getStyleClass",Null).RunMethod("addAll",Array(Array As String("cmenu","menutext")))
	AddStyle(MI.AsJavaObject,Array As String("mm-menutext"))
	Return MI
End Sub

'Create and return a MenuCustom Object
Public Sub MenuCustom(N As Node) As MenuCustomClass
	Dim MI As MenuCustomClass
	MI.Initialize(Me,"MC",N)
	If CustomNodeList.IsInitialized = False Then
		CustomNodeList.Initialize
	End If
	CustomNodeList.add(N)
	If mMenuType = MENUTYPE_MENU Then
		SetListener(MI,N)
	Else
		SetOnShownListener
	End If
	'Add a style to the MenuItem
'	MI.ASJavaObject.RunMethodJO("getStyleClass",Null).RunMethod("addAll",Array(Array As String("cmenu","menucustom")))
	AddStyle(MI.AsJavaObject,Array As String("mm-menucustom"))
	Return MI
End Sub

'Adjust the width of custom object on a Context Menu
Private Sub SetOnShownListener
	Dim JO As JavaObject
	JO = CM
	Dim O As Object = JO.CreateEventFromUI("javafx.event.EventHandler","OnShown",Null)
	JO.RunMethod("setOnShown",Array(O))
	Wait For (JO) OnShown_Event (MethodName As String, Args() As Object)
	Dim Width As Double = JO.RunMethod("getWidth",Null)
	For Each N As Node In CustomNodeList
		N.PrefWidth = Width
	Next
End Sub


'Need to set the width for custom views if we want a tooltip as the label won't necessarily take the whole width of the menu
Private Sub SetListener(MI As MenuCustomClass,N As Node)
	
	'Code from here: https://stackoverflow.com/questions/28699152/how-to-get-menu-or-menuitem-width-in-javafx
	Dim O As Object = MenuManagerUtils.AsJO(N).CreateEvent("javafx.beans.value.ChangeListener","PopupChanged",Null)
	Dim Parent As JavaObject
	Parent = MI.AsJavaObject.RunMethodJO("parentPopupProperty",Null)
	Parent.RunMethod("addListener",Array(O))

	Wait For (N) PopupChanged_Event (MethodName As String, Args() As Object)

	Dim ParentPopup As JavaObject
	Dim ParentPopupSkinProperty As JavaObject
	Dim MenuItemWidthProperty As JavaObject
	Dim MenuItemContainer As JavaObject
	ParentPopup = Args(2)
	ParentPopupSkinProperty = ParentPopup.RunMethodJO("skinProperty",Null)
	
	Dim O As Object = ParentPopupSkinProperty.CreateEvent("javafx.beans.value.ChangeListener","PopupChanged1",Null)
	ParentPopupSkinProperty.RunMethod("addListener",Array(O))
	
	Wait For (ParentPopupSkinProperty) PopupChanged1_Event (MethodName As String, Args() As Object)
	MenuItemContainer = getAssociatedNode(MI)
	MenuItemWidthProperty = MenuItemContainer.RunMethod("widthProperty",Null)
	Dim O As Object = MenuItemWidthProperty.CreateEvent("javafx.beans.value.ChangeListener","PopupChanged2",Null)
	MenuItemWidthProperty.RunMethod("addListener",Array(O))

	Wait For (MenuItemWidthProperty) PopupChanged2_Event (MethodName As String, Args() As Object)
	
	For Each N As Node In CustomNodeList
		N.PrefWidth = Args(2)
	Next
End Sub

'Helper sub for the SetListener process
Private Sub getAssociatedNode(MI As MenuCustomClass) As JavaObject
	Dim Menu As JavaObject
	Dim MenuSkin As JavaObject
	Dim Content As JavaObject
	Dim ItemsContainer As JavaObject
	Dim Children As List
	Dim MenuItemContainer As JavaObject
	
	If mMenuType = MENUTYPE_MENU Then
		Menu = MI.AsJavaObject.RunMethod("getParentPopup",Null)
		MenuSkin = Menu.RunMethod("getSkin",Null)
		Content = MenuSkin.RunMethod("getNode",Null)
		ItemsContainer = Content.RunMethod("getItemsContainer",Null)
		Children = ItemsContainer.RunMethod("getChildrenUnmodifiable",Null)
		For Each Child As Node In Children
			If GetType(Child) = "com.sun.javafx.scene.control.skin.ContextMenuContent$MenuItemContainer" Then
				MenuItemContainer = Child
				If MenuItemContainer.RunMethod("getItem",Null) = MI.AsObject Then
					Return MenuItemContainer
				End If
			End If
		Next
	Else
	End If
	Return Null
End Sub


'Create and Return a CheckMenuItem and set a changelistener
'SelectedCChanged(MSB As MenuCheckBoxClass)
Public Sub MenuCheckBox(Text As String) As MenuCheckBoxClass
	Dim MCB As MenuCheckBoxClass
	MCB.Initialize(Me,"CB",Text)
	'Add a style to the Checkbox Menu Item
	AddStyle(MCB.AsJavaObject,Array As String("mm-checkbox"))
	Return MCB
End Sub

'Create and return a MenuTitle Object, make it not hide when clicked
Public Sub MenuTitle(Text As String) As MenuCustomClass
	Dim Lbl As Label
	Lbl.Initialize("")
	Lbl.Text = Text
	Dim MCC As MenuCustomClass
	MCC.Initialize(Me,"",Lbl)
	'Add a style to the MenuItem
	AddStyle(MCC.AsJavaObject,Array As String("mm-title"))
	Return MCC
End Sub

'Create and return a Label containing the defined FontAwesome Character
Public Sub NewFontAwesome(FA As Char,Color As Paint) As Node
	Dim L As Label
	L.Initialize("")
	L.Font = fx.CreateFontAwesome(12)
	L.Text = FA
	L.TextColor = Color
	AddStyle(L,Array As String("mm-graphic","mm-fa-lbl"))
	Return L
End Sub

'Create and return a Label containing the defined MaterialIcon Character
Public Sub NewMaterialIcon(FA As Char,Color As Paint) As Node
	Dim L As Label
	L.Initialize("")
	L.Font = fx.CreateMaterialIcons(12)
	L.Text = FA
	L.TextColor = Color
	AddStyle(L,Array As String("mm-graphic","mm-ma-lbl"))
	Return L
End Sub

'Helper to create an image view from a filepath/filename to add to the menu item
Public Sub NewImage(FilePath As String,FileName As String) As ImageView
	Dim Img As ImageView
	Img.Initialize("")
	Img.SetImage(fx.LoadImageSample(FilePath,FileName,16,16))
	AddStyle(Img,Array As String("mm-graphic-img"))
	Return Img
End Sub

Public Sub SetStyleSheet(FilePath As String,FileName As String)
	
End Sub

'Get/Set a tag on the menumanager object
Public Sub setTag(Tag As Object)
	MenuManagerUtils.AsJO(Me).runMethod("setUserData", Array(Tag))
End Sub

Public Sub getTag As Object
	Return MenuManagerUtils.AsJO(Me).runMethod("getUserData", Null)
End Sub
B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.45
@EndOfDesignText@
#If Documentation
Updates
V1.00
	-Release
V1.01
	-BugFixes
	-Add get and set MaxSelectionCount - Only in SelectionMode = Multi - Defines the maximum number of items that may be selected
		-Default: 0
V1.02
	-Add Designer Property HapticFeedback
		-Default: True
	-BugFix on SearchByText - No longer takes capitalization into account
V1.03
	-BugFixes and Improvemets
	-Add Clear
	-Add RebuildList
	-Add CreateViewPerCode
	-Add "Height" to AS_SelectionList_ItemProperties Type 
V1.04
	-BugFixes
V1.05
	-Add GetItems - Get all items as list of AS_SelectionList_Item
V1.06
	-Add SetSelections2 - Set the Selections via a list
	-Add Type AS_SelectionList_SelectedItemProperties
		-Per Default the same settings as the AS_SelectionList_ItemProperties
	-Add get and set SideGap
		-Default: 10dip
	-Add Desginer Property SeperatorWidth
		-Default: BeginWithText
		-BeginWithText - The separator begins where the text begins
		-FullWidth - Full width
		-BeginWithIcon - The separator starts where the icon begins, if there is no icon, then where the text begins
V2.00
	-BugFixes and Improvements
	-Add AddSubItem
	-Add Designer Property RootItemClickBehavior - What should happen if you click on the root item when the sub menu is open
		-Default: CloseSubMenu
	-Add Type AS_SelectionList_SubItem
	-Add Type AS_SelectionList_SubItemProperties
	-Add Type AS_SelectionList_SelectedSubItemProperties
	-Add get and set CornerRadius - First and Last Item corner radius
V2.01
	-Search BugFix
V2.02
	-New SelectionIconAlignment - Alignment of the check icon of an item when it is selected
		-Default: Right
		-Left or Right
	-New Designer Property SelectionIconAlignment
		-Default: Right
	-New get and set ShowSeperators
V2.03
	-New RefreshList - Removes the layout of the items and rebuilds the layout
	-New Designer Property SearchTextHighlightedColor - The text color of the searched text when searching for something via SearchByText
		-Default: Red
	-New EmptyListTextLabel - Text that is displayed in the middle of the view if the list is empty, e.g. in a search if no items match the search
	-New get EmptyListTextLabel
	-New get and set EmptyListText
	-New get and set EmptySearchListText
	-New get and set EmptyListTextVisibility - If False then no Empty list text is displayed
		Default: True
	-New CustomDrawItem Event
	-New AS_SelectionList_CustomDrawItemViews Type
	-New AddItem2 - Adding an item with AS_SelectionList_Item parameter
	-Update Base_Resize - if the width changes, the items are recreated
	-Change The ItemText is now based on BBLabel
V2.04
	-New SelectionItemChanged Event - In the event, the item that was checked/unchecked is returned in order to be able to react better instead of always having to go through the complete selected item list
V2.05
	-New DeselectItem - Deselect by AS_SelectionList_Item or AS_SelectionList_SubItem
	-New DeselectItem2 - Deselect by Value
V2.06
	-BugFix subitems list height is now maximum as high as the space below
V2.07
	-BugFix
V2.08
	-New AS_SelectionList_CheckItemProperties Type
	-New get CheckItemProperties
V2.09
	-BugFixes - Thanks to @Peter Meares
V2.10
	-BugFix - SelectionChanged is now also triggered when you deselect items using code
	-New SelectAll - Selects all items + subitems
#End If

#DesignerProperty: Key: ThemeChangeTransition, DisplayName: ThemeChangeTransition, FieldType: String, DefaultValue: Fade, List: None|Fade
#DesignerProperty: Key: SelectionMode, DisplayName: SelectionMode, FieldType: String, DefaultValue: Single, List: Single|Multi
#DesignerProperty: Key: SelectionIconAlignment, DisplayName: SelectionIconAlignment, FieldType: String, DefaultValue: Right, List: Left|Right, Description: Alignment of the check icon of an item when it is selected
#DesignerProperty: Key: RootItemClickBehavior, DisplayName: RootItemClickBehavior, FieldType: String, DefaultValue: CloseSubMenu, List: CloseSubMenu|SelectRootItem|SelectAllSubItems
#DesignerProperty: Key: CanDeselect, DisplayName: CanDeselect, FieldType: Boolean, DefaultValue: True , Description: If true, then the user can remove the selection by clicking again
#DesignerProperty: Key: HapticFeedback, DisplayName: HapticFeedback, FieldType: Boolean, DefaultValue: True

#DesignerProperty: Key: BackgroundColor, DisplayName: Background Color, FieldType: Color, DefaultValue: 0xFFFFFFFF
#DesignerProperty: Key: ItemBackgroundColor, DisplayName: ItemBackgroundColor Color, FieldType: Color, DefaultValue: 0xFFE3E2E8
#DesignerProperty: Key: ShowSeperators, DisplayName: ShowSeperators, FieldType: Boolean, DefaultValue: True , Description: Show seperators between items
#DesignerProperty: Key: SeperatorWidth, DisplayName: SeperatorWidth, FieldType: String, DefaultValue: BeginWithText, List: BeginWithText|FullWidth|BeginWithIcon
#DesignerProperty: Key: SeperatorColor, DisplayName: SeperatorColor, FieldType: Color, DefaultValue: 0x28000000
#DesignerProperty: Key: SearchTextHighlightedColor, DisplayName: SearchTextHighlightedColor, FieldType: Color, DefaultValue: 0xFFDD5F60, Description: The text color of the searched text when searching for something via SearchByText

#Event: CustomDrawItem(Item As Object,Views As AS_SelectionList_CustomDrawItemViews)
#Event: SelectionChanged
#Event: SelectionItemChanged(Item As Object,Checked As Boolean)

Sub Class_Globals
	
	Type AS_SelectionList_Item(Text As String,Icon As B4XBitmap,Value As Object)
	Type AS_SelectionList_ItemProperties(BackgroundColor As Int,xFont As B4XFont,TextColor As Int,SeperatorColor As Int,Height As Float)
	Type AS_SelectionList_SelectedItemProperties(BackgroundColor As Int,xFont As B4XFont,TextColor As Int)
	
	Type AS_SelectionList_SubItem(RootItem As AS_SelectionList_Item,Text As String,Icon As B4XBitmap,Value As Object)
	Type AS_SelectionList_SubItemProperties(BackgroundColor As Int,xFont As B4XFont,TextColor As Int,SeperatorColor As Int,Height As Float)
	Type AS_SelectionList_SelectedSubItemProperties(BackgroundColor As Int,xFont As B4XFont,TextColor As Int)
	
	Type AS_SelectionList_CheckItemProperties(UncheckIcon As String,CheckedIcon As String,xFont As B4XFont,SelectedTextColor As Int,UnselectedTextColor As Int)
	Type AS_SelectionList_CustomDrawItemViews(BackgroundPanel As B4XView,ItemBackgroundPanel As B4XView,ItemTextLabel As BBLabel,CheckIconLabel As B4XView,SeperatorPanel As B4XView,IconImageView As B4XView,CollapsIconLabel As B4XView)
	
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	Private m_DataMap As B4XOrderedMap
	Private m_SubDataMap As B4XOrderedMap
	Private m_OldWidth As Double
	
	Private g_ItemProperties As AS_SelectionList_ItemProperties
	Private g_SubItemProperties As AS_SelectionList_SubItemProperties
	Private g_SelectedItemProperties As AS_SelectionList_SelectedItemProperties
	Private g_SelectedSubItemPropertiess As AS_SelectionList_SelectedSubItemProperties
	Private g_CheckItemProperties As AS_SelectionList_CheckItemProperties
	
	Private xclv_Main As CustomListView
	Private m_SelectionMap As Map
	
	Private m_CornerRadius As Float = 10dip
	Private m_SideGap As Float = 10dip
	Private m_SelectionMode As String
	Private m_RootItemClickBehavior As String
	Private m_CanDeselect As Boolean
	Private m_BackgroundColor As Int
	Private m_ThemeChangeTransition As String
	Private m_ShowSeperators As Boolean
	Private m_SeperatorWidth As String
	Private m_MaxSelectionCount As Int = 0
	Private m_HapticFeedback As Boolean
	Private m_isSubMenuOpen As Boolean = False
	Private m_isInSearchMode As Boolean = False
	Private m_SearchByText As String = ""
	Private m_SearchByObject As Object = Null
	Private m_SelectionIconAlignment As String
	Private m_TextGap As Float = 5dip
	Private m_SearchTextHighlightedColor As Int
	
	'***SubItems***
	Private xpnl_SubItemBackground As B4XView
	Private xpnl_SubItemListBase As B4XView
	Private xclv_SubItems As CustomListView
	Private xlbl_RootCollapsButton As B4XView
	Private xpnl_RootClvPanelBackground As B4XView
	Private xpnl_RootItemBackground As B4XView
	Private xlbl_RootCheckItem As B4XView
	'***
	
	'***EmptyList***
	Private m_EmptyListTextVisibility As Boolean = True
	Private xlbl_EmptyListText As B4XView
	Private m_EmptyListText As String = "Nothing here yet"
	Private m_EmptySearchListText As String = "No items found"
	'***
	
	Private m_TextEngine As BCTextEngine
	
	Private xiv_RefreshImage As B4XView
	
	Type AS_SelectionList_Theme(BackgroundColor As Int,Item_BackgroundColor As Int,Item_TextColor As Int,Item_SeperatorColor As Int,SubItem_BackgroundColor As Int,SubItem_TextColor As Int,SubItem_SeperatorColor As Int,SearchTextHighlightedColor As Int,EmptyListTextColor As Int,CheckItem_SelectedTextColor As Int,CheckItem_UnselectedTextColor As Int)
	
End Sub

Public Sub setTheme(Theme As AS_SelectionList_Theme)
	
	xiv_RefreshImage.SetBitmap(mBase.Snapshot)
	xiv_RefreshImage.SetVisibleAnimated(0,True)

	g_ItemProperties.BackgroundColor = Theme.Item_BackgroundColor
	g_ItemProperties.TextColor = Theme.Item_TextColor
	g_ItemProperties.SeperatorColor = Theme.Item_SeperatorColor
	
	g_SubItemProperties.BackgroundColor = Theme.SubItem_BackgroundColor
	g_SubItemProperties.TextColor = Theme.SubItem_TextColor
	g_SubItemProperties.SeperatorColor = Theme.SubItem_SeperatorColor
	
	g_SelectedItemProperties.BackgroundColor = Theme.Item_BackgroundColor
	g_SelectedItemProperties.TextColor = Theme.Item_TextColor
	
	g_SelectedSubItemPropertiess.BackgroundColor = Theme.SubItem_BackgroundColor
	g_SelectedSubItemPropertiess.TextColor = Theme.SubItem_TextColor
	
	g_CheckItemProperties.SelectedTextColor = Theme.CheckItem_SelectedTextColor
	g_CheckItemProperties.UnselectedTextColor = Theme.CheckItem_UnselectedTextColor
	
	m_SearchTextHighlightedColor = Theme.SearchTextHighlightedColor
	xlbl_EmptyListText.TextColor = Theme.EmptyListTextColor
	
	setBackgroundColor(Theme.BackgroundColor)
	
	Sleep(0)
	
	For i = 0 To xclv_Main.Size -1
		xclv_Main.GetPanel(i).RemoveAllViews
	Next
	xclv_Main.Refresh

	Select m_ThemeChangeTransition
		Case "None"
			xiv_RefreshImage.SetVisibleAnimated(0,False)
		Case "Fade"
			Sleep(250)
			xiv_RefreshImage.SetVisibleAnimated(250,False)
	End Select

End Sub

Public Sub getTheme_Dark As AS_SelectionList_Theme
	
	Dim Theme As AS_SelectionList_Theme
	Theme.Initialize
	Theme.BackgroundColor = xui.Color_ARGB(255,19, 20, 22)
	Theme.Item_BackgroundColor = xui.Color_ARGB(255,32, 33, 37)
	Theme.Item_TextColor = xui.Color_White
	Theme.Item_SeperatorColor = xui.Color_ARGB(40,255,255,255)
	Theme.SearchTextHighlightedColor = xui.Color_ARGB(255,221, 95, 96)
	Theme.EmptyListTextColor = xui.Color_White
	Theme.CheckItem_SelectedTextColor = xui.Color_White
	Theme.CheckItem_UnselectedTextColor = xui.Color_White
	
	Theme.SubItem_BackgroundColor = xui.Color_ARGB(255,32, 33, 37)
	Theme.SubItem_TextColor = xui.Color_White
	Theme.SubItem_SeperatorColor = xui.Color_ARGB(40,255,255,255)
	
	Return Theme
	
End Sub

Public Sub getTheme_Light As AS_SelectionList_Theme
	
	Dim Theme As AS_SelectionList_Theme
	Theme.Initialize
	Theme.BackgroundColor = xui.Color_White
	Theme.Item_BackgroundColor = xui.Color_ARGB(255,227, 226, 232)
	Theme.Item_TextColor = xui.Color_Black
	Theme.Item_SeperatorColor = xui.Color_ARGB(40,0,0,0)
	Theme.SearchTextHighlightedColor = xui.Color_ARGB(255,221, 95, 96)
	Theme.EmptyListTextColor = xui.Color_Black
	Theme.CheckItem_SelectedTextColor = xui.Color_Black
	Theme.CheckItem_UnselectedTextColor = xui.Color_Black
	
	
	Theme.SubItem_BackgroundColor = xui.Color_ARGB(255,227, 226, 232)
	Theme.SubItem_TextColor = xui.Color_Black
	Theme.SubItem_SeperatorColor = xui.Color_ARGB(40,0,0,0)
	
	Return Theme
	
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	m_SelectionMap.Initialize
	m_DataMap.Initialize
	m_SubDataMap.Initialize
End Sub

Public Sub CreateViewPerCode(Parent As B4XView,Left As Float,Top As Float,Width As Float,Height As Float)
	
	Dim xpnl_ViewBase As B4XView = xui.CreatePanel("")
	Parent.AddView(xpnl_ViewBase,Left,Top,Max(1dip,Width),Max(1dip,Height))
	
	DesignerCreateView(xpnl_ViewBase,CreateLabel(""),CreateMap())
	
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	m_OldWidth = mBase.Width
    Tag = mBase.Tag
	mBase.Tag = Me

	IniProps(Props)
	mBase.Color = m_BackgroundColor

	Dim xpnl_ListBackground As B4XView = xui.CreatePanel("")
	mBase.AddView(xpnl_ListBackground,0,0,mBase.Width,mBase.Height)
	xclv_Main = ini_xclv("xclv_Main",xpnl_ListBackground,xui.IsB4J)

	CreateSubItemsBase

	xiv_RefreshImage = CreateImageView("")
	xiv_RefreshImage.Visible = False
	mBase.AddView(xiv_RefreshImage,0,0,mBase.Width,mBase.Height)

	xlbl_EmptyListText = CreateLabel("")
	xlbl_EmptyListText.TextColor = xui.Color_Black
	xlbl_EmptyListText.Font = xui.CreateDefaultBoldFont(18)
	xlbl_EmptyListText.SetTextAlignment("CENTER","CENTER")
	xlbl_EmptyListText.Text = m_EmptyListText
	'xlbl_EmptyListText.Color = xui.Color_Red
	#If B4I
	xlbl_EmptyListText.As(Label).Multiline = True
	#Else If B4J
	xlbl_EmptyListText.As(Label).WrapText = True
	#Else B4A
	xlbl_EmptyListText.As(Label).SingleLine = False
	#End If
	mBase.AddView(xlbl_EmptyListText,mBase.Width/2 - 200dip/2,mBase.Height/2 - 100dip/2,200dip,100dip)

	m_TextEngine.Initialize(mBase)

	#If B4A
	Base_Resize(mBase.Width,mBase.Height)
	#End If

End Sub

Private Sub CreateSubItemsBase
	xpnl_SubItemBackground = xui.CreatePanel("xpnl_SubItemBackground")
	xpnl_SubItemBackground.Visible = False
	xpnl_SubItemBackground.Color = xui.Color_ARGB(100,0,0,0)
	mBase.AddView(xpnl_SubItemBackground,0,0,mBase.Width,mBase.Height)
	
	xpnl_SubItemListBase = xui.CreatePanel("")
	xpnl_SubItemBackground.AddView(xpnl_SubItemListBase,m_SideGap,0,xpnl_SubItemBackground.Width - m_SideGap*2,xpnl_SubItemBackground.Height)
	xclv_SubItems = ini_xclv("xclv_Main",xpnl_SubItemListBase,xui.IsB4J)
End Sub

Private Sub IniProps(Props As Map)
	
	m_ThemeChangeTransition = Props.GetDefault("ThemeChangeTransition","Fade")
	m_BackgroundColor = xui.PaintOrColorToColor(Props.GetDefault("BackgroundColor",0xFFFFFFFF))
	m_SelectionMode = Props.GetDefault("SelectionMode","Single")
	m_RootItemClickBehavior = Props.GetDefault("RootItemClickBehavior","CloseSubMenu")
	m_CanDeselect = Props.GetDefault("CanDeselect",True)
	m_ShowSeperators = Props.GetDefault("ShowSeperators",True)
	m_HapticFeedback = Props.GetDefault("HapticFeedback",True)
	m_SeperatorWidth = Props.GetDefault("SeperatorWidth",getSeperatorWidth_BeginWithText)
	m_SelectionIconAlignment = Props.GetDefault("SelectionIconAlignment",getSelectionIconAlignment_Right).As(String).ToUpperCase
	m_SearchTextHighlightedColor = xui.PaintOrColorToColor(Props.GetDefault("SearchTextHighlightedColor",xui.Color_ARGB(255,221, 95, 96)))
	
	g_ItemProperties.Initialize
	g_ItemProperties.BackgroundColor = xui.PaintOrColorToColor(Props.GetDefault("ItemBackgroundColor",0xFFE3E2E8))
	g_ItemProperties.TextColor = xui.Color_Black
	g_ItemProperties.xFont = xui.CreateDefaultBoldFont(18)
	g_ItemProperties.SeperatorColor = xui.PaintOrColorToColor(Props.GetDefault("SeperatorColor",0x28000000))
	g_ItemProperties.Height = 50dip
	
	g_SubItemProperties.Initialize
	g_SubItemProperties.BackgroundColor = xui.PaintOrColorToColor(Props.GetDefault("ItemBackgroundColor",0xFFE3E2E8))
	g_SubItemProperties.TextColor = xui.Color_Black
	g_SubItemProperties.xFont = xui.CreateDefaultBoldFont(16)
	g_SubItemProperties.SeperatorColor = xui.PaintOrColorToColor(Props.GetDefault("SeperatorColor",0x28000000))
	g_SubItemProperties.Height = 50dip
	
	g_SelectedItemProperties.Initialize
	g_SelectedItemProperties.BackgroundColor = xui.PaintOrColorToColor(Props.GetDefault("ItemBackgroundColor",0xFFE3E2E8))
	g_SelectedItemProperties.TextColor = xui.Color_Black
	g_SelectedItemProperties.xFont = xui.CreateDefaultBoldFont(18)
	
	g_SelectedSubItemPropertiess.Initialize
	g_SelectedSubItemPropertiess.BackgroundColor = xui.PaintOrColorToColor(Props.GetDefault("ItemBackgroundColor",0xFFE3E2E8))
	g_SelectedSubItemPropertiess.TextColor = xui.Color_Black
	g_SelectedSubItemPropertiess.xFont = xui.CreateDefaultBoldFont(16)
	
	g_CheckItemProperties.Initialize
	g_CheckItemProperties.xFont = xui.CreateMaterialIcons(20)
	g_CheckItemProperties.CheckedIcon = Chr(0xE5CA)
	g_CheckItemProperties.UncheckIcon = ""
	g_CheckItemProperties.SelectedTextColor = xui.Color_Black
	g_CheckItemProperties.UnselectedTextColor = xui.Color_Black
	
End Sub

Public Sub Base_Resize (Width As Double, Height As Double)
	mBase.SetLayoutAnimated(0,mBase.Left,mBase.Top,Width,Height)
	xpnl_SubItemBackground.SetLayoutAnimated(0,0,0,Width,Height)
	
	Dim OldOffsetY As Int = xclv_Main.sv.ScrollViewOffsetY
	
	xclv_Main.AsView.SetLayoutAnimated(0,0,0,Width,Height)
	xclv_Main.Base_Resize(Width,Height)
	xiv_RefreshImage.SetLayoutAnimated(0,0,0,Width,Height)
	xlbl_EmptyListText.SetLayoutAnimated(0,mBase.Width/2 - IIf(Width<200dip,Width,200dip)/2,mBase.Height/2 - 100dip/2,IIf(Width<200dip,Width,200dip), 100dip)
	
	xclv_Main.sv.ScrollViewOffsetY = Max(0,OldOffsetY)
	
	If m_OldWidth <> Width Then
		Sleep(0)
		RefreshList
	End If
	m_OldWidth = mBase.Width

End Sub

#Region Methods

'Get all items as list of AS_SelectionList_Item
Public Sub GetItems As List
	Dim lstItems As List
	lstItems.Initialize
	For i = 0 To xclv_Main.Size -1
		lstItems.Add(xclv_Main.GetValue(i))
	Next
	Return lstItems
End Sub

Public Sub AddItem(Text As String,Icon As B4XBitmap,Value As Object) As AS_SelectionList_Item
	
	Dim Item As AS_SelectionList_Item
	Item.Initialize
	Item.Text = Text
	Item.Icon = Icon
	Item.Value = Value
	
	AddItemIntern(Item,True)
	Return Item
End Sub

Public Sub AddItem2(Item As AS_SelectionList_Item) As AS_SelectionList_Item
	AddItemIntern(Item,True)
	Return Item
End Sub

Public Sub AddSubItem(RootItem As AS_SelectionList_Item,Text As String,Icon As B4XBitmap,Value As Object) As AS_SelectionList_SubItem
	
	Dim SubItem As AS_SelectionList_SubItem
	SubItem.Initialize
	SubItem.RootItem = RootItem
	SubItem.Text = Text
	SubItem.Icon = Icon
	SubItem.Value = Value
	
	Dim lstSubItems As List
	If m_SubDataMap.ContainsKey(RootItem) Then
		lstSubItems = m_SubDataMap.Get(RootItem)
	Else
		lstSubItems.Initialize
	End If
	
	lstSubItems.Add(SubItem)
	
	m_SubDataMap.Put(RootItem,lstSubItems)
	Return SubItem
	
End Sub

Public Sub Clear
	xclv_Main.Clear
	xclv_SubItems.Clear
	m_DataMap.Clear
	
	xlbl_EmptyListText.Text = m_EmptyListText
	xlbl_EmptyListText.Visible = True And m_EmptyListTextVisibility
End Sub

'Takes a snapshot of the layout and displays it in an ImageView
'The list can be cleared and rebuilt without the user seeing any flickering
Public Sub StartRefresh
	xiv_RefreshImage.SetBitmap(mBase.Snapshot)
	xiv_RefreshImage.SetVisibleAnimated(0,True)
End Sub

'Hides the ImageView with the layout snapshot
Public Sub StopRefresh
	Sleep(0)
	xiv_RefreshImage.SetVisibleAnimated(0,False)
End Sub

'Removes the layout of the items and rebuilds the layout
Public Sub RefreshList
	For i = 0 To xclv_Main.Size -1
		If xclv_Main.GetPanel(i).NumberOfViews > 0 Then
			xclv_Main.GetPanel(i).RemoveAllViews
			BuildItem(xclv_Main.GetPanel(i),xclv_Main.GetValue(i),xclv_Main)
		End If
	Next
	For i = 0 To xclv_SubItems.Size -1
		If xclv_SubItems.GetPanel(i).NumberOfViews > 0 Then
			xclv_SubItems.GetPanel(i).RemoveAllViews
			BuildItem(xclv_SubItems.GetPanel(i),xclv_SubItems.GetValue(i),xclv_SubItems)
		End If
	Next
End Sub

'Clears the list and adds the items again
Public Sub RebuildList
	xiv_RefreshImage.SetBitmap(mBase.Snapshot)
	xiv_RefreshImage.SetVisibleAnimated(0,True)
	Sleep(0)
	
	xclv_Main.Clear
	xclv_SubItems.Clear
	m_DataMap.Values.Sort(True)
	For Each Item As AS_SelectionList_Item In m_DataMap.Keys
		AddItemIntern(Item,False)
	Next
	
	xlbl_EmptyListText.Text = m_EmptyListText
	xlbl_EmptyListText.Visible = xclv_Main.Size = 0 And m_EmptyListTextVisibility
	
	Sleep(0)
	xiv_RefreshImage.SetVisibleAnimated(0,False)
End Sub

Public Sub SearchByText(Text As String)
	m_SearchByText = Text
	If Text.Trim = "" Then
		ClearSearch
		Return
	End If
	
	m_isInSearchMode = True
	xiv_RefreshImage.SetBitmap(mBase.Snapshot)
	xiv_RefreshImage.SetVisibleAnimated(0,True)
	Sleep(0)
	
	xclv_Main.Clear
	xclv_SubItems.Clear
	m_DataMap.Values.Sort(True)
	For Each Item As AS_SelectionList_Item In m_DataMap.Keys
		
		Dim SearchValueFound As Boolean = False
		If m_SubDataMap.ContainsKey(Item) Then
			Dim lstSubItems As List = m_SubDataMap.Get(Item)
			For Each SubItem As AS_SelectionList_SubItem In lstSubItems
				If (m_SearchByText <> "" And SubItem.Text.ToLowerCase.Contains(m_SearchByText.ToLowerCase)) Then
					SearchValueFound = True
					Exit
				End If
			Next
		End If
		
		If Item.Text.ToLowerCase.Contains(Text.ToLowerCase) Or SearchValueFound Then AddItemIntern(Item,False)
	Next
	
	xlbl_EmptyListText.Text = m_EmptySearchListText
	xlbl_EmptyListText.Visible = xclv_Main.Size = 0 And m_EmptyListTextVisibility
	
	Sleep(0)
	xiv_RefreshImage.SetVisibleAnimated(0,False)
	
	If m_isSubMenuOpen Then
		xpnl_SubItemBackground.SetColorAnimated(200,xpnl_SubItemBackground.Color,xui.Color_Transparent)
		Sleep(200)
		xpnl_SubItemBackground.Visible = False
	End If
	
End Sub

Public Sub SearchByValue(Value As Object)
	m_SearchByObject = Value
	m_isInSearchMode = True
	xiv_RefreshImage.SetBitmap(mBase.Snapshot)
	xiv_RefreshImage.SetVisibleAnimated(0,True)
	Sleep(0)
	
	xclv_Main.Clear
	xclv_SubItems.Clear
	m_DataMap.Values.Sort(True)
	For Each Item As AS_SelectionList_Item In m_DataMap.Keys
		
		Dim SearchValueFound As Boolean = False
		If m_SubDataMap.ContainsKey(Item) Then
			Dim lstSubItems As List = m_SubDataMap.Get(Item)
			For Each SubItem As AS_SelectionList_SubItem In lstSubItems
				If (m_SearchByObject <> Null And m_SearchByObject = SubItem.Value) Then
					SearchValueFound = True
					Exit
				End If
			Next
		End If
		
		If Item.Value = Value Or SearchValueFound Then AddItemIntern(Item,False)
	Next
	
	xlbl_EmptyListText.Text = m_EmptySearchListText
	xlbl_EmptyListText.Visible = xclv_Main.Size = 0 And m_EmptyListTextVisibility
	
	Sleep(0)
	xiv_RefreshImage.SetVisibleAnimated(0,False)
End Sub

Public Sub ClearSearch
	m_SearchByText = ""
	m_SearchByObject = Null
	m_isInSearchMode = False
	RebuildList
End Sub

Public Sub ClearSelections
	xiv_RefreshImage.SetBitmap(mBase.Snapshot)
	xiv_RefreshImage.SetVisibleAnimated(0,True)
	Sleep(0)
	
	For Each k As Object In m_SelectionMap.Keys
		SelectionItemChanged(k,False)
	Next
	
	m_SelectionMap.Clear
	ClearListIntern(xclv_Main,False)
	ClearListIntern(xclv_SubItems,False)
	SelectionChanged(Null,False)
	
	Sleep(0)
	xiv_RefreshImage.SetVisibleAnimated(0,False)
	
End Sub

'Selects all items + subitems
Public Sub SelectAll
	
	For Each Item As AS_SelectionList_Item In m_DataMap.Keys
		m_SelectionMap.Put(Item,"")
	Next

	For Each Item As AS_SelectionList_Item In m_SubDataMap.Keys
		
		Dim lstSubItems As List = m_SubDataMap.Get(Item)
			
		For Each SubItem As AS_SelectionList_SubItem In lstSubItems
			m_SelectionMap.Put(SubItem,"")
		Next
		
		m_SelectionMap.Put(SubItem,"")
	Next
	
	RefreshList
	
	Dim Haptic As Boolean = m_HapticFeedback
	m_HapticFeedback = False
	SelectionChanged(Null,True)
	m_HapticFeedback = Haptic
End Sub

'<code>
'	For Each Item As Object In AS_SelectionList1.GetSelections
'		Log("Item selected: " & Item.Text)
'	Next
'</code>
Public Sub GetSelections As List
	Dim lst As List
	lst.Initialize
	For Each k As Object In m_SelectionMap.Keys
		lst.Add(k)
	Next
	Return lst
End Sub

'Returns True if the item was found
Public Sub DeselectItem(Item As Object) As Boolean
	If m_SelectionMap.ContainsKey(Item) Then
		
		If Item Is AS_SelectionList_Item Then
			Dim Index As Int = -1
			For i = 0 To xclv_Main.Size -1
				If xclv_Main.GetValue(i) = Item Then
					Index = i
					Exit
				End If
			Next
				
			If Index > -1 Then ItemClickIntern(Item,Index,xclv_Main,True)
		Else If Item Is AS_SelectionList_SubItem Then
			
			Dim Index As Int = -1
			For i = 0 To xclv_SubItems.Size -1
				If xclv_SubItems.GetValue(i) = Item Then
					Index = i
					Exit
				End If
			Next
				
			If Index > -1 Then ItemClickIntern(Item,Index,xclv_SubItems,True)
			
		End If
		
		Return True
	End If
	Return False
End Sub

'Returns True if the item was found
Public Sub DeselectItem2(Value As Object) As Boolean
	For Each k As Object In m_SelectionMap.Keys
		If k Is AS_SelectionList_Item Then
			If k.As(AS_SelectionList_Item).Value = Value Then
				
				Dim Index As Int = -1
				For i = 0 To xclv_Main.Size -1
					If xclv_Main.GetValue(i) = k Then
						Index = i
						Exit
					End If
				Next
				
				If Index > -1 Then ItemClickIntern(k,Index,xclv_Main,True)
				
				Return True
			End If
		Else If k Is AS_SelectionList_SubItem Then
			If k.As(AS_SelectionList_SubItem).Value = Value Then
				
				Dim Index As Int = -1
				For i = 0 To xclv_SubItems.Size -1
					If xclv_SubItems.GetValue(i) = k Then
						Index = i
						Exit
					End If
				Next
				
				If Index > -1 Then ItemClickIntern(k,Index,xclv_SubItems,True)

				Return True
			End If
		End If	
	Next
	Return False
End Sub

'<code>AS_SelectionList1.SetSelections(Array As Object(1,3))</code>
Public Sub SetSelections(Values() As Object)
	Dim tmpMap As Map
	tmpMap.Initialize
	For Each Value As Object In Values
		tmpMap.Put(Value,"")
	Next
	SetSelectionIntern(tmpMap)
End Sub

'<code>
'	Dim lst As List
'	lst.Initialize
'	lst.Add(1)
'	lst.Add(3)
'	AS_SelectionList1.SetSelections2(lst)
'</code>
Public Sub SetSelections2(Values As List)
	Dim tmpMap As Map
	tmpMap.Initialize
	For Each Value As Object In Values
		tmpMap.Put(Value,"")
	Next
	SetSelectionIntern(tmpMap)
End Sub

Public Sub CloseSubMenu
	If m_isSubMenuOpen = False Then Return

	If xpnl_SubItemListBase.Top > 0 Then
		SetLayoutAnimated(xclv_Main.AsView,200,0,xclv_Main.AsView.Top,xclv_Main.AsView.Width + 5dip,xclv_Main.AsView.Height)
		If m_SelectionIconAlignment = getSelectionIconAlignment_Right Then	SetLayoutAnimated(xlbl_RootCheckItem,200,xpnl_SubItemListBase.Width - m_TextGap*2 - xlbl_RootCheckItem.Width,xlbl_RootCheckItem.Top,xlbl_RootCheckItem.Width,xlbl_RootCheckItem.Height)
		SetLayoutAnimated(xpnl_SubItemListBase,200,xpnl_SubItemListBase.Left,xpnl_SubItemListBase.Top + 10dip,xpnl_SubItemListBase.Width - 5dip,g_ItemProperties.Height)
	Else
		SetLayoutAnimated(xpnl_SubItemListBase,200,xpnl_SubItemListBase.Left,xpnl_SubItemListBase.Top,xpnl_SubItemListBase.Width,g_ItemProperties.Height)
	End If

	Dim xbblbl_ItemText As BBLabel
		
	For Each v As B4XView In xpnl_RootItemBackground.GetAllViewsRecursive
		If v.Tag Is BBLabel And v.Tag.As(BBLabel).Tag = "xbblbl_ItemText" Then
			xbblbl_ItemText = v.Tag
		End If
	Next

	If m_SelectionIconAlignment = getSelectionIconAlignment_Left Then
		xbblbl_ItemText.mBase.Width = xpnl_RootItemBackground.Width - xbblbl_ItemText.mBase.Left - m_TextGap*2
	Else
		xbblbl_ItemText.mBase.Width = xpnl_RootItemBackground.Width - xbblbl_ItemText.mBase.Left - m_TextGap*2 - xlbl_RootCheckItem.Width - m_TextGap
	End If
	
	xlbl_RootCollapsButton.SetRotationAnimated(200,0)
	xpnl_SubItemBackground.SetColorAnimated(200,xpnl_SubItemBackground.Color,xui.Color_Transparent)
	Sleep(200)
	xpnl_SubItemBackground.Visible = False
	
	xpnl_RootItemBackground.RemoveViewFromParent
	xpnl_RootClvPanelBackground.AddView(xpnl_RootItemBackground,m_SideGap,0,mBase.Width-m_SideGap*2,xpnl_RootItemBackground.Height)
	xpnl_RootItemBackground.SendToBack
	xclv_SubItems.Clear
	m_isSubMenuOpen = False
	
	If xclv_Main.Size > 0 Then
		Dim CurrentIndex As Int = xclv_Main.GetItemFromView(xpnl_RootClvPanelBackground)
		If CurrentIndex = 0 Or CurrentIndex = (xclv_Main.Size -1) Then 'Runde Ecken beim 1. und letzten item
			xpnl_RootItemBackground.SetColorAndBorder(xpnl_RootItemBackground.Color,0,0,m_CornerRadius)
			SetPanelCornerRadius(xpnl_RootItemBackground,m_CornerRadius,IIf(CurrentIndex = 0,True,False),IIf(CurrentIndex = 0,True,False),IIf(CurrentIndex = (xclv_Main.Size -1),True,False),IIf(CurrentIndex = (xclv_Main.Size -1),True,False))
		End If
	End If

End Sub

#End Region

#Region Properties

'Defaults:
'xFont - <code>xui.CreateMaterialIcons(20)</code>
'CheckedIcon - <code>Chr(0xE5CA)</code>
'UncheckIcon - <code>""</code>
Public Sub getCheckItemProperties As AS_SelectionList_CheckItemProperties
	Return g_CheckItemProperties
End Sub

'If False then no Empty list text is displayed
Public Sub setEmptyListTextVisibility(Visible As Boolean)
	m_EmptyListTextVisibility = Visible
End Sub

Public Sub getEmptyListTextVisibility As Boolean
	Return m_EmptyListTextVisibility
End Sub

'<code>AS_SelectionList1.EmptyListTextLabel.Font = xui.CreateDefaultBoldFont(20)</code>
Public Sub getEmptyListTextLabel As B4XView
	Return xlbl_EmptyListText
End Sub

'<code>AS_SelectionList1.EmptySearchListText = "No items found"</code>
Public Sub setEmptySearchListText(Text As String)
	m_EmptySearchListText = Text
End Sub

Public Sub getEmptySearchListText As String
	Return m_EmptySearchListText
End Sub

'<code>AS_SelectionList1.EmptyListText = "Nothing here yet"</code>
Public Sub setEmptyListText(Text As String)
	m_EmptyListText = Text
End Sub

Public Sub getEmptyListText As String
	Return m_EmptyListText
End Sub

'The text color of the searched text when searching for something via SearchByText
Public Sub setSearchTextHighlightedColor(Color As Int)
	m_SearchTextHighlightedColor = Color
End Sub

Public Sub getSearchTextHighlightedColor As Int
	Return m_SearchTextHighlightedColor
End Sub

'Left or Right
'Default: Right
Public Sub setSelectionIconAlignment(Alignment As String)
	m_SelectionIconAlignment = Alignment
End Sub

Public Sub getSelectionIconAlignment As String
	Return m_SelectionIconAlignment
End Sub

Public Sub setShowSeperators(ShowSeperators As Boolean)
	m_ShowSeperators = ShowSeperators
End Sub

Public Sub getShowSeperators As Boolean
	Return m_ShowSeperators
End Sub

Public Sub setCornerRadius(CornerRadius As Float)
	m_CornerRadius = CornerRadius
End Sub

Public Sub getCornerRadius As Float
	Return m_CornerRadius
End Sub

'<code>AS_SelectionList1.RootItemClickBehavior = AS_SelectionList1.RootItemClickBehavior_CloseSubMenu</code>
Public Sub setRootItemClickBehavior(RootItemClickBehavior As String)
	m_RootItemClickBehavior = RootItemClickBehavior
End Sub

Public Sub getRootItemClickBehavior As String
	Return m_RootItemClickBehavior
End Sub

'Default: 10dip
Public Sub setSideGap(SideGap As Float)
	m_SideGap = SideGap
End Sub

Public Sub getSideGap As Float
	Return m_SideGap
End Sub

'Fade or None
Public Sub setThemeChangeTransition(ThemeChangeTransition As String)
	m_ThemeChangeTransition = ThemeChangeTransition
End Sub

Public Sub getThemeChangeTransition As String
	Return m_ThemeChangeTransition
End Sub

Public Sub setHapticFeedback(HapticFeedback As Boolean)
	m_HapticFeedback = HapticFeedback
End Sub

Public Sub getHapticFeedback As Boolean
	Return m_HapticFeedback
End Sub

'Single or Multi
Public Sub getSelectionMode As String
	Return m_SelectionMode
End Sub

Public Sub setSelectionMode(SelectionMode As String)
	m_SelectionMode = SelectionMode
End Sub

'Only in SelectionMode = Multi - Defines the maximum number of items that may be selected
'Default: 0
Public Sub setMaxSelectionCount(MaxSelecion As Int)
	m_MaxSelectionCount = MaxSelecion
End Sub

Public Sub getMaxSelectionCount As Int
	Return m_MaxSelectionCount
End Sub

Public Sub getSize As Int
	Return m_DataMap.Size
End Sub

Public Sub setBackgroundColor(BackgroundColor As Int)
	m_BackgroundColor = BackgroundColor
	mBase.Color = BackgroundColor
	xclv_Main.AsView.Color = BackgroundColor
	xclv_Main.sv.ScrollViewInnerPanel.Color = BackgroundColor
	xclv_Main.GetBase.Color = BackgroundColor
	xclv_SubItems.AsView.Color = BackgroundColor
	xclv_SubItems.sv.ScrollViewInnerPanel.Color = BackgroundColor
	xclv_SubItems.GetBase.Color = BackgroundColor
End Sub

Public Sub getBackgroundColor As Int
	Return m_BackgroundColor
End Sub

'Height: Default: 50dip
Public Sub getItemProperties As AS_SelectionList_ItemProperties
	Return g_ItemProperties
End Sub

'Height: Default: 50dip
Public Sub getSubItemProperties As AS_SelectionList_SubItemProperties
	Return g_SubItemProperties
End Sub

Public Sub getSelectedItemProperties As AS_SelectionList_SelectedItemProperties
	Return g_SelectedItemProperties
End Sub

Public Sub getSelectedSubItemPropertiess As AS_SelectionList_SelectedSubItemProperties
	Return g_SelectedSubItemPropertiess
End Sub

Public Sub getSearchText As String
	Return m_SearchByText
End Sub

Public Sub setSearchText(SearchText As String)
	m_SearchByText = SearchText
End Sub

#End Region

#Region InternFunctions

Private Sub AddItemIntern(Item As AS_SelectionList_Item,Add2DataMap As Boolean)

	Dim xpnl_Background As B4XView = xui.CreatePanel("")
	xpnl_Background.SetLayoutAnimated(0,0,0,mBase.Width,g_ItemProperties.Height)
	xpnl_Background.Color = m_BackgroundColor
	
	If Add2DataMap Then m_DataMap.Put(Item,xclv_Main.Size)
	xclv_Main.Add(xpnl_Background,Item)
	xlbl_EmptyListText.Visible = False
End Sub

Private Sub ClearListIntern(xclv As CustomListView,SkipSubMenuItem As Boolean)
	For i = 0 To xclv.Size -1
		
		If SkipSubMenuItem And xpnl_RootClvPanelBackground.IsInitialized And xclv.GetValue(i) = xpnl_RootClvPanelBackground.Tag Then Continue
		
		xclv.GetPanel(i).RemoveAllViews
	Next
	xclv.Refresh
End Sub

Private Sub SetSelectionIntern(Values As Map)
	xiv_RefreshImage.SetBitmap(mBase.Snapshot)
	xiv_RefreshImage.SetVisibleAnimated(0,True)
	Sleep(0)
	
	m_SelectionMap.Clear
	FillSelectionMap(xclv_Main,m_DataMap,Values)
	FillSelectionMap(xclv_SubItems,m_SubDataMap,Values)

	Sleep(0)
	xiv_RefreshImage.SetVisibleAnimated(0,False)
End Sub

Private Sub FillSelectionMap(xclv As CustomListView,DataMap As B4XOrderedMap,Values As Map)


	For Each Item As AS_SelectionList_Item In DataMap.Keys
		
		If DataMap.Get(Item) Is List Then
			Dim lstSubItems As List = DataMap.Get(Item)
			
			For Each SubItem As AS_SelectionList_SubItem In lstSubItems
				
				For Each SetValue As Object In Values.Keys
					If SetValue.As(String) = SubItem.Value.As(String) Then
						m_SelectionMap.Put(SubItem,"")
					End If
				Next
				
			Next
			
		Else
			
			For Each SetValue As Object In Values.Keys
				If SetValue.As(String) = Item.Value.As(String) Then
					m_SelectionMap.Put(Item,"")
				End If
			Next
			
		End If

	Next
	
	For i = 0 To xclv.Size -1
		xclv.GetPanel(i).RemoveAllViews
	Next
	xclv.Refresh
End Sub

Private Sub BuildItem(xpnl_Background As B4XView,Item As Object,xclv As CustomListView)
	
	Dim CurrentIndex As Int = xclv.GetItemFromView(xpnl_Background)
	Dim SideGap As Float = IIf(xclv = xclv_Main,m_SideGap,0)
	Dim ItemWidth As Float = IIf(xclv = xclv_Main,mBase.Width - SideGap*2,mBase.Width-m_SideGap*2 + IIf(CurrentIndex > 0,m_TextGap,0))
	Dim CheckItemWidth As Float = 20dip
	
	Dim Text As String
	Dim Icon As B4XBitmap
	
	Dim BackgroundColor As Int
	Dim xFont As B4XFont
	Dim TextColor As Int
	Dim SeperatorColor As Int
	'Dim Height As Float
	
	Dim SelectedBackgroundColor As Int
	Dim SelectedTextColor As Int
	Dim SelectedFont As B4XFont
	
	If Item Is AS_SelectionList_Item Then
		Text = Item.As(AS_SelectionList_Item).Text
		Icon = Item.As(AS_SelectionList_Item).Icon
		BackgroundColor = g_ItemProperties.BackgroundColor
		xFont = g_ItemProperties.xFont
		TextColor = g_ItemProperties.TextColor
		SeperatorColor = g_ItemProperties.SeperatorColor
		'Height = g_ItemProperties.Height
		SelectedBackgroundColor = g_SelectedItemProperties.BackgroundColor
		SelectedFont = g_SelectedItemProperties.xFont
		SelectedTextColor = g_SelectedItemProperties.TextColor
	Else
		Text = Item.As(AS_SelectionList_SubItem).Text
		Icon = Item.As(AS_SelectionList_SubItem).Icon
		BackgroundColor = g_SubItemProperties.BackgroundColor
		xFont = g_SubItemProperties.xFont
		TextColor = g_SubItemProperties.TextColor
		SeperatorColor = g_SubItemProperties.SeperatorColor
		SelectedBackgroundColor = g_SelectedSubItemPropertiess.BackgroundColor
		SelectedFont = g_SelectedSubItemPropertiess.xFont
		SelectedTextColor = g_SelectedSubItemPropertiess.TextColor
		'Height = g_SubItemProperties.Height
	End If
	
	Dim isSelected As Boolean = m_SelectionMap.ContainsKey(Item)
	
	Dim xpnl_ItemBackground As B4XView = xui.CreatePanel("")
	xpnl_ItemBackground.Tag = "xpnl_ItemBackground"
	xpnl_Background.AddView(xpnl_ItemBackground,SideGap,0,ItemWidth,xpnl_Background.Height)
	xpnl_Background.Color = m_BackgroundColor
	xpnl_ItemBackground.Color = IIf(isSelected,SelectedBackgroundColor, BackgroundColor)
	

'	Dim xlbl_ItemText As B4XView = CreateLabel("")
'	xlbl_ItemText.Tag = "xlbl_ItemText"
'	xlbl_ItemText.Text = Text
'	xlbl_ItemText.Font = IIf(isSelected,SelectedFont, xFont)
'	xlbl_ItemText.TextColor = IIf(isSelected,SelectedTextColor, TextColor)
'	xlbl_ItemText.SetTextAlignment("CENTER","LEFT")
'	#If B4I
'	xlbl_ItemText.As(Label).Multiline = True
'	#Else If B4J
'	xlbl_ItemText.As(Label).WrapText = True
'	#Else B4A
'	xlbl_ItemText.As(Label).SingleLine = False
'	#End If
	
	Dim xpnl_ItemText As B4XView = xui.CreatePanel("")
	xpnl_ItemText.SetLayoutAnimated(0,0,0,1dip,1dip)
	
	Dim xlbl_ItemText As B4XView = CreateLabel("")
	xlbl_ItemText.Text = ""
	xlbl_ItemText.Font = IIf(isSelected,SelectedFont, xFont)
	xlbl_ItemText.TextColor = IIf(isSelected,SelectedTextColor, TextColor)
	xlbl_ItemText.SetTextAlignment("CENTER","LEFT")
	
	Dim xbblbl_ItemText As BBLabel
	xbblbl_ItemText.Initialize(Me,"xbblbl_ItemText")
	xbblbl_ItemText.DesignerCreateView(xpnl_ItemText,xlbl_ItemText,CreateMap())
	xbblbl_ItemText.TextEngine = m_TextEngine
	xbblbl_ItemText.Tag = "xbblbl_ItemText"
	
	
	Dim xlbl_CheckItem As B4XView = CreateLabel("")
	xlbl_CheckItem.Tag = "xlbl_CheckItem"
	xlbl_CheckItem.TextColor = IIf(isSelected,g_CheckItemProperties.SelectedTextColor, g_CheckItemProperties.UnselectedTextColor)
	xlbl_CheckItem.SetTextAlignment("CENTER","CENTER")
	xlbl_CheckItem.Font = g_CheckItemProperties.xFont
	
	If m_SelectionMap.ContainsKey(Item) Then
		xlbl_CheckItem.Text = g_CheckItemProperties.CheckedIcon
	Else
		xlbl_CheckItem.Text = g_CheckItemProperties.UncheckIcon
	End If

	Dim xpnl_Seperator As B4XView = xui.CreatePanel("")
	xpnl_Seperator.Tag = "xpnl_Seperator"
	xpnl_Seperator.Color = SeperatorColor

	xpnl_ItemBackground.AddView(xpnl_ItemText,m_TextGap,0,xpnl_ItemBackground.Width - CheckItemWidth - m_TextGap*3,xpnl_ItemBackground.Height)
	xpnl_ItemBackground.AddView(xlbl_CheckItem,xpnl_ItemBackground.Width - CheckItemWidth - m_TextGap,0,CheckItemWidth,xpnl_ItemBackground.Height)
	
	Dim xiv_Icon As B4XView = CreateImageView("")
	If Icon.IsInitialized Then
		xpnl_ItemBackground.AddView(xiv_Icon,m_TextGap + IIf(m_SelectionIconAlignment = getSelectionIconAlignment_Left,CheckItemWidth + m_TextGap,0),(xpnl_Background.Height)/2 - ((xpnl_Background.Height)/2)/2,(xpnl_Background.Height)/2,(xpnl_Background.Height)/2)
		xpnl_ItemText.Left = xiv_Icon.Left + xiv_Icon.Width + m_TextGap
		xpnl_ItemText.Width = xpnl_ItemBackground.Width - xiv_Icon.Left - xiv_Icon.Width - IIf(m_SelectionIconAlignment = getSelectionIconAlignment_Right,xpnl_ItemBackground.Width - xlbl_CheckItem.Left,0) - m_TextGap*2
		xiv_Icon.SetBitmap(Icon)
	End If
	
	xpnl_Seperator.Visible = m_ShowSeperators And CurrentIndex > 0

	If CurrentIndex = 0 Or CurrentIndex = (xclv.Size -1) Then 'Runde Ecken beim 1. und letzten item
		xpnl_ItemBackground.SetColorAndBorder(xpnl_ItemBackground.Color,0,0,m_CornerRadius)
		SetPanelCornerRadius(xpnl_ItemBackground,m_CornerRadius,IIf(CurrentIndex = 0,True,False),IIf(CurrentIndex = 0,True,False),IIf(CurrentIndex = (xclv.Size -1),True,False),IIf(CurrentIndex = (xclv.Size -1),True,False))
	End If
	
	'If Item Is AS_SelectionList_Item Then
	'RootItem
	Dim xlbl_CollapsButton As B4XView = CreateLabel("xlbl_CollapsButton")
	xlbl_CollapsButton.Tag = "xlbl_CollapsButton"
	xlbl_CollapsButton.Text = Chr(0xF105)
	xlbl_CollapsButton.Font = xui.CreateFontAwesome(22)
	xlbl_CollapsButton.TextColor = IIf(isSelected,SelectedTextColor, TextColor)
	xlbl_CollapsButton.SetTextAlignment("CENTER","CENTER")
	xpnl_ItemBackground.AddView(xlbl_CollapsButton,m_TextGap,0dip,CheckItemWidth,xpnl_ItemBackground.Height)
	
	If m_SubDataMap.Size > 0 Then
		xiv_Icon.Left = xlbl_CollapsButton.Left + xlbl_CollapsButton.Width + m_TextGap
		xpnl_ItemText.Left = xlbl_CollapsButton.Left + xlbl_CollapsButton.Width + m_TextGap + IIf(Icon.IsInitialized,xiv_Icon.Width + m_TextGap,0)
		xpnl_ItemText.Width = xpnl_ItemBackground.Width - xpnl_ItemText.Left - xlbl_CheckItem.Width - m_TextGap*2
	End If
		
	If m_isInSearchMode And Item Is AS_SelectionList_Item Then
		
		Dim SearchValueFound As Boolean = False
		
		Dim lstSubItems As List = m_SubDataMap.Get(Item)
		If lstSubItems.IsInitialized Then
			For Each SubItem As AS_SelectionList_SubItem In lstSubItems
				If (m_SearchByText <> "" And SubItem.Text.ToLowerCase.Contains(m_SearchByText.ToLowerCase)) Or (m_SearchByObject <> Null And m_SearchByObject = SubItem.Value) Then
					SearchValueFound = True
					Exit
				End If
			Next
		End If
		
		xlbl_CollapsButton.Visible = SearchValueFound
	Else
		xlbl_CollapsButton.Visible = m_SubDataMap.ContainsKey(Item)
	End If
	
	If xclv = xclv_SubItems And m_isSubMenuOpen And xpnl_RootClvPanelBackground.Tag = Item Then
		xlbl_CollapsButton.SetRotationAnimated(0,90)
	End If
		
	'End If
	
	If Item Is AS_SelectionList_Item And m_SubDataMap.ContainsKey(Item) Then
		
		Dim lstSubItems As List = m_SubDataMap.Get(Item)
		For Each SubItem As AS_SelectionList_SubItem In lstSubItems
				
			If m_SelectionMap.ContainsKey(SubItem) Then
				xlbl_CheckItem.TextColor = IIf(isSelected,SelectedTextColor, TextColor)
				xlbl_CheckItem.Text = Chr(0xE15B)
			End If
			
		Next
		
	End If
	
	If m_SelectionIconAlignment = getSelectionIconAlignment_Left Then
		
		xlbl_CheckItem.Left = m_TextGap
		If Icon.IsInitialized = False Then
			xpnl_ItemText.Left = xlbl_CheckItem.Left + xlbl_CheckItem.Width + m_TextGap
		End If
		
		If m_SelectionIconAlignment = getSelectionIconAlignment_Left And xlbl_CollapsButton.Visible Then
			xlbl_CheckItem.Top = xlbl_CheckItem.Top + IIf(xui.IsB4J,2dip,1dip)
			
			xlbl_CollapsButton.Left = xlbl_CheckItem.Left + xlbl_CheckItem.Width + m_TextGap
			If Icon.IsInitialized Then xiv_Icon.Left = xlbl_CollapsButton.Left + xlbl_CollapsButton.Width + m_TextGap
			xpnl_ItemText.Left = IIf(Icon.IsInitialized,xiv_Icon.Left + xiv_Icon.Width + m_TextGap, xlbl_CollapsButton.Left + xlbl_CollapsButton.Width + m_TextGap)
		End If
		
		xpnl_ItemText.Width = xpnl_ItemBackground.Width - xpnl_ItemText.Left - m_TextGap
		
	End If
	
	If m_SeperatorWidth = getSeperatorWidth_BeginWithText Or (m_SeperatorWidth = getSeperatorWidth_BeginWithIcon And Icon.IsInitialized = False) Then
		xpnl_Background.AddView(xpnl_Seperator,xpnl_ItemBackground.Left + xpnl_ItemText.Left,0,xpnl_ItemBackground.Width - xpnl_ItemText.Left,1dip)
	Else If m_SeperatorWidth = getSeperatorWidth_BeginWithIcon And Icon.IsInitialized Then
		xpnl_Background.AddView(xpnl_Seperator,xpnl_ItemBackground.Left + xiv_Icon.Left,0,xpnl_ItemBackground.Width - xiv_Icon.Left,1dip)
	Else If m_SeperatorWidth = getSeperatorWidth_FullWidth Then
		xpnl_Background.AddView(xpnl_Seperator,xpnl_ItemBackground.Left,0,xpnl_ItemBackground.Width,1dip)
	End If
	
	xbblbl_ItemText.Text = GenerateText(Text,IIf(isSelected,SelectedTextColor, TextColor))
	UpdateBBLabelHeight(xbblbl_ItemText)
	xbblbl_ItemText.DisableResizeEvent = True
	xbblbl_ItemText.ForegroundImageView.Left = 0dip 'set this after you set the text.
	
'	Dim xpnl69 As B4XView = xui.CreatePanel("")
'	xpnl_ItemBackground.AddView(xpnl69,xiv_Icon.Left,xiv_Icon.Top,xiv_Icon.Width,xiv_Icon.Height)
'	xpnl69.Color = xui.Color_Red
'	xlbl_CheckItem.Color = xui.Color_Blue
'	xpnl_ItemText.Color = xui.Color_Magenta
'	xlbl_CollapsButton.Color = xui.Color_Red
	
	Dim Views As AS_SelectionList_CustomDrawItemViews
	Views.Initialize
	Views.BackgroundPanel = xpnl_Background
	Views.ItemBackgroundPanel = xpnl_ItemBackground
	Views.ItemTextLabel = xbblbl_ItemText
	Views.CheckIconLabel = xlbl_CheckItem
	Views.SeperatorPanel = xpnl_Seperator
	Views.IconImageView = xiv_Icon
	Views.CollapsIconLabel = xlbl_CollapsButton
	
	CustomDrawItem(Item,Views)
	
End Sub

Private Sub UpdateBBLabelHeight(lbl As BBLabel)
	Dim par As BCParagraph = lbl.Paragraph
	If par.IsInitialized = False Then Return
	Dim MaxHeight As Int = lbl.mBase.Height
	For Each line As BCTextLine In par.TextLines
		If lbl.Padding.Top + (line.BaselineY + line.MaxHeightBelowBaseLine) / m_TextEngine.mScale > MaxHeight Then
			Dim Height As Double = lbl.Padding.Top + (line.BaselineY - line.MaxHeightAboveBaseLine) / m_TextEngine.mScale - 1dip
			
			Dim ClipPanel As B4XView = xui.CreatePanel("")
			ClipPanel.Color = xui.Color_Red'xui.Color_Transparent
			lbl.mBase.AddView(ClipPanel,0,Height,lbl.mBase.Width,Height)
			lbl.mBase.Top = lbl.mBase.Top + (lbl.mBase.Height - Height)
			'lbl.Text = lbl.Text & "..."

			Exit
		End If
	Next
End Sub


Private Sub GenerateText(MainText As String,TextColor As Int) As String
	If m_SearchByText = "" Then Return MainText
	Dim MainTextLower As String = MainText.ToLowerCase
	Dim SearchTextLower As String = m_SearchByText.ToLowerCase
	
	' Check if the SearchTextLower exists in MainText
	If SearchTextLower = "" Or Not(MainTextLower.Contains(SearchTextLower)) Then
		Return MainText ' No highlighting if SearchTextLower is empty or not found
	End If
    
	' Initialize variables
	Dim StartIndex As Int = MainTextLower.IndexOf(SearchTextLower)
	Dim EndIndex As Int = StartIndex + SearchTextLower.Length

	' Split MainText into parts
	Dim BeforeText As String = MainText.SubString2(0, Min(MainText.Length,StartIndex))
	Dim HighlightText As String = MainText.SubString2(StartIndex,Min(MainText.Length, EndIndex))
	Dim AfterText As String = MainText.SubString(EndIndex)

	' Create BBCode
	Dim Result As String
	Result = $"[color=#${ColorToHex(TextColor)}]${BeforeText}[/color][color=#${ColorToHex(m_SearchTextHighlightedColor)}]${HighlightText}[/color][color=#${ColorToHex(TextColor)}]${AfterText}[/color]"$

	Return Result
End Sub

#End Region

#Region ViewEvents

#If B4J
Private Sub xpnl_SubItemBackground_MouseClicked (EventData As MouseEvent)
#Else
Private Sub xpnl_SubItemBackground_Click
#End If

	CloseSubMenu
	
End Sub

Private Sub xclv_Main_ItemClick (Index As Int, Value As Object)
	
	Dim xclv As CustomListView = Sender
	
	If m_SubDataMap.ContainsKey(Value) Then
		
		If m_isSubMenuOpen Then
			
			Select m_RootItemClickBehavior
				Case getRootItemClickBehavior_CloseSubMenu
					CloseSubMenu
				Case getRootItemClickBehavior_SelectAllSubItems
					
					'Select all sub items from the root item, unless all are already selected, then deselect all
					Dim lstSubItems As List = m_SubDataMap.Get(Value)
					Dim IndexCounter As Int = 0
					For Each SubItem As AS_SelectionList_SubItem In lstSubItems
						ItemClickIntern(SubItem,IndexCounter+1,xclv_SubItems,False)
						IndexCounter = IndexCounter +1
						SelectionItemChanged(SubItem,m_SelectionMap.ContainsKey(SubItem))
					Next
					
				Case getRootItemClickBehavior_SelectRootItem
					
					ItemClickIntern(Value,0,xclv_SubItems,True)
					
			End Select
			
			Return
		End If
		
		'Aufklappen
		'Hintergrund Abdunkeln
		'Neues Panel erstellen was übern Item liegt
		'1. Item ist das root element welches man dort anhaken kann
		'darunter die subitems
		m_isSubMenuOpen = True
		xpnl_RootClvPanelBackground = xclv_Main.GetPanel(Index)
		xpnl_SubItemBackground.SetLayoutAnimated(0,0,0,mBase.Width,mBase.Height)
		xpnl_RootClvPanelBackground.Tag = xclv_Main.GetValue(Index)
		Dim xbblbl_ItemText As BBLabel
		
		For Each v As B4XView In xclv_Main.GetPanel(Index).GetAllViewsRecursive
			If v.Tag Is String And v.Tag = "xlbl_CollapsButton" Then
				xlbl_RootCollapsButton = v
			Else If v.Tag Is String And v.Tag = "xpnl_ItemBackground" Then
				xpnl_RootItemBackground = v
			Else If v.Tag Is String And v.Tag = "xlbl_CheckItem" Then
				xlbl_RootCheckItem = v
			Else If v.Tag Is BBLabel And v.Tag.As(BBLabel).Tag = "xbblbl_ItemText" Then
				xbblbl_ItemText = v.Tag
			End If
		Next
		xlbl_RootCollapsButton.SetRotationAnimated(200,90)
		
		Dim lstSubItems As List = m_SubDataMap.Get(Value)
		
		'Dim MaxVisibleItems As Int = Ceil(g_ItemProperties.Height/lstSubItems.Size)
		
		Dim FinalListWidth As Float = mBase.Width-m_SideGap*2 + IIf(Index > 0,m_TextGap,0)
		
		xpnl_RootItemBackground.RemoveViewFromParent
		
		Dim xpnl_Background As B4XView = xui.CreatePanel("")
		xpnl_Background.SetLayoutAnimated(0,0,0,FinalListWidth,g_ItemProperties.Height)
		xpnl_Background.Color = m_BackgroundColor
		xpnl_Background.AddView(xpnl_RootItemBackground,0,0,FinalListWidth,xpnl_SubItemListBase.Height)
		
		xclv_SubItems.Add(xpnl_Background,Value)
		
		For Each SubItem As AS_SelectionList_SubItem In lstSubItems
			
			If m_isInSearchMode And (m_SearchByText <> "" And SubItem.Text.ToLowerCase.Contains(m_SearchByText.ToLowerCase)) Or (m_SearchByObject <> Null And m_SearchByObject = SubItem.Value) Then
				
			Else if m_isInSearchMode Then
				Continue
			End If
			
			Dim xpnl_Background As B4XView = xui.CreatePanel("")
			xpnl_Background.SetLayoutAnimated(0,0,0,FinalListWidth,g_ItemProperties.Height)
			xpnl_Background.Color = m_BackgroundColor
	
			xclv_SubItems.Add(xpnl_Background,SubItem)
				
		Next
	
		Dim RawListItem As CLVItem = xclv_Main.GetRawListItem(Index) 'Gets the raw list item
		Dim Top As Float = (RawListItem.Offset - xclv_Main.sv.ScrollViewOffsetY) '+ RawListItem.Panel.Height 'Calculates the right top
		
		Dim Height As Float = Min(xclv_Main.AsView.Height - Top, g_ItemProperties.Height*(xclv_SubItems.Size)) 'Action Menu Height
   
		If Top + Height > xpnl_SubItemBackground.Height Then 'If the menu no longer fits on the screen, display the menu above the list item
			Top = xpnl_SubItemBackground.Height - Height
		End If
		
		xpnl_SubItemListBase.SetLayoutAnimated(0,m_SideGap,Top,mBase.Width-m_SideGap*2,g_ItemProperties.Height)
		xclv_SubItems.Base_Resize(FinalListWidth,Height)
		
		#If B4I or B4A
		SetCircleClip(xpnl_SubItemListBase,m_CornerRadius)
		#End If
		
		SetPanelCornerRadius(xpnl_RootItemBackground,0,True,True,True,True)
		
		xpnl_SubItemBackground.Visible = True
		xpnl_SubItemBackground.SetColorAnimated(200,xpnl_SubItemBackground.Color,xui.Color_ARGB(100,0,0,0))
		If Index > 0 Then
			SetLayoutAnimated(xpnl_SubItemListBase,200,xpnl_SubItemListBase.Left,xpnl_SubItemListBase.Top - 10dip,FinalListWidth,Height)
			SetLayoutAnimated(xclv_Main.AsView,200,5dip,xclv_Main.AsView.Top,xclv_Main.AsView.Width - 5dip,xclv_Main.AsView.Height)
		Else
			SetLayoutAnimated(xpnl_SubItemListBase,200,xpnl_SubItemListBase.Left,xpnl_SubItemListBase.Top,FinalListWidth,Height)
		End If
		
		If m_SelectionIconAlignment = getSelectionIconAlignment_Right Then
			SetLayoutAnimated(xlbl_RootCheckItem,200,FinalListWidth - xlbl_RootCheckItem.Width - m_TextGap,xlbl_RootCheckItem.Top,xlbl_RootCheckItem.Width,xlbl_RootCheckItem.Height)
			xbblbl_ItemText.mBase.Width = xpnl_RootItemBackground.Width - xbblbl_ItemText.mBase.Left - m_TextGap - xlbl_RootCheckItem.Width - m_TextGap
			Else
			xbblbl_ItemText.mBase.Width = xpnl_RootItemBackground.Width - xbblbl_ItemText.mBase.Left - m_TextGap
		End If
		
		xclv_SubItems.Refresh
'		Sleep(200)
'		SetCircleClip(xpnl_SubItemListBase,m_CornerRadius)
	Else
			
		
			
		ItemClickIntern(Value,Index,xclv,True)
		
	End If

End Sub

Private Sub ItemClickIntern(ThisItem As Object,Index As Int,xclv As CustomListView,WithEvent As Boolean)
	Dim isSubMenuOpen As Boolean = m_isSubMenuOpen
	If m_SelectionMap.ContainsKey(ThisItem) And m_CanDeselect Then
		m_SelectionMap.Remove(ThisItem)
		HandleSelection(xclv.GetPanel(Index),xclv)
		If WithEvent Then SelectionChanged(ThisItem,False)
	Else If m_SelectionMap.ContainsKey(ThisItem) = False Then
		
		If m_SelectionMode = "Single" Then
			
			If m_SelectionMap.Size > 0 Then
				
				For Each k As Object In m_SelectionMap.Keys
					SelectionItemChanged(k,False)
				Next
				
				m_SelectionMap.Clear
				ClearListIntern(xclv_Main,True)
				ClearListIntern(xclv_SubItems,True)
			End If
			
'			For i = 0 To xclv.size -1
'				If m_SelectionMap.ContainsKey(xclv.GetValue(i)) Then
'					m_SelectionMap.Clear
'					ClearListIntern(xclv_Main)
'					ClearListIntern(xclv_SubItems)
'					Exit
'				End If
'			Next
			m_SelectionMap.Put(ThisItem,Index)
			HandleSelection(xclv.GetPanel(Index),xclv)
			If WithEvent Then SelectionChanged(ThisItem,True)
			If m_isSubMenuOpen Then CloseSubMenu
		Else If m_SelectionMode = "Multi" Then
			If m_MaxSelectionCount > 0 And m_MaxSelectionCount = m_SelectionMap.Size Then Return
			m_SelectionMap.Put(ThisItem,Index)
			HandleSelection(xclv.GetPanel(Index),xclv)
			If WithEvent Then SelectionChanged(ThisItem,True)
		End If
		
	End If
	
	If isSubMenuOpen Then

		RefreshRootItem
		
	End If
	
End Sub

Private Sub RefreshRootItem
	Dim Item As AS_SelectionList_Item = xpnl_RootClvPanelBackground.Tag
	If Item Is AS_SelectionList_Item And m_SubDataMap.ContainsKey(Item) Then
		
		Dim lstSubItems As List = m_SubDataMap.Get(Item)
		For Each SubItem As AS_SelectionList_SubItem In lstSubItems
				
			If m_SelectionMap.ContainsKey(SubItem) Then
				xlbl_RootCheckItem.TextColor = g_SelectedItemProperties.TextColor
				xlbl_RootCheckItem.Text = Chr(0xE15B)
				Exit
			else If m_SelectionMap.ContainsKey(Item) Then
				xlbl_RootCheckItem.TextColor = g_SelectedItemProperties.TextColor
				xlbl_RootCheckItem.Text = Chr(0xE5CA)
				Exit
			Else
				xlbl_RootCheckItem.Text = ""
			End If
			
		Next
		
	End If
End Sub

Private Sub HandleSelection(xpnl_Background As B4XView,xclv As CustomListView)
	
	Dim Index As Int = xclv.GetItemFromView(xpnl_Background)
    xpnl_Background.RemoveAllViews
	BuildItem(xpnl_Background,xclv.GetValue(Index),xclv)

End Sub


Private Sub xclv_Main_VisibleRangeChanged (FirstIndex As Int, LastIndex As Int)
	Dim xclv As CustomListView = Sender
	Dim ExtraSize As Int = 20
	For i = 0 To xclv.Size - 1
		Dim p As B4XView = xclv.GetPanel(i)
		If i > FirstIndex - ExtraSize And i < LastIndex + ExtraSize Then
			'visible+
			If p.NumberOfViews = 0 Then
				BuildItem(p,xclv.GetValue(i),xclv)
			End If
		Else
			'not visible
			If p.NumberOfViews > 0 Then
				p.RemoveAllViews
			End If
		End If
	Next
End Sub

#End Region

#Region Events

Private Sub SelectionChanged(Item As Object,Checked As Boolean)
	If Item <> Null Then SelectionItemChanged(Item,Checked)
	If m_HapticFeedback Then XUIViewsUtils.PerformHapticFeedback(mBase)
	If xui.SubExists(mCallBack, mEventName & "_SelectionChanged",0) Then
		CallSub(mCallBack, mEventName & "_SelectionChanged")
	End If
End Sub

Private Sub CustomDrawItem(Item As Object,Views As AS_SelectionList_CustomDrawItemViews)
	If xui.SubExists(mCallBack, mEventName & "_CustomDrawItem",2) Then
		CallSub3(mCallBack, mEventName & "_CustomDrawItem",Item,Views)
	End If
End Sub

Private Sub SelectionItemChanged(Item As Object,Checked As Boolean)
	If xui.SubExists(mCallBack, mEventName & "_SelectionItemChanged",2) Then
		CallSub3(mCallBack, mEventName & "_SelectionItemChanged",Item,Checked)
	End If
End Sub

#End Region

#Region Enums

Public Sub getThemeChangeTransition_Fade As String
	Return "Fade"
End Sub

Public Sub getThemeChangeTransition_None As String
	Return "None"
End Sub

Public Sub getSelectionMode_Single As String
	Return "Single"
End Sub

Public Sub getSelectionMode_Multi As String
	Return "Multi"
End Sub


Public Sub getSeperatorWidth_BeginWithText As String
	Return "BeginWithText"
End Sub

Public Sub getSeperatorWidth_BeginWithIcon As String
	Return "BeginWithIcon"
End Sub

Public Sub getSeperatorWidth_FullWidth As String
	Return "FullWidth"
End Sub

Public Sub getRootItemClickBehavior_CloseSubMenu As String
	Return "CloseSubMenu"
End Sub

Public Sub getRootItemClickBehavior_SelectRootItem As String
	Return "SelectRootItem"
End Sub

'Takes into account the SelectionMode and MaxSelectionCount
Public Sub getRootItemClickBehavior_SelectAllSubItems As String
	Return "SelectAllSubItems"
End Sub


Public Sub getSelectionIconAlignment_Left As String
	Return "LEFT"
End Sub

Public Sub getSelectionIconAlignment_Right As String
	Return "RIGHT"
End Sub

#End Region

#Region Functions

Private Sub ColorToHex(clr As Int) As String
	Dim bc As ByteConverter
	Dim Hex As String = bc.HexFromBytes(bc.IntsToBytes(Array As Int(clr)))
	If Hex.Length > 6 Then Hex = Hex.SubString(Hex.Length - 6)
	Return Hex
End Sub

Private Sub ini_xclv(EventName As String,Parent As B4XView,ShowScrollBar As Boolean) As CustomListView
	Dim tmplbl As Label
	tmplbl.Initialize("")
 
	Dim clv As CustomListView
 
	Dim tmpmap As Map
	tmpmap.Initialize
	tmpmap.Put("DividerColor",0x00FFFFFF)
	tmpmap.Put("DividerHeight",0)
	tmpmap.Put("PressedColor",0x00FFFFFF)
	tmpmap.Put("InsertAnimationDuration",0)
	tmpmap.Put("ListOrientation","Vertical")
	tmpmap.Put("ShowScrollBar",False)
	clv.Initialize(Me,EventName)
	clv.DesignerCreateView(Parent,tmplbl,tmpmap)

	#If B4I
	Do While clv.sv.IsInitialized = False
		'Sleep(0)
	Loop
	Dim sv As ScrollView = clv.sv
	sv.Color = xui.Color_Transparent
	clv.sv.As(NativeObject).SetField("contentInsetAdjustmentBehavior", 1) 'Always
	#Else IF B4J
	clv.sv.As(ScrollPane).Style = "-fx-background:transparent;-fx-background-color:transparent;"
	#End If
	
	Return clv
	
End Sub

Private Sub CreateLabel(EventName As String) As B4XView
	Dim lbl As Label
	lbl.Initialize(EventName)
	Return lbl
End Sub

Private Sub CreateImageView(EventName As String) As B4XView
	Dim iv As ImageView
	iv.Initialize(EventName)
	Return iv
End Sub

'https://www.b4x.com/android/forum/threads/fontawesome-to-bitmap.95155/post-603250
Public Sub FontToBitmap (text As String, IsMaterialIcons As Boolean, FontSize As Float, color As Int) As B4XBitmap
	Dim xui As XUI
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, 32dip, 32dip)
	Dim cvs1 As B4XCanvas
	cvs1.Initialize(p)
	Dim fnt As B4XFont
	If IsMaterialIcons Then fnt = xui.CreateMaterialIcons(FontSize) Else fnt = xui.CreateFontAwesome(FontSize)
	Dim r As B4XRect = cvs1.MeasureText(text, fnt)
	Dim BaseLine As Int = cvs1.TargetRect.CenterY - r.Height / 2 - r.Top
	cvs1.DrawText(text, cvs1.TargetRect.CenterX, BaseLine, fnt, color, "CENTER")
	Dim b As B4XBitmap = cvs1.CreateBitmap
	cvs1.Release
	Return b
End Sub

Private Sub SetCircleClip (pnl As B4XView,radius As Int)'ignore
#if B4J
	Dim jo As JavaObject = pnl
	Dim shape As JavaObject
	Dim cx As Double = pnl.Width
	Dim cy As Double = pnl.Height
	shape.InitializeNewInstance("javafx.scene.shape.Rectangle", Array(cx, cy))
	If radius > 0 Then
		Dim d As Double = radius
		shape.RunMethod("setArcHeight", Array(d))
		shape.RunMethod("setArcWidth", Array(d))
	End If
	jo.RunMethod("setClip", Array(shape))
#else if B4A
	Dim jo As JavaObject = pnl
	jo.RunMethod("setClipToOutline", Array(True))
	pnl.SetColorAndBorder(pnl.Color,0,0,radius)
	#Else If B4I
	Dim NaObj As NativeObject = pnl
	Dim BorderWidth As Float = NaObj.GetField("layer").GetField("borderWidth").AsNumber
	' *** Get border color ***
	'Dim noMe As NativeObject = Me
	'Dim BorderUIColor As Int = noMe.UIColorToColor (noMe.RunMethod ("borderColor:", Array (pnl)))
	pnl.SetColorAndBorder(pnl.Color,BorderWidth,xui.Color_Transparent,radius)
#end if
End Sub

'https://www.b4x.com/android/forum/threads/b4x-setpanelcornerradius-only-for-certain-corners.164567/
Private Sub SetPanelCornerRadius(View As B4XView, CornerRadius As Float,TopLeft As Boolean,TopRight As Boolean,BottomLeft As Boolean,BottomRight As Boolean) 
    #If B4I
	'https://www.b4x.com/android/forum/threads/individually-change-corner-radius-of-a-view.127751/post-800352
    View.SetColorAndBorder(View.Color,0,0,CornerRadius)
    Dim CornerSum As Int = IIf(TopLeft,1,0) + IIf(TopRight,2,0) + IIf(BottomLeft,4,0) + IIf(BottomRight,8,0)
    View.As(NativeObject).GetField ("layer").SetField ("maskedCorners", CornerSum)
    #Else If B4A
	'https://www.b4x.com/android/forum/threads/gradientdrawable-with-different-corner-radius.51475/post-322392
    Dim cdw As ColorDrawable
    cdw.Initialize(View.Color, 0)
    View.As(View).Background = cdw
    Dim jo As JavaObject = View.As(View).Background
    If View.As(View).Background Is ColorDrawable Or View.As(View).Background Is GradientDrawable Then
        jo.RunMethod("setCornerRadii", Array As Object(Array As Float(IIf(TopLeft,CornerRadius,0), IIf(TopLeft,CornerRadius,0), IIf(TopRight,CornerRadius,0), IIf(TopRight,CornerRadius,0), IIf(BottomRight,CornerRadius,0), IIf(BottomRight,CornerRadius,0), IIf(BottomLeft,CornerRadius,0), IIf(BottomLeft,CornerRadius,0))))
    End If
    #Else If B4J
	'https://www.b4x.com/android/forum/threads/b4x-setpanelcornerradius-only-for-certain-corners.164567/post-1008965
	Dim Corners As String = ""
	Corners = Corners & IIf(TopLeft, CornerRadius, 0) & " "
	Corners = Corners & IIf(TopRight, CornerRadius, 0) & " "
	Corners = Corners & IIf(BottomLeft, CornerRadius, 0) & " "
	Corners = Corners & IIf(BottomRight, CornerRadius, 0)
	CSSUtils.SetStyleProperty(View, "-fx-background-radius", Corners)
    #End If
End Sub

Private Sub SetLayoutAnimated(v As B4XView,Duration As Int, Left As Int,Top As Int,Width As Int,Height As Int)
	#If B4A
	v.SetLayoutAnimated(Duration,Left,Top,Width,v.Height)
	Dim startTime As Long = DateTime.Now
	Dim startHeight As Int = v.Height
	Dim deltaHeight As Int = Height - startHeight
	Dim t As Long = DateTime.Now
	Do While t < startTime + Duration
		Dim h As Int = startHeight + deltaHeight * (t - startTime) / Duration
		v.Height = h
		Sleep(10)
		t = DateTime.Now
	Loop
	v.Height = Height
	#Else
	v.SetLayoutAnimated(Duration,Left,Top,Width,Height)
	#End If
End Sub

#End Region

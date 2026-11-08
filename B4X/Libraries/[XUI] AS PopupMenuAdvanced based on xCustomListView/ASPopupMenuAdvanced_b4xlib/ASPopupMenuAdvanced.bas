B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
#If Documentation

V1.00
	-Release
V1.01
	-Add OpenMenuOnView - opens the view attached on a view
	-Add set IsInSpecialContainer - set it true if the target is on a listview or as a child on a panel where the left and top values differ from the form
	-Add set ActivityHasActionBar
	-Add set OrientationVertical
	-Add set MenuViewGap - sets the gap between the menu and the attached view
		-only affected if you open the menu with OpenMenuOnView
V1.02
	-Add get isOpen - checks if the menu is open
V1.03
	-Add set MenuViewGap - sets the gap between the menu and the attached view
	-Add get TriangleProperties 
	-Add set ShowTriangle - only visible if you open the menu with OpenMenu
		-Default: False
V1.04
	-BugFix
V1.05
	-BugFixes
	-Add OpenMenuAdvanced - You can set the Left, Top and Width value to show the menu on the parent
V1.06
	-Add get BackgroundPanel
V1.07
	-B4I Improvements - the entire screen is now used for the background shadow
		-When the navigation bar was hidden, there was an area at the top that did not go dark when the menu was opened
		-The height of the area is now determined and the gap closed
		-B4XPages is now required in B4I
#End If

#Event: ItemClick(Index as Int,Tag as Object)
#Event: ItemLongClick(Index as Int,Tag as Object)
#Event: MenuClosed

Sub Class_Globals
	Private xui As XUI
	Private mCallBack As Object
	Private mEventName As String
	
	Public AutoHideMs As Int
	Public CloseDurationMs As Int = 500
	Public OpenDurationMs As Int = 250
	
	Private m_MenuViewGap As Float = 0
	
	Private xpnl_Parent As B4XView
	Private xclv As CustomListView
	
	Private xpnl_Background As B4XView
	Private xpnl_Menu As B4XView
	Private xpnl_Triangle As B4XView
	
	Private m_Orientation As String = "Vertical"
	Private m_Radius As Int = 0 'ignore
	
	Private g_OrientationVertical As String
	Private g_OrientationHorizontal As String
	Private g_IsInSpecialContainer As Boolean = False
	Private LeftTop_Root() As Int
	Private actHasActionBar As Boolean = False
	Private max_x,max_y As Float
	Private max_endlessloop As Int = 0
	Private m_ShowTriangle As Boolean = False
	
	Private m_isOpen As Boolean = False
	Private m_TopBarOffset As Float = 0
	
	Type ASPM_TitleLabelPropertiesAdvanced(TextColor As Int,xFont As B4XFont,TextAlignment_Vertical As String,TextAlignment_Horizontal As String,BackgroundColor As Int,ItemBackgroundColor As Int,LeftRightPadding As Float,Height As Float)
	Type ASPM_SeparatorPropertiesAdvanced(Height As Float,BackgroundColor As Int)
	Type ASPM_TrianglePropertiesAdvanced(Color As Int,Width As Float,Height As Float,Left As Float,Top As Float)

	Private g_TitleLabelProperties As ASPM_TitleLabelPropertiesAdvanced
	Private g_SeparatorPropertiesAdvanced As ASPM_SeparatorPropertiesAdvanced
	Private g_TrianglePropertiesAdvanced As ASPM_TrianglePropertiesAdvanced
End Sub

Public Sub setDividerHeight(height As Int)
	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(Parent As B4XView,CallBack As Object,EventName As String)
	mCallBack = CallBack
	mEventName = EventName

	g_OrientationVertical = getOrientationVertical_TOP
	g_OrientationHorizontal = getOrientationHorizontal_MIDDLE
	
	xpnl_Parent = Parent
	max_x = Parent.Width
	max_y = Parent.Height

	xpnl_Background = xui.CreatePanel("xpnl_Background")
	xpnl_Background.Color = xui.Color_Transparent
	Parent.AddView(xpnl_Background,0,0,Parent.Width,Parent.Height)
	xpnl_Background.Visible = False
	
	xpnl_Background.Color = xui.Color_ARGB(152,0,0,0)
	
	xpnl_Menu = xui.CreatePanel("")
	xpnl_Menu.Color = xui.Color_ARGB(255,32, 33, 37)
	
	ini_xclv
	
	g_TitleLabelProperties = CreateASPM_TitleLabelPropertiesAdvanced(xui.Color_White,xui.CreateDefaultBoldFont(18),"CENTER","CENTER",xui.Color_ARGB(255,32, 33, 37),xui.Color_ARGB(255,32, 33, 37),5dip,60dip)
	g_SeparatorPropertiesAdvanced = CreateASPM_SeparatorPropertiesAdvanced(2dip,xui.Color_ARGB(255,255,255,255))
	g_TrianglePropertiesAdvanced = CreateASPM_TrianglePropertiesAdvanced(xui.Color_White,20dip,10dip,-1,-1)
End Sub

Public Sub Resize(ParentWidth As Float,ParentHeight As Float)
	xpnl_Background.SetLayoutAnimated(0,xpnl_Background.Left,xpnl_Background.Top,ParentWidth,ParentHeight)
	max_x = ParentWidth
	max_y = ParentHeight
End Sub

Private Sub ini_xclv
	
	Dim tmplbl As Label
	tmplbl.Initialize("")
 
	Dim tmpmap As Map
	tmpmap.Initialize
	tmpmap.Put("DividerColor",0)'0xFFD9D7DE)
	tmpmap.Put("DividerHeight",0)
	tmpmap.Put("PressedColor",0x007EB4FA)'0xFF7EB4FA
	tmpmap.Put("InsertAnimationDuration",0)
	tmpmap.Put("ListOrientation",m_Orientation)
	tmpmap.Put("ShowScrollBar",False)
	
	xclv.AnimationDuration = 0
	xclv.Initialize(Me,"xclv")
	xclv.DesignerCreateView(xpnl_Menu,tmplbl,tmpmap)
	
End Sub

'Opens the menu attached to a view
Public Sub OpenMenuOnView(xView As B4XView,Width As Float,Height As Float)
	m_isOpen = True
	Dim ff() As Int = ViewScreenPosition(xView)

	#If B4I
		m_TopBarOffset = B4XPages.GetNativeParent(B4XPages.GetManager.GetTopPage.B4XPage).RootPanel.Top
	#End If
	xpnl_Background.SetLayoutAnimated(0,xpnl_Background.Left,-m_TopBarOffset,xpnl_Parent.Width,xpnl_Parent.Height+m_TopBarOffset)

	If g_IsInSpecialContainer = True Then
		Dim top As Float = ff(1) - LeftTop_Root(1)
		Dim left As Float = ff(0) - LeftTop_Root(0)
	Else
		Dim top As Float = xView.top
		Dim left As Float = xView.Left
	End If
	If actHasActionBar = True And g_IsInSpecialContainer = True Then
		#If B4A
		Dim j As JavaObject : j.InitializeContext
		top = top - j.RunMethodJO("getActionBar",Null).RunMethod("getHeight",Null)
		#Else IF B4I
		Dim NO As NativeObject = Main.NavControl
		top = top - NO.ArrayFromRect(NO.GetField("navigationBar").GetField("frame").RunMethod("CGRectValue", Null))(3)
		#End If
	End If
	
	If g_OrientationVertical = getOrientationVertical_TOP Then
		top = top - m_MenuViewGap
	Else
		top = top + xView.Height + m_MenuViewGap
	End If
	
	top = top + m_TopBarOffset
	
	If g_OrientationHorizontal = getOrientationHorizontal_LEFT Then
	
	else If g_OrientationHorizontal = getOrientationHorizontal_MIDDLE Then
		left = left + xView.Width/2 - Width/2
	Else
		left = left + xView.Width - Width
	End If
	
	max_endlessloop = 0
	GetTopLeft(top,left,Width,xView)
	Wait For lol (left As Float,top As Float)
	
	If xpnl_Menu.Parent.IsInitialized = False Then xpnl_Background.AddView(xpnl_Menu,left,top,Width,Height)
	
	xclv.Base_Resize(Width,Height)
	xclv.AsView.SetLayoutAnimated(0,0,0,Width,Height)
	
	xpnl_Menu.SetLayoutAnimated(0,left,top,Width,Height)
	

	For i = 0 To xclv.Size -1
		If xclv.GetValue(i) Is String And "Title" = xclv.GetValue(i) Then
			xclv.GetPanel(i).SetLayoutAnimated(0,0,0,Width,g_TitleLabelProperties.Height)
			xclv.GetPanel(i).GetView(0).SetLayoutAnimated(0,0,0,Width,g_TitleLabelProperties.Height)
			xclv.ResizeItem(i,g_TitleLabelProperties.Height)
		else If xclv.GetValue(i) Is String And "Separator" = xclv.GetValue(i) Then
			xclv.GetPanel(i).SetLayoutAnimated(0,0,0,Width,g_SeparatorPropertiesAdvanced.Height)
			xclv.ResizeItem(i,g_SeparatorPropertiesAdvanced.Height)
		End If
	Next
	
	If m_ShowTriangle = True Then
		xpnl_Triangle = xui.CreatePanel("")
		xpnl_Triangle.Color = xui.Color_Transparent
		xpnl_Background.AddView(xpnl_Triangle,xpnl_Menu.Left + g_TrianglePropertiesAdvanced.Width,xpnl_Menu.Top - g_TrianglePropertiesAdvanced.Height,g_TrianglePropertiesAdvanced.Width,g_TrianglePropertiesAdvanced.Height)

		Dim xCV As B4XCanvas
		xCV.Initialize(xpnl_Triangle)
		
		xCV.ClearRect(xCV.TargetRect)
		Dim p As B4XPath
		Select g_OrientationVertical
			Case getOrientationVertical_TOP
				p.Initialize(0, 0).LineTo(xpnl_Triangle.Width, 0).LineTo(xpnl_Triangle.Width / 2, xpnl_Triangle.Height).LineTo(0, 0)
				xpnl_Triangle.Left = xpnl_Menu.Left + g_TrianglePropertiesAdvanced.Left
			Case getOrientationVertical_BOTTOM
				p.Initialize(xpnl_Triangle.Width / 2, 0).LineTo(xpnl_Triangle.Width, xpnl_Triangle.Height).LineTo(0, xpnl_Triangle.Height).LineTo(xpnl_Triangle.Width / 2, 0)
				xpnl_Triangle.Left = xpnl_Menu.Left + g_TrianglePropertiesAdvanced.Left
			Case getOrientationHorizontal_RIGHT
				p.Initialize(xpnl_Triangle.Width, 0).LineTo(xpnl_Triangle.Width, xpnl_Triangle.Height).LineTo(0, xpnl_Triangle.Height / 2).LineTo(xpnl_Triangle.Width, 0)
				xpnl_Triangle.Left = xpnl_Menu.Left + g_TrianglePropertiesAdvanced.Top
			Case getOrientationHorizontal_LEFT
				p.Initialize(0, 0).LineTo(xpnl_Triangle.Width, xpnl_Triangle.Height / 2).LineTo(0, xpnl_Triangle.Height).LineTo(0, 0)
				xpnl_Triangle.Left = xpnl_Menu.Left + g_TrianglePropertiesAdvanced.Top
		End Select
	
		xCV.DrawPath(p, g_TrianglePropertiesAdvanced.Color, True, 0)
		xCV.Invalidate

	End If
	
	#If B4J
	SetCircleClip(xpnl_Menu,m_Radius)
	#End if
	
	xpnl_Background.SetVisibleAnimated(OpenDurationMs,True)
	
	If AutoHideMs > 0 Then
		Sleep(AutoHideMs)
		CloseMenu
	End If

	
End Sub

'Opens the menu
Public Sub OpenMenu(Width As Float,Height As Float)
	m_isOpen = True
	
	#If B4I
		m_TopBarOffset = B4XPages.GetNativeParent(B4XPages.GetManager.GetTopPage.B4XPage).RootPanel.Top
	#End If
	xpnl_Background.SetLayoutAnimated(0,xpnl_Background.Left,-m_TopBarOffset,xpnl_Parent.Width,xpnl_Parent.Height+m_TopBarOffset)
	
	If xpnl_Menu.Parent.IsInitialized = False Then xpnl_Background.AddView(xpnl_Menu,xpnl_Background.Width/2 - Width/2,xpnl_Background.Height/2 - Height/2,Width,Height)
	
	xclv.Base_Resize(Width,Height)
	xclv.AsView.SetLayoutAnimated(0,0,0,Width,Height)

	xpnl_Menu.SetLayoutAnimated(0,xpnl_Background.Width/2 - Width/2,xpnl_Background.Height/2 - Height/2 + m_TopBarOffset,Width,Height)

	For i = 0 To xclv.Size -1
		If xclv.GetValue(i) Is String And "Title" = xclv.GetValue(i) Then
			xclv.GetPanel(i).SetLayoutAnimated(0,0,0,Width,g_TitleLabelProperties.Height)
			xclv.GetPanel(i).GetView(0).SetLayoutAnimated(0,0,0,Width,g_TitleLabelProperties.Height)
			xclv.ResizeItem(i,g_TitleLabelProperties.Height)
		else If xclv.GetValue(i) Is String And "Separator" = xclv.GetValue(i) Then
			xclv.GetPanel(i).SetLayoutAnimated(0,0,0,Width,g_SeparatorPropertiesAdvanced.Height)
			xclv.ResizeItem(i,g_SeparatorPropertiesAdvanced.Height)
		End If
	Next
	
	#If B4J
	SetCircleClip(xpnl_Menu,m_Radius)
	#End if
	
	xpnl_Background.SetVisibleAnimated(OpenDurationMs,True)
	
	If AutoHideMs > 0 Then
		Sleep(AutoHideMs)
		CloseMenu
	End If
	
End Sub
Public Sub OpenMenuAdvanced(Left As Float,Top As Float,Width As Float,Height As Float)
	m_isOpen = True
	
	#If B4I
		m_TopBarOffset = B4XPages.GetNativeParent(B4XPages.GetManager.GetTopPage.B4XPage).RootPanel.Top
	#End If
	xpnl_Background.SetLayoutAnimated(0,xpnl_Background.Left,-m_TopBarOffset,xpnl_Parent.Width,xpnl_Parent.Height+m_TopBarOffset)
	
	Top = Top + m_TopBarOffset
	
	If xpnl_Menu.Parent.IsInitialized = False Then xpnl_Background.AddView(xpnl_Menu,xpnl_Background.Width/2 - Width/2,xpnl_Background.Height/2 - Height/2,Width,Height)
	
	xclv.Base_Resize(Width,Height)
	xclv.AsView.SetLayoutAnimated(0,0,0,Width,Height)

	xpnl_Menu.SetLayoutAnimated(0,Left,Top,Width,Height)

	For i = 0 To xclv.Size -1
		If xclv.GetValue(i) Is String And "Title" = xclv.GetValue(i) Then
			xclv.GetPanel(i).SetLayoutAnimated(0,0,0,Width,g_TitleLabelProperties.Height)
			xclv.GetPanel(i).GetView(0).SetLayoutAnimated(0,0,0,Width,g_TitleLabelProperties.Height)
			xclv.ResizeItem(i,g_TitleLabelProperties.Height)
		else If xclv.GetValue(i) Is String And "Separator" = xclv.GetValue(i) Then
			xclv.GetPanel(i).SetLayoutAnimated(0,0,0,Width,g_SeparatorPropertiesAdvanced.Height)
			xclv.ResizeItem(i,g_SeparatorPropertiesAdvanced.Height)
		End If
	Next
	
	If m_ShowTriangle = True Then
		xpnl_Triangle = xui.CreatePanel("")
		xpnl_Triangle.Color = xui.Color_Transparent
		xpnl_Background.AddView(xpnl_Triangle,xpnl_Menu.Left + g_TrianglePropertiesAdvanced.Width,IIf(g_TrianglePropertiesAdvanced.Top = -1,xpnl_Menu.Top,g_TrianglePropertiesAdvanced.Top) - g_TrianglePropertiesAdvanced.Height,g_TrianglePropertiesAdvanced.Width,g_TrianglePropertiesAdvanced.Height)

		Dim xCV As B4XCanvas
		xCV.Initialize(xpnl_Triangle)
		
		xCV.ClearRect(xCV.TargetRect)
		Dim p As B4XPath
		Select g_OrientationVertical
			Case getOrientationVertical_TOP
				p.Initialize(0, 0).LineTo(xpnl_Triangle.Width, 0).LineTo(xpnl_Triangle.Width / 2, xpnl_Triangle.Height).LineTo(0, 0)
				xpnl_Triangle.Left = xpnl_Menu.Left + g_TrianglePropertiesAdvanced.Left
			Case getOrientationVertical_BOTTOM
				p.Initialize(xpnl_Triangle.Width / 2, 0).LineTo(xpnl_Triangle.Width, xpnl_Triangle.Height).LineTo(0, xpnl_Triangle.Height).LineTo(xpnl_Triangle.Width / 2, 0)
				xpnl_Triangle.Left = xpnl_Menu.Left + g_TrianglePropertiesAdvanced.Left
			Case getOrientationHorizontal_RIGHT
				p.Initialize(xpnl_Triangle.Width, 0).LineTo(xpnl_Triangle.Width, xpnl_Triangle.Height).LineTo(0, xpnl_Triangle.Height / 2).LineTo(xpnl_Triangle.Width, 0)
				xpnl_Triangle.Left = xpnl_Menu.Left + g_TrianglePropertiesAdvanced.Top
			Case getOrientationHorizontal_LEFT
				p.Initialize(0, 0).LineTo(xpnl_Triangle.Width, xpnl_Triangle.Height / 2).LineTo(0, xpnl_Triangle.Height).LineTo(0, 0)
				xpnl_Triangle.Left = xpnl_Menu.Left + g_TrianglePropertiesAdvanced.Top
		End Select
	
		xCV.DrawPath(p, g_TrianglePropertiesAdvanced.Color, True, 0)
		xCV.Invalidate

	End If
	
	#If B4J
	SetCircleClip(xpnl_Menu,m_Radius)
	#End if
	
	xpnl_Background.SetVisibleAnimated(OpenDurationMs,True)
	
	If AutoHideMs > 0 Then
		Sleep(AutoHideMs)
		CloseMenu
	End If
End Sub

'Close the menu
Public Sub CloseMenu
	xpnl_Background.SetVisibleAnimated(CloseDurationMs,False)
	If xpnl_Triangle.IsInitialized = True Then xpnl_Triangle.Visible = False
	xpnl_Menu.RemoveViewFromParent
	MenuClosed
	m_isOpen = False
End Sub

'Add a item e.g. a panel with checkboxes
Public Sub AddItem(xPnl As B4XView,Value As Object)	
	xclv.Add(xPnl,Value)
End Sub
'Add a item at a special index
Public Sub AddItemAt(Index As Int,xPnl As B4XView,Value As Object)
	xclv.InsertAt(Index,xPnl,Value)
End Sub
'Clears the list
Public Sub Clear
	xclv.Clear
End Sub
'Add a title
Public Sub AddTitle(Text As String, Height As Float)
	
	Dim xpnl_item_background As B4XView = xui.CreatePanel("item")
	xpnl_item_background.Tag = "title"
	xpnl_item_background.Color = g_TitleLabelProperties.ItemBackgroundColor
	Dim xlbl_text As B4XView = CreateLabel("")
	xlbl_text.TextColor = g_TitleLabelProperties.TextColor
	xlbl_text.Font = g_TitleLabelProperties.xFont
	xlbl_text.Text = Text
	xlbl_text.SetTextAlignment(g_TitleLabelProperties.TextAlignment_Vertical,g_TitleLabelProperties.TextAlignment_Horizontal)
	xlbl_text.Color = g_TitleLabelProperties.BackgroundColor
	xpnl_item_background.Color = g_TitleLabelProperties.BackgroundColor
	xpnl_item_background.AddView(xlbl_text,0,0,0,0)
	g_TitleLabelProperties.Height = Height
	xclv.Add(xpnl_item_background,"Title")
	'HasTitle = True
	
End Sub
'Add a separator
Public Sub AddSeparator
	Dim xpnl_Separator As B4XView = xui.CreatePanel("")
	xpnl_Separator.Color = g_SeparatorPropertiesAdvanced.BackgroundColor
	xclv.Add(xpnl_Separator,"Separator")
End Sub
'sets the corner radius from the menu
Public Sub setCornerRadius(radius As Int)
	m_Radius = radius
	xpnl_Menu.SetColorAndBorder(xpnl_Menu.Color,0,0,radius)
	SetCircleClip(xpnl_Menu,radius)
End Sub
'gets the xCustomListView
Public Sub getCustomListView As CustomListView
	Return xclv
End Sub

'change the label properties, call it before you add the title
'<code>ASScrollingTags1.TitleLabelProperties.xFont = xui.CreateDefaultBoldFont(20)</code>
Public Sub getTitleLabelProperties As ASPM_TitleLabelPropertiesAdvanced
	Return g_TitleLabelProperties
End Sub
'change the separator properties, call it before you add the title
'<code>ASScrollingTags1.TitleLabelProperties.xFont = xui.CreateDefaultBoldFont(20)</code>
Public Sub getSeparatorProperties As ASPM_SeparatorPropertiesAdvanced
	Return g_SeparatorPropertiesAdvanced
End Sub
'change the label properties, call it before you show the menu
'<code>ASScrollingTags1.TriangleProperties.Color = xui.Color_White</code>
Public Sub getTriangleProperties As ASPM_TrianglePropertiesAdvanced
	Return g_TrianglePropertiesAdvanced
End Sub
'set it true if the target is on a listview or as a child on a panel where the left and top values differ from the form
Public Sub setIsInSpecialContainer(value As Boolean)
	g_IsInSpecialContainer = value
End Sub

Public Sub setActivityHasActionBar(value As Boolean)
	actHasActionBar = value
End Sub

Public Sub setOrientationVertical(orientation As String)
	If orientation = getOrientationVertical_BOTTOM Then
		g_OrientationVertical = orientation
	Else
		g_OrientationVertical = getOrientationVertical_TOP
	End If
End Sub
Public Sub setOrientationHorizontal(orientation As String)
	If orientation = getOrientationHorizontal_LEFT Or orientation = getOrientationHorizontal_RIGHT Then
		g_OrientationHorizontal = orientation
	Else
		g_OrientationHorizontal = getOrientationHorizontal_MIDDLE
	End If
End Sub
'sets the gap between the menu and the attached view
'only affected if you open the menu with OpenMenuOnView
Public Sub setMenuViewGap(Gap As Float)
	m_MenuViewGap = Gap
End Sub
'only affected if you open the menu with OpenMenuOnView
Public Sub setShowTriangle(Show As Boolean)
	m_ShowTriangle = Show
End Sub
'checks if the menu is open
Public Sub getisOpen As Boolean
	Return m_isOpen
End Sub

Public Sub getBackgroundPanel As B4XView
	Return xpnl_Background
End Sub

Private Sub xclv_ItemClick (Index As Int, Value As Object)
	ItemClick(Index,Value)
End Sub

Private Sub xclv_ItemLongClick (Index As Int, Value As Object)
	ItemLongClick(Index,Value)
End Sub

#If B4J
Private Sub xpnl_Background_MouseClicked (EventData As MouseEvent)
	CloseMenu
End Sub
#Else
Private Sub xpnl_Background_Click
	CloseMenu
End Sub
#End If

Private Sub ItemClick(index As Int,tag As Object)
	If xui.SubExists(mCallBack,mEventName & "_ItemClick",2) Then
		CallSub3(mCallBack,mEventName & "_ItemClick",index,tag)
	End If
End Sub

Private Sub ItemLongClick(index As Int,tag As Object)
	If xui.SubExists(mCallBack,mEventName & "_ItemLongClick",2) Then
		CallSub3(mCallBack,mEventName & "_ItemLongClick",index,tag)
	End If
End Sub

Private Sub MenuClosed
	If xui.SubExists(mCallBack,mEventName & "_MenuClosed",0) Then
		CallSub(mCallBack,mEventName & "_MenuClosed")
	End If
End Sub

Private Sub CreateLabel(EventName As String) As B4XView
	Dim tmp_lbl As Label
	tmp_lbl.Initialize(EventName)
	#If B4I
	tmp_lbl.Multiline = True
	#End If
	Return tmp_lbl
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
#end if
End Sub

Private Sub GetTopLeft(top As Float,left As Float,width As Float,view As B4XView)
	
	If top < 0 Then
		top = view.Top + view.Height
	Else If (top + xpnl_Menu.Height) > max_y Then
		top = view.Top - xpnl_Menu.Height
	Else If left < 0 Then
		left = 0
	Else If (left + width) > max_x Then
		left = max_x - width
	Else
		CallSubDelayed3(Me,"lol",left,top)
		Return
	End If
	If max_endlessloop = 10 Then
		CallSubDelayed3(Me,"lol",left,top)
		Return
	End If
	max_endlessloop = max_endlessloop +1
	GetTopLeft(top,left,width,view)
End Sub

Sub ViewScreenPosition (view As B4XView) As Int()
	
	Dim leftTop(2) As Int
	#IF B4A
	Dim JO As JavaObject = view
	JO.RunMethod("getLocationOnScreen", Array As Object(leftTop))
	#Else If B4I
	'https://www.b4x.com/android/forum/threads/absolute-position-of-view.56821/#content
	Dim parent As B4XView = view
	Do While GetType(parent) <> "B4IMainView"
		Dim no As NativeObject = parent
		leftTop(0) = leftTop(0) + parent.Left
		leftTop(1) = leftTop(1) + parent.Top
		parent = no.GetField("superview")
   Loop
	#Else
	Dim parent As B4XView = view
   Do While parent.IsInitialized
       leftTop(0) = leftTop(0) + parent.Left
       leftTop(1) = leftTop(1) + parent.Top
       parent = parent.Parent
   Loop
	#End If

	Return Array As Int(leftTop(0), leftTop(1))
End Sub


#Region Enums
'Vertical = Top,Bottom
'Horizontal = Left,Middle,Right
Public Sub getOrientationVertical_TOP As String
	Return "TOP"
End Sub

Public Sub getOrientationVertical_BOTTOM As String
	Return "BOTTOM"
End Sub

Public Sub getOrientationHorizontal_LEFT As String
	Return "LEFT"
End Sub

Public Sub getOrientationHorizontal_MIDDLE As String
	Return "MIDDLE"
End Sub

Public Sub getOrientationHorizontal_RIGHT As String
	Return "RIGHT"
End Sub

#End Region

Public Sub CreateASPM_TitleLabelPropertiesAdvanced (TextColor As Int, xFont As B4XFont, TextAlignment_Vertical As String, TextAlignment_Horizontal As String, BackgroundColor As Int, ItemBackgroundColor As Int, LeftRightPadding As Float, Height As Float) As ASPM_TitleLabelPropertiesAdvanced
	Dim t1 As ASPM_TitleLabelPropertiesAdvanced
	t1.Initialize
	t1.TextColor = TextColor
	t1.xFont = xFont
	t1.TextAlignment_Vertical = TextAlignment_Vertical
	t1.TextAlignment_Horizontal = TextAlignment_Horizontal
	t1.BackgroundColor = BackgroundColor
	t1.ItemBackgroundColor = ItemBackgroundColor
	t1.LeftRightPadding = LeftRightPadding
	t1.Height = Height
	Return t1
End Sub

Public Sub CreateASPM_SeparatorPropertiesAdvanced (Height As Float, BackgroundColor As Int) As ASPM_SeparatorPropertiesAdvanced
	Dim t1 As ASPM_SeparatorPropertiesAdvanced
	t1.Initialize
	t1.Height = Height
	t1.BackgroundColor = BackgroundColor
	Return t1
End Sub

Public Sub CreateASPM_TrianglePropertiesAdvanced (Color As Int, Width As Float, Height As Float, Left As Float, Top As Float) As ASPM_TrianglePropertiesAdvanced
	Dim t1 As ASPM_TrianglePropertiesAdvanced
	t1.Initialize
	t1.Color = Color
	t1.Width = Width
	t1.Height = Height
	t1.Left = Left
	t1.Top = Top
	Return t1
End Sub
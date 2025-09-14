B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.3
@EndOfDesignText@

#If Documentation
Changelog:
V1.00
	-Release
V1.01
	-BugFixes
V1.02
	-Add Clear - Clears all lists
V1.03
	-Add Designer Property LazyLoading
	-Add Designer Property LazyLoadingExtraSize
	-Add Event LazyLoadingAddContent
	-Add set ColumnCount
V1.04
	-New ScrollToValue - Scrolls the list to a specified value
		-Scrolls the list to a specified value
		-Animated - If True the list scrolls smoothlie - If False the list jump to the item
		-Returns “True” if the item was found
#End If

#DesignerProperty: Key: ColumnCount, DisplayName: Columns, FieldType: Int, DefaultValue: 1, MinRange: 1, Description: Column Count

#DesignerProperty: Key: LazyLoading, DisplayName: Lazy Loading, FieldType: Boolean, DefaultValue: False, Description: activates lazy loading
#DesignerProperty: Key: LazyLoadingExtraSize, DisplayName: Lazy Loading Extra Size, FieldType: Int, DefaultValue: 5, MinRange: 0

#DesignerProperty: Key: PressedColor, DisplayName: Pressed Color, FieldType: Color, DefaultValue: 0xFF7EB4FA
#DesignerProperty: Key: InsertAnimationDuration, DisplayName: Insert Animation Duration, FieldType: Int, DefaultValue: 300
#DesignerProperty: Key: ShowScrollBar, DisplayName: Show Scroll Bar, FieldType: Boolean, DefaultValue: True, Description: Whether to show the scrollbar (when needed).

#Event: ItemClick (Index As Int, Value As Object)
#Event: ItemLongClick (Index As Int, Value As Object)
#Event: ReachEnd
#Event: LazyLoadingAddContent(Parent As B4XView, Value As Object)

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Private xpnl_ListViewBackground As B4XView
	
	Private m_ColumnCount As Int
	
	'xCLV Desgner Props
	Private m_PressedColor As Int
	Private m_InsertAnimationDuration As Long
	Private m_ShowScrollBar As Boolean
	
	Private m_CurrentAddIndex As Int
	Private m_LazyLoading As Boolean
	Private m_LazyLoadingExtraSize As Int
	Private m_LongestClv As Float
	
	#If B4I or B4A
	Private xclv_CurrentUsed As CustomListView
	#End If
	
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
    mBase.Tag = Me 

	IniProps(Props)

	xpnl_ListViewBackground = xui.CreatePanel("")
	mBase.AddView(xpnl_ListViewBackground,0,0,mBase.Width,mBase.Height)
	
	CreateLists
	
	#If B4A
	Base_Resize(mBase.Width,mBase.Height)
	#End If
	
End Sub

Private Sub CreateLists
	
	For i = 0 To m_ColumnCount -1
		
		Dim SlotWidth As Float = mBase.Width/m_ColumnCount
		
		Dim xpnl_Background As B4XView = xui.CreatePanel("")
		xpnl_Background.SetLayoutAnimated(0,0,0,SlotWidth,mBase.Height)
		Create_xCLV(xpnl_Background,i = (m_ColumnCount-1))
		xpnl_ListViewBackground.AddView(xpnl_Background,SlotWidth*i,0,SlotWidth,mBase.Height)
	Next
	
End Sub

Private Sub IniProps(Props As Map)
	
	m_ColumnCount = Props.Get("ColumnCount")
	
	m_LazyLoading = Props.GetDefault("LazyLoading",False)
	m_LazyLoadingExtraSize = Props.GetDefault("LazyLoadingExtraSize",5)
	
	m_PressedColor = xui.PaintOrColorToColor(Props.Get("PressedColor"))
	m_InsertAnimationDuration = Props.Get("InsertAnimationDuration")
	m_ShowScrollBar = Props.Get("ShowScrollBar")
	
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
  
	For i = 0 To m_ColumnCount -1
		
		Dim xclv As CustomListView = xpnl_ListViewBackground.GetView(i).Tag
		xclv.AsView.Width = Width/m_ColumnCount
		xclv.AsView.Height = Height
		xclv.Base_Resize(Width/m_ColumnCount,Height)
		
	Next
  
End Sub

Private Sub Create_xCLV(Parent As B4XView,isLast As Boolean)
	Dim tmplbl As Label
	tmplbl.Initialize("")
 
	Dim tmpmap As Map
	tmpmap.Initialize
	tmpmap.Put("DividerColor",0x00FFFFFF)
	tmpmap.Put("DividerHeight",0)
	tmpmap.Put("PressedColor",m_PressedColor)
	tmpmap.Put("InsertAnimationDuration",m_InsertAnimationDuration)
	tmpmap.Put("ListOrientation","Vertical")
	tmpmap.Put("ShowScrollBar",m_ShowScrollBar And isLast)
	Dim xclv_main As CustomListView
	xclv_main.Initialize(Me,"xclv_main")
	xclv_main.DesignerCreateView(Parent,tmplbl,tmpmap)

	#IF B4A
	xclv_main.sv.As(JavaObject).RunMethod("setOverScrollMode", Array(2))
	xclv_main.sv.Tag = xclv_main
	Private objPages As Reflector
	objPages.Target = xclv_main.sv
	objPages.SetOnTouchListener("xpnl_PageArea2_Touch")
	#Else IF B4I	
	xclv_main.sv.Tag = xclv_main
	Dim gr As GestureRecognizerMultiColumnCustomListView
	gr.Initialize("gr",Me,xclv_main.sv)'.sv)
	gr.AddPanGesture(1,1)
	
	'tmp.Initialize("tmp",Me,xclv_main.GetBase)'.sv)
	'tmp.AddLongPressGesture(0,1,0)
	'tmp.AddPanGesture(1,1)

	#End if
	
	#If B4I
	Do While xclv_main.sv.IsInitialized = False
		'Sleep(0)
	Loop
	Dim sv As ScrollView = xclv_main.sv
	sv.Color = xui.Color_Transparent'xui.Color_ARGB(255,32, 33, 37)
	
	#End If
	xclv_main.AsView.Tag = xclv_main
	
	#IF B4A or B4I
	xclv_CurrentUsed = xclv_main
	#End If
	
End Sub

'Adds a custom item.
Public Sub Add(Pnl As B4XView, Value As Object)
	
	Dim xclv As CustomListView = xpnl_ListViewBackground.GetView(m_CurrentAddIndex).Tag
	xclv.Add(Pnl,Value)
	m_CurrentAddIndex = (m_CurrentAddIndex + 1) Mod m_ColumnCount
	
End Sub

'Clears all lists
Public Sub Clear
	
	For i = 0 To m_ColumnCount -1
		xpnl_ListViewBackground.GetView(i).Tag.As(CustomListView).Clear
	Next
	
End Sub

Public Sub Commit
	
	For i = 0 To m_ColumnCount -1
		Dim xclv As CustomListView = xpnl_ListViewBackground.GetView(i).Tag
		
		Dim ContentHeight As Float = xclv.sv.ScrollViewContentHeight
		
		If ContentHeight > m_LongestClv Then m_LongestClv = ContentHeight
	Next
	
	For i = 0 To m_ColumnCount -1
		Dim xclv As CustomListView = xpnl_ListViewBackground.GetView(i).Tag

		Dim ContentHeight As Float = xclv.sv.ScrollViewContentHeight
			
		If ContentHeight < m_LongestClv Then
			Dim xpnl_Placeholder As B4XView = xui.CreatePanel("")
			xpnl_Placeholder.Color = xui.Color_Transparent
			xpnl_Placeholder.SetLayoutAnimated(0,0,0,mBase.Width/m_ColumnCount,m_LongestClv - ContentHeight)
			xclv.Add(xpnl_Placeholder,"Placeholder")
			
		End If
	Next
	
End Sub

'Scrolls the list to a specified value
'Animated - If True the list scrolls smoothlie - If False the list jump to the item
'Returns “True” if the item was found
Public Sub ScrollToValue(Value As Object,Animated As Boolean) As Boolean
	For i = 0 To m_ColumnCount -1
		Dim xclv As CustomListView = xpnl_ListViewBackground.GetView(i).Tag
		For i2 = 0 To xclv.Size -1
			If xclv.GetValue(i2) = Value Then
				If Animated Then
					xclv.ScrollToItem(i2)
				Else
					xclv.JumpToItem(i2)
				End If
				Return True
			End If
		Next
	Next
	Return False
End Sub

#Region Properties

Public Sub getColumnCount As Int
	Return m_ColumnCount
End Sub

Public Sub setColumnCount(Columns As Int)
	m_ColumnCount = Columns
	xpnl_ListViewBackground.RemoveAllViews
	CreateLists
End Sub

Public Sub setLazyLoading(Enabled As Boolean)
	m_LazyLoading = Enabled
End Sub

Public Sub getLazyLoading As Boolean
	Return m_LazyLoading
End Sub

Public Sub setLazyLoadingExtraSize(ExtraSize As Int)
	m_LazyLoadingExtraSize = ExtraSize
End Sub

Public Sub getLazyLoadingExtraSize As Int
	Return m_LazyLoadingExtraSize
End Sub

#End Region

#Region Events

Private Sub xclv_main_VisibleRangeChanged (FirstIndex As Int, LastIndex As Int)
	
	Dim xclv_Main As CustomListView = Sender
	
	For i = 0 To xclv_Main.Size - 1
		Dim p As B4XView = xclv_Main.GetPanel(i)
		If i > FirstIndex - m_LazyLoadingExtraSize And i < LastIndex + m_LazyLoadingExtraSize Then
			'visible+
			If p.NumberOfViews = 0 And "Placeholder" <> xclv_Main.GetValue(i) Then
				LazyLoadingAddContent(p,xclv_Main.GetValue(i))
			End If
		Else
			'not visible
			If p.NumberOfViews > 0 Then
				p.RemoveAllViews '<--- remove the layout
			End If
		End If
	Next
	
End Sub

Private Sub xclv_main_ScrollChanged (Offset As Int)
	
	Dim xclv_Main As CustomListView = Sender
	
	#If B4I or B4A
	If xclv_Main <> xclv_CurrentUsed Then Return
	#End If
	'Log(xclv_Main.AsView.Left)
	
	For i = 0 To m_ColumnCount -1
		
		Dim xclv As CustomListView = xpnl_ListViewBackground.GetView(i).Tag
		
		If xclv <> xclv_Main Then
			xclv.sv.ScrollViewOffsetY = Offset
		End If
	Next
	
End Sub

Private Sub LazyLoadingAddContent(Parent As B4XView,Value As Object)
	If xui.SubExists(mCallBack, mEventName & "_LazyLoadingAddContent", 2) Then
		CallSub3(mCallBack, mEventName & "_LazyLoadingAddContent",Parent,Value)
	End If
End Sub

Private Sub xclv_main_ItemClick (Index As Int, Value As Object)
	If xui.SubExists(mCallBack, mEventName & "_ItemClick", 2) Then
		CallSub3(mCallBack, mEventName & "_ItemClick",Index,Value)
	End If
End Sub

Private Sub xclv_main_ItemLongClick (Index As Int, Value As Object)
	If xui.SubExists(mCallBack, mEventName & "_ItemLongClick", 2) Then
		CallSub3(mCallBack, mEventName & "_ItemLongClick",Index,Value)
	End If
End Sub

Private Sub xclv_main_ReachEnd
	If xui.SubExists(mCallBack, mEventName & "_ReachEnd", 0) Then
		CallSub(mCallBack, mEventName & "_ReachEnd")
	End If
End Sub

#End Region

#If B4I

Private Sub gr_pan(state As Int, att As Pan_AttributesMultiColumnCustomListView)
	Dim bb As GestureRecognizerMultiColumnCustomListView = Sender
	Dim xclv As CustomListView = bb.mView.tag
	xclv_CurrentUsed = xclv
End Sub

#Else If B4A
Private Sub xpnl_PageArea2_Touch(ViewTag As Object, Action As Int, X As Float, y As Float, MotionEvent As Object) As Boolean
	Dim sv As ScrollView = Sender
	Dim xclv As CustomListView = sv.Tag
	xclv_CurrentUsed = xclv
	Return False
End Sub

#End If

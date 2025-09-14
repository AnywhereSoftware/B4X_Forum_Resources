B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.2
@EndOfDesignText@
#If Documentation
Updates
V1.00
	-Release
V1.01
	-BugFix - labels with different heights
V2.00
	-Complete new development
	-Now works like AS_Chips
V2.01
	-Add Designer Property SelectionMode - An integrated selection system
		-Modes
			-None
			-Single
			-Multi
		-Default: None
	-Add Designer Property CanDeselect - If true, then the user can remove the selection by clicking again
		-Default: True
	-Add set Selection
	-Add ClearSelections
	-Add get Selections
	-Add Width to ASScrollingChips_ChipProperties - If > 0 then this value is used instead of the calculated value by the text
	-Add AddChipCustom
	-Add CopyChipPropertiesGlobal
	-Add RefreshProperties - Updates just the font and colors
V2.02
	-Property SelectionColor renamed to SelectionBorderColor
	-Add Designer Property SelectionBackgroundColor
		-Default: Transparent
V2.03
	-BugFix
V2.04
	-BugFixes
	-Add Designer Proeprty Alignment - IF center then a stub item are added left and right so the chips looks centered
		-Default: Left
V2.05
	-Add Designer Property SelectionTextColor
		-Default: White
	-Add SetSelections
V2.06
	-Add SetSelections2 - Set the selected items via a list of indexes
	-Add SetSelections3 - Set the selected items via a map of chip tags
V2.07
	-BugFix
	-Add get and set MaxSelectionCount - Only in SelectionMode = Multi - Defines the maximum number of items that may be selected
		-Default: 0
V2.08
	-BugFix on get Size - Has returned an incorrect value
V2.09
	-BugFixes
V2.10
	-New GetChip2 - Get the chip via the tag value of the item
V2.11
	-BugFix - The chips are now resized when you call RefreshChips, if you change text etc.
V2.12
	-New - ShowRemoveIcon added to ASScrollingChips_ChipProperties type
	-New - xFont and Icon added to ASScrollingChips_RemoveIconProperties type
	-New - GetChipProperties2 Get the chip props via the tag value of the item
	-New - RemoveChipClicked Event - if the event is used, automatic deletion is deactivated
#End If

#DesignerProperty: Key: SelectionMode, DisplayName: SelectionMode, FieldType: String, DefaultValue: None, List: None|Single|Multi
#DesignerProperty: Key: CanDeselect, DisplayName: CanDeselect, FieldType: Boolean, DefaultValue: True , Description: If true, then the user can remove the selection by clicking again
#DesignerProperty: Key: SelectionBorderColor, DisplayName: SelectionBorderColor, FieldType: Color, DefaultValue: 0xFFFFFFFF
#DesignerProperty: Key: SelectionBackgroundColor, DisplayName: SelectionBackgroundColor, FieldType: Color, DefaultValue: 0x00FFFFFF
#DesignerProperty: Key: SelectionTextColor, DisplayName: SelectionTextColor, FieldType: Color, DefaultValue: 0xFFFFFFFF
#DesignerProperty: Key: BackgroundColor, DisplayName: Background Color, FieldType: Color, DefaultValue: 0xFF000000
#DesignerProperty: Key: ShowRemoveIcon, DisplayName: Show Remove Icon, FieldType: Boolean, DefaultValue: False, Description: Displays a Remove icon which can be clicked on
#DesignerProperty: Key: Round, DisplayName: Round, FieldType: Boolean, DefaultValue: True, Description: Makes the chips round
#DesignerProperty: Key: CornerRadius, DisplayName: Corner Radius, FieldType: Int, DefaultValue: 5, MinRange: 0, Description: Only affected if Round = False
#DesignerProperty: Key: Alignment, DisplayName: Alignment, FieldType: String, DefaultValue: Left, List: Left|Center, Description: IF center then a stub item are added left and right so the chips looks centered

#Event: ChipClick (Chip As ASScrollingChips_Chip)
#Event: ChipLongClick (Chip As ASScrollingChips_Chip)
#Event: ChipRemoved (Chip As ASScrollingChips_Chip)
#Event: CustomDrawChip(Item As ASScrollingChips_CustomDraw)
#Event: RemoveChipClicked(Chip As ASScrollingChips_Chip)

Sub Class_Globals
	
	Type ASScrollingChips_Chip(Text As String,Icon As B4XBitmap,Tag As Object,Index As Int)
	Type ASScrollingChips_ChipProperties(Width As Float,Height As Float,BackgroundColor As Int,TextColor As Int,xFont As B4XFont,CornerRadius As Float,BorderSize As Float,BorderColor As Int,TextGap As Float,ShowRemoveIcon As Boolean)
	Type ASScrollingChips_RemoveIconProperties(BackgroundColor As Int,TextColor As Int,xFont As B4XFont,Icon As String)
	Type ASScrollingChips_Views(BackgroundPanel As B4XView,TextLabel As B4XView,IconImageView As B4XView,RemoveIconLabel As B4XView)
	Type ASScrollingChips_CustomDraw(Chip As ASScrollingChips_Chip,ChipProperties As ASScrollingChips_ChipProperties,Views As ASScrollingChips_Views)
	
	Private g_ChipProperties As ASScrollingChips_ChipProperties
	Private g_RemoveIconProperties As ASScrollingChips_RemoveIconProperties
	
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Private xclv As CustomListView
	Public Tag As Object
	
	Private m_GapBetween As Float
	Private m_BackgroundColor As Int
	Private m_ShowRemoveIcon As Boolean
	Private m_Round As Boolean
	Private m_SelectionMode As String
	Private m_SelectionMap As Map
	Private m_CanDeselect As Boolean
	Private m_SelectionBorderColor As Int
	Private m_SelectionBackgroundColor As Int
	Private m_SelectionTextColor As Int
	Private m_Alignment As String
	Private m_MaxSelectionCount As Int = 0
	
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	m_SelectionMap.Initialize
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
    mBase.Tag = Me 
	ini_props(Props)
	ini_xclv
	
	#If B4A 
	Base_Resize(mBase.Width,mBase.Height)
	#End If
End Sub

Private Sub ini_props(Props As Map)
	m_BackgroundColor = xui.PaintOrColorToColor(Props.Get("BackgroundColor"))
	m_ShowRemoveIcon = Props.Get("ShowRemoveIcon")
	m_Round = Props.Get("Round")
	m_SelectionMode = Props.GetDefault("SelectionMode","None")
	m_CanDeselect = Props.GetDefault("CanDeselect",True)
	m_SelectionBorderColor = xui.PaintOrColorToColor(Props.GetDefault("SelectionBorderColor",xui.Color_White))
	m_SelectionBackgroundColor = xui.PaintOrColorToColor(Props.GetDefault("SelectionBackgroundColor",xui.Color_ARGB(0,255,255,255)))
	m_SelectionTextColor = xui.PaintOrColorToColor(Props.GetDefault("SelectionTextColor",xui.Color_White))
	m_Alignment = Props.GetDefault("Alignment","Left")
	
	m_GapBetween = 5dip
	
	g_ChipProperties = CreateASScrollingChips_ChipProperties(22dip,xui.Color_Black,xui.Color_White,xui.CreateDefaultFont(14),DipToCurrent(Props.Get("CornerRadius")),0,3dip)
	g_ChipProperties.BorderColor = m_SelectionBorderColor
	g_ChipProperties.ShowRemoveIcon = m_ShowRemoveIcon
	g_RemoveIconProperties = CreateASScrollingChips_RemoveIconProperties(xui.Color_Black,xui.Color_White,xui.CreateMaterialIcons(9),Chr(0xE5CD))
	
	mBase.Color = m_BackgroundColor
	
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	For i = 0 To xclv.Size -1
		xclv.GetPanel(i).Height = Height
	Next
End Sub

Private Sub ini_xclv
	
	Dim tmplbl As Label
	tmplbl.Initialize("")
 
	Dim tmpmap As Map
	tmpmap.Initialize
	tmpmap.Put("DividerColor",m_BackgroundColor)'0xFFD9D7DE)
	tmpmap.Put("DividerHeight",0)
	tmpmap.Put("PressedColor",0x007EB4FA)'0xFF7EB4FA
	tmpmap.Put("InsertAnimationDuration",0)	
	tmpmap.Put("ListOrientation","Horizontal")		
	tmpmap.Put("ShowScrollBar",xui.IsB4J)
	
	xclv.Initialize(Me,"xclv")
	xclv.DesignerCreateView(mBase,tmplbl,tmpmap)
	
'	#If B4J
'	
'	#Else
	#If B4A
	Dim sv As HorizontalScrollView = xclv.sv
	sv.Color = m_BackgroundColor
	#Else If B4I
	xclv.sv.As(ScrollView).Color = m_BackgroundColor
	#Else IF B4J
	xclv.sv.As(ScrollPane).Style="-fx-background:transparent;-fx-background-color:transparent;"
	#End If
	
	
	
End Sub

'Public Sub AddAdd(background_color As Int)
'	
'	Dim tmp_height As Float =  MeasureTextHeight("A",g_LabelProperties.xFont) + 10dip
'	
'	Dim xpnl_base As B4XView = xui.CreatePanel("")
'	Dim xpnl_background As B4XView = xui.CreatePanel("")
'	xpnl_base.SetLayoutAnimated(0,0,0,tmp_height + g_TextPaddingTopBottom,xclv.GetBase.Height)
'	xpnl_background.SetColorAndBorder(background_color,0,0,tmp_height/2)
'	
'	Dim xlbl_text As B4XView = CreateLabel("")
'	xlbl_text.TextColor = g_LabelProperties.TextColor
'	xlbl_text.Font = xui.CreateMaterialIcons(15)
'	xlbl_text.SetTextAlignment("CENTER","CENTER")
'	xlbl_text.Text = Chr(0xE145)
'	
'	xpnl_base.AddView(xpnl_background,xpnl_base.Width/2 - tmp_height/2,xclv.GetBase.Height/2 - tmp_height/2,tmp_height,tmp_height)
'	xpnl_base.AddView(xlbl_text,xpnl_background.Left,xpnl_background.Top,xpnl_background.Width,xpnl_background.Height)
'	
'	xclv.Add(xpnl_base,"add")
'	
'End Sub

Public Sub AddChip(Text As String,Icon As B4XBitmap,xTag As Object)
	AddChip2List(Text,Icon,g_ChipProperties.BackgroundColor,xTag)
End Sub

Public Sub AddChip2(Text As String,Icon As B4XBitmap,ChipColor As Int,xTag As Object)
	AddChip2List(Text,Icon,ChipColor,xTag)
End Sub

Public Sub AddChipCustom(Chip As ASScrollingChips_Chip,ChipProperties As ASScrollingChips_ChipProperties)

	Chip.Index = xclv.Size
	
	Dim IconGap As Float = 4dip
	Dim HaveIcon As Boolean = IIf(Chip.Icon <> Null And Chip.Icon.IsInitialized = True,True,False)
	Dim RemoveIconWidthHeight As Float = IIf(ChipProperties.ShowRemoveIcon,ChipProperties.Height/1.5,0)
	Dim IconHeightWidth As Float = IIf(HaveIcon,ChipProperties.Height/1.3,0)
	
	Dim FontGap As Float = IIf(xui.IsB4J,6dip,0dip)
	Dim TextWidth As Float =  MeasureTextWidth(Chip.Text,ChipProperties.xFont) + 5dip
	
	Dim Width As Float = TextWidth + FontGap + ChipProperties.TextGap*2 + IconHeightWidth + IIf(HaveIcon,IconGap*2,0) + RemoveIconWidthHeight + IIf(ChipProperties.ShowRemoveIcon,IconGap*2,0)
	
	Dim xpnl_Background As B4XView = xui.CreatePanel("xpnl_ChipBackground")
	xpnl_Background.Color = m_BackgroundColor
	xpnl_Background.SetLayoutAnimated(0,0,0,Width + m_GapBetween*2,mBase.Height)
	
	xclv.Add(xpnl_Background,CreateMap("Chip":Chip,"ChipProperties":ChipProperties))
End Sub

Private Sub AddChip2List(Text As String,Icon As B4XBitmap,ChipColor As Int,xTag As Object)
	Dim ChipProperties As ASScrollingChips_ChipProperties = CreateASScrollingChips_ChipProperties(g_ChipProperties.Height,ChipColor,g_ChipProperties.TextColor,g_ChipProperties.xFont,g_ChipProperties.CornerRadius,g_ChipProperties.BorderSize,g_ChipProperties.TextGap)
	ChipProperties.Width = g_ChipProperties.Width
	ChipProperties.BorderColor = g_ChipProperties.BorderColor
	
	Dim Chip As ASScrollingChips_Chip
	Chip.Text = Text
	Chip.Icon = Icon
	Chip.Tag = xTag
	Chip.Index = xclv.Size
	
	Dim IconGap As Float = 4dip
	Dim HaveIcon As Boolean = IIf(Chip.Icon <> Null And Chip.Icon.IsInitialized = True,True,False)
	Dim RemoveIconWidthHeight As Float = IIf(ChipProperties.ShowRemoveIcon,ChipProperties.Height/1.5,0)
	Dim IconHeightWidth As Float = IIf(HaveIcon,ChipProperties.Height/1.3,0)
	
	Dim FontGap As Float = IIf(xui.IsB4J,6dip,0dip)
	Dim TextWidth As Float =  MeasureTextWidth(Chip.Text,ChipProperties.xFont) + 5dip
	
	Dim Width As Float = TextWidth + FontGap + ChipProperties.TextGap*2 + IconHeightWidth + IIf(HaveIcon,IconGap*2,0) + RemoveIconWidthHeight + IIf(ChipProperties.ShowRemoveIcon,IconGap*2,0)
	
	Dim xpnl_Background As B4XView = xui.CreatePanel("xpnl_ChipBackground")
	xpnl_Background.Color = m_BackgroundColor
	xpnl_Background.SetLayoutAnimated(0,0,0,Width + m_GapBetween*2,mBase.Height)
	
	xclv.Add(xpnl_Background,CreateMap("Chip":Chip,"ChipProperties":ChipProperties))

End Sub

Private Sub AddChipIntern(xpnl_Background As B4XView,ChipMap As Map)
	
	Dim Chip As ASScrollingChips_Chip = ChipMap.Get("Chip")
	Dim ChipProperties As ASScrollingChips_ChipProperties = ChipMap.Get("ChipProperties")
	
	Dim IconGap As Float = 4dip
	Dim HaveIcon As Boolean = IIf(Chip.Icon <> Null And Chip.Icon.IsInitialized = True,True,False)
	Dim RemoveIconWidthHeight As Float = IIf(ChipProperties.ShowRemoveIcon,ChipProperties.Height/1.5,0)
	Dim IconHeightWidth As Float = IIf(HaveIcon,ChipProperties.Height/1.3,0)
	
	Dim FontGap As Float = IIf(xui.IsB4J,6dip,0dip)
	Dim TextWidth As Float =  MeasureTextWidth(Chip.Text,ChipProperties.xFont) + 5dip
	
	Dim BackgroundColor As Int = ChipProperties.BackgroundColor
	Dim TextColor As Int = ChipProperties.TextColor
	If ChipProperties.BorderSize = 2dip And (m_SelectionMode = "Single" Or m_SelectionMode = "Multi") Then
		BackgroundColor = m_SelectionBackgroundColor
		TextColor = m_SelectionTextColor
	End If
	
	Dim Width As Float = TextWidth + FontGap + ChipProperties.TextGap*2 + IconHeightWidth + IIf(HaveIcon,IconGap*2,0) + RemoveIconWidthHeight + IIf(ChipProperties.ShowRemoveIcon,IconGap*2,0)
	xpnl_Background.Width = Width
	
	Dim xpnl_ChipBackground As B4XView = xui.CreatePanel("xpnl_ChipBackground")
	xpnl_Background.AddView(xpnl_ChipBackground,xpnl_Background.Width/2 - Width/2,xpnl_Background.Height/2-ChipProperties.Height/2,Width,ChipProperties.Height)
	xpnl_ChipBackground.SetColorAndBorder(BackgroundColor,ChipProperties.BorderSize,ChipProperties.BorderColor,IIf(m_Round = True,xpnl_ChipBackground.Height/2, ChipProperties.CornerRadius))
	
	Dim xlbl_Text As B4XView = CreateLabel("")
	xpnl_ChipBackground.AddView(xlbl_Text,0,0,0,0)
	xlbl_Text.TextColor = TextColor
	xlbl_Text.SetTextAlignment("CENTER","CENTER")
	xlbl_Text.Font = ChipProperties.xFont
	xlbl_Text.SetLayoutAnimated(0,IconHeightWidth + ChipProperties.TextGap + IIf(HaveIcon,IIf(ChipProperties.ShowRemoveIcon,IconGap,0),0),0,TextWidth ,ChipProperties.Height)
	xlbl_Text.Text = Chip.Text
	'xlbl_Text.Color = xui.Color_Red
	
	Dim xiv_Icon As B4XView = CreateImageView("")
	xpnl_ChipBackground.AddView(xiv_Icon,0,0,0,0)
	
	Dim xlbl_RemoveIcon As B4XView = CreateLabel("xlbl_RemoveIcon")
	xpnl_ChipBackground.AddView(xlbl_RemoveIcon,0,0,0,0)
	
	'************Icon********************************
	If HaveIcon Then
			
		
		xiv_Icon.SetLayoutAnimated(0,IconGap,xpnl_ChipBackground.Height/2 - IconHeightWidth/2,IconHeightWidth,IconHeightWidth)
		xiv_Icon.SetBitmap(Chip.Icon.Resize(xiv_Icon.Width,xiv_Icon.Height,True))
			
	End If
	xiv_Icon.Visible = HaveIcon
'	'************RemoveIcon********************************
	If ChipProperties.ShowRemoveIcon Then
			
		xlbl_RemoveIcon.Font = g_RemoveIconProperties.xFont
		xlbl_RemoveIcon.Text = g_RemoveIconProperties.Icon
		xlbl_RemoveIcon.SetTextAlignment("CENTER","CENTER")
		xlbl_RemoveIcon.SetColorAndBorder(g_RemoveIconProperties.BackgroundColor,0,0,RemoveIconWidthHeight/2)
		xlbl_RemoveIcon.TextColor = g_RemoveIconProperties.TextColor
			
		xlbl_RemoveIcon.SetLayoutAnimated(0,xpnl_ChipBackground.Width - RemoveIconWidthHeight - IconGap*2,xpnl_ChipBackground.Height/2 - RemoveIconWidthHeight/2,RemoveIconWidthHeight,RemoveIconWidthHeight)
		xlbl_RemoveIcon.Visible = True
	Else
		xlbl_RemoveIcon.Visible = False
	End If
	
	xpnl_Background.Width = Width + m_GapBetween*2
	xclv.ResizeItem(xclv.GetItemFromView(xpnl_Background),xpnl_Background.Width)
	xpnl_ChipBackground.Left = xpnl_Background.Width/2 - xpnl_ChipBackground.Width/2
	
	CustomDrawChip(CreateASScrollingChips_CustomDraw(Chip,ChipProperties,CreateASScrollingChips_Views(xpnl_Background,xlbl_Text,xiv_Icon,xlbl_RemoveIcon)))
	
End Sub

Public Sub RefreshChips
	For i = 0 To xclv.Size -1
		xclv.GetPanel(i).RemoveAllViews
	Next
	xclv.Refresh
	
	If m_Alignment = "Center" And xclv.sv.ScrollViewContentWidth < mBase.Width Then
		
		If xclv.Size > 0 And xclv.GetValue(0) Is String And "StubItem" = xclv.GetValue(0) Then xclv.RemoveAt(0)
		
		Dim Width As Float = mBase.Width - xclv.sv.ScrollViewContentWidth
		
		Dim xpnl_StubItemLeft As B4XView = xui.CreatePanel("")
		xpnl_StubItemLeft.SetLayoutAnimated(0,0,0,Width/2,mBase.Height)
		xpnl_StubItemLeft.Color = m_BackgroundColor
		xclv.InsertAt(0,xpnl_StubItemLeft,"StubItem")
	Else if m_Alignment = "Center" Then
		If xclv.Size > 0 Then
			If xclv.GetValue(0) Is String And xclv.GetValue(0).As(String) = "StubItem" Then
				xclv.RemoveAt(0)
			End If
		End If
	End If
	
End Sub

'Updates just the font and colors
Public Sub RefreshProperties
	For i = 0 To xclv.Size -1
		If xclv.GetPanel(i).NumberOfViews > 0 Then
			Dim ChipProperties As ASScrollingChips_ChipProperties = xclv.GetValue(i).As(Map).Get("ChipProperties")
			Dim BackgroundColor As Int = ChipProperties.BackgroundColor
			Dim TextColor As Int = ChipProperties.TextColor
			If ChipProperties.BorderSize = 2dip And (m_SelectionMode = "Single" Or m_SelectionMode = "Multi") Then
				BackgroundColor = m_SelectionBackgroundColor
				TextColor = m_SelectionTextColor
			End If
			xclv.GetPanel(i).GetView(0).SetColorAndBorder(BackgroundColor,ChipProperties.BorderSize,ChipProperties.BorderColor,IIf(m_Round = True,xclv.GetPanel(i).GetView(0).Height/2, ChipProperties.CornerRadius))
			Dim xlbl_Text As B4XView = xclv.GetPanel(i).GetView(0).GetView(0)
			xlbl_Text.TextColor = TextColor
			xlbl_Text.Font = ChipProperties.xFont
			
		End If
	Next
End Sub

Private Sub xclv_VisibleRangeChanged (FirstIndex As Int, LastIndex As Int)
	Dim ExtraSize As Int = 20
	For i = 0 To xclv.Size - 1
		Dim p As B4XView = xclv.GetPanel(i)
		If i > FirstIndex - ExtraSize And i < LastIndex + ExtraSize Then
			'visible+
			
			'If m_Alignment = "Center" And i = 0 Then
			If xclv.GetValue(i) Is String And "StubItem" = xclv.GetValue(i) Then Continue
			'End If
			
			If p.NumberOfViews = 0 Then
				AddChipIntern(p,xclv.GetValue(i))
			End If
		Else
			
			'If m_Alignment = "Center" And i = 0 Then
				If xclv.GetValue(i) Is String And "StubItem" = xclv.GetValue(i) Then Continue
			'End If
			
			'not visible
			If p.NumberOfViews > 0 Then
				p.RemoveAllViews
			End If
		End If
	Next
End Sub


#Region Properties

'Only in SelectionMode = Multi - Defines the maximum number of items that may be selected
'Default: 0
Public Sub setMaxSelectionCount(MaxSelecion As Int)
	m_MaxSelectionCount = MaxSelecion
End Sub

Public Sub getMaxSelectionCount As Int
	Return m_MaxSelectionCount
End Sub

Public Sub setSelectionTextColor(Color As Int)
	m_SelectionTextColor = Color
End Sub

Public Sub getSelectionTextColor As Int
	Return m_SelectionTextColor
End Sub

Public Sub getSelectionBackgroundColor As Int
	Return m_SelectionBackgroundColor
End Sub

Public Sub setSelectionBackgroundColor(Color As Int)
	m_SelectionBackgroundColor = Color
End Sub

Public Sub getSelectionBorderColor As Int
	Return m_SelectionBorderColor
End Sub

Public Sub setSelectionBorderColor(Color As Int)
	m_SelectionBorderColor = Color
End Sub

Public Sub getSelectionMode As String
	Return m_SelectionMode
End Sub

'<code>None</code>
'<code>Single</code>
'<code>Multi</code>
Public Sub setSelectionMode(Mode As String)
	m_SelectionMode = Mode
End Sub

'SelectionMode must be set to Single or Multi
Public Sub setSelection(Index As Int)
	HandleSelection(xclv.GetPanel(Index))
End Sub

'<code>AS_ScrollingChips1.SetSelections(Array As Int(0,3,7))</code>
Public Sub SetSelections(Indexes() As Int)
	For Each Index In Indexes
		HandleSelection(xclv.GetPanel(Index))
	Next
End Sub

'<code>
'	Dim lst_Indexes As List
'	lst_Indexes.Initialize
'	lst_Indexes.Add(0)
'	lst_Indexes.Add(3)
'	lst_Indexes.Add(5)
'	AS_ScrollingChips1.SetSelections2(lst_Indexes)
'</code>
Public Sub SetSelections2(Indexes As List)
	For Each Index In Indexes
		HandleSelection(xclv.GetPanel(Index))
	Next
End Sub

'Selects the items with the matching value in the tag with the value of the map item
'<code>
'	Dim ValueMap As Map
'	ValueMap.Initialize
'	ValueMap.Put("Item1","Value1")
'	ValueMap.Put("Item3","Value3")
'	ValueMap.Put("Item5","Value5")
'	AS_ScrollingChips1.SetSelections3(ValueMap)
'</code>
Public Sub SetSelections3(Values As Map)
	For Each key As String In Values.Keys
		For i = 0 To getSize -1
			If GetChip(i).Tag = Values.Get(key) Then
				HandleSelection(xclv.GetPanel(i))
				Exit
			End If
		Next
	Next
End Sub

Public Sub ClearSelections
	For i = 0 To xclv.Size -1
				
		Dim Props As ASScrollingChips_ChipProperties = xclv.GetValue(i).As(Map).Get("ChipProperties")
		
		Props.BorderSize = 0dip
		Props.BorderColor = xui.Color_Transparent

		SetChipProperties(i,Props)
	Next
	RefreshProperties
	m_SelectionMap.Clear
End Sub

Public Sub getSelections As List
	Dim lst As List
	lst.Initialize
	For Each k As String In m_SelectionMap.Keys
		lst.Add(k)
	Next
	Return lst
End Sub

'Call RefreshChips if you change something
Public Sub getRemoveIconProperties As ASScrollingChips_RemoveIconProperties
	Return g_RemoveIconProperties
End Sub
'Can only influence the appearance before the respective chip has been added
Public Sub getChipPropertiesGlobal As ASScrollingChips_ChipProperties
	Return g_ChipProperties
End Sub

Public Sub CopyChipPropertiesGlobal As ASScrollingChips_ChipProperties
	Dim ChipProps As ASScrollingChips_ChipProperties
	ChipProps.Initialize
	ChipProps.BackgroundColor = g_ChipProperties.BackgroundColor
	ChipProps.BorderSize = g_ChipProperties.BorderSize
	ChipProps.CornerRadius = g_ChipProperties.CornerRadius
	ChipProps.Height = g_ChipProperties.Height
	ChipProps.TextColor = g_ChipProperties.TextColor
	ChipProps.TextGap = g_ChipProperties.TextGap
	ChipProps.Width = g_ChipProperties.Width
	ChipProps.xFont = g_ChipProperties.xFont
	ChipProps.BorderColor = g_ChipProperties.BorderColor
	Return ChipProps
End Sub

Public Sub getCLV As CustomListView
	Return xclv
End Sub

Public Sub GetBackgroundAt(index As Int) As B4XView
	Return xclv.GetPanel(index).GetView(0)
End Sub

Public Sub GetLabelAt(index As Int) As B4XView
	Return xclv.GetPanel(index).GetView(0).GetView(0)
End Sub

Public Sub getGapBetween As Float
	Return m_GapBetween
End Sub

Public Sub setGapBetween(Gap As Float)
	m_GapBetween = Gap
End Sub

Public Sub Clear
	xclv.Clear
End Sub

Public Sub getSize As Int
	Dim Size As Int = xclv.Size
	For i = 0 To xclv.Size -1
		If xclv.GetValue(i) Is String And xclv.GetValue(i).As(String) = "StubItem" Then
			Size = Size -1
			Exit
		End If
	Next
	
	Return Size
End Sub

Public Sub RemoveChip(Index As Int)
	ChipRemoved(xclv.GetValue(Index).As(Map).Get("Chip"))
	xclv.RemoveAt(Index)
End Sub
'Call RefreshChips if you change something
Public Sub SetChipProperties(Index As Int,Properties As ASScrollingChips_ChipProperties)
	Dim mProps As Map = xclv.GetValue(Index)
	mProps.Put("ChipProperties",Properties)
	mProps.Put("Chip",mProps.Get("Chip"))
	'list_Chips.Set(Index,mProps)
End Sub

Public Sub GetChipProperties(Index As Int) As ASScrollingChips_ChipProperties
	Return xclv.GetValue(Index).As(Map).Get("ChipProperties")
End Sub

'Value = Tag
Public Sub GetChipProperties2(Value As Object) As ASScrollingChips_ChipProperties
	
	For i = 0 To xclv.Size -1
		
		If xclv.GetValue(i) Is Map And xclv.GetValue(i).As(Map).Get("Chip").As(ASScrollingChips_Chip).Tag = Value Then
			Return xclv.GetValue(i).As(Map).Get("ChipProperties")
		End If
		
	Next
	
	Return Null
End Sub

Public Sub GetChip(Index As Int) As ASScrollingChips_Chip
	Return xclv.GetValue(Index).As(Map).Get("Chip")
End Sub

'Value = Tag
Public Sub GetChip2(Value As Object) As ASScrollingChips_Chip
	
	For i = 0 To xclv.Size -1
		
		If xclv.GetValue(i) Is Map And xclv.GetValue(i).As(Map).Get("Chip").As(ASScrollingChips_Chip).Tag = Value Then
			Return xclv.GetValue(i).As(Map).Get("Chip")
		End If
		
	Next
	
	Return Null
End Sub

'Overwrites all ItemProperties with the new value
Public Sub getShowRemoveIcon As Boolean
	Return m_ShowRemoveIcon
End Sub

Public Sub setShowRemoveIcon(Show As Boolean)
	m_ShowRemoveIcon = Show
	
	For i = 0 To xclv.Size -1
				
		Dim Props As ASScrollingChips_ChipProperties = xclv.GetValue(i).As(Map).Get("ChipProperties")	
		Props.ShowRemoveIcon = Show
		SetChipProperties(i,Props)
	Next
	RefreshProperties
	
End Sub

'Call RefreshChips if you change something
Public Sub getBackgroundColor As Int
	Return m_BackgroundColor
End Sub

Public Sub setBackgroundColor(Color As Int)
	m_BackgroundColor = Color
	mBase.Color = m_BackgroundColor
	xclv.AsView.Color = m_BackgroundColor
		#If B4A
	Dim sv As HorizontalScrollView = xclv.sv
	sv.Color = m_BackgroundColor
	#Else If B4I
	xclv.sv.As(ScrollView).Color = m_BackgroundColor
	#End If
End Sub
'Call RefreshChips if you change something
Public Sub setRound(isRound As Boolean)
	m_Round = isRound
End Sub

Public Sub getRound As Boolean
	Return m_Round
End Sub

#End Region

#Region Events

Private Sub CustomDrawChip(Item As ASScrollingChips_CustomDraw)
	If xui.SubExists(mCallBack, mEventName & "_CustomDrawChip",1) Then
		CallSub2(mCallBack, mEventName & "_CustomDrawChip",Item)
	End If
End Sub


Private Sub ChipRemoved(Chip As ASScrollingChips_Chip)
	If xui.SubExists(mCallBack, mEventName & "_ChipRemoved",1) Then
		CallSub2(mCallBack, mEventName & "_ChipRemoved",Chip)
	End If
End Sub

Private Sub ChipClicked(Chip As ASScrollingChips_Chip)
	If xui.SubExists(mCallBack, mEventName & "_ChipClick",1) Then
		CallSub2(mCallBack, mEventName & "_ChipClick",Chip)
	End If
End Sub

Private Sub ChipLongClick(Chip As ASScrollingChips_Chip)
	If xui.SubExists(mCallBack, mEventName & "_ChipLongClick",1) Then
		CallSub2(mCallBack, mEventName & "_ChipLongClick",Chip)
	End If
End Sub

#If B4J
Private Sub xpnl_ChipBackground_MouseClicked (EventData As MouseEvent)
	EventData.Consume
	If EventData.PrimaryButtonPressed Then
		ClickedChip(Sender)
	else If EventData.SecondaryButtonPressed Then
		LongClickedChip(Sender)
	End If
End Sub
#Else
Private Sub xpnl_ChipBackground_Click
	ClickedChip(Sender)
End Sub
Private Sub xpnl_ChipBackground_LongClick
	LongClickedChip(Sender)
End Sub
#End If

#If B4J
Private Sub xlbl_RemoveIcon_MouseClicked (EventData As MouseEvent)
	EventData.Consume
#Else
Private Sub xlbl_RemoveIcon_Click
#End If
	
	Dim xlbl_RemoveIcon As B4XView = Sender
	
	If xui.SubExists(mCallBack, mEventName & "_RemoveChipClicked",1) Then
		Dim Index As Int = xclv.GetItemFromView(xlbl_RemoveIcon)
		CallSub2(mCallBack, mEventName & "_RemoveChipClicked",xclv.GetValue(Index).As(Map).Get("Chip"))
	Else
		RemoveChip2(xlbl_RemoveIcon)
	End If
	
End Sub

Private Sub HandleSelection(xpnl_Background As B4XView)
	Dim ThisChip As ASScrollingChips_Chip = xclv.GetValue(xclv.GetItemFromView(xpnl_Background)).As(Map).Get("Chip")
	Select m_SelectionMode
		Case "Single"
			For i = 0 To xclv.Size -1
				
				Dim Props As ASScrollingChips_ChipProperties = xclv.GetValue(i).As(Map).Get("ChipProperties")
		
				If i = ThisChip.Index And Props.BorderSize = 0dip Then
					Props.BorderSize = 2dip
					Props.BorderColor = m_SelectionBorderColor
					m_SelectionMap.Put(i,i)
				Else If m_CanDeselect And i = ThisChip.Index And Props.BorderSize = 2dip Then
					Props.BorderSize = 0dip
					Props.BorderColor = xui.Color_Transparent
					m_SelectionMap.Remove(i)
				Else if i <> ThisChip.Index Then
					Props.BorderSize = 0dip
					Props.BorderColor = xui.Color_Transparent
					m_SelectionMap.Remove(i)
				End If
				SetChipProperties(i,Props)
			Next
			RefreshProperties
		Case "Multi"
			For i = 0 To xclv.Size -1
				
				Dim Props As ASScrollingChips_ChipProperties = xclv.GetValue(i).As(Map).Get("ChipProperties")
		
				If i = ThisChip.Index And Props.BorderSize = 0dip Then
					If m_MaxSelectionCount > 0 And m_MaxSelectionCount = m_SelectionMap.Size Then Return
					Props.BorderSize = 2dip
					Props.BorderColor = m_SelectionBorderColor
					m_SelectionMap.Put(i,i)
				Else if m_CanDeselect And i = ThisChip.Index And Props.BorderSize = 2dip Then
					Props.BorderSize = 0dip
					Props.BorderColor = xui.Color_Transparent
					m_SelectionMap.Remove(i)
				End If
				SetChipProperties(i,Props)
			Next
			RefreshProperties
	End Select
End Sub

Private Sub ClickedChip(xpnl_Background As B4XView)
	Dim OldSelectionCount As Int = m_SelectionMap.Size
	HandleSelection(xpnl_Background)
	If m_MaxSelectionCount > 0 And m_SelectionMode = "Multi" And m_MaxSelectionCount = OldSelectionCount Then Return
	ChipClicked(xclv.GetValue(xclv.GetItemFromView(xpnl_Background)).As(Map).Get("Chip"))
End Sub

Private Sub LongClickedChip(xpnl_Background As B4XView)
	ChipLongClick(xclv.GetValue(xclv.GetItemFromView(xpnl_Background)).As(Map).Get("Chip"))
End Sub

Private Sub RemoveChip2(xlbl_RemoveIcon As B4XView)
	Dim Index As Int = xclv.GetItemFromView(xlbl_RemoveIcon)
	ChipRemoved(xclv.GetValue(Index).As(Map).Get("Chip"))
	xclv.RemoveAt(Index)
End Sub

#End Region

#Region Functions

Private Sub CreateLabel(EventName As String) As B4XView
	Dim tmp_lbl As Label
	tmp_lbl.Initialize(EventName)
	Return tmp_lbl
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

Private Sub MeasureTextWidth(Text As String, Font1 As B4XFont) As Int
#If B4A
	Private bmp As Bitmap
	bmp.InitializeMutable(2dip, 2dip)
	Private cvs As Canvas
	cvs.Initialize2(bmp)
	Return cvs.MeasureStringWidth(Text, Font1.ToNativeFont, Font1.Size)
#Else If B4i
    Return Text.MeasureWidth(Font1.ToNativeFont)
#Else If B4J
    Dim jo As JavaObject
    jo.InitializeNewInstance("javafx.scene.text.Text", Array(Text))
    jo.RunMethod("setFont",Array(Font1.ToNativeFont))
    jo.RunMethod("setLineSpacing",Array(0.0))
    jo.RunMethod("setWrappingWidth",Array(0.0))
    Dim Bounds As JavaObject = jo.RunMethod("getLayoutBounds",Null)
    Return Bounds.RunMethod("getWidth",Null)
#End If
End Sub

#End Region

#Region Types

Public Sub CreateASScrollingChips_ChipProperties (Height As Float, BackgroundColor As Int, TextColor As Int, xFont As B4XFont, CornerRadius As Float, BorderSize As Float, TextGap As Float) As ASScrollingChips_ChipProperties
	Dim t1 As ASScrollingChips_ChipProperties
	t1.Initialize
	t1.Height = Height
	t1.BackgroundColor = BackgroundColor
	t1.TextColor = TextColor
	t1.xFont = xFont
	t1.CornerRadius = CornerRadius
	t1.BorderSize = BorderSize
	t1.TextGap = TextGap
	Return t1
End Sub

Public Sub CreateASScrollingChips_CustomDraw (Chip As ASScrollingChips_Chip, ChipProperties As ASScrollingChips_ChipProperties, Views As ASScrollingChips_Views) As ASScrollingChips_CustomDraw
	Dim t1 As ASScrollingChips_CustomDraw
	t1.Initialize
	t1.Chip = Chip
	t1.ChipProperties = ChipProperties
	t1.Views = Views
	Return t1
End Sub

Public Sub CreateASScrollingChips_Views (BackgroundPanel As B4XView, TextLabel As B4XView, IconImageView As B4XView, RemoveIconLabel As B4XView) As ASScrollingChips_Views
	Dim t1 As ASScrollingChips_Views
	t1.Initialize
	t1.BackgroundPanel = BackgroundPanel
	t1.TextLabel = TextLabel
	t1.IconImageView = IconImageView
	t1.RemoveIconLabel = RemoveIconLabel
	Return t1
End Sub

Public Sub CreateASScrollingChips_RemoveIconProperties (BackgroundColor As Int, TextColor As Int, xFont As B4XFont, Icon As String) As ASScrollingChips_RemoveIconProperties
	Dim t1 As ASScrollingChips_RemoveIconProperties
	t1.Initialize
	t1.BackgroundColor = BackgroundColor
	t1.TextColor = TextColor
	t1.xFont = xFont
	t1.Icon = Icon
	Return t1
End Sub

#End Region


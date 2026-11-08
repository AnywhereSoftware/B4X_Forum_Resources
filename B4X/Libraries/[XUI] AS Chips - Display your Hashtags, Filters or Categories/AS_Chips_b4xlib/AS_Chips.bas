B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=11.5
@EndOfDesignText@
#If Documentation
Updates
V1.00
	-Release
V1.01
	-Add some properties
V1.02
	-Add AddChip2 - with one more parameter
		-ChipColor
V1.03
	-Add Clear - removes all chips
	-Add get and set GapBetween
V1.04
	-Add Event CustomDrawChip
	-Add Event EmptyAreaClick
V1.05
	-Add Index to ASChips_Chip Type
V1.06
	-Add get and set TopGap - Gap between items vertical
		-Default: 5dip
V1.07
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
	-Add CopyChipPropertiesGlobal
	-Add RefreshProperties - Updates just the font and colors
	-Add Designer Property SelectionBackgroundColor
		-Default: Transparent
V1.08
	-BugFix
V1.09
	-Add Designer Property SelectionTextColor
		-Default: White
	-Add SetSelections
V1.10
	-BugFixes
V1.11
	-Add SetSelections2 - Set the selected items via a list of indexes
	-Add SetSelections3 - Set the selected items via a map of chip tags
V1.12
	-BugFixes
	-Add get and set MaxSelectionCount - Only in SelectionMode = Multi - Defines the maximum number of items that may be selected
		-Default: 0
V1.13
	-Add GetLabelAt - Gets the chip text label
	-Add GetBackgroundAt - Gets the chip background panel
V1.14
	-New - ShowRemoveIcon added to ASScrollingChips_ChipProperties type
	-New - xFont and Icon added to ASScrollingChips_RemoveIconProperties type
	-New - GetChipProperties2 Get the chip props via the tag value of the item
	-New - RemoveChipClicked Event - if the event is used, automatic deletion is deactivated
V1.15
	-BugFix
#End If

#DesignerProperty: Key: SelectionMode, DisplayName: SelectionMode, FieldType: String, DefaultValue: None, List: None|Single|Multi
#DesignerProperty: Key: CanDeselect, DisplayName: CanDeselect, FieldType: Boolean, DefaultValue: True , Description: If true, then the user can remove the selection by clicking again
#DesignerProperty: Key: SelectionBorderColor, DisplayName: SelectionBorderColor, FieldType: Color, DefaultValue: 0xFFFFFFFF
#DesignerProperty: Key: SelectionBackgroundColor, DisplayName: SelectionBackgroundColor, FieldType: Color, DefaultValue: 0x00FFFFFF
#DesignerProperty: Key: SelectionTextColor, DisplayName: SelectionTextColor, FieldType: Color, DefaultValue: 0xFFFFFFFF
#DesignerProperty: Key: BackgroundColor, DisplayName: Background Color, FieldType: Color, DefaultValue: 0xFF000000
#DesignerProperty: Key: AutoExpand, DisplayName: Auto Expand, FieldType: Boolean, DefaultValue: False, Description: Increases or decreases the size of the view depending on how many chips are added. The HeightChanged event is triggered.
#DesignerProperty: Key: ShowRemoveIcon, DisplayName: Show Remove Icon, FieldType: Boolean, DefaultValue: False, Description: Displays a Remove icon which can be clicked on
#DesignerProperty: Key: Round, DisplayName: Round, FieldType: Boolean, DefaultValue: True, Description: Makes the chips round
#DesignerProperty: Key: CornerRadius, DisplayName: Corner Radius, FieldType: Int, DefaultValue: 5, MinRange: 0, Description: Only affected if Round = False

#Event: ChipClick (Chip As ASChips_Chip)
#Event: ChipLongClick (Chip As ASChips_Chip)
#Event: ChipRemoved (Chip As ASChips_Chip)
#Event: HeightChanged (Height As Float)
#Event: HiddenChipsClicked (ListChips As List)
#Event: CustomDrawChip(Item As ASChips_CustomDraw)
#Event: EmptyAreaClick
#Event: RemoveChipClicked(Chip As ASScrollingChips_Chip)

Sub Class_Globals
	
	Type ASChips_Chip(Text As String,Icon As B4XBitmap,Tag As Object,Index As Int)
	Type ASChips_ChipProperties(Height As Float,BackgroundColor As Int,TextColor As Int,xFont As B4XFont,CornerRadius As Float,BorderSize As Float,BorderColor As Int,TextGap As Float,ShowRemoveIcon As Boolean)
	Type ASChips_RemoveIconProperties(BackgroundColor As Int,TextColor As Int,xFont As B4XFont,Icon As String)
	Type ASChips_Views(BackgroundPanel As B4XView,TextLabel As B4XView,IconImageView As B4XView,RemoveIconLabel As B4XView)
	Type ASChips_CustomDraw(Chip As ASChips_Chip,ChipProperties As ASChips_ChipProperties,Views As ASChips_Views)
	
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	Private xpnl_ChipBackground As B4XView
	Private xpnl_HiddenChips As B4XView
	
	Private m_GapBetween As Float
	Private m_BackgroundColor As Int
	Private m_ShowRemoveIcon As Boolean
	Private m_AutoExpand As Boolean
	Private m_Round As Boolean
	Private m_TopGap As Float = 5dip
	Private m_SelectionMode As String
	Private m_SelectionMap As Map
	Private m_CanDeselect As Boolean
	Private m_SelectionBorderColor As Int
	Private m_SelectionBackgroundColor As Int
	Private m_SelectionTextColor As Int
	Private m_MaxSelectionCount As Int = 0
	
	Private g_ChipProperties As ASChips_ChipProperties
	Private g_RemoveIconProperties As ASChips_RemoveIconProperties
	
	Private list_Chips As List
	
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	list_Chips.Initialize
	m_SelectionMap.Initialize
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
    mBase.Tag = Me 
	IniProps(Props)
	mBase.Color = xui.Color_Transparent
	xpnl_ChipBackground = xui.CreatePanel("BaseChipBackground")
	mBase.AddView(xpnl_ChipBackground,0,0,0,0)
	
	xpnl_HiddenChips = xui.CreatePanel("xpnl_HiddenChips")
	mBase.AddView(xpnl_HiddenChips,0,0,0,0)
	
	Dim xlbl_HiddenChips As B4XView = CreateLabel("")
	xpnl_HiddenChips.AddView(xlbl_HiddenChips,0,0,0,0)
	
	#If B4A
	Base_Resize(mBase.Width,mBase.Height)
	#End If
End Sub

Private Sub IniProps(Props As Map)
	
	m_BackgroundColor = xui.PaintOrColorToColor(Props.Get("BackgroundColor"))
	m_ShowRemoveIcon = Props.Get("ShowRemoveIcon")
	m_AutoExpand = Props.Get("AutoExpand")
	m_Round = Props.Get("Round")
	m_SelectionMode = Props.GetDefault("SelectionMode","None")
	m_CanDeselect = Props.GetDefault("CanDeselect",True)
	m_SelectionBorderColor = xui.PaintOrColorToColor(Props.GetDefault("SelectionBorderColor",xui.Color_White))
	m_SelectionBackgroundColor = xui.PaintOrColorToColor(Props.GetDefault("SelectionBackgroundColor",xui.Color_ARGB(0,255,255,255)))
	m_SelectionTextColor = xui.PaintOrColorToColor(Props.GetDefault("SelectionTextColor",xui.Color_White))
	
	m_GapBetween = 5dip
	
	g_ChipProperties = CreateASChips_ChipProperties(22dip,xui.Color_Black,xui.Color_White,xui.CreateDefaultFont(14),DipToCurrent(Props.Get("CornerRadius")),0,m_SelectionBorderColor,3dip)
	g_ChipProperties.ShowRemoveIcon = m_ShowRemoveIcon
	
	g_RemoveIconProperties = CreateASChips_RemoveIconProperties(xui.Color_Black,xui.Color_White,xui.CreateMaterialIcons(9),Chr(0xE5CD))
	
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	xpnl_ChipBackground.SetLayoutAnimated(0,0,0,Width,IIf(xpnl_ChipBackground.NumberOfViews > 0 And m_AutoExpand = True,xpnl_ChipBackground.GetView(xpnl_ChipBackground.NumberOfViews -1).top + xpnl_ChipBackground.GetView(xpnl_ChipBackground.NumberOfViews -1).Height,Height))
	RefreshChips
End Sub

#If B4J
Private Sub BaseChipBackground_MouseClicked (EventData As MouseEvent)
#Else
Private Sub BaseChipBackground_Click
#End If
	EmptyAreaClick
End Sub

Public Sub AddChip(Text As String,Icon As B4XBitmap,xTag As Object)
	AddChipIntern(Text,Icon,g_ChipProperties.BackgroundColor,xTag)
End Sub

Public Sub AddChip2(Text As String,Icon As B4XBitmap,ChipColor As Int,xTag As Object)
	AddChipIntern(Text,Icon,ChipColor,xTag)
End Sub

Private Sub AddChipIntern(Text As String,Icon As B4XBitmap,ChipColor As Int,xTag As Object)
	Dim ChipProperties As ASChips_ChipProperties = CreateASChips_ChipProperties(g_ChipProperties.Height,ChipColor,g_ChipProperties.TextColor,g_ChipProperties.xFont,g_ChipProperties.CornerRadius,g_ChipProperties.BorderSize,g_ChipProperties.BorderColor,g_ChipProperties.TextGap)
	ChipProperties.ShowRemoveIcon = g_ChipProperties.ShowRemoveIcon
	
	Dim Chip As ASChips_Chip
	Chip.Text = Text
	Chip.Icon = Icon
	Chip.Tag = xTag
	Chip.Index = list_Chips.Size
	
	Dim xpnl_Background As B4XView = xui.CreatePanel("xpnl_ChipBackground")
	
	Dim xlbl_Text As B4XView = CreateLabel("")
	xpnl_Background.AddView(xlbl_Text,0,0,0,0)
	
	Dim xiv_Icon As B4XView = CreateImageView("")
	xpnl_Background.AddView(xiv_Icon,0,0,0,ChipProperties.Height)
	
	Dim xlbl_RemoveIcon As B4XView = CreateLabel("xlbl_RemoveIcon")
	xpnl_Background.AddView(xlbl_RemoveIcon,0,0,0,0)
	
	xpnl_ChipBackground.AddView(xpnl_Background,0,0,0,0)

	list_Chips.Add(CreateMap("Chip":Chip,"ChipProperties":ChipProperties))
End Sub

Public Sub RefreshChips

	xpnl_ChipBackground.Color = m_BackgroundColor
	Dim FontGap As Float = IIf(xui.IsB4J,6dip,0dip)
	Dim LastItemWhatVisible As Int = 0

	Dim CurrentLevel As Int = 0
	Dim BackgroundHeight As Float = xpnl_ChipBackground.Height
	Dim OldBackgroundHeight As Float = BackgroundHeight
	For i = 0 To list_Chips.Size -1
		
		Dim Chip As ASChips_Chip = list_Chips.Get(i).As(Map).Get("Chip")
		Dim ChipProperties As ASChips_ChipProperties = list_Chips.Get(i).As(Map).Get("ChipProperties")
		
		Dim HaveIcon As Boolean = IIf(Chip.Icon <> Null And Chip.Icon.IsInitialized = True,True,False)
		
		Dim LastChip As B4XView
		If i > 0 Then
			LastChip = xpnl_ChipBackground.GetView(i -1)
		End If
		
		'************Sizing********************************
		Dim Left As Float = IIf(LastChip.IsInitialized = True,LastChip.Left + LastChip.Width,0) + m_GapBetween
		Dim Width As Float = MeasureTextWidth(Chip.Text,ChipProperties.xFont) + FontGap + ChipProperties.TextGap*3
		
		If ChipProperties.ShowRemoveIcon Then Width = Width + IIf(xui.IsB4J,ChipProperties.Height/1.5,ChipProperties.Height)
		If HaveIcon = True Then Width = Width + ChipProperties.Height/1.3
		
		If Left + Width + m_GapBetween >= xpnl_ChipBackground.Width Then
			If m_AutoExpand = False And (ChipProperties.Height*(CurrentLevel+1))+m_TopGap*(CurrentLevel+1) + ChipProperties.Height > mBase.Height Then
				CurrentLevel = CurrentLevel
			Else
				CurrentLevel = CurrentLevel +1
			End If
		End If
		Dim Top As Float = (ChipProperties.Height*CurrentLevel)+m_TopGap*CurrentLevel
		If LastChip.IsInitialized = True Then
			Left = IIf(CurrentLevel <> LastChip.Tag,0 + m_GapBetween,Left + m_GapBetween)
		End If
		
		'************Container********************************
		
		Dim BackgroundColor As Int = ChipProperties.BackgroundColor
		Dim TextColor As Int = ChipProperties.TextColor
		If ChipProperties.BorderSize = 2dip And (m_SelectionMode = "Single" Or m_SelectionMode = "Multi") Then
			BackgroundColor = m_SelectionBackgroundColor
			TextColor = m_SelectionTextColor
		End If
		
		Dim xpnl_Background As B4XView = xpnl_ChipBackground.GetView(i)
		xpnl_Background.Tag = CurrentLevel
		xpnl_Background.SetLayoutAnimated(0,Left,Top,Width,ChipProperties.Height)
		xpnl_Background.SetColorAndBorder(BackgroundColor,ChipProperties.BorderSize,ChipProperties.BorderColor,IIf(m_Round = True,ChipProperties.Height/2, ChipProperties.CornerRadius))
		
		If m_AutoExpand = False And (ChipProperties.Height*(CurrentLevel+1))+m_TopGap*(CurrentLevel+1) + ChipProperties.Height > mBase.Height And Left + Width + MeasureTextWidth("+" & ((list_Chips.Size-1) - LastItemWhatVisible),g_ChipProperties.xFont) + FontGap + m_GapBetween + ChipProperties.TextGap*3 > mBase.Width Then
			xpnl_Background.Visible = False
			
			Dim LastVisibleItem As B4XView = xpnl_ChipBackground.GetView(LastItemWhatVisible)
			
			If LastItemWhatVisible = 0 Then
				xpnl_HiddenChips.SetLayoutAnimated(0,m_GapBetween,0,MeasureTextWidth("+" & ((list_Chips.Size -1)- LastItemWhatVisible),g_ChipProperties.xFont) + FontGap + ChipProperties.TextGap*3,g_ChipProperties.Height)
			Else
				xpnl_HiddenChips.SetLayoutAnimated(0,LastVisibleItem.Left + LastVisibleItem.Width + m_GapBetween,LastVisibleItem.Top,MeasureTextWidth("+" & ((list_Chips.Size-1) - LastItemWhatVisible),g_ChipProperties.xFont) + FontGap + ChipProperties.TextGap*3,g_ChipProperties.Height)
			End If
			
			xpnl_HiddenChips.SetColorAndBorder(g_ChipProperties.BackgroundColor,0,0,xpnl_HiddenChips.Height/2)
			
			Dim xlbl_HiddenChips As B4XView = xpnl_HiddenChips.GetView(0)
			xlbl_HiddenChips.TextColor = g_ChipProperties.TextColor
			xlbl_HiddenChips.SetLayoutAnimated(0,0,0,xpnl_HiddenChips.Width,xpnl_HiddenChips.Height)
			xlbl_HiddenChips.SetTextAlignment("CENTER","CENTER")
			xlbl_HiddenChips.Text = "+" & ((list_Chips.Size -1) - LastItemWhatVisible)
			xpnl_HiddenChips.Visible = True
		Else
			xpnl_HiddenChips.Visible = False
			xpnl_Background.Visible = True
			LastItemWhatVisible = i
		End If
		xpnl_HiddenChips.Tag = LastItemWhatVisible
		
		'************Text********************************
		Dim xlbl_Text As B4XView = xpnl_Background.GetView(0)
		xlbl_Text.TextColor = TextColor
		xlbl_Text.SetTextAlignment("CENTER","CENTER")
		xlbl_Text.Font = ChipProperties.xFont
		xlbl_Text.SetLayoutAnimated(0,ChipProperties.TextGap + IIf(HaveIcon = True,ChipProperties.Height/1.3,0),0,MeasureTextWidth(Chip.Text,ChipProperties.xFont) + FontGap + ChipProperties.TextGap,ChipProperties.Height)
		
		xlbl_Text.Text = Chip.Text
		
		'************Icon********************************
		Dim xiv_Icon As B4XView = xpnl_Background.GetView(1)
		If HaveIcon Then
			
			Dim HeightWidth As Float = ChipProperties.Height/1.3
			xiv_Icon.SetLayoutAnimated(0,ChipProperties.Height/2 - HeightWidth/2,xpnl_Background.Height/2 - HeightWidth/2,HeightWidth,HeightWidth)
			xiv_Icon.SetBitmap(Chip.Icon.Resize(xiv_Icon.Width,xiv_Icon.Height,True))
			
		End If
		xiv_Icon.Visible = HaveIcon
		'************RemoveIcon********************************
		Dim xlbl_RemoveIcon As B4XView = xpnl_Background.GetView(2)
		xlbl_RemoveIcon.Tag = i
		If ChipProperties.ShowRemoveIcon Then
			
			Dim HeightWidth As Float = ChipProperties.Height/1.5
			
			xlbl_RemoveIcon.Font = g_RemoveIconProperties.xFont
			xlbl_RemoveIcon.Text = g_RemoveIconProperties.Icon
			xlbl_RemoveIcon.SetTextAlignment("CENTER","CENTER")
			xlbl_RemoveIcon.SetColorAndBorder(g_RemoveIconProperties.BackgroundColor,0,0,HeightWidth/2)
			xlbl_RemoveIcon.TextColor = g_RemoveIconProperties.TextColor
			
			
			xlbl_RemoveIcon.SetLayoutAnimated(0,xpnl_Background.Width - ChipProperties.Height/2 - HeightWidth/2,xpnl_Background.Height/2 - HeightWidth/2,HeightWidth,HeightWidth)
			xlbl_RemoveIcon.Visible = True
		Else
			xlbl_RemoveIcon.Visible = False
		End If
		
		BackgroundHeight = xpnl_Background.Top + xpnl_Background.Height
		
		CustomDrawChip(CreateASChips_CustomDraw(Chip,ChipProperties,CreateASChips_Views(xpnl_Background,xlbl_Text,xiv_Icon,xlbl_RemoveIcon)))
		
	Next
	
	If m_AutoExpand = True Then
		If OldBackgroundHeight <> BackgroundHeight And BackgroundHeight <> mBase.Height Then HeightChanged(BackgroundHeight)
		xpnl_ChipBackground.Height = BackgroundHeight
		mBase.Height = xpnl_ChipBackground.Height
	Else
		xpnl_ChipBackground.Height = mBase.Height
		
	End If
	
End Sub

'Updates just the font and colors
Public Sub RefreshProperties
	For i = 0 To list_Chips.Size -1
		Dim ChipProperties As ASChips_ChipProperties = list_Chips.Get(i).As(Map).Get("ChipProperties")
		Dim xpnl_Background As B4XView = xpnl_ChipBackground.GetView(i)
		
		Dim BackgroundColor As Int = ChipProperties.BackgroundColor
		Dim TextColor As Int = ChipProperties.TextColor
		If ChipProperties.BorderSize = 2dip And (m_SelectionMode = "Single" Or m_SelectionMode = "Multi") Then
			BackgroundColor = m_SelectionBackgroundColor
			TextColor = m_SelectionTextColor
		End If
		xpnl_Background.SetColorAndBorder(BackgroundColor,ChipProperties.BorderSize,ChipProperties.BorderColor,IIf(m_Round = True,xpnl_Background.Height/2, ChipProperties.CornerRadius))
		Dim xlbl_Text As B4XView = xpnl_Background.GetView(0)
		xlbl_Text.TextColor = TextColor
		xlbl_Text.Font = ChipProperties.xFont
			
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

Public Sub getSelectionTextColor As Int
	Return m_SelectionTextColor
End Sub

Public Sub setSelectionTextColor(Color As Int)
	m_SelectionTextColor = Color
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
	HandleSelection(xpnl_ChipBackground.GetView(Index))
End Sub

Public Sub ClearSelections
	For i = 0 To list_Chips.Size -1
				
		Dim ChipProperties As ASChips_ChipProperties = list_Chips.Get(i).As(Map).Get("ChipProperties")
		
		ChipProperties.BorderSize = 0dip
		ChipProperties.BorderColor = xui.Color_Transparent

		SetChipProperties(i,ChipProperties)
	Next
	RefreshProperties
	m_SelectionMap.Clear
End Sub

'Returns the indexes of the selected chips
'<code>
'	For Each Index As Int In xchips_Weekdays.GetSelections
'		Log(xchips_Weekdays.GetChip(Index).Tag)
'	Next
'</code>
Public Sub GetSelections As List
	Dim lst As List
	lst.Initialize
	For Each k As String In m_SelectionMap.Keys
		lst.Add(k)
	Next
	Return lst
End Sub

'<code>AS_Chips1.SetSelections(Array As Int(0,3,7))</code>
Public Sub SetSelections(Indexes() As Int)
	For Each Index In Indexes
		HandleSelection(xpnl_ChipBackground.GetView(Index))
	Next
End Sub

'<code>
'	Dim lst_Indexes As List
'	lst_Indexes.Initialize
'	lst_Indexes.Add(0)
'	lst_Indexes.Add(3)
'	lst_Indexes.Add(5)
'	AS_Chips1.SetSelections2(lst_Indexes)
'</code>
Public Sub SetSelections2(Indexes As List)
	For Each Index In Indexes
		HandleSelection(xpnl_ChipBackground.GetView(Index))
	Next
End Sub

'Selects the items with the matching value in the tag with the value of the map item
'<code>
'	Dim ValueMap As Map
'	ValueMap.Initialize
'	ValueMap.Put("Item1","Value1")
'	ValueMap.Put("Item3","Value3")
'	ValueMap.Put("Item5","Value5")
'	AS_Chips1.SetSelections3(ValueMap)
'</code>
Public Sub SetSelections3(Values As Map)
	For Each key As String In Values.Keys
		For i = 0 To getSize -1
			If GetChip(i).Tag = Values.Get(key) Then
				HandleSelection(xpnl_ChipBackground.GetView(i))
				Exit
			End If
		Next
	Next
End Sub

Public Sub setTopGap(Gap As Float)
	m_TopGap = Gap
End Sub

Public Sub getTopGap As Float
	Return m_TopGap
End Sub

Public Sub getGapBetween As Float
	Return m_GapBetween
End Sub

Public Sub setGapBetween(Gap As Float)
	m_GapBetween = Gap
End Sub

Public Sub Clear
	list_Chips.Clear
	xpnl_ChipBackground.RemoveAllViews
End Sub

Public Sub getSize As Int
	Return list_Chips.Size
End Sub
'Call RefreshChips if you change something
Public Sub getRemoveIconProperties As ASChips_RemoveIconProperties
	Return g_RemoveIconProperties
End Sub
'Can only influence the appearance before the respective chip has been added
Public Sub getChipPropertiesGlobal As ASChips_ChipProperties
	Return g_ChipProperties
End Sub

Public Sub RemoveChip(Index As Int)
	If Index >= 0 And Index < list_Chips.Size Then
		RemoveChip2(mBase.GetView(0).GetView(Index).GetView(2))
	Else
		Log("RemoveChip index out of range")
	End If
End Sub
'Call RefreshChips if you change something
Public Sub SetChipProperties(Index As Int,Properties As ASChips_ChipProperties)
	Dim mProps As Map = list_Chips.Get(Index)
	mProps.Put("ChipProperties",Properties)
	mProps.Put("Chip",mProps.Get("Chip"))
	list_Chips.Set(Index,mProps)
End Sub

Public Sub GetChipProperties(Index As Int) As ASChips_ChipProperties
	Return list_Chips.Get(Index).As(Map).Get("ChipProperties")
End Sub

'Value = Tag
Public Sub GetChipProperties2(Value As Object) As ASChips_ChipProperties
	
	For i = 0 To list_Chips.Size -1
		
		If list_Chips.Get(i) Is Map And list_Chips.Get(i).As(Map).Get("Chip").As(ASChips_Chip).tag = Value Then
			Return list_Chips.Get(i).As(Map).Get("ChipProperties")
		End If
		
	Next
	
	Return Null
End Sub

Public Sub GetChip(Index As Int) As ASChips_Chip
	Return list_Chips.Get(Index).As(Map).Get("Chip")
End Sub

Public Sub GetBackgroundAt(index As Int) As B4XView
	Return xpnl_ChipBackground.GetView(index)
End Sub

Public Sub GetLabelAt(index As Int) As B4XView
	Return xpnl_ChipBackground.GetView(index).GetView(0)
End Sub

'Overwrites all ItemProperties with the new value
Public Sub getShowRemoveIcon As Boolean
	Return m_ShowRemoveIcon
End Sub

Public Sub setShowRemoveIcon(Show As Boolean)
	m_ShowRemoveIcon = Show
	
	For i = 0 To list_Chips.Size -1
				
		Dim Props As ASChips_ChipProperties = list_Chips.Get(i).As(Map).Get("ChipProperties")
		Props.ShowRemoveIcon = Show
		SetChipProperties(i,Props)
	Next
	RefreshProperties
	
End Sub

Public Sub getAutoExpand As Boolean
	Return m_AutoExpand
End Sub

Public Sub setAutoExpand(Expand As Boolean)
	m_AutoExpand= Expand
End Sub
'Call RefreshChips if you change something
Public Sub getBackgroundColor As Int
	Return m_BackgroundColor
End Sub

Public Sub setBackgroundColor(Color As Int)
	m_BackgroundColor = Color
End Sub
'Call RefreshChips if you change something
Public Sub setRound(isRound As Boolean)
	m_Round = isRound
End Sub

Public Sub getRound As Boolean
	Return m_Round
End Sub

Public Sub CopyChipPropertiesGlobal As ASChips_ChipProperties
	Dim ChipProps As ASChips_ChipProperties
	ChipProps.Initialize
	ChipProps.BackgroundColor = g_ChipProperties.BackgroundColor
	ChipProps.BorderSize = g_ChipProperties.BorderSize
	ChipProps.CornerRadius = g_ChipProperties.CornerRadius
	ChipProps.Height = g_ChipProperties.Height
	ChipProps.TextColor = g_ChipProperties.TextColor
	ChipProps.TextGap = g_ChipProperties.TextGap
	ChipProps.xFont = g_ChipProperties.xFont
	ChipProps.BorderColor = g_ChipProperties.BorderColor
	Return ChipProps
End Sub

#End Region

#Region Events

Private Sub EmptyAreaClick
	If xui.SubExists(mCallBack, mEventName & "_EmptyAreaClick",0) Then
		CallSub(mCallBack, mEventName & "_EmptyAreaClick")
	End If
End Sub

Private Sub CustomDrawChip(Item As ASChips_CustomDraw)
	If xui.SubExists(mCallBack, mEventName & "_CustomDrawChip",1) Then
		CallSub2(mCallBack, mEventName & "_CustomDrawChip",Item)
	End If
End Sub

Private Sub HeightChanged(Height As Float)
	If xui.SubExists(mCallBack, mEventName & "_HeightChanged",1) Then
		CallSub2(mCallBack, mEventName & "_HeightChanged",Height)
	End If
End Sub

Private Sub ChipRemoved(Chip As ASChips_Chip)
	If xui.SubExists(mCallBack, mEventName & "_ChipRemoved",1) Then
		CallSub2(mCallBack, mEventName & "_ChipRemoved",Chip)
	End If
End Sub

Private Sub ChipClicked(Chip As ASChips_Chip)
	If xui.SubExists(mCallBack, mEventName & "_ChipClick",1) Then
		CallSub2(mCallBack, mEventName & "_ChipClick",Chip)
	End If
End Sub

Private Sub ChipLongClick(Chip As ASChips_Chip)
	If xui.SubExists(mCallBack, mEventName & "_ChipLongClick",1) Then
		CallSub2(mCallBack, mEventName & "_ChipLongClick",Chip)
	End If
End Sub

Private Sub HiddenChipsClicked
	If xui.SubExists(mCallBack, mEventName & "_HiddenChipsClicked",1) Then
		
		Dim NewList As List
		NewList.Initialize
		For i = (xpnl_HiddenChips.Tag +1) To list_Chips.Size -1
			NewList.Add(list_Chips.Get(i).As(Map).Get("Chip"))
		Next
		
		CallSub2(mCallBack, mEventName & "_HiddenChipsClicked",NewList)
	End If
End Sub

'********************

#If B4J
Private Sub xlbl_RemoveIcon_MouseClicked (EventData As MouseEvent)
	EventData.Consume
#Else
Private Sub xlbl_RemoveIcon_Click
#End If

	Dim xlbl_RemoveIcon As B4XView = Sender
	
	If xui.SubExists(mCallBack, mEventName & "_RemoveChipClicked",1) Then
		Dim Index As Int = xlbl_RemoveIcon.Tag
		CallSub2(mCallBack, mEventName & "_RemoveChipClicked",list_Chips.get(Index).As(Map).Get("Chip"))
	Else
		RemoveChip2(xlbl_RemoveIcon)
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

#if B4J
Private Sub xpnl_HiddenChips_MouseClicked (EventData As MouseEvent)
	HiddenChipsClicked
End Sub
#Else
Private Sub xpnl_HiddenChips_Click
	HiddenChipsClicked
End Sub
#End If

Private Sub RemoveChip2(xlbl_RemoveIcon As B4XView)
	ChipRemoved(list_Chips.Get(xlbl_RemoveIcon.Tag).As(Map).Get("Chip"))
	list_Chips.RemoveAt(xlbl_RemoveIcon.Tag)
	xlbl_RemoveIcon.Parent.RemoveViewFromParent
	RefreshChips
End Sub

Private Sub ClickedChip(xpnl_Background As B4XView)
	Dim OldSelectionCount As Int = m_SelectionMap.Size
	HandleSelection(xpnl_Background)
	If m_MaxSelectionCount > 0 And m_SelectionMode = "Multi" And m_MaxSelectionCount = OldSelectionCount Then Return
	ChipClicked(list_Chips.Get(xpnl_Background.GetView(2).Tag).As(Map).Get("Chip"))
End Sub

Private Sub LongClickedChip(xpnl_Background As B4XView)
	HandleSelection(xpnl_Background)
	ChipLongClick(list_Chips.Get(xpnl_Background.GetView(2).Tag).As(Map).Get("Chip"))
End Sub

Private Sub HandleSelection(xpnl_Background As B4XView)
	Dim ThisChip As ASChips_Chip = list_Chips.Get(xpnl_Background.GetView(2).Tag).As(Map).Get("Chip")
	Select m_SelectionMode
		Case "Single"
			For i = 0 To list_Chips.Size -1
				
				Dim Props As ASChips_ChipProperties = list_Chips.Get(i).As(Map).Get("ChipProperties")
		
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
			For i = 0 To list_Chips.Size -1
				
				Dim Props As ASChips_ChipProperties = list_Chips.Get(i).As(Map).Get("ChipProperties")
		
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

#End Region

#Region Functions

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

Private Sub MeasureTextWidth(Text As String, Font1 As B4XFont) As Int
	
'	Dim cv As B4XCanvas
'	Dim xpnl As B4XView = xui.CreatePanel("")
'	xpnl.SetLayoutAnimated(0,0,0,1dip,1dip)
'	cv.Initialize(xpnl)
'	Return cv.MeasureText(Text,Font1).Width
	
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

#End Region

#Region Types

Public Sub CreateASChips_RemoveIconProperties (BackgroundColor As Int, TextColor As Int, xFont As B4XFont, Icon As String) As ASChips_RemoveIconProperties
	Dim t1 As ASChips_RemoveIconProperties
	t1.Initialize
	t1.BackgroundColor = BackgroundColor
	t1.TextColor = TextColor
	t1.xFont = xFont
	t1.Icon = Icon
	Return t1
End Sub

Public Sub CreateASChips_CustomDraw (Chip As ASChips_Chip, ChipProperties As ASChips_ChipProperties, Views As ASChips_Views) As ASChips_CustomDraw
	Dim t1 As ASChips_CustomDraw
	t1.Initialize
	t1.Chip = Chip
	t1.ChipProperties = ChipProperties
	t1.Views = Views
	Return t1
End Sub

Public Sub CreateASChips_Views (BackgroundPanel As B4XView, TextLabel As B4XView, IconImageView As B4XView, RemoveIconLabel As B4XView) As ASChips_Views
	Dim t1 As ASChips_Views
	t1.Initialize
	t1.BackgroundPanel = BackgroundPanel
	t1.TextLabel = TextLabel
	t1.IconImageView = IconImageView
	t1.RemoveIconLabel = RemoveIconLabel
	Return t1
End Sub

#End Region

Public Sub CreateASChips_ChipProperties (Height As Float, BackgroundColor As Int, TextColor As Int, xFont As B4XFont, CornerRadius As Float, BorderSize As Float, BorderColor As Int, TextGap As Float) As ASChips_ChipProperties
	Dim t1 As ASChips_ChipProperties
	t1.Initialize
	t1.Height = Height
	t1.BackgroundColor = BackgroundColor
	t1.TextColor = TextColor
	t1.xFont = xFont
	t1.CornerRadius = CornerRadius
	t1.BorderSize = BorderSize
	t1.BorderColor = BorderColor
	t1.TextGap = TextGap
	Return t1
End Sub


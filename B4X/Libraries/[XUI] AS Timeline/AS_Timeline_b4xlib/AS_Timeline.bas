B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
#If Documentation
Updates
V1.00
	-Release
V1.01
	-Add Event CustomDrawItem
	-Add get and set Index
V1.02
	-New SetIndexByValue - Selects the item which value is passed
#End If

#DesignerProperty: Key: UnReachedColor, DisplayName: UnReachedColor, FieldType: Color, DefaultValue: 0xFFCFDCDC
#DesignerProperty: Key: ReachedColor, DisplayName: ReachedColor, FieldType: Color, DefaultValue: 0xFFCFDCDC

#DesignerProperty: Key: AutoPlay, DisplayName: Auto Play, FieldType: Boolean, DefaultValue: False
#DesignerProperty: Key: AutoPlayInterval, DisplayName: Auto Play Interval, FieldType: Int, DefaultValue: 4000, MinRange: 0

#Event: SelectionChanged(Item As AS_Timeline_Item)
#Event: CustomDrawItem(Item As AS_Timeline_Item,Views As AS_Timeline_CustomDrawItemViews)

Sub Class_Globals
	
	Type AS_Timeline_Item(DataYear As String,DataInfo As String,Value As Object,Duration As Int,Index As Int,ItemProperties As AS_Timeline_ItemProperties)
	Type AS_Timeline_ItemProperties(UnReachedColor As Int,ReachedColor As Int,UnReachedFont As B4XFont,ReachedFont As B4XFont)
	Type AS_Timeline_CustomDrawItemViews(xpnl_Background As B4XView,xpnl_Line As B4XView,xpnl_CanvasLine As B4XView,xpnl_Round As B4XView,xlbl_DataYear As B4XView,xlbl_DataInfo As B4XView)
	
	Dim g_ItemProperties As AS_Timeline_ItemProperties
	
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Private xpnl_Background As B4XView
	
	Dim lst_Items As List
	
	Private m_Index As Int 
	Private m_Pause As Boolean = False
	Private m_AutoPlay As Boolean
	Private m_AutoPlayInterval As Int
	Private m_AutoPlayIntervalLegacy As Int
	
	Private CurrentAutoPlay As Long
	Private tmr_AutoPlayInterval As Timer
	
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	lst_Items.Initialize
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
    mBase.Tag = Me 
	IniProps(Props)

	xpnl_Background = xui.CreatePanel("")
	mBase.AddView(xpnl_Background,0,0,mBase.Width,mBase.Height)

	tmr_AutoPlayInterval.Initialize("tmr_AutoPlayInterval",50)
	
	Sleep(0)
	
	If m_AutoPlay Then
		
		Dim Item As AS_Timeline_Item = lst_Items.Get(m_Index)
		If Item.Duration > 0 Then
			m_AutoPlayInterval = Item.Duration
		End If
		
		SectorClicked(xpnl_Background.GetView(m_Index))
	End If
	
	tmr_AutoPlayInterval.Enabled = m_AutoPlay
	
End Sub

Private Sub IniProps(Props As Map)
	
	m_AutoPlay = Props.Get("AutoPlay")
	m_AutoPlayInterval = Props.Get("AutoPlayInterval")
	m_AutoPlayIntervalLegacy = Props.Get("AutoPlayInterval")
	
	g_ItemProperties = CreateAS_Timeline_ItemProperties(xui.PaintOrColorToColor(Props.Get("UnReachedColor")),xui.PaintOrColorToColor(Props.Get("ReachedColor")),xui.CreateDefaultFont(15),xui.CreateDefaultBoldFont(15))
	
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
  
End Sub

'Add a item
'DataYear - Year Text e.g. 1960
'DataInfo - Description Text
'Value - whatever you want
Public Sub AddItem(DataYear As String,DataInfo As String,Value As Object)
	
	Dim Item As AS_Timeline_Item
	Item.Initialize
	
	Item.Value = Value
	Item.DataYear = DataYear
	Item.DataInfo = DataInfo
	Item.Index = lst_Items.Size
	
	lst_Items.Add(Item)
	
End Sub

'Add a item with a custom duration for this item, if you are using auto play
'DataYear - Year Text e.g. 1960
'DataInfo - Description Text
'Value - whatever you want
'AutoPlayDuration - Duration in milliseconds
Public Sub AddItemDuration(DataYear As String,DataInfo As String,Value As Object,AutoPlayDuration As Int)
	
	Dim Item As AS_Timeline_Item
	Item.Initialize
	
	Item.Value = Value
	Item.DataYear = DataYear
	Item.DataInfo = DataInfo
	Item.Duration = AutoPlayDuration
	Item.Index = lst_Items.Size
	
	lst_Items.Add(Item)
	
End Sub

Public Sub AddItemAdvanced(Item As AS_Timeline_Item)
	
	lst_Items.Add(Item)
	
End Sub

'Call this if you change something or if you want to show it
Public Sub CreateTimeline
	
	xpnl_Background.RemoveAllViews
	
	Dim WidthBetween As Float = mBase.Width/(lst_Items.Size)
	
	Dim CircleHeight As Float = 30dip
	Dim DataYearHeight As Float = 20dip
	Dim GapBetween As Float = 10dip
	
'	Dim xpnl_Line As B4XView = xui.CreatePanel("")
'	xpnl_Line.Color = g_ItemProperties.UnReachedColor
'	xpnl_Background.AddView(xpnl_Line,0,mBase.Height - DataYearHeight - GapBetween - CircleHeight/2 - 5dip/2,mBase.Width,5dip)
	
	For i = 0 To lst_Items.Size -1
		
		Dim Item As AS_Timeline_Item = lst_Items.Get(i)
		
		Dim ItemProperties As AS_Timeline_ItemProperties = CreateAS_Timeline_ItemProperties(g_ItemProperties.UnReachedColor,g_ItemProperties.ReachedColor,g_ItemProperties.UnReachedFont,g_ItemProperties.ReachedFont)
		Item.ItemProperties = ItemProperties
		
		Dim xpnl_Sector As B4XView = xui.CreatePanel("xpnl_Sector")
		'xpnl_Sector.Color = xui.Color_Green
		xpnl_Sector.Tag = i
		xpnl_Background.AddView(xpnl_Sector,WidthBetween*i,0,WidthBetween + WidthBetween/2,mBase.Height)
		
		Dim xpnl_Line As B4XView = xui.CreatePanel("")
		xpnl_Line.Color = g_ItemProperties.UnReachedColor
		xpnl_Sector.AddView(xpnl_Line,0,mBase.Height - DataYearHeight - GapBetween - (CircleHeight)/2 - 5dip/2,WidthBetween,5dip)
		
		Dim xpnl_CanvasLine As B4XView = xui.CreatePanel("")
		xpnl_Sector.AddView(xpnl_CanvasLine,0,mBase.Height - DataYearHeight - GapBetween - (CircleHeight)/2 - 5dip/2,WidthBetween,5dip)
		
		Dim xpnl_Round As B4XView = xui.CreatePanel("")
		xpnl_Round.SetColorAndBorder(g_ItemProperties.UnReachedColor,0,0,CircleHeight/2)
		xpnl_Sector.AddView(xpnl_Round,WidthBetween/2 - CircleHeight/2,mBase.Height - DataYearHeight - GapBetween - CircleHeight,CircleHeight,CircleHeight)
		
		Dim xlbl_DataYear As B4XView = CreateLabel("")
		xlbl_DataYear.Font = ItemProperties.UnReachedFont
		xlbl_DataYear.SetTextAlignment("TOP","CENTER")
		xlbl_DataYear.Text = Item.DataYear
		xlbl_DataYear.TextColor = xui.Color_White
		'xlbl_DataYear.Color = xui.Color_Green
		xpnl_Sector.AddView(xlbl_DataYear,0,mBase.Height - DataYearHeight,WidthBetween,DataYearHeight)
			

		
		Dim xlbl_DataInfo As B4XView = CreateLabel("")
		xlbl_DataInfo.Font = ItemProperties.UnReachedFont
		xlbl_DataInfo.SetTextAlignment("CENTER","LEFT")
		xlbl_DataInfo.Text = Item.DataInfo
		xlbl_DataInfo.TextColor = xui.Color_White
		'xlbl_DataInfo.Color = xui.Color_Green
		xlbl_DataInfo.Rotation = -60
		
		#If B4J
		xlbl_DataInfo.As(Label).WrapText = True
		#Else If B4I
		xlbl_DataInfo.As(Label).Multiline = True
		#End If

		#If B4I
		xpnl_Sector.AddView(xlbl_DataInfo,xpnl_Round.Left + xpnl_Round.Width/2,xpnl_Round.Top - 50dip - GapBetween,WidthBetween,50dip)
		  
		xlbl_DataInfo.Top = xlbl_DataInfo.Top - SinD(60) * xlbl_DataInfo.Width / 2 + SinD(90 - 60) * xlbl_DataInfo.Height / 2 + GapBetween
		xlbl_DataInfo.Left = xlbl_DataInfo.Left - (CosD(60) * xlbl_DataInfo.Width / 2 - CosD(90 - 60) * xlbl_DataInfo.Height/2) - xlbl_DataInfo.Height/2
		  

		#Else
		xpnl_Sector.AddView(xlbl_DataInfo,WidthBetween/2 - 50dip/2,xpnl_Round.Top - xpnl_Round.Height - 50dip,WidthBetween,50dip)
		#End If
		
		Dim Views As AS_Timeline_CustomDrawItemViews
		Views.Initialize
		Views.xpnl_Background = xpnl_Sector
		Views.xpnl_Line = xpnl_Line
		Views.xpnl_CanvasLine = xpnl_CanvasLine
		Views.xpnl_Round = xpnl_Round
		Views.xlbl_DataYear = xlbl_DataYear
		Views.xlbl_DataInfo = xlbl_DataInfo
		
		CustomDrawItem(Item,Views)
		
	Next
	
End Sub

Private Sub SectorClicked(xpnl_TargetSector As B4XView)
	Dim WidthBetween As Float = mBase.Width/(lst_Items.Size)
	
	m_Index = xpnl_TargetSector.tag
	
	For i = 0 To xpnl_Background.NumberOfViews -1
		
		Dim xpnl_Sector As B4XView = xpnl_Background.GetView(i)
		Dim xpnl_Line As B4XView = xpnl_Sector.GetView(0)
		Dim xpnl_CanvasLine As B4XView = xpnl_Sector.GetView(1)
		Dim xpnl_Round As B4XView = xpnl_Sector.GetView(2)
		
		Dim xlbl_DataYear As B4XView = xpnl_Sector.GetView(3)
		Dim xlbl_DataInfo As B4XView = xpnl_Sector.GetView(4)
		
		Dim Item As AS_Timeline_Item = lst_Items.Get(i)

		If i <= xpnl_TargetSector.Tag.As(Int) Then
			xpnl_Round.Color = Item.ItemProperties.ReachedColor
			If xpnl_TargetSector = xpnl_Sector Then
				xpnl_CanvasLine.Width = WidthBetween/2  + IIf(i = (xpnl_Background.NumberOfViews-1),WidthBetween,0)
				SelectionChanged(Item)
			Else
				xpnl_CanvasLine.Width = WidthBetween
			End If
			xpnl_CanvasLine.Color = Item.ItemProperties.ReachedColor
			xlbl_DataYear.Font = Item.ItemProperties.ReachedFont
			xlbl_DataInfo.Font = Item.ItemProperties.ReachedFont
		Else
			xpnl_CanvasLine.Width = WidthBetween
			xpnl_CanvasLine.Color = Item.ItemProperties.UnReachedColor
			xpnl_Round.Color = Item.ItemProperties.UnReachedColor
			xlbl_DataYear.Font = Item.ItemProperties.UnReachedFont
			xlbl_DataInfo.Font = Item.ItemProperties.UnReachedFont
		End If
		
		Dim Views As AS_Timeline_CustomDrawItemViews
		Views.Initialize
		Views.xpnl_Background = xpnl_Sector
		Views.xpnl_Line = xpnl_Line
		Views.xpnl_CanvasLine = xpnl_CanvasLine
		Views.xpnl_Round = xpnl_Round
		Views.xlbl_DataYear = xlbl_DataYear
		Views.xlbl_DataInfo = xlbl_DataInfo
		
		CustomDrawItem(Item,Views)
		
	Next
End Sub

#Region Properties

Public Sub setIndex(Index As Int)
	m_Index = Index
	SectorClicked(xpnl_Background.GetView(Index))
End Sub

Public Sub getIndex As Int
	Return m_Index
End Sub

'Selects the item which value is passed
'Return True if the value was found
Public Sub SetIndexByValue(Value As Object) As Boolean
	
	For i = 0 To lst_Items.Size -1
		If lst_Items.Get(i).As(AS_Timeline_Item).Value = Value Then
			m_Index = i
			SectorClicked(xpnl_Background.GetView(m_Index))
			Return True
		End If
	Next
	Return False
End Sub

'Starts the AutoPlay
Public Sub StartAutoPlay
	SectorClicked(xpnl_Background.GetView(m_Index))
	m_AutoPlay = True
	CurrentAutoPlay = 0
	m_Pause = False
	tmr_AutoPlayInterval.Enabled = True
End Sub
'Stops the AutoPlay
Public Sub StopAutoPlay
	m_AutoPlay = False
	m_Pause = True
	tmr_AutoPlayInterval.Enabled = False
End Sub
'Paused AutoPlay
Public Sub PauseAutoPlay
	m_AutoPlay = True
	m_Pause = True
End Sub

#End Region

#If B4J
Private Sub xpnl_Sector_MouseClicked (EventData As MouseEvent)
	SectorClicked(Sender)
End Sub
#Else
Private Sub xpnl_Sector_Click
	SectorClicked(Sender)
End Sub
#End If

#Region Events

Private Sub tmr_AutoPlayInterval_Tick
	If m_Pause = False Then	CurrentAutoPlay = CurrentAutoPlay +50
	
	If CurrentAutoPlay >= m_AutoPlayInterval Then
		
		If m_Index = (lst_Items.Size -1) Then
			tmr_AutoPlayInterval.Enabled = False
			'AutoPlayEnd
		Else
			CurrentAutoPlay = 0
		End If
		
		NextPage
		
		Dim Item As AS_Timeline_Item = lst_Items.Get(m_Index)
		If Item.Duration > 0 Then
			m_AutoPlayInterval = Item.Duration
		Else
			m_AutoPlayInterval = m_AutoPlayIntervalLegacy
		End If
		
	End If
	'DrawProgress
End Sub

Private Sub NextPage
	
	If m_Index < (lst_Items.Size -1) Then
		
		m_Index = m_Index +1
		
		SectorClicked(xpnl_Background.GetView(m_Index))
		
	End If
	
End Sub

'Private Sub DrawProgress
	
'	Dim WidthBetween As Float = mBase.Width/(lst_Items.Size)
'	
'	Dim LineWidth As Float = mBase.Width/lst_Items.Size
'	
'	Dim Progress As Int = (CurrentAutoPlay / m_AutoPlayInterval) * 100
'	Dim WidthProgress As Float = (Progress / 100) * LineWidth
'	
'	Dim Item As AS_Timeline_Item = lst_Items.Get(m_Index)
'	
'	Dim xpnl As B4XView = xpnl_Background.GetView(m_Index).GetView(1)
'	xpnl.Color = Item.ItemProperties.ReachedColor
'	xpnl.Width = WidthBetween/2 + LineWidth*m_Index + WidthProgress
	
'End Sub

Private Sub SelectionChanged(Item As AS_Timeline_Item)
	If xui.SubExists(mCallBack, mEventName & "_SelectionChanged", 1) Then
		CallSub2(mCallBack, mEventName & "_SelectionChanged",Item)
	End If
End Sub

Private Sub CustomDrawItem(Item As AS_Timeline_Item,Views As AS_Timeline_CustomDrawItemViews)
	If xui.SubExists(mCallBack, mEventName & "_CustomDrawItem", 2) Then
		CallSub3(mCallBack, mEventName & "_CustomDrawItem",Item,Views)
	End If
End Sub

#End Region

#Region Functions

Private Sub CreateLabel(EventName As String) As B4XView
	Dim lbl As Label
	lbl.Initialize(EventName)
	Return lbl
End Sub

#End Region

Public Sub CreateAS_Timeline_ItemProperties (UnReachedColor As Int, ReachedColor As Int, UnReachedFont As B4XFont, ReachedFont As B4XFont) As AS_Timeline_ItemProperties
	Dim t1 As AS_Timeline_ItemProperties
	t1.Initialize
	t1.UnReachedColor = UnReachedColor
	t1.ReachedColor = ReachedColor
	t1.UnReachedFont = UnReachedFont
	t1.ReachedFont = ReachedFont
	Return t1
End Sub

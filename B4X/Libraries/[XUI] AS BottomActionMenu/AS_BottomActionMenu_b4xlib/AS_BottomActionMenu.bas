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
	-New HidePicker
	-New get isOpen
V1.02
	-BreakingChange get and set TextColor renamed -> DragIndicatorColor
	-New AS_BottomActionMenu_ItemProperties type
	-New get ItemProperties
	-BugFixes
V1.03
	-BugFix - Icon under B4A in wrong position
#End If

#Event: ItemClick (Index As Int, Value As Object)

Sub Class_Globals
	
	Type AS_BottomActionMenu_ItemProperties(xFont As B4XFont,TextColor As Int,Width As Float)
	
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Private xParent As B4XView
	Private BottomCard As ASDraggableBottomCard
	Private xpnl_ListviewBackground As B4XView
	Private xclv_Main As CustomListView
	
	Private xpnl_Header As B4XView
	Private xpnl_Body As B4XView
	Private xpnl_DragIndicator As B4XView
	
	Private m_HeaderHeight As Float
	Private m_BodyHeight As Float
	Private m_HeaderColor As Int
	Private m_BodyColor As Int
	Private m_DragIndicatorColor As Int
	
	Private g_ItemProperties As AS_BottomActionMenu_ItemProperties
	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(Callback As Object,EventName As String,Parent As B4XView)
	
	mEventName = EventName
	mCallBack = Callback
	xParent = Parent
	
	m_HeaderHeight = 40dip
	m_BodyHeight = 100dip
	
	xpnl_Header = xui.CreatePanel("")
	xpnl_Body = xui.CreatePanel("")
	xpnl_DragIndicator = xui.CreatePanel("")
	xpnl_ListviewBackground = xui.CreatePanel("")
	xpnl_ListviewBackground.SetLayoutAnimated(0,0,0,Parent.Width,m_BodyHeight)
	
	m_HeaderColor = xui.Color_ARGB(255,32, 33, 37)
	m_BodyColor = xui.Color_ARGB(255,32, 33, 37)
	m_DragIndicatorColor = xui.Color_White
	
	g_ItemProperties.Initialize
	g_ItemProperties.TextColor = xui.Color_White
	g_ItemProperties.Width = 90dip
	g_ItemProperties.xFont = xui.CreateDefaultBoldFont(14)
	
	ini_xclv
	
End Sub

Private Sub ini_xclv
	Dim tmplbl As Label
	tmplbl.Initialize("")
 
	Dim tmpmap As Map
	tmpmap.Initialize
	tmpmap.Put("DividerColor",0x00FFFFFF)
	tmpmap.Put("DividerHeight",0)
	tmpmap.Put("PressedColor",0x00FFFFFF)
	tmpmap.Put("InsertAnimationDuration",0)
	tmpmap.Put("ListOrientation","Horizontal")
	tmpmap.Put("ShowScrollBar",False)
	xclv_Main.Initialize(Me,"xclv_main")
	xclv_Main.DesignerCreateView(xpnl_ListviewBackground,tmplbl,tmpmap)
	#IF B4A
	
	xclv_Main.AsView.SetLayoutAnimated(0,xclv_Main.AsView.Left,xclv_Main.AsView.Top,xpnl_ListviewBackground.Width,xpnl_ListviewBackground.Height)
	xclv_Main.Base_Resize(xpnl_ListviewBackground.Width,xpnl_ListviewBackground.Height)
	#End if
	
	#If B4I
	Dim sv As ScrollView = xclv_Main.sv
	sv.Color = xui.Color_Transparent'xui.Color_ARGB(255,32, 33, 37)
	#Else If B4J
	xclv_Main.sv.As(ScrollPane).Style = "-fx-background:transparent;-fx-background-color:transparent;"
	#End If
	
	xclv_Main.AsView.Color = xui.Color_Transparent
	xclv_Main.sv.ScrollViewInnerPanel.Color = xui.Color_Transparent
	xclv_Main.GetBase.Color = xui.Color_Transparent
	
End Sub

Public Sub HidePicker
	BottomCard.Hide(False)
End Sub

Public Sub ShowPicker
	
	Dim DatePickerHeight As Float = m_BodyHeight
	Dim SafeAreaHeight As Float = 0
	
	#If B4I
	SafeAreaHeight = B4XPages.GetNativeParent(B4XPages.MainPage).SafeAreaInsets.Bottom
	m_BodyHeight = m_BodyHeight + SafeAreaHeight
	#Else
	SafeAreaHeight = 20dip
	m_BodyHeight = m_BodyHeight + SafeAreaHeight
	#End If
	
	BottomCard.Initialize(Me,"BottomCard")
	BottomCard.BodyDrag = True
	BottomCard.Create(xParent,m_BodyHeight,m_BodyHeight,m_HeaderHeight,xParent.Width,BottomCard.Orientation_MIDDLE)
	
	xpnl_Header.Color = m_HeaderColor
	
	xpnl_Header.AddView(xpnl_DragIndicator,xParent.Width/2 - 70dip/2,m_HeaderHeight/2 - 6dip/2,70dip,6dip)
	Dim ARGB() As Int = GetARGB(m_DragIndicatorColor)
	xpnl_DragIndicator.SetColorAndBorder(xui.Color_ARGB(80,ARGB(1),ARGB(2),ARGB(3)),0,0,3dip)
	
	BottomCard.BodyPanel.Color = m_BodyColor
	BottomCard.HeaderPanel.AddView(xpnl_Header,0,0,xParent.Width,m_HeaderHeight)
	BottomCard.BodyPanel.AddView(xpnl_Body,0,0,xParent.Width,DatePickerHeight)
	BottomCard.CornerRadius_Header = 30dip/2
	
	
	xpnl_ListviewBackground.RemoveViewFromParent
	xpnl_Body.AddView(xpnl_ListviewBackground,0,0,xpnl_Body.Width,m_BodyHeight)
	
'	Dim xlbl_Abort As B4XView = CreateLabel("xlbl_Abort")
'	xlbl_Abort.TextColor = xui.Color_White
'	xlbl_Abort.SetTextAlignment("CENTER","CENTER")
'	xlbl_Abort.Text = "Abort"
'	xlbl_Abort.Font = xui.CreateDefaultBoldFont(18)	
'	xlbl_Abort.Color = xui.Color_Red
'	xpnl_Body.AddView(xlbl_Abort,0,xpnl_ListviewBackground.Height,xpnl_Body.Width,50dip)
	
	Sleep(0)
	
	BottomCard.Show(False)
	
End Sub

Public Sub AddItem(Text As String,Icon As B4XBitmap,Value As Object)
	
	Dim xpnl_Background As B4XView = xui.CreatePanel("")
	xpnl_Background.Color = m_BodyColor
	xpnl_Background.SetLayoutAnimated(0,0,0,g_ItemProperties.Width,m_BodyHeight)
	
	Dim xiv_Icon As B4XView = CreateImageView
	xpnl_Background.AddView(xiv_Icon,g_ItemProperties.Width/2 - 30dip/2,m_BodyHeight/2 - 30dip,30dip,30dip)
	xiv_Icon.SetBitmap(Icon)
	
	Dim xlbl_ItemText As B4XView = CreateLabel("")
	xlbl_ItemText.TextColor = g_ItemProperties.TextColor
	xlbl_ItemText.SetTextAlignment("CENTER","CENTER")
	xlbl_ItemText.Text = Text
	#If B4I
	xlbl_ItemText.As(Label).Multiline = True
	#Else If B4A
	xlbl_ItemText.As(Label).SingleLine = False
	#End If
	xlbl_ItemText.Font = g_ItemProperties.xFont
	xpnl_Background.AddView(xlbl_ItemText,0,m_BodyHeight/2,xpnl_Background.Width,38dip)
	
	xclv_Main.Add(xpnl_Background,Value)
	
End Sub

#Region Properties

'Defaults:
'TextColor - White
'Width - 90dip
'xFont - Bold 14
Public Sub getItemProperties As AS_BottomActionMenu_ItemProperties
	Return g_ItemProperties
End Sub

Public Sub getisOpen As Boolean
	Return BottomCard.IsOpen
End Sub

Public Sub setDragIndicatorColor(Color As Int)
	m_DragIndicatorColor = Color
	Dim ARGB() As Int = GetARGB(m_DragIndicatorColor)
	xpnl_DragIndicator.SetColorAndBorder(xui.Color_ARGB(80,ARGB(1),ARGB(2),ARGB(3)),0,0,3dip)
End Sub

Public Sub getDragIndicatorColor As Int
	Return m_DragIndicatorColor
End Sub

Public Sub setColor(Color As Int)
	m_BodyColor = Color
	If BottomCard.IsInitialized Then BottomCard.BodyPanel.Color = m_BodyColor
	m_HeaderColor = Color
	xpnl_Body.Color = Color
	xpnl_Header.Color = Color
End Sub

Public Sub getColor As Int
	Return m_BodyColor
End Sub

#End Region

#Region Events

Private Sub xclv_main_ItemClick (Index As Int, Value As Object)
	If xui.SubExists(mCallBack, mEventName & "_ItemClick",2) Then
		CallSub3(mCallBack, mEventName & "_ItemClick",Index,Value)
	End If
	BottomCard.Hide(True)
End Sub

#End Region

#Region Functions

Private Sub CreateLabel(EventName As String) As B4XView
	Dim lbl As Label
	lbl.Initialize(EventName)
	Return lbl
End Sub

Private Sub CreateImageView As B4XView
	Dim iv As ImageView
	iv.Initialize("")
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

Private Sub GetARGB(Color As Int) As Int()'ignore
	Dim res(4) As Int
	res(0) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff000000), 24)
	res(1) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff0000), 16)
	res(2) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff00), 8)
	res(3) = Bit.And(Color, 0xff)
	Return res
End Sub

#End Region

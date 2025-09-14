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
#End If

#Event: ActionButtonClicked
#Event: Close
#Event: CustomDrawItem(Item As AS_AppSummary_Item,ItemViews As AS_AppSummary_ItemViews)
#Event: ItemClicked(Item As AS_AppSummary_Item)

Sub Class_Globals
	
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Private xParent As B4XView
	Private BottomCard As ASDraggableBottomCard
	Private m_AppSummary As AS_AppSummary
	Private xpnl_ItemsBackground As B4XView
	
	Private xpnl_Header As B4XView
	Private xpnl_Body As B4XView
	Private xpnl_DragIndicator As B4XView
	
	Private m_HeaderHeight As Float
	Private m_HeaderColor As Int
	Private m_BodyColor As Int
	Private m_DragIndicatorColor As Int
	Private m_SheetWidth As Float = 0
	
	Type AS_BottomAppSummary_Theme(BodyColor As Int,TextColor As Int,DragIndicatorColor As Int,AppSummary As AS_AppSummary_Theme)
	
End Sub

Public Sub getTheme_Light As AS_BottomAppSummary_Theme
	
	Dim Theme As AS_BottomAppSummary_Theme
	Theme.Initialize
	Theme.BodyColor = xui.Color_White
	Theme.TextColor = xui.Color_Black
	Theme.DragIndicatorColor = xui.Color_Black

	Dim AppSummary_Theme As AS_AppSummary_Theme = m_AppSummary.Theme_Light
	AppSummary_Theme.BackgroundColor = Theme.BodyColor
	Theme.AppSummary = AppSummary_Theme

	Return Theme
	
End Sub

Public Sub getTheme_Dark As AS_BottomAppSummary_Theme
	
	Dim Theme As AS_BottomAppSummary_Theme
	Theme.Initialize
	Theme.BodyColor = xui.Color_ARGB(255,19, 20, 22)
	Theme.TextColor = xui.Color_White
	Theme.DragIndicatorColor = xui.Color_White

	Dim AppSummary_Theme As AS_AppSummary_Theme = m_AppSummary.Theme_Dark
	AppSummary_Theme.BackgroundColor = Theme.BodyColor
	Theme.AppSummary = AppSummary_Theme

	Return Theme
	
End Sub

Public Sub setTheme(Theme As AS_BottomAppSummary_Theme)
	
	m_HeaderColor = Theme.BodyColor
	m_BodyColor = Theme.BodyColor
	m_DragIndicatorColor = Theme.DragIndicatorColor
	setColor(m_BodyColor)
	m_AppSummary.Theme = Theme.AppSummary
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(Callback As Object,EventName As String,Parent As B4XView)
	
	mEventName = EventName
	mCallBack = Callback
	xParent = Parent
	
	xpnl_Header = xui.CreatePanel("")
	xpnl_Body = xui.CreatePanel("")
	xpnl_DragIndicator = xui.CreatePanel("")
	xpnl_ItemsBackground = xui.CreatePanel("")
	xpnl_ItemsBackground.SetLayoutAnimated(0,0,0,100dip,100dip)
	
	m_AppSummary.Initialize(Me,"AppSummary")
	m_AppSummary.CreateViewPerCode(xpnl_ItemsBackground,0,0,100dip,100dip)
	m_AppSummary.ThemeChangeTransition = "None"
	m_AppSummary.Theme = m_AppSummary.Theme_Dark
	m_AppSummary.TitleTop = 0
	
	m_DragIndicatorColor = xui.Color_ARGB(80,255,255,255)
	m_HeaderColor = xui.Color_ARGB(255,32, 33, 37)
	m_BodyColor = xui.Color_ARGB(255,32, 33, 37)
	
	m_HeaderHeight = 30dip

End Sub

Public Sub SetTitleText(Text1 As String,ColoredText As String,Text2 As String)
	m_AppSummary.SetTitleText(Text1,ColoredText,Text2)
End Sub

Public Sub AddItem(Name As String,Description As String,Icon As B4XBitmap,Value As Object) As AS_AppSummary_Item
	Return m_AppSummary.AddItem(Name,Description,Icon,Value)
End Sub

Public Sub AddImageItem(xBitmap As B4XBitmap,Height As Float,Value As Object) As AS_AppSummary_ImageItem
	Return m_AppSummary.AddImageItem(xBitmap,Height,Value)
End Sub

Public Sub AddDescriptionItem(Text As String,Value As Object) As AS_AppSummary_DescriptionItem
	Return m_AppSummary.AddDescriptionItem(Text,Value)
End Sub

Public Sub AddTitleItem(Text As String,Value As Object) As AS_AppSummary_TitleItem
	Return m_AppSummary.AddTitleItem(Text,Value)
End Sub

Public Sub AddPlaceholder(Height As Float)
	m_AppSummary.AddPlaceholder(Height)
End Sub

Public Sub ShowPicker(BodyHeight As Float)
	
	Dim SheetWidth As Float = IIf(m_SheetWidth=0,xParent.Width,m_SheetWidth)
	
	Dim SafeAreaHeight As Float = 0
	
	'If m_ActionButtonVisible Then
		BodyHeight = BodyHeight + 50dip
	'End If
	
	#If B4I
	SafeAreaHeight = B4XPages.GetNativeParent(B4XPages.MainPage).SafeAreaInsets.Bottom
	BodyHeight = BodyHeight + SafeAreaHeight
	#Else
	SafeAreaHeight = 20dip
	BodyHeight = BodyHeight + SafeAreaHeight
	#End If
	
	BottomCard.Initialize(Me,"BottomCard")
	BottomCard.BodyDrag = True
	BottomCard.Create(xParent,BodyHeight,BodyHeight,m_HeaderHeight,SheetWidth,BottomCard.Orientation_MIDDLE)
	
	xpnl_Header.Color = m_HeaderColor
	
	xpnl_Header.AddView(xpnl_DragIndicator,SheetWidth/2 - 70dip/2,m_HeaderHeight/2 - 6dip/2,70dip,6dip)
	Dim ARGB() As Int = GetARGB(m_DragIndicatorColor)
	xpnl_DragIndicator.SetColorAndBorder(xui.Color_ARGB(80,ARGB(1),ARGB(2),ARGB(3)),0,0,3dip)
	
	m_AppSummary.ConfirmButtonText = "Continue"

	BottomCard.BodyPanel.Color = m_BodyColor
	BottomCard.HeaderPanel.AddView(xpnl_Header,0,0,SheetWidth,m_HeaderHeight)
	BottomCard.BodyPanel.AddView(xpnl_Body,0,0,SheetWidth,BodyHeight)
	BottomCard.CornerRadius_Header = 30dip/2
	
	xpnl_ItemsBackground.RemoveViewFromParent
	xpnl_Body.AddView(xpnl_ItemsBackground,0,0,xpnl_Body.Width,BodyHeight - SafeAreaHeight)
	m_AppSummary.Base_Resize(xpnl_ItemsBackground.Width,xpnl_ItemsBackground.Height)
	m_AppSummary.Refresh
	
	Sleep(0)
	
	BottomCard.Show(False)
	
End Sub

Public Sub HidePicker
	BottomCard.Hide(False)
End Sub

#Region Properties

Public Sub getItemIconProperties As AS_AppSummary_ItemIconProperties
	Return m_AppSummary.ItemIconProperties
End Sub

'Fade or None
Public Sub setThemeChangeTransition(ThemeChangeTransition As String)
	m_AppSummary.ThemeChangeTransition = ThemeChangeTransition
End Sub

Public Sub getThemeChangeTransition As String
	Return m_AppSummary.ThemeChangeTransition
End Sub

Public Sub getAppSummary As AS_AppSummary
	Return m_AppSummary
End Sub

'Set the value to greater than 0 to set a custom width
'Set the value to 0 to use the full screen width
'Default: 0
Public Sub setSheetWidth(SheetWidth As Float)
	m_SheetWidth = SheetWidth
End Sub

Public Sub getSheetWidth As Float
	Return m_SheetWidth
End Sub

Public Sub setDragIndicatorColor(Color As Int)
	m_DragIndicatorColor = Color
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

Public Sub setConfirmButtonText(ConfirmButtonText As String)
	m_AppSummary.ConfirmButtonText = ConfirmButtonText
End Sub

#End Region

#Region Events

Private Sub AppSummary_ConfirmButtonClick
	XUIViewsUtils.PerformHapticFeedback(xpnl_ItemsBackground)
	If xui.SubExists(mCallBack, mEventName & "_ActionButtonClicked",0) Then
		CallSub(mCallBack, mEventName & "_ActionButtonClicked")
	End If
End Sub

Private Sub BottomCard_Close
	If xui.SubExists(mCallBack, mEventName & "_Close",0) Then
		CallSub(mCallBack, mEventName & "_Close")
	End If
End Sub

Private Sub AppSummary_CustomDrawItem(Item As AS_AppSummary_Item,ItemViews As AS_AppSummary_ItemViews)
	If xui.SubExists(mCallBack, mEventName & "_CustomDrawItem",2) Then
		CallSub3(mCallBack, mEventName & "_CustomDrawItem",Item,ItemViews)
	End If
End Sub

Private Sub AppSummary_ItemClicked(Item As AS_AppSummary_Item)
	If xui.SubExists(mCallBack, mEventName & "_ItemClicked",1) Then
		CallSub2(mCallBack, mEventName & "_ItemClicked",Item)
	End If
End Sub

#End Region

#Region Functions

Private Sub GetARGB(Color As Int) As Int()
	Dim res(4) As Int
	res(0) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff000000), 24)
	res(1) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff0000), 16)
	res(2) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff00), 8)
	res(3) = Bit.And(Color, 0xff)
	Return res
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

#End Region

#Region Types

#End Region

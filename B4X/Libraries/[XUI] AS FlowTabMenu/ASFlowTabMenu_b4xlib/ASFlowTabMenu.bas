B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.8
@EndOfDesignText@
'ASFlowTabMenu
'Author: Alexander Stolte
'Version: 1.00

#If Documentation
TODO:
-Animation: Text zoom in and out
-Animation: Text visible animated

Updates:
V1.00
	-Release
V1.01
	-BugFix on RemoveTab
#End If

#DesignerProperty: Key: BackgroundColor, DisplayName: Background Color, FieldType: Color, DefaultValue: 0xFF212121, Description: Text color
#DesignerProperty: Key: SelectorColor, DisplayName: Selector Color, FieldType: Color, DefaultValue: 0x982d8879, Description: Text color

#Event: TabClick(index as int)

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	Private xpnl_TabBackground As B4XView
	Private xpnl_TabSelector As B4XView
	
	Private mIconHeight As Float = 35dip
	Private mCurrentIndex As Int = 0
	
	Private m_BackgroundColor As Int
	Private m_SelectorColor As Int
	
	Type ASFlowTabMenu_Tab (Index As Int,Icon As B4XBitmap,Text As String,TextColor As Int,xFont As B4XFont)
	
	Private gTabProp As ASFlowTabMenu_Tab
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	gTabProp.Initialize
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
    mBase.Tag = Me 

	xpnl_TabBackground = xui.CreatePanel("")
	xpnl_TabSelector = xui.CreatePanel("")
	mBase.AddView(xpnl_TabSelector,0,0,0,0)
	mBase.AddView(xpnl_TabBackground,0,0,0,0)

	IniProps(Props)
	
	gTabProp = CreateASFlowTabMenu_Tab(-1,Null,"",xui.Color_White,xui.CreateDefaultFont(15))
	
	#If B4A
	Base_Resize(mBase.width,mBase.height)
	#End If

End Sub

Private Sub IniProps(Props As Map)
	m_SelectorColor = xui.PaintOrColorToColor(Props.Get("SelectorColor"))
	m_BackgroundColor = xui.PaintOrColorToColor(Props.Get("BackgroundColor"))
	
	xpnl_TabSelector.SetColorAndBorder(m_SelectorColor,0,0,10dip)
	xpnl_TabBackground.Color = xui.Color_Transparent
	mBase.Color = m_BackgroundColor
	
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	xpnl_TabBackground.SetLayoutAnimated(0,0,0,Width,Height)
	
	UpdateTabs(False)
	
End Sub

Private Sub UpdateTabs(Animated As Boolean)
	Dim duration As Int = 0
	If Animated = True Then duration = 250
	
	Dim MaxWidth As Float = xpnl_TabBackground.Width/xpnl_TabBackground.NumberOfViews
	
	For i = 0 To xpnl_TabBackground.NumberOfViews -1
		Dim xpnl_Tab As B4XView = xpnl_TabBackground.GetView(xpnl_TabBackground.GetView(i).Tag.As(ASFlowTabMenu_Tab).Index)
		Dim Tab1 As ASFlowTabMenu_Tab = xpnl_Tab.Tag
		
		Dim xlbl_Text As B4XView = xpnl_Tab.GetView(0)
		Dim xiv_Icon As B4XView = xpnl_Tab.GetView(1)
		
		Dim TextWidth As Int = MeasureTextWidth(xlbl_Text.Text,xlbl_Text.Font)
		Dim LabelWidth As Float = TextWidth + mIconHeight + 5dip
		
		xpnl_Tab.SetLayoutAnimated(0,(mBase.Width/xpnl_TabBackground.NumberOfViews) * i,0,mBase.Width/xpnl_TabBackground.NumberOfViews,mBase.Height)
		
		If mCurrentIndex <> i Then
			Dim NormalPanelWidth As Float = mBase.Width/xpnl_TabBackground.NumberOfViews
			xlbl_Text.SetLayoutAnimated(duration,NormalPanelWidth/2 - LabelWidth/2 + mIconHeight,0,LabelWidth - mIconHeight,xpnl_Tab.Height)
			xlbl_Text.SetVisibleAnimated(duration/2,False)
			xiv_Icon.SetLayoutAnimated(duration,NormalPanelWidth/2 - mIconHeight/2,mBase.Height/2 - mIconHeight/2,mIconHeight,mIconHeight)
		
		Else
			
'			xpnl_Tab.Top = 0
'			xpnl_Tab.Height = mBase.Height
			
			'xpnl_Tab.SetLayoutAnimated(0,(mBase.Width/xpnl_TabBackground.NumberOfViews) * i,0,mBase.Width/xpnl_TabBackground.NumberOfViews,mBase.Height)
			
			If LabelWidth > MaxWidth Then LabelWidth = MaxWidth
			
			
'			Dim Width As Float = xpnl_TabBackground.Width/xpnl_TabBackground.NumberOfViews
'			If mCurrentIndex = 0 Or mCurrentIndex = (xpnl_TabBackground.NumberOfViews -1) Then
'				Width = Width + (xpnl_TabBackground.Width/xpnl_TabBackground.NumberOfViews)/2 - mIconHeight
'				If mCurrentIndex = 0 Then
'					xpnl_Tab.Width = Width
'					xpnl_Tab.Left = 0
'				Else
'					xpnl_Tab.Left = xpnl_TabBackground.Width - Width
'					xpnl_Tab.Width = Width
'				End If
'			Else
'				Width = Width + (xpnl_TabBackground.Width/xpnl_TabBackground.NumberOfViews) - mIconHeight*2
'				xpnl_Tab.Width = Width
'				'xpnl_Tab.Left = xpnl_TabBackground.GetView(mCurrentIndex -1).Left + xpnl_TabBackground.GetView(mCurrentIndex -1).Width/2 + mIconHeight
'				xpnl_Tab.Left = (mBase.Width/xpnl_TabBackground.NumberOfViews) * i - MaxWidth/2 + mIconHeight/2
'			End If
'			
'			xpnl_Tab.SendToBack
			
			
			xiv_Icon.SetLayoutAnimated(duration,xpnl_Tab.Width/2 - LabelWidth/2,mBase.Height/2 - mIconHeight/2,mIconHeight,mIconHeight)
			xlbl_Text.SetLayoutAnimated(duration,xpnl_Tab.Width/2 - LabelWidth/2 + mIconHeight,0,LabelWidth - mIconHeight - 5dip/2,xpnl_Tab.Height)
			
			xlbl_Text.SetVisibleAnimated(duration,True)
			
			xpnl_TabSelector.SetLayoutAnimated(duration,xpnl_Tab.Left + xpnl_Tab.Width/2 - LabelWidth/2,xpnl_Tab.Height/2 - mIconHeight/2,LabelWidth,mIconHeight)
		End If
		
		xiv_Icon.SetBitmap(Tab1.Icon.Resize(mIconHeight,mIconHeight,True))
		
	Next
End Sub
'Add a new tab
Public Sub AddTab(Icon As B4XBitmap,Text As String)
	
	Dim xpnl_Tab As B4XView = xui.CreatePanel("xpnl_Tab")
	xpnl_Tab.SetLayoutAnimated(0,0,0,0,0)
	'xpnl_Tab.Color = Rnd(xui.Color_Black,xui.Color_White)
	Dim xlbl_Text As B4XView = CreateLabel("")
	Dim xiv_Icon As B4XView = CreateImageView("")
	
	xpnl_Tab.AddView(xlbl_Text,0,0,0,0)
	xpnl_Tab.AddView(xiv_Icon,0,0,0,0)
	
	xlbl_Text.TextColor = gTabProp.TextColor
	xlbl_Text.SetTextAlignment("CENTER","LEFT")
	'xlbl_Text.SetTextAlignment("CENTER","CENTER")
	xlbl_Text.Text = Text
	xlbl_Text.Font = gTabProp.xFont
	
	xpnl_Tab.Tag = CreateASFlowTabMenu_Tab(xpnl_TabBackground.NumberOfViews,Icon,Text,gTabProp.TextColor,gTabProp.xFont)
	
	xpnl_TabBackground.AddView(xpnl_Tab,0,0,0,0)
	
	Base_Resize(mBase.Width,mBase.Height)
End Sub
'Removes a tab from a certain index
Public Sub RemoveTab(Index As Int)
	xpnl_TabBackground.GetView(Index).RemoveViewFromParent
	
	For i = 0 To xpnl_TabBackground.NumberOfViews -1
		Dim xpnl_Tab As B4XView = xpnl_TabBackground.GetView(i)
		Dim Tab1 As ASFlowTabMenu_Tab = xpnl_Tab.Tag
		Tab1.Index = i
		xpnl_Tab.Tag = Tab1
	Next
	
	If mCurrentIndex <> Index Then
		mCurrentIndex = 0
		TabClickEvent
		Else
		mCurrentIndex = 0
	End If

	Base_Resize(mBase.Width,mBase.Height)
End Sub

'Gets or sets the current index
'Sets the current index without animation
Public Sub getCurrentIndex As Int
	Return mCurrentIndex
End Sub

Public Sub setCurrentIndex(Index As Int)
	mCurrentIndex = Index : UpdateTabs(False)
End Sub
'Sets the current index with animation
Public Sub setCurrentIndexAnimated(Index As Int)
	mCurrentIndex = Index : UpdateTabs(True)
End Sub

Public Sub GetTabPropertiesAt(Index As Int) As ASFlowTabMenu_Tab
	Return xpnl_TabBackground.GetView(Index).Tag.As(ASFlowTabMenu_Tab)
End Sub
'Call RefreshTabProperties after this
Public Sub SetTabProperties(Index As Int,TabProperties As ASFlowTabMenu_Tab)
	xpnl_TabBackground.GetView(Index).Tag = TabProperties
End Sub
'If you change Tab Properties then call this function to apply this
Public Sub RefreshTabProperties
	For i = 0 To xpnl_TabBackground.NumberOfViews -1
		Dim xpnl_Tab As B4XView = xpnl_TabBackground.GetView(i)
		Dim xlbl_Text As B4XView = xpnl_Tab.GetView(0)
		Dim xiv_Icon As B4XView = xpnl_Tab.GetView(1)
		
		Dim TabProp As ASFlowTabMenu_Tab = xpnl_Tab.Tag
		
		xlbl_Text.TextColor = xui.Color_White
		xlbl_Text.SetTextAlignment("CENTER","LEFT")
		xlbl_Text.SetTextAlignment("CENTER","CENTER")
		xlbl_Text.Text = TabProp.Text
		xlbl_Text.Font = xui.CreateDefaultFont(15)
		
		xiv_Icon.SetBitmap(TabProp.Icon.Resize(mIconHeight,mIconHeight,True))
		
	Next
End Sub
'Gets or sets the icon Width and Height
Public Sub getIconHeight As Float
	Return mIconHeight
End Sub
'Gets or sets the icon Width and Height
Public Sub setIconHeight(Height As Float)
	mIconHeight = Height
End Sub

Public Sub getSize As Int
	Return xpnl_TabBackground.NumberOfViews
End Sub
'Change this properties before you add tabs
Public Sub getGlobalTabProperties As ASFlowTabMenu_Tab
	Return gTabProp
End Sub


#If B4J
Private Sub xpnl_Tab_MouseClicked (EventData As MouseEvent)
	TabClick(Sender)
End Sub
#Else
Private Sub xpnl_Tab_Click
	TabClick(Sender)
End Sub
#End If

Private Sub TabClick(xpnl_Tab As B4XView)
	
	'For i = 0 To xpnl_TabBackground.NumberOfViews -1
	'If xpnl_TabBackground.GetView(i).Tag.As(ASFlowTabMenu_Tab).Index = xpnl_Tab.Tag.As(ASFlowTabMenu_Tab).Index Then
	If mCurrentIndex <> xpnl_Tab.Tag.As(ASFlowTabMenu_Tab).Index Then
		mCurrentIndex = xpnl_Tab.Tag.As(ASFlowTabMenu_Tab).Index
	TabClickEvent
	UpdateTabs(True)
	End If
	'Exit
	'	End If
	'Next
	
End Sub

Private Sub TabClickEvent
	If xui.SubExists(mCallBack, mEventName & "_TabClick",1) Then
		CallSub2(mCallBack, mEventName & "_TabClick",mCurrentIndex)
	End If
End Sub

Private Sub CreateLabel(EventName As String) As B4XView
	Dim tmp_lbl As Label
	tmp_lbl.Initialize(EventName)
	#If B4A
	tmp_lbl.SingleLine = False
	tmp_lbl.Ellipsize = "END"
	#Else If B4I
	tmp_lbl.Multiline = True
	#End If
	Return tmp_lbl
End Sub

Private Sub CreateImageView(EventName As String) As B4XView
	
	Dim tmp_iv As ImageView
	tmp_iv.Initialize(EventName)
	Return tmp_iv
	
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

Public Sub CreateASFlowTabMenu_Tab (Index As Int, Icon As B4XBitmap, Text As String, TextColor As Int, xFont As B4XFont) As ASFlowTabMenu_Tab
	Dim t1 As ASFlowTabMenu_Tab
	t1.Initialize
	t1.Index = Index
	t1.Icon = Icon
	t1.Text = Text
	t1.TextColor = TextColor
	t1.xFont = xFont
	Return t1
End Sub
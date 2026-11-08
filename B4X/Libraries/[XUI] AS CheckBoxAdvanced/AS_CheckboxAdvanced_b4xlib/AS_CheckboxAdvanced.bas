B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
#if Documentation
Updates
V1.00
	-Release
V1.01
	-The checkbox is now also toggled when you click on the text
V1.02
	-Add Designer Property CheckBox2TextGap - Gap between checkbox and text
		-Default: 10dip
V1.03
	-BugFixes and Improvements
V2.00
	-Add get CheckBoxLabel - The checkbox label
	-Add Designer Property FillUncheckedBackgroundColor
	-Add Designer Property UncheckedBackgroundColor
	-Add Designer Property UncheckedIconColor
	-Add Designer Property Round
		-Default: False
	-Add set Theme
	-Add get Theme_Dark
	-Add get Theme_Light
	-Add Designer Property ThemeChangeTransition
		-Default: None	
#End If

#DesignerProperty: Key: CheckBoxWidthHeight, DisplayName: CheckBoxWidthHeight, FieldType: Int, DefaultValue: 24, MinRange: 0
#DesignerProperty: Key: CheckBox2TextGap, DisplayName: CheckBox2TextGap, FieldType: Int, DefaultValue: 10, MinRange: 0 , Description: Gap between checkbox and text

#DesignerProperty: Key: ThemeChangeTransition, DisplayName: ThemeChangeTransition, FieldType: String, DefaultValue: None, List: None|Fade
#DesignerProperty: Key: CheckedBackgroundColor, DisplayName: CheckedBackgroundColor, FieldType: Color, DefaultValue: 0xFF131416
#DesignerProperty: Key: IconColor, DisplayName: Icon Color, FieldType: Color, DefaultValue: 0xFFFFFFFF
#DesignerProperty: Key: FillUncheckedBackgroundColor, DisplayName: FillUncheckedBackgroundColor, FieldType: Boolean, DefaultValue: False
#DesignerProperty: Key: UncheckedBackgroundColor, DisplayName: UncheckedBackgroundColor, FieldType: Color, DefaultValue: 0xFF131416
#DesignerProperty: Key: UncheckedIconColor, DisplayName: UncheckedIconColor, FieldType: Color, DefaultValue: 0x00FFFFFF
#DesignerProperty: Key: DisabledBackgroundColor, DisplayName: Disabled Background Color, FieldType: Color, DefaultValue: 0xFF3C4043
#DesignerProperty: Key: DisabledIconColor, DisplayName: Disabled Icon Color, FieldType: Color, DefaultValue: 0x98FFFFFF
#DesignerProperty: Key: BorderWidth, DisplayName: Border Width, FieldType: Int, DefaultValue: 2, MinRange: 1
#DesignerProperty: Key: Round, DisplayName: Round, FieldType: Boolean, DefaultValue: False
#DesignerProperty: Key: CornerRadius, DisplayName: Corner Radius, FieldType: Int, DefaultValue: 5, MinRange: 0
#DesignerProperty: Key: CheckedAnimated, DisplayName: Checked Animated, FieldType: Boolean, DefaultValue: False
#DesignerProperty: Key: HapticFeedback, DisplayName: Haptic Feedback, FieldType: Boolean, DefaultValue: True, Description: Whether to make a haptic feedback when the user clicks on the control.
#DesignerProperty: Key: Checked, DisplayName: Checked, FieldType: Boolean, DefaultValue: False
#DesignerProperty: Key: Enabled, DisplayName: Enabled, FieldType: Boolean, DefaultValue: True

#Event: CheckedChange(Checked As Boolean)

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	Private xlbl_CheckBox As B4XView
	Private xlbl_Text As B4XView
	Private xpnl_ClickPanel As B4XView
	
	Private m_Icon As String
	Private m_isFontAswesome As Boolean = False
	Private m_IconColor As Int
	Private m_CheckedBackgroundColor As Int
	Private m_UncheckedBackgroundColor As Int
	Private m_UncheckedIconColor As Int
	Private m_DisabledColor As Int
	Private m_DisabledIconColor As Int
	Private m_isChecked As Boolean = False
	Private m_BorderWidth As Int
	Private m_CornerRadius As Int
	Private m_isCheckedAnimated As Boolean
	Private m_isHaptic As Boolean'Ignore
	Private m_isEvent As Boolean = True
	Private m_isEnabled As Boolean
	Private m_isRound As Boolean
	Private m_isFillUncheckedBackgroundColor As Boolean
	Private m_ThemeChangeTransition As String
	
	Private m_CheckBoxWidthHeight As Float
	Private m_CheckBox2TextGap As Float = 10dip
	Private m_CheckBoxGap As Float = 5dip
	
	Private xiv_RefreshImage As B4XView
	
	Type AS_CheckBoxAdvanced_Theme(TextColor As Int,CheckedBackgroundColor As Int,IconColor As Int,UncheckedBackgroundColor As Int,UncheckedIconColor As Int,DisabledBackgroundColor As Int,DisabledIconColor As Int)
	
End Sub

Public Sub setTheme(Theme As AS_CheckBoxAdvanced_Theme)
	
	xiv_RefreshImage.SetBitmap(mBase.Snapshot)
	xiv_RefreshImage.SetVisibleAnimated(0,True)

	m_CheckedBackgroundColor = Theme.CheckedBackgroundColor
	m_IconColor = Theme.IconColor
	m_UncheckedBackgroundColor = Theme.UncheckedBackgroundColor
	m_UncheckedIconColor = Theme.UncheckedIconColor
	m_DisabledColor = Theme.DisabledBackgroundColor
	m_DisabledIconColor = Theme.DisabledIconColor
	xlbl_Text.TextColor = Theme.TextColor

	
	Sleep(0)
	
	UpdateStyle

	Select m_ThemeChangeTransition
		Case "None"
			xiv_RefreshImage.SetVisibleAnimated(0,False)
		Case "Fade"
			Sleep(250)
			xiv_RefreshImage.SetVisibleAnimated(250,False)
	End Select
	
End Sub

Public Sub getTheme_Dark As AS_CheckBoxAdvanced_Theme
	
	Dim Theme As AS_CheckBoxAdvanced_Theme
	Theme.Initialize
	Theme.CheckedBackgroundColor = xui.Color_White
	Theme.IconColor = xui.Color_Black
	Theme.UncheckedBackgroundColor = xui.Color_White
	Theme.UncheckedIconColor = xui.Color_ARGB(0,255,255,255)
	Theme.DisabledBackgroundColor = xui.Color_ARGB(255,60, 64, 67)
	Theme.DisabledIconColor = xui.Color_ARGB(152,255,255,255)
	Theme.TextColor = xui.Color_White
	
	Return Theme
	
End Sub

Public Sub getTheme_Light As AS_CheckBoxAdvanced_Theme
	
	Dim Theme As AS_CheckBoxAdvanced_Theme
	Theme.Initialize
	Theme.CheckedBackgroundColor = xui.Color_ARGB(255,19, 20, 22)
	Theme.IconColor = xui.Color_White
	Theme.UncheckedBackgroundColor = xui.Color_ARGB(255,19, 20, 22)
	Theme.UncheckedIconColor = xui.Color_ARGB(0,255,255,255)
	Theme.DisabledBackgroundColor = xui.Color_ARGB(255,60, 64, 67)
	Theme.DisabledIconColor = xui.Color_ARGB(152,255,255,255)
	Theme.TextColor = xui.Color_Black
	
	Return Theme
	
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
	ini_props(Props)
	xlbl_CheckBox = CreateLabel("xlbl_CheckBox")
	xlbl_Text = Lbl
	xpnl_ClickPanel = xui.CreatePanel("xpnl_ClickPanel")
	xpnl_ClickPanel.Color = xui.Color_Transparent
	
	mBase.AddView(xlbl_CheckBox,m_CheckBoxGap,0,0,0)
	mBase.AddView(xlbl_Text,m_CheckBoxWidthHeight + m_CheckBox2TextGap + xlbl_CheckBox.Left,0,mBase.Width-m_CheckBoxWidthHeight - m_CheckBox2TextGap - xlbl_CheckBox.Left,mBase.Height)
	mBase.AddView(xpnl_ClickPanel,0,0,mBase.Width,mBase.Height)
	
	xlbl_CheckBox.Enabled = m_isEnabled
	
	m_Icon = Chr(0xE5CA)
	xlbl_CheckBox.Text = m_Icon
	
	xiv_RefreshImage = CreateImageView("")
	xiv_RefreshImage.Visible = False
	mBase.AddView(xiv_RefreshImage,0,0,mBase.Width,mBase.Height)
	
	Base_Resize(mBase.Width,mBase.Height)
	
	Check(False,False)
End Sub

Private Sub ini_props(Props As Map)
	m_isEnabled = Props.GetDefault("Enabled",True)
	m_ThemeChangeTransition = Props.GetDefault("ThemeChangeTransition","None")
	m_CheckedBackgroundColor = xui.PaintOrColorToColor(Props.Get("CheckedBackgroundColor"))
	m_IconColor = xui.PaintOrColorToColor(Props.Get("IconColor"))
	m_DisabledColor = xui.PaintOrColorToColor(Props.Get("DisabledBackgroundColor"))
	m_DisabledIconColor = xui.PaintOrColorToColor(Props.Get("DisabledIconColor"))
	m_BorderWidth = Props.Get("BorderWidth")
	m_CornerRadius = Props.Get("CornerRadius")
	m_isCheckedAnimated = Props.Get("CheckedAnimated")
	m_isHaptic = Props.Get("HapticFeedback")
	m_isChecked = Props.GetDefault("Checked",False)
	m_isFillUncheckedBackgroundColor = Props.GetDefault("FillUncheckedBackgroundColor",False)
	m_UncheckedBackgroundColor = xui.PaintOrColorToColor(Props.GetDefault("UncheckedBackgroundColor",xui.Color_ARGB(255,19, 20, 22)))
	m_UncheckedIconColor = xui.PaintOrColorToColor(Props.GetDefault("UncheckedIconColor",xui.Color_ARGB(0,255,255,255)))
	m_isRound = Props.GetDefault("Round",False)
	
	m_CheckBoxWidthHeight = DipToCurrent(Props.Get("CheckBoxWidthHeight"))
	m_CheckBox2TextGap = DipToCurrent(Props.GetDefault("CheckBox2TextGap",10dip))
	
End Sub

Public Sub Base_Resize (Width As Double, Height As Double)
	xiv_RefreshImage.SetLayoutAnimated(0,0,0,Width,Height)
	xlbl_CheckBox.SetLayoutAnimated(0,m_CheckBoxGap,Height/2 - m_CheckBoxWidthHeight/2,m_CheckBoxWidthHeight,m_CheckBoxWidthHeight)
	xlbl_Text.SetLayoutAnimated(0,m_CheckBoxWidthHeight + m_CheckBox2TextGap + xlbl_CheckBox.Left,0,mBase.Width-m_CheckBoxWidthHeight - m_CheckBox2TextGap - xlbl_CheckBox.Left,mBase.Height)
	xpnl_ClickPanel.SetLayoutAnimated(0,0,0,Width,Height)
	#If B4J
	Dim jo As JavaObject = xlbl_CheckBox
	jo.RunMethod("setMinSize", Array(xlbl_CheckBox.Width/2, xlbl_CheckBox.Height/2))
	jo.RunMethod("setMaxSize", Array(xlbl_CheckBox.Width, xlbl_CheckBox.Height))
	#End If
	UpdateStyle
End Sub

Private Sub UpdateStyle
	Dim BackgroundColor As Int = m_CheckedBackgroundColor
	Dim IconColor As Int = m_IconColor
	If m_isEnabled = False Then
		BackgroundColor = m_DisabledColor
		IconColor = m_DisabledIconColor
	Else If m_isChecked = False Then
		BackgroundColor = m_UncheckedBackgroundColor
		IconColor = m_UncheckedIconColor
	End If
	
	xlbl_CheckBox.SetColorAndBorder(IIf(m_isFillUncheckedBackgroundColor Or m_isChecked,BackgroundColor,xui.Color_Transparent),m_BorderWidth,BackgroundColor,IIf(m_isRound,xlbl_CheckBox.Height/2, m_CornerRadius))
	xlbl_CheckBox.TextColor = IconColor
	
End Sub


Public Sub setChecked(b_checked As Boolean)
	m_isChecked = b_checked
	Check(m_isCheckedAnimated,True)
End Sub

Public Sub getChecked As Boolean
	Return m_isChecked
End Sub

Public Sub Refresh
	Base_Resize(mBase.Width,mBase.Height)
End Sub

Private Sub Check(isAnimated As Boolean,WithEvent As Boolean)
	
	UpdateStyle
	xlbl_CheckBox.SetTextAlignment("CENTER","CENTER")
	xlbl_CheckBox.Font = IIf(m_isFontAswesome = False,xui.CreateMaterialIcons(1),xui.CreateFontAwesome(1))
	Dim size As Float = 2
	For size = 2 To 500
		If CheckSize(size) Then Exit
	Next
	If size > 10 Then size = size - 5
		
	If m_isCheckedAnimated = True And isAnimated = True Then
		xlbl_CheckBox.Font = IIf(m_isFontAswesome = False,xui.CreateMaterialIcons(1),xui.CreateFontAwesome(1))
		
		Jump
		If (m_CornerRadius <> 0 And xui.IsB4i = False) Or m_CornerRadius = 0 Then
			Sleep(250)
		End If
			
			
		xlbl_CheckBox.SetTextSizeAnimated(250,size)
	Else
		xlbl_CheckBox.Font = IIf(m_isFontAswesome = False,xui.CreateMaterialIcons(size),xui.CreateFontAwesome(size))
	End If
	
	If WithEvent = True And m_isEvent = True Then
		CheckedChange
	End If
End Sub

'https://www.b4x.com/android/forum/threads/iamir_viewanimator.100194/#content
Private Sub Jump	
	#If B4I
'	Dim tmp_lbl As Label = xlbl_CheckBox	
'	tmp_lbl.SetLayoutAnimated(250,1,m_CheckBoxWidthHeight/4,mBase.Height/2 - m_CheckBoxWidthHeight/4,m_CheckBoxWidthHeight/2,m_CheckBoxWidthHeight/2)
'	Sleep(250)
'	tmp_lbl.SetLayoutAnimated(250,1,mBase.Height/2 - m_CheckBoxWidthHeight/2,0,m_CheckBoxWidthHeight,m_CheckBoxWidthHeight)
	#Else
	xlbl_CheckBox.SetLayoutAnimated(250,m_CheckBoxGap + m_CheckBoxWidthHeight/4,mBase.Height/2 - m_CheckBoxWidthHeight/4,m_CheckBoxWidthHeight/2,m_CheckBoxWidthHeight/2)
	Sleep(250)
	xlbl_CheckBox.SetLayoutAnimated(250,m_CheckBoxGap,mBase.Height/2 - m_CheckBoxWidthHeight/2,m_CheckBoxWidthHeight,m_CheckBoxWidthHeight)
	#End If
End Sub

#Region Properties

Public Sub setisround(isRound As Boolean)
	m_isRound = isRound
End Sub

Public Sub getisRound As Boolean
	Return m_isRound
End Sub

Public Sub setUncheckedIconColor(UncheckedIconColor As Int)
	m_UncheckedIconColor = UncheckedIconColor
End Sub

Public Sub getUncheckedIconColor As Int
	Return m_UncheckedIconColor
End Sub

Public Sub setUncheckedBackgroundColor(UncheckedBackgroundColor As Int)
	m_UncheckedBackgroundColor = UncheckedBackgroundColor
End Sub

Public Sub getUncheckedBackgroundColor As Int
	Return m_UncheckedBackgroundColor
End Sub

Public Sub setisFillUncheckedBackgroundColor(FillUncheckedBackgroundColor As Boolean)
	m_isFillUncheckedBackgroundColor = FillUncheckedBackgroundColor
End Sub

Public Sub getisFillUncheckedBackgroundColor As Boolean
	Return m_isFillUncheckedBackgroundColor
End Sub

'Call Refresh if you change this value
Public Sub getCheckBoxWidthHeight As Float
	Return m_CheckBoxWidthHeight
End Sub

Public Sub setCheckBoxWidthHeight(WidthHeight As Float)
	m_CheckBoxWidthHeight = WidthHeight
End Sub

Public Sub getText As String
	Return xlbl_Text.Text
End Sub

Public Sub setText(Text As String)
	xlbl_Text.Text = Text
End Sub

Public Sub getTextLabel As B4XView
	Return xlbl_Text
End Sub

Public Sub getCheckBoxLabel As B4XView
	Return xlbl_CheckBox
End Sub

Public Sub SetIcon(icon As String,isfontawesome As Boolean)
	m_Icon = icon
	m_isFontAswesome = isfontawesome
	If m_isChecked = True Then Check(False,False)
End Sub

Public Sub setBorderCornerRadius(radius As Int)
	m_CornerRadius = radius
	UpdateStyle
End Sub

Public Sub setBorderWidth(width As Int)
	m_BorderWidth = width
	UpdateStyle
End Sub

Public Sub getIconColor As Int
	Return m_IconColor
End Sub

Public Sub setIconColor(Color As Int)
	m_IconColor = Color
	UpdateStyle
End Sub

Public Sub setCheckedBackgroundColor(crl As Int)
	m_CheckedBackgroundColor = crl
	UpdateStyle
End Sub

Public Sub setCheckedAnimated(animated As Boolean)
	m_isCheckedAnimated = animated
End Sub

Public Sub setEnabled(enable As Boolean)
	m_isEnabled = enable
	mBase.Enabled = enable
	xlbl_CheckBox.Enabled = enable
	UpdateStyle
End Sub

Public Sub getEnabled As Boolean
	Return m_isEnabled
End Sub

Public Sub getDisabledBackgroundColor As Int
	Return  m_DisabledColor
End Sub

Public Sub setDisabledBackgroundColor(crl As Int)
	m_DisabledColor = crl
	UpdateStyle
End Sub

Public Sub getDisabledIconColor As Int
	Return  m_DisabledIconColor
End Sub

Public Sub setDisabledIconColor(crl As Int)
	m_DisabledIconColor = crl
	UpdateStyle
End Sub

Public Sub getisHaptic As Boolean
	Return m_isHaptic
End Sub

Public Sub setisHaptic(Enabled As Boolean)
	m_isHaptic = Enabled
End Sub

Public Sub getisEvent As Boolean
	Return m_isEvent
End Sub

Public Sub setisEvent(Enabled As Boolean)
	m_isEvent = Enabled
End Sub

Public Sub getisFontAswesome As Boolean
	Return m_isFontAswesome
End Sub

Public Sub setisFontAswesome(FontAwesome As Boolean)
	m_isFontAswesome = FontAwesome
End Sub

#End Region

#If B4J
Private Sub xpnl_ClickPanel_MouseClicked (EventData As MouseEvent)
	If m_isEnabled = False Then Return
	xlbl_CheckBox_MouseClicked(EventData)
End Sub
#Else
Private Sub xpnl_ClickPanel_Click
	If m_isEnabled = False Then Return
	xlbl_CheckBox_Click
End Sub
#End If

#If B4J
Private Sub xlbl_CheckBox_MouseClicked (EventData As MouseEvent)
	If m_isEnabled = False Then Return
	If m_isChecked = True Then
		setChecked(False)
		Else
		setChecked(True)
	End If
End Sub
#Else
Private Sub xlbl_CheckBox_Click
	If m_isEnabled = False Then Return
	If m_isHaptic Then XUIViewsUtils.PerformHapticFeedback(mBase)
	If m_isChecked = True Then
		m_isChecked = False
		Check(m_isCheckedAnimated,True)
	Else
		m_isChecked = True
		Check(m_isCheckedAnimated,True)
	End If
End Sub
#End If

Private Sub CreateLabel(EventName As String) As B4XView
	Dim tmp_lbl As Label : tmp_lbl.Initialize(EventName)
	Return tmp_lbl
End Sub

Private Sub CreateImageView(EventName As String) As B4XView
	Dim iv As ImageView
	iv.Initialize(EventName)
	Return iv
End Sub

'returns true if the size is too large
Private Sub CheckSize(size As Float) As Boolean
	xlbl_CheckBox.TextSize = size
	
		#if b4A
		Dim stuti As StringUtils
		Return MeasureTextWidth(xlbl_CheckBox.Text,xlbl_CheckBox.Font) > xlbl_CheckBox.Width Or stuti.MeasureMultilineTextHeight(xlbl_CheckBox,xlbl_CheckBox.Text) > xlbl_CheckBox.Height		
		#Else		
	Return MeasureTextWidth(xlbl_CheckBox.Text,xlbl_CheckBox.Font) > xlbl_CheckBox.Width Or MeasureTextHeight(xlbl_CheckBox.Text,xlbl_CheckBox.Font) > xlbl_CheckBox.Height
		#End If
		
End Sub

'https://www.b4x.com/android/forum/threads/b4x-xui-add-measuretextwidth-and-measuretextheight-to-b4xcanvas.91865/#content
Private Sub MeasureTextWidth(Text As String, Font1 As B4XFont) As Int
#If B4A
	Private bmp As Bitmap
	bmp.InitializeMutable(1, 1)'ignore
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

'https://www.b4x.com/android/forum/threads/b4x-xui-add-measuretextwidth-and-measuretextheight-to-b4xcanvas.91865/#content
Private Sub MeasureTextHeight(Text As String, Font1 As B4XFont) As Int'Ignore
#If B4A     
	Private bmp As Bitmap
	bmp.InitializeMutable(1, 1)'ignore
	Private cvs As Canvas
	cvs.Initialize2(bmp)
	Return cvs.MeasureStringHeight(Text, Font1.ToNativeFont, Font1.Size)
	
#Else If B4i
    Return Text.MeasureHeight(Font1.ToNativeFont)
#Else If B4J
	Dim jo As JavaObject
	jo.InitializeNewInstance("javafx.scene.text.Text", Array(Text))
	jo.RunMethod("setFont",Array(Font1.ToNativeFont))
	jo.RunMethod("setLineSpacing",Array(0.0))
	jo.RunMethod("setWrappingWidth",Array(0.0))
	Dim Bounds As JavaObject = jo.RunMethod("getLayoutBounds",Null)
	Return Bounds.RunMethod("getHeight",Null)
#End If
End Sub

#Region Events

Private Sub CheckedChange
	If xui.SubExists(mCallBack,mEventName & "_CheckedChange",1) Then
		CallSub2(mCallBack,mEventName & "_CheckedChange",m_isChecked)
	End If
End Sub

#End Region
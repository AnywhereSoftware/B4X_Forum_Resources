B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=12.5
@EndOfDesignText@
#If Documentation
Updates
V1.00
	-Release
#End If

#DesignerProperty: Key: Text, DisplayName: Text, FieldType: String, DefaultValue: Text
#DesignerProperty: Key: Font, DisplayName: Font, FieldType: String, DefaultValue: Default, List: Default|Bold|FontAwesome|Material Icons|Custom Font
#DesignerProperty: Key: CustomFont, DisplayName: Custom Font, FieldType: String, DefaultValue: 
#DesignerProperty: Key: TextHeigth, DisplayName: TextHeigth, FieldType: Int, DefaultValue: 16, MinRange: 0
#DesignerProperty: Key: HorizontalAlignment, DisplayName: Horizontal Alignment, FieldType: String, DefaultValue: Center, List: Left|Center|Right
'#DesignerProperty: Key: VerticalAlignment, DisplayName: Vertical Alignment, FieldType: String, DefaultValue: Center, List: Top|Center|Bottom

#DesignerProperty: Key: Icon, DisplayName: Icon, FieldType: String, DefaultValue: 
#DesignerProperty: Key: IconHeigth, DisplayName: Icon Heigth, FieldType: Int, DefaultValue: 24, MinRange: 0
#DesignerProperty: Key: IconPosition, DisplayName: Icon Position, FieldType: String, DefaultValue: Right Text, List: Left|Left Text|Center Up|Center|Center Down|Right Text|Right
#DesignerProperty: Key: GapIconBorder, DisplayName: Gap Between Icon And Border, FieldType: Int, DefaultValue: 16, MinRange: 0, Description: Gap Between Icon And Border
#DesignerProperty: Key: GapIconText, DisplayName: Gap Between Icon And Text, FieldType: Int, DefaultValue: 16, MinRange: 0, Description: Gap Between Icon And Text

#DesignerProperty: Key: CornerRadius, DisplayName: CornerRadius, FieldType: Int, DefaultValue: 5, MinRange: 0
#DesignerProperty: Key: Shadow, DisplayName: Shadow, FieldType: Int, DefaultValue: 0, MinRange: 0

#DesignerProperty: Key: EnabledTextColor, DisplayName: Enabled Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF
#DesignerProperty: Key: EnabledBackgroundColor, DisplayName: Enabled Background Color, FieldType: Color, DefaultValue: 0xFF007C61
#DesignerProperty: Key: EnabledBorderColor, DisplayName: Enabled Border Color, FieldType: Color, DefaultValue: 0xFF005B47
#DesignerProperty: Key: EnabledBorderWidth, DisplayName: Enabled Border Width, FieldType: Int, DefaultValue: 0, MinRange: 0
#DesignerProperty: Key: EnabledUpdateColorIcon, DisplayName: Update Color Icon Enabled, FieldType: Boolean, DefaultValue: False

#DesignerProperty: Key: DisabledTextColor, DisplayName: Disabled Text Color, FieldType: Color, DefaultValue: 0xFF8E8E8E
#DesignerProperty: Key: DisabledBackgroundColor, DisplayName: Disabled Background Color, FieldType: Color, DefaultValue: 0xFFDBDBDB
#DesignerProperty: Key: DisabledBorderColor, DisplayName: Disabled Border Color, FieldType: Color, DefaultValue: 0xFFC1C1C1
#DesignerProperty: Key: DisabledBorderWidth, DisplayName: Disabled Border Width, FieldType: Int, DefaultValue: 0, MinRange: 0
#DesignerProperty: Key: DisabledUpdateColorIcon, DisplayName: Update Color Icon Disabled, FieldType: Boolean, DefaultValue: False

#DesignerProperty: Key: PressedTextColor, DisplayName: Pressed Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF
#DesignerProperty: Key: PressedBackgroundColor, DisplayName: Pressed Background Color, FieldType: Color, DefaultValue: 0xFF005B47
#DesignerProperty: Key: PressedBorderColor, DisplayName: Pressed Border Color, FieldType: Color, DefaultValue: 0xFF004232
#DesignerProperty: Key: PressedBorderWidth, DisplayName: Pressed Border Width, FieldType: Int, DefaultValue: 0, MinRange: 0
#DesignerProperty: Key: PressedUpdateColorIcon, DisplayName: Update Color Icon Pressed, FieldType: Boolean, DefaultValue: False

#Event: Click
#Event: LongClick

Sub Class_Globals
	Private corLog As Int = xui.Color_RGB( Rnd(100,256) , Rnd(100,256) , Rnd(100,256) )
	
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private mLbl As B4XView 'ignore
	Private xui As XUI 'ignore
	Public Tag As Object
		
	Private downTime As Long
	Private pressionado As Boolean
	Private desabilitado As Boolean
		
	Public xpnl_ButtonBackgroundEnabled As B4XView
	Private xpnl_ButtonBackgroundDisabled As B4XView
	Private xpnl_ButtonBackgroundPressed As B4XView
	Private xpnl_CanvasEnabled As B4XView
	Private xpnl_CanvasDisabled As B4XView
	Private xpnl_CanvasPressed As B4XView
	
	
	Dim m_Text As String
	Dim m_Font As String
	Dim m_CustomFont As String
	Dim m_TextHeigth As Int
	Dim m_HorizontalAlignment As String
	Dim m_VerticalAlignment As String
	
	Dim m_Icon As String
	Dim m_IconHeigth As Int
	Dim m_IconPosition As String
	Dim m_GapIconBorder As Int
	Dim m_GapIconText As Int
	
	Dim m_CornerRadius As Int
	Dim m_Shadow As Int
	
	Dim m_EnabledTextColor As Int
	Dim m_EnabledBackgroundColor As Int
	Dim m_EnabledBorderColor As Int
	Dim m_EnabledBorderWidth As Int
	Dim m_EnabledUpdateColorIcon As Boolean
	
	
	
	Dim m_DisabledTextColor As Int
	Dim m_DisabledBackgroundColor As Int
	Dim m_DisabledBorderColor As Int
	Dim m_DisabledBorderWidth As Int
	Dim m_DisabledUpdateColorIcon As Boolean
	
	Dim m_PressedTextColor As Int
	Dim m_PressedBackgroundColor As Int
	Dim m_PressedBorderColor As Int
	Dim m_PressedBorderWidth As Int
	Dim m_PressedUpdateColorIcon As Boolean
	
	
	Dim m_B4XBitmapIcon As B4XBitmap
	Dim m_B4XBitmapBlack As B4XBitmap
	Dim m_B4XBitmapColorEnabled As B4XBitmap
	Dim m_B4XBitmapColorDisabled As B4XBitmap
	Dim m_B4XBitmapColorPressed As B4XBitmap
	Dim m_BitmapCreatorEffects As BitmapCreatorEffects
	Dim m_B4XFont As B4XFont
	Dim m_CanvasEnabled As B4XCanvas
	Dim m_CanvasDisabled As B4XCanvas
	Dim m_CanvasPressed As B4XCanvas
	
	Dim n As Long
	
	Dim Timer1 As Timer
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	n = DateTime.Now
	
	LogColor("DesignerCreateView: " & (DateTime.Now - n) & "ms", corLog)
	
	mLbl = Lbl
	mBase = Base
	Tag = mBase.Tag
	mBase.Tag = Me
	
	mBase.Color = xui.Color_Transparent
	
	
	m_Text = Props.Get("Text")
	m_Font = Props.Get("Font")
	m_CustomFont = Props.Get("CustomFont")
	m_TextHeigth = Props.Get("TextHeigth")
	m_HorizontalAlignment = Props.Get("HorizontalAlignment")
	m_VerticalAlignment = Props.Get("VerticalAlignment")
	
	m_Icon = Props.Get("Icon")
	m_IconHeigth = DipToCurrent(Props.Get("IconHeigth"))
	m_IconPosition = Props.Get("IconPosition")
	m_GapIconBorder = DipToCurrent(Props.Get("GapIconBorder"))
	m_GapIconText = DipToCurrent(Props.Get("GapIconText"))
	
	m_CornerRadius = DipToCurrent(Props.Get("CornerRadius"))
	m_Shadow = DipToCurrent(Props.Get("Shadow"))
	
	m_EnabledTextColor = xui.PaintOrColorToColor(Props.Get("EnabledTextColor"))
	m_EnabledBackgroundColor = xui.PaintOrColorToColor(Props.Get("EnabledBackgroundColor"))
	m_EnabledBorderColor = xui.PaintOrColorToColor(Props.Get("EnabledBorderColor"))
	m_EnabledBorderWidth = DipToCurrent(Props.Get("EnabledBorderWidth"))
	m_EnabledUpdateColorIcon = Props.Get("EnabledUpdateColorIcon")
	
	m_DisabledTextColor = xui.PaintOrColorToColor(Props.Get("DisabledTextColor"))
	m_DisabledBackgroundColor = xui.PaintOrColorToColor(Props.Get("DisabledBackgroundColor"))
	m_DisabledBorderColor = xui.PaintOrColorToColor(Props.Get("DisabledBorderColor"))
	m_DisabledBorderWidth = DipToCurrent(Props.Get("DisabledBorderWidth"))
	m_DisabledUpdateColorIcon = Props.Get("DisabledUpdateColorIcon")
	
	m_PressedTextColor = xui.PaintOrColorToColor(Props.Get("PressedTextColor"))
	m_PressedBackgroundColor = xui.PaintOrColorToColor(Props.Get("PressedBackgroundColor"))
	m_PressedBorderColor = xui.PaintOrColorToColor(Props.Get("PressedBorderColor"))
	m_PressedBorderWidth = DipToCurrent(Props.Get("PressedBorderWidth"))
	m_PressedUpdateColorIcon = Props.Get("PressedUpdateColorIcon")
	
	
	mBase.SetColorAndBorder(mBase.Parent.Color,0,0,m_CornerRadius)
	
	LogColor("carregou_propriedades: " & (DateTime.Now - n) & "ms", corLog)
	
	If m_Font.ToUpperCase="BOLD" Then
		m_B4XFont = xui.CreateDefaultBoldFont(m_TextHeigth)
	Else If m_Font.ToUpperCase="FONTAWESOME" Then
		m_B4XFont = xui.CreateFontAwesome(m_TextHeigth)
	Else If m_Font.ToUpperCase="MATERIAL ICONS" Then
		m_B4XFont = xui.CreateMaterialIcons(m_TextHeigth)
	Else If m_Font.ToUpperCase="CUSTOM FONT" Then
		m_B4XFont = CreateB4XFont(m_CustomFont, m_TextHeigth)
	Else
		m_B4XFont = xui.CreateDefaultFont(m_TextHeigth)
	End If
	
	LogColor("carregou_fonte: " & (DateTime.Now - n) & "ms", corLog)
	
	Try
		If m_Icon<>"" Then
			Dim diretorio As String = File.DirAssets
			
			#if b4j 
			If Not(File.Exists(File.DirTemp, m_Icon)) Then
				File.Copy(File.DirAssets, m_Icon, File.DirTemp, m_Icon)
				diretorio = File.DirTemp
			End If
			#Else
			If File.Exists(xui.DefaultFolder, m_Icon) Then 
				diretorio = xui.DefaultFolder
			End If
			#End If
			
			m_B4XBitmapIcon = xui.LoadBitmap(diretorio, m_Icon)
			m_BitmapCreatorEffects.Initialize
			
			
		End If
	Catch
		Log(LastException)
	End Try
	
	
	
	
	
	
	
	LogColor("carregou_icone: " & (DateTime.Now - n) & "ms", corLog)
	
	xpnl_ButtonBackgroundEnabled = xui.CreatePanel("xpnl_ButtonBackground")
	xpnl_ButtonBackgroundDisabled = xui.CreatePanel("xpnl_ButtonBackground")
	xpnl_ButtonBackgroundPressed = xui.CreatePanel("xpnl_ButtonBackground")
	mBase.AddView(xpnl_ButtonBackgroundEnabled,0,0,mBase.Width,mBase.Height)
	mBase.AddView(xpnl_ButtonBackgroundDisabled,0,0,mBase.Width,mBase.Height)
	mBase.AddView(xpnl_ButtonBackgroundPressed,0,0,mBase.Width,mBase.Height)
	xpnl_CanvasEnabled = xui.CreatePanel("xpnl_CanvasEnabled")
	xpnl_CanvasDisabled = xui.CreatePanel("xpnl_CanvasDisabled")
	xpnl_CanvasPressed = xui.CreatePanel("xpnl_CanvasPressed")
	xpnl_ButtonBackgroundEnabled.AddView(xpnl_CanvasEnabled,0,0,mBase.Width,mBase.Height)
	xpnl_ButtonBackgroundDisabled.AddView(xpnl_CanvasDisabled,0,0,mBase.Width,mBase.Height)
	xpnl_ButtonBackgroundPressed.AddView(xpnl_CanvasPressed,0,0,mBase.Width,mBase.Height)
	m_CanvasEnabled.Initialize(xpnl_CanvasEnabled)
	m_CanvasDisabled.Initialize(xpnl_CanvasDisabled)
	m_CanvasPressed.Initialize(xpnl_CanvasPressed)
	
	
	LogColor("adicionou os campos no layout: " & (DateTime.Now - n) & "ms", corLog)
	
	
	#If B4A
	Base_Resize(mBase.Width,mBase.Height)
	#End If
	
	
	
End Sub


Sub Timer1_Tick
	'Handle tick events
	
	'DrawIconAndText(m_CanvasEnabled, m_B4XBitmapColorEnabled, xpnl_ButtonBackgroundEnabled, xui.Color_Blue, m_EnabledBorderWidth, m_EnabledBorderColor, m_EnabledTextColor, m_EnabledUpdateColorIcon, "enabled")
	'LogColor("desenhou enabled: " & (DateTime.Now - n) & "ms", corLog)
	
	DrawIconAndText(m_CanvasDisabled, m_B4XBitmapColorDisabled, xpnl_ButtonBackgroundDisabled, m_DisabledBackgroundColor, m_DisabledBorderWidth, m_DisabledBorderColor, m_DisabledTextColor, m_DisabledUpdateColorIcon, "disabled")
	LogColor("desenhou disabled: " & (DateTime.Now - n) & "ms", corLog)
	
	DrawIconAndText(m_CanvasPressed, m_B4XBitmapColorPressed, xpnl_ButtonBackgroundPressed, m_PressedBackgroundColor, m_PressedBorderWidth, m_PressedBorderColor, m_PressedTextColor, m_PressedUpdateColorIcon, "pressed")
	LogColor("desenhou pressed: " & (DateTime.Now - n) & "ms", corLog)
	
	Timer1.Enabled = False
End Sub


Public Sub Refresh
	
	DrawIconAndText(m_CanvasEnabled, m_B4XBitmapColorEnabled, xpnl_ButtonBackgroundEnabled, m_EnabledBackgroundColor, m_EnabledBorderWidth, m_EnabledBorderColor, m_EnabledTextColor, m_EnabledUpdateColorIcon, "enabled")
	LogColor("desenhou enabled: " & (DateTime.Now - n) & "ms", corLog)
	
	Style
	LogColor("aplicou o estilo: " & (DateTime.Now - n) & "ms", corLog)
	
	'DrawIconAndText(m_CanvasDisabled, m_B4XBitmapColorDisabled, xpnl_ButtonBackgroundDisabled, m_DisabledBackgroundColor, m_DisabledBorderWidth, m_DisabledBorderColor, m_DisabledTextColor, m_DisabledUpdateColorIcon, "disabled")
	'LogColor("desenhou disabled: " & (DateTime.Now - n) & "ms", corLog)
	
	'DrawIconAndText(m_CanvasPressed, m_B4XBitmapColorPressed, xpnl_ButtonBackgroundPressed, m_PressedBackgroundColor, m_PressedBorderWidth, m_PressedBorderColor, m_PressedTextColor, m_PressedUpdateColorIcon, "pressed")
	'LogColor("desenhou pressed: " & (DateTime.Now - n) & "ms", corLog)
	
	If Not(Timer1.IsInitialized) Then
		Timer1.Initialize("Timer1", 1000)
		Timer1.Enabled = False
	End If
	
	If m_Icon="" Then 	
		Timer1.Interval = 50
	End If
	
	Timer1.Enabled = True
	
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	LogColor("Base_Resize: " & (DateTime.Now - n) & "ms", corLog)
	
	xpnl_ButtonBackgroundEnabled.SetLayoutAnimated(0, 0, 0, Width, Height)
	xpnl_ButtonBackgroundDisabled.SetLayoutAnimated(0, 0, 0, Width, Height)
	xpnl_ButtonBackgroundPressed.SetLayoutAnimated(0, 0, 0, Width, Height)
	xpnl_CanvasEnabled.SetLayoutAnimated(0, 0, 0, Width, Height)
	xpnl_CanvasDisabled.SetLayoutAnimated(0, 0, 0, Width, Height)
	xpnl_CanvasPressed.SetLayoutAnimated(0, 0, 0, Width, Height)
	m_CanvasEnabled.Resize(xpnl_CanvasEnabled.Width, xpnl_CanvasEnabled.Height)
	m_CanvasDisabled.Resize(xpnl_CanvasDisabled.Width, xpnl_CanvasDisabled.Height)
	m_CanvasPressed.Resize(xpnl_CanvasPressed.Width, xpnl_CanvasPressed.Height)
	m_CanvasEnabled.ClearRect(m_CanvasEnabled.TargetRect)
	m_CanvasDisabled.ClearRect(m_CanvasDisabled.TargetRect)
	m_CanvasPressed.ClearRect(m_CanvasPressed.TargetRect)
	m_CanvasEnabled.Invalidate
	m_CanvasDisabled.Invalidate
	m_CanvasPressed.Invalidate
	
	LogColor("reajustou o tamanho: " & (DateTime.Now - n) & "ms", corLog)
	
	SetShadow2(mBase, m_Shadow, 0x64000000)
	
	LogColor("colocou borda: " & (DateTime.Now - n) & "ms", corLog)
	
	Refresh
End Sub



Sub DrawIconAndText(m_Canvas As B4XCanvas, B4XBitmapColor As B4XBitmap, xpnl_ButtonBackground As B4XView, BackgroundColor As Int, BorderWidth As Int, BorderColor As Int, TextColor As Int, UpdateColorIcon As Boolean, campo As String) As ResumableSub
	xpnl_ButtonBackground.SetColorAndBorder(BackgroundColor, BorderWidth, BorderColor, m_CornerRadius)
	
	Dim hasIcon As Boolean = False
	
	m_Canvas.ClearRect(m_Canvas.TargetRect)
	m_Canvas.Invalidate
	
	Dim CenterY As Int = m_Canvas.TargetRect.CenterY
	Dim CenterYText As Int = CenterY
	Dim CenterYIcon As Int = CenterY
	Dim CenterX As Int = m_Canvas.TargetRect.CenterX
	
	Dim rectText As B4XRect = m_Canvas.MeasureText(m_Text, m_B4XFont)
	Dim TextHeight As Float = rectText.Height
	Dim TextWidth As Float = rectText.Width
	
	Dim rectIcon As B4XRect
	rectIcon.Initialize(0, 0, 0, 0)
	
	Try
		If UpdateColorIcon Then
			If Not(m_BitmapCreatorEffects.IsInitialized) Then
				m_BitmapCreatorEffects.Initialize
			End If
			
			If Not(m_B4XBitmapBlack.IsInitialized) Then 
				m_B4XBitmapBlack = m_BitmapCreatorEffects.Brightness(m_B4XBitmapIcon, 0)
			End If	
			
			If m_B4XBitmapBlack.IsInitialized Then
				'If campo="enabled" Then				'	
				'End If
				'se a cor é igual, e o icone esta populado
				If campo="disabled" And m_DisabledTextColor=m_EnabledBorderColor And m_B4XBitmapColorEnabled.IsInitialized Then		
					LogColor("disabled = enabled", corLog)
					B4XBitmapColor = m_B4XBitmapColorEnabled					
				Else If campo="pressed" And m_PressedTextColor=m_EnabledBorderColor And m_B4XBitmapColorEnabled.IsInitialized Then
					LogColor("pressed = enabled", corLog)
					B4XBitmapColor = m_B4XBitmapColorEnabled
				Else
					B4XBitmapColor = m_BitmapCreatorEffects.ReplaceColor(m_B4XBitmapBlack, xui.Color_Black, TextColor, True)
				End If
				
				hasIcon = True
			End If
		Else
			If m_B4XBitmapIcon.IsInitialized Then
				B4XBitmapColor = m_B4XBitmapIcon
				hasIcon = True
			End If
		End If
	Catch
		Log(LastException)
	End Try
	
	
	If hasIcon And m_IconPosition.ToUpperCase.Contains("UP") Then
		CenterYIcon = CenterY - (m_GapIconText/2) - (m_IconHeigth/2)
		CenterYText = CenterY + (m_GapIconText/2) + (TextHeight/2)		
	Else If hasIcon And m_IconPosition.ToUpperCase.Contains("DOWN") Then
		CenterYIcon = CenterY + (m_GapIconText/2) + (m_IconHeigth/2)
		CenterYText = CenterY - (m_GapIconText/2) - (TextHeight/2)
	End If
	
	
	'Dim baseline As Double = (CenterY - rectText.Height / 2 - rectText.Top)
	Dim baseline As Double = (CenterYText - rectText.Height / 2 - rectText.Top)
	
	
	
	
	If m_HorizontalAlignment.ToUpperCase.Contains("LEFT") Then
		If hasIcon And m_IconPosition.ToUpperCase.Contains("LEFT") Then
			CenterX = m_GapIconBorder + m_IconHeigth + m_GapIconText + (TextWidth/2)
		Else
			CenterX = m_GapIconBorder + (TextWidth/2)
		End If
	End If
	
	
	If m_HorizontalAlignment.ToUpperCase.Contains("RIGHT") Then
		If hasIcon And m_IconPosition.ToUpperCase.Contains("RIGHT") Then
			CenterX = m_Canvas.TargetRect.Width - m_GapIconBorder - m_IconHeigth - m_GapIconText - (TextWidth/2) 'm_GapIconBorder + m_IconHeigth + m_GapIconText + (TextWidth/2)
		Else
			CenterX = m_Canvas.TargetRect.Width - m_GapIconBorder - (TextWidth/2)
		End If
	End If
	
	
	If m_HorizontalAlignment.ToUpperCase.Contains("CENTER") Then
		If hasIcon And m_IconPosition.ToUpperCase.Contains("LEFT TEXT") Then
			CenterX = CenterX + (getGapIconText/2) + (m_IconHeigth/2)
		Else If hasIcon And m_IconPosition.ToUpperCase.Contains("RIGHT TEXT") Then
			CenterX = CenterX - (getGapIconText/2) - (m_IconHeigth/2)
		End If
	End If
	
	
	m_Canvas.DrawText(m_Text, CenterX, baseline, m_B4XFont, TextColor, "CENTER")
	m_Canvas.Invalidate
	
	'Enabled Disabled Pressed
	
	If hasIcon Then
		Dim left As Float = 0
		'Left|Left Text|Center|Right Text|Right
		If m_IconPosition.ToUpperCase="LEFT" Then
			left = m_GapIconBorder
		else If m_IconPosition.ToUpperCase="LEFT TEXT" Then
			left = (CenterX - (TextWidth/2) - m_GapIconText - m_IconHeigth)
		else If m_IconPosition.ToUpperCase.Contains("CENTER") Then
			left = (m_Canvas.TargetRect.CenterX - (m_IconHeigth/2))
		else If m_IconPosition.ToUpperCase="RIGHT TEXT" Then
			left = (CenterX + (TextWidth/2) + m_GapIconText)
		else If m_IconPosition.ToUpperCase="RIGHT" Then
			left = (m_Canvas.TargetRect.Width - m_GapIconBorder - m_IconHeigth)
		End If
		
		Dim top As Float = (CenterYIcon - (m_IconHeigth/2))
		Dim right As Float = (left + m_IconHeigth)
		Dim botton As Float = (top + m_IconHeigth)
		
		Dim rectIcon As B4XRect
		rectIcon.Initialize(left, top, right, botton)
				
		m_Canvas.DrawBitmap(B4XBitmapColor, rectIcon)
	End If
	
	m_Canvas.Invalidate
	
	Return True
End Sub

Private Sub xpnl_ButtonBackground_Touch (Action As Int, X As Float, Y As Float)
	
	If Not(desabilitado) Then
		'Log(Action)
		'Log(mBase.TOUCH_ACTION_UP) '1 ' soltou
		'Log(mBase.TOUCH_ACTION_DOWN) '0 ' apertou
		'Log(mBase.TOUCH_ACTION_MOVE) '2 'arrastou
		'Log(mBase.TOUCH_ACTION_MOVE_NOTOUCH) '100
	
		If Action = mBase.TOUCH_ACTION_DOWN Then
			pressionado = True
			downTime = DateTime.Now
			Style
			
		Else if Action = mBase.TOUCH_ACTION_UP Then
			
			If pressionado = True Then
				pressionado = False
				Style
			End If
			
			'#if release 
			'If (DateTime.Now - downTime) > 250 Then
			'#else
			If (DateTime.Now - downTime) > 500 Then
			'#End If
				If xui.SubExists(mCallBack, mEventName & "_LongClick", 0) Then
					CallSub(mCallBack, mEventName & "_LongClick")
				End If
			Else
				If xui.SubExists(mCallBack, mEventName & "_Click", 0) Then
					CallSub(mCallBack, mEventName & "_Click")
				End If
			End If
			
			
		End If
	End If
End Sub





Private Sub Style
	'Log($"Style  pressionado:${pressionado}  formartarEstilo:${formartarEstilo}  desabilitado:${desabilitado}"$)
	xpnl_ButtonBackgroundEnabled.Visible = False
	xpnl_ButtonBackgroundDisabled.Visible = False
	xpnl_ButtonBackgroundPressed.Visible = False
	If pressionado Then
		xpnl_ButtonBackgroundPressed.Visible = True
	Else if desabilitado Then
		xpnl_ButtonBackgroundDisabled.Visible = True
	Else
		xpnl_ButtonBackgroundEnabled.Visible = True
	End If
End Sub


#Region Properties
Public Sub setEnabled(Enabled1 As Boolean)
	desabilitado = Not(Enabled1)
	Style
End Sub
Public Sub getEnabled As Boolean
	Return Not(desabilitado)
End Sub

Public Sub setText(Text1 As String)
	m_Text = Text1
	Style
End Sub
Public Sub getText As String
	Return m_Text
End Sub

Public Sub setFont(Font1 As B4XFont)
	m_B4XFont = Font1
	'Style
End Sub
Public Sub getFont As B4XFont
	Return m_B4XFont
End Sub

Public Sub setTextHeigth(TextHeigth1 As Int)
	m_TextHeigth = TextHeigth1
	'Style
End Sub
Public Sub getTextHeigth As Int
	Return m_TextHeigth
End Sub

'Left|Center|Right
Public Sub setHorizontalAlignment(HorizontalAlignment1 As String)
	m_HorizontalAlignment = HorizontalAlignment1
	'Style
End Sub
Public Sub getHorizontalAlignment As String
	Return m_HorizontalAlignment
End Sub

' Top|Center|Bottom
Public Sub setVerticalAlignment(VerticalAlignment1 As String)
	m_VerticalAlignment = VerticalAlignment1
	'Style
End Sub
Public Sub getVerticalAlignment As String
	Return m_VerticalAlignment
End Sub

Public Sub setIcon(Icon1 As B4XBitmap)
	m_B4XBitmapIcon = Icon1
	'Style
End Sub
Public Sub getIcon As B4XBitmap
	Return m_B4XBitmapIcon
End Sub

Public Sub setIconHeigth(IconHeigth1 As Int)
	m_IconHeigth = IconHeigth1
	'Style
End Sub
Public Sub getIconHeigth As Int
	Return m_IconHeigth
End Sub

'Left|Left Text|Center Up|Center|Center Down|Right Text|Right
Public Sub setIconPosition(IconPosition1 As String)
	m_IconPosition = IconPosition1
	'Style
End Sub
Public Sub getIconPosition As String
	Return m_IconPosition
End Sub

Public Sub setGapIconBorder(GapIconBorder1 As Int)
	m_GapIconBorder = GapIconBorder1
	'Style
End Sub
Public Sub getGapIconBorder As Int
	Return m_GapIconBorder
End Sub

Public Sub setGapIconText(GapIconText1 As Int)
	m_GapIconText = GapIconText1
	'Style
End Sub
Public Sub getGapIconText As Int
	Return m_GapIconText
End Sub

Public Sub setCornerRadius(CornerRadius1 As Int)
	m_CornerRadius = CornerRadius1
	'Style
End Sub
Public Sub getCornerRadius As Int
	Return m_CornerRadius
End Sub

Public Sub setShadow(Shadow1 As Int)
	m_Shadow = Shadow1
	'Style
End Sub
Public Sub getShadow As Int
	Return m_Shadow
End Sub


Public Sub setEnabledTextColor(EnabledTextColor1 As Int)
	m_EnabledTextColor = EnabledTextColor1
	'Style
End Sub
Public Sub getEnabledTextColor As Int
	Return m_EnabledTextColor
End Sub

Public Sub setEnabledBackgroundColor(EnabledBackgroundColor1 As Int)
	m_EnabledBackgroundColor = EnabledBackgroundColor1
	'Style
End Sub
Public Sub getEnabledBackgroundColor As Int
	Return m_EnabledBackgroundColor
End Sub

Public Sub setEnabledBorderColor(EnabledBorderColor1 As Int)
	m_EnabledBorderColor = EnabledBorderColor1
	'Style
End Sub
Public Sub getEnabledBorderColor As Int
	Return m_EnabledBorderColor
End Sub

Public Sub setEnabledBorderWidth(EnabledBorderWidth1 As Int)
	m_EnabledBorderWidth = EnabledBorderWidth1
	'Style
End Sub
Public Sub getEnabledBorderWidth As Int
	Return m_EnabledBorderWidth
End Sub


Public Sub setDisabledTextColor(DisabledTextColor1 As Int)
	m_DisabledTextColor = DisabledTextColor1
	'Style
End Sub
Public Sub getDisabledTextColor As Int
	Return m_DisabledTextColor
End Sub

Public Sub setDisabledBackgroundColor(DisabledBackgroundColor1 As Int)
	m_DisabledBackgroundColor = DisabledBackgroundColor1
	'Style
End Sub
Public Sub getDisabledBackgroundColor As Int
	Return m_DisabledBackgroundColor
End Sub

Public Sub setDisabledBorderColor(DisabledBorderColor1 As Int)
	m_DisabledBorderColor = DisabledBorderColor1
	'Style
End Sub
Public Sub getDisabledBorderColor As Int
	Return m_DisabledBorderColor
End Sub

Public Sub setDisabledBorderWidth(DisabledBorderWidth1 As Int)
	m_DisabledBorderWidth = DisabledBorderWidth1
	'Style
End Sub
Public Sub getDisabledBorderWidth As Int
	Return m_DisabledBorderWidth
End Sub


Public Sub setPressedTextColor(PressedTextColor1 As Int)
	m_PressedTextColor = PressedTextColor1
	'Style
End Sub
Public Sub getPressedTextColor As Int
	Return m_PressedTextColor
End Sub

Public Sub setPressedBackgroundColor(PressedBackgroundColor1 As Int)
	m_PressedBackgroundColor = PressedBackgroundColor1
	'Style
End Sub
Public Sub getPressedBackgroundColor As Int
	Return m_PressedBackgroundColor
End Sub

Public Sub setPressedBorderColor(PressedBorderColor1 As Int)
	m_PressedBorderColor = PressedBorderColor1
	'Style
End Sub
Public Sub getPressedBorderColor As Int
	Return m_PressedBorderColor
End Sub

Public Sub setPressedBorderWidth(PressedBorderWidth1 As Int)
	m_PressedBorderWidth = PressedBorderWidth1
	'Style
End Sub
Public Sub getPressedBorderWidth As Int
	Return m_PressedBorderWidth
End Sub

#End Region




#Region Functions
'https://www.b4x.com/android/forum/threads/b4x-xui-elevation-shadow.135767/#content
Private Sub SetShadow2 (View As B4XView, Offset As Double, Color As Int)
	If Offset>0 Then		
 	#if B4J
		Dim DropShadow As JavaObject
		'You might prefer to ignore panels as the shadow is different.
		'If View Is Pane Then Return
		'DropShadow.InitializeNewInstance(IIf(View Is Pane, "javafx.scene.effect.InnerShadow", "javafx.scene.effect.DropShadow"), Null)
		DropShadow.InitializeNewInstance("javafx.scene.effect.DropShadow", Null)
		DropShadow.RunMethod("setOffsetX", Array(Offset))
		DropShadow.RunMethod("setOffsetY", Array(Offset))
		DropShadow.RunMethod("setRadius", Array(Offset))
		Dim fx As JFX
		DropShadow.RunMethod("setColor", Array(fx.Colors.From32Bit(Color)))
		View.As(JavaObject).RunMethod("setEffect", Array(DropShadow))
    #Else If B4A
    'Offset = Offset * 2
   ' View.As(JavaObject).RunMethod("setElevation", Array(Offset.As(Float)))
	mBase.As(Panel).Elevation = DipToCurrent(Offset)
    #Else If B4i
    View.As(View).SetShadow(Color, Offset, Offset, 0.5, False)
    #End If
	End If
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

'https://www.b4x.com/android/forum/threads/b4x-createb4xfont.138325/#content
Public Sub CreateB4XFont(FontFileName As String, FontSize As Float) As B4XFont
    #IF B4A
        Return xui.CreateFont(Typeface.LoadFromAssets(FontFileName), FontSize)
    #ELSE IF B4I
	
		FontFileName = FontFileName.Replace(".ttf","").Replace(".otf","")
		
		Dim existFont As Boolean = False
		
		For Each fontename As String In Font.AvailableNames
			If fontename = FontFileName Then 
				existFont = True
				Exit
			End If
		Next
		
		If existFont Then
		Return xui.CreateFont(Font.CreateNew2(FontFileName, FontSize), FontSize)
		Else
			Log($"not found FontFileName: ${FontFileName}"$)
		Return xui.CreateDefaultFont(FontSize)
		End If 
		
    #ELSE ' B4J
	Dim FX As JFX
	Return xui.CreateFont(FX.LoadFont(File.DirAssets, FontFileName, FontSize), FontSize)
    #END IF
End Sub


'
''https://www.b4x.com/android/forum/threads/b4x-CreateB4XFont.138325/#content
'Public Sub CreateB4XFont(FontFileName As String, FontSize As Float, NativeFontSize As Float) As B4XFont
'    #IF B4A
'        Return xui.CreateFont(Typeface.LoadFromAssets(FontFileName), FontSize)
'    #ELSE IF B4I
'        Return xui.CreateFont(Font.CreateNew2(FontFileName, NativeFontSize), FontSize)
'    #ELSE ' B4J
'	Dim FX As JFX
'	Return xui.CreateFont(FX.LoadFont(File.DirAssets, FontFileName, NativeFontSize), FontSize)
'    #END IF
'End Sub
#End Region








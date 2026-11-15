B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
Sub Class_Globals
	Private xui As XUI
	Private m_DynamicToast As AS_DynamicToast
	Public Data As Map
	Public Panel As B4XView
	Public Closing As Boolean
	Public Revision As Long
	Public MeasuredHeight As Float

	'Content container and offscreen text measurement.
	Private xpnl_Body As B4XView
	Private xCanvas As B4XCanvas
	Private xpnl_Measure As B4XView

	'Targets and current state of the stack animation.
	Private m_Width As Float
	Private m_TargetY As Double
	Private m_CurrentY As Double
	Private m_VelocityY As Double
	Private m_TargetScale As Double = 1
	Private m_CurrentScale As Double = 1
	Private m_VelocityScale As Double
	Private m_TargetOpacity As Double = 1
	Private m_Opacity As Double = 1

	'Entry, exit and remaining lifetime.
	Private m_Presence As Double
	Private m_PresenceVelocity As Double
	Private m_ContentFade As Double = 1
	Private m_RemainingDuration As Double
	Private m_Duration As Double
	Private m_CloseTime As Double
	Private m_ClosePresence As Double
	Private m_ExitX As Double
	Private m_ExitY As Double

	'Offsets, anchors and state of the current swipe gesture.
	Private m_DragX As Double
	Private m_DragY As Double
	Private m_DragVelocityX As Double
	Private m_DragVelocityY As Double
	Private m_AnchorX As Double
	Private m_AnchorY As Double
	Private m_IsBottom As Boolean
	Private m_LayoutReady As Boolean
	Private m_Dragging As Boolean
	Private m_TouchStartX As Double
	Private m_TouchStartY As Double
	Private m_LastTouchX As Double
	Private m_LastTouchY As Double
	Private m_SwipeAxis As Int
	Private m_TouchStartTime As Long
	Private m_LastTouchTime As Long
	Private m_TouchMoved As Boolean
	Private m_ReturnDrag As Boolean
	Private m_Detached As Boolean

	'Resolved content and separately tracked text views.
	Private m_Title As Object
	Private m_Description As Object
	Private m_CustomContent As Object
	Private lst_TextViews As List
End Sub

#Region Initialization

Public Sub Initialize(Host As AS_DynamicToast,Parent As B4XView,Options As Map)

	m_DynamicToast = Host
	Panel = xui.CreatePanel("xpnl_Toast")
	Parent.AddView(Panel,0,0,1dip,1dip)
	Panel.Visible = False

	'Prepare an offscreen canvas for text measurement.
	xpnl_Measure = xui.CreatePanel("")
	xpnl_Measure.SetLayoutAnimated(0,0,0,1dip,1dip)
	xCanvas.Initialize(xpnl_Measure)
	xpnl_Body = xui.CreatePanel("")
	Panel.AddView(xpnl_Body,0,0,1dip,1dip)
	Update(Options)

End Sub

Public Sub Update(Options As Map)

	Dim DurationValue As Double = Options.GetDefault("duration",m_DynamicToast.ConfigValue("duration"))

	'Reset the remaining lifetime only when the duration changes or the card is shown again.
	If Revision = 0 Or Closing Or DurationValue <> m_Duration Then m_RemainingDuration = DurationValue
	m_Duration = DurationValue
	Revision = Revision + 1
	Data = m_DynamicToast.CopyMap(Options)
	Closing = False
	m_CloseTime = 0

	'Resolve content callbacks once per update before building the views.
	m_Title = m_DynamicToast.ResolveContent(Data.GetDefault("title",Null))
	m_Description = m_DynamicToast.ResolveContent(Data.GetDefault("description",Null))
	m_CustomContent = Data.GetDefault("custom",Null)

	If m_LayoutReady Then m_ContentFade = 0
	Build

End Sub

#End Region

#Region Layout

Public Sub Build

	If m_Width < 1 Then Return

	lst_TextViews.Initialize
	Dim DurationValue As Double = Data.GetDefault("duration",m_DynamicToast.ConfigValue("duration"))

	If DurationValue <> m_Duration Then
		m_Duration = DurationValue
		m_RemainingDuration = m_Duration
	End If

	xpnl_Body.RemoveAllViews

	'Read padding, colors and corner radius from the global toast style.
	Dim Properties As Map = m_DynamicToast.ToastStyle
	Dim PaddingHorizontal As Float = Properties.GetDefault("paddingHorizontal",16dip)
	Dim PaddingVertical As Float = Properties.GetDefault("paddingVertical",14dip)
	Dim Gap As Float = Properties.GetDefault("gap",12dip)
	Panel.SetColorAndBorder( _
		Properties.GetDefault("backgroundColor",0xFF1A1A1C), _
		Properties.GetDefault("borderWidth",0.5dip), _
		Properties.GetDefault("borderColor",0x14FFFFFF), _
		Properties.GetDefault("borderRadius",18dip))

	'Apply shadows and elevation using native platform APIs.
	#If B4A
	Dim pnl_Toast As Panel = Panel
	pnl_Toast.Elevation = Properties.GetDefault("elevation",10dip)
	#Else If B4J
	Dim jo As JavaObject = Panel
	Dim jo_Shadow As JavaObject
	jo_Shadow.InitializeNewInstance("javafx.scene.effect.DropShadow",Null)
	jo_Shadow.RunMethod("setRadius",Array(20.0))
	jo_Shadow.RunMethod("setOffsetY",Array(10.0))
	Dim fx As JFX
	jo_Shadow.RunMethod("setColor",Array(fx.Colors.ARGB(115,0,0,0)))
	jo.RunMethod("setEffect",Array(jo_Shadow))
	#Else If B4i
	Dim no As NativeObject = Panel
	Dim no_Layer As NativeObject = no.GetField("layer")
	no_Layer.SetField("shadowOpacity",0.45)
	no_Layer.SetField("shadowRadius",20)
	no.SetField("clipsToBounds",False)
	#End If

	Dim ContentWidth As Float = Max(1,m_Width - 2 * PaddingHorizontal)

	'Custom content replaces the standard icon, text and button layout.
	If m_CustomContent <> Null Then
		Dim CustomHeight As Float = Data.GetDefault("height",40dip)
		xpnl_Body.SetLayoutAnimated(0,PaddingHorizontal,PaddingVertical,ContentWidth,CustomHeight)

		If m_CustomContent Is Map Then
			Dim CustomBodyProperties As Map = m_CustomContent
			CallSub3(CustomBodyProperties.Get("Callback"),CustomBodyProperties.Get("EventName"),Data.Get("id"),xpnl_Body)
			CustomHeight = xpnl_Body.Height
		Else
			Dim xpnl_CustomBody As B4XView = m_CustomContent
			CustomHeight = Max(CustomHeight,xpnl_CustomBody.Height)
			xpnl_CustomBody.RemoveViewFromParent
			xpnl_Body.AddView(xpnl_CustomBody,0,0,ContentWidth,CustomHeight)
		End If

		MeasuredHeight = CustomHeight + PaddingVertical * 2
		xpnl_Body.Height = CustomHeight
		Return
	End If

	'Build controls from right to left and reserve their width before laying out text.
	Dim Right As Float = ContentWidth
	Dim RowHeight As Float = 22dip
	Dim ShowClose As Boolean = m_DynamicToast.ConfigValue("closeButton")

	If ShowClose And Data.GetDefault("dismissible",True) And Data.Get("type") <> "loading" Then
		Dim xlbl_Close As B4XView = CreateLabel("xlbl_Close")
		xlbl_Close.Text = Chr(0x00D7)
		xlbl_Close.TextSize = 18
		xlbl_Close.SetTextAlignment("CENTER","CENTER")
		xlbl_Close.SetColorAndBorder(0x10FFFFFF,0,0,11dip)
		Right = Right - 22dip
		xpnl_Body.AddView(xlbl_Close,Right,0,22dip,22dip)
		TrackButton(xlbl_Close)
		Dim Icons As Map = m_DynamicToast.Icons

		If Icons.ContainsKey("close") Then
			xlbl_Close.Text = ""
			Dim CloseIcon As Object = m_DynamicToast.ResolveContent(Icons.Get("close"))
			AddIcon(CloseIcon,Right + 4dip,4dip,14dip,14dip)
		End If

		Right = Right - Gap
	End If

	'Place Action first, then Cancel, so Cancel appears to the left of Action.
	For Each Key As String In Array As String("action","cancel")
		If Data.ContainsKey(Key) And Data.Get(Key) Is Map Then
			Dim ActionProperties As Map = Data.Get(Key)
			Dim ActionContent As Object = m_DynamicToast.ResolveContent(ActionProperties.GetDefault("label",""))
			Dim xlbl_Action As B4XView = CreateLabel("xlbl_Action")
			xlbl_Action.Tag = Key
			xlbl_Action.Font = xui.CreateDefaultBoldFont(13)
			xlbl_Action.Text = ""
			Dim ButtonWidth As Float = 52dip

			If ActionContent Is String Then
				xlbl_Action.Text = ActionContent
				ButtonWidth = xCanvas.MeasureText(xlbl_Action.Text,xlbl_Action.Font).Width + 26dip
			End If

			ButtonWidth = Min(ButtonWidth,ContentWidth * 0.32)
			xlbl_Action.SetTextAlignment("CENTER","CENTER")
			xlbl_Action.TextColor = 0xFF0A0A0B
			xlbl_Action.SetColorAndBorder(0xFFF5F5F7,0,0,10dip)

			If Key = "cancel" Then
				xlbl_Action.TextColor = 0xFFF5F5F7
				xlbl_Action.SetColorAndBorder(0x10FFFFFF,0,0,10dip)
			End If

			Right = Right - ButtonWidth
			xpnl_Body.AddView(xlbl_Action,Right,0,ButtonWidth,32dip)
			TrackButton(xlbl_Action)

			If (ActionContent Is String) = False And ActionContent <> Null Then
				Dim xlbl_ActionContent As B4XView = ActionContent
				xlbl_ActionContent.RemoveViewFromParent
				xpnl_Body.AddView(xlbl_ActionContent,Right + 8dip,7dip,Max(1,ButtonWidth - 16dip),18dip)
				PassThrough(xlbl_ActionContent)
			End If

			Right = Right - 8dip
			RowHeight = Max(RowHeight,32dip)
		End If
	Next

	'Icon priority: per-toast option, global type override, built-in icon.
	Dim Left As Float
	Dim Icon As Object = Null
	Dim IconSize As Float = Data.GetDefault("iconSize",20dip)
	Dim ToastType As String = Data.Get("type")

	If Data.ContainsKey("icon") Then
		Icon = Data.Get("icon")
	Else
		Dim TypeIcons As Map = m_DynamicToast.Icons

		If TypeIcons.ContainsKey(ToastType) Then
			Icon = m_DynamicToast.ResolveContent(TypeIcons.Get(ToastType))
		Else
			Icon = DefaultIcon(ToastType)
		End If
	End If

	If Icon <> Null Then
		AddIcon(Icon,0,0,IconSize,IconSize)
		Left = IconSize + Gap
		RowHeight = Max(RowHeight,IconSize)
	End If

	'Title and description share the remaining width as one text block.
	Dim TextWidth As Float = Max(1,Right - Left)
	Dim TextHeight As Float

	If m_Title <> Null Then TextHeight = AddContent(m_Title,Left,0,TextWidth,m_DynamicToast.TitleStyle,True)

	If m_Description <> Null Then
		Dim DescriptionTop As Float = TextHeight

		If TextHeight > 0 Then DescriptionTop = DescriptionTop + 3dip
		TextHeight = DescriptionTop + AddContent(m_Description,Left,DescriptionTop,TextWidth,m_DynamicToast.DescriptionStyle,False)
	End If

	'Align the elements vertically, then calculate the outer card height.
	RowHeight = Max(RowHeight,TextHeight)
	AlignBody(RowHeight,TextHeight)
	MeasuredHeight = Max(Properties.GetDefault("minHeight",0),RowHeight + 2 * PaddingVertical)
	xpnl_Body.SetLayoutAnimated(0,PaddingHorizontal,(MeasuredHeight - RowHeight) / 2,ContentWidth,RowHeight)
	SetAccessibility

End Sub

Private Sub AlignBody(RowHeight As Float,TextHeight As Float)

	'Track content views separately: native controls may have a Null Tag,
	'and user-provided content must retain its own Tag.
	For i = 0 To xpnl_Body.NumberOfViews - 1
		Dim xView As B4XView = xpnl_Body.GetView(i)

		If lst_TextViews.IndexOf(xView) > -1 Then
			xView.Top = xView.Top + (RowHeight - TextHeight) / 2
		Else
			xView.Top = (RowHeight - xView.Height) / 2
		End If
	Next

End Sub

Private Sub CreateLabel(EventName As String) As B4XView

	Dim lbl As Label
	lbl.Initialize(EventName)
	Dim xView As B4XView = lbl
	xView.Font = xui.CreateDefaultFont(14)
	xView.TextColor = 0xFFF5F5F7

	#If B4J
	lbl.WrapText = True
	#Else If B4i
	lbl.Multiline = True
	#End If

	Return xView

End Sub

Private Sub AddContent(Content As Object,Left As Float,Top As Float,Width As Float,Properties As Map,Bold As Boolean) As Float

	Dim xView As B4XView
	Dim Height As Float

	'Create a label for text; preserve the content and height of custom views.
	If Content Is String Then
		xView = CreateLabel("")
		xView.Text = Content
		Dim FontSize As Float = 13
		Dim Color As Int = 0xFF8E8E96

		If Bold Then
			FontSize = 14
			Color = 0xFFF5F5F7
		End If

		FontSize = Properties.GetDefault("fontSize",FontSize)
		xView.TextColor = Properties.GetDefault("color",Color)

		If Bold Then
			xView.Font = xui.CreateDefaultBoldFont(FontSize)
		Else
			xView.Font = xui.CreateDefaultFont(FontSize)
		End If

		If Properties.ContainsKey("font") Then xView.Font = Properties.Get("font")
		xView.SetTextAlignment("TOP",Properties.GetDefault("textAlign","LEFT"))
		Height = MeasureTextHeight(xView.Text,xView.Font,Width,Properties.GetDefault("lineHeight",DipToCurrent(FontSize + 5)))
	Else
		xView = Content
		Height = Max(1dip,xView.Height)
		xView.RemoveViewFromParent
	End If

	lst_TextViews.Add(xView)
	xpnl_Body.AddView(xView,Left,Top,Width,Height)
	PassThrough(xView)
	Return Height

End Sub

Private Sub MeasureTextHeight(Text As String,Font As B4XFont,Width As Float,LineHeight As Float) As Float

	Dim LineCount As Int

	'Account for line breaks and available width when estimating text height.
	For Each Paragraph As String In Regex.Split(CRLF,Text & CRLF & " ")
		Dim LineWidth As Float
		LineCount = LineCount + 1

		For Each Word As String In Regex.Split(" ",Paragraph)
			Dim WordWidth As Float = xCanvas.MeasureText(Word & " ",Font).Width

			If LineWidth > 0 And LineWidth + WordWidth > Width Then
				LineCount = LineCount + 1
				LineWidth = 0
			End If

			If WordWidth > Width Then
				Dim LineCountValue As Int = Ceil(WordWidth / Max(1,Width))
				LineCount = LineCount + LineCountValue - 1
				LineWidth = WordWidth - (LineCountValue - 1) * Width
			Else
				LineWidth = LineWidth + WordWidth
			End If
		Next
	Next

	Return Max(1,LineCount - 1) * LineHeight + 2dip

End Sub

Private Sub AddIcon(Icon As Object,Left As Float,Top As Float,Width As Float,Height As Float)

	If Icon = Null Then Return

	Dim xView As B4XView

	If Icon Is B4XBitmap Then
		Dim xiv_Icon As ImageView
		xiv_Icon.Initialize("")
		xView = xiv_Icon
		xView.SetBitmap(Icon)
	Else If Icon Is String Then
		xView = CreateLabel("")
		xView.Text = Icon
		xView.SetTextAlignment("CENTER","CENTER")
		xView.TextColor = Accent(Data.Get("type"))
	Else
		xView = Icon
		xView.RemoveViewFromParent
	End If

	xpnl_Body.AddView(xView,Left,Top,Width,Height)
	PassThrough(xView)

End Sub

'Vector icons are drawn with B4XCanvas, independent of platform font glyphs.
Private Sub DefaultIcon(Kind As String) As Object

	'Default and loading have no built-in icon, matching the reference implementation.
	If Kind = "default" Or Kind = "loading" Then Return Null

	Dim xpnl_Icon As B4XView = xui.CreatePanel("")
	xpnl_Icon.SetLayoutAnimated(0,0,0,20dip,20dip)
	Dim xCanvas_Icon As B4XCanvas
	xCanvas_Icon.Initialize(xpnl_Icon)
	Dim Color As Int = Accent(Kind)
	Dim CenterX As Float = 10dip

	If Kind = "warning" Then
		Dim xPath As B4XPath
		xPath.Initialize(10dip,2dip)
		xPath.LineTo(19dip,18dip)
		xPath.LineTo(1dip,18dip)
		xPath.LineTo(10dip,2dip)
		xCanvas_Icon.DrawPath(xPath,Color,True,0)
	Else
		xCanvas_Icon.DrawCircle(CenterX,CenterX,8dip,Color,True,0)
	End If

	Select Kind
		Case "success"
			xCanvas_Icon.DrawLine(6dip,10dip,9dip,13dip,0xFF1A1A1C,1.5dip)
			xCanvas_Icon.DrawLine(9dip,13dip,14dip,7dip,0xFF1A1A1C,1.5dip)
		Case "error","warning"
			xCanvas_Icon.DrawLine(CenterX,6dip,CenterX,11dip,0xFF1A1A1C,1.5dip)
			xCanvas_Icon.DrawCircle(CenterX,14dip,0.9dip,0xFF1A1A1C,True,0)
		Case "info"
			xCanvas_Icon.DrawCircle(CenterX,6dip,0.9dip,0xFF1A1A1C,True,0)
			xCanvas_Icon.DrawLine(CenterX,9dip,CenterX,14dip,0xFF1A1A1C,1.5dip)
	End Select

	xCanvas_Icon.Invalidate
	Dim bitmap As B4XBitmap = xCanvas_Icon.CreateBitmap
	xCanvas_Icon.Release
	Return bitmap

End Sub

Private Sub Accent(Kind As String) As Int

	Select Kind
		Case "success"
			Return 0xFF34D27B
		Case "error"
			Return 0xFFFF5A52
		Case "info"
			Return 0xFF2FA8FF
		Case "warning"
			Return 0xFFFFB23E
		Case "loading"
			Return 0xFF8E8E96
	End Select

	Return 0xFFF5F5F7

End Sub

Private Sub PassThrough(View As B4XView) 'ignore - Android labels already pass touches to their parent.
	#If B4J
	Dim jo As JavaObject = View
	jo.RunMethod("setMouseTransparent",Array(True))
	#Else If B4i
	Dim no As NativeObject = View
	no.SetField("userInteractionEnabled",False)
	#End If
End Sub

Private Sub TrackButton(View As B4XView) 'ignore - Additional touch tracking is Android-specific.
	#If B4A
	Dim jo As JavaObject = View

	'Object fields default to a plain Object in B4X, not Null. Always create a typed proxy.

	'Pause lifetimes during button interaction; False preserves normal click handling.
	Dim TouchListener As Object = jo.CreateEventFromUI("android.view.View.OnTouchListener","ButtonTouch",False)
	jo.RunMethod("setOnTouchListener",Array(TouchListener))
	#End If
End Sub

#If B4A
Private Sub ButtonTouch_Event(MethodName As String,Args() As Object) As Object

	Dim jo_Event As JavaObject = Args(1)
	Dim TouchAction As Int = jo_Event.RunMethod("getActionMasked",Null)

	If TouchAction = 0 Then m_DynamicToast.SetInteracting(True)

	If TouchAction = 1 Or TouchAction = 3 Then m_DynamicToast.SetInteracting(False)
	Return False

End Sub
#End If

Private Sub SetAccessibility

	Dim Title As String = ""

	If m_Title Is String Then Title = m_Title

	If m_Description Is String Then Title = Title & ". " & m_Description

	#If B4A
	Dim jo As JavaObject = Panel
	jo.RunMethod("setContentDescription",Array(Title))
	jo.RunMethod("setAccessibilityLiveRegion",Array(1))
	#Else If B4J
	Dim jo As JavaObject = Panel
	jo.RunMethod("setAccessibleText",Array(Title))
	#Else If B4i
	Dim no As NativeObject = Panel
	no.SetField("accessibilityLabel",Title)
	#End If

End Sub

#End Region

#Region Animation

Public Sub Layout(X As Float,Y As Float,Width As Float,Height As Float,Position As String,Index As Int,SumBefore As Float,Expanded As Boolean,SafeTop As Float,SafeBottom As Float)

	m_IsBottom = Position <> "top"
	Dim Offset As Float = m_DynamicToast.ConfigValue("offset")
	Dim RegionProperties As Map = m_DynamicToast.Style
	Dim Left As Float = RegionProperties.GetDefault("left",Offset)
	Dim Right As Float = RegionProperties.GetDefault("right",Offset)
	Dim NewWidth As Float = Max(1,Width - Left - Right)
	NewWidth = RegionProperties.GetDefault("width",NewWidth)

	If NewWidth <> m_Width Then
		m_Width = NewWidth
		Build
	End If

	'Keep the anchor at the screen edge and animate the stack offset separately.
	m_AnchorX = X + Left
	m_AnchorY = Y + SafeTop + RegionProperties.GetDefault("top",Offset)

	If m_IsBottom Then m_AnchorY = Y + Height - SafeBottom - RegionProperties.GetDefault("bottom",Offset) - MeasuredHeight

	'Collapsed: fixed depth offsets. Expanded: use the measured card heights.
	m_TargetY = Index * 16dip
	m_TargetScale = Max(0.8,1 - Index * 0.05)

	If Expanded Then
		m_TargetY = SumBefore
		m_TargetScale = 1
	End If

	If m_IsBottom Then m_TargetY = -m_TargetY

	'The visible-card limit also applies while the stack is expanded.
	m_TargetOpacity = 0

	If Index < m_DynamicToast.ConfigValue("visibleToasts") Then m_TargetOpacity = 1

	'Start at the correct stack position on the first layout.
	If m_LayoutReady = False Then
		m_CurrentY = m_TargetY
		m_CurrentScale = m_TargetScale
		m_Opacity = m_TargetOpacity
		m_LayoutReady = True
	End If

End Sub

Public Sub StepFrame(Elapsed As Long,Paused As Boolean)

	If m_Detached Or m_LayoutReady = False Then Return

	'Fade out first and remove the card only after the exit animation completes.
	If Closing Then
		m_CloseTime = m_CloseTime + Elapsed
		Dim Progress As Double = Min(1,m_CloseTime / 200)
		m_Presence = m_ClosePresence * (1 - Progress)
		m_DragX = m_DragX + (m_ExitX - m_DragX) * Min(1,Elapsed / Max(1,200 - m_CloseTime + Elapsed))
		m_DragY = m_DragY + (m_ExitY - m_DragY) * Min(1,Elapsed / Max(1,200 - m_CloseTime + Elapsed))

		If m_CloseTime >= 220 Then
			m_DynamicToast.RemoveItem(Me)
			Return
		End If
	Else

		'Paused, dragged and loading toasts do not consume their remaining lifetime.
		If Paused = False And m_Dragging = False And Data.Get("type") <> "loading" And m_RemainingDuration >= 0 Then
			m_RemainingDuration = Max(0,m_RemainingDuration - Elapsed)

			If m_RemainingDuration = 0 Then Close(True,0,0)
		End If
	End If

	'Substeps keep the spring stable on slow frames. Glide: damping 32, stiffness 170, mass 1.
	Dim RemainingTime As Double = Min(64,Elapsed) / 1000

	Do While RemainingTime > 0
		Dim DeltaTime As Double = Min(0.008,RemainingTime)
		m_VelocityY = m_VelocityY + (170 * (m_TargetY - m_CurrentY) - 32 * m_VelocityY) * DeltaTime
		m_CurrentY = m_CurrentY + m_VelocityY * DeltaTime
		m_VelocityScale = m_VelocityScale + (170 * (m_TargetScale - m_CurrentScale) - 32 * m_VelocityScale) * DeltaTime
		m_CurrentScale = m_CurrentScale + m_VelocityScale * DeltaTime

		'Animate presence independently of the stack movement.
		If Closing = False Then
			m_PresenceVelocity = m_PresenceVelocity + (170 * (1 - m_Presence) - 32 * m_PresenceVelocity) * DeltaTime
			m_Presence = m_Presence + m_PresenceVelocity * DeltaTime
		End If

		'An incomplete swipe springs back to the original position.
		If m_ReturnDrag And m_Dragging = False And Closing = False Then
			m_DragVelocityX = m_DragVelocityX + (280 * -m_DragX - 24 * m_DragVelocityX) / 0.8 * DeltaTime
			m_DragVelocityY = m_DragVelocityY + (280 * -m_DragY - 24 * m_DragVelocityY) / 0.8 * DeltaTime
			m_DragX = m_DragX + m_DragVelocityX * DeltaTime
			m_DragY = m_DragY + m_DragVelocityY * DeltaTime
		End If

		RemainingTime = RemainingTime - DeltaTime
	Loop

	'Combine stack movement, entry and swipe offsets when applying the final transform.
	m_Opacity = m_Opacity + Max(-Elapsed / 300,Min(Elapsed / 300,m_TargetOpacity - m_Opacity))
	m_ContentFade = Min(1,m_ContentFade + Elapsed / 300)
	Dim Direction As Int = -1

	If m_IsBottom Then Direction = 1
	Dim EnterOffset As Double = Direction * (MeasuredHeight + 16dip) * (1 - m_Presence)
	Panel.SetLayoutAnimated(0,m_AnchorX + m_DragX,m_AnchorY + m_CurrentY + EnterOffset + m_DragY,m_Width,MeasuredHeight)
	Dim Alpha As Double = Max(0,Min(1,m_Opacity * m_Presence * (1 - Min(1,(Abs(m_DragX) + Abs(m_DragY)) / 200dip))))
	Panel.Visible = Alpha > 0.001
	SetTransform(m_CurrentScale * (0.94 + 0.06 * m_Presence),Alpha)
	SetAlpha(xpnl_Body,m_ContentFade)

End Sub

Public Sub Close(Automatic As Boolean,SwipeX As Float,SwipeY As Float)

	'Prevent duplicate events if the timer and gesture dismiss at the same time.
	If Closing Or m_Detached Then Return

	Closing = True
	m_CloseTime = 0
	m_ClosePresence = m_Presence
	m_ExitX = SwipeX
	m_ExitY = SwipeY
	m_Dragging = False
	m_DynamicToast.SetInteracting(False)
	m_DynamicToast.ItemClosed(Me,Automatic)

End Sub

Public Sub Detach
	m_Detached = True
	Panel.RemoveViewFromParent
	xpnl_Body.RemoveAllViews
	xCanvas.Release
End Sub

Private Sub SetTransform(Scale As Double,Alpha As Double)

	#If B4J
	Dim jo As JavaObject = Panel
	jo.RunMethod("setScaleX",Array(Scale))
	jo.RunMethod("setScaleY",Array(Scale))
	#Else If B4A
	Dim jo As JavaObject = Panel
	jo.RunMethod("setScaleX",Array(Scale.As(Float)))
	jo.RunMethod("setScaleY",Array(Scale.As(Float)))
	#Else If B4i
	Dim no As NativeObject = Me
	no.RunMethod("setScale:scale:",Array(Panel,Scale))
	#End If

	SetAlpha(Panel,Alpha)

End Sub

Private Sub SetAlpha(View As B4XView,Alpha As Double)

	#If B4J
	Dim jo As JavaObject = View
	jo.RunMethod("setOpacity",Array(Alpha))
	#Else If B4A
	Dim jo As JavaObject = View
	jo.RunMethod("setAlpha",Array(Alpha.As(Float)))
	#Else If B4i
	Dim no As NativeObject = View
	no.SetField("alpha",Alpha)
	#End If

End Sub

#End Region

#Region Gestures

'Absolute coordinates avoid drift while the card moves under the finger.
Public Sub PointerDown(X As Double,Y As Double)

	If Closing Or m_Detached Then Return

	m_TouchStartX = X
	m_TouchStartY = Y
	m_LastTouchX = X
	m_LastTouchY = Y
	m_TouchStartTime = DateTime.Now
	m_LastTouchTime = m_TouchStartTime

	'Reset movement and axis locking for the new gesture.
	m_DragVelocityX = 0
	m_DragVelocityY = 0
	m_SwipeAxis = 0
	m_TouchMoved = False
	m_Dragging = True
	m_ReturnDrag = False
	m_DynamicToast.SetInteracting(True)

End Sub

Public Sub PointerMove(X As Double,Y As Double)

	If m_Dragging = False Or Closing Then Return

	Dim DeltaX As Double = X - m_TouchStartX
	Dim DeltaY As Double = Y - m_TouchStartY

	If Max(Abs(DeltaX),Abs(DeltaY)) > 4dip Then m_TouchMoved = True

	If m_DynamicToast.ConfigValue("swipeToDismiss") = False Or Data.GetDefault("dismissible",True) = False Or Data.Get("type") = "loading" Then Return

	'Lock to the dominant axis once movement exceeds the small dead zone.
	If m_SwipeAxis = 0 And m_TouchMoved Then
		m_SwipeAxis = 2

		If Abs(DeltaX) >= Abs(DeltaY) Then m_SwipeAxis = 1
	End If

	'Calculate velocity from the most recent movement segment in pixels per second.
	Dim CurrentTime As Long = DateTime.Now

	If CurrentTime > m_LastTouchTime Then
		m_DragVelocityX = (X - m_LastTouchX) * 1000 / (CurrentTime - m_LastTouchTime)
		m_DragVelocityY = (Y - m_LastTouchY) * 1000 / (CurrentTime - m_LastTouchTime)
	End If

	m_LastTouchX = X
	m_LastTouchY = Y
	m_LastTouchTime = CurrentTime

	If m_SwipeAxis = 1 Then m_DragX = DeltaX

	'Apply resistance when dragging away from the anchored screen edge.
	If m_SwipeAxis = 2 Then
		m_DragY = DeltaY

		If (m_IsBottom And DeltaY < 0) Or (m_IsBottom = False And DeltaY > 0) Then m_DragY = DeltaY * 0.2
	End If

End Sub

Public Sub PointerUp(Cancelled As Boolean)

	If m_Dragging = False Then Return

	m_Dragging = False
	m_DynamicToast.SetInteracting(False)

	If Cancelled = False And m_TouchMoved = False Then m_DynamicToast.ToggleExpand

	If Cancelled = False And m_SwipeAxis > 0 Then

		'A pause before release must not count as a fast flick.
		If DateTime.Now - m_LastTouchTime > 100 Then
			m_DragVelocityX = 0
			m_DragVelocityY = 0
		End If

		'Dismiss when either the distance or velocity threshold is reached.
		If m_SwipeAxis = 1 And (Abs(m_DragX) >= 45dip Or Abs(m_DragVelocityX) >= 300dip) Then
			Close(False,DirectionOf(m_DragX) * Panel.Parent.Width,0)
			Return
		End If

		'Allow vertical dismissal only toward the anchored screen edge.
		Dim TowardEdge As Boolean = (m_IsBottom And m_DragY > 0) Or (m_IsBottom = False And m_DragY < 0)

		If m_SwipeAxis = 2 And TowardEdge And (Abs(m_DragY) >= 45dip Or Abs(m_DragVelocityY) >= 300dip) Then
			Close(False,0,DirectionOf(m_DragY) * Panel.Parent.Height * 0.6)
			Return
		End If
	End If

	'If the gesture did not dismiss the card, let the frame timer spring it back.
	m_ReturnDrag = True

End Sub

Private Sub DirectionOf(Value As Double) As Int
	If Value < 0 Then Return -1

	Return 1
End Sub

#End Region

#Region Events

#If B4J
Private Sub xpnl_Toast_MousePressed(EventData As MouseEvent)
	Dim e As JavaObject = EventData
	PointerDown(e.RunMethod("getScreenX",Null),e.RunMethod("getScreenY",Null))
	EventData.Consume
End Sub

Private Sub xpnl_Toast_MouseDragged(EventData As MouseEvent)
	Dim e As JavaObject = EventData
	PointerMove(e.RunMethod("getScreenX",Null),e.RunMethod("getScreenY",Null))
	EventData.Consume
End Sub

Private Sub xpnl_Toast_MouseReleased(EventData As MouseEvent)
	PointerUp(False)
	EventData.Consume
End Sub
#Else If B4A
Private Sub xpnl_Toast_Touch(Action As Int,X As Float,Y As Float)

	Select Action
		Case 0
			PointerDown(Panel.Left + X,Panel.Top + Y)
		Case 2
			PointerMove(Panel.Left + X,Panel.Top + Y)
		Case 1
			PointerUp(False)
		Case 3
			PointerUp(True)
	End Select

End Sub
#Else If B4i
Private Sub xpnl_Toast_Touch(Action As Int,X As Float,Y As Float)

	Select Action
		Case 0
			PointerDown(Panel.Left + X,Panel.Top + Y)
		Case 1
			PointerMove(Panel.Left + X,Panel.Top + Y)
		Case 2
			PointerUp(False)
		Case 3
			PointerUp(True)
	End Select

End Sub
#End If

Private Sub xlbl_Close_Click
	Close(False,0,0)
End Sub

Private Sub xlbl_Action_Click
	Dim xView As B4XView = Sender
	m_DynamicToast.ItemAction(Me,"cancel" = xView.Tag)
End Sub

#If B4J
Private Sub xlbl_Close_MousePressed(EventData As MouseEvent)
	m_DynamicToast.SetInteracting(True)
	EventData.Consume
End Sub

Private Sub xlbl_Close_MouseReleased(EventData As MouseEvent)
	m_DynamicToast.SetInteracting(False)
	EventData.Consume
End Sub

Private Sub xlbl_Action_MousePressed(EventData As MouseEvent)
	m_DynamicToast.SetInteracting(True)
	EventData.Consume
End Sub

Private Sub xlbl_Action_MouseReleased(EventData As MouseEvent)
	m_DynamicToast.SetInteracting(False)
	EventData.Consume
End Sub

Private Sub xlbl_Close_MouseClicked(EventData As MouseEvent)
	xlbl_Close_Click
	EventData.Consume
End Sub

Private Sub xlbl_Action_MouseClicked(EventData As MouseEvent)
	xlbl_Action_Click
	EventData.Consume
End Sub
#End If

#End Region

#Region Native Code

#If OBJC
- (void)setScale:(UIView *)view scale:(NSNumber *)scale {
    view.transform = CGAffineTransformMakeScale(scale.doubleValue, scale.doubleValue);
}
#End If

#End Region

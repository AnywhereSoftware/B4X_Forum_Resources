B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.3
@EndOfDesignText@
#If Documentation
Updates
V1.00
	-Release
V1.01
	-B4J BugFix - The text animation now no longer slips outside the badge
	-Add get and set TextAnimation - Various text change animations
		-Default: TextAnimation_Slide
		-TextAnimation_Slide - The old text slides out to the right
		-TextAnimation_Growth - The font grows animated
		-TextAnimation_FadeIn - The alpha of the new text is increased animatedly
V1.02
	-Breaking Change - Initialize needs now a CallBack and a EventName
	-Add Event Click
V1.03
	-BugFixes
	-Add set AutoRemove - Removes the badge if the value is 0
		-Default: True
V1.04
	-Property descriptions added
	-Add get and set xGap and yGap - This allows you to change the position of the badge. e.g. position it further to the left or higher up so that it matches the design.
		-Default: 0
#End If

#Event: Click (Parent As B4XView)

Sub Class_Globals
	
	Type AS_Badges_BadgeProperties(BackgroundColor As Int,TextColor As Int,xFont As B4XFont,Orientation As String)
	
	Private g_BadgeProperties As AS_Badges_BadgeProperties
	
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	
	Private views As Map
	Private stub As B4XView 'ignore this is required in B4A for the class to have an activity context.
	Private m_Radius As Float = 15dip
	Private cx, cy As Float
	Private xui As XUI
	Private m_FadeInDuration As Long = 250
	Private m_TextDuration As Long = 500
	Private m_TextAnimation As String
	Private m_AutoRemove As Boolean = True
	Private m_xGap As Float = 0
	Private m_yGap As Float = 0
End Sub

'<code>AS_Badges1.Initialize(Me,"Badges1")</code>
Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	
	views.Initialize
	
	g_BadgeProperties = CreateAS_Badges_BadgeProperties(xui.Color_ARGB(255,45, 136, 121),xui.Color_White,xui.CreateDefaultBoldFont(16),getOrientation_TopRight)
	m_TextAnimation = getTextAnimation_Slide
End Sub

Public Sub SetBadge(View As B4XView, Badge As Int)
	CreateOrUpdateBadge(View,Badge,g_BadgeProperties)
End Sub

Public Sub SetBadge2(View As B4XView, Badge As Int,Properties As AS_Badges_BadgeProperties)
	CreateOrUpdateBadge(View,Badge,Properties)
End Sub

Private Sub CreateOrUpdateBadge(View As B4XView, Badge As Int,Properties As AS_Badges_BadgeProperties)
	If views.ContainsKey(View) Then
		If Badge = 0 And m_AutoRemove Then
			RemoveBadge(View)
		Else
			ReplaceLabel(View, Badge)
		End If
	Else
		If Badge > 0 Or m_AutoRemove = False Then
			Dim xpnl_Badge As B4XView = CreateNewPanel(View)
			xpnl_Badge.Tag = View
			CreateLabel(xpnl_Badge, Badge)
			#If B4J
			xpnl_Badge.SetLayoutAnimated(0, cx - m_Radius, cy - m_Radius, m_Radius * 2, m_Radius * 2)
			xpnl_Badge.SetVisibleAnimated(m_FadeInDuration,True)
			#Else
			xpnl_Badge.SetLayoutAnimated(m_FadeInDuration, cx - m_Radius, cy - m_Radius, m_Radius * 2, m_Radius * 2)
			#End If
			views.Put(View,xpnl_Badge)
		End If
	End If
	UpdateStyle(View,Properties)
End Sub

Private Sub UpdateStyle(View As B4XView,Properties As AS_Badges_BadgeProperties)
	If views.ContainsKey(View) = False Then Return
	Dim xpnl_Badge As B4XView = views.Get(View)
	xpnl_Badge.Color = Properties.BackgroundColor
	SetCircleClip(xpnl_Badge,0)
	If xpnl_Badge.GetView(0).IsInitialized = True Then
		Dim xlbl_BadgeLabel As B4XView = xpnl_Badge.GetView(0)
		xlbl_BadgeLabel.Font = Properties.xFont
		xlbl_BadgeLabel.TextColor = Properties.TextColor
	End If
	
	If Properties.Orientation = getOrientation_TopRight Or Properties.Orientation = getOrientation_TopLeft Then
		cx = View.Left + IIf(Properties.Orientation = getOrientation_TopRight,View.Width,0) + m_xGap
		cy = View.Top + m_yGap
	Else if Properties.Orientation = getOrientation_BottomRight Or Properties.Orientation = getOrientation_BottomLeft Then
		cx = View.Left + IIf(Properties.Orientation = getOrientation_BottomRight,View.Width,0) + m_xGap
		cy = View.Top + View.Height + m_yGap
	End If
	
	xpnl_Badge.SetLayoutAnimated(0,cx - m_Radius, cy - m_Radius, m_Radius * 2, m_Radius * 2)
	
End Sub

Private Sub RemoveBadge(view As B4XView)
	Dim p As B4XView = GetPanel(view)
	GetLabel(p).RemoveViewFromParent
	views.Remove(view)
	p.SetLayoutAnimated(m_FadeInDuration, cx, cy, 2dip, 2dip)
	Sleep(m_FadeInDuration)
	p.RemoveViewFromParent
End Sub

Private Sub ReplaceLabel(view As B4XView, Badge As Int)
	Dim lbl As B4XView = GetLabel(GetPanel(view))
	
	If m_TextAnimation = getTextAnimation_Slide Then
		lbl.SetLayoutAnimated(m_TextDuration / 2, m_Radius + 8dip, 0, m_Radius * 2, m_Radius * 2)
		Else
		lbl.SetLayoutAnimated(0 / 2, m_Radius + 8dip, 0, m_Radius * 2, m_Radius * 2)
	End If
	
	CreateLabel(GetPanel(view), Badge)
	Sleep(m_TextDuration / 2)
	lbl.RemoveViewFromParent
End Sub
'Gets the Count of the badge on this view
Public Sub GetBadgeCounter(view As B4XView) As Int
	If views.ContainsKey(view) Then
		Dim lbl As B4XView = GetLabel(GetPanel(view))
		Return lbl.Text
	Else
		Return 0
	End If
End Sub

'This allows you to change the position of the badge. e.g. position it further to the left or higher up so that it matches the design.
'Default: 0
Public Sub getyGap As Float
	Return m_yGap
End Sub

Public Sub setyGap(Gap As Float)
	m_yGap = Gap
End Sub

'This allows you to change the position of the badge. e.g. position it further to the left or higher up so that it matches the design.
'Default: 0
Public Sub getxGap As Float
	Return m_xGap
End Sub

Public Sub setxGap(Gap As Float)
	m_xGap = Gap
End Sub

'Removes the badge if the value is 0
'Default: True
Public Sub setAutoRemove(Remove As Boolean)
	m_AutoRemove = Remove
End Sub

'Default: 250
Public Sub getFadeInDuration As Long
	Return m_FadeInDuration
End Sub

Public Sub setFadeInDuration(Duration As Long)
	m_FadeInDuration = Duration
End Sub

'Gets or sets the text animation
'<code>AS_Badges1.TextAnimation = AS_Badges1.TextAnimation_FadeIn</code>
Public Sub getTextAnimation As String
	Return m_TextAnimation
End Sub

Public Sub setTextAnimation(AnimationName As String)
	m_TextAnimation = AnimationName
End Sub

'Default: 500
Public Sub getTextDuration As Long
	Return m_TextDuration
End Sub

Public Sub setTextDuration(Duration As Long)
	m_TextDuration = Duration
End Sub

Private Sub GetPanel (view As Object) As B4XView
	Return views.Get(view)
End Sub

Private Sub GetLabel(panel As B4XView) As B4XView
	Return panel.GetView(panel.NumberOfViews - 1)
End Sub

Private Sub CreateNewPanel(view As B4XView) As B4XView
	
	Dim xp As B4XView = xui.CreatePanel("BadgePanel")
	
#if B4A
	xp.As(Panel).SetElevationAnimated(m_FadeInDuration, 8dip)
#end if
	
	xp.SetColorAndBorder(g_BadgeProperties.BackgroundColor, 0, g_BadgeProperties.BackgroundColor, m_Radius)
	cx = view.Left + view.Width
	cy = view.Top
	Dim parent As B4XView = view.Parent
	parent.AddView(xp, cx, cy, 0, 0)
	
	'Dim Properties As AS_Badges_BadgeProperties = CreateAS_Badges_BadgeProperties(g_BadgeProperties.BackgroundColor,g_BadgeProperties.TextColor,g_BadgeProperties.xFont,g_BadgeProperties.Orientation)
	'xp.Tag = Properties
	Return xp
End Sub

Private Sub CreateLabel(p As B4XView, count As Int)
	Dim lbl As Label
	lbl.Initialize("")
	Dim xlbl As B4XView = lbl
	If m_TextAnimation = getTextAnimation_Slide Or m_TextAnimation = getTextAnimation_FadeIn Then
		xlbl.Font = g_BadgeProperties.xFont
	else If m_TextAnimation = getTextAnimation_Growth Then
		xlbl.Font = xui.CreateFont2(g_BadgeProperties.xFont,0)
	End If
	
	xlbl.TextColor = g_BadgeProperties.TextColor
	xlbl.Text = IIf(count = 0,"", count)
	p.AddView(xlbl, m_Radius, m_Radius, 0, 0)
	xlbl.SetTextAlignment("CENTER", "CENTER")
	Dim duration As Int = m_TextDuration
	
	If m_TextAnimation = getTextAnimation_Slide Then
		xlbl.SetLayoutAnimated(duration, 0, 0, m_Radius * 2, m_Radius * 2)
		xlbl.Visible = False
		xlbl.SetVisibleAnimated(duration, True)
	Else if m_TextAnimation = getTextAnimation_FadeIn Then
		xlbl.SetLayoutAnimated(0, 0, 0, m_Radius * 2, m_Radius * 2)
		xlbl.Visible = False
		xlbl.SetVisibleAnimated(duration, True)
	else If m_TextAnimation = getTextAnimation_Growth Then
		xlbl.SetLayoutAnimated(0, 0, 0, m_Radius * 2, m_Radius * 2)
		xlbl.SetTextSizeAnimated(duration,g_BadgeProperties.xFont.Size)
	End If
End Sub

#Region Properties

'<code>
'	Dim BadgeProperties As AS_Badges_BadgeProperties = AS_Badges1.BadgeProperties
'	BadgeProperties.Orientation = AS_Badges1.Orientation_BottomRight
'	AS_Badges1.BadgeProperties = BadgeProperties
'</code>
Public Sub getBadgeProperties As AS_Badges_BadgeProperties
	Dim Properties As AS_Badges_BadgeProperties = CreateAS_Badges_BadgeProperties(g_BadgeProperties.BackgroundColor,g_BadgeProperties.TextColor,g_BadgeProperties.xFont,g_BadgeProperties.Orientation)
	Return Properties
End Sub

Public Sub setBadgeProperties(Properties As AS_Badges_BadgeProperties)
	g_BadgeProperties = Properties
End Sub

'Get or set the radius
'Default: 15dip
Public Sub getRadius As Float
	Return m_Radius
End Sub

Public Sub setRadius(Radius As Float)
	m_Radius = Radius
End Sub

#End Region

#Region Enums

'<code>BadgeProperties.Orientation = AS_Badges1.Orientation_TopLeft</code>
Public Sub getOrientation_TopLeft As String
	Return "TopLeft"
End Sub

'<code>BadgeProperties.Orientation = AS_Badges1.Orientation_TopRight</code>
Public Sub getOrientation_TopRight As String
	Return "TopRight"
End Sub

'<code>BadgeProperties.Orientation = AS_Badges1.Orientation_BottomLeft</code>
Public Sub getOrientation_BottomLeft As String
	Return "BottomLeft"
End Sub

'<code>BadgeProperties.Orientation = AS_Badges1.Orientation_BottomRightt</code>
Public Sub getOrientation_BottomRight As String
	Return "BottomRight"
End Sub

'<code>'<code>AS_Badges1.TextAnimation = AS_Badges1.TextAnimation_Slide</code></code>
Public Sub getTextAnimation_Slide As String
	Return "Slide"
End Sub

'<code>'<code>AS_Badges1.TextAnimation = AS_Badges1.TextAnimation_Growth</code></code>
Public Sub getTextAnimation_Growth As String
	Return "Growth"
End Sub

'<code>'<code>AS_Badges1.TextAnimation = AS_Badges1.TextAnimation_FadeIn</code></code>
Public Sub getTextAnimation_FadeIn As String
	Return "FadeIn"
End Sub

#End Region

#Region Events

#If B4J
Private Sub BadgePanel_MouseClicked (EventData As MouseEvent)
#Else
Private Sub BadgePanel_Click
#End If
	Dim xpnl_Badge As B4XView = Sender
	Click(xpnl_Badge.Tag)
End Sub


Private Sub Click(Parent As B4XView)
	If xui.SubExists(mCallBack, mEventName & "_Click",1) Then
		CallSub2(mCallBack, mEventName & "_Click",Parent)
	End If
End Sub

#End Region

#Region Functions

Private Sub SetCircleClip (pnl As B4XView,radius As Int)'ignore
#if B4J
	Dim jo As JavaObject = pnl
	Dim shape As JavaObject
	Dim cx2 As Double = pnl.Width
	Dim cy2 As Double = pnl.Height
	shape.InitializeNewInstance("javafx.scene.shape.Rectangle", Array(cx2, cy2))
	If radius > 0 Then
		Dim d As Double = radius
		shape.RunMethod("setArcHeight", Array(d))
		shape.RunMethod("setArcWidth", Array(d))
	End If
	jo.RunMethod("setClip", Array(shape))
	#else if B4A
	Dim jo As JavaObject = pnl
	jo.RunMethod("setClipToOutline", Array(True))
#end if
End Sub

#End Region

Public Sub CreateAS_Badges_BadgeProperties (BackgroundColor As Int, TextColor As Int, xFont As B4XFont, Orientation As String) As AS_Badges_BadgeProperties
	Dim t1 As AS_Badges_BadgeProperties
	t1.Initialize
	t1.BackgroundColor = BackgroundColor
	t1.TextColor = TextColor
	t1.xFont = xFont
	t1.Orientation = Orientation
	Return t1
End Sub
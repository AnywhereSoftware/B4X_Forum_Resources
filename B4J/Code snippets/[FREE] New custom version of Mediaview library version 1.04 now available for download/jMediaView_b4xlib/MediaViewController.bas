B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.1
@EndOfDesignText@

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	Public Overlay As B4XView
	Public Timer1 As Timer
	Public lblState As B4XView
	Public lblTime As B4XView
	Public mMediaView As MediaView
	Public barPosition As B4XSeekBar
	Public pnlBottom As B4XView
	Public lblPlay As B4XView
	Private UserIsMovingPosition As Boolean
	Public lblMute As B4XView
	Public LastTouch As Long
	Public FadeAfterMs As Long = 3000
	'---- New ----
	Public lblRatio As B4XView
	Private mBackgroundColorGradient() As Int = Array As Int(xui.Color_Transparent)
	Private mBackgroundColorGradientOrientation As String = "LEFT_RIGHT"
	Private mTextIconColor As Int = xui.Color_White
	Private mOnMouseOverVideo As Boolean = False
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
    mBase.Tag = Me 
	Timer1.Initialize("Timer1", 200)
	Sleep(0)
	mBase.LoadLayout("MediaViewController")
	mBase.Tag = Me
	'---- New ----
	barPosition.Size1 = 2 : barPosition.Size2 = 2
	barPosition.Radius1 = 4 : barPosition.Radius2 = 10
	CSSUtils.SetStyleProperty(pnlBottom,"-fx-cursor","hand")
	Base_Resize (mBase.Width, mBase.Height)
End Sub

Public Sub SetMediaView(View As MediaView)
	mMediaView = View
	Timer1.Enabled = True 'only after the source is set
	Timer1_Tick
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	If Overlay.IsInitialized = False Then Return
	SetColorGradient(pnlBottom, mBackgroundColorGradient, mBackgroundColorGradientOrientation)
	SetTextColor(Overlay, mTextIconColor, 65)
End Sub

Private Sub Timer1_Tick
	If Overlay.IsInitialized = False Then Return
	If mMediaView.jMediaPlayer.IsInitialized = False Then
		Overlay.Visible = False
		Return
	End If
	If mMediaView.IsFiniteDuration Then
		Dim p As Double = IIf(UserIsMovingPosition, GetBarPosition, mMediaView.Position)
		lblTime.Text = ConvertMillisecondsToString(p) & " / " & ConvertMillisecondsToString(mMediaView.Duration)
	Else
		lblTime.Text = ""
	End If
	lblState.Text = mMediaView.State
	pnlBottom.Visible = True
	Select mMediaView.State
		Case "READY"
			UpdateTouchCounter
		Case "PLAYING"
			lblPlay.Text = Chr(0xE037)
		Case "PAUSED"
			lblPlay.Text = Chr(0xE034)
			UpdateTouchCounter
	End Select
	If mMediaView.IsFiniteDuration Then
		barPosition.mBase.Visible = IIf(barPosition.mBase.Width < 40, False, True)
		If UserIsMovingPosition = False Then
			barPosition.Value = mMediaView.Position / mMediaView.Duration * (barPosition.MaxValue - barPosition.MinValue)
		End If
	Else
		barPosition.mBase.Visible = False
	End If
	lblTime.Visible = barPosition.mBase.Visible
	lblMute.Text = IIf(mMediaView.Mute, Chr(0xE04F), Chr(0xE050))
	lblRatio.Text = IIf(mMediaView.GetPreserveRatio, Chr(0xE85B), Chr(0xE911))
	Overlay.Visible = DateTime.Now <= LastTouch + FadeAfterMs
End Sub

Private Sub ConvertMillisecondsToString(t As Long) As String
	Dim hours, minutes, seconds As Int
	hours = t / DateTime.TicksPerHour
	minutes = (t Mod DateTime.TicksPerHour) / DateTime.TicksPerMinute
	seconds = (t Mod DateTime.TicksPerMinute) / DateTime.TicksPerSecond
	Dim result As String
	If hours = 0 Then
		result = $"$2.0{minutes}:$2.0{seconds}"$
	Else
		result = $"$2.0{hours}:$2.0{minutes}:$2.0{seconds}"$
	End If
	Return result
End Sub

Private Sub barPosition_ValueChanged (Value As Int)
	UpdateTouchCounter
End Sub

Private Sub barPosition_TouchStateChanged (Pressed As Boolean)
	If Pressed Then
		UserIsMovingPosition = True
	Else
		mMediaView.Position = GetBarPosition
		UserIsMovingPosition = False
	End If
End Sub

Private Sub GetBarPosition As Double
	Return mMediaView.Duration * barPosition.Value / (barPosition.MaxValue - barPosition.MinValue)
End Sub

Private Sub lblPlay_MouseClicked (EventData As MouseEvent)
	TogglePlay
	EventData.Consume
End Sub

Private Sub TogglePlay
	If mMediaView.State = "READY" Or mMediaView.State = "PAUSED" Then
		mMediaView.Play
	Else If mMediaView.State = "PLAYING" Then
		mMediaView.Pause
	End If
End Sub

Private Sub lblMute_MouseClicked (EventData As MouseEvent)
	mMediaView.Mute = Not(mMediaView.Mute)
	EventData.Consume
End Sub

Private Sub pnlTouch_MouseClicked (EventData As MouseEvent)
	UpdateTouchCounter
	If Overlay.IsInitialized And Overlay.Visible Then
		TogglePlay
	End If
End Sub

Private Sub UpdateTouchCounter
	LastTouch = DateTime.Now
End Sub

Private Sub pnlBottom_MouseClicked (EventData As MouseEvent)
	EventData.Consume
End Sub

'************** New **************

Private Sub pnlTouch_MouseMoved (EventData As MouseEvent)
	If Not(mMediaView.State = "UNKNOWN") And mOnMouseOverVideo Then
		UpdateTouchCounter
	End If
End Sub

Private Sub lblRatio_MouseClicked (EventData As MouseEvent)
	mMediaView.SetPreserveRatio = Not(mMediaView.GetPreserveRatio)
	EventData.Consume
End Sub

'Sets the background gradient color of the controller.
'Colors - An array of one or more colors that define the gradient.
'Orientation - TL_BR, TOP_BOTTOM, TR_BL, LEFT_RIGHT, RIGHT_LEFT, BL_TR, BOTTOM_TOP, BR_TL and RECTANGLE.
'Default: Transparent
Public Sub SetBackgroundColorGradient(Colors() As Int, Orientation As String)
	If Not(Colors.Length = 0) Then mBackgroundColorGradient = Colors
	If Not(Orientation.Trim.Length = 0) Then mBackgroundColorGradientOrientation = Orientation
	Base_Resize (mBase.Width, mBase.Height)
End Sub

'Sets the background color of the controller.
'Default: Transparent
Public Sub setSetBackgroundColor(Color As Int)
	mBackgroundColorGradient = Array As Int(Color)
	Base_Resize (mBase.Width, mBase.Height)
End Sub

'Sets the color of texts and icons.
'Default: White
Public Sub setSetTextIconColor(clr As Int)
	mTextIconColor = clr
	Base_Resize (mBase.Width, mBase.Height)
End Sub

'Return the color of texts and icons.
'Default: White
Public Sub getGetTextIconColor As Int
	Return mTextIconColor
End Sub

'Sets the display of the controller when the mouse hovers over the video.
'Default: False
Public Sub setSetOnMouseOverVideo(Status As Boolean)
	mOnMouseOverVideo = Status
End Sub

'Return the display state of the controller when the mouse is hovered over the video.
Public Sub getGetOnMouseOverVideo As Boolean
	Return mOnMouseOverVideo
End Sub

'************** Utils **************

Private Sub SetColorGradient(v As B4XView, Colors() As Int, Orientation As String)
	Dim bc As BitmapCreator
	bc.Initialize(v.Width / xui.Scale, v.Height / xui.Scale)
	bc.FillGradient(Colors, bc.TargetRect, Orientation.ToUpperCase)
	v.Color = xui.Color_Transparent
	For Each vi As B4XView In v.GetAllViewsRecursive
		If vi.Tag = "GradientColor" Then vi.RemoveViewFromParent
	Next
	Dim iv As ImageView
	iv.Initialize("")
	Dim xiv As B4XView = iv
	v.AddView(xiv, 0, 0, v.Width, v.Height)
	xiv.SendToBack
	xiv.Tag = "GradientColor"
	bc.SetBitmapToImageView(bc.Bitmap, xiv)
End Sub

Private Sub SetTextColor(v As B4XView, clr As Int, Alpha As Int)
	Dim bc As BitmapCreator, ARGBColor As ARGBColor
	bc.Initialize(v.Width / xui.Scale, v.Height / xui.Scale)
	bc.ColorToARGB(clr, ARGBColor)
	ARGBColor.a = Alpha
	For Each v As B4XView In  Overlay.GetAllViewsRecursive
		If v Is Label Then v.TextColor = clr
	Next
	barPosition.Color1 = clr
	barPosition.Color2 = bc.ARGBToColor(ARGBColor)
	barPosition.ThumbColor = bc.ARGBToColor(ARGBColor)
	Dim CornerRadius As Double = Min(lblState.Width, lblState.Height) / 2
	lblState.SetColorAndBorder(bc.ARGBToColor(ARGBColor), 2, bc.ARGBToColor(ARGBColor), CornerRadius)
End Sub

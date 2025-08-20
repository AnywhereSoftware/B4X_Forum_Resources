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
End Sub

Public Sub SetMediaView(View As MediaView)
	mMediaView = View
	Timer1.Enabled = True 'only after the source is set
	Timer1_Tick
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
  
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
	lblState.Text = IIf(mMediaView.State = "UNKNOWN", "", mMediaView.State)
	Select mMediaView.State
		Case "READY"
			pnlBottom.Visible = True
			UpdateTouchCounter
		Case "PLAYING"
			lblPlay.Text = Chr(0xF04C)
		Case "PAUSED"
			lblPlay.Text = Chr(0xF04B)
			UpdateTouchCounter
	End Select
	If mMediaView.IsFiniteDuration Then
		barPosition.mBase.Visible = True
		If UserIsMovingPosition = False Then
			barPosition.Value = mMediaView.Position / mMediaView.Duration * (barPosition.MaxValue - barPosition.MinValue)
		End If
	Else
		barPosition.mBase.Visible = False
	End If
	lblMute.Text = IIf(mMediaView.Mute, Chr(0xF026), Chr(0xF028))
	Overlay.Visible = DateTime.Now <= LastTouch + FadeAfterMs
End Sub

Private Sub ConvertMillisecondsToString(t As Long) As String
	Dim hours, minutes, seconds As Int
	hours = t / DateTime.TicksPerHour
	minutes = (t Mod DateTime.TicksPerHour) / DateTime.TicksPerMinute
	seconds = (t Mod DateTime.TicksPerMinute) / DateTime.TicksPerSecond
	If hours = 0 Then
		Return $"$2.0{minutes}:$2.0{seconds}"$
	Else
		Return $"$1.0{hours}:$2.0{minutes}:$2.0{seconds}"$
	End If
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
B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.1
@EndOfDesignText@
#Event: Error (Message As String)
#Event: StateChanged (State As String)
#Event: Complete

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	Public jMedia As JavaObject
	Public jMediaPlayer As JavaObject
	Public mMediaView As B4XView
	'---- New ----
	Private mPreserveRatio As Boolean = True
	Private mBackgroundColor As Int = xui.Color_Black
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
	mBase.Tag = Me
	Dim jo As JavaObject
	mMediaView = jo.InitializeNewInstance("javafx.scene.media.MediaView", Null)
	mBase.AddView(mMediaView, 0, 0, mBase.Width, mBase.Height)
End Sub

Public Sub Base_Resize (Width As Double, Height As Double)
	If jMedia.IsInitialized Then
		Dim VideoWidth As Int = jMedia.RunMethod("getWidth", Null)
		Dim VideoHeight As Int = jMedia.RunMethod("getHeight", Null)
		If VideoWidth > 0 And VideoHeight > 0 Then
			Dim ratio As Float = Width / Height
			Dim scale As Float
			If ratio > VideoWidth / VideoHeight Then
				scale = Height / VideoHeight
			Else
				scale = Width / VideoWidth
			End If
			mMediaView.Left = IIf(mPreserveRatio, Width / 2 - VideoWidth / 2 * scale, 0)
			mMediaView.Top = IIf(mPreserveRatio, Height / 2 - VideoHeight / 2 * scale, 0)
		End If
	End If
	mMediaView.As(JavaObject).RunMethod("setFitWidth", Array(Width))
	mMediaView.As(JavaObject).RunMethod("setFitHeight", Array(Height))
	mMediaView.As(JavaObject).RunMethod("setPreserveRatio", Array(mPreserveRatio))
	mBase.Color = mBackgroundColor
End Sub

'Sets the video or audio source. It can be http(s):// or file:// url.
Public Sub setSource(url As String)
	If jMediaPlayer.IsInitialized Then
		jMediaPlayer.RunMethod("dispose", Null)
	End If
	jMedia.InitializeNewInstance("javafx.scene.media.Media", Array(url))
	jMediaPlayer.InitializeNewInstance("javafx.scene.media.MediaPlayer", Array(jMedia))
	Dim listener As Object = jMediaPlayer.CreateEventFromUI("javafx.beans.value.ChangeListener", "StateChanged", Null)
	jMediaPlayer.RunMethodJO("statusProperty", Null).RunMethod("addListener", Array(listener))
	listener = jMediaPlayer.CreateEventFromUI("java.lang.Runnable", "Error", Null)
	jMediaPlayer.RunMethod("setOnError", Array(listener))
	listener = jMediaPlayer.CreateEventFromUI("java.lang.Runnable", "Complete", Null)
	jMediaPlayer.RunMethod("setOnEndOfMedia", Array(listener))
	mMediaView.As(JavaObject).RunMethod("setMediaPlayer", Array(jMediaPlayer))
End Sub

Private Sub Complete_Event (MethodName As String, Args() As Object) As Object
	If SubExists(mCallBack, mEventName & "_Complete") Then
		CallSubDelayed(mCallBack, mEventName & "_Complete")
	End If
	Return Null
End Sub

Private Sub Error_Event (MethodName As String, Args() As Object) As Object
	Dim error As Exception = jMediaPlayer.RunMethodJO("getError", Null)
	If SubExists(mCallBack, mEventName & "_Error") Then
		CallSubDelayed2(mCallBack, mEventName & "_Error", IIf(error.IsInitialized, error.Message, "Unknown"))
	End If
	Return Null
End Sub

Private Sub StateChanged_Event (MethodName As String, Args() As Object) As Object
	If MethodName = "changed" Then
		Dim state As String = Args(2)
		If state = "READY" Then
			Base_Resize (mBase.Width, mBase.Height)
		End If
		If SubExists(mCallBack, mEventName & "_StateChanged") Then
			CallSubDelayed2(mCallBack, mEventName & "_StateChanged", state)
		End If
	End If
	Return Null
End Sub

'Starts playback.
Public Sub Play
	jMediaPlayer.RunMethod("play", Null)
End Sub

'Pauses playback.
Public Sub Pause
	jMediaPlayer.RunMethod("pause", Null)
End Sub

'Stops playback.
Public Sub Stop
	jMediaPlayer.RunMethod("stop", Null)
End Sub

'Returns true if the total duration is known and valid.
Public Sub getIsFiniteDuration As Boolean
	Dim duration As JavaObject = jMediaPlayer.RunMethod("getTotalDuration", Null)
	Return duration.RunMethod("isUnknown", Null) = False And duration.RunMethod("isIndefinite", Null) = False
End Sub

'Returns the total duration in milliseconds.
Public Sub getDuration As Double
	Return jMediaPlayer.RunMethod("getTotalDuration", Null).As(JavaObject).RunMethod("toMillis", Null)
End Sub

'Gets or sets the current position in milliseconds.
Public Sub getPosition As Double
	Return jMediaPlayer.RunMethodJO("getCurrentTime", Null).RunMethod("toMillis", Null)
End Sub

Public Sub setPosition(t As Double)
	Dim duration As JavaObject
	duration.InitializeNewInstance("javafx.util.Duration", Array(t))
	jMediaPlayer.RunMethod("seek", Array(duration))
End Sub

'Gets the current state.
Public Sub getState As String
	Dim o As Object = IIf(jMediaPlayer.IsInitialized, jMediaPlayer.RunMethod("getStatus", Null), Null)
	Return IIf(o = Null, "UNKNOWN", o.As(String).Trim.ToUpperCase)
End Sub

'Gets or sets the volume (0 - 1).
Public Sub getVolume As Double
	Return jMediaPlayer.RunMethod("getVolume", Null)
End Sub

Public Sub setVolume(v As Double)
	jMediaPlayer.RunMethod("setVolume", Array(v))
End Sub

'Gets or sets the mute state.
Public Sub getMute As Boolean
	Return jMediaPlayer.RunMethod("isMute", Null)
End Sub

Public Sub setMute(b As Boolean) 
	jMediaPlayer.RunMethod("setMute", Array(b))
End Sub

'Releases resources related to the media. MediaView can be reused after a new source is set.
Public Sub Dispose
	If jMediaPlayer.IsInitialized Then
		jMediaPlayer.RunMethod("dispose", Null)
		Dim jMediaPlayer As JavaObject
	End If
End Sub

'************** New **************

'Set the background color of the video.
'Default: Black
Public Sub setSetBackgroundColor(clr As Int)
	mBackgroundColor = clr
	Base_Resize (mBase.Width, mBase.Height)
End Sub

'Return the background color of the video.
Public Sub getGetBackgroundColor As Int
	Return mBackgroundColor
End Sub

'Sets the state of the aspect ratio.
'Default: True
'Note: If the value is False, the video is filled to the dimensions of the container.
Public Sub setSetPreserveRatio(p As Boolean)
	mPreserveRatio = p
	Base_Resize (mBase.Width, mBase.Height)
End Sub

'Return the state of the aspect ratio.
Public Sub getGetPreserveRatio As Boolean
	Return mPreserveRatio
End Sub

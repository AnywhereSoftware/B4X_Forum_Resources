Type=Activity
Version=6
ModulesStructureVersion=1
B4A=true
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: true
	#IncludeTitle: false
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Dim streamingURL As String 'a process global variable used in this example to pass on the streaming url
End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.
	Dim VLCVideoview1 As VLCVideoView
	Dim VLCMediaController1 As VLCMediaController
	Dim mypanel As Panel
	'Dim subpanel As Panel 'for subtitles

End Sub

Sub Activity_Create(FirstTime As Boolean)
	'Do not forget to load the layout file created with the visual designer. For example:
	'Activity.LoadLayout("Layout1")
	
		mypanel.Initialize("mypanel")
		VLCVideoview1.Initialize("VLCVideoview1")
		'subpanel.Initialize("subpanel") ''for subtitles
		Activity.AddView(mypanel,0, 0, 100%x, 100%y)
		mypanel.AddView(VLCVideoview1,0, 0, 100%x, 100%y)
		'mypanel.AddView(subpanel, 0, 0, 100%x, 100%y-20dip) ''for subtitles
		VLCMediaController1.Initialize("VLCMediaController1")
		mypanel.Color = Colors.Black

		Dim OptionList As List
		OptionList.Initialize
		OptionList.Add("--aout=opensles")
		OptionList.Add("--audio-time-stretch")
		OptionList.Add("-vvv")
		VLCVideoview1.SetVlcOptions(OptionList)
		
		StartStreaming

End Sub

Sub StartStreaming
	
	If streamingURL.Contains("http") Then 'streaming url
		VLCVideoview1.VideoURI = streamingURL
	Else	'local file
		'VLCVideoview1.SetVideoPath(File.Combine(File.DirRootExternal,streamingURL))
		'for subtitles
		'VLCVideoview1.SubtitlesSurfaceView = subpanel
		'VLCVideoview1.SubtitleLocalSource = File.Combine(File.DirRootExternal,"bb.srt")
		
	End If
	
	VLCVideoview1.RequestFocus
	VLCVideoview1.Start
End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

Sub Activity_KeyPress (KeyCode As Int) As Boolean 'return true if you want to consume the event
 
	If KeyCode = KeyCodes.KEYCODE_BACK Then
 
 		Select Msgbox2("Quit streeaming?","My stream","Yes","","No",Null)
			Case DialogResponse.POSITIVE
				Try
					If VLCVideoview1.IsPlaying Then
						VLCVideoview1.StopPlayback
						Log("video was playing but now quitting")
					End If
				Catch		
					Activity.Finish
				End Try
				Activity.Finish
			Case Else
				Return True
		End Select
 
	End If
 
End Sub
Sub VLCVideoview1_onPrepared
	
	VLCVideoview1.SetMediaController(VLCMediaController1)
	CenterVideoView
	
End Sub

Sub CenterVideoView
	
	'just some code to center the videoview
	If GetDeviceLayoutValues.Width < GetDeviceLayoutValues.Height Then 'portrait
			VLCVideoview1.Top = (100%y - VLCVideoview1.Height) / 2
	Else if GetDeviceLayoutValues.Width > GetDeviceLayoutValues.Height Then 'landscape
      	VLCVideoview1.Left = (100%x - VLCVideoview1.Width) / 2
		VLCVideoview1.Top = (100%y - VLCVideoview1.Height) / 2
	End If

End Sub

Sub VLCVideoview1_onError
	Log("SOME ERROR OCCURRED")
End Sub

Sub VLCVideoview1_onCompleted
	Log("VIDEO WAS COMPLETED")
End Sub

Sub VLCMediaController1_onMediaControllerShown
	Log("mediacontroller shown")
End Sub

Sub VLCMediaController1_onMediaControllerHidden
	Log("mediacontroller hidden")
End Sub


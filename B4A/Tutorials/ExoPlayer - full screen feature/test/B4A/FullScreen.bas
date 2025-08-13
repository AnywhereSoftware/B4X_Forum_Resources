B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=11
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: True
	#IncludeTitle: False
#End Region

Sub Process_Globals

End Sub

Sub Globals

	Private SimpleExoPlayerView1 As SimpleExoPlayerView
	Private lblExitFullScreen As B4XView
End Sub

Sub Activity_Create(FirstTime As Boolean)
	If B4XPages.IsInitialized = False Then
		StartActivity(Main)
		Activity.Finish
		Return
	End If
	Activity.LoadLayout("FullScreen")
	SwitchTargetPlayerView(True)
	B4XPages.MainPage.PutLabelInVideoTopRightCorner(SimpleExoPlayerView1, lblExitFullScreen)
End Sub

Private Sub SwitchTargetPlayerView(FullScreenIsDestination As Boolean)
	Dim mp As B4XMainPage = B4XPages.MainPage
	Dim jo As JavaObject
	Dim player As Object = mp.Player.As(JavaObject).GetField("player")
	jo.InitializeStatic("androidx.media3.ui.PlayerView")
	jo.RunMethod("switchTargetView", Array(player, IIf(FullScreenIsDestination, mp.SimpleExoPlayerView1, SimpleExoPlayerView1), IIf(FullScreenIsDestination, SimpleExoPlayerView1, mp.SimpleExoPlayerView1)))
End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)
	SwitchTargetPlayerView(False)
End Sub


Private Sub lblExitFullScreen_Click
	Activity.Finish
End Sub
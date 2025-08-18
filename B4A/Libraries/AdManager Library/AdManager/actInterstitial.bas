B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=10.17
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: True
#End Region

Sub Process_Globals
End Sub

Sub Globals
	Private AdManagerInterstitial1 As AdManagerInterstitial
	Private btnLoad As Button
	Private btnShow As Button
End Sub

Sub Activity_Create(FirstTime As Boolean)
	'***************************************************************************************************************
	'***************************************************************************************************************
	'
	'   CHECK MANIFEST - you should replace "ca-app-pub-3940256099942544~3347511713" in manifest with your APP ID
	'
	'***************************************************************************************************************
	'***************************************************************************************************************
	Activity.LoadLayout("2")
	btnShow.Enabled = False
	AdManagerInterstitial1.Initialize("AdManagerInterstitial1", "/6499/example/interstitial")
End Sub

Sub Activity_Resume
End Sub

Sub Activity_Pause (UserClosed As Boolean)
End Sub

Sub btnLoad_Click
	If AdManagerInterstitial1.IsLoaded = False Then
		AdManagerInterstitial1.LoadPersonalized ' You can use Consent dialog from AdMob library to determine if user is in EEA zone or not.
		'AdManagerInterstitial1.LoadNonPersonalized
	End If
End Sub

Sub btnShow_Click
	If AdManagerInterstitial1.IsLoaded Then
		AdManagerInterstitial1.Show
	End If
End Sub


Sub AdManagerInterstitial1_AdLoaded
	btnLoad.Enabled = False
	btnShow.Enabled = True
	Log("AdLoaded - event fire")
End Sub

Sub AdManagerInterstitial1_AdFailedToLoad (Error As String)
	Log("AdFailedToLoad: " & Error)
End Sub

Sub AdManagerInterstitial1_AdDismissedFullScreenContent
	Log("AdDismissedFullScreenContent - event fire")
End Sub

Sub AdManagerInterstitial1_AdFailedToShowFullScreenContent (Error As String)
	Log("AdFailedToShowFullScreenContent: " & Error)
End Sub

Sub AdManagerInterstitial1_AdShowedFullScreenContent
	btnLoad.Enabled = True
	btnShow.Enabled = False
	Log("AdShowedFullScreenContent - event fire")
End Sub


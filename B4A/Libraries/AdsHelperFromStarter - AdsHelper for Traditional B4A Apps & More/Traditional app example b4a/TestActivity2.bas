B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=11.2
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: True
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.

End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.
	Private iAd As InterstitialAd
	
	Private ButtonActivity2 As Button
End Sub

Sub Activity_Create(FirstTime As Boolean)
	'Do not forget to load the layout file created with the visual designer. For example:
	'Activity.LoadLayout("Layout1")
	Activity.LoadLayout("MainPage")
	ButtonActivity2.Text="Return to Main"
	'-*--*--*--*--*--*--*--*--*--*-
	' you could bypass the events being fired in starter by uncommenting the lines below
'	Starter.Ads.SetRewardedVideoCallbackModule(Me, "RewardAd")
'	Starter.Ads.SetRewardedInterstitialCallbackModule(Me, "RewardedInterstitialAd")
'	Starter.Ads.SetOpenAdCallbackModule(Me, "OpenAd")
	'-*--*--*--*--*--*--*--*--*--*-
End Sub

Sub Activity_Resume
	Starter.AdsSecondaryCallbackModule=Me
	iAd.Initialize("iad", "ca-app-pub-3940256099942544/1033173712")
	iAd.LoadAd
End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub



#Region Button Click Events
Private Sub ButtonShowInterstitial_Click
	If iAd.Ready Then
		iAd.Show
	Else
		Log("no Iad is available")
	End If
	iAd.LoadAd
End Sub

Private Sub ButtonShowRewardedInterstitial_Click
	If Starter.Ads.isAvailableRewardedInterstitialAd Then
		Starter.Ads.ShowRewardedInterstitialAd
	Else
		Log("wait... loading reward ad")
		Starter.Ads.FetchRewardedInterstitialAd("ca-app-pub-3940256099942544/5354046379", Starter, "RewardedInterstitialAd", True)
	End If
End Sub


Private Sub Button_Native_Click
'	B4XPages.ShowPage("B4XNative2")
	StartActivity(NativeActivity)
End Sub

Private Sub Button_RewardedVideo_Click
	If Starter.Ads.isAvailableRewardedVideoAd Then
		Starter.Ads.ShowRewardedVideoAd
	Else
		Log("wait... loading reward ad")
		Starter.Ads.FetchRewardedVideoAd("ca-app-pub-3940256099942544/5224354917", Me, "RewardAd", True)
	End If
End Sub
#End Region



'Open Ad Events
Sub OpenAd_ReceiveAd
	LogColor($"OpenAd_ReceiveAd"$, Colors.Green)
End Sub

Sub OpenAd_FailedToReceiveAd (ErrorCode As String)
	LogColor($"OpenAd_FailedToReceiveAd ErrorCode=${ErrorCode}"$, Colors.Green)
End Sub

'rewarded video ad events
Sub RewardAd_ReceiveAd
	LogColor($"RewardAd_ReceiveAd"$, Colors.Green)
End Sub

Sub RewardAd_FailedToReceiveAd (ErrorCode As String)
	LogColor($"RewardAd_FailedToReceiveAd ErrorCode=${ErrorCode}"$, Colors.Green)
End Sub

Sub RewardAd_Rewarded (Item As Object)
	LogColor("RewardAd_Rewarded",Colors.Green)
	Dim Reward As JavaObject = Item
	Dim Amount As Int = Reward.RunMethod("getAmount", Null)
	Dim RewardType As String = Reward.RunMethod("getType", Null)
	Log("Rewarded: " & Amount & " -> " & RewardType)
End Sub

'rewarded interstitial events
Sub RewardedInterstitialAd_ReceiveAd
	LogColor($"RewardInterstitialAd_ReceiveAd"$, Colors.Green)
End Sub

Sub RewardedInterstitialAd_FailedToReceiveAd (ErrorCode As String)
	LogColor($"RewardedInterstitialAd_FailedToReceiveAd ErrorCode=${ErrorCode}"$, Colors.Green)
End Sub

Sub RewardedInterstitialAd_Rewarded (Item As Object)
	LogColor("RewardedInterstitialAd_Rewarded",Colors.Green)
	Dim Reward As JavaObject = Item
	Dim Amount As Int = Reward.RunMethod("getAmount", Null)
	Dim RewardType As String = Reward.RunMethod("getType", Null)
	Log("Rewarded: " & Amount & " -> " & RewardType)
End Sub

Private Sub ButtonActivity2_Click
	StartActivity(Main)
End Sub
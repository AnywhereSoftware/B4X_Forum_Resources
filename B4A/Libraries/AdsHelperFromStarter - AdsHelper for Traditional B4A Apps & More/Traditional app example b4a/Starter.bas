B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=9.9
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
	#ExcludeFromLibrary: True
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Public RightToLeft As Boolean = False
	Public Ads As AdsHelperFromStarter
	Public AppOpenAdUnit As String = "ca-app-pub-3940256099942544/3419835294"
	Private Ctxt As JavaObject
	
	' the starter service will first receive events from ads helper for 
	' the full screen ad types
	' the AdsSecondaryCallbackModule will allow these events to also be called in another module
	' this could allow you to take some custom specific action in that module
	Public AdsSecondaryCallbackModule As Object 
	' you could bypass calling events in this module (starter) by
	' Starter.Ads.SetRewardedVideoCallbackModule(Me, "RewardAd")
End Sub

Sub Service_Create
	'This is the program entry point.
	'This is a good place to load resources that are not specific to a single activity.
	
	Ads.Initialize
	Ctxt.InitializeContext
	Ads.SetCallbackModuleForFullScreenAds(Me)
	Ads.FetchRewardedInterstitialAd("ca-app-pub-3940256099942544/5354046379", Me, "RewardedInterstitialAd", True)
	Ads.FetchRewardedVideoAd("ca-app-pub-3940256099942544/5224354917", Me, "RewardAd", True)
	Ads.FetchOpenAd(AppOpenAdUnit, Me, "OpenAd", True, True)
End Sub

Sub Service_Start (StartingIntent As Intent)
	Service.StopAutomaticForeground 'Starter service can start in the foreground state in some edge cases.
End Sub

Sub Service_TaskRemoved
	'This event will be raised when the user removes the app from the recent apps list.
End Sub

'Return true to allow the OS default exceptions handler to handle the uncaught exception.
Sub Application_Error (Error As Exception, StackTrace As String) As Boolean
	Return True
End Sub

Sub Service_Destroy

End Sub

'call this from main if they are using landscape mode
Sub LoadLandscapeOpenAd
	Ads.FetchOpenAd(AppOpenAdUnit, Me, "OpenAd", False, True)
End Sub

Sub CheckCallAdEventInSecondaryModule(Event As String)
	If Not(AdsSecondaryCallbackModule = Null) And SubExists(AdsSecondaryCallbackModule, Event) Then CallSubDelayed(AdsSecondaryCallbackModule, Event)
End Sub

Sub CheckCallAdEventInSecondaryModule2(Event As String, Param As Object)
	If Not(AdsSecondaryCallbackModule = Null) And SubExists(AdsSecondaryCallbackModule, Event) Then CallSubDelayed2(AdsSecondaryCallbackModule, Event, Param)
End Sub

'Open Ad Events
Sub OpenAd_ReceiveAd
	LogColor($"OpenAd_ReceiveAd"$, Colors.Green)
	CheckCallAdEventInSecondaryModule("OpenAd_ReceiveAd")
End Sub

Sub OpenAd_FailedToReceiveAd (ErrorCode As String)
	LogColor($"OpenAd_FailedToReceiveAd ErrorCode=${ErrorCode}"$, Colors.Green)
	CheckCallAdEventInSecondaryModule2("OpenAd_FailedToReceiveAd", ErrorCode)
End Sub

Sub OpenAd_Closed
	LogColor($"OpenAd_Closed"$, Colors.Green)
	CheckCallAdEventInSecondaryModule("OpenAd_Closed")
End Sub

'rewarded video ad events
Sub RewardAd_ReceiveAd
	LogColor($"RewardAd_ReceiveAd"$, Colors.Green)
	CheckCallAdEventInSecondaryModule("RewardAd_ReceiveAd")
End Sub

Sub RewardAd_FailedToReceiveAd (ErrorCode As String)
	LogColor($"RewardAd_FailedToReceiveAd ErrorCode=${ErrorCode}"$, Colors.Green)
	CheckCallAdEventInSecondaryModule2("RewardAd_FailedToReceiveAd", ErrorCode)
End Sub

Sub RewardAd_Rewarded (Item As Object)
	LogColor("RewardAd_Rewarded",Colors.Green)
	Dim Reward As JavaObject = Item
	Dim Amount As Int = Reward.RunMethod("getAmount", Null)
	Dim RewardType As String = Reward.RunMethod("getType", Null)
	Log("Rewarded: " & Amount & " -> " & RewardType)
	CheckCallAdEventInSecondaryModule2("RewardAd_Rewarded", Item)
End Sub

Sub RewardedAd_Dismissed(Rewarded As Boolean)
	LogColor($"Rewarded Video RewardedAd_Dismissed Rewarded=${Rewarded}"$, Colors.Green)
	CheckCallAdEventInSecondaryModule2("RewardAd_Dismissed", Rewarded)
End Sub

'rewarded interstitial events
Sub RewardedInterstitialAd_ReceiveAd
	LogColor($"RewardedInterstitialAd_ReceiveAd"$, Colors.Green)
	CheckCallAdEventInSecondaryModule("RewardedInterstitialAd_ReceiveAd")
End Sub

Sub RewardedInterstitialAd_FailedToReceiveAd (ErrorCode As String)
	LogColor($"RewardedInterstitialAd_FailedToReceiveAd ErrorCode=${ErrorCode}"$, Colors.Green)
	CheckCallAdEventInSecondaryModule2("RewardInterstitialAd_FailedToReceiveAd", ErrorCode)
End Sub

Sub RewardedInterstitialAd_Rewarded (Item As Object)
	LogColor("RewardedInterstitialAd_Rewarded",Colors.Green)
	Dim Reward As JavaObject = Item
	Dim Amount As Int = Reward.RunMethod("getAmount", Null)
	Dim RewardType As String = Reward.RunMethod("getType", Null)
	Log("Rewarded: " & Amount & " -> " & RewardType)
	CheckCallAdEventInSecondaryModule2("RewardedInterstitialAd_Rewarded", Item)
End Sub

Sub RewardedInterstitialAd_Dismissed(Rewarded As Boolean)
	LogColor($"RewardedInterstitialAd_Dismissed Rewarded=${Rewarded}"$, Colors.Green)
	CheckCallAdEventInSecondaryModule2("RewardedInterstitialAd_Dismissed", Rewarded)
End Sub
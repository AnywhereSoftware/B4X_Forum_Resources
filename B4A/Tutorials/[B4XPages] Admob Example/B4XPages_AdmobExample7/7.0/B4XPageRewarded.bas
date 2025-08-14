B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=12.5
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
End Sub

'You can add more parameters here.
Public Sub Initialize As Object	
	Return Me
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	'load the layout to Root
	
	
	B4XPages.MainPage.Ads.FetchRewardedVideoAd("ca-app-pub-3940256099942544/5224354917", Me, "RewardAd")
'	Ads.FetchRewardedInterstitialAd("ca-app-pub-3940256099942544/5354046379", Me, "RewardedInterstitialAd")
	
	
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.


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
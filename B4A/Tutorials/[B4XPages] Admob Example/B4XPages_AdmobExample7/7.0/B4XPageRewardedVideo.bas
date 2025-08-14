B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=12.5
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	Private Button1 As B4XView
	Private LabelTrophy As B4XView
End Sub

'You can add more parameters here.
Public Sub Initialize As Object	
	Return Me
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	'load the layout to Root
	Root.LoadLayout("LayAdmob3")
	
	Button1.Text = "Show video and get reward"
End Sub

'resume
Sub B4XPage_Appear
	'reload reward video when show the screen again
	B4XPages.MainPage.Ads.FetchRewardedVideoAd("ca-app-pub-3940256099942544/5224354917", Me, "RewardVideoAd")
End Sub

' pause
Sub B4XPage_Disappear
	Button1.Text = "Show video and get reward"
	
	LabelTrophy.TextColor = xui.Color_LightGray
End Sub
'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

'rewarded video ad events
Sub RewardAd_RewardVideoAd
	ToastMessageShow("RewardVideoAd_ReceiveAd", False)
	LogColor($"RewardVideoAd_ReceiveAd"$, Colors.Green)
End Sub

Sub RewardVideoAd_FailedToReceiveAd (ErrorCode As String)
	LogColor($"RewardVideoAd_FailedToReceiveAd ErrorCode=${ErrorCode}"$, Colors.Green)
End Sub

Sub RewardVideoAd_Rewarded (Item As Object)
	LogColor("RewardVideoAd_Rewarded",Colors.Green)
	Dim Reward As JavaObject = Item
	Dim Amount As Int = Reward.RunMethod("getAmount", Null)
	Dim RewardType As String = Reward.RunMethod("getType", Null)
	Log("Rewarded: " & Amount & " -> " & RewardType)
	
	LabelTrophy.TextColor = xui.Color_Blue
	Button1.Text = "REWARDED"
End Sub

Private Sub Button1_Click
	If B4XPages.MainPage.Ads.isAvailableRewardedVideoAd = False Then
		Log("wait... loading reward ad")		
		ProgressDialogShow("Loading Ad...")
		B4XPages.MainPage.Ads.FetchRewardedVideoAd("ca-app-pub-3940256099942544/5224354917", Me, "RewardVideoAd")
		Sleep(2000)
		ProgressDialogHide
	End If

	B4XPages.MainPage.Ads.ShowRewardedVideoAd	
End Sub
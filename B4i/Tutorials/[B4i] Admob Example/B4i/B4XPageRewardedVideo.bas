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
	
	Dim hud As HUD
	
	Private rew As RewardedVideoAd
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
	
	rew.Initialize("RewardVideoAd")
	rew.LoadAd("ca-app-pub-3940256099942544/1712485313")
End Sub

'resume
Sub B4XPage_Appear
	'reload reward video when show the screen again
End Sub

' pause
Sub B4XPage_Disappear
	Button1.Text = "Show video and get reward"
	
	LabelTrophy.TextColor = xui.Color_LightGray
End Sub
'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Sub RewardVideoAd_AdOpened
	Log("ad opened")
End Sub

'rewarded video ad events
Sub RewardVideoAd_ReceiveAd
	LogColor($"RewardVideoAd_ReceiveAd"$, Colors.Green)
End Sub

Sub RewardVideoAd_FailedToReceiveAd (ErrorCode As String)
	LogColor($"RewardVideoAd_FailedToReceiveAd ErrorCode=${ErrorCode}"$, Colors.Green)
End Sub

Sub RewardVideoAd_Rewarded (Item As Object)
	LogColor("RewardVideoAd_Rewarded",Colors.Green)
	LabelTrophy.TextColor = xui.Color_Blue
	Button1.Text = "REWARDED"
End Sub

Private Sub Button1_Click
	Log("wait... loading reward ad")		
	hud.ProgressDialogShow("Loading Ad...")
	Sleep(2000)
	hud.ProgressDialogHide

	If rew.Ready Then rew.Show(B4XPages.GetNativeParent(Me))
End Sub
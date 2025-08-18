B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=10.5
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: False
#End Region

Sub Process_Globals

End Sub
Sub Globals
		Dim RewardedAd As RewardedAd
End Sub
Sub Activity_Create(FirstTime As Boolean)
		ProgressDialogShow2("Loading Ad...",False)
		LoadRewardedAd
End Sub
Sub Activity_Resume

End Sub
Sub Activity_Pause (UserClosed As Boolean)

End Sub


Sub LoadRewardedAd
		RewardedAd.Initialize("RewardedAd")
		RewardedAd.LoadAd("ca-app-pub-3940256099942544/5224354917")
End Sub
Sub RewardedAd_onRewardedAdLoaded(Item As RewardItem)
		ProgressDialogHide
		Log($"RewardedAd_onRewardedAdLoaded, Type: ${Item.Type}, Amount: ${Item.Amount}"$)
		If RewardedAd.IsLoaded Then RewardedAd.Show
End Sub
Sub RewardedAd_onRewardedAdFailedToLoad (ErrorCode As Int)
		ProgressDialogHide
		Log($"RewardedAd_onRewardedAdFailedToLoad, ErrorCode: ${ErrorCode}"$)
End Sub
Sub RewardedAd_onRewardedAdOpened
		Log("RewardedAd_onRewardedAdOpened")
End Sub
Sub RewardedAd_onRewardedAdFailedToShow (ErrorCode As Int)
		Log($"RewardedAd_onRewardedAdFailedToShow, ErrorCode: ${ErrorCode}"$)
End Sub
Sub RewardedAd_onUserEarnedReward (Item As RewardItem)
		Log($"RewardedAd_onUserEarnedReward, Type: ${Item.Type}, Amount: ${Item.Amount}"$)
End Sub
Sub RewardedAd_onRewardedAdClosed
		Log("RewardedAd_onRewardedAdClosed")
End Sub





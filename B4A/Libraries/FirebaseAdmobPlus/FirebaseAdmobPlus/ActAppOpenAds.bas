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
		Dim AppOpenAds As AppOpenAds
End Sub
Sub Activity_Create(FirstTime As Boolean)
		ProgressDialogShow2("Loading Ad...",False)
		LoadAppOpenAds
End Sub
Sub Activity_Resume

End Sub
Sub Activity_Pause (UserClosed As Boolean)

End Sub


Sub LoadAppOpenAds
		AppOpenAds.Initialize("AppOpenAds")
		AppOpenAds.LoadAd(AppOpenAds.APP_OPEN_AD_ORIENTATION_PORTRAIT,"ca-app-pub-3940256099942544/3419835294")
End Sub
Sub AppOpenAds_onAppOpenAdLoaded
		ProgressDialogHide
		Log("AppOpenAds_onAppOpenAdLoaded")
		AppOpenAds.Show
End Sub
Sub AppOpenAds_onAppOpenAdFailedToLoad(ErrorCode As Int)
		ProgressDialogHide
		Log($"AppOpenAds_onAppOpenAdFailedToLoad, ErrorCode: ${ErrorCode}"$)
End Sub
Sub AppOpenAds_onAdShowedFullScreenContent
		Log("AppOpenAds_onAdShowedFullScreenContent")
End Sub
Sub AppOpenAds_onAdDismissedFullScreenContent
		Log("AppOpenAds_onAdDismissedFullScreenContent")
End Sub
Sub AppOpenAds_onAdFailedToShowFullScreenContent(ErrorCode As Int)
		Log($"AppOpenAds_onAdFailedToShowFullScreenContent, ErrorCode: ${ErrorCode}"$)
End Sub


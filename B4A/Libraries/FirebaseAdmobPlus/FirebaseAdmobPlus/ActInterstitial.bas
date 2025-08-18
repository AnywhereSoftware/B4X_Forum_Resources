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
		Dim InterstitialAd As InterstitialAd
End Sub
Sub Activity_Create(FirstTime As Boolean)
		ProgressDialogShow2("Loading Ad...",False)
		LoadInterstitialAd
End Sub
Sub Activity_Resume

End Sub
Sub Activity_Pause (UserClosed As Boolean)

End Sub



Sub LoadInterstitialAd
		InterstitialAd.Initialize("InterstitialAd")
		InterstitialAd.LoadAd("ca-app-pub-3940256099942544/1033173712")
End Sub
Sub InterstitialAd_onAdLoaded
		ProgressDialogHide
		Log("InterstitialAd_onAdLoaded")
		If InterstitialAd.isLoaded Then InterstitialAd.Show
End Sub
Sub InterstitialAd_onAdFailedToLoad (ErrorCode As Int)
		ProgressDialogHide
		Log($"InterstitialAd_onAdFailedToLoad, ErrorCode: ${ErrorCode}"$)
End Sub
Sub InterstitialAd_onAdOpened
		Log("InterstitialAd_onAdOpened")	
End Sub
Sub InterstitialAd_onAdClosed
		Log("InterstitialAd_onAdClosed")
End Sub
Sub InterstitialAd_onAdLeftApplication
		Log("InterstitialAd_onAdLeftApplication")
End Sub
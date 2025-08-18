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
	
End Sub
Sub Activity_Create(FirstTime As Boolean)
		ProgressDialogShow2("Loading Ad...",False)
		LoadAdaptiveBanner
End Sub
Sub Activity_Resume

End Sub
Sub Activity_Pause (UserClosed As Boolean)

End Sub


Sub LoadAdaptiveBanner
		Dim AdaptiveBanner As AdView
			AdaptiveBanner.Initialize("AdaptiveBanner","ca-app-pub-3940256099942544/6300978111",AdaptiveBanner.CreateAdaptiveSize(100%x))
			Activity.AddView(AdaptiveBanner,0,0,100%x,AdaptiveBanner.MeasureAdaptiveBannerHeight(100%x))
			AdaptiveBanner.LoadAd	
End Sub
Sub AdaptiveBanner_onAdLoaded
		ProgressDialogHide
		Log("AdaptiveBanner_onAdLoaded")	
End Sub
Sub AdaptiveBanner_onAdFailedToLoad (ErrorCode As Int)
		ProgressDialogHide
		Log($"AdaptiveBanner_onAdFailedToLoad, ErrorCode: ${ErrorCode}"$)
End Sub
Sub AdaptiveBanner_onAdOpened
		Log("AdaptiveBanner_onAdOpened")	
End Sub
Sub AdaptiveBanner_onAdLeftApplication
		Log("AdaptiveBanner_onAdLeftApplication")	
End Sub
Sub AdaptiveBanner_onAdClicked
		Log("AdaptiveBanner_onAdClicked")	
End Sub
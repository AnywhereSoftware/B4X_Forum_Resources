B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=10.7
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: True
#End Region

Sub Process_Globals
End Sub

Sub Globals
	Private IronSourceAds1 As IronSourceAds
	Private IronSourceAdsInterstitial1 As IronSourceAdsInterstitial	
	Private btnLoadAd As Button
	Private btnShowAd As Button
End Sub

Sub Activity_Create(FirstTime As Boolean)
	Activity.LoadLayout("layInter")
	IronSourceAds1.Initialize("85460dcd")  '85460dcd = Test AppKey
	IronSourceAdsInterstitial1.InitializeInterstitial("IronSourceAdsInterstitial1")
End Sub

Sub Activity_Resume
End Sub

Sub Activity_Pause (UserClosed As Boolean)
End Sub

Private Sub btnLoadAd_Click
	IronSourceAdsInterstitial1.LoadAd
End Sub

Private Sub btnShowAd_Click
	If IronSourceAdsInterstitial1.IsReady Then
		IronSourceAdsInterstitial1.ShowAd
	Else
		Log("Ad not ready.")
	End If
	
End Sub

Sub IronSourceAdsInterstitial1_InterstitialAdReady
	' Invoked when Interstitial Ad is ready to be shown after load function was called.
	Log("InterstitialAdReady")
End Sub

Sub IronSourceAdsInterstitial1_InterstitialAdClicked
	' Invoked when the end user clicked on the interstitial ad.
	Log("InterstitialAdClicked")
End Sub

Sub IronSourceAdsInterstitial1_InterstitialAdClosed
	' Invoked when the ad is closed and the user is about to return to the application.
	Log("InterstitialAdClosed")
End Sub

Sub IronSourceAdsInterstitial1_InterstitialAdLoadFailed (Error As String)
	' Invoked when there is no Interstitial Ad available after calling load function.
	Log(Error)
End Sub

Sub IronSourceAdsInterstitial1_InterstitialAdOpened
	' Invoked when the Interstitial Ad Unit is opened
	Log("InterstitialAdOpened")
End Sub

Sub IronSourceAdsInterstitial1_InterstitialAdShowFailed (Error As String)
	' Invoked when Interstitial ad failed to show
	Log(Error)
End Sub

Sub IronSourceAdsInterstitial1_InterstitialAdShowSucceeded
	' Invoked right before the Interstitial screen is about to open.
	' NOTE - This event Is available only For some of the networks. You should Not treat this event As an interstitial impression, but rather use InterstitialAdOpenedEvent
	Log("InterstitialAdShowSucceeded")
End Sub


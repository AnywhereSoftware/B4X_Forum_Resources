B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=10
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: True
#End Region

Sub Process_Globals
End Sub

Sub Globals
	Private UnityAdsBanner As UnityAdsBanner
End Sub

Sub Activity_Create(FirstTime As Boolean)
	Activity.Title = "Banner Ads Example"
	
	UnityAdsBanner.InitializeBanner("BannerAd", "3054608", True, "banner")
	Activity.AddView(UnityAdsBanner, 100%x/2-160dip, 0, 320dip, 50dip)
	
'	UnityAdsBanner.InitializeBanner300x250("BannerAd", "3054608", True, "banner")
'	Activity.AddView(UnityAdsBanner, 100%x/2-150dip, 0, 300dip, 250dip)
	
'	UnityAdsBanner.InitializeBanner300x300("BannerAd", "3054608", True, "banner")
'	Activity.AddView(UnityAdsBanner, 100%x/2-150dip, 0, 300dip, 300dip)
	
'	UnityAdsBanner.InitializeBanner450x450("BannerAd", "3054608", True, "banner")
'	Activity.AddView(UnityAdsBanner, 100%x/2-225dip, 0, 450dip, 450dip)
End Sub

Sub Activity_Resume
End Sub

Sub Activity_Pause (UserClosed As Boolean)
End Sub

Sub BannerAd_OnInitializationComplete
	Log ("OnInitializationComplete event")
	UnityAdsBanner.LoadBanner
End Sub

Sub BannerAd_OnInitializationFailed (Error As String)
	Log ("OnInitializationFailed: " & Error)
End Sub

Sub BannerAd_OnBannerLoaded
	' Called when the banner is loaded.
	Log ("OnBannerLoaded event")
End Sub

Sub BannerAd_OnBannerFailedToLoad (Error As String)
	' Note that the Error can indicate a no fill (see API documentation). Doc: https://docs.unity3d.com/Packages/com.unity.ads@3.4/manual/MonetizationResourcesApiAndroid.html#bannerview
	Log (Error)
End Sub

Sub BannerAd_OnBannerClick
	' Called when a banner is clicked.
	Log ("OnBannerClick event")
End Sub


Sub BannerAd_OnBannerLeftApplication
	' Called when the banner links out of the application.
	Log ("OnBannerLeftApplication event")
End Sub
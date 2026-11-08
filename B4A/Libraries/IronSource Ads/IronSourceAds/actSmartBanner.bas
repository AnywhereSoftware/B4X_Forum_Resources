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
	Private SmartBannerHeight As Int
End Sub

Sub Activity_Create(FirstTime As Boolean)
	Activity.Title = "Smart Banner"
	IronSourceAds1.Initialize("85460dcd")  '85460dcd = Test AppKey
	Dim ScreenHeightScaled As Float
	ScreenHeightScaled = GetDeviceLayoutValues.Height / GetDeviceLayoutValues.Scale
	If ScreenHeightScaled <= 720 Then
		SmartBannerHeight = 50dip
		Log("SmartBannerHeight = 50dip")
	Else if ScreenHeightScaled > 720 Then
		SmartBannerHeight = 90dip
		Log("SmartBannerHeight = 90dip")
	End If
End Sub

Sub Activity_Resume
	IronSourceAds1.InitializeBanner("IronSourceAds1", IronSourceAds1.AD_SMART)
	Activity.AddView(IronSourceAds1, 0, 0, 100%x, SmartBannerHeight)
	IronSourceAds1.LoadBanner
End Sub

Sub Activity_Pause (UserClosed As Boolean)
	IronSourceAds1.RemoveView
	IronSourceAds1.DestroyBanner
End Sub

Sub IronSourceAds1_AdClicked
	' Called after a banner has been clicked.
	Log("AdClicked")
End Sub

Sub IronSourceAds1_AdLeftApplication
	' Called when a user would be taken out of the application context.
	Log("AdLeftApplication")
End Sub

Sub IronSourceAds1_AdLoaded
	' Called after a banner ad has been successfully loaded
	Log("AdLoaded")
End Sub

Sub IronSourceAds1_AdLoadFailed (Error As String)
	' Called after a banner has attempted to load an ad but failed.
	Log(Error)
End Sub

Sub IronSourceAds1_AdScreenDismissed
	' Called after a full screen content has been dismissed
	Log("AdScreenDismissed")
End Sub

Sub IronSourceAds1_AdScreenPresented
	' Called when a banner is about to present a full screen content.
	Log("AdScreenPresented")
End Sub




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
	Private AdColony As AdColonyBanner

End Sub

Sub Activity_Create(FirstTime As Boolean)
	Activity.Title = "Banner"
	
	'GDPR, COPPA, CCPA https://github.com/AdColony/AdColony-Android-SDK/wiki/Privacy-Laws
	AdColony.InitializeBanner("AdColony", "app185a7e71e1714831a49ec7", "vz785bc8d42d9c43fdaf", False, "1", False, "1", False, "1")
	AdColony.RequestBannerAd(AdColony.AD_BANNER) 'For AdSize dimensions please check: https://www.adcolony.com/blog/2019/10/02/choosing-the-right-display-format-for-your-app/
End Sub

Sub Activity_Resume
End Sub

Sub Activity_Pause (UserClosed As Boolean)
	If UserClosed Then
		AdColony.Destroy
	End If
End Sub

Sub AdColony_OnRequestFilled
	Log("OnRequestFilled")
	' Remove view before adding new one.
	' Before removal you must check IsInitialized. If you don't check you may expect crashes in some edge cases.
	If AdColony.IsInitialized Then
		AdColony.RemoveView
	End If
	' You must add view in this event.
	' IsInitialized check before AddView. If you don't check you may expect crashes in some edge cases.
	If AdColony.IsInitialized Then
		Activity.AddView(AdColony, 50%x-160dip, 0, 320dip, 50dip)
	End If		
End Sub

Sub AdColony_OnClicked
	Log("OnClicked")
End Sub

Sub AdColony_OnClosed
	Log("OnClosed")
End Sub

Sub AdColony_OnLeftApplication
	Log("OnLeftApplication")
End Sub

Sub AdColony_OnOpened
	Log("OnOpened")
End Sub

Sub AdColony_OnRequestNotFilled
	Log("OnRequestNotFilled")
End Sub
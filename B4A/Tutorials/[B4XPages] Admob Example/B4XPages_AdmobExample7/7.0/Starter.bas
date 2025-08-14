B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=7.8
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
	#ExcludeFromLibrary: True
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
'	Public consent As ConsentManager

	Dim rewarded_item As Int = 0 'used in rewarded ad
	
	Type AdSize (Native As Object, Width As Int, Height As Int) 'there are another option using AdsHelper class
	Type AdInlineSize (Inline As Object, Width As Int, Height As Int) 
	
'	Public Ads As AdsHelper
End Sub

Sub Service_Create
	'This is the program entry point.
	'This is a good place to load resources that are not specific to a single activity.
		
'	Ads.Initialize
'	CheckConsentAndAddAds
End Sub

Sub Service_Start (StartingIntent As Intent)

End Sub

Sub Service_TaskRemoved
	'This event will be raised when the user removes the app from the recent apps list.
End Sub

'Return true to allow the OS default exceptions handler to handle the uncaught exception.
Sub Application_Error (Error As Exception, StackTrace As String) As Boolean
	Return True
End Sub

Sub Service_Destroy

End Sub

'Private Sub CheckConsentAndAddAds
'	Try
'		Dim m As MobileAds
'		Wait For (m.Initialize) MobileAds_Ready
''	m.SetConfiguration(m.CreateRequestConfigurationBuilder(Array("0BAB27F6EE97F9B5FA3B8C59548E8A34"))) 'optional. Array with test device ids. See unfiltered logs to find correct id.
'		m.SetConfiguration(m.CreateRequestConfigurationBuilder(Array("528A88F244A0246D2B5B12A725C04D19")))'	Catch
'	Catch
'		Log(LastException)
'	End Try
'	
''	'Mute Ad Sound
''	Dim jo As JavaObject
''	jo.InitializeStatic("com.google.android.gms.ads.MobileAds")
''	jo.RunMethod("setAppMuted", Array(True))
'	
''	'EXAMPLE code to ADJUST VOLUME level - remove the "setAppMuted" line above
''	Dim volume As Float = 0.5
''	jo.RunMethod("setAppVolume", Array(volume))
'	
'	Ads.ResetConsentStatus
''	Ads.SetConsentDebugParameters("0BAB27F6EE97F9B5FA3B8C59548E8A34", True) 'same id as above
'	Ads.SetConsentDebugParameters("528A88F244A0246D2B5B12A725C04D19", True) 'same id as above
'	
'	If Ads.GetConsentStatus = "UNKNOWN" Or Ads.GetConsentStatus = "REQUIRED" Then
'		Wait For (Ads.RequestConsentInformation(False)) Complete (Success As Boolean)
'	End If
'	
'	If Ads.GetConsentStatus = "REQUIRED" And Ads.GetConsentFormAvailable Then
'		Wait For (Ads.ShowConsentForm) Complete (Success As Boolean)
'	End If
'	
'	Log("Consent: " & Ads.GetConsentStatus)
'	
''	Dim AdaptiveSize As Map = Ads.GetAdaptiveAdSize
''	
''	Dim size As AdSize = Utils.GetAdaptiveAdSize
'	
''	Test Ads
''	https://developers.google.com/admob/android/test-ads
'
''	BannerAdView1.Initialize2("BannerAdView1","ca-app-pub-3940256099942544/6300978111", AdaptiveSize.Get("native"))
''	Root.AddView(BannerAdView1, 0, 100%y - size.Height, 100%x, size.Height)
''	BannerAdView1.LoadAd
''	
''	'Interstitial that's show when click the button "Interstitial"
''	mwAdInterstitial.Initialize("mwadi","ca-app-pub-3940256099942544/1033173712")  'TEST AD UNIT
''	mwAdInterstitial.LoadAd
''	
''	Ads.FetchOpenAd(AppOpenAdUnit)
'End Sub
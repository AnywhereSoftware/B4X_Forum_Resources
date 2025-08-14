B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.7
@EndOfDesignText@
'V1.01
Sub Class_Globals
	Private AppOpenAdCallback, AppOpenAdFullScreenCallback As JavaObject
	Private ctxt As JavaObject
	Private LastBackgroundTime As Long
	Private ConsentInformation As JavaObject
	Private ConsentDebugSettings As JavaObject
End Sub

Public Sub Initialize
	ctxt.InitializeContext
	Dim UserMessagingPlatform As JavaObject
	UserMessagingPlatform.InitializeStatic("com.google.android.ump.UserMessagingPlatform")
	ConsentInformation = UserMessagingPlatform.RunMethod("getConsentInformation", Array(ctxt))
End Sub

'Returns a Map with the following keys: height, width and native (native = AdSize).
Public Sub GetAdaptiveAdSize As Map
	Dim ctxt As JavaObject
	ctxt.InitializeContext
	Dim AdSize As JavaObject
	Dim width As Int = 100%x / GetDeviceLayoutValues.Scale
	Dim Native As JavaObject = AdSize.InitializeStatic("com.google.android.gms.ads.AdSize").RunMethod("getCurrentOrientationAnchoredAdaptiveBannerAdSize", Array(ctxt, width))
	Return CreateMap("native": Native, "width": Native.RunMethod("getWidthInPixels", Array(ctxt)), _
        "height": Native.RunMethod("getHeightInPixels", Array(ctxt)))
End Sub

'Should be called once. An infinite loop that checks for an AppOpenAd when needed.
Public Sub FetchOpenAd (AppOpenAdUnit As String)
	Dim AppOpenAd As JavaObject
	AppOpenAd.InitializeStatic("com.google.android.gms.ads.appopen.AppOpenAd")
	AppOpenAdCallback.InitializeNewInstance(Application.PackageName & ".adshelper$MyAddOpenAdCallback", Null)
	AppOpenAdFullScreenCallback.InitializeNewInstance(Application.PackageName & ".adshelper$MyFullScreenContentCallback", Null)
	Do While True
		If AppOpenAdCallback.GetField("ad") = Null Then
			AppOpenAd.RunMethod("load", Array(ctxt, AppOpenAdUnit, GetAdRequest, AppOpenAdCallback))
		End If
		Sleep(60000)
	Loop
End Sub

Private Sub GetAdRequest As Object
	Dim builder As AdRequestBuilder
	builder.Initialize
	Dim jo As JavaObject = builder
	Return jo.RunMethod("build", Null)
End Sub



'Should be called from B4XPage_Foreground.
Public Sub ShowOpenAdIfAvailable
	If AppOpenAdCallback.IsInitialized = False Then Return
	If AppOpenAdFullScreenCallback.GetField("isShowingAd") = True Then Return
	'don't show an ad if less than 2 minutes in background
	If LastBackgroundTime + 2 * DateTime.TicksPerMinute > DateTime.Now Then Return
	Dim ad As JavaObject = AppOpenAdCallback.GetField("ad")
	If ad.IsInitialized Then
		ad.RunMethod("setFullScreenContentCallback", Array(AppOpenAdFullScreenCallback))
		ad.RunMethod("show", Array(ctxt))
		AppOpenAdCallback.SetField("ad", Null)
	End If
End Sub

'Resets the ConsentInformation to initialized status. This should only used for debugging. 
Public Sub ResetConsentStatus
	Log("Consent information is being reset!")
	ConsentInformation.RunMethod("reset", Null)
End Sub

'Should be called from B4XPage_Background
Public Sub Background
	LastBackgroundTime = DateTime.Now
End Sub

'Returns one of the following values: NOT_REQUIRED, REQUIRED, OBTAINED, UNKNOWN
Public Sub GetConsentStatus As String
	Dim statuses As Map = CreateMap(1: "NOT_REQUIRED", 2: "REQUIRED", 3: "OBTAINED", 0: "UNKNOWN")
	Dim status As Int = ConsentInformation.RunMethod("getConsentStatus", Null)
	Return statuses.GetDefault(status, "UNKNOWN")
End Sub

'Returns one of the following values: NON_PERSONALIZED, PERSONALIZED, UNKNOWN
Public Sub GetConsentType As String
	Dim statuses As Map = CreateMap(1: "NON_PERSONALIZED", 2: "PERSONALIZED", 0: "UNKNOWN")
	Dim status As Int = ConsentInformation.RunMethod("getConsentType", Null)
	Return statuses.GetDefault(status, "UNKNOWN")
End Sub

Public Sub GetConsentFormAvailable As Boolean
	Return ConsentInformation.RunMethod("isConsentFormAvailable", Null)
End Sub

'TagForUnderAgeOfConsent - False means users are not underage.
Public Sub RequestConsentInformation (TagForUnderAgeOfConsent As Boolean) As ResumableSub
	Dim ConsentRequestParameters As JavaObject
	ConsentRequestParameters.InitializeNewInstance("com.google.android.ump.ConsentRequestParameters$Builder", Null)
	ConsentRequestParameters.RunMethod("setTagForUnderAgeOfConsent", Array(TagForUnderAgeOfConsent))
	If ConsentDebugSettings.IsInitialized Then
		ConsentRequestParameters.RunMethod("setConsentDebugSettings", Array(ConsentDebugSettings))
	End If
	Dim callback1 As Object = ConsentInformation.CreateEventFromUI("com.google.android.ump.ConsentInformation$OnConsentInfoUpdateSuccessListener", _
		"callback", Null)
	Dim callback2 As Object = ConsentInformation.CreateEventFromUI("com.google.android.ump.ConsentInformation$OnConsentInfoUpdateFailureListener", _
		"callback", Null)
	ConsentInformation.RunMethod("requestConsentInfoUpdate", Array(ctxt, ConsentRequestParameters.RunMethod("build", Null), callback1, callback2))
	Wait For Callback_Event (MethodName As String, Args() As Object)
	If MethodName = "onConsentInfoUpdateFailure" Then
		Dim FormError As JavaObject = Args(0)
		Log("onConsentInfoUpdateFailure: " & FormError.RunMethod("getMessage", Null) & ", code: " & FormError.RunMethod("getErrorCode", Null))
		Return False
	Else if MethodName = "onConsentInfoUpdateSuccess" Then
		Log("onConsentInfoUpdateSuccess")
		Return True
	End If
	Return False
End Sub

Public Sub SetConsentDebugParameters (TestId As String, InEEA As Boolean)
	Log("Consent debug parameters are being set. Don't forget to remove before production.")
	ConsentDebugSettings.InitializeNewInstance("com.google.android.ump.ConsentDebugSettings$Builder", Array(ctxt))
	Dim geo As Int
	If InEEA Then geo = 1 Else geo = 2
	ConsentDebugSettings.RunMethod("setDebugGeography", Array(geo))
	ConsentDebugSettings.RunMethod("addTestDeviceHashedId", Array(TestId))
	ConsentDebugSettings = ConsentDebugSettings.RunMethod("build", Null)
End Sub

Public Sub ShowConsentForm As ResumableSub
	Dim UserMessagingPlatform As JavaObject
	UserMessagingPlatform.InitializeStatic("com.google.android.ump.UserMessagingPlatform")
	Dim callback1 As Object = UserMessagingPlatform.CreateEventFromUI("com.google.android.ump.UserMessagingPlatform$OnConsentFormLoadSuccessListener", _
		"callback", Null)
	Dim callback2 As Object = UserMessagingPlatform.CreateEventFromUI("com.google.android.ump.UserMessagingPlatform$OnConsentFormLoadFailureListener", _
		"callback", Null)
	UserMessagingPlatform.RunMethod("loadConsentForm", Array(ctxt, callback1, callback2))
	Wait For Callback_Event (MethodName As String, Args() As Object)
	If MethodName = "onConsentFormLoadFailure" Then
		Dim FormError As JavaObject = Args(0)
		Log("onConsentFormLoadFailure: " & FormError.RunMethod("getMessage", Null) & ", code: " & FormError.RunMethod("getErrorCode", Null))
	Else if MethodName = "onConsentFormLoadSuccess" Then
		Dim form As JavaObject = Args(0)
		Dim listener As Object = form.CreateEventFromUI("com.google.android.ump.ConsentForm$OnConsentFormDismissedListener", "callback", Null)
		form.RunMethod("show", Array(ctxt, listener))
		Wait For Callback_Event (MethodName As String, Args() As Object)
		Log("consent form dismissed")
	End If
	Return True
End Sub

#if java
import com.google.android.gms.ads.appopen.*;
import com.google.android.gms.ads.appopen.AppOpenAd.*;
import com.google.android.gms.ads.FullScreenContentCallback;
import com.google.android.gms.ads.*;
public static class MyAddOpenAdCallback extends AppOpenAdLoadCallback {
	public AppOpenAd ad;
	@Override
	public void onAdFailedToLoad(LoadAdError adError) {
		BA.Log("Failed to load OpenAd: " + adError);
	}
	 @Override
    public void onAdLoaded(AppOpenAd ad) {
		BA.Log("OpenAd received");
		this.ad = ad;
	}
	
}
public static class MyFullScreenContentCallback extends FullScreenContentCallback {
	public boolean isShowingAd;	
	@Override
    public void onAdDismissedFullScreenContent() {
		BA.Log("full screen content dismissed");
      isShowingAd = false;
    }

    @Override
    public void onAdFailedToShowFullScreenContent(AdError adError) {}

    @Override
    public void onAdShowedFullScreenContent() {
      isShowingAd = true;
    }

}
#End If
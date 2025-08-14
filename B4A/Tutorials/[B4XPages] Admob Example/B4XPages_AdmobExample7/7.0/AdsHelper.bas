B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.7
@EndOfDesignText@
'V1.00
'Events for Rewarded Video, Rewarded Interstitial, and Open Ads. 
'Rewarded is only for the rewarded types.
#Event: ReceiveAd
#Event: FailedToReceiveAd(ErrorCode As String)
#Event: Rewarded (Item As Object)

Sub Class_Globals
	Private AppOpenAdCallback, AppOpenAdFullScreenCallback As JavaObject
	Private AppInterstitialRAdCallback, AppInterstitialRAdFullScreenCallback As JavaObject  'Rewarded Interstitial
	Private AppVideoRAdCallback, AppVideoRAdFullScreenCallback As JavaObject  'Rewarded Video
	
	Private ctxt As JavaObject
	Private LastBackgroundTime As Long
	Private ConsentInformation As JavaObject
	Private ConsentDebugSettings As JavaObject
	
	Private nativeMe As JavaObject
	Private Callback_Module_RewardedVideo, Callback_Module_RewardedInterstitial, Callback_Module_AppOpenAd As Object
	Private Event_RewardedVideo, Event_RewardedInterstitial, Event_AppOpenAd As String
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

Private Sub GetAdRequest As Object
	Dim builder As AdRequestBuilder
	builder.Initialize
	Dim jo As JavaObject = builder
	Return jo.RunMethod("build", Null)
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

#Region Consent
'Returns one of the following values: NOT_REQUIRED, REQUIRED, OBTAINED, UNKNOWN
Public Sub GetConsentStatus As String
	Log("GetConsentStatus")
	Dim statuses As Map = CreateMap(1: "NOT_REQUIRED", 2: "REQUIRED", 3: "OBTAINED", 0: "UNKNOWN")
	Dim status As Int = ConsentInformation.RunMethod("getConsentStatus", Null)
	Log("status: " & status)
	Return statuses.GetDefault(status, "UNKNOWN")
End Sub

'Returns one of the following values: NON_PERSONALIZED, PERSONALIZED, UNKNOWN
Public Sub GetConsentType As String
	Log("GetConsentType")
	Dim statuses As Map = CreateMap(1: "NON_PERSONALIZED", 2: "PERSONALIZED", 0: "UNKNOWN")
	Dim status As Int = ConsentInformation.RunMethod("getConsentType", Null)
	LogColor("status: " & status, Colors.Cyan)
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
	Log(MethodName)
	LogColor(Args, Colors.Cyan)
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
	Log("SetConsentDebugParameters: " & TestId & " - " & InEEA)
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
	Log(MethodName)
	LogColor(Args, Colors.Magenta)
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
#End Region

#Region Open Ad
'Should be called once. An infinite loop that checks for an AppOpenAd when needed.
Public Sub FetchOpenAd (AppOpenAdUnit As String)
	Dim AppOpenAd As JavaObject
	AppOpenAd.InitializeStatic("com.google.android.gms.ads.appopen.AppOpenAd")
	AppOpenAdCallback.InitializeNewInstance(Application.PackageName & ".adshelper$MyAddOpenAdCallback", Null)
	AppOpenAdFullScreenCallback.InitializeNewInstance(Application.PackageName & ".adshelper$MyFullScreenContentCallback", Null)
	Do While True
		If AppOpenAdCallback.GetField("ad") = Null Then
'			AppOpenAd.RunMethod("load", Array(ctxt, AppOpenAdUnit, GetAdRequest, AppOpenAd.GetField("APP_OPEN_AD_ORIENTATION_PORTRAIT"), AppOpenAdCallback))
			'1.01  13/07/25
			AppOpenAd.RunMethod("load", Array(ctxt, AppOpenAdUnit, GetAdRequest, AppOpenAdCallback))
		End If
		Sleep(60000)
	Loop
End Sub

'Should be called from B4XPage_Foreground.
Public Sub ShowOpenAdIfAvailable
	LogColor("ShowOpenAdIfAvailable: " & AppOpenAdCallback.IsInitialized, Colors.Green)
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
#End Region

#Region Rewarded Interstitial
'Load rewarded interstitial ad
Public Sub FetchRewardedInterstitialAd (RewardedInterstitialAdAdUnit As String, CallbackModule As Object, Event As String)
	SetRewardedInterstitialCallbackModule(CallbackModule, Event)
	Dim RewardedInterstitialAd As JavaObject
	RewardedInterstitialAd.InitializeStatic("com.google.android.gms.ads.rewardedinterstitial.RewardedInterstitialAd")
	AppInterstitialRAdCallback.InitializeNewInstance(Application.PackageName & ".adshelper$MyRewardedInterstitialAdCallback", Null)
	AppInterstitialRAdFullScreenCallback.InitializeNewInstance(Application.PackageName & ".adshelper$MyFullScreenContentCallback", Null)

	If AppInterstitialRAdCallback.GetField("ad") = Null Then
		RewardedInterstitialAd.RunMethod("load", Array(ctxt, RewardedInterstitialAdAdUnit, GetAdRequest, AppInterstitialRAdCallback))
	End If
End Sub

'Show rewarded interstitial ad
Public Sub ShowRewardedInterstitialAd
	If AppInterstitialRAdCallback.IsInitialized And Not(AppInterstitialRAdFullScreenCallback.GetField("isShowingAd")) Then
		Dim ad As JavaObject = AppInterstitialRAdCallback.GetField("ad")
		If ad.IsInitialized Then
			ad.RunMethod("setFullScreenContentCallback", Array(AppInterstitialRAdFullScreenCallback))
			nativeMe = Me
			nativeMe.RunMethod("showRewardedInterstitialAd", Array(ad, ctxt, "RewardedInterstitialAd_Event"))
			AppInterstitialRAdCallback.SetField("ad", Null)
		End If
	End If
End Sub

Public Sub isAvailableRewardedInterstitialAd As Boolean
	Dim Retval As Boolean
	Try
		Dim ad As JavaObject = AppInterstitialRAdCallback.GetField("ad")
		Retval=ad.IsInitialized
	Catch
		Retval=False
	End Try
	Return Retval
End Sub

Private Sub SetRewardedInterstitialCallbackModule(Module As Object, Event As String)
	nativeMe = Me
	nativeMe.RunMethod("setEventCallback", Array(Me))
	Callback_Module_RewardedInterstitial=Module
	Event_RewardedInterstitial=Event
End Sub

Sub RewardedInterstitialAd_Event (MethodName As String, Args() As Object) As Object
	Log("RewardedInterstitialAd_Event "&MethodName)
	Event_Rewarded(Args(0), "RewardedInterstitial")
	Return True
End Sub
#End Region

#Region Rewarded Video
'Load the rewarded video ad
'Has events of Event_ReceiveAd and Event_FailedToReceiveAd (ErrorCode As String)
Public Sub FetchRewardedVideoAd (RewardedAdAdUnit As String, CallbackModule As Object, Event As String)
	SetRewardedVideoCallbackModule(CallbackModule, Event)
	Dim RewardedAd As JavaObject
	RewardedAd.InitializeStatic("com.google.android.gms.ads.rewarded.RewardedAd")
	AppVideoRAdCallback.InitializeNewInstance(Application.PackageName & ".adshelper$MyRewardedAdCallback", Null)
	AppVideoRAdFullScreenCallback.InitializeNewInstance(Application.PackageName & ".adshelper$MyFullScreenContentCallback", Null)

	If AppVideoRAdCallback.GetField("ad") = Null Then
		RewardedAd.RunMethod("load", Array(ctxt, RewardedAdAdUnit, GetAdRequest, AppVideoRAdCallback))
	End If
End Sub

'Show the rewarded video ad
'Has the event of Event_Rewarded(Item as Object)
'Event is set on the FetchRewardedVideoAd method
Public Sub ShowRewardedVideoAd
	If AppVideoRAdCallback.IsInitialized Then
		If Not(AppVideoRAdFullScreenCallback.GetField("isShowingAd")) Then

			Dim ad As JavaObject = AppVideoRAdCallback.GetField("ad")
			If ad.IsInitialized Then
'			Dim listener As Object = ad.CreateEventFromUI("com.google.android.gms.ads.OnUserEarnedRewardListener", "rewardedVideoAd", Null)
				ad.RunMethod("setFullScreenContentCallback", Array(AppVideoRAdFullScreenCallback))
'		ad.RunMethod("show", Array(ctxt, listener)) ', listener
				AppVideoRAdCallback.SetField("ad", Null)
				nativeMe = Me
				nativeMe.RunMethod("showRewardedVideoAd", Array(ad, ctxt, "RewardedVideoAd_Event"))
			End If
		End If
	End If
End Sub

'Check to see if the rewarded video ad is ready to show
Public Sub isAvailableRewardedVideoAd As Boolean
	Dim Retval As Boolean
	Try
		Dim ad As JavaObject = AppVideoRAdCallback.GetField("ad")
		Retval=ad.IsInitialized
	Catch
		Retval=False
	End Try
	Return Retval
End Sub

Private Sub SetRewardedVideoCallbackModule(Module As Object, Event As String)
	nativeMe = Me
	nativeMe.RunMethod("setEventCallback", Array(Me))
	Callback_Module_RewardedVideo=Module
	Event_RewardedVideo=Event
End Sub

Sub RewardedVideoAd_Event (Args() As Object) As Object
'	Log("RewardedVideoAd_Event "&MethodName)
	Event_Rewarded(Args(0), "RewardedVideo")
	Return True
End Sub

'this sub will route the FailedToReceiveAd events to the appropriate sub and related module
Sub Event_FailedToReceiveAd (ErrorCode As String, AdType As String)
'	LogColor("Event_FailedToReceiveAd ErrorCode="&ErrorCode&" AdType="&AdType, Colors.Yellow)
	Select AdType
		Case "AppOpenAd"
			CallSubDelayed2(Callback_Module_AppOpenAd, Event_AppOpenAd & "_FailedToReceiveAd", ErrorCode)
		Case "RewardedVideo"
			CallSubDelayed2(Callback_Module_RewardedVideo, Event_RewardedVideo & "_FailedToReceiveAd", ErrorCode)
		Case "RewardedInterstitial"
			CallSubDelayed2(Callback_Module_RewardedInterstitial, Event_RewardedInterstitial & "_FailedToReceiveAd", ErrorCode)
	End Select
End Sub

'this sub will route the ReceiveAd events to the appropriate sub and related module
Sub Event_ReceiveAd(AdType As String)
'	LogColor("Event_ReceiveAd AdType="&AdType, Colors.Yellow)
	Select AdType
		Case "AppOpenAd"
			CallSubDelayed(Callback_Module_AppOpenAd, Event_AppOpenAd & "_ReceiveAd")
		Case "RewardedVideo"
			CallSubDelayed(Callback_Module_RewardedVideo, Event_RewardedVideo & "_ReceiveAd")
		Case "RewardedInterstitial"
			CallSubDelayed(Callback_Module_RewardedInterstitial, Event_RewardedInterstitial & "_ReceiveAd")
	End Select
End Sub

'this sub will route the ReceiveAd events to the appropriate sub and related module
Sub Event_Rewarded(Item As Object, AdType As String)
'	LogColor("Event_ReceiveAd AdType="&AdType, Colors.Yellow)
	Select AdType
		Case "RewardedVideo"
			CallSubDelayed2(Callback_Module_RewardedVideo, Event_RewardedVideo & "_Rewarded", Item)
		Case "RewardedInterstitial"
			CallSubDelayed2(Callback_Module_RewardedInterstitial, Event_RewardedInterstitial & "_Rewarded", Item)
	End Select
End Sub

'called from a rewarded ad when the screen is dimsissed
Sub Event_Dismissed_Rewarded(Rewarded As Boolean, Item As Object, AdType As String)
	LogColor($"Event_Dismissed(Rewarded=${Rewarded}, AdType=${AdType})"$, Colors.Green)
	If Rewarded Then
		Event_Rewarded(Item, AdType)
	End If
End Sub
#End Region

#if java
import com.google.android.gms.ads.FullScreenContentCallback;
import com.google.android.gms.ads.appopen.*;
import com.google.android.gms.ads.appopen.AppOpenAd.*;
import com.google.android.gms.ads.*;
import com.google.android.gms.ads.rewardedinterstitial.*;
import com.google.android.gms.ads.rewardedinterstitial.RewardedInterstitialAd;
//added jc
import com.google.android.gms.ads.OnUserEarnedRewardListener;
import com.google.android.gms.ads.ResponseInfo;
import com.google.android.gms.ads.rewarded.RewardItem;
import com.google.android.gms.ads.rewarded.RewardedAd;
import com.google.android.gms.ads.rewarded.RewardedAdLoadCallback;
import androidx.annotation.NonNull;
import android.app.Activity;

static B4AClass target;
static Boolean rewarded;
static RewardItem lastRewardItem;
static String lastRewardShownType;

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
	  	if (lastRewardItem!=null) {
	  		target.getBA().raiseEventFromDifferentThread(target, null, 0, "event_dismissed_rewarded", false, new Object[] {rewarded, lastRewardItem, lastRewardShownType});
		}
	  	lastRewardShownType="";
	  	rewarded=false;
    }

    @Override
    public void onAdFailedToShowFullScreenContent(AdError adError) {}

    @Override
    public void onAdShowedFullScreenContent() {
      isShowingAd = true;
    }
}

public static class MyRewardedInterstitialAdCallback extends RewardedInterstitialAdLoadCallback {
	public RewardedInterstitialAd ad;
	
	@Override
	public void onAdFailedToLoad(LoadAdError adError) {
		BA.Log("Failed to load RewardedInterstitialAd: " + adError);
		target.getBA().raiseEventFromDifferentThread(target, null, 0, "event_failedtoreceivead", false, new Object[] {adError.toString(), "RewardedInterstitial"});
	}
	
	@Override
    public void onAdLoaded(RewardedInterstitialAd ad) {
		BA.Log("RewardedInterstitialAd received");
		target.getBA().raiseEventFromDifferentThread(target, null, 0, "event_receivead", false, new Object[] {"RewardedInterstitial"});
		this.ad = ad;
	}	
}

public void setEventCallback(B4AClass target) {
	//BA.Log("setEventCallback");	   
    this.target = target;	   
}
      
public void showRewardedVideoAd(RewardedAd mRewardedAd, Activity context, String theEvent) {
	rewarded=false;
	lastRewardShownType="RewardedVideo";
	if (mRewardedAd != null) {
//	  isShowingAd=true;
	  mRewardedAd.show(context, new OnUserEarnedRewardListener() {
	    public void onUserEarnedReward(@NonNull RewardItem rewardItem) {
	      // Handle the reward.
	      BA.Log("The user earned the reward.");
	      int rewardAmount = rewardItem.getAmount();
	      String rewardType = rewardItem.getType();
		  rewarded=true;
		  lastRewardItem=rewardItem;
		  target.getBA().raiseEventFromDifferentThread(target, null, 0, "theEvent", false, new Object[] {rewardItem});
	    }
	  });
	} else {
	  BA.Log("The rewarded ad wasn't ready yet.");
	}
}
      
public void showRewardedInterstitialAd(RewardedInterstitialAd mRewardedAd, Activity context, String theEvent) {
	rewarded=false;
	lastRewardShownType="RewardedInterstitial";
	if (mRewardedAd != null) {
//	  isShowingAd=true;
	  mRewardedAd.show(context, new OnUserEarnedRewardListener() {
	    public void onUserEarnedReward(@NonNull RewardItem rewardItem) {
	      // Handle the reward.
	      BA.Log("The user earned the reward.");
	      int rewardAmount = rewardItem.getAmount();
	      String rewardType = rewardItem.getType();
		  rewarded=true;
		  lastRewardItem=rewardItem;
		  target.getBA().raiseEventFromDifferentThread(target, null, 0, "theEvent", false, new Object[] {rewardItem});
	    }
	  });
	} else {
	  BA.Log("The rewarded ad wasn't ready yet.");
	}
}

//rewarded video ad
public static class MyRewardedAdCallback extends RewardedAdLoadCallback {
	public RewardedAd ad;
	
	@Override
	public void onAdFailedToLoad(LoadAdError adError) {
		BA.Log("Failed to load RewardedVideoAd: " + adError);
		target.getBA().raiseEventFromDifferentThread(target, null, 0, "event_failedtoreceivead", false, new Object[] {adError.toString(), "RewardedVideo"});
	}
	
	@Override
    public void onAdLoaded(RewardedAd ad) {
		BA.Log("RewardedVideoAd received");
		target.getBA().raiseEventFromDifferentThread(target, null, 0, "event_receivead", false, new Object[] {"RewardedVideo"});
		this.ad = ad;
	}	
}
#End If
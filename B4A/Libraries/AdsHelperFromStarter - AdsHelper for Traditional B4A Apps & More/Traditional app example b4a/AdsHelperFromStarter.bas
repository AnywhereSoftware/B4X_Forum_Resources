B4A=true
Group=Default Group\Classes
ModulesStructureVersion=1
Type=Class
Version=11.2
@EndOfDesignText@
'V1.00
'Events for Rewarded Video, Rewarded Interstitial, and Open Ads. 
'Rewarded is only for the rewarded types.
#Event: ReceiveAd
#Event: FailedToReceiveAd(ErrorCode As String)
#Event: Rewarded (Item As Object)

Sub Class_Globals
#if not(pro) and not(iqpro)
	Private AppOpenAdCallback, AppOpenAdFullScreenCallback As JavaObject
	Private AppInterstitialRAdCallback, AppInterstitialRAdFullScreenCallback As JavaObject
	Private AppVideoRAdCallback, AppVideoRAdFullScreenCallback As JavaObject
	Private ctxt, ConsentContext, FullScreenAdDisplayContext As JavaObject
	Private LastBackgroundTime As Long
	Private ConsentInformation As JavaObject
	Private ConsentDebugSettings As JavaObject
	Private nativeMe As JavaObject
	Private Callback_Module_RewardedVideo, Callback_Module_RewardedInterstitial, Callback_Module_AppOpenAd As Object
	Private Event_RewardedVideo, Event_RewardedInterstitial, Event_AppOpenAd As String
	Private ReloadOnDismissed_OpenAd, ReloadOnDismissed_RewardedInterstitial, ReloadOnDismissed_RewardedVideo As Boolean ' whether to automatically reload the ad after it has been shown
	Private AdUnitID_OpenAd, AdUnitID_RewardedInterstitial, AdUnitID_RewardedVideo As String
	Public LastOrientationPortrait As Boolean
#end if
End Sub

Public Sub Initialize
#if not(pro) and not(iqpro)	
	ctxt.InitializeContext
	Dim UserMessagingPlatform As JavaObject
	UserMessagingPlatform.InitializeStatic("com.google.android.ump.UserMessagingPlatform")
	ConsentInformation = UserMessagingPlatform.RunMethod("getConsentInformation", Array(ctxt))
#end if
End Sub

#if not(pro) and not(iqpro)


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
	Dim callback1 As Object = ConsentInformation.CreateEventFromUI("com.google.android.ump.ConsentInformation$OnConsentInfoUpdateSuccessListener", "callback", Null)
	Dim callback2 As Object = ConsentInformation.CreateEventFromUI("com.google.android.ump.ConsentInformation$OnConsentInfoUpdateFailureListener", "callback", Null)
	ConsentInformation.RunMethod("requestConsentInfoUpdate", Array(ConsentContext, ConsentRequestParameters.RunMethod("build", Null), callback1, callback2))
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
	ConsentDebugSettings.InitializeNewInstance("com.google.android.ump.ConsentDebugSettings$Builder", Array(ConsentContext))
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
	UserMessagingPlatform.RunMethod("loadConsentForm", Array(ConsentContext, callback1, callback2))
	Wait For Callback_Event (MethodName As String, Args() As Object)
	If MethodName = "onConsentFormLoadFailure" Then
		Dim FormError As JavaObject = Args(0)
		Log("onConsentFormLoadFailure: " & FormError.RunMethod("getMessage", Null) & ", code: " & FormError.RunMethod("getErrorCode", Null))
	Else if MethodName = "onConsentFormLoadSuccess" Then
		Dim form As JavaObject = Args(0)
		Dim listener As Object = form.CreateEventFromUI("com.google.android.ump.ConsentForm$OnConsentFormDismissedListener", "callback", Null)
		form.RunMethod("show", Array(ConsentContext, listener))
		Wait For Callback_Event (MethodName As String, Args() As Object)
		Log("consent form dismissed")
	End If
	Return True
End Sub

#Region Open Ad
'Should be called once. An infinite loop that checks for an AppOpenAd when needed.
Public Sub FetchOpenAd (AppOpenAdUnit As String, CallbackModule As Object, Event As String, Portrait As Boolean, ReloadOnDismissed As Boolean)
	LogColor($"--------->FetchOpenAd"$, Colors.Green)
	ReloadOnDismissed_OpenAd=ReloadOnDismissed
	AdUnitID_OpenAd=AppOpenAdUnit
	SetOpenAdCallbackModule(CallbackModule, Event)
	Dim AppOpenAd As JavaObject
	AppOpenAd.InitializeStatic("com.google.android.gms.ads.appopen.AppOpenAd")
	AppOpenAdCallback.InitializeNewInstance(Application.PackageName & ".adshelperfromstarter$MyAddOpenAdCallback", Null)
	AppOpenAdFullScreenCallback.InitializeNewInstance(Application.PackageName & ".adshelperfromstarter$MyFullScreenContentCallback", Null)
	Do While True
		If AppOpenAdCallback.GetField("ad") = Null Then
			If Portrait Then
				AppOpenAd.RunMethod("load", Array(ctxt, AppOpenAdUnit, GetAdRequest, AppOpenAd.GetField("APP_OPEN_AD_ORIENTATION_PORTRAIT"), AppOpenAdCallback))
			Else
				AppOpenAd.RunMethod("load", Array(ctxt, AppOpenAdUnit, GetAdRequest, AppOpenAd.GetField("APP_OPEN_AD_ORIENTATION_LANDSCAPE"), AppOpenAdCallback))
			End If
		End If
		Sleep(60000)
	Loop
End Sub

Public Sub SetConsentContext(Context As JavaObject)
	ConsentContext=Context
End Sub

Public Sub SetCallbackModuleForFullScreenAds(Module As Object)
	Callback_Module_AppOpenAd=Module
	Callback_Module_RewardedInterstitial=Module
	Callback_Module_RewardedVideo=Module
End Sub

Public Sub SetFullScreenAdDisplayContext(Context As JavaObject)
	FullScreenAdDisplayContext = Context
End Sub

Public Sub SetOpenAdCallbackModule(Module As Object, Event As String)
	nativeMe = Me
	nativeMe.RunMethod("setEventCallback", Array(Me))
	Callback_Module_AppOpenAd=Module
	Event_AppOpenAd=Event
End Sub

'Should be called from B4XPage_Foreground.
Public Sub ShowOpenAdIfAvailable(BackgroundMinutesBeforeShowing As Int)
'	LogColor($"Checking to see if should show AppOpenAd. Is AppOpenAd loaded? ${AppOpenAdCallback.IsInitialized} Seconds since last background ${(DateTime.Now-LastBackgroundTime)/DateTime.TicksPerSecond} "$, Colors.Magenta)
	'don't show an ad if less than BackgroundMinutesBeforeShowing minutes in background
	If AppOpenAdCallback.IsInitialized And LastBackgroundTime + BackgroundMinutesBeforeShowing * DateTime.TicksPerMinute < DateTime.Now Then
'		LogColor($"Is already showing? ${AppOpenAdFullScreenCallback.GetField("isShowingAd")}"$, Colors.Magenta)
		If Not(AppOpenAdFullScreenCallback.GetField("isShowingAd")) Then
			Dim ad As JavaObject = AppOpenAdCallback.GetField("ad")
			If ad.IsInitialized Then
				ad.RunMethod("setFullScreenContentCallback", Array(AppOpenAdFullScreenCallback))
				ad.RunMethod("show", Array(FullScreenAdDisplayContext))
				nativeMe = Me
				nativeMe.RunMethod("setLastRewardTypeToOpenAd", Null)
				
				AppOpenAdCallback.SetField("ad", Null)
			End If
		End If
	End If
End Sub
#End Region



#Region Rewarded Interstitial
'Load rewarded interstitial ad
Public Sub FetchRewardedInterstitialAd (RewardedInterstitialAdAdUnit As String, CallbackModule As Object, Event As String, ReloadOnDismissed As Boolean)
	ReloadOnDismissed_RewardedInterstitial=ReloadOnDismissed
	AdUnitID_RewardedInterstitial=RewardedInterstitialAdAdUnit
	SetRewardedInterstitialCallbackModule(CallbackModule, Event)
	Dim RewardedInterstitialAd As JavaObject
	RewardedInterstitialAd.InitializeStatic("com.google.android.gms.ads.rewardedinterstitial.RewardedInterstitialAd")
	RewardedInterstitialAd.InitializeStatic("com.google.android.gms.ads.rewardedinterstitial.RewardedInterstitialAd")
	AppInterstitialRAdCallback.InitializeNewInstance(Application.PackageName & ".adshelperfromstarter$MyRewardedInterstitialAdCallback", Null)
	AppInterstitialRAdFullScreenCallback.InitializeNewInstance(Application.PackageName & ".adshelperfromstarter$MyFullScreenContentCallback", Null)
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
			nativeMe.RunMethod("showRewardedInterstitialAd", Array(ad, FullScreenAdDisplayContext, "RewardedInterstitialAd_Event"))
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

Public Sub SetRewardedInterstitialCallbackModule(Module As Object, Event As String)
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
Public Sub FetchRewardedVideoAd (RewardedAdAdUnit As String, CallbackModule As Object, Event As String, ReloadOnDismissed As Boolean)
	ReloadOnDismissed_RewardedVideo=ReloadOnDismissed
	AdUnitID_RewardedVideo=RewardedAdAdUnit
	SetRewardedVideoCallbackModule(CallbackModule, Event)
	Dim RewardedAd As JavaObject
	RewardedAd.InitializeStatic("com.google.android.gms.ads.rewarded.RewardedAd")
	AppVideoRAdCallback.InitializeNewInstance(Application.PackageName & ".adshelperfromstarter$MyRewardedAdCallback", Null)
	AppVideoRAdFullScreenCallback.InitializeNewInstance(Application.PackageName & ".adshelperfromstarter$MyFullScreenContentCallback", Null)

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
				nativeMe.RunMethod("showRewardedVideoAd", Array(ad, FullScreenAdDisplayContext, "RewardedVideoAd_Event"))
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

Public Sub SetRewardedVideoCallbackModule(Module As Object, Event As String)
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
	LogColor("Event_FailedToReceiveAd ErrorCode="&ErrorCode&" AdType="&AdType, Colors.Yellow)
	Select AdType
		Case "OpenAd"
			CallSubDelayed2(Callback_Module_AppOpenAd, Event_AppOpenAd & "_FailedToReceiveAd", ErrorCode)
		Case "RewardedVideo"
			CallSubDelayed2(Callback_Module_RewardedVideo, Event_RewardedVideo & "_FailedToReceiveAd", ErrorCode)
		Case "RewardedInterstitial"
			CallSubDelayed2(Callback_Module_RewardedInterstitial, Event_RewardedInterstitial & "_FailedToReceiveAd", ErrorCode)
	End Select
End Sub

'this sub will route the ReceiveAd events to the appropriate sub and related module
Sub Event_ReceiveAd(AdType As String)
	LogColor("Event_ReceiveAd AdType="&AdType, Colors.Yellow)
	Select AdType
		Case "OpenAd"
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
	LogColor($"Event_Dismissed(Rewarded=${Rewarded}, AdType=${AdType}); isAvailableRewardedInterstitialAd=${isAvailableRewardedInterstitialAd}, ReloadOnDismissed_RewardedVideo=${ReloadOnDismissed_RewardedVideo}, ReloadOnDismissed_RewardedInterstitial=${ReloadOnDismissed_RewardedInterstitial}"$, Colors.Green)
	Select AdType
'		Case "OpenAd"
'			CallSubDelayed(Callback_Module_AppOpenAd, Event_AppOpenAd & "_Dismissed")
		Case "RewardedVideo"
			CallSubDelayed2(Callback_Module_RewardedVideo, Event_RewardedVideo & "_Dismissed", Rewarded)
			If ReloadOnDismissed_RewardedVideo Then FetchRewardedVideoAd(AdUnitID_RewardedVideo, Callback_Module_RewardedVideo, Event_RewardedVideo, ReloadOnDismissed_RewardedVideo)
		Case "RewardedInterstitial"
			CallSubDelayed2(Callback_Module_RewardedInterstitial, Event_RewardedInterstitial & "_Dismissed", Rewarded)
			If ReloadOnDismissed_RewardedInterstitial Then FetchRewardedInterstitialAd(AdUnitID_RewardedInterstitial, Callback_Module_RewardedInterstitial, Event_RewardedInterstitial, ReloadOnDismissed_RewardedInterstitial)
	End Select
	If Rewarded Then
		Event_Rewarded(Item, AdType)
	End If
	
End Sub

Sub Event_Dismissed_OpenAd(AdType As String)
	LogColor($"Event_Dismissed_OpenAd(AdType=${AdType})"$, Colors.Green)
	CallSubDelayed(Callback_Module_AppOpenAd, Event_AppOpenAd & "_Closed")
	If ReloadOnDismissed_OpenAd Then FetchOpenAd(AdUnitID_OpenAd, Callback_Module_AppOpenAd, Event_AppOpenAd, LastOrientationPortrait, ReloadOnDismissed_OpenAd)
End Sub

#End Region

#if java
import com.google.android.gms.ads.FullScreenContentCallback;
import com.google.android.gms.ads.appopen.*;
import com.google.android.gms.ads.appopen.AppOpenAd.*;
import com.google.android.gms.ads.rewardedinterstitial.*;
import com.google.android.gms.ads.rewardedinterstitial.RewardedInterstitialAd;
import com.google.android.gms.ads.*;
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

   public void setEventCallback(B4AClass target) {
       //BA.Log("setEventCallback");	   
       this.target = target;	   
   }
   
   public void setLastRewardTypeToOpenAd() {
   		lastRewardShownType="OpenAd";
   }
    
   public void showRewardedVideoAd(RewardedAd mRewardedAd, Activity context, String theEvent) {
		rewarded=false;
		lastRewardShownType="RewardedVideo";
		if (mRewardedAd != null) {
//		  isShowingAd=true;
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
//		  isShowingAd=true;
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
   
public static class MyAddOpenAdCallback extends AppOpenAdLoadCallback {
	public AppOpenAd ad;
	
	@Override
	public void onAdFailedToLoad(LoadAdError adError) {
		BA.Log("Failed to load OpenAd: " + adError);
	  target.getBA().raiseEventFromDifferentThread(target, null, 0, "event_failedtoreceivead", false, new Object[] {adError.toString(), "OpenAd"});		
	}	
	
	 @Override
    public void onAdLoaded(AppOpenAd ad) {
		BA.Log("OpenAd received");
		this.ad = ad;
		target.getBA().raiseEventFromDifferentThread(target, null, 0, "event_receivead", false, new Object[] {"OpenAd"});
	}
}

public static class MyFullScreenContentCallback extends FullScreenContentCallback {
	public boolean isShowingAd;
	@Override
    public void onAdDismissedFullScreenContent() {
		BA.Log("full screen content dismissed "+lastRewardShownType);
      	isShowingAd = false;
	  	if ((lastRewardItem != null) && (!lastRewardShownType.equals("OpenAd"))) {
	  		target.getBA().raiseEventFromDifferentThread(target, null, 0, "event_dismissed_rewarded", false, new Object[] {rewarded, lastRewardItem, lastRewardShownType});
		} else if (lastRewardShownType=="OpenAd") {
			target.getBA().raiseEventFromDifferentThread(target, null, 0, "event_dismissed_openad", false, new Object[] {lastRewardShownType});
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

#end if
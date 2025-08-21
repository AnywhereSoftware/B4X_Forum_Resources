### StartApp ads service by Douglas Farias
### 08/18/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/121325/)

Hello everyone, also posted here.  
  
Tappx  
<https://www.b4x.com/android/forum/threads/tappx-ads-service.90624/#post-758391>  
Displayio  
<https://www.b4x.com/android/forum/threads/display-io-ads-service.90627/#post-758393>  
  
Here is an example of how to use StartApp, banner and interstitial with lasted SDK version.  
<https://www.startapp.com/>  
Download the 4.6.1 jar file.  
![](https://www.b4x.com/android/forum/attachments/98729)  

```B4X
#AdditionalJar: StartAppInApp-4.6.1
```

  
Manifest (the code generated in the startApp goes here in the manifest)  

```B4X
'STARTAPP  
AddPermission(android.permission.INTERNET)  
AddPermission(android.permission.ACCESS_WIFI_STATE)  
AddPermission(android.permission.ACCESS_NETWORK_STATE)  
AddPermission(android.permission.ACCESS_COARSE_LOCATION)  
AddPermission(android.permission.ACCESS_FINE_LOCATION)  
AddPermission(android.permission.RECEIVE_BOOT_COMPLETED)  
AddPermission(android.permission.BLUETOOTH)  
AddApplicationText(  
<provider  
 android:name="com.startapp.sdk.adsbase.StartAppInitProvider"  
 android:authorities="${applicationId}.startappinitprovider"  
 android:exported="false" />  
<activity  
 android:name="com.startapp.sdk.adsbase.consent.ConsentActivity"  
 android:configChanges="orientation|screenSize|screenLayout|keyboardHidden"  
 android:theme="@android:style/Theme.Translucent"/>  
<activity  
 android:name="com.startapp.sdk.ads.list3d.List3DActivity"  
 android:theme="@android:style/Theme"/>  
<activity  
 android:name="com.startapp.sdk.adsbase.activities.OverlayActivity"  
 android:configChanges="orientation|screenSize|screenLayout|keyboardHidden"  
 android:theme="@android:style/Theme.Translucent"/>  
<activity  
 android:name="com.startapp.sdk.adsbase.activities.FullScreenActivity"  
 android:configChanges="orientation|screenSize|screenLayout|keyboardHidden"  
 android:theme="@android:style/Theme"/>  
<service android:name="com.startapp.sdk.adsbase.InfoEventService" />  
<service  
 android:name="com.startapp.sdk.adsbase.PeriodicJobService"  
 android:permission="android.permission.BIND_JOB_SERVICE" />  
<receiver android:name="com.startapp.sdk.adsbase.remoteconfig.BootCompleteListener">  
 <intent-filter>  
 <action android:name="android.intent.action.BOOT_COMPLETED"/>  
 </intent-filter>  
</receiver>  
 <meta-data  
 android:name="com.startapp.sdk.APPLICATION_ID"  
 android:value="xxxxxxxxYOUR APP CODE HERExxxxxxxxxxxx" />  
)
```

  
Service  

```B4X
#Region  Service Attributes  
    #StartAtBoot: False  
#End Region  
  
Sub Process_Globals  
      
    'GENERAL  
    Private StartAppSDK As JavaObject  
    Private ctxt As JavaObject  
    Private appKey As String  
    Private testMode As Boolean = True  
    Private retryTime As Int = 30000  
      
    'INTER  
    Private StartAppAd As JavaObject  
    Public isInterstitialReady As Boolean = False  
    Private AdListenerInterstitial As Object  
    Private AdDisplayListener As Object  
      
      
    'BANNER  
    Private BannerAdListener As Object  
    Public isBannerReady As Boolean = False  
    Private bannerAd As JavaObject  
    Public bannerHeight As Int = 51dip  
    Public bannerView As JavaObject  
      
End Sub  
  
Sub Service_Create  
      
    'INITIALIZE CONTEXT  
    ctxt.InitializeContext  
      
    'GET APP KEY ID  
    appKey = Get_Key("com.startapp.sdk.APPLICATION_ID")  
      
    'INITIALIZE SDK  
    StartAppSDK.InitializeStatic("com.startapp.sdk.adsbase.StartAppSDK")  
    StartAppSDK.RunMethod("init", Array(ctxt,appKey,True))  
    StartAppSDK.RunMethod("setTestAdsEnabled", Array(testMode)) 'TEST MODE ON  
  
    'INTER  
    StartAppAd.InitializeNewInstance("com.startapp.sdk.adsbase.StartAppAd", Array(ctxt))  
    AdListenerInterstitial = StartAppAd.CreateEventFromUI("com.startapp.sdk.adsbase.adlisteners.AdEventListener", "AdListenerInterstitial", Null)  
    AdDisplayListener = StartAppAd.CreateEventFromUI("com.startapp.sdk.adsbase.adlisteners.AdDisplayListener", "AdDisplayListener", Null)  
    Load_Inter  
  
    'BANNER  
    bannerAd.InitializeNewInstance("com.startapp.sdk.ads.banner.Banner", Array(ctxt))  
    BannerAdListener = bannerAd.CreateEventFromUI("com.startapp.sdk.ads.banner.BannerListener", "BannerAdListener", Null)  
    bannerAd.RunMethod("setBannerListener", Array(BannerAdListener))  
    Load_Banner  
      
  
End Sub  
  
Sub Service_Start (StartingIntent As Intent)  
    Service.StopAutomaticForeground  
End Sub  
  
Sub Service_Destroy  
  
End Sub  
  
  
  
#Region INTER  
  
Private Sub AdListenerInterstitial_Event (MethodName As String, Args() As Object) As Object 'INTER EVENTS  
    Select MethodName  
          
        Case "onReceiveAd"  
            LogColor("onReceiveAd Inter StartApp", Colors.Green)  
            isInterstitialReady = True  
              
        Case "onFailedToReceiveAd"  
            LogColor("onFailedToReceiveAd Inter StartApp", Colors.Green)  
            isInterstitialReady = False  
            Retry_Inter  
                          
    End Select  
    Return Null  
End Sub  
  
  
Private Sub AdDisplayListener_Event (MethodName As String, Args() As Object) As Object  
    Select MethodName  
  
        Case "adHidden"  
            isInterstitialReady = False  
            LogColor("adHidden Inter StartApp", Colors.Green)  
  
        Case "adDisplayed"  
            isInterstitialReady = False  
            LogColor("adDisplayed Inter StartApp", Colors.Green)  
  
        Case "adClicked"  
            isInterstitialReady = False  
            LogColor("adClicked Inter StartApp", Colors.Green)  
              
        Case "adNotDisplayed"  
            LogColor("adNotDisplayed Inter StartApp", Colors.Green)  
            isInterstitialReady = False  
            Retry_Inter  
              
    End Select  
    Return Null  
End Sub  
  
  
Sub Load_Inter  
    Try  
        StartAppAd.RunMethod("loadAd", Array(AdListenerInterstitial))  
    Catch  
        If LastException.IsInitialized Then Log(LastException)  
        Retry_Inter  
    End Try  
End Sub  
  
Sub Retry_Inter  
    isInterstitialReady = False  
    Sleep(retryTime)  
    Load_Inter  
End Sub  
  
  
Sub Show_Inter  
    StartAppAd.RunMethod("showAd", Array(AdDisplayListener))  
End Sub  
  
#End Region  
  
  
  
  
  
#Region BANNER  
  
Private Sub BannerAdListener_Event (MethodName As String, Args() As Object) As Object  
    Select MethodName  
  
        Case "onReceiveAd"  
            LogColor("onReceiveAd Banner StartApp", Colors.Green)  
            isBannerReady = True  
            bannerView = Args(0)  
  
        Case "onFailedToReceiveAd"  
            LogColor("onFailedToReceiveAd Banner StartApp", Colors.Green)  
            isBannerReady = False  
            Retry_Banner  
              
        Case "onClick"  
            LogColor("onClick Banner StartApp", Colors.Green)  
                  
    End Select  
    Return Null  
End Sub  
  
  
Sub Load_Banner  
    Try  
        bannerAd.RunMethod("loadAd", Array(320,50))  
    Catch  
        If LastException.IsInitialized Then Log(LastException)  
        Retry_Banner  
    End Try  
End Sub  
  
Sub Retry_Banner  
    isBannerReady = False  
    Sleep(retryTime)  
    Load_Banner  
End Sub  
  
#End Region  
  
  
Private Sub Get_Key(key As String) As String  
    Dim ApplicationInfo As JavaObject = ctxt.RunMethodJO("getPackageManager", Null).RunMethod("getApplicationInfo", Array(Application.PackageName, 0x00000080))  
    Dim bundle As JavaObject = ApplicationInfo.GetField("metaData")  
    Return bundle.RunMethod("getInt", Array(key))  
End Sub
```

  
**I use it in a service (where all events work correctly), but you can compile it as a library or use it as a class.**  
  
Interstitial  

```B4X
If Not(IsPaused(StartApp)) And StartApp.isInterstitialReady Then CallSub(StartApp, "Show_Inter")
```

  
Banner  

```B4X
If Not(IsPaused(StartApp)) And StartApp.isBannerReady Then  
    Private bannerView As View  
    bannerView = StartApp.bannerView  
    Activity.AddView(bannerView,0%x, 100%y - 51dip, 100%x, 51dip)  
End if
```

  
  
  
Thx
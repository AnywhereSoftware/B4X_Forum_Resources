### HMS - Huawei SDK by Erel
### 04/14/2024
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/124034/)

Huawei is the number one manufacturer of phones (<https://www.statista.com/statistics/271496/global-market-share-held-by-smartphone-vendors-since-4th-quarter-2009/>). Due to USA restrictions, the new phones that they sell do not include Google Play, Google Play Services and other Google components.  
They have created their own ecosystem and as developers we shouldn't ignore this ecosystem. There might be opportunities here.  
  
Currently this library supports analytics, push notifications, DRM check, ads and in app purchases.  
I want to thank [USER=58525]@Ferdari[/USER] and other developers who already built wrappers for some of HMS features. Their work did help me while building this library.  
  
The implementation is built in such way that it will not add the HMS SDK unless the build configuration includes the HMS conditional symbol (Ctrl + B):  
  
![](https://www.b4x.com/android/forum/attachments/102207)  
  
Instructions:  
  

1. Register as a Huawei developer: <https://developer.huawei.com/consumer/en/>
2. Download the attached zip **and** [www.b4x.com/android/files/hms\_sdk.zip](https://www.b4x.com/android/files/hms_sdk.zip). Unzip them and copy all files to the additional libraries folder.
3. Open the AppGallery Connect page and create a new project.
4. Find the Manage APIs page and make sure that Analytics Kit and Push Kit (if needed) are enabled.
![](https://www.b4x.com/android/forum/attachments/102209)5. Go to the General Information tab. Set the SHA-256 fingerprint. You can find it in the IDE under Tools - Private Sign Key:
![](https://www.b4x.com/android/forum/attachments/102210)6. Download agconnect-services.json and put it in the project folder (where the b4a file is located).
7. Add the HMS symbol to the build configuration (Ctrl + B) and make sure that the package name matches the project package name defined in AppGallery Connect.
8. Add to main module:

```B4X
#Region HMS Libs+  
#if HMS  
#additionaljar: hms-push-5.0.2.300.aar  
#additionaljar: hms-agconnect-core-1.4.1.300.aar  
#additionaljar: hms-agconnect-credential-1.4.0.300.aar  
#additionaljar: hms-agconnect-https-1.4.0.300.aar  
#additionaljar: hms-availableupdate-5.0.3.301.aar  
#additionaljar: hms-base-5.0.3.301.aar  
#additionaljar: hms-datastore-core-1.4.0.300.aar  
#additionaljar: hms-device-5.0.3.301.aar  
#additionaljar: hms-hianalytics-5.0.4.300.aar  
#additionaljar: hms-Log-5.0.3.301.aar  
#additionaljar: hms-network-common-4.0.18.300.aar  
#additionaljar: hms-network-grs-4.0.18.300.aar  
#additionaljar: hms-opendevice-5.0.2.300.aar  
#additionaljar: hms-security-encrypt-1.1.5.301.aar  
#additionaljar: hms-security-ssl-1.1.5.301.aar  
#additionaljar: hms-security-base-1.1.5.301.aar  
#additionaljar: hms-stats-5.0.3.301.aar  
#additionaljar: hms-tasks-1.4.1.300.aar  
#additionaljar: hms-ui-5.0.3.301.aar  
#additionaljar: hms-update-2.0.7.301.aar  
#AdditionalJar: hms-hianalytics-core-5.0.4.300.jar  
#AdditionalJar: hms-hianalytics-framework-5.0.4.300.jar  
#AdditionalJar: hms-greendao-3.3.0.jar  
#AdditionalJar: hms-greendao-api-3.3.0.jar  
#AdditionalJar: hms-datastore-annotation-1.4.0.300.jar  
#AdditionalJar: hms-drm-2.5.4.302.aar  
#AdditionalJar: hms-apptouch-5.0.2.300.aar  
#AdditionalJar: hms-ads-banner-13.4.30.301.aar  
#AdditionalJar: hms-ads-base-13.4.30.301.aar  
#AdditionalJar: hms-ads-interstitial-13.4.30.301.aar  
#AdditionalJar: hms-ads-lang-13.4.30.301.aar  
#AdditionalJar: hms-ads-lite-13.4.30.301.aar  
#AdditionalJar: hms-ads-native-13.4.30.301.aar  
#AdditionalJar: hms-ads-reward-13.4.30.301.aar  
#AdditionalJar: hms-ads-splash-13.4.30.301.aar  
#AdditionalJar: hms-ads-template-13.4.30.301.aar  
#AdditionalJar: hms-iap-5.1.0.300.aar  
#AdditionalJar: hms-scan-2.0.0.300.aar  
#AdditionalJar: hms-dynamic-api-1.0.13.303.aar  
#AdditionalJar: hms-ml-computer-agc-inner-2.0.5.304.aar  
#AdditionalJar: hms-ml-computer-camera-inner-2.0.5.304.aar  
#AdditionalJar: hms-ml-computer-commonutils-inner-2.0.5.304.aar  
#AdditionalJar: hms-ml-computer-ha-inner-2.0.5.304.aar  
#AdditionalJar: hms-ml-computer-sdkbase-inner-2.0.5.304.aar  
#CustomBuildAction: folders ready, %WINDIR%\system32\cmd.exe, /c copy ..\agconnect-services.json bin\extra\assets\  
#End If  
#End Region
```

9. Add to manifest editor:

```B4X
#if HMS  
CreateResourceFromFile(Macro, hms.hms)  
CreateResourceFromFile(Macro, hms.hms_push)  
CreateResourceFromFile(Macro, hms.hms_drm)  
CreateResourceFromFile(Macro, hms.hms_ads)  
SetApplicationAttribute(android:usesCleartextTraffic, "true")  
#end if
```

10. Add to B4XMainPage (or the Activity for non-B4XPages projects):

```B4X
Sub Class_Globals  
Private Root As B4XView  
Private xui As XUI  
Private hms As HMSManager  
End Sub  
  
Public Sub Initialize  
  
End Sub  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
hms.Initialize  
hms.EnableLogs  
Root = Root1  
Root.LoadLayout("MainPage")  
End Sub
```

11. Make sure that Huawei AppGallery app is installed on the target device.
12. Run the project in debug mode. It will show analytics related logs. Move the app to the background and to the foreground a few times. You should see a message similar to:

```B4X
10-30 11:05:02.794 20298 21440 I HiAnalyticsSDK: SendTask=> events PostRequest sendevent TYPE : oper, TAG : _openness_config_tag, resultCode: 200 ,reqID:7d328467a831341dcfb442174a5c8208
```

13. You should also see the traffic in:
![](https://www.b4x.com/android/forum/attachments/102211)
  
**Tips & Notes**  
  

- The analytics logs are only redirected in debug mode.
- In debug mode you might see an "application not responding" message from time to time. It is related to these logs. It doesn't happen in release mode.

  
Push notifications: <https://www.b4x.com/android/forum/threads/hms-huwaei-push-kit.124100/#content>  
  
  
**Updates**  
  
Update both the attached HMS.zip and [www.b4x.com/android/files/hms\_sdk.zip](https://www.b4x.com/android/files/hms_sdk.zip)  

- V1.07 - New HMS\_NewToken event that is raised in the **Starter** service when a new push token is available:

```B4X
Private Sub HMS_NewToken(Token As String)  
Log("New_Token: " & Token)  
End Sub
```

- V1.05 - HMS.ScanBitmap - scans a bitmap for known barcode types.
- V1.04 - Support for barcode scanning: <https://www.b4x.com/android/forum/threads/hms-barcode-qr-scan.133334/>
Make sure to update the dependencies list, hms\_sdk and hms.zip.- V1.03 - Support for in app purchases. The dependencies list was updated. See this tutorial:
<https://www.b4x.com/android/forum/threads/hms-in-app-purchases.126020/>- V1.02 - Support for banner and interstitial ads. The dependencies and manifest editor snippets were updated.
<https://www.b4x.com/android/forum/threads/hms-ads.124908/>- V1.01 - Missing CheckDRM method added.
- V1.00 - Support for DRM (verification of paid apps): <https://www.b4x.com/android/forum/threads/hms-huawei-drm-verification.124725/>
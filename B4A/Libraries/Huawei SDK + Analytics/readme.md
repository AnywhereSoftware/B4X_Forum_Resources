### Huawei SDK + Analytics by Ferdari
### 10/23/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/123762/)

This library is very simple, it connects to the HMS SDK and then sends Stats to Analytics services like:  
Which Activity open, users actions, etc.  
  
**Author:** Huawei + Ferdari  
**Version:** 1.0  
  
Add the AppGallery Connect configuration file of the app to your B4A project.  

1. Sign in to [AppGallery Connect](https://developer.huawei.com/consumer/en/service/josp/agc/index.html) and click **My projects**.
2. Find your app project and click the app that needs to integrate the HMS Core SDK.
3. Go to **Project Setting** > **App information**. In the **App information** area, download the **agconnect-services.json** file.
4. Copy the **agconnect-services.json** file your Files directory of your project.

  
**Huawei Dependencies SDK + Analytics**  

- Unpack to Additional Libraries and **try to Jetify if needed.**

<https://app.box.com/s/lxukfsckbzi0gqir6mp3zxunpmto2q0a>  

- Unpack atachment:: **DependenciesToFilesFolder.Zip** to Files folder of project.

  
  
  
It uses HMS Analytics version **4.0.2.300** and SDK **1.0.0.300,** Works on every brand phone, **Needs HMS core installed, if not will not throw error.**  
  
Currently it only connects to Analytics but cannot send Actions or preset events.  
  
**NOTE: If your a not using in your project *OkHttpUtils* or Other libr that uses Okio and/or Okhttp you need to add:**  

```B4X
#AdditionalJar: okhttp-3.11.0.jar  
#AdditionalJar: okio-1.14.0.jar
```

  
Check the version in your Libraries folder, it should be the same or greater version in order to work, change to your version.  
  
  
**On Manifest**  

```B4X
'————-HUAWEI——————–  
AddManifestText(  
    <uses-permission android:name="android.permission.REQUEST_INSTALL_PACKAGES" />  
    <uses-permission android:name="com.huawei.appmarket.service.commondata.permission.GET_COMMON_DATA" />  
)  
  
SetApplicationAttribute(android:name, "hms.analytics.MainApplication")  
AddApplicationText(<meta-data android:name="com.huawei.hms.client.service.name:hianalytics" android:value="hianalytics:4.0.2.300"/>  
        <meta-data android:name="com.huawei.hms.min_api_level:hianalytics:hianalytics" android:value="1"/>  
        <receiver android:exported="false" android:name="com.huawei.hms.analytics.receiver.HiAnalyticsSvcEvtReceiver">  
            <intent-filter>  
                <action android:name="com.huawei.hms.analytics.pps.event"/>  
            </intent-filter>  
        </receiver>  
        <service android:exported="false" android:name="com.huawei.agconnect.core.ServiceDiscovery">  
            <meta-data android:name="com.huawei.agconnect.credential.CredentialServiceRegistrar" android:value="com.huawei.agconnect.core.ServiceRegistrar"/>  
        </service>  
        <provider android:authorities="${applicationId}.aaidinitprovider" android:exported="false" android:name="com.huawei.hms.aaid.InitProvider"/>  
        <meta-data android:name="com.huawei.hms.client.service.name:opendevice" android:value="opendevice:4.0.1.301"/>  
        <meta-data android:name="com.huawei.hms.min_api_level:opendevice:push" android:value="1"/>  
        <meta-data android:name="com.huawei.hms.client.service.name:base" android:value="base:4.0.2.300"/>  
        <meta-data android:name="com.huawei.hms.min_api_level:base:hmscore" android:value="1"/>  
        <activity android:configChanges="locale|fontScale|layoutDirection|orientation|screenLayout|screenSize|smallestScreenSize" android:excludeFromRecents="true" android:exported="false" android:hardwareAccelerated="true" android:name="com.huawei.hms.activity.BridgeActivity" android:theme="@android:style/Theme.Translucent">  
            <meta-data android:name="hwc-theme" android:value="androidhwext:style/Theme.Emui.Translucent"/>  
        </activity>  
        <activity android:configChanges="keyboardHidden|orientation|screenLayout|screenSize|smallestScreenSize" android:name="com.huawei.hms.activity.EnableServiceActivity"/>  
        <provider android:authorities="${applicationId}.hms.update.provider" android:exported="false" android:grantUriPermissions="true" android:name="com.huawei.hms.update.provider.UpdateProvider"/>  
        <provider android:authorities="${applicationId}.AGCInitializeProvider" android:exported="false" android:name="com.huawei.agconnect.core.provider.AGConnectInitializeProvider"/>  
        <activity android:configChanges="orientation|screenSize" android:exported="false" android:name="com.huawei.updatesdk.service.otaupdate.AppUpdateActivity" android:theme="@style/upsdkDlDialog">  
            <meta-data android:name="hwc-theme" android:value="androidhwext:style/Theme.Emui.Translucent.NoTitleBar"/>  
        </activity>  
        <activity android:configChanges="keyboardHidden|orientation|screenSize" android:exported="false" android:name="com.huawei.updatesdk.support.pm.PackageInstallerActivity" android:theme="@style/upsdkDlDialog">  
            <meta-data android:name="hwc-theme" android:value="androidhwext:style/Theme.Emui.Translucent"/>  
        </activity>)  
'————-HUAWEI——————–
```

  
**On Process\_ Globals**  

```B4X
Dim analytics As Analytics
```

  
  
**On Activity\_create**  

```B4X
analytics.initAnalytics
```

  
  
Check your Realtime Analytics Dashboard stats to see if it are connecting successfully.  
![](https://www.b4x.com/android/forum/attachments/101967)  
  
**Check the Unfiltered log to check the connection status and info**
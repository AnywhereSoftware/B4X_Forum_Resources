### AdMob mediation - UnityAds (not tested) by Pendrush
### 04/20/2025
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/166508/)

This tutorial assumes that you **already have** [**FirebaseAdMob2**](https://www.b4x.com/android/forum/threads/firebaseadmob2-google-mobile-ads-sdk-v20.129609/#content) **implemented in your app**.  
  
Implementation is **NOT tested in B4A**. You can test it if you want.  
If any of you have tested the implementation, please share your observations, as I don't have any project written with B4A.  
  
If you have problem compiling app please check **[**THIS**](https://www.b4x.com/android/forum/threads/unity-ads-library.120648/page-2#post-1021660)** post.  
  

1. Follow **Step 1** and **Step 2** in this tutorial: <https://developers.google.com/admob/android/mediation/unity>
2. Download UnityAds library from **[HERE](https://www.b4x.com/android/forum/threads/unity-ads-library.120648/)** and unzip it in additional libraries folder. You also can test example app from [post #1](https://www.b4x.com/android/forum/threads/unity-ads-library.120648/) to check is everything is OK with UnityAds, you can have problem with compiling. If you have problem compiling app, please check **[**THIS**](https://www.b4x.com/android/forum/threads/unity-ads-library.120648/page-2#post-1021660)** post.
3. Download UnityAds adapter for mediation from **[HERE](https://maven.google.com/com/google/ads/mediation/unity/4.14.1.0/unity-4.14.1.0.aar)** and copy **unity-4.14.1.0.aar** to additional libraries folder.
4. **minSdkVersion** must be set to **23**.
5. Include UnityAds and OkHttp library in your project. You don't need to initialize libraries, just include them by checking library in Libraries Manager tab inside B4A.

  
Add this to Main module in your project:  

```B4X
    #MultiDex: True  
    #AdditionalJar: androidx.asynclayoutinflater:asynclayoutinflater  
    #AdditionalJar: androidx.collection:collection  
    #AdditionalJar: androidx.concurrent:concurrent-futures  
    #AdditionalJar: androidx.coordinatorlayout:coordinatorlayout  
    #AdditionalJar: androidx.cursoradapter:cursoradapter  
    #AdditionalJar: androidx.datastore:datastore  
    #AdditionalJar: androidx.documentfile:documentfile  
    #AdditionalJar: androidx.fragment:fragment  
    #AdditionalJar: androidx.interpolator:interpolator  
    #AdditionalJar: androidx.legacy:legacy-support-core-ui  
    #AdditionalJar: androidx.legacy:legacy-support-core-utils  
    #AdditionalJar: androidx.lifecycle:lifecycle-common  
    #AdditionalJar: androidx.lifecycle:lifecycle-livedata  
    #AdditionalJar: androidx.lifecycle:lifecycle-livedata-core  
    #AdditionalJar: androidx.lifecycle:lifecycle-process  
    #AdditionalJar: androidx.lifecycle:lifecycle-runtime  
    #AdditionalJar: androidx.lifecycle:lifecycle-runtime-ktx  
    #AdditionalJar: androidx.lifecycle:lifecycle-service  
    #AdditionalJar: androidx.lifecycle:lifecycle-viewmodel  
    #AdditionalJar: androidx.lifecycle:lifecycle-viewmodel-ktx  
    #AdditionalJar: androidx.lifecycle:lifecycle-viewmodel-savedstate  
    #AdditionalJar: androidx.localbroadcastmanager:localbroadcastmanager  
    #AdditionalJar: androidx.print:print  
    #AdditionalJar: androidx.profileinstaller:profileinstaller  
    #AdditionalJar: androidx.sqlite:sqlite  
    #AdditionalJar: androidx.sqlite:sqlite-framework  
    #AdditionalJar: androidx.work:work-runtime  
    #AdditionalJar: androidx.work:work-runtime-ktx  
    #AdditionalJar: androidx.webkit:webkit  
    #AdditionalJar: com.google.android.gms:play-services-cronet  
    #AdditionalJar: com.google.android.gms:play-services-base  
    #AdditionalJar: com.google.android.gms:play-services-basement  
    #AdditionalJar: com.google.android.gms:play-services-tasks  
    #AdditionalJar: com.google.protobuf:protobuf-java-lite  
    #AdditionalJar: com.google.protobuf:protobuf-kotlin-lite  
    #AdditionalJar: org.chromium.net:cronet-api  
    #AdditionalJar: room-common-2.2.5  
    #AdditionalJar: room-runtime-2.2.5.aar
```

  
  
Add this to manifest:  

```B4X
AddManifestText(<queries>  
        <intent>  
            <action android:name="com.attribution.REFERRAL_PROVIDER" />  
        </intent>  
    </queries>)  
  
AddApplicationText(<activity  
            android:name="com.unity3d.services.ads.adunit.AdUnitActivity"  
            android:configChanges="fontScale|keyboard|keyboardHidden|locale|mnc|mcc|navigation|orientation|screenLayout|screenSize|smallestScreenSize|uiMode|touchscreen"  
            android:exported="false"  
            android:hardwareAccelerated="true"  
            android:theme="@android:style/Theme.NoTitleBar.Fullscreen" />  
        <activity  
            android:name="com.unity3d.services.ads.adunit.AdUnitTransparentActivity"  
            android:configChanges="fontScale|keyboard|keyboardHidden|locale|mnc|mcc|navigation|orientation|screenLayout|screenSize|smallestScreenSize|uiMode|touchscreen"  
            android:exported="false"  
            android:hardwareAccelerated="true"  
            android:theme="@android:style/Theme.Translucent.NoTitleBar.Fullscreen" />  
        <activity  
            android:name="com.unity3d.services.ads.adunit.AdUnitTransparentSoftwareActivity"  
            android:configChanges="fontScale|keyboard|keyboardHidden|locale|mnc|mcc|navigation|orientation|screenLayout|screenSize|smallestScreenSize|uiMode|touchscreen"  
            android:exported="false"  
            android:hardwareAccelerated="false"  
            android:theme="@android:style/Theme.Translucent.NoTitleBar.Fullscreen" />  
        <activity  
            android:name="com.unity3d.services.ads.adunit.AdUnitSoftwareActivity"  
            android:configChanges="fontScale|keyboard|keyboardHidden|locale|mnc|mcc|navigation|orientation|screenLayout|screenSize|smallestScreenSize|uiMode|touchscreen"  
            android:exported="false"  
            android:hardwareAccelerated="false"  
            android:theme="@android:style/Theme.NoTitleBar.Fullscreen" />  
        <activity  
            android:name="com.unity3d.ads.adplayer.FullScreenWebViewDisplay"  
            android:configChanges="fontScale|keyboard|keyboardHidden|locale|mnc|mcc|navigation|orientation|screenLayout|screenSize|smallestScreenSize|uiMode|touchscreen"  
            android:exported="false"  
            android:hardwareAccelerated="true"  
            android:theme="@android:style/Theme.NoTitleBar.Fullscreen" />  
        <provider  
            android:name="androidx.startup.InitializationProvider"  
            android:authorities="${applicationId}.androidx-startup" >  
            <meta-data  
                android:name="androidx.lifecycle.ProcessLifecycleInitializer"  
                android:value="androidx.startup" />  
            <meta-data  
                android:name="com.unity3d.services.core.configuration.AdsSdkInitializer"  
                android:value="androidx.startup" />  
        </provider>)
```
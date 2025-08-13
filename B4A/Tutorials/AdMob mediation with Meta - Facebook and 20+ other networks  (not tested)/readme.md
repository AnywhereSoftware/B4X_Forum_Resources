### AdMob mediation with Meta - Facebook and 20+ other networks  (not tested) by Pendrush
### 01/17/2023
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/145527/)

This tutorial assumes that you already have FirebaseAdMob2 implemented in your app.  
  
**Implementation is tested in native Android app, not in B4A**. You can test it if you want.  
  
You need to have **approved partnership** with Meta - Facebook. You can set up a partnership directly in your AdMob account.  
Bidding is supported. Waterfall is not supported.  
  
First you need to follow **Step 1** and **Step 2** in this tutorial:  
<https://developers.google.com/admob/android/mediation/meta>  
  
**Download addition libraries**:  
<https://www.dropbox.com/s/l5b39uanpjcab79/AdMobFacebookLibs.zip?dl=0>  
  
Unzip files in B4A additional libraries folder.  
  
**In B4A app add**:  

```B4X
#AdditionalJar: facebook-6.12.0.0.aar  
#AdditionalJar: AudienceNetwork.aar
```

  
  
**Add in app manifest**:  

```B4X
AddApplicationText(<activity  
            android:name="com.facebook.ads.AudienceNetworkActivity"  
            android:configChanges="keyboardHidden|orientation|screenSize"  
            android:exported="false"  
            android:theme="@android:style/Theme.Translucent.NoTitleBar" />  
  
        <provider  
            android:name="com.facebook.ads.AudienceNetworkContentProvider"  
            android:authorities="${applicationId}.AudienceNetworkContentProvider"  
            android:exported="false" />)
```

  
  
You can show in your app: Banner, Interstitial and Rewarded Ads.  
  
  
**BONUS**:  
Except few, you will receive payments for most networks in mediation directly from Google.  
You can also make partnership with a lot more networks (20+), without changing any code in your app.  
Networks in "**No third-party SDKs required**" (without changing code in app) :  
<https://developers.google.com/admob/android/choose-networks#network_details>  
For some network you need to wait 10 minutes to get approved partnership, for some waiting time is few months. So be patient.  
For these networks, in section "**No third-party SDKs required"**, you don't even need to upload new version of your app, as you don't need to change any code.  
  
**Bidding FAQ**:  
<https://support.google.com/admob/answer/9360574>  
  
If anyone wants to test, please post your results.
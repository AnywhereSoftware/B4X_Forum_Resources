### Facebook - Extends FirebaseAuth to support Facebook by Erel
### 11/07/2022
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/67954/)

This library requires B4A v12.0+  
  
![](https://www.b4x.com/android/forum/attachments/45045)  
  
This library together with FirebaseAuth allows users to sign in to your app with a Facebook or Google account.  
  
Start with configuring FirebaseAuth: <https://www.b4x.com/android/forum/threads/firebaseauth-authenticate-your-users.67875/>  
Once it works you can follow these instructions to add support for Facebook.  
  
You should create a facebook app with an Android platform:  
![](https://www.b4x.com/basic4android/images/SS-2016-06-15_17.06.51.png)  
  
Enable Facebook in Firebase console: Auth - Sign In Method:  
![](https://www.b4x.com/basic4android/images/SS-2016-06-15_17.04.08.png)  
  
Add the OAuth redirect URI from Firebase to Facebook Login product:  
![](https://www.b4x.com/basic4android/images/SS-2016-06-15_17.08.38.png)  
  
You will need to follow these instructions to create a hash key from B4A signing key: <https://developers.facebook.com/docs/android/getting-started#release-key-hash>  
The alias in the command should be B4A.  
  
Add the following snippet to the manifest editor and make sure to update **facebook\_app\_id** and the **client token** (<https://developers.facebook.com/docs/facebook-login/guides/access-tokens#clienttokens>):  

```B4X
'************ Facebook Login ****************  
CreateResource(values, facebook.xml, <resources>  
    <string name="facebook_app_id">111111111111111</string>  
   </resources>)  
    
 AddApplicationText(<meta-data android:name="com.facebook.sdk.ClientToken" android:value="aaaaaaaaaabbbbbbbe053434346"/>)  
  
AddApplicationText( <activity  
            android:name="com.facebook.FacebookActivity"  
            android:configChanges="keyboard|keyboardHidden|screenLayout|screenSize|orientation"  
           android:theme="@android:style/Theme.Translucent.NoTitleBar" />  
          <meta-data android:name="com.facebook.sdk.ApplicationId" android:value="@string/facebook_app_id"/>)  
    
AddApplicationText(  
    <provider  
            android:name="com.facebook.internal.FacebookInitProvider"  
            android:authorities="${applicationId}.FacebookInitProvider"  
            android:exported="false" />  
  
        <receiver  
            android:name="com.facebook.CurrentAccessTokenExpirationBroadcastReceiver"  
            android:exported="false" >  
            <intent-filter>  
                <action android:name="com.facebook.sdk.ACTION_CURRENT_ACCESS_TOKEN_CHANGED" />  
            </intent-filter>  
        </receiver>  
        <receiver  
            android:name="com.facebook.AuthenticationTokenManager$CurrentAuthenticationTokenChangedBroadcastReceiver"  
            android:exported="false" >  
            <intent-filter>  
                <action android:name="com.facebook.sdk.ACTION_CURRENT_AUTHENTICATION_TOKEN_CHANGED" />  
            </intent-filter>  
        </receiver>  
         
         <activity  
            android:name="com.facebook.FacebookActivity"  
            android:configChanges="keyboard|keyboardHidden|screenLayout|screenSize|orientation"  
            android:theme="@style/com_facebook_activity_theme" />  
        <activity android:name="com.facebook.CustomTabMainActivity" />  
        <activity  
            android:name="com.facebook.CustomTabActivity"  
            android:exported="true"  
             >  
            <intent-filter>  
                <action android:name="android.intent.action.VIEW" />  
  
                <category android:name="android.intent.category.DEFAULT" />  
                <category android:name="android.intent.category.BROWSABLE" />  
  
                <data  
                    android:host="cct.${applicationId}"  
                    android:scheme="fbconnect" />  
            </intent-filter>  
        </activity>  
)  
  
'************ Facebook Login (end) **********
```

  
Replace the number with your Facebook app id.  
  
The code itself is simple. You need to initialize FacebookSdk in the starter service.  
Call SignIn from an Activity to sign in.  
Note that the user will sign in automatically after the first time.  
  
Auth\_SignedIn event is raised after the user signs in.  
  
  
Firebase instructions: <https://firebase.google.com/docs/auth/android/facebook-login>  
Facebook instructions: <https://developers.facebook.com/docs/facebook-login/android>  
  
Note that you need to "make the app public" before other users can log in:  
  
![](https://www.b4x.com/basic4android/images/SS-2016-07-05_08.57.05.png)  
  
  
**Updates**  
  
v2.01 - Adds missing dependencies.  
v2.00 - Based on Facebook 14.1.1  
v1.04 - Based on Facebook 11.2  
v1.02 - Based on Facebook SDK 7.0.0.  
v1.01 - Based on Facebook SDK 5.50.  
  
Download link: <https://www.b4x.com/android/files/facebook.zip>
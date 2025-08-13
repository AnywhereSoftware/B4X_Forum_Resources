### [class] Microsoft OAuth2 by josejad
### 12/10/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/164049/)

Hi there:  
  
I've adapted Erel's [Google Oauth2 class](https://www.b4x.com/android/forum/threads/class-b4x-google-oauth2.79426/) to login with Microsoft, adapting the [code from this post](https://www.b4x.com/android/forum/threads/logging-in-to-ms-365.148816/) (thanks [USER=23847]@stu14t[/USER])  
  
For now, it's just working on B4A. It works in **B4A and B4J, not tested in B4i.** Probably with [USER=1]@Erel[/USER] help it will work in B4i.  
  
MicrosoftOAuth2 class takes care of several tasks:  
  
1. Opening the browser and getting the authorization code.  
2. Getting and saving the access token and refresh token from the authorization code.  
3. Getting a new access token when it expires using the refresh token.  
  
**Setup**  
  
1. Go to <https://entra.microsoft.com> ->Aplication Developer->Register app. After registering your app, you will need your client\_id and your tenant\_id  
2. Configure your “API permissions”. You will need, at least “User.Read” permissions, and you have to see the green check. (I can't test the sendMail because I got no permissions from my IT Manager. You need the Mail.Send permission)  
  
![](https://www.b4x.com/android/forum/attachments/158479)  
  
**B4A**  
  
3. Still in microsoft web, go to “Authentication” and “Add a platform”. Select “Android”. Set the package name (**MUST** be the Package Name set in the B4A IDE (Ctrl-B))  
  
![](https://www.b4x.com/android/forum/attachments/158480)  
  
IMPORTANT: Package name (Nombre del paquete in the next image) must be the same that in the IDE  
"Sign HASH" ("Hash de firma" in the image) must be your Private key, in base64 format. In the example you will get your private key base64 hash in LOGS if you run the app. Copy it, and paste in the Microsoft page: (code from [this post](https://www.b4x.com/android/forum/threads/get-the-apk-signature-at-runtime.70490/#content))  
  

```B4X
Log("Use this sha1 base64 sign to register your app in ms: " & su.EncodeBase64(raw))  
result:  
Use this sha1 base64 sign to register your app in ms: 2pmj9i4rSx0yEb/viWBYkE/ZQrk= ‘FAKE
```

  
![](https://www.b4x.com/android/forum/attachments/158481)  
  
  
  
Using that code in the microsoft page you will get a “redirection URI” you must use it in order the browse redirects to your app  
  
![](https://www.b4x.com/android/forum/attachments/158482)  
  
Add to your APP Manifest this code, in order the browser returns to your app after login  

```B4X
AddActivityText(Main,  
<intent-filter>  
<action android:name="android.intent.action.VIEW" />  
<category android:name="android.intent.category.DEFAULT" />  
<category android:name="android.intent.category.BROWSABLE" />  
<data android:scheme="msauth"  
android:host="$PACKAGE$"  
android:path="2pmj9i4rSx0yEb/viWBYkE/ZQrk=" ‘The same you get in your LOG app  
/>  
</intent-filter>
```

  
  
**B4J**  
  
Go to “Authentication” and “Add a platform”. Select “Mobile and Desktop apps”. In redirection\_uri add: <http://127.0.0.1:51067>  
  
![](https://www.b4x.com/android/forum/attachments/158567)  
  
Set the client\_id and tenant\_id in B4XMain, and test!!  
  
Any improvement is welcome!!  
  
![](https://www.b4x.com/android/forum/attachments/158484) ![](https://www.b4x.com/android/forum/attachments/158486)  
  
  
![](https://www.b4x.com/android/forum/attachments/158558)
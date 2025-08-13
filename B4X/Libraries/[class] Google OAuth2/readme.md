### [class] Google OAuth2 by Erel
### 03/19/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/79426/)

**GoogleOAuth2 class is compatible with B4A, B4i and B4J (new).**  
  
It is no longer possible to use WebView to implement Google's OAuth2 authentication.  
The solution is to open the default browser and set the redirection uri in such a way that the browser will redirect the response back to our app.  
  
GoogleOAuth2 class takes care of several tasks:  
  
1. Opening the browser and getting the authorization code.  
2. Getting and saving the access token and refresh token from the authorization code.  
3. Getting a new access token when it expires using the refresh token.  
  
The process is documented here: <https://developers.google.com/identity/protocols/OAuth2InstalledApp>  
  
**Setup**  
  
1. Go to [Google developer console](https://console.developers.google.com), create a new project if needed and add a client id:  
  
![](https://www.b4x.com/basic4android/images/SS-2017-05-11_15.14.36.png)  
  
For the Android client you need to get the SHA-1 signature. It is available under Tools - Private Sign Key.  
Set the package name or bundle identifier fields to your app's package name.  
  
2. **B4A**:  
Add to the manifest editor:  

```B4X
AddActivityText(Main,  
  <intent-filter>  
  <action android:name="android.intent.action.VIEW" />  
  <category android:name="android.intent.category.DEFAULT" />  
  <category android:name="android.intent.category.BROWSABLE" />  
  <data android:scheme="$PACKAGE$" />  
  </intent-filter>  
   )
```

  
**B4i**:  
Change b4i.example2 with your package name.  

```B4X
#UrlScheme: b4i.example2
```

  
  
3. B4A code:  

```B4X
Sub Activity_Resume  
   oauth2.CallFromResume(Activity.GetStartingIntent)  
End Sub
```

  
B4i code:  

```B4X
Sub Application_OpenUrl (Url As String, Data As Object, SourceApplication As String) As Boolean  
   oauth2.CallFromOpenUrl(Url)  
   Return True  
End Sub
```

  
  
**B4J**:  
Create a new OAuth Client id with the type set to Other.  
You need to add both the client id and the client secret to the project (client secret is not required in the the mobile solutions).  
The Initialize methods expects two additional parameters: client secret and the path where the token will be stored.  
  
  
3. Initialize GoogleOAuth2 with the required scopes (based on the API that you want to call).  
Call GoogleOAuth2.GetAccessToken. The AccessTokenAvailable will be raised when the token is available.  
Once you have the access token, you can access the relevant Google web service.  
In this example we will access the People API. **You need to enable it in Google console.**  
Example:  

```B4X
Sub btnGetData_Click  
   oauth2.GetAccessToken  
   Wait For OAuth2_AccessTokenAvailable (Success As Boolean, Token As String)  
   If Success = False Then  
     ToastMessageShow("Error accessing account.", True)  
     Return  
   End If  
   Dim j As HttpJob  
   j.Initialize("", Me)  
   j.Download2("https://people.googleapis.com/v1/people/me", _  
       Array As String("access_token", Token, "requestMask.includeField", "person.email_addresses,person.birthdays,person.names"))  
   Wait For (j) JobDone(j As HttpJob)  
   If j.Success Then  
     ParsePersonData(j.GetString)  
   Else  
     ToastMessageShow("Online data not available.", True)  
   End If  
   j.Release  
End Sub
```

  
  
![](https://www.b4x.com/basic4android/images/SS-2017-05-11_15.25.44.png)  
  
![](https://www.b4x.com/basic4android/images/SS-2017-05-11_15.29.51.png)  
  
![](https://www.b4x.com/basic4android/images/SS-2017-05-11_15.30.18.png)  
  
![](https://www.b4x.com/basic4android/images/SS-2017-06-20_17.56.27.png)  
  
**Updates**:  
  
- B4XPages project is attached. Don't miss:  

- Different ClientId for each platform
- ClientSecret is only needed in B4J
- Manifest snippet in B4A
- #UrlScheme and Sub Application\_OpenUrl in B4i (Main module)

- v2.11: added "access\_type":"offline" to the token request. This is a new requirement for offline token refreshes. Thanks [USER=42649]@DonManfred[/USER]!
###  Supabase - Authentification SignIn with Google by Alexander Stolte
### 08/31/2023
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/149955/)

<https://www.b4x.com/android/forum/threads/b4x-supabase-the-open-source-firebase-alternative.149855/>  
  
In this example, we will take a look at how we can implement authentication using Google sign-in to secure our application using the Supabase SDK for B4X.  
  
**Configure the Client IDs on the Google developer console**  
We will obtain client IDs for B4I, B4A and B4J from the Google Cloud console, and register them to our Supabase project.  
  
1. Go to [Google developer console](https://console.developers.google.com/), create a new project if needed and add a client id:  
![](https://www.b4x.com/android/forum/attachments/145433)  
We need a separate Client Id for each platform.  

- **Type**

- B4A=Android
- B4I=Ios
- B4J=Web application

**For the B4A client** you need to get the SHA-1 signature. It is available under Tools - Private Sign Key.  
Set the package name or bundle identifier fields to your app's package name.  
![](https://www.b4x.com/android/forum/attachments/145438)  
**For the B4J client** you need to whitelist a uri:  

```B4X
http://127.0.0.1:3000
```

  
![](https://www.b4x.com/android/forum/attachments/145439)  
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

  
Add this to B4XMainPage:  

```B4X
Private Sub B4XPage_Foreground  
    #if B4A  
    xSupabase.Auth.CallFromResume(B4XPages.GetNativeParent(Me).GetStartingIntent)  
    #End If  
End Sub
```

  
**B4i**:  
Change b4i.example2 with your package name.  

```B4X
#UrlScheme: b4i.example2
```

  
Add this to the main module:  

```B4X
Private Sub Application_OpenUrl (Url As String, Data As Object, SourceApplication As String) As Boolean  
    B4XPages.MainPage.xSupabase.Auth.CallFromOpenUrl(Url)  
    Return True  
End Sub
```

  
**Configure Google sign-in on Supabase Auth**  
Open the Supabase Dashboard and got to: authentication -> Providers -> Google  
to set up Google auth. Toggle the Enable Sign in with Google switch first. Then add the 3 client IDs you obtained in your Google Cloud console to Authorized Client IDs field with a comma in between the two client IDs like this: ANDROID\_CLIENT\_ID,IOS\_CLIENT\_ID.  
![](https://www.b4x.com/android/forum/attachments/145435)  
  
**B4A, B4I and B4J Code**  
Simply insert the "xxx" with the client id from the respective platform. In B4J you still need the ClientSecret, you can also find it in the Google Dashboard.  

```B4X
    #If B4A  
    Wait For (xSupabase.Auth.SignInWithOAuth("xxx.apps.googleusercontent.com","google","profile email https://www.googleapis.com/auth/userinfo.email")) Complete (User As SupabaseUser)  
    #Else If B4I  
    Wait For (xSupabase.Auth.SignInWithOAuth("xxx.apps.googleusercontent.com","google","profile email https://www.googleapis.com/auth/userinfo.email")) Complete (User As SupabaseUser)  
    #Else If B4J  
    Wait For (xSupabase.Auth.SignInWithOAuth("xxx.apps.googleusercontent.com","google","profile email https://www.googleapis.com/auth/userinfo.email","xxx")) Complete (User As SupabaseUser)  
    #End If  
  
    If User.Error.Success Then  
        Log("successfully logged in with " & User.Email)  
        xui.MsgboxAsync("successfully logged in with " & User.Email, "SignIn with Google")  
    Else  
        Log("Error: " & User.Error.ErrorMessage)  
        xui.MsgboxAsync("Error: " & User.Error.ErrorMessage, "SignIn with Google")  
    End If
```

  
  
**Tips**  
It may be that you still need to enable the People API in the Google Dashboard.  
![](https://www.b4x.com/android/forum/attachments/145437)  
  
**That's it!**  
Now your users can easily log in to your app with google.
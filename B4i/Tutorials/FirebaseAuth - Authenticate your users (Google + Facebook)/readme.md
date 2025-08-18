### FirebaseAuth - Authenticate your users (Google + Facebook) by Erel
### 03/17/2021
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/68625/)

Start with this tutorial: <https://www.b4x.com/android/forum/threads/firebase-integration.68623/>  
  
FirebaseAuth allows your app to identify the user based on their Google or Facebook accounts.  
  
We will start with Google integration.  
  
![](https://www.b4x.com/android/forum/attachments/45733)  
  
1. Make sure that Google is enabled under Authentication - Sign-in methods:  
  
![](https://www.b4x.com/basic4android/images/SS-2016-07-04_15.25.27.png)  
  
2. Open GoogleService-Info.plist with a text editor and copy the key that is under REVERSED\_CLIENT\_ID:  
  
![](https://www.b4x.com/basic4android/images/SS-2016-07-04_15.28.07.png)  
  
3. Add this value with:  

```B4X
#UrlScheme: com.googleusercontent.apps.250280117927-3n8kkn0a8oveo2olg2tcnuefmntv5toi
```

  
  
4. Handle Application\_OpenUrl and call FirebaseAuth.OpenUrl. Note that the signature of Application\_OpenUrl has changed in v2.80:  
  

```B4X
Private Sub Application_OpenUrl (Url As String, Data As Object, SourceApplication As String) As Boolean  
   If auth.OpenUrl(Url, Data, SourceApplication) Then Return True  
   Return False  
End Sub
```

  
  
See the attached project. Don't forget to download GoogleService-Info.plist to Files\Special.  
  
iFirebaseAuth v2.51 is attached. It is an internal library. It adds a SignError (Error As Exception) event.
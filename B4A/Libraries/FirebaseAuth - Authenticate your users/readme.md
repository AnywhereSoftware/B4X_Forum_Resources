### FirebaseAuth - Authenticate your users by Erel
### 08/12/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/67875/)

This library requires B4A v6+.  
  
It allows the users to sign in to your app with their Google account (more identity providers will be added in the future).  
  
![](https://www.b4x.com/android/forum/attachments/44939)  
  
Like all Firebase services it is quite simple to integrate this service in your app.  
  
1. Follow this tutorial and make sure to add the Firebase Auth manifest snippet: <https://www.b4x.com/android/forum/threads/integrating-firebase-services.67692/>  
  
2. This service requires that the signing key SHA1 signature is set in the Firebase project settings:  
  
![](https://www.b4x.com/basic4android/images/SS-2016-06-13_16.36.56.png)  
  
You can find this value under Tools - Private Sign Key, in the signature field:  
  
![](https://www.b4x.com/basic4android/images/SS-2016-06-13_16.38.08.png)  
  
Initialize the FirebaseAuth object and call SignInWithGoogle to sign in. Note that the user will be signed in automatically when the program restarts.  

```B4X
Sub Process_Globals  
   Private auth As FirebaseAuth  
End Sub  
  
Sub Globals  
   Private lblName As Label  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
   If FirstTime Then  
     auth.Initialize("auth")  
   End If  
   Activity.LoadLayout("1")  
   If auth.CurrentUser.IsInitialized Then Auth_SignedIn(auth.CurrentUser)  
End Sub  
  
Sub btnSignIn_Click  
   auth.SignInWithGoogle  
End Sub  
  
Sub btnSignOut_Click  
   auth.SignOutFromGoogle  
   lblName.Text = "Goodbye!"  
End Sub  
  
Sub Auth_SignedIn (User As FirebaseUser)  
   Log("SignedIn: " & User.DisplayName)  
   lblName.Text = "Hello: " & User.DisplayName  
End Sub
```

  
  
Next:  
- Combine Google and Facebook: <https://www.b4x.com/android/forum/threads/facebook-extends-firebaseauth-to-support-facebook.67954/#post-430482>  
- Server verification of signed in users: <https://www.b4x.com/android/forum/threads/server-firebaseserver-backend-authentication-for-signed-in-users.68672/>  
  
FirebaseAuth is an internal library now. It is preinstalled with the IDE.  
  
Updates:  
v3.22 - Adds missing dependency: androidx.tracing:tracing
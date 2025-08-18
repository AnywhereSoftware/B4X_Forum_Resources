### User Authentication with Apple ID by Erel
### 08/05/2021
[B4X Forum - B4i - Libraries](https://www.b4x.com/android/forum/threads/113671/)

If you are using FirebaseAuth then use this class instead: <https://www.b4x.com/android/forum/threads/sign-in-with-apple-and-firebase.116280/>  
  
![](https://www.b4x.com/basic4android/images/i_view64_UN4n1t4ZCe.png)  
  
Starting from iOS 13 there is integral support for letting the user sign in with the user Apple ID.  
  
The AppleAuthButton is a custom view that manages authentication.  
  
You need to add the AuthResult event which will be raised when the user successfully signs in:  

```B4X
Sub AppleAuthButton1_AuthResult (Name As String, Email As String)  
    Msgbox($"Name: ${Name}  
Email: ${Email}"$, "")  
End Sub
```

  
  
Configuration:  
1. Enable 'Sign In With Apple' in the app identifier page in Apple developer console. The app id must be a non-wildcard id.  
2. Download an updated provision profile and set it with:  

```B4X
#ProvisionFile: xxx.mobileprovision
```

  
  
3. Add to main module:  

```B4X
#AdditionalLib: AuthenticationServices.framework  
#MinVersion: 13  
#Entitlement: <key>com.apple.developer.applesignin</key><array><string>Default</string></array>
```

  
  
4. Add the class to your project and add the custom view.  
  
Depends on: iXUI library.  
  
**Notes**  
  
The user will only be able to authenticate successfully once. The username and email are empty if the user tries to sign in again.  
This means that you must save the username and email and don't let the user sign in again.  
During development you can reset it in the settings app:  
  
Settings > Apple Id > Password & Security > Apple ID logins > {YOUR APP} > Stop using Apple ID
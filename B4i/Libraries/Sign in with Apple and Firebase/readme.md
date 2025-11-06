### Sign in with Apple and Firebase by Erel
### 11/05/2025
[B4X Forum - B4i - Libraries](https://www.b4x.com/android/forum/threads/116280/)

If you want to authenticate without Firebase: <https://www.b4x.com/android/forum/threads/user-authentication-with-apple-id.113671/#content>  
  
Make sure to use latest version of Firebase: <https://www.b4x.com/android/forum/threads/firebase-2-50-april-2020.116278/>  
  
It will only work with iOS 13. Most iOS devices run iOS 13+.  
  
Configuration:  
0. Configure FirebaseAuth as explained here: <https://www.b4x.com/android/forum/threads/firebaseauth-authenticate-your-users-google-facebook.68625/#content>  
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

  
  
4. Add the class to your project and add the custom view - AppleAuthButton. It depends on iXUI library.  
5. Enable Apple in Firebase console, under Authentication - Sign-in method.  
  
When the user signs in the Auth\_SignedIn event will be raised. Note that the name is likely to be empty. The email might be an anonymized email, based on the user selection.  
  
Note that this class is different than the class from the previous tutorial.  
  
Updates:  
  
v10.00 - Compatible with B4i v10.00.  
v1.01 - Adds Auth\_Error event inside the class.
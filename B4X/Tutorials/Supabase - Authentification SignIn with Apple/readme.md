###  Supabase - Authentification SignIn with Apple by Alexander Stolte
### 09/01/2023
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/149977/)

<https://www.b4x.com/android/forum/threads/b4x-supabase-the-open-source-firebase-alternative.149855/>  
  
In this example, we will take a look at how we can implement authentication using Apple sign-in to secure our application using the Supabase SDK for B4X.  
  
**SignIn with Apple is currently only available for B4I**  
  
It will only work with iOS 13. Most iOS devices run iOS 13+.  
  
**Configure the mobileprovision file on the Apple developer console**  
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

  
4. Add this code:  
We don't need a Client Id  

```B4X
    Wait For (xSupabase.Auth.SignInWithOAuth("","apple","")) Complete (User As SupabaseUser)'wen dont need a client id  
    If User.Error.Success Then  
        Log("successfully logged in with " & User.Email)  
    Else  
        Log("Error: " & User.Error.ErrorMessage)  
    End If
```

  
**Configure Apple sign-in on Supabase Auth**  
Open the Supabase Dashboard and got to: authentication -> Providers -> Apple  
to set up Apple auth. Toggle the Enable Sign in with Apple switch first. Then add the package name of your app:  
![](https://www.b4x.com/android/forum/attachments/145460)  
**That's it!**  
Now your users can easily log in to your app with apple.
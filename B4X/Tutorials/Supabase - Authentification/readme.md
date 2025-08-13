###  Supabase - Authentification by Alexander Stolte
### 04/17/2024
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/149856/)

<https://www.b4x.com/android/forum/threads/b4x-supabase-firebase-alternative.149855/>  
The client library does the work for you, you don't have to worry about renewing the access token or using and saving it.  
  
This is a very simple tutorial on how to use the auth options. A more detailed tutorial is coming soon.  
  
**SignUp**  
Allow your users to sign up and create a new account.  

```B4X
    Wait For (xSupabase.Auth.SignUp("test@example.com","Test123!")) Complete (NewUser As SupabaseUser)  
    If NewUser.Error.Success Then  
        Log("successfully registered with " & NewUser.Email)  
    Else  
        Log("Error: " & NewUser.Error.ErrorMessage)  
    End If
```

  
**Sign in anonymously**  
Allow your users to sign up without requiring users to enter an email address, password  
It is strongly recommended to enable invisible Captcha or Cloudflare Turnstile to prevent abuse for anonymous sign-ins, you can more read about in the forum thread.  

```B4X
    Wait For (xSupabase.Auth.LogIn_Anonymously) Complete (AnonymousUser As SupabaseUser)  
    If AnonymousUser.Error.Success Then  
        Log("Successfully created an anonymous user")  
    Else  
        Log("Error: " & AnonymousUser.Error.ErrorMessage)  
    End If
```

  
<https://www.b4x.com/android/forum/threads/b4x-supabase-sign-in-anonymously.160566/>  
**SignUp with additional user metadata**  
The options parameters are used to store additional information, e.g. user name, birthday, etc. in the user record when registering new users.  

```B4X
Dim AdditionalUserMetadata As Map = CreateMap("first_name":"Alexander","age":25)  
Wait For (xSupabase.Auth.SignUp("test@gmail.com","Test123!",AdditionalUserMetadata)) Complete (NewUser As SupabaseUser)
```

  
![](https://www.b4x.com/android/forum/attachments/147267)  
This information is then stored in the "raw\_user\_meta\_data" column in the Auth.Users table.  
To retrieve this info from a user, you can get the user object:  

```B4X
Wait For (xSupabase.Auth.GetUser) Complete (User As SupabaseUser)  
Log(User.Metadata.Get("username"))
```

  
  
**Login with E-Mail and Password**  
If an account is created, users can login to your app.  

```B4X
    Wait For (xSupabase.Auth.LogIn_EmailPassword("test@example.com","Test123!!")) Complete (User As SupabaseUser)  
    If User.Error.Success Then  
        Log("successfully logged in with " & User.Email)  
    Else  
        Log("Error: " & User.Error.ErrorMessage)  
    End If
```

  
**Update User**  
Update the user with a new email or password. Each key (email, password, and data) is optional  

```B4X
    Wait For (xSupabase.Auth.UpdateUser("test@example.com","")) Complete (Result As SupabaseError)  
    If Result.Success Then  
        Log("User data successfully changed")  
    Else  
        Log("Error: " & Result.ErrorMessage)  
    End If
```

  
**Password Recovery**  

```B4X
    wait for (xSupabase.Auth.PasswordRecovery("test@example.com")) Complete (Response As SupabaseError)  
    If Response.Success Then  
        Log("Recovery email sent successfully")  
    Else  
        Log("Error: " & Response.ErrorMessage)  
    End If
```

  
**Logout**  
User tokens are removed from the device  
After calling log out, all interactions using the Supabase B4X client will be "anonymous".  

```B4X
    Wait For (xSupabase.Auth.Logout) Complete (Result As SupabaseError)  
    If Result.Success Then  
        Log("User successfully logged out")  
    Else  
        Log("Error: " & Result.ErrorMessage)  
    End If
```

  
**Events**  
Don't forget to Initialize the event:  

```B4X
xSupabase.InitializeEvents(Me,"Supabase")
```

  

```B4X
Private Sub Supabase_AuthStateChange(StateType As String)  
    Select StateType  
        Case "passwordRecovery"  
            Log("Reset password was requested")  
        Case "signedIn"  
            Log("The user has logged in")  
        Case "signedOut"  
            Log("The user has logged out")  
        Case "tokenRefreshed"  
            Log("The Auth Token was updated")  
        Case "userUpdated"  
            Log("The email address and or password has been changed")  
        Case Else  
            Log("Unknown State Type")  
    End Select  
End Sub
```
###  PocketBase - Authentification by Alexander Stolte
### 01/29/2025
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/165333/)

<https://www.b4x.com/android/forum/threads/b4x-pocketbase-open-source-backend-in-1-file.165213/#content>  
  
Please read the official documentation about auth in pocketbase:  
<https://pocketbase.io/docs/authentication/>  
  
PocketBase authentication allows you to register users, log them in, manage their sessions, and perform various actions such as password resets and email changes. Below is an overview of the available functions with examples.  
  
**[SIZE=5]User Registration (SignUp)[/SIZE]**  
Allows new users to create an account.  

```B4X
    Wait For (xPocketbase.Auth.SignUp("test@example.com","Test123!","Test123!",Null)) Complete (NewUser As PocketbaseUser)  
    If NewUser.Error.Success Then  
        Log("successfully registered with " & NewUser.Email)  
    Else  
        Log("Error: " & NewUser.Error.ErrorMessage)  
    End If
```

  
[HEADING=2][SIZE=4]Parameters:[/SIZE][/HEADING]  

- **Email:** The user's email address.
- **Password:** The user's password.
- **PasswordConfirm:** Password confirmation.
- **Options**: A Map containing optional fields for additional user details.

```B4X
Dim options As Map  
options.Initialize  
options.Put("username", "testuser")  
  
Wait For (xPocketbase.Auth.SignUp("test@example.com", "Test123!", "Test123!", options)) Complete (NewUser As PocketbaseUser)
```

  
  
**[SIZE=5]Request Account Verification (RequestVerification)[/SIZE]**  
Sends a verification request to the user’s email.  

```B4X
    Wait For (xPocketbase.Auth.RequestVerification("test@example.com")) Complete (Success As PocketbaseError)  
    If Success.Success Then  
        Log("verification code send to email")  
    Else  
        Log("Error: " & Success.ErrorMessage)  
    End If
```

  
[HEADING=2][SIZE=4]Parameters:[/SIZE][/HEADING]  

- **Email:** The user's email address.

  
**[SIZE=5]Confirm Account Verification (ConfirmVerification)[/SIZE]**  
Confirms the user’s account using the verification token received via email.  

```B4X
    Wait For (xPocketbase.Auth.ConfirmVerification("xxx")) Complete (Success As PocketbaseError)  
    If Success.Success Then  
        Log("verification sucessfull")  
    Else  
        Log("Error: " & Success.ErrorMessage)  
    End If
```

  
**Parameters:**  

- **VerificationToken:** The token received via email.

  
**[SIZE=5]User Login with Email & Password (AuthWithPassword)[/SIZE]**  
Authenticates a user using their email and password.  

```B4X
    Wait For (xPocketbase.Auth.AuthWithPassword("test@example.com","Test123!")) Complete (User As PocketbaseUser)  
    If User.Error.Success Then  
        Log("successfully logged in with " & User.Email)  
    Else  
        Log("Error: " & User.Error.ErrorMessage)  
    End If
```

  
[HEADING=2][SIZE=4]Parameters:[/SIZE][/HEADING]  

- **Email:** The user's email address.
- **Password:** The user's password.

  
**[SIZE=5]Logout[/SIZE]**  
Removes user tokens and info from the device.  

```B4X
    Wait For (xPocketbase.Auth.Logout) Complete (Result As PocketbaseError)  
    If Result.Success Then  
        Log("successfully logged out")  
    Else  
        Log("Error: " & Result.ErrorMessage)  
    End If
```

  
  
**[SIZE=5]Get User Information (GetUser)[/SIZE]**  
Retrieves the current authenticated user’s information.  

```B4X
    Wait For (xPocketbase.Auth.GetUser) Complete (User As PocketbaseUser)  
    Log(User.Email)
```

  
  
**[SIZE=5]Update User Information (UpdateUser)[/SIZE]**  
Updates the user's profile details.  
Wait For (xPocketbase.Auth.UpdateUser(CreateMap("name":"Test Name"))) Complete (Success As PocketbaseError)  
**Parameters:**  

- **Options:** A Map containing the fields to be updated.

  
**[SIZE=5]Delete User (DeleteUser)[/SIZE]**  
Deletes the user’s account.  

```B4X
    Wait For (xPocketbase.Auth.DeleteUser) Complete (Result As PocketbaseError)  
    If Result.Success Then  
        Log("User Account deleted")  
    Else  
        Log("Error: " & Result.ErrorMessage)  
    End If
```

  
  
**[SIZE=5]Request Password Reset (RequestPasswordReset)[/SIZE]**  
Sends an email for resetting the user’s password.  

```B4X
    Wait for (xPocketbase.Auth.RequestPasswordReset("test@example.com")) Complete (Response As PocketbaseError)  
    If Response.Success Then  
        Log("Recovery email sent successfully")  
    Else  
        Log("Error: " & Response.ErrorMessage)  
    End If
```

  
**Parameters:**  

- **Email:** The user's email address.

  
**[SIZE=5]Confirm Password Reset (ConfirmPasswordReset)[/SIZE]**  
Confirms the password reset using the token received via email.  

```B4X
    Wait For (xPocketbase.Auth.ConfirmPasswordReset("xxx","Test123!","Test123!")) Complete (Response As PocketbaseError)  
    If Response.Success Then  
        Log("Password change successfully")  
    Else  
        Log("Error: " & Response.ErrorMessage)  
    End If
```

  
**Parameters:**  

- **Token:** The verification token from the email.
- **NewPassword:** The new password.
- **NewPasswordConfirm:** Confirmation of the new password.

  
**[SIZE=5]Request Email Change (RequestEmailChange)[/SIZE]**  
Sends a request to change the user’s email.  

```B4X
    Wait For (xPocketbase.Auth.RequestEmailChange("test@example.com")) Complete (Success As PocketbaseError)  
    If Success.Success Then  
        Log("E-Mail change request sent")  
    Else  
        Log("Error: " & Success.ErrorMessage)  
    End If
```

  
**Parameters:**  

- **NewEmail:** The new email address.

  
**[SIZE=5]Confirm Email Change (ConfirmEmailChange)[/SIZE]**  
Confirms the email change with a verification token.  

```B4X
    Wait For (xPocketbase.Auth.ConfirmEmailChange("xxx","Test123!")) Complete (Response As PocketbaseError)  
    If Response.Success Then  
        Log("E-Mail change successfully")  
    Else  
        Log("Error: " & Response.ErrorMessage)  
    End If
```

  
**Parameters:**  

- **Token:** The verification token from the email.
- **Password:** The user's password.

  
**[SIZE=5]Refresh Token (RefreshToken) - Optional[/SIZE]**  
Refreshes the user's authentication token.  
  
The B4X-Pocketbase library does this automatically internally, but if needed, you can update the access token this way  

```B4X
Wait For (xPocketbase.Auth.RefreshToken) Complete (Success As Boolean)  
  
If Success Then  
    Log("Token refreshed successfully")  
Else  
    Log("Error refreshing token")  
End If
```
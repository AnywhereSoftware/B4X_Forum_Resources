###  Firebase Auth REST API by Alexander Stolte
### 04/26/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/119935/)

Not all API commands I have implemented and tested, if you have problems, then ask in the comments or in a new thread.  
  
With this class you can register and log in your users via email and password. And a lot more…  
  
Setup:  

1. put your API Key in the Class\_Globals

1. [ICODE]Private const API\_KEY As String = "AIzaSyDPXXXXXX"[/ICODE]

**FirebaseAuthREST  
Author: Alexander Stolte  
Version: 1.1**  

- **FirebaseAuthREST**

- **Functions:**

- **changeEmail** (idToken As String, email As String, returnSecureToken As Boolean) As ResumableSub
*Change email  
 <https://firebase.google.com/docs/reference/rest/auth#section-change-email>  
 idToken - A Firebase Auth ID token for the user.  
 email - The user's new email.  
 returnSecureToken - Whether or not to return an ID and refresh token.*- **changePassword** (idToken As String, password As String, returnSecureToken As Boolean) As ResumableSub
*Change password  
 <https://firebase.google.com/docs/reference/rest/auth#section-change-password>  
 idToken - A Firebase Auth ID token for the user.  
 password - User's new password.  
 returnSecureToken - Whether or not to return an ID and refresh token.*- **Class\_Globals** As String
- **confirmEmailVerification** (oobCode As String) As ResumableSub
*Confirm email verification  
 <https://firebase.google.com/docs/reference/rest/auth#section-confirm-email-verification>  
 oobCode - The action code sent to user's email for email verification.*- **confirmPasswordReset** (oobCode As String, newPassword As String) As ResumableSub
*Confirm password reset  
 <https://firebase.google.com/docs/reference/rest/auth#section-confirm-reset-password>  
 oobCode - The email action code sent to the user's email for resetting the password.  
 newPassword - The user's new password.*- **createAuthUri** (identifier As String, continueUri As String) As ResumableSub
*Fetch providers for email  
 <https://firebase.google.com/docs/reference/rest/auth#section-fetch-providers-for-email>  
 identifier - User's email address  
 continueUri - The URI to which the IDP redirects the user back. For this use case, this is just the current URL.*- **deleteAccount** (idToken As String) As ResumableSub
*Delete account  
 <https://firebase.google.com/docs/reference/rest/auth#section-delete-account>  
 idToken - The Firebase ID token of the user to delete.*- **getErrorCode** (root As Map) As Int
*code: 400*- **getErrorMap** (root As Map) As Map
*reason: invalid  
 domain: global  
 message: EMAIL\_NOT\_FOUND*- **getErrorMessage** (root As Map) As String
*message: EMAIL\_NOT\_FOUND*- **Initialize** As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **sendEmailVerification** (requestType As String, idToken As String) As ResumableSub
*Send email verification  
 <https://firebase.google.com/docs/reference/rest/auth#section-send-email-verification>  
 requestType - The type of confirmation code to send. Should always be "VERIFY\_EMAIL".  
 idToken - The Firebase ID token of the user to verify.*- **sendPasswordResetEmail** (requestType As String, email As String) As ResumableSub
*Send password reset email  
 <https://firebase.google.com/docs/reference/rest/auth#section-send-password-reset-email>  
 requestType - The kind of OOB code to return. Should be "PASSWORD\_RESET" for password reset.  
 email - User's email address.*- **signInAnonymously** (returnSecureToken As Boolean) As ResumableSub
*Sign in anonymously  
 <https://firebase.google.com/docs/reference/rest/auth#section-sign-in-anonymously>  
 returnSecureToken - Whether or not to return an ID and refresh token. Should always be true.*- **signInEmailPW** (email As String, password As String, returnSecureToken As Boolean) As ResumableSub
*Sign in with email / password  
 <https://firebase.google.com/docs/reference/rest/auth#section-sign-in-email-password>  
 email - The email the user is signing in with.  
 password - The password for the account.  
 returnSecureToken - Whether or not to return an ID and refresh token. Should always be true.*- **signUpEmailPW** (email As String, password As String, returnSecureToken As Boolean) As ResumableSub
*Sign up with email / password  
 <https://firebase.google.com/docs/reference/rest/auth#section-create-email-password>  
 email - The email for the user to create.  
 password - The password for the user to create.  
 returnSecureToken - Whether or not to return an ID and refresh token. Should always be true.*- **verifyPasswordResetCode** (oobCode As String) As ResumableSub
*Verify password reset code  
 <https://firebase.google.com/docs/reference/rest/auth#section-verify-password-reset-code>  
 oobCode - The email action code sent to the user's email for resetting the password.*
  
You can get the map keys in the code or on the online documentation from Firebase  
<https://firebase.google.com/docs/reference/rest/auth#section-api-usage>  

```B4X
Wait For (fa_rest.signInEmailPW("myemail@lol.de","MySecurePassword123!",True)) complete (root As Map)  
   
    If root.Get("success") = True Then    
        For Each k As String In root.Keys  
            Log("Key: " & k & CRLF & "Value: " & root.Get(k))  
        Next    
    Else  
        Log("ErrorCode: " & fa_rest.getErrorCode(root))  
        Log("ErrorMessage: " & fa_rest.getErrorMessage(root))  
        Log("Reason: " & fa_rest.getErrorMap(root).Get("reason"))  
        Log("Domain: " & fa_rest.getErrorMap(root).Get("domain"))  
        Log("Message: " & fa_rest.getErrorMap(root).Get("message"))  
    End If
```

  

```B4X
Key: expiresIn  
Value: 3600  
Key: kind  
Value: identitytoolkit#VerifyPasswordResponse  
Key: displayName  
Value:  
Key: idToken  
Value: eyJhbGciOiJSUzI1NiIsImtpZCI6Ijc2MjNlMTBhMDQ1MTQwZjFjZmQ0YmUwNDY2Y2Y4MDM1MmI1OWY4MWUiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vZmlyLWF1dGhyZXN0IiwiYXVkIjoiZmlyLWF1dGhyZXN0IiwiYXV0aF90aW1lIjoxNTk0MjAxMzMxLCJ1c2VyX2lkIjoiSU90TjVqVmN1YWhjQWt2S0ExZWM0eDdPU0hHMiIsInN1YiI6IklPdE41alZjdWFoY0FrdktBMWVjNHg3T1NIRzIiLCJpYXQiOjE1OTQyMDEzMzEsImV4cCI6MTU5NDIwNDkzMSwiZW1haWwiOiJhbGV4Ljk4LnN0b2x0ZUBnbXguZGUiLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJhbGV4Ljk4LnN0b2x0ZUBnbXguZGUiXX0sInNpZ25faW5fcHJvdmlkZXIiOiJwYXNzd29yZCJ9fQ.PkoZaKyMxbz7U6s2fW2DQisGTgs5rbPJiqcJbVipopda1vi25iYGOyq0jDhaHdTFX4If_umKEsiRzWpncafKs7Kev1_aqDV-XAAHbEoO_zOyomsopRYIjzzL2NoUuSN-667ArzJURgA0VjB0s8GYN0hDeWqbISvq3Kgdu3569MQHDLd01BcFKc2-9Tv6ZoFGqsWTRWyZZmtu7PDga97vmsiQ01eiogmXY7giGbAMs4q9XdcP3vAzlYi8H5Tr61ywsKFhoPhhk6w4dH1o_RrErS5WiPKl-325QA-qZ99VBfMdgLoIyfCj898UbXP7cpq2E0vJrqMmdaALJsWfNhFzDg  
Key: registered  
Value: true  
Key: localId  
Value: IOtN5jVcuahcAkvKA1ec4x7OSHG2  
Key: email  
Value: myemail@lol.de  
Key: refreshToken  
Value: AE0u-NcTYspSYujdVRs5Bx3eXMoVDeDRUNX3NGUd9xWfq-ty8r7NDeDvEhX14GGWeoXdWpzwT2oTkBGU5QCNdqhcipb_wCbDgIXX9IZ6lyatl_tCEfhupu5zYD3hnYDVetT2diHrxUZfwqUR-ZJBHUlDtA_3VkAAXNUdXhychL2pY7BELgawWOkrwDJbndMrdfGuyMDYDJ1mHTmUDLabouTDykvtmVo7rg  
Key: success  
Value: true
```

  

```B4X
ErrorCode: 400  
ErrorMessage: EMAIL_NOT_FOUND  
Reason: invalid  
Domain: global  
Message: EMAIL_NOT_FOUND
```

  
**Changelog**  

- **1.00**

- Release

- **1.01**

- get Errors check if item in map exists
- Add refreshToken - Exchange a refresh token for an ID token

- **1.02**

- Add getUserData - Thanks to [USER=75340]@Blueforcer[/USER]

Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)
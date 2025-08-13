###  Firebase Auth REST Helper - manage the access tokens by Alexander Stolte
### 02/24/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/120016/)

The advantage of the rest API of Firebase auth is that it can be used cross platform. The downside is, we have to take care of the user access tokens ourselves. That's why I wrote this class, it works with the "[FirebaseAuthREST](https://www.b4x.com/android/forum/threads/b4x-firebase-auth-rest-api.119935/#content)" class.  
  
The class was inspired by [USER=1]@Erel[/USER] oauth2 class, adapted to my class  
<https://www.b4x.com/android/forum/threads/class-b4x-google-oauth2.79426/>  
For the attached example you need the FirebaseAuthREST class.  
<https://www.b4x.com/android/forum/threads/b4x-firebase-auth-rest-api.119935/#content>  
The class were tested in B4A.  
  
**FirebaseAuthRESTHelper  
Author: Alexander Stolte  
Version: 1.0**  

- **FirebaseAuthRESTHelper**

- **Events:**

- **AccessTokenAvailable** (Success As Boolean, Token As String)
- **Authenticate**
- **RefreshToken** (RefreshToken As String)

- **Functions:**

- **Class\_Globals** As String
- **GetAccessToken** As String
- **Initialize** (Target As Object, EventName As String) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **ResetToken** As String
- **TokenInformationFromResponse** (m As Map) As String

- **TokenInformations**

- **Fields:**

- **AccessExpiry** As Long
- **AccessToken** As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **RefreshToken** As String
- **Valid** As Boolean

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
  

```B4X
Dim farh As FirebaseAuthRESTHelper  
Dim far As FirebaseAuthREST  
  
farh.Initialize(Me,"farh")  
far.Initialize  
  
farh.GetAccessToken  
  
Private Sub farh_AccessTokenAvailable (Success As Boolean, Token As String)  
  
    Log("farh_AccessTokenAvailable")  
    Log("Success: " & Success)  
    Log("Token: " & Token)  
  
End Sub  
  
Private Sub farh_Authenticate  
  
    Log("farh_Authenticate")  
  
    Wait For (far.signInEmailPW("myemail@lol.de","Test123",True)) complete (root As Map)  
    If root.Get("success") = True Then  
  
        farh.TokenInformationFromResponse(root)  
  
    End If  
  
End Sub  
  
Private Sub farh_RefreshToken (RefreshToken As String)  
  
    Log("farh_RefreshToken")  
    Log("RefreshToken: " & RefreshToken)  
  
    Wait For (far.refreshToken("refresh_token",RefreshToken)) complete (root As Map)  
    If root.Get("success") = True Then  
  
        farh.TokenInformationFromResponse(root)  
  
    End If  
  
End Sub
```

  
  
**Changelog**  

- **1.00**

- Release

- **1.01**

- Add GetEmail - gets the email-address from the user

- **1.02**

- Add tag to TokenInformations

Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)
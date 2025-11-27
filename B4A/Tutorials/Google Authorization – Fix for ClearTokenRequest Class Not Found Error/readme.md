### Google Authorization – Fix for ClearTokenRequest Class Not Found Error by Mehrzad238
### 11/21/2025
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/169405/)

If you are using this example:  
  
[Google Authorization with AuthorizationClient](https://www.b4x.com/android/forum/threads/google-authorization-with-authorizationclient.169164/)  
  
Might encounter this error:  
  

```B4X
Clearing token cache  
Error occurred on line: 0 (GoogleAuthorization)  
java.lang.ClassNotFoundException: com.google.android.gms.auth$api$identity$ClearTokenRequest  
    at anywheresoftware.b4j.object.JavaObject.getCorrectClassName(JavaObject.java:289)  
    at anywheresoftware.b4j.object.JavaObject.InitializeStatic(JavaObject.java:75)
```

  
  
For the solution, just comment out this Sub (apparently you don't need it):  
  

```B4X
Public Sub ClearToken(Token As String) As ResumableSub  
    Dim ClearTokenRequest As JavaObject  
    ClearTokenRequest = ClearTokenRequest.InitializeStatic("com/google/android/gms/auth/api/identity/ClearTokenRequest".Replace("/", ".")) _  
        .RunMethodJO("builder", Null) _  
        .RunMethodJO("setToken", Array(Token)).RunMethod("build", Null)  
    Dim task As JavaObject = AuthorizationClient.RunMethod("clearToken", Array(ClearTokenRequest))  
    Do While task.RunMethod("isComplete", Null).As(Boolean) = False  
        Sleep(50)  
    Loop  
    Return task.RunMethod("isSuccessful", Null).As(Boolean)  
End Sub
```

  
  
And then use these two Sub for getting Info:  
  

```B4X
Private Sub Button1_Click  
    Dim scopes As List = Array("profile", "email")  
    Wait For (ga.AuthorizeMaybeAutomatic(scopes)) Complete (Result As AuthorizationResult)  
  
    If Result.Success = False Then  
        Log("Failed: " & Result.Error)  
        Return  
    Else If Result.ResolutionNeeded Then  
        Log("resolution needed…")  
        Wait For (ga.AuthorizeRequestAccess(Result)) Complete (Result As AuthorizationResult)  
        If Result.Success = False Then  
            Log("Failed: " & Result.Error)  
            Return  
        End If  
    End If  
  
    If Result.Token <> "" Then  
        Dim j As HttpJob  
        j.Initialize("", Me)  
  
        j.Download2("https://www.googleapis.com/oauth2/v3/userinfo", _  
            Array As String("access_token", Result.Token))  
  
        Wait For (j) JobDone(j As HttpJob)  
  
        If j.Success Then  
            Log("UserInfo: " & j.GetString)  
            ParseUserInfo(j.GetString)  
        Else  
            Log("Error: " & j.ErrorMessage)  
        End If  
  
        j.Release  
    End If  
End Sub  
  
Private Sub ParseUserInfo(json As String)  
    Dim p As JSONParser  
    p.Initialize(json)  
    Dim m As Map = p.NextObject  
  
    Log("ID: " & m.Get("sub"))  
    Log("Email: " & m.Get("email"))  
    Log("Name: " & m.Get("name"))  
    Log("Picture: " & m.Get("picture"))  
End Sub
```

  
  
  
I have tested it and it works 100%👍  
**Note: most of the time, you won't need the birthday, and you can get it from the user.**
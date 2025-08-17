### [Web] SithasoDaisy - Pocketbase User Authentication by Mashiane
### 09/12/2024
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/163053/)

Hi Fam  
  
[Download](https://github.com/Mashiane/SithasoDaisy-PocketBase-User-Authentication)  
  
One is able to perform User Authentication using Email / Password combination in PocketBase. The user must be defined in the users collection in pocketbase.  
  
![](https://www.b4x.com/android/forum/attachments/156837)  
  
The project in the download is a B4J / BANano based project that shows one how to perform user authentication using an email and a password.  
  
1. The administrator user is [email]admin@pocketbase.com[/email] and password is [email]admin@pocketbase.com[/email]123! This is the same as a user in the users collection  
2. The user details are stored in the beautify.json file of the project. This is used to create other users in the app.  
3. A user must exist on the users table to be able to log in usign their credentials.  
4. To run the demo, double click the bat file, this login screen will appear, login using [email]admin@pocketbase.com[/email] and [email]admin@pocketbase.com[/email]123!  
  
This template can be used to create Pocketbase based WebApps with user authentication.  
  
For the forgot password screen to work, email settings should be set on pocketbase. You can use your SMTP details for that.  
  
This is the example of the sign in code  
  

```B4X
Private Sub btnSignIn_Click (e As BANanoEvent)  
    e.PreventDefault  
    'reset the validations  
    mdlSignIn.ResetValidation  
    'validate each of the elements  
    mdlSignIn.Validate(email.IsBlank)  
    mdlSignIn.Validate(password.IsBlank)  
    'check the form status  
    If mdlSignIn.IsValid = False Then   
        app.ShowSwalError("Please provide all required information!")  
        Return  
    End If  
    '      
    app.pagepause  
    dblUsers.Initialize(Me, "dbusers", Main.ServerIP, "users")  
    banano.await(dblUsers.USER_AUTH_WITH_PASSWORD(email.value, password.value))  
    Dim up As profileType = dblUsers.UserProfile  
    If up.Size = 0 Then  
        app.pageresume  
        app.ShowSwalError("These login details could not be authenticated, please contact Admin!")  
        Return  
    End If  
    'get the data on form  
    Dim data As Map = mdlSignIn.GetData  
    'do we remember  
    If rememberme.Checked Then  
        'save settings using app name  
        SDUIShared.SetLocalStorage(Main.AppName, data)  
    Else  
        'remove settings  
        SDUIShared.DeleteLocalStorage(Main.AppName)  
    End If  
    'show nav & drawer  
    pgIndex.UpdateUserName(up.name)  
    pgIndex.UpdateUserAvatar(up.avatar)  
    pgIndex.IsAuthenticated(True)  
    'hide the modal  
    mdlSignIn.Hide  
    app.PageResume  
End Sub
```

  
  
  
You can use this guide.  
  
<https://github.com/pocketbase/pocketbase/discussions/458#discussioncomment-3651995>  
  
Related Content  
  
<https://www.b4x.com/android/forum/threads/web-mastering-pocketbase-your-ultimate-guide-to-a-flawless-sqlite-webserver-install-on-windows.161538/#content>
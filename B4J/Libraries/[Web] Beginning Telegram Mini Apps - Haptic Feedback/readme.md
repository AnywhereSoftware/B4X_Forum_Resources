### [Web] Beginning Telegram Mini Apps - Haptic Feedback by Mashiane
### 07/25/2024
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/162253/)

Hi Fam  
  
**What is Haptic Feedback?**  
  
Your sense of touch provides valuable information about the world around you, and haptics mimic these experiences. If you've played a racing video game and felt the controller vibrate when your vehicle rolled the track, you've experienced haptic feedback. Derived from the Greek word for "touch," this technology allows developers to incorporate the sense of touch into their simulation systems, which enhances the user experience. Additional haptic feedback examples include the sensations you feel when tapping your smartphone's keyboard and using surgical training simulators.  
  
For this example, we wanted to provide haptic feedback when a user does not enter sign in credentials.  
  
![](https://www.b4x.com/android/forum/attachments/155647)  
  
  
1. To experience this for yourself, open this link on your telegram via your mobile device.  
  
<https://t.me/SithasoHoldingsBot>  
  
On the sign in page, do not enter an email or password and press the sign in button.  
  
The code that makes this possible is this piece here. When the sign in is invalid, an error haptic feedback is pushed to the device.  
  

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
        pgIndex.TMA.WebApp.HapticFeedback.error  
        Return  
    End If  
    pgIndex.TMA.WebApp.HapticFeedback.success  
    'get the data on form  
    Dim data As Map = mdlSignIn.GetData  
    Log(data)  
    'do verification  
    'if verification = false return  
    'do we remember  
    If rememberme.Checked Then  
        'save settings using app name  
        SDUIShared.SetLocalStorage(Main.AppName, data)  
    Else  
        'remove settings  
        SDUIShared.DeleteLocalStorage(Main.AppName)  
    End If  
     
     
    'show nav & drawer  
    pgIndex.UpdateUserName("Anele 'Mashy' Mbanga")  
    pgIndex.UpdateUserAvatar("./assets/mashy.jpg")  
    pgIndex.IsAuthenticated(True)  
    'hide the modal  
    mdlSignIn.Hide  
    'pgDashboard.Show(app)  
End Sub
```

  
  
  
**Related Content:**  
  
UI Developed with [SithasoDaisy](https://www.b4x.com/android/forum/threads/web-sithasodaisy-tailwindcss-webapps-powered-by-b4x-banano.143950/#content)  
  
<https://core.telegram.org/bots/webapps#hapticfeedback>  
  
Source Code:  
  
<https://github.com/Mashiane/SithasoTMA>  
  
<https://www.b4x.com/android/forum/threads/web-beginning-telegram-mini-apps-with-banano.162232/>
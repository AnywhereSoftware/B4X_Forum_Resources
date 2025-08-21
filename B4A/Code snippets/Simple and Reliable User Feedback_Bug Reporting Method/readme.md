### Simple and Reliable User Feedback/Bug Reporting Method by JohnC
### 06/25/2020
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/119392/)

I used to have a "Send us your Comment" form in my app that sent me the user's comment/bug report by using a simple HTTP post to my website (so I would not have to embed any private email server credentials in the app), which was then converted to an email and sent to me.  
  
But often the user would misspell their email address in the form, so my replies would bounce, and then there would be no way to contact them back.  
  
So, I changed to using a new "Comment" activity and just have an editbox and a "Send" button on it. Then using the below code it will email me the user's comment using the user's own email app.  
  
By using the below "email" intent to launch the user's own email client, you can be assured the "replyto" address will be accurate, and this method doesn't require your app to have Internet Permission. Plus it gives the user confidence that your app is not sending any hidden data/files because the user can clearly see everything that is going to be sent before they actually send the email.  
  
The below code also adds some device info like it's SDK level and make/model that may be helpful in diagnosing any issue the user may be reporting. You could even customize it some more and include the name of the activity the user was on (prior to this "Comment" activity) so you will have some context to better understand what the user is talking about and what they were doing (because as you know users assume we can read their minds :))  
  
Another advantage of this method is that it will first present the user with a blank TextEdit box (txtCommand) so it will be clear to the user of where they should enter their comment. Then, after the user clicks the cmdSend button, thats when we add the extra device info to the end of their comment and then display the email message all ready to be sent. Because if we instead just skipped over the dedicated txtComment box and go directly to invoking the email intent with some pre-filled in device info in the body of the email, the opened email will look half-baked to the user because they then need to figure out where to put their comments in the body of the email (either above or below the pre-filled in device info) and they might even accidently delete some/all of the device info when they attempt to type in their comments. So, by first asking the user to enter their comments into a dedicated edittext box and THEN create the entire email message and have it all ready to be sent without requiring the user to do anything more (other then to "send" the email), it is (at least to me) the best foolproof way of doing this.  
  

```B4X
Sub cmdSend_Click  
    Dim in As Intent  
    Dim B As String  
  
    MsgboxAsync("Thank you for taking the time to send us your comment!" & CRLF & CRLF & "Your email program will open on the next screen and your comment will be all ready to send to us - Just click 'Send' in your email app","Send Comment")  
    Wait For MsgBox_Result (Result As Int)  
  
    B = txtComment.Text & CRLF & "____________________________" & CRLF  
    B = B & "App Version: " & GetAppVersion & CRLF  
    B = B & "Device Model: " & GetDeviceInfo & CRLF  
    B = B & "Device API Level: " & GetDeviceAPILevel  
  
    in.Initialize("android.intent.action.SENDTO", "mailto:")  
    in.PutExtra("android.intent.extra.EMAIL", Array As String("support@myappcompany.com"))  
    in.PutExtra("android.intent.extra.SUBJECT", "User Comment for MyApp")  
    in.PutExtra("android.intent.extra.TEXT", B)  
    StartActivity(in)  
  
    Activity.Finish  
End Sub
```

  
  
  

```B4X
Sub GetAppVersion As String  
    Dim PM As PackageManager  
    Try  
        Return PM.GetVersionName(GetPackageName)  
    Catch  
        Return ""  
    End Try  
End Sub  
  
Sub GetDeviceInfo As String  
       Dim P As Phone  
       Dim manu As String = p.Manufacturer  
       Dim modl As String = p.Model  
       Dim prod As String = p.Product  
       Return manu & " - " & modl & " - " & prod  
End Sub  
  
Sub GetDeviceAPILevel () As Int  
    Dim P As Phone  
    Return p.SdkVersion  
End Sub
```
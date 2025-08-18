### [B4x] Send SMS (Text Message), Dial Number, Send Email B4A and B4i - Code Snippets by MrKim
### 10/09/2021
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/128496/)

Here are 3 subs that work in both B4A and B4i to dial the phone, open text, and open mail using the default apps. They will not work out of the box as they contain code that is getting text which is particular to my app but they should be a good start.  
  
Some of this I had a hard time figuring out - mostly the ios sms stuff. I couldn't find it here. There was a lot of stuff about opening a messaging program but nothing I could find to just open the default app and sending the phone # and text. And there was a lot of figuring out to do. There is probably a way to do attachments as well but I don't need it. If someone want to figure that out and add it that would be great.  
  
The Android was pretty straightforward but the **ios is done with URLS and they can't contain spaces** and if there are spaces it just fails with no error. Spaces, CRLFs, etc. have to be replaced. Take a look at the sms for how to replace whitespace.  
  
**Edit:** You need to add the code to remove any whitespace from phone numbers as well. I know, you think, "but ios doesn't allow spaces if you use the phone keyboard." but trust me, users WILL find a way - cut and paste the phone from an email, for example.  
  
Note that if a phone number has spaces it will fail in ios as well.  
  
**NOTE** that I have not replaced everything, and in fact the email app does not replace anything because I didn't happen to need it. For som reason it works with spaces in the subject. The sms i had to replace the spaces in the body - go figure.  
  
Hope these help someone.  
(MP is just a reference to the B4XPages MainPage)  
  

```B4X
Sub EmailLbl_Click  
    Dim Src As Label = Sender  
Try  
    #If B4A  
        Dim mailapp As Email  
        mailapp.To.Add(Src.Text)  
        If MP.GroupCmboTxt.EqualsIgnoreCase("Show All") Then  
            mailapp.Subject = Dlookup("SELECT GroupName FROM PList WHERE ID = " & MP.SelectedUser & ";")  
        Else  
            mailapp.Subject = MP.GroupCmboTxt  
        End If  
        StartActivity(mailapp.GetIntent)  
    #ELSE If B4i  
        If Main.App.CanOpenURL("mailto:") = False Then  
            MP.xui.MsgboxAsync("Unable to open default email app. Is your email set up?", "Can't Send Email")  
        Else  
            Dim su As StringUtils  
            If MP.GroupCmboTxt.EqualsIgnoreCase("Show All") Then  
                Main.App.OpenURL($"mailto:?to=${Src.Text}&subject=${su.EncodeUrl(Dlookup("SELECT GroupName FROM PList WHERE ID = " & MP.SelectedUser & ";"), "utf8")}"$)  
            Else  
                Main.App.OpenURL($"mailto:?to=${Src.Text}&subject=${su.EncodeUrl(MP.GroupCmboTxt, "utf8")}"$)  
            End If  
        End If  
  
    #End If  
Catch  
    MP.xui.MsgboxAsync($"[plain]${LastException.Message}[/plain]"$, "Error in EmailLbl_Click")  
End Try  
End Sub  
  
Sub DialNumber(Num As String)  
Try  
    #If B4A  
        Dim CallReason As String = "In order for this program to dial phone numbers, your permission is required. The next screen will ask for that permission. If you deny permission, then this program can not dial phone numbers for you"  
        Dim PC As PhoneCalls  
        Dim RP As RuntimePermissions  
        If RP.Check(RP.PERMISSION_CALL_PHONE) = False Then        'if no existing phone call permission  
            MsgboxAsync(CallReason,"Call Permission")        'explain why this apps needs call permission  
            Wait For MsgBox_Result (Result As Int)  
            RP.CheckAndRequest(RP.PERMISSION_CALL_PHONE)        'prompt for permission  
            Wait For Activity_PermissionResult (Permission As String, AskResult As Boolean)  
            If AskResult = False Then    'user did not give permission  
                MsgboxAsync("User refused permission, cannot make calls.", "Call Permission")  
                Return    'abort dial  
            End If  
        End If  
        StartActivity(PC.Call(Num))     'dial number  
    #ELSE If B4i  
        If Main.App.CanOpenUrl("tel:") = False Then  
            MP.xui.MsgboxAsync("Unable to open phone app.", "Can't open phone")  
        Else  
            Num = Num.Replace(" ", "").Trim  
            Main.App.OpenUrl($"tel:${Num}"$)  
        End If  
    #End If  
Catch  
    MP.xui.MsgboxAsync($"[plain]${LastException.Message}[/plain]"$, "Error in DialNumber")  
End Try  
    
End Sub  
  
  
Sub SendText(Num As String, Msg As String)  
Try  
    #If B4A  
        Dim CallReason As String = "In order for this program to send texts, your permission is required. The next screen will ask for that permission. If you deny permission, then this program can not start a text message for you."  
        Dim RP As RuntimePermissions  
        If RP.Check(RP.PERMISSION_SEND_SMS) = False Then        'if no existing phone call permission  
            MsgboxAsync(CallReason, "Texts Permission")        'explain why this apps needs call permission  
            Wait For MsgBox_Result (Result As Int)  
            RP.CheckAndRequest(RP.PERMISSION_SEND_SMS)        'prompt for permission  
            Wait For Activity_PermissionResult (Permission As String, AskResult As Boolean)  
            If AskResult = False Then    'user did not give permission  
                MsgboxAsync("User refused permission, cannot start texts.", "Texts Permission")  
                Return    'abort text  
            End If  
        End If  
        Dim in As Intent  
        in.Initialize(in.ACTION_VIEW, $"sms:${Num}"$)       
        If Msg.Length > 0 Then in.PutExtra("sms_body", Msg)  
        StartActivity(in)  
        
    #ELSE If B4i  
        If Main.App.CanOpenUrl($"sms:"$) = False Then  
            MP.xui.MsgboxAsync("Unable to open text app.", "Can't open sms")  
        Else  
            If Msg.Length > 0 Then Msg = Msg.Replace(" ", "%20")  
            If Msg.Length > 0 Then Msg = Msg.Replace(CRLF, "%0D%0A")  
            Main.App.OpenUrl($"sms:${Num}&body=${Msg}"$)  
        End If  
  
    #End If  
Catch  
    MP.xui.MsgboxAsync(LastException.Message, "Error in SendText")  
End Try  
    
End Sub
```
### PHPMailer by Claude Obiri Amadu
### 10/27/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/135496/)

PHPMailer(<https://github.com/PHPMailer/PHPMailer>) is a code library to send emails safely and easily via PHP code from a web server.  
This B4A Library is to allow sending of Emails in B4A Apps with online PHP servers.  
The PHP code on your server("https://[host]/mailer/index.php") will be where mail would be processed and sent  
Upload the contents of mailer.zip to your server [yourdomain.com/mailer/index.php](http://yourdomain.com/mailer/index.php) will be **PHPDir**  

```B4X
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("Layout")  
    Dim Email As PHPMailer  
    Email.Initialize("Email",Me)  
    Email.PHPDir = "https://[host]/mailer/index.php"  
    Email.Message = $"Hi [Name]${CRLF}Thanks for registering.${CRLF}Below is your 4-digit code to activate your account."$  
    Email.PreHeader = "Header"  
    Email.CanButton = "1"'1 = True, 0 = False and will remove buttton  
    Email.ButtonAction = "1" '1 = #  
    Email.ButtonText = "This is a button"  
    Email.Receipient = "name@mail.com"  
    Email.Name = "Name"  
    Email.Subject = "Subject"  
    Email.Logo = "https://[host]/mailer/[logo.png]"  
    Email.EndText = ""  
    Email.SendEmail  
End Sub  
  
Sub Email_MailSent(Success As Boolean, Message As String)  
    Log(Success)  
    Log(Message)  
    If Success = False Then  
        ToastMessageShow("Failed to send email","Email")  
    Else  
        ToastMessageShow("Email Sent","Email")  
    End If  
End Sub
```

  
  
**Demo Mail sent**  
  
![](https://www.b4x.com/android/forum/attachments/120844)
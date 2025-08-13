###  SMTP Errors by yiankos1
### 06/27/2024
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/161844/)

Hello team,  
  
I have lost three days in order to find out how SMTP library works with SMTP services(smtp2go, Sendpulse etc…) without errors about RCPT and more….  
  

```B4X
Private SMTP As SMTP  
  
SMTP.Initialize("mail.smtp2go.com",587,"username","password","SMTP")  
  
SMTP.Subject = "Subject"  
SMTP.Body = "Body"  
  
SMTP.To.add("recipient@mail.com")  
SMTP.MailFrom="sender@yourdomain.com" 'DO NOT FORGET TO ADD YOUR DOMAIN SENDER MAIL  
SMTP.Sender="sender@yourdomain.com" 'DO NOT FORGET TO ADD YOUR DOMAIN SENDER MAIL  
  
SMTP.StartTLSMode = True  
  
SMTP.Send  
  
Wait For SMTP_MessageSent(Success As Boolean)  
Log(Success)  
If Success Then  
    Log("Success")  
Else  
    Log("Error sending email")  
    Log(LastException.Message)  
End If
```
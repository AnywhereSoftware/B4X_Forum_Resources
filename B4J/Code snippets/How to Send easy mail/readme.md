### How to Send easy mail by Brian Michael
### 06/08/2021
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/131472/)

Hi, i was searching a easy tutorial for send a Mail, and there're many post but they don't explain easy how to send a mail easy. So i will share with you how i do it!  
  
  
First you need to load the Net library, its a Internal Library.  
  
Then create a Global Variable:  
  

```B4X
Public SMTP As SMTP
```

  
  
Add this code to your project:  
  

```B4X
Public Sub SendMail(Subject As String, Body As String, MailTo As String)  
      
    SMTP.Initialize(MailServer,MailPort,YourEmail,EmailPassword,"SMTP")  
    SMTP.Subject = Subject  
    SMTP.Body = Body  
    SMTP.To.Add(MailTo)  
    SMTP.StartTLSMode = True  
    SMTP.Send  
      
End Sub  
  
Sub SMTP_MessageSent(Success As Boolean)  
    Log(Success)  
    If Success Then  
        Log("Message sent successfully")  
    Else  
        Log("Error sending message")  
        Log(LastException.Message)  
    End If  
End Sub
```

  
  
You have to replace:  
  
MailServer: The Server of you mail provider.  
Ex..: Google : "smtp.gmail.com"  
MailPort: 587  
Your Email - EmailPassword  
  
Result its something like:  
  

```B4X
    SMTP.Initialize("smtp.gmail.com",587,"test@gmail.com","1234","SMTP")
```

  
  
For Use the code just add this line:  
  

```B4X
SendMail("Test Message","This messages come from B4X Project","mailto@gmail.com")
```

  
  
I hope help you with this tutorial.  
  
  
Regards!
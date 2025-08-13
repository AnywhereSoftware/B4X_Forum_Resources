### Send Mail via VBScript/PowerShell from B4J via local installed Outlook 20x/365 by KMatle
### 01/17/2024
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/158697/)

This is a small example how to send Emails via VBScript/Powershell via Outlook (must be installed on your pc!). Works on Outlook 365, too.  
  
The B4J App has two buttons (VBScript or PowerShell), creates the related scripts and executes them. You can add more parameters like to send attachements. See the Microsoft documentation about sending mails: [MailItem](https://learn.microsoft.com/en-us/office/vba/api/outlook.mailitem)  
  
For security reasons the mails are stored as drafts via  
  

```B4X
$email.Save()
```

  
  
Change it to   
  

```B4X
$email.Send()
```

  
  
to send directly.
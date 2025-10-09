### New Net library - Android FTP, SMTP and POP3 by Erel
### 10/06/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/10892/)

The Net library supports FTP, SMTP and POP3 protocols. This library replaces the FTP library. Both regular connections and SSL connections are supported.  
SMTP - Allows to directly connect to SMTP mail servers and send mails, including Html messages and attachments.  
POP3 - Allows to directly connect to POP3 mail servers and download messages. Currently the messages are not parsed. The raw string is returned. You can use MailParser class to parse the raw messages.  
  
Installation instructions:  
- Download the attach file.  
- Copy Net.xml and Net.jar to the additional libraries folder. Make sure that there are no older copies in the internal libraries folder.  
  
**V1.83** - Fixes an issue with SMTP and IPv6 clients.  
**V1.80** - SMTP, POP and FTP can be configured to use a custom trust manager. This allows accepting invalid certificates.  
  
**V1.77 -** New Sender.MailFrom field. Allows setting the mail address that is sent with the MAIL command. By default it is the same as the Username field.  
  
**V1.75 -** Adds a configurable timeout parameter - FTP.TimeoutMs. Default timeout is set to 60000 (60 seconds).  
  
**V1.70 -** Adds support for calling with Wait For: <https://www.b4x.com/android/forum/threads/b4x-net-library-ftp-smtp-pop-with-wait-for.84821/>  
SMTP.AdditionalHeaders map. Allows adding headers to the messages.  
  
**V1.63** - Fixes an issue with SMTP mails with attachments. The closing boundary was previously missing.  
**V1.62 -** Fixes an issue with SMTP in StartTLS mode.  
**V1.61 -** Fixes an issue in SMTP related to the content encoding not being set in multipart messages.  
  
**V1.60 -** New method: FTP.AppendFile. Similar to UploadFile. Appends the data to an existing file if such exists. It sends the APPE FTP command.  
  
**V1.53 -** Fixes an issue with FTP.CloseNow and SSL connections.  
  
**V1.52 -** Adds support for different types of authentication methods (SMTP): <http://www.b4x.com/android/forum/threads/new-net-library-android-ftp-smtp-and-pop3.10892/page-11#post-232432>  
  
**V1.51 is released.** Fixes an issue with FTP over SSL explicit mode.  
  
**V1.50 is released. See this link:** <http://www.b4x.com/android/forum/threads/new-net-library-android-ftp-smtp-and-pop3.10892/page-10#post-231145>  
  
**V1.37 is released. This version removes the automatic escaping of '=' characters in SMTP messages. To implement it in your code you should write:**  

```B4X
SMTP.Body = SMTP.Body.Replace("=", "=3D")
```

  
  
  
**V1.35 is released. This version adds support for STARTTLS mode.**  
Unlike UseSSL mode the connection is "upgraded" to a secured connection only after the client sends the STARTTLS command.  
Most of the popular smtp servers support this mode, usually on port 587.  
  

```B4X
Sub Activity_Create(FirstTime As Boolean)  
   If FirstTime Then  
      smtpClient.Initialize("smtp.gmail.com", 587, "xxx@gmail.com", "yyy", "SmtpClient")  
      smtpClient.StartTLSMode = True  
   End If  
End Sub
```
###  Solving encoding issues with html mails sent with SMTP (Net library) by Erel
### 03/14/2021
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/128146/)

Encoding the html text with base64 avoids encoding issues, especially with MS Outlook.  
This code is compatible with B4A and B4J:  

```B4X
Dim su As StringUtils  
smtp.Body = su.EncodeBase64(html.GetBytes("utf8")) 'html = the html body  
smtp.AdditionalHeaders.Put("Content-Transfer-Encoding", "BASE64")
```

  
  
Note that it will not work with messages with attachments.
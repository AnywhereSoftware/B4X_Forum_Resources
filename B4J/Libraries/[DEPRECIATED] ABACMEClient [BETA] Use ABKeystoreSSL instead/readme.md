### [DEPRECIATED] ABACMEClient [BETA] Use ABKeystoreSSL instead. by alwaysbusy
### 02/28/2021
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/128081/)

**DEPRECIATED: Use ABKeystoreSSL instead <https://www.b4x.com/android/forum/threads/abkeystoressl-ssl-certificate-generator-using-lets-encrypt.128115/>**  
  
———————————————–  
  
This is a library to create HTTPS credentials for jServer Web Apps.  
  
As I'm currently blocked for some time from Let's Encrypt because I did to many requests, this is just a beta you can test.  
  
**> [SIZE=6]Save the generated user.key and domain.key in a secure place! IF YOU LOSE THEM, THERE IS NO WAY TO RECOVER YOUR ACCOUNT![/SIZE]**  
  
  
1. You must have a domain and a web server like Apache running on port 80!  
2. Copy ALL the files in the .zip to your Additional Libraries folder  
  
Usage (just an non-UI B4J app e.g. called Maker):  

```B4X
Sub AppStart (Args() As String)  
    Dim client As ABACMEClient  
    ' needs to be the 'entry point' in your webserver (NOT your B4X app). In my case it was var/www/html and not var/www/)  
    ' MUST be accessible on port 80  
    client.Initialize("./html/")  
  
    Dim domains As List  
    domains.Initialize  
    domains.Add("banano.always-busy.com")  
  
    ' to prevent the code to run when compiling on release. args can be anything when you run it from your server  
    If Args.Length > 0 Then  
        ' will print whatever you have added  
        Log(Args(0))  
        ' using the real Let's Encrypt production server  
        Log(client.fetchCertificate(domains, "keystore", "01234", "56789", True))  
    Else  
        ' using the developers server of Let's Encrypt  
        Log(client.fetchCertificate(domains, "keystore", "01234", "56789", False))  
    End If  
End Sub
```

  
  
This app was placed in the /var/www/ folder and then started with 'java -jar maker.jar somethingtotriggertheargs'  
  
It will create a keystore.jks file that you can use in your jServer Web App (or ABMaterial):  

```B4X
Server.StartServerHTTP2("keystore.jks", "01234", "56789")
```

  
  
NOTE: credentials created in developers mode will show in the browser as not correct, but still run in HTTP/2 mode. This is a Let's encrypt limitation.  
 Also, **READ THE LOGS**. There is important info in it (and you can ignore the ones about SLF4J, this is because I show the logs in the B4J pane)  
  
Download: <http://gorgeousapps.com/ABACMEClient.zip>  
  
Alwaysbusy
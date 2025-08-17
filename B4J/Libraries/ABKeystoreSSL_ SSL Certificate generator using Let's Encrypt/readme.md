### ABKeystoreSSL: SSL Certificate generator using Let's Encrypt by alwaysbusy
### 11/08/2024
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/128115/)

This library allows you to generate SSL Certificates without the need of using the openssl and keytool tools. It can also reload a certificate in a jServer app (also ABMServer or BANanoServer) at runtime (the reload is based on the code [USER=97072]@OliverA[/USER] provided).  
  
![](https://www.b4x.com/android/forum/attachments/108835)  
  
Download: <https://gorgeousapps.com/ABKeystoreSSL1.08b.zip>  
  
  
> **Save the generated user.key and domain.key in a secure place! IF YOU LOSE THEM, THERE IS NO WAY TO RECOVER YOUR ACCOUNT!**

  
1. You must have a domain and a web server like Apache running on port 80!  
2. Copy ALL the files in the .zip to your Additional Libraries folder  
3. credentials created in developers mode will show in the browser as not correct, but still run in HTTP/2 mode. This is a Let's encrypt limitation.  
 Also, **READ THE LOGS**. There is important info in it (and you can ignore the ones about SLF4J, this is because I show the logs in the B4J pane instead)  
  
**[SIZE=5]ABKeystoreSSL[/SIZE]  
  
Author:** Alain Bailleul  
**Version:** 1.07  

- **ABKeystoreSSL**

- **Functions:**

- **GenerateJKS** (myDomains As List, dir As String, keyStoreFileNameNoExtension As String, keyStorePassword As String, keyManagerPassword As String, forProduction As Boolean, vault As String, ForceGenerate As Boolean) As Boolean
*Generates a certificate for the given domains. Also takes care for the registration process. ***domains: Domains to get a common certificate for *dir: folder where to put the generated keystore .jks file  
   
 keyStoreFileNameNoExtension: name of your keystore file (without the .jks extension)  
   
 keyStorePassword: the keyStore password you want to use in your jServer  
   
 keyManagerPassword: the keyManager password you want to use in your jServer  
   
 forProduction: if true uses "acme://letsencrypt.org", else "acme://[letsencrypt.org/staging](http://letsencrypt.org/staging)"  
   
 vault: a folder name where your key files should be stored/retrieved.  
 a submap with the keyStoreFileNameNoExtension will be created.   
   
 ForceGenerate: if true then the jks file will be generated, ignoring the fact if may not be needed as it is still valid   
   
 TIP: Use the GetNotBefore and GetNotAfter methods right after running fetchCertificate to find the valid date range.  
   
 Those dates are also saved in your vault location as 'range.times'.*****- **GenerateSelfSignedJKS** (dir As String, keyStoreFileNameNoExtension As String, keyStorePassword As String, keyManagerPassword As String, vault As String) As Boolean
*Generates a self signed certificate for development purposes.*
dir: folder where to put the generated keystore .jks file
keyStoreFileNameNoExtension: name of your keystore file (without the .jks extension)
keyStorePassword: the keyStore password you want to use in your jServer
keyManagerPassword: the keyManager password you want to use in your jServer
vault: a folder name where your key files should be stored/retrieved.
a submap with the keyStoreFileNameNoExtension will be created.- **GetNotAfter** As Long
*Can only be called right after the GenerateJKS() call.  
 Is also saved in your vault location/{keystoreFileNameNoExtension} as 'range.times'.*- **GetNotBefore** As Long
*Can only be called right after the GenerateJKS() call.  
 Is also saved in your vault location/{keystoreFileNameNoExtension} as 'range.times'.*- **Initialize** (wwwFolder As String)
*wwwFolder: needs to be the 'entry point' in your webserver (NOT your B4X app). In my case it was var/www/html and not var/www/)  
 MUST be accessible on port 80. Is for example your Apache Server.*- **ReloadJKS** (SslConfiguration As SslContextFactory)
*Reloads the SslConfiguration of the jServer  
   
 Based on the reloadSSLConfiguration method written by OliverA  
More info: <https://www.b4x.com/android/forum/threads/access-to-sslfactory-in-jserver-or-implementation-of-sslcontextfactory-reload.128051/#post-802925>*
- **Properties:**

- **DomainChainFile** As String [write only]
*File name of the signed certificate. Default domain-chain.crt*- **DomainCsrFile** As String [write only]
*File name of the CSR. Default domain.csr*- **DomainKeyFile** As String [write only]
*File name of the Domain Key Pair. Default domain.key  
   
 If the file does not exist, a new key pair is generated and saved.*- **UserKeyFile** As String [write only]
*File name of the User Key Pair. Default user.key  
   
 If the file does not exist, a new key pair is generated and saved.  
   
 Keep this key pair in a safe place! In a production environment, you will not be  
 able to access your account again if you should lose the key pair.*
  
Example usage (here for ABMServer Webapp, but similar for a normal jServer App or a BANanoServer Webapp).  
  
Requires a server that is purely accessible on port 80. Is e.g. an Apache server.  
  

```B4X
#Region  Project Attributes  
    #CommandLineArgs:  
    #MergeLibraries: True  
#End Region  
  
Sub Process_Globals  
    Public Server As ABMServer 'requires 1.23+  
    Public MyTheme As ABMTheme  
    Public ABM As ABMaterial 'ignore  
  
   ' JKS variables  
    Public JKS As ABKeystoreSSL  
    Public JKSReloadTimer As Timer  
  
    Public JKSName As String = "keystore"  
    Public JKSStorePassword As String = "01234"  
    Public JKSManagerPassword As String = "56789"  
End Sub  
  
Sub AppStart (Args() As String)  
    ' must be the first line in AppStart. DO NOT DELETE OR CHANGE!  
    ' ————————————————————  
    ABM.SessionCacheControlV3 = "ABMCacheV3"  
    ' ————————————————————  
  
    Dim DonatorKey As String = ""  
    Server.Initialize("", DonatorKey, "template") ' Application = ' the handler that will be used in the url e.g. http://localhost:51042/template  
    ' some parameters  
    Server.Port = 51042  
    Server.PortSSL = 51043  
  
    …  
  
    ' create the pages  
    Dim myPage As ABMPageTemplate  
    myPage.Initialize      
    ' add the pages to the app  
    Server.AddPage(myPage.page)  
    ' do the same for your own pages: dim, initialize and Server.AddPage  
    ' …  
   
    ' start the server  
    If Server.PortSSL <> 0 Then  
        ' make the jks file (if needed)  
        MakeJKS  
   
        If File.Exists(File.DirApp, JKSName & ".jks") Then  
            Log("Starting server in HTTPS mode…")  
            Server.StartServerHTTP2(JKSName & ".jks", JKSStorePassword, JKSManagerPassword)  
   
            ' set a timer for a day  
            JKSReloadTimer.Initialize("JKSReloadTimer", 24*60*60*1000)  
            JKSReloadTimer.Enabled = True  
        Else  
            ' start it without https  
            LogError("Failed to open or create " & JKSName & ".jks" & ". Starting server in HTTP mode…")  
            Server.StartServer  
        End If  
    Else  
        Server.StartServer  
    End If  
  
    ' redirect the output of the logs to a file if in release mode  
    Server.RedirectOutput(File.DirApp, "logs.txt")  
      
    StartMessageLoop  
End Sub  
  
' creates a certificate with Let's Encrypt  
Sub MakeJKS() As Boolean  
    Dim Result As Boolean  
    ' needs to be the 'entry point' in your webserver (NOT your B4X app). In my case it was var/www/html and not var/www/)  
    ' MUST be accessible on port 80  
    JKS.Initialize("/var/www/html/")  
  
    Dim domains As List  
    domains.Initialize  
    domains.Add("yourdomain.com")  
  
    ' when developing, I check here if it is my local PC. If so I do not use the production server of Let's Encrypt  
    If ABM.GetMyIP = "192.168.86.150" Then  
        Result = JKS.GenerateJKS(domains, File.DirApp, JKSName, JKSStorePassword, JKSManagerPassword, False, "K:\KeyVault", False)  
        If File.Exists(File.DirApp, JKSName & ".jks") = False Then  
            ' let's try to make a self signed certificate for development  
            LogError("Failed to open or create " & JKSName & ".jks with Let's Encrypt. Let's try to make a self signed one…")  
            Result = JKS.GenerateSelfSignedJKS(File.DirApp, JKSName, JKSStorePassword, JKSManagerPassword, "K:\KeyVault")  
        End If  
    Else  
        Result = JKS.GenerateJKS(domains, File.DirApp, JKSName, JKSStorePassword, JKSManagerPassword, True, "../KeyVault", False)  
    End If  
  
    Return Result  
End Sub  
  
Sub JKSReloadTimer_Tick  
    If MakeJKS Then  
        ' we created a new one, so reload it in the server  
        JKS.ReloadJKS(Server.GetSSLConfiguration)  
    End If  
End Sub
```

  
  
Alwaysbusy
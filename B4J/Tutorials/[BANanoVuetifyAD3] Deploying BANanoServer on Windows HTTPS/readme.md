### [BANanoVuetifyAD3] Deploying BANanoServer on Windows HTTPS by Mashiane
### 11/05/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/135745/)

Ola  
  
Remember: The jetty webserver is a self encompassing webserver. These is no need for laragon development webserver here. This is detailing a step by step process on how we have managed to make this work without hurdles.  
  
**Step 1:**  
  
Download the [ABKeyStoreSSL](https://www.b4x.com/android/forum/threads/abkeystoressl-ssl-certificate-generator-using-lets-encrypt.128115/) libraries to your external libraries folder. This will help create certificates for the server to run on. Dont forget the additional resources needed and specified there.  
  
**Step 2:**  
  
This works with JDK 11 onwards, Java JDK 64 bit, sadly struggles, apparently the "old ways" dont work. Also you kinda need a capable machine for this. I have experience b4j IDE degradation due to my challenged machine. The reason for using JDK 11 was this:  
  
![](https://www.b4x.com/android/forum/attachments/121226)  
  
**Step 3:**  
  

- Download and run the [BANanoVuetifyAD3 library source code](https://github.com/Mashiane/BANanoVuetifyAD3/tree/main/Library). This will compile the b4xlib from the source code source code.
- Also ensure that the [External Libraries](https://github.com/Mashiane/BANanoVuetifyAD3/tree/main/External%20Libraries) are copied to your B4J external libraries
- Download the [BANanoVuetifyAD3 BANanoServer Kitchen Sink](https://github.com/Mashiane/BANanoVuetifyAD3/blob/main/BVAD3Server.zip), we will use this to deploy our tests.
- This deployment test should work for all other BANanoVuetifyAD3 BANanoServer projects

  
**NB: The linked BANanoVuetifyAD3 BANanoServer Kitchen Sink above has already been set for the steps below, just update it to suit your needs.  
  
Step 4**  
  

- Decide on ports you will use, for this test we used Port 2096 for SSL and port 2095 for normal traffic.
- Update the Files > config.properties file to reflect your host and your ports configuation. For Windows HTTPS we have used these settings

  

```B4X
Host=https://localhost  
Port=2095  
PortSSL=2096
```

  
  
**Step 5**  
  
Ensure you have these defined in Main\_Process\_Globals  
  

```B4X
Public JKS As ABKeystoreSSL  
    Public JKSReloadTimer As Timer  
    Public JKSName As String = "jksname"  
    Public JKSStorePassword As String = "jkspassword"  
    Public JKSManagerPassword As String = "jksmanagerpassword"
```

  
  
**Step 6**  
  
Update Main.App\_Start, we added this after Server.StartPage = config.Get("StartPage")  
  
  

```B4X
' lets start the B4J server  
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
```

  
  
**Step 7**  
  
Here you need the entry point and your domain. You can find the entry point from your FTP target location of your server. Usually for some linux machines this start with var.  
  

```B4X
' creates a certificate with Let's Encrypt  
Sub MakeJKS() As Boolean  
    Dim Result As Boolean  
    ' needs to be the 'entry point' in your webserver (NOT your B4X app). In my case it was var/www/html and not var/www/)  
    ' MUST be accessible on port 80  
    JKS.Initialize("/www")  
  
    Dim domains As List  
    domains.Initialize  
    domains.Add("https://mydomain.com")  
  
    ' when developing, I check here if it is my local PC. If so I do not use the production server of Let's Encrypt  
    Result = JKS.GenerateJKS(domains, File.DirApp, JKSName, JKSStorePassword, JKSManagerPassword, False, "C:\KeyVault", True)  
    If File.Exists(File.DirApp, JKSName & ".jks") = False Then  
        ' let's try to make a self signed certificate for development  
        LogError("Failed to open or create " & JKSName & ".jks with Let's Encrypt. Let's try to make a self signed one…")  
        Result = JKS.GenerateSelfSignedJKS(File.DirApp, JKSName, JKSStorePassword, JKSManagerPassword, "C:\KeyVault")  
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

  
  
**Step 8**  
  
Run your BANanoVuetifyAD3 WebApp and enter the http port on the browser e.g. **<http://localhost:2096/index>  
  
Step 9**  
  
Confirm that you want to continue on the site.  
  
![](https://www.b4x.com/android/forum/attachments/121227)  
  
**Step 10: You are running on HTTPS and certificate is valid.**  
  
  
![](https://www.b4x.com/android/forum/attachments/121230)  
  
![](https://www.b4x.com/android/forum/attachments/121229)  
  
That's it!  
  
All the best
### [server] LetsEncrypt SSL certificates by Erel
### 03/03/2024
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/159285/)

[LetsEncrypt](https://letsencrypt.org/) provides SSL certificates for free. The certificates are created and renewed using a tool named certbot. The process can be a bit confusing, especially if you want to automate it.  
As B4J servers can run "forever" a solution that automates the steps and allows hot reloading of the renewed certificate is needed.  
The attached class takes care of:  

1. Periodically calling certbot for a certificate creation or renewal. Certbot will not do anything if the existing certificate isn't close to its expiration date.
2. Using OpenSSL + Java keytool to convert the certificate to a Java keystore that can be loaded by B4J server.
3. Hot reloading of the new certificate.

Certbot creates a file under the B4J server www folder (through the file system) and then makes a http call to read and verify this file. This is done to verify the domain.  
  
Requirements:  

1. Certbot needs to be installed: <https://certbot.eff.org/>
2. OpenSSL needs to be installed. It is preinstalled on Mac and Linux.
You can install Git which includes OpenSSL: <https://gitforwindows.org/>3. The server must be listening on port 80.
4. On Windows the server must be started as an administrator. This is required by certbot. This is not required on Mac (not sure about Linux).
Note that running B4J as an administrator will cause the running program to also run as admin.
Instructions:  

1. Add the module to the server project.
2. The paths to CertBot and OpenSSL should be set in the module:

```B4X
'Mac  
Private Const CertBotExe As String = "/opt/homebrew/Cellar/certbot/2.9.0/bin/certbot"  
Private Const OpenSSLExe As String = "openssl"  
'Windows  
Private Const CertBotExe As String = "C:\Program Files\Certbot\bin\certbot.exe"  
Private Const OpenSSLExe As String = "c:\Program Files\Git\usr\bin\openssl.exe"
```

3. In the main module the srvr variable needs to be made public and the following globals should be added, with the correct values:

```B4X
Public SslConfiguration As SslConfiguration  
Public KeystorePassword As String = "password here"  
Public Domain As String = "www.example.com"  
Public KeystoreFilename As String = "keystore.jks"
```

The ConfigureSSL sub should be similar to:

```B4X
Private Sub ConfigureSSL (SslPort As Int)  
    'example of SSL connector configuration  
    SslConfiguration.Initialize 'this is the global variable  
    SslConfiguration.SetKeyStorePath(File.DirApp, KeystoreFilename) 'path to keystore file  
    SslConfiguration.KeyStorePassword = KeystorePassword  
    SslConfiguration.KeyManagerPassword = KeystorePassword  
    srvr.SetSslConfiguration(SslConfiguration, SslPort)  
    'add filter to redirect all traffic from http to https  
    'srvr.AddFilter("/*", "HttpsFilter", False)  
End Sub
```

4. The LetsEncrypt class should be added with a background worker:

```B4X
srvr.AddBackgroundWorker("LetsEncrypt") 'before the server is started
```


Tips:  

1. The CertBot will create the files under <project>\Objects\certbot
2. LetsEncrypt sets a limit on the number of certificates (for the same domain). The limit is easy to reach while testing after deleting the certificates. CertBot will not create a new certificate if not needed.
3. You can comment the call to ConfigureSSL when running without a certificate. Once it was created, uncomment and restart the server.
4. SSL connectors tutorial: <https://www.b4x.com/android/forum/threads/server-ssl-connections.40130/#content>
5. I wasn't able to install CertBot on one of my Linux servers. Eventually I used a different client named getssl: <https://github.com/srvrco/getssl>
For now I'm running it manually. The two commands that convert the generated certificate to a keystore:

```B4X
openssl pkcs12 -export -in fullchain.crt -inkey domain.com.key  -out serversout -passout pass:<password>  
keytool -importkeystore -deststorepass <password> -destkeypass <password> -destkeystore keystore.jks -srckeystore server.p12 -srcstoretype PKCS12 -srcstorepass <password> -alias b4j
```

6. LetsEncrypt certificates are not recognized as valid certificates on Android 7- devices.
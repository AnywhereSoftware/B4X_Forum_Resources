###  Client certificates with OkHttpUtils2 SSLContext-Kickstart by Erel
### 07/26/2021
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/132549/)

This is a B4A + B4J library.  
This code uses JavaObject to access SSLContext-Kickstart SDK (v5.0.0): <https://github.com/Hakky54/sslcontext-kickstart/tree/v5.0.0>  
License: Apache 2.  
  
It allows configuring OkHttpUtils2 to use an external keystore and include client certificates.  
  

```B4X
'Press Ctrl + B and add HU2_PUBLIC as a conditional symbol!  
Private Sub SetSSLFactory (StoreDir As String, StoreFile As String, StorePassword As String)  
    Dim hc As OkHttpClient = HttpUtils2Service.hc  
    Dim builder As JavaObject = hc.As(JavaObject).RunMethod("sharedInit", Array("hc"))  
    Dim sslfactoryBuilder As JavaObject  
    sslfactoryBuilder = sslfactoryBuilder.InitializeStatic("nl.altindag.sslcontext.SSLFactory").RunMethod("builder", Null)  
    Dim in As InputStream = File.OpenInput(StoreDir, StoreFile)  
    Dim keystore As JavaObject  
    keystore.InitializeStatic("java.security.KeyStore")  
    Dim password As Object = StorePassword.As(JavaObject).RunMethod("toCharArray", Null) 'ignore  
    Dim store As JavaObject = keystore.RunMethodJO("getInstance", Array("pkcs12"))  
    store.RunMethod("load", Array(in, password)) 'ignore  
   
    sslfactoryBuilder.RunMethod("withIdentityMaterial", Array(store, password))  
    sslfactoryBuilder.RunMethod("withTrustMaterial", Array(store, password))  
    'uncomment if need to disable http 2.  
'    Dim protocol As JavaObject  
'    protocol = protocol.InitializeStatic("okhttp3.Protocol").RunMethod("valueOf", Array("HTTP_1_1"))  
'    Dim protocols As List = Array(protocol)  
'    builder.RunMethod("protocols", Array(protocols))  
   
    Dim sslfactory As JavaObject = sslfactoryBuilder.RunMethod("build", Null)  
    Dim socketfactory As JavaObject = sslfactory.RunMethodJO("getSslContext", Null).RunMethod("getSocketFactory", Null)  
    Dim trustmanager As JavaObject = sslfactory.RunMethodJO("getTrustManager", Null)  
    builder.RunMethod("sslSocketFactory", Array(socketfactory, trustmanager.RunMethod("get", Null)))  
    builder.RunMethod("hostnameVerifier", Array(sslfactory.RunMethod("getHostnameVerifier", Null)))  
    hc.As(JavaObject).SetField("client", builder.RunMethod("build", Null))  
End Sub
```

  
  
Add to main module:  

```B4X
#AdditionalJar: slf4j-api-1.7.30  
#AdditionalJar: sslcontext-android
```

  
  
  
You need to add a Java keystore file to the project. The keystore will include the certificates. The format should be pkcs12 (not JKS).  
The exact steps to create the keystore depend on the certificates format.
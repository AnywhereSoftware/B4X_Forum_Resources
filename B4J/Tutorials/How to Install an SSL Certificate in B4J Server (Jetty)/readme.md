### How to Install an SSL Certificate in B4J Server (Jetty) by tummosoft
### 06/27/2022
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/141429/)

![](https://www.b4x.com/android/forum/attachments/130841)  
  
This is a easy way to install SSL Certificate on a VPS with Jetty.  
  
(1) Goto ZeroSSL to create free sll for your domain: <https://zerossl.com/>  
  
(2) Download your Certificate (includes 3 files: ca\_bundle.crt, certificate.crt, private.key)  
  
(3) Download Openssl if you have not yet on your computer. (<https://slproweb.com/products/Win32OpenSSL.html>)  
  
(4) Joint Certificate*, o*pen a new *command prompt* (C:\Program Files\OpenSSL-Win64\bin).  
  
Run:  
  

```B4X
openssl pkcs12 -export -in d:\certificate.crt -inkey d:\private.key -out d:\abc.p12
```

  
  
(5) Move to the *JDK* software where *installed* on your computer (ex: C:\Program Files\Java\jdk1.8.0\_333\bin)  
  
Run:  
  

```B4X
keytool -importkeystore -srckeystore d:\abc.p12 -srcstoretype PKCS12 -destkeystore d:\abc.jks -deststoretype JKS
```

  
  
(6) Copy abc.jks on to Object folder  
  
![](https://www.b4x.com/android/forum/attachments/130843)
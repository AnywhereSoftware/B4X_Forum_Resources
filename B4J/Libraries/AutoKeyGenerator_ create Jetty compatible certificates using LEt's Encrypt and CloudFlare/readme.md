### AutoKeyGenerator: create Jetty compatible certificates using LEt's Encrypt and CloudFlare by wl
### 05/04/2020
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/117320/)

Attached the source code and some description on a tool I wrote to generate SSL certificates to be used in B4J http server applications.  
  
It generates and renews certificates (even wildcard ones) on Let's Encrypt and communicates with the CloudFlare API to do DNS challenging.  
The code has been tested on Windows as well as Ubuntu.  
  
The different steps needed to accomplish this are based on info found at <https://github.com/porunov/acme_client/wiki/Get-a-wildcard-certificate>  
Thanks to DonManfred for his post at: [https://www.b4x.com/android/forum/threads/b4x-manage-your-own-let´s-encrypt-certificates-acme-client.101385/#content](https://www.b4x.com/android/forum/threads/b4x-manage-your-own-let%C2%B4s-encrypt-certificates-acme-client.101385/#content)  
  
As this is currently the first version, issues are to be expected: please let me know when you encounter any.
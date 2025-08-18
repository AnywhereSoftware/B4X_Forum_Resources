### Connecting to HTTPS (secured) urls by Erel
### 06/22/2021
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/7057/)

**New tutorial: [[B4X] OkHttpUtils2 / iHttpUtils2 and accept all option](https://www.b4x.com/android/forum/threads/110673/#content)**   
[SPOILER="irrelevant"]The HTTP library and the underlying Apache HTTP component takes care of secured web pages automatically. The certificate will be checked and if trusted a connection will be made.  
However sometimes you need to connect to a secure page which is self signed. Trying to connect to such a page will fail because the certificate is not trusted. You can bypass this check by calling Http.[InitializeAcceptAll](http://www.b4x.com/android/help/http.html#httpclient_initializeacceptall) instead of Http.Initialize (this method is available in HTTP v1.02)  
  
This method should only be used in local secured networks.[/SPOILER]
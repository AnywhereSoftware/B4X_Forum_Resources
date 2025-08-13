### OkHttpUtils2 v3.02 by Erel
### 03/22/2023
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/146185/)

All previous versions of OkHttpUtils2 relied on a service. As it is no longer possible to start services when the app starts in the background, this configuration is problematic and it will fail in such cases (<https://www.b4x.com/android/forum/threads/receivers-and-httpjob.146181>).  
In the new version HttpUtils2Service is actually a receiver. It should be transparent for developers.  
  
Note that this is an internal library.
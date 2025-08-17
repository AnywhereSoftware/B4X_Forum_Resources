### FirebaseAnalytics by Erel
### 08/14/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/67708/)

This library requires B4A v6+.  
  
Adding support for Firebase [analytics](https://firebase.google.com/docs/analytics/):  
  
1. Follow the Firebase integration tutorial: <https://www.b4x.com/android/forum/threads/integrating-firebase-services.67692/#content>  
  
  
2. In Starter service:  

```B4X
Sub Process_Globals  
   Public analytics As FirebaseAnalytics  
End Sub  
  
Sub Service_Create  
   analytics.Initialize  
End Sub
```

  
  
That's it.  
  
You can manually send events with:  

```B4X
Starter.analytics.SendEvent("login", CreateMap ("additional parameter": 100))
```

  
  
Note that it can take several hours until the data is available in Firebase console:  
  
![](https://www.b4x.com/basic4android/images/SS-2016-06-09_10.03.24.png)  
  
![](https://www.b4x.com/basic4android/images/SS-2016-06-09_10.03.58.png)  
  
Updates:  
v3.21 - Fixes an issue related to 7\_25 resources.
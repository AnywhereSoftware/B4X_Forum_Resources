### HMS (Huawei) - DRM verification by Erel
### 11/24/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/124725/)

HMS v1.00 adds support for DRM verification.  
<https://www.b4x.com/android/forum/threads/hms-huawei-sdk.124034/#content>  
  
It allows checking whether the app was purchased from the store or not.  
It is very simple to integrate. Make sure to use the latest version of HMS and include the two new dependencies (drm and apptouch).  
  

1. Find the project DRM ID and key:
![](https://www.b4x.com/android/forum/attachments/103252)2. Add to manifest editor:

```B4X
CreateResourceFromFile(Macro, hms.hms_drm)
```

3. Call CheckDRM with:

```B4X
Wait For (hms.CheckDRM(Main.DRM_ID, Main.DRM_KEY)) Complete (Success As Boolean)  
If Success = False Then  
Log("Not purchased")  
'ExitApplication  
End If
```


  
It will show a dialog if the app was not purchased and take the user to the store page.  
  
You can add a test account and it will be treated as if it was purchased from the store.  
  
**The CheckDRM method will only work in B4XPages projects.**
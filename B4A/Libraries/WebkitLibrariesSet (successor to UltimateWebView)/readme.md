### WebkitLibrariesSet (successor to UltimateWebView) by Ivica Golubovic
### 01/01/2024
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/144368/)

[SIZE=6]**IMPORTANT!!!**[/SIZE]  
[SIZE=7]**Library deprecated. Use UltimateWebView2 instead.**[/SIZE]  
<https://www.b4x.com/android/forum/threads/ultimatewebview2.158340/>  
  
**WebkitLibrariesSet** is an advanced successor to the **UltimateWebView** library. Instead of a single library that made up **UltimateWebView**, the new concept contains a collection of a large number of libraries that belong to the **android.webkit** class set. Each library that is an integral part of the **WebkitLibrariesSet** contains from one to at most several smaller classes.  
  
The advantages of this approach are multiple, and I will mention only a part of them:  

- Each library in the set is independent from the others, but can be used in synergy with each of the libraries in the set.
- For your project, you will use only those libraries from the kit that are needed for your project. With this approach, you can reduce the size of your final application compared to the size of the application using a single **UltimateWebView** library.
- In addition to the fact that each library in the kit is independent, each of them can be used with the native **B4A WebView**. This means that if you do not need to use **WebkitWebView** (successor of UltimateWebView) with all its options, in that case you can use native **WebView** in synergy with other libraries in this set.
- To use **WebkitWebView** Custom View (the successor of UltimateWebView), you don't have to use all the libraries from set, but only those that are necessary for your project (while using **UltimateWebView** all classes from the set of libraries were necessary).

Over time, this set of libraries will be upgraded with new libraries that will contain classes from the **android.webkit** class set. Also, these new libraries will be independent to use from other libraries in the kit and all will be able to be used with native **B4A WebView**.  
  
Manifest requirements:  

- For WebkitWebChromeClient

- ```B4X
  'Camera Permissions
  ```
AddPermission(android.permission.CAMERA)
AddPermission(android.permission.RECORD\_AUDIO)
AddPermission(android.permission.MODIFY\_AUDIO\_SETTINGS)
AddPermission(android.permission.MICROPHONE)
'————————
'Geolocation Permissions
AddPermission(android.permission.ACCESS\_FINE\_LOCATION)
AddPermission(android.permission.ACCESS\_COARSE\_LOCATION)
'AddPermission(android.permission.ACCESS\_BACKGROUND\_LOCATION)
'AddPermission(android.permission.WRITE\_EXTERNAL\_STORAGE)
'————————
- For WebkitDownloadListener

- ```B4X
  'DownloadListener Permissions
  ```
AddPermission(android.permission.DOWNLOAD\_WITHOUT\_NOTIFICATION)
'————————
- For WebkitWebView Custom View.

- ```B4X
  SetApplicationAttribute(android:usesCleartextTraffic,"true")
  ```

**In the manifest, add lines that are necessary for your project, do not add unnecessary ones.  
  
Version 1.0** libraries list:  

1. WebkitConsoleMessage 1.0
2. WebkitCookieManager 1.0
3. **WebkitDownloadListener** 1.0
4. WebkitHttpAuthHandler 1.0
5. WebkitJavascriptInterface 1.0
6. WebkitJsResultAndJsPromptResult 1.0
7. WebkitMimeTypeMap 1.0
8. WebkitSafeBrowsingResponse 1.0
9. WebkitURLUtil 1.0
10. WebkitWebBackForwardList 1.0
11. **WebkitWebChromeClient** 1.0
12. WebkitWebResourceError 1.0
13. WebkitWebResourceRequest 1.0
14. WebkitWebResourceResponse 1.0
15. **WebkitWebView** 1.0 Custom View
16. WebkitWebViewAssetLoader 1.0
17. **WebkitWebViewClient** 1.0
18. WebkitWebViewDatabase 1.0
19. **WebkitWebViewSettings** 1.0

  
If this libraries makes your work easier and saves time in creating your application, please make a donation.  
<https://www.paypal.com/donate?hosted_button_id=HX7GS8H4XS54Q>
### UltimateWebView2 by Ivica Golubovic
### 01/01/2024
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/158340/)

A new old acquaintance (**UltimateWebView**) returns on the first day of 2024. This library is my New Year's greeting to all the members of this really special forum, a forum that doesn't let the good old **BASIC** programming language go into oblivion. The new library is called **UltimateWebView2** and is a completely new design (it doesn't rely on the old library). Also, this library is the successor of the **WebkitLibrarySet** library, which has a lot of difficulties in working with older versions of Android.  
  
The **UltimateWebView2** library is the successor of the **WebkitLibrarySet** and old **UltimateWebView** library. This library is a complete java wrapper, while the previous versions are a B4X libraries. This opens up many possibilities in the functioning of the library as well as for future updates.  
  
The **UltimateWebView2** library, like **WebkitLibrarySet**, can be used with the native **B4A WebView** object. It is also possible to initialize the **UltimateWebView** object with the native **WebView** object like in example below:  

```B4X
UltimateWebView1.Initialize2("UltimateWebView1",WebView1) 'WebView1 is native B4A WebView
```

  
  
In order for **B4A WebView** or **UltimateWebView** to display the desired WEB content, it is necessary to enable "**ClearTextTraffic**" by adding the following line to the manifest:  

```B4X
SetApplicationAttribute(android:usesCleartextTraffic,"true")
```

  
  
The **Webkit Compat** package (**androidx.webkit:webkit**) is integrated into this library for the first time. **UltimateWebView2** library contains many methods from this package. This package enables the compatibility of this library with a large number of old and new devices. For example, without this package, the SafeBrowsing option is only possible from API26 and above, while with this package this option is available on much older devices. This package also relies on the native **Android System WebView** application from which it pulls many functions. In practice, this means that if the **Android System WebView** application is up to date on an old device, that device will have some features that are not available on the version of the system that device has. This package does not need to be downloaded additionally because it is integrated into the **UltimateWebView2** library itself. In the future, many more methods and classes will be added from this package that provides additional capabilities related to the **WebView** object.  
  
The main object of this library is, of course, the **UltimateWebView** object which contains many more methods and properties than the standard **B4A WebView** object. As before, **UltimateWebView** can be added through the Designer, with the fact that in this library **UltimateWebView** is a standard View object that can be used in other libraries (the previous version from **WebkitLibrarySet** and old **UltimateWebView** could not).  
  
The **UltimateDownloadListener**, **UltimateWebChromeClient** and **UltimateWebViewClient** classes have been improved and optimized compared to their predecessors. They also contain a certain number of new events. These classes when integrated into **UltimateWebView** or **WebView** provide many features that bring **UltimateWebView** or **WebView** closer to standard Web browsers like Chrome. Some of those possibilities are: downloading files (**UltimateDownloadListener**), uploading files (**UltimateWebChromeClient**), launching external applications (**UltimateWebViewClient**), geolocation (**UltimateWebChromeClient**), WebRTC (**UltimateWebChromeClient**), full-screen video viewing (**UltimateWebChromeClient**), etc…  
When I have time I will do tutorials for each of these classes and explain the events they contain and their usage. Depending on which feature you want, add the following lines to the manifest:  

```B4X
'WebRTC camera & audio permissions  
AddPermission(android.permission.CAMERA)  
AddPermission(android.permission.RECORD_AUDIO)  
AddPermission(android.permission.MODIFY_AUDIO_SETTINGS) 'optional
```

  

```B4X
'Geolocation Permissions  
AddPermission(android.permission.ACCESS_FINE_LOCATION)  
AddPermission(android.permission.ACCESS_COARSE_LOCATION)
```

  
  
In addition to classes, this library also contains modules. Modules contain static variables and methods. Some classes have their own child module with the same name as the parent class (for example **FileChooserParams** exists as both a class and a module). For more information, see the list of classes and modules below.  
  
It is not recommended to use this library with other custom **WebView** libraries because class conflicts may occur. In fact, no other custom **WebView** library is required.  
  
Classes and modules:  

- **ClientCertRequest** - class. This class cannot be initialized by the user.
- **ConsoleMessage** - there is both a class and a module. A module can contain static variables and methods.
- **CookieManager** - class
- **DownloadProperties** - custom class, not part of original android.webkit package.
- **FileChooserParams** - there is both a class and a module. A module can contain static variables and methods. Class cannot be initialized by the user.
- **GeolocationPermission** - class
- **GeolocationPermissionCallback** - class. This class cannot be initialized by the user.
- **HitTestResult** - there is both a class and a module. A module can contain static variables and methods. Class cannot be initialized by the user.
- **HttpAuthHandler** - class. This class cannot be initialized by the user.
- **JsPromptResult** - class. This class cannot be initialized by the user.
- **JsResult** - class. This class cannot be initialized by the user.
- **MimeTypeMap** - a module which contains static methods.
- **PermissionRequest** - there is both a class and a module. A module can contain static variables and methods. Class cannot be initialized by the user.
- **SafeBrowsingResponse** - class. This class cannot be initialized by the user.
- **SslError** - part of **android.net.http** package. There is both a class and a module. A module can contain static variables and methods. Class cannot be initialized by the user.
- **SslErrorHandler** - class. This class cannot be initialized by the user.
- **UltimateDownloadListener** - class
- **UltimateJavascriptInterface** - class
- **UltimateWebChromeClient** - class
- **UltimateWebView** - custom WebView object compatible with native **B4A WebView** (class).
- **UltimateWebViewClient** - there is both a class and a module. A module can contain static variables and methods.
- **URLUtil** - a module which contains static methods.
- **ValueCallbackUri** - class. This class cannot be initialized by the user.
- **WebBackForwardList** - class. This class cannot be initialized by the user.
- **WebHistoryItem** - class. This class cannot be initialized by the user.
- **WebResourceRequest** - class. This class cannot be initialized by the user.
- **WebResourceResponse** - class
- **WebSettings** - there is both a class and a module. A module can contain static variables and methods
- **WebViewAssetLoader** - part of **androidx.webkit** package (**Webkit compat** package) which is integrated in this library (extra packages not required)
- **WebViewDatabase** - class

  
In addition to the zipped library file, three examples are attached. **Example1** is based on using the **UltimateWebView** object which is added via the Designer. **Example2** shows the use of an **UltimateWebView** object that is initialized with a native **B4A WebView** object which is added via the Designer. **Example3** shows the use of the library to work only with the native **B4A WebView** object which is added directly through the Designer (without using the **UltimateWebView** object).  
  
***For all additional questions and solutions, please write in this thread, or start a new thread. I will not answer private questions related to this library (I did in the past) so that solutions and suggestions are available to everyone on the forum.***  
  
If this libraries makes your work easier and saves time in creating your application, please make a donation.  
<https://www.paypal.com/donate?hosted_button_id=HX7GS8H4XS54Q>
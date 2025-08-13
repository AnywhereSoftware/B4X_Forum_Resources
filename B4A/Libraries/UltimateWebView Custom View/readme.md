### UltimateWebView Custom View by Ivica Golubovic
### 01/01/2024
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/135666/)

[SIZE=6]**IMPORTANT!!!**[/SIZE]  
[SIZE=7]**Library deprecated. Use UltimateWebView2 instead.**[/SIZE]  
<https://www.b4x.com/android/forum/threads/ultimatewebview2.158340/>  
  
  
The purpose of the library is to implement all important classes in one library in order to make work as easy as possible. The library will be upgraded over time by adding new features and protocols.  
  
For full library functionality, copy the following into the manifest:  

```B4X
'Important  
SetApplicationAttribute(android:usesCleartextTraffic,"true")  
AddPermission(android.permission.DOWNLOAD_WITHOUT_NOTIFICATION)  
'———————  
'Camera Permissions  
AddPermission(android.permission.CAMERA)  
AddPermission(android.permission.RECORD_AUDIO)  
AddPermission(android.permission.MODIFY_AUDIO_SETTINGS)  
AddPermission(android.permission.MICROPHONE)  
AddPermission("android.hardware.camera")  
AddManifestText(<uses-feature android:name="android.hardware.camera" android:required="true" />)  
AddManifestText(<uses-feature android:name="android.hardware.camera.autofocus" android:required="false" />)  
AddManifestText(<uses-feature android:name="android.hardware.camera.flash" android:required="false" />)  
'———————  
  
'Geolocation Permissions  
AddPermission(android.permission.ACCESS_FINE_LOCATION)  
AddPermission(android.permission.ACCESS_COARSE_LOCATION)  
AddPermission(android.permission.ACCESS_BACKGROUND_LOCATION)  
AddPermission(android.permission.WRITE_EXTERNAL_STORAGE)  
'————————  
  
AddManifestText(<uses-permission  
   android:name="android.permission.WRITE_EXTERNAL_STORAGE"  
   android:maxSdkVersion="18" />  
)  
  
AddApplicationText(  
  <provider  
  android:name="android.support.v4.content.FileProvider"  
  android:authorities="$PACKAGE$.provider"  
  android:exported="false"  
  android:grantUriPermissions="true">  
  <meta-data  
  android:name="android.support.FILE_PROVIDER_PATHS"  
  android:resource="@xml/provider_paths"/>  
  </provider>  
)  
CreateResource(xml, provider_paths,  
   <files-path name="name" path="shared" />  
)
```

  
  
UltimateWebView is a Custom View Library and it is possible to add a View through the Designer.  
  
Sample project:  

```B4X
#Region  Project Attributes  
    #ApplicationLabel: B4A Example  
    #VersionCode: 1  
    #VersionName:  
    'SupportedOrientations possible values: unspecified, landscape or portrait.  
    #SupportedOrientations: unspecified  
    #CanInstallToExternalStorage: False  
#End Region  
  
#Region  Activity Attributes  
    #FullScreen: False  
    #IncludeTitle: True  
#End Region  
  
#BridgeLogger: True  
  
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'These variables can be accessed from all modules.  
  
End Sub  
  
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
    'These variables can only be accessed from this module.  
    Private txtUrl As EditText  
    Private btnGo As Button  
    Private UltimateWebView1 As UltimateWebView  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    'Do not forget to load the layout file created with the visual designer. For example:  
    Activity.LoadLayout("Main")  
   
    UltimateWebView1.SetWebViewClient 'Sets WebViewClient and its Events.  
    UltimateWebView1.SetWebChromeClient 'Sets WebChromeClient and its Events.  
    'Other UltimateWebViewSettings  
    UltimateWebView1.Settings.JavaScriptEnabled=True  
    UltimateWebView1.Settings.AllowContentAccess=True  
    UltimateWebView1.Settings.AllowFileAccess=True  
    UltimateWebView1.Settings.AppCacheEnabled=True  
    UltimateWebView1.Settings.CacheMode=UltimateWebView1.Settings.CacheMode_LOAD_DEFAULT  
    UltimateWebView1.Settings.JavaScriptCanOpenWindowsAutomatically=True  
    UltimateWebView1.Settings.DisplayZoomControls=False  
    UltimateWebView1.Settings.DomStorageEnabled=True  
    UltimateWebView1.Settings.MediaPlaybackRequiresUserGesture=False  
    UltimateWebView1.Settings.AllowFileAccessFromFileURLs=True  
    UltimateWebView1.Settings.AllowUniversalAccessFromFileURLs=True  
    UltimateWebView1.Settings.GeolocationEnabled=True  
    UltimateWebView1.SetDownloadListener 'Sets and start DownloadListener'  
   
    'CookieManager Settings to accept all cookies  
    UltimateWebView1.CookieManager.AcceptCookies=True  
    UltimateWebView1.CookieManager.AcceptThirdPartyCookies=True  
    UltimateWebView1.CookieManager.AcceptFileSchemeCookies=True  
    UltimateWebView1.CookieManager.Flush  
End Sub  
  
Sub Activity_Resume  
  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
    If UserClosed Then  
        ExitApplication  
    End If  
End Sub  
  
Sub Activity_KeyPress (KeyCode As Int) As Boolean 'Return True to consume the event  
    If KeyCode=KeyCodes.KEYCODE_BACK Then  
        If UltimateWebView1.CanGoBack=True Then  
            UltimateWebView1.GoBack  
            Return True  
        Else  
            Return False  
        End If  
    Else  
        Return False  
    End If  
End Sub  
  
Sub btnGo_Click  
    'You can use LoadUrl2 like in code bellow  
    '————————–  
    'Dim Headerrs As Map  
    'Headerrs.Initialize  
    'Headerrs.Put("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.183 Safari/537.36")  
    'UltimateWebView1.LoadUrl2(txtUrl.Text,Headerrs)  
    '—————————  
   
    UltimateWebView1.LoadUrl(txtUrl.Text)  
End Sub  
  
Sub UltimateWebView1_FileDownloadInitialized (DownloadProperties1 As DownloadProperties) 'When click to download link or button this event will bi fired.  
    Log("Download INITIALIZED")  
    'DownloadProperties fields:  
    '———————————  
    'Log(DownloadProperties1.url)  
    'Log(DownloadProperties1.userAgent)  
    'Log(DownloadProperties1.contentDisposition)  
    'Log(DownloadProperties1.mimeType)  
    'Log(DownloadProperties1.contentLength)  
    'Log(DownloadProperties1.cookies)  
    'Log(DownloadProperties1.fileName)  
    'Log(DownloadProperties1.FileExtension)  
    'Log(DownloadProperties1.DownloadID)  
    '———————————  
   
    UltimateWebView1.StartFileDownload(DownloadProperties1,"TEST",True,True) 'File will be downloaded with native DownloadManager. If you want internall download, you can use your own method with parameters from DownloadProperties.  
End Sub  
  
Sub UltimateWebView1_FileDownloadStarted (DownloadProperties1 As DownloadProperties)  
    Log("Download STARTED")  
    'Log(DownloadProperties1.url)  
    'Log(DownloadProperties1.userAgent)  
    'Log(DownloadProperties1.contentDisposition)  
    'Log(DownloadProperties1.mimeType)  
    'Log(DownloadProperties1.contentLength)  
    'Log(DownloadProperties1.cookies)  
    'Log(DownloadProperties1.fileName)  
    'Log(DownloadProperties1.FileExtension)  
    'Log(DownloadProperties1.DownloadID)  
End Sub  
  
Sub UltimateWebView1_FileDownloadCompleted (Success As Boolean, DownloadProperties1 As DownloadProperties)  
    Log("Download COMPLETED; Success:" & Success)  
    'Log(DownloadProperties1.url)  
    'Log(DownloadProperties1.userAgent)  
    'Log(DownloadProperties1.contentDisposition)  
    'Log(DownloadProperties1.mimeType)  
    'Log(DownloadProperties1.contentLength)  
    'Log(DownloadProperties1.cookies)  
    'Log(DownloadProperties1.fileName)  
    'Log(DownloadProperties1.FileExtension)  
    'Log(DownloadProperties1.DownloadID)  
End Sub  
  
Private Sub UltimateWebView1_OverrideUrl (WebResourceRequest1 As WebResourceRequest) As Boolean  
    'Log(WebResourceRequest1.GetUrl)  
    'Log(WebResourceRequest1.GetMethod)  
    'Log(WebResourceRequest1.HasGesture)  
    'Log(WebResourceRequest1.IsForMainFrame)  
    'Log(WebResourceRequest1.IsRedirect)  
    'Dim M As Map=WebResourceRequest1.GetRequestHeaders  
    'If M.IsInitialized Then  
        'For i=0 To M.Size-1  
            'Log(M.GetKeyAt(i))  
            'Log(M.GetValueAt(i))  
        'Next  
    'End If  
    Return False  
End Sub  
  
Sub UltimateWebView1_PageFinished (Url As String)  
   
End Sub  
  
Sub UltimateWebView1_PageStarted (Url As String, FavIcon As Bitmap)  
    'If FavIcon<>Null Then  
        'do stuff…  
    'End If  
End Sub  
  
Sub UltimateWebView1_PageLoadingProgressChanged(Progress As Int)  
   
End Sub  
  
Sub UltimateWebView1_ReceivedIcon (Icon As Bitmap)  
    'If Icon<>Null Then  
    'do stuff…  
    'End If  
End Sub  
  
Sub UltimateWebView1_ReceivedTitle (Title As String)  
   
End Sub  
  
'Very important event for UltimateWebView permissions request!!!  
Sub UltimateWebView1_PermissionRequest (RequestedPermission As String)  
    Dim Permissions As RuntimePermissions  
    Permissions.CheckAndRequest(RequestedPermission)  
    Wait For Activity_PermissionResult (Permission As String, result As Boolean)  
    UltimateWebView1.GrantPermission(result)  
End Sub  
  
Sub UltimateWebView1_ScaleChanged (OldScale As Float, NewScale As Float)  
   
End Sub  
  
Private Sub UltimateWebView1_ReceivedError (WebResourceRequest1 As WebResourceRequest, WebResourceError1 As WebResourceError)  
    'Log("ReceivedError")  
    'Log(WebResourceRequest1.GetUrl)  
    'Log(WebResourceError1.Description)  
    'Log(WebResourceError1.ErrorCode)  
End Sub  
  
Private Sub UltimateWebView1_ReceivedHttpError (WebResponseRequest1 As WebResourceRequest, WebResourceResponse1 As WebResourceResponse)  
    'Log("ReceivedHttpError")  
    'Log(WebResponseRequest1.GetUrl)  
    'Log(WebResourceResponse1.Encoding)  
    'Log(WebResourceResponse1.StatusCode)  
End Sub  
  
Private Sub UltimateWebView1_ReceivedHttpAuthRequest (HttpAuthHandler1 As HttpAuthHandler, HttpAuthRequestProperties1 As HttpAuthRequestProperties)  
    'Log("ReceivedHttpAuthRequest")  
    'Log(HttpAuthRequestProperties1.Host)  
    'Log(HttpAuthRequestProperties1.Realm)  
End Sub  
  
Private Sub UltimateWebView1_ReceivedLoginRequest (LoginRequestProperties1 As LoginRequestProperties)  
    'Log("ReceivedLoginRequest")  
    'Log(LoginRequestProperties1.Realm)  
    'Log(LoginRequestProperties1.Account)  
    'Log(LoginRequestProperties1.Args)  
End Sub  
  
Private Sub UltimateWebView1_UpdateVisitedHistory (Url As String, IsReload As Boolean)  
    'Log("UpdateVisitedHistory")  
    'Log(Url)  
    'Log(IsReload)  
End Sub  
  
  
Private Sub UltimateWebView1_PageCommitVisible (Url As String)  
   
End Sub  
  
Private Sub UltimateWebView1_ShouldInterceptRequest (Request As WebResourceRequest) As WebResourceResponse  
    'Log("ShouldInterceptRequest")  
    'Log(Request.GetUrl)  
    'Dim ins As InputStream  
    'ins.InitializeFromBytesArray(Array As Byte(100,231,155),0,3)  
    'Dim Response As WebResourceResponse  
    'Response.Initialize  
    'Response.Create("text/plain","utf-8",ins)  
    'Return Response  
    Return Null  
End Sub  
  
  
Private Sub UltimateWebView1_JsAlert (JsProperties1 As JsProperties, JsResult1 As JsResult) As Boolean  
    'Log("JsAlert")  
    'Log(JsProperties1.Url)  
    'Log(JsProperties1.Message)  
    'Log(JsProperties1.DefaultValue)  
    'JsResult1.Confirm  
    Return False  
End Sub  
  
Private Sub UltimateWebView1_JsBeforeUnload (JsProperties1 As JsProperties, JsResult1 As JsResult) As Boolean  
    'Log("JsBeforeUnload")  
    'Log(JsProperties1.Url)  
    'Log(JsProperties1.Message)  
    'Log(JsProperties1.DefaultValue)  
    'JsResult1.Confirm  
    Return False  
End Sub  
  
Private Sub UltimateWebView1_JsConfirm (JsProperties1 As JsProperties, JsResult1 As JsResult) As Boolean  
    'Log("JsConfirm")  
    'Log(JsProperties1.Url)  
    'Log(JsProperties1.Message)  
    'Log(JsProperties1.DefaultValue)  
    'JsResult1.Confirm  
    Return False  
End Sub
```

  
  
**UltimateWebView  
Author:** Ivica Golubovic  
**Version:** 1.1  
  
**Changes:**  

- Method **GetWebView** is removed from UltimateWebView Class.
- Property **WebView** (get/set) added to UltimateWebView Class. You can now use this property to set existing **WebView** to UltimateWebView.
- Added method **ClearFormData**.
- Added method **ClearMatches**.
- Added method **ClearSslPreferences**.
- Added method **ComputeScroll**.
- Added class WebBackForwardList.
- Added type WebHistoryItem to class WebBackForwardList.
- Added method **CopyBackForwardList**.
- Added method **FindAllAsync**.
- Added method **FindNext**.
- Added method **FlingScroll**.

You can now import an existing WebView object into UltimateWebView, it is not necessary to add an UltimateWebView object through the Designer.  
Example:  

```B4X
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'These variables can be accessed from all modules.  
  
End Sub  
  
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
    'These variables can only be accessed from this module.  
    Private WebView1 As WebView  
    Private UltimateWebView1 As UltimateWebView  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    'Do not forget to load the layout file created with the visual designer. For example:  
    Activity.LoadLayout("Main")  
   
    'First Initialize UltimateWebView  
    UltimateWebView1.Initialize(Me,"UltimateWebView1")  
    'Import native WebView into UltimateWebView  
    UltimateWebView1.WebView=WebView1  
   
    UltimateWebView1.SetWebViewClient  
    UltimateWebView1.SetWebChromeClient  
    UltimateWebView1.Settings.JavaScriptEnabled=True  
    UltimateWebView1.Settings.AllowContentAccess=True  
    UltimateWebView1.Settings.AllowFileAccess=True  
    UltimateWebView1.Settings.AppCacheEnabled=True  
    UltimateWebView1.Settings.CacheMode=UltimateWebView1.Settings.CacheMode_LOAD_DEFAULT  
    UltimateWebView1.Settings.JavaScriptCanOpenWindowsAutomatically=True  
    UltimateWebView1.Settings.DisplayZoomControls=False  
    UltimateWebView1.Settings.DomStorageEnabled=True  
    UltimateWebView1.Settings.MediaPlaybackRequiresUserGesture=False  
    UltimateWebView1.Settings.AllowFileAccessFromFileURLs=True  
    UltimateWebView1.Settings.AllowUniversalAccessFromFileURLs=True  
    UltimateWebView1.Settings.GeolocationEnabled=True  
    UltimateWebView1.SetDownloadListener  
   
    UltimateWebView1.CookieManager.AcceptCookies=True  
    UltimateWebView1.CookieManager.AcceptThirdPartyCookies=True  
    UltimateWebView1.CookieManager.AcceptFileSchemeCookies=True  
    UltimateWebView1.CookieManager.Flush  
End Sub
```

  
  
A very important event for the permissions required for WebRTC, Geolocation, etc. Without this event permisions will be denied.  

```B4X
Sub UltimateWebView1_PermissionRequest (RequestedPermission As String)  
    Dim Permissions As RuntimePermissions  
    Permissions.CheckAndRequest(RequestedPermission)  
    Wait For Activity_PermissionResult (Permission As String, result As Boolean)  
    UltimateWebView1.GrantPermission(result)  
End Sub
```

  
  
**UltimateWebView  
Author:** Ivica Golubovic  
**Version:** 1.2  
  
**Changes:**  

- Added event **FileChooserInitialized.**
- Added class **FileChooserParams.**
- Added method **FileChooserStart.**
- Added automatic permissions requests for UploadFileChooser.
- Added the ability to upload multiple files with UploadFileChooser if allowed.
- Added event **OverrideUrlWithExternalAppIntent**.

**FileChooserInitialized** event added. It will be activated when a Web source requires uploading a file or multiple files. To start FileChooser, call the **FileChooserStart** method or use event objects the way you want. Do not add this event if you do not want your application to have this feature.  

```B4X
Private Sub UltimateWebView1_FileChooserInitialized (FilePathCallback As Object, FileChooserParams1 As FileChooserParams)  
    'ForceIsCaptureEnabled As Boolean:  
    '    True: Use resources such as camera, microphone, etc. by force if the required file format is appropriate.  
    '    False: Use a predefined value assigned to FileChooserParams.  
    UltimateWebView1.FileChooserStart(FilePathCallback,FileChooserParams1,True) 'Use this method or use your own method from given parameters  
End Sub
```

  
  
Added event **OverrideUrlWithExternalAppIntent** which will process the request to launch an external application outside of UltimateWebView (e.g. PlayStore, Maps, AppGalery, applies to all installed applications). The result of the event is an Intent which you can use in the way you want (e.g. StartActivity (Intent) - opens the application or application chooser, depending on the case).  

```B4X
Sub UltimateWebView1_OverrideUrlWithExternalAppIntent (WebResourceRequest1 As WebResourceRequest, ExternalAppIntent As Intent) As Boolean  
    'ExternalAppIntent - Intent to use  
    StartActivity(ExternalAppIntent) 'You can use this method or do with event what ever you want  
    Return True 'True to stop page loading and handling event, False to finish loading page (Error web page will be shown)  
End Sub
```

  
  
**UltimateWebView  
Author:** Ivica Golubovic  
**Version:** 1.3  
**Changes:** Visit this post: <https://www.b4x.com/android/forum/threads/ultimatewebview-custom-view.135666/post-859400>  
  
  
**UltimateWebView  
Author:** Ivica Golubovic  
**Version:** 1.4  
**Changes:** Visit this post: <https://www.b4x.com/android/forum/threads/ultimatewebview-custom-view.135666/post-860033>  
  
**UltimateWebView  
Author:** Ivica Golubovic  
**Version:** 1.5  
**Changes:** Visit this post: <https://www.b4x.com/android/forum/threads/ultimatewebview-custom-view.135666/post-861510>  
  
**UltimateWebView  
Author:** Ivica Golubovic  
**Version:** 1.6  
**Changes:** Visit this post for description: <https://www.b4x.com/android/forum/threads/ultimatewebview-custom-view.135666/post-864977>  
  
**UltimateWebView  
Author:** Ivica Golubovic  
**Version:** 1.7  
**Changes:** Visit this post: <https://www.b4x.com/android/forum/threads/ultimatewebview-custom-view.135666/post-866430>  
  
**UltimateWebView  
Author:** Ivica Golubovic  
**Version:** 2.0  
**Changes:** Visit this post: <https://www.b4x.com/android/forum/threads/ultimatewebview-custom-view.135666/post-869686>  
  
**UltimateWebView  
Author:** Ivica Golubovic  
**Version:** 2.01  
**Changes:** Visit this post: <https://www.b4x.com/android/forum/threads/ultimatewebview-custom-view.135666/post-869704>  
  
**UltimateWebView  
Author:** Ivica Golubovic  
**Version:** 2.1  
**Changes:** Visit this post: <https://www.b4x.com/android/forum/threads/ultimatewebview-custom-view.135666/post-871370>  
  
**UltimateWebView  
Author:** Ivica Golubovic  
**Version:** 2.11  
**Changes:** Fixed bug where object is not visible in Designer (AddView-CustomView-UltimateWebView).  
  
**UltimateWebView  
Author:** Ivica Golubovic  
**Version:** 2.12  
**Changes:** Visit this post: <https://www.b4x.com/android/forum/threads/ultimatewebview-custom-view.135666/post-875746>  
  
**UltimateWebView  
Author:** Ivica Golubovic  
**Version:** 2.20  
**Changes:** Visit this post: <https://www.b4x.com/android/forum/threads/ultimatewebview-custom-view.135666/post-906883>  
  
**UltimateWebView  
Author:** Ivica Golubovic  
**Version:** 2.21  
**Changes:** Visit this post: <https://www.b4x.com/android/forum/threads/ultimatewebview-custom-view.135666/post-908288>  
  
**UltimateWebView  
Author:** Ivica Golubovic  
**Version:** 2.3  
**Changes:** Visit this post: <https://www.b4x.com/android/forum/threads/ultimatewebview-custom-view.135666/post-912804>  
  
**UltimateWebView  
Author:** Ivica Golubovic  
**Version:** 2.31  
**Changes:** Visit this post: <https://www.b4x.com/android/forum/threads/ultimatewebview-custom-view.135666/post-914392>  
  
Library references **htm** file is packed together with **jar** and **xml** file.  
  
If this library makes your work easier and saves time in creating your application, please make a donation.  
<https://www.paypal.com/donate?hosted_button_id=HX7GS8H4XS54Q>
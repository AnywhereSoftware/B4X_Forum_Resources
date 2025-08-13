### UltimateWebViewAssetLoader by Ivica Golubovic
### 11/24/2022
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/144244/)

[SIZE=7]**IMPORTANT!!!  
This library has become an integral part of WebkitLibrariesSet and is referenced like WebkitWebViewAssetLoader. Download a set of libraries from the following link:**  
<https://www.b4x.com/android/forum/threads/webkitlibrariesset-successor-to-ultimatewebview.144368/>[/SIZE]  
  
  
  
From API version 30 and above, Google has disabled the use of **AllowFileAccessFromFileURLs** and **AllowUniversalAccessFromFileURLs** options in WebView Settings. This means that since version API version 30 it is not possible to use **file:///** to load files from the **DirAsset**, **DirInternal** and **Resource folders**. Shown in the image below:  
  
  
![](https://www.b4x.com/android/forum/attachments/136152)  
  
  
The options can only be used by setting the SDK version in the manifest to a version below 30 or by adding some special lines in the manifest. The problem is that after such actions the application cannot be published on the Google Play Store.  
  
As can be seen in the image above, the only legal possibility to load files from **DirAsset**, **DirInternal** and **Resource folder** on API 30 and above is to use **androidx.webkit.WebViewAssetLoader** class. That's why I chose to implement this class in a library called **UltimateWebViewAssetLoader**.  
  
In order for this class to be used in B4X, it is first necessary to download the package **androidx.webkit:webkit** via the **SDK Manager**. The procedure is as follows:  

1. In the B4X main window menu, click on **Tools**, and from the drop-down menu, select the **SDK Manager** option.
2. When the **SDK Manager** window opens, type **androidx.webkit:webkit** in the search box.
3. Check the offered option (always choose the latest version) and click the **Install Selected** button.
4. Wait for the process to complete and then close the **SDK Manager**.

If you already have this package installed, skip the above procedure.  
  
**WebViewClient** is necessary for the operation of the library, ie the *shouldInterceptRequest* event. The library does not have its own **WebViewClient** in order to avoid conflicts if a custom **WebViewClient** is already used. Therefore, the library can be used together with the **UltimateWebView** and **WebViewExtra2** libraries, as well as with other custom WebView libraries and with native WebView.  
  
**IMPORTANT**: The library does not work in **DEBUG** mode, but only in **RELEASE** mode (In **DEBUG** mode the page will not be loaded).  
  
**References:  
UltimateWebViewAssetLoader  
Author:** Ivica Golubovic  
**Version:** 1.0  

- **UltimateWebViewAssetLoader**

- **Functions:**

- **Destroy** As String
*Destroy's UltimateWebViewAssetLoader. After that you can pass Null to UltimateWebViewAssetLoader variable.*- **Initialize** (Domain As String) As String
*Initializes the object.  
 Domain As String - Set the domain for the UltimateWebViewAssetLoader. The domain can be of your choice or use e.g. Application.PackageName. The domain must be unique so that it does not match the domain of an already existing website. Pass Null or empty string to use default domain (appassets.androidplatform.net).  
 Important: The UltimateWebViewAssetLoader will not work in DEBUG mode, work's only in RELEASE mode.  
 Works from API 11 and higher.*- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **ShouldInterceptRequest** (Url As String) As WebResourceResponseParameters
*Call this method from shouldInterceptRequest method with predefined Url. Return result is Object as android.webkit.WebResourceResponse. Pass this Object as return value for shouldInterceptRequest event or use it's parameters to construct custom WebResourceResponse.*- **ShouldInterceptRequest2** (AndroidNetUri As Object) As WebResourceResponseParameters
*Call this method from shouldInterceptRequest method with predefined android.net.Uri. Return result is Object as android.webkit.WebResourceResponse. Pass this Object as return value for shouldInterceptRequest event or use it's parameters to construct custom WebResourceResponse.*
- **Properties:**

- **AssetPahtURL** As String [read only]
*Gets the URL prefix for load file from DirAsset.*- **Domain** As String
*Gets or sets the UltimateWebViewAssetLoader domain.*- **InternalPahtURL** As String [read only]
*Gets the URL prefix for load file from DirInternal.*- **ResourcesPahtURL** As String [read only]
*Gets the URL prefix for load file from #AdditionalRes.*- **WebViewAssetLoader** As Object [read only]
*Gets the androidx.webkit.WebViewAssetLoader as Object which can be used as JavaObject, Reflector.Target or in inline java code.*
- **WebResourceResponseParameters**

- **Fields:**

- **Data** As InputStream
- **Encoding** As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **MimeType** As String
- **ReasonPhrase** As String
- **ResponseHeaders** As Object
- **StatusCode** As Int
- **WebResourceResponse** As Object

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
  
Examples:  

```B4X
'IMPORTANT: Run in RELEASE mode!  
  
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'These variables can be accessed from all modules.  
    'Private xui As XUI  
End Sub  
  
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
    Private WebView1 As WebView  
    Private AssetLoader As UltimateWebViewAssetLoader  
    Private NativeMe As JavaObject  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("Layout")  
    NativeMe.InitializeContext  
    AssetLoader.Initialize(Application.PackageName)  
    NativeMe.RunMethod("setWebViewClient",Array(WebView1))  
    WebView1.LoadUrl(AssetLoader.AssetPahtURL & "UltimateWebViewAssetLoader.htm")  
End Sub  
  
Sub Activity_Resume  
  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
  
End Sub  
  
Public Sub ShouldInterceptRequest (Url As String) As Object  
    Return AssetLoader.ShouldInterceptRequest(Url).WebResourceResponse  
End Sub  
  
Public Sub PageFinished (Url As String)  
    If Url.StartsWith(AssetLoader.AssetPahtURL) Then  
        ToastMessageShow("Page loaded from DirAsset",True)  
    Else If Url.StartsWith(AssetLoader.InternalPahtURL) Then  
        ToastMessageShow("Page loaded from DirInternal",True)  
    Else If Url.StartsWith(AssetLoader.ResourcesPahtURL) Then  
        ToastMessageShow("Page loaded from Resources",True)  
    Else  
        ToastMessageShow("Page loaded from internet",True)  
    End If  
End Sub  
  
#If Java  
  
import android.webkit.WebView;  
import android.webkit.WebViewClient;  
import android.webkit.WebResourceResponse;  
import android.webkit.WebResourceRequest;  
  
public void setWebViewClient (WebView webView){  
    webView.getSettings().setJavaScriptEnabled(true);  
    webView.setWebViewClient(new WebViewClient() {  
        @Override  
        public WebResourceResponse shouldInterceptRequest(WebView view, WebResourceRequest request) {  
            Object response = processBA.raiseEvent(null, "shouldinterceptrequest", request.getUrl().toString());  
            return (WebResourceResponse) response;  
        }  
  
        @Override  
        public WebResourceResponse shouldInterceptRequest(WebView view, String url) {  
            Object response = processBA.raiseEvent(null, "shouldinterceptrequest", url);  
            return (WebResourceResponse) response;  
        }  
         
        @Override  
        public void onPageFinished (WebView view, String url){  
            processBA.raiseEvent(null, "pagefinished", url);  
        }  
    });  
}  
  
#End If
```

  
  

```B4X
'IMPORTANT: Run in RELEASE mode!  
  
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'These variables can be accessed from all modules.  
    'Private xui As XUI  
End Sub  
  
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
    Private WebView1 As WebView  
    Private WebViewEx As WebViewExtras  
    Private WebViewClient As DefaultWebViewClient  
    Private AssetLoader As UltimateWebViewAssetLoader  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("Layout")  
    AssetLoader.Initialize(Application.PackageName)  
    WebViewEx.Initialize(WebView1)  
    WebViewClient.Initialize("WebViewClient")  
    WebViewEx.SetWebViewClient(WebViewClient)  
    WebViewEx.JavaScriptEnabled=True  
    WebView1.LoadUrl(AssetLoader.AssetPahtURL & "UltimateWebViewAssetLoader.htm")  
End Sub  
  
Sub Activity_Resume  
  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
  
End Sub  
  
Private Sub WebViewClient_PageFinished(Url As String)  
    If Url.StartsWith(AssetLoader.AssetPahtURL) Then  
        ToastMessageShow("Page loaded from DirAsset",True)  
    Else If Url.StartsWith(AssetLoader.InternalPahtURL) Then  
        ToastMessageShow("Page loaded from DirInternal",True)  
    Else If Url.StartsWith(AssetLoader.ResourcesPahtURL) Then  
        ToastMessageShow("Page loaded from Resources",True)  
    Else  
        ToastMessageShow("Page loaded from internet",True)  
    End If  
End Sub  
  
Private Sub WebViewClient_ShouldInterceptRequest(Url As String) As WebResourceResponse  
    Dim ResponseParam As WebResourceResponseParameters=AssetLoader.ShouldInterceptRequest(Url)  
    If ResponseParam.WebResourceResponse<>Null Then  
        Dim Response As WebResourceResponse  
        Response.Initialize(ResponseParam.MimeType,ResponseParam.Encoding,ResponseParam.Data)  
        Return Response  
    Else  
        Return Null  
    End If  
End Sub
```

  
  

```B4X
'IMPORTANT: Run in RELEASE mode!  
  
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'These variables can be accessed from all modules.  
    'Private xui As XUI  
End Sub  
  
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
    Private AssetLoader As UltimateWebViewAssetLoader  
    Private UltimateWebView1 As UltimateWebView  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("Layout")  
    AssetLoader.Initialize(Application.PackageName)  
    UltimateWebView1.Settings.JavaScriptEnabled=True  
    UltimateWebView1.WebViewClientEnabled=True  
    UltimateWebView1.LoadUrl(AssetLoader.AssetPahtURL & "UltimateWebViewAssetLoader.htm")  
End Sub  
  
Sub Activity_Resume  
     
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
  
End Sub  
  
Private Sub UltimateWebView1_PageFinished (Url As String) 'Works from API level 1 and above. WebViewClient required.  
    If Url.StartsWith(AssetLoader.AssetPahtURL) Then  
        ToastMessageShow("Page loaded from DirAsset",True)  
    Else If Url.StartsWith(AssetLoader.InternalPahtURL) Then  
        ToastMessageShow("Page loaded from DirInternal",True)  
    Else If Url.StartsWith(AssetLoader.ResourcesPahtURL) Then  
        ToastMessageShow("Page loaded from Resources",True)  
    Else  
        ToastMessageShow("Page loaded from internet",True)  
    End If  
End Sub  
  
  
Private Sub UltimateWebView1_ShouldInterceptRequest (Url As String) As WebResourceResponse 'Works from API level 11 to API level 20. WebViewClient required.  
    Dim Response As WebResourceResponse  
    Response.Initialize(AssetLoader.ShouldInterceptRequest(Url).WebResourceResponse)  
    Return Response  
End Sub  
  
Private Sub UltimateWebView1_ShouldInterceptRequest2 (Request As WebResourceRequest) As WebResourceResponse 'Works from API level 21 and above. WebViewClient required.  
    Dim Response As WebResourceResponse  
    Response.Initialize(AssetLoader.ShouldInterceptRequest(Request.Url).WebResourceResponse)  
    Return Response  
End Sub
```

  
  
Library references **htm** file is packed together with **jar** and **xml** file.  
  
If this library makes your work easier and saves time in creating your application, please make a donation.  
<https://www.paypal.com/donate?hosted_button_id=HX7GS8H4XS54Q>
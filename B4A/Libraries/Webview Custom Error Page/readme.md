### Webview Custom Error Page by Biswajit
### 05/12/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/117639/)

This code module will return a custom HTML design along with the actual error message instead of the default webview error page.  
  
Import the attached code module to your project and use it like below.  
  
**Usage:**  

```B4X
Sub Globals  
    Private MainWebView As WebView  
    Private WVE As WebViewExtras  
    Private DWVC As DefaultWebViewClient  
End Sub  
  
  
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("layout")  
   
    DWVC.Initialize("WebViewClient")  
    WVE.Initialize(MainWebView)  
    WVE.SetWebViewClient(DWVC)  
  
    WVE.LoadUrl("<your link>")  
End Sub  
  
Sub WebViewClient_ReceivedError(ErrorCode As Int, Description As String, FailingUrl As String)  
    WVE.LoadHtml(CustomWebviewError.GetErrorPageHtml(Description))  
End Sub
```
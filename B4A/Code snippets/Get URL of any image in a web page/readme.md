### Get URL of any image in a web page by SergeNova
### 11/07/2020
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/124311/)

Hello everyone, I looked in the forum for a way to get the url of an image (On a PC we right click to get a window that offers several parameters) but I did not find a good code . So after searching all over the place, I found Martin's AFWebkit library ( <https://www.b4x.com/android/forum/threads/webviewextras.12453/page-7#post-231721>).  
Here is how we can do it thanks to the AFWebkit library  
Thank you again very much to Martin for the library.  
  

```B4X
#Region  Project Attributes  
    #ApplicationLabel: Get Image Url  
    #VersionCode: 1  
    #VersionName:  
    'SupportedOrientations possible values: unspecified, landscape or portrait.  
    #SupportedOrientations: portrait  
    #CanInstallToExternalStorage: False  
#End Region  
  
#Region  Activity Attributes  
    #FullScreen: False  
    #IncludeTitle: False  
#End Region  
  
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'These variables can be accessed from all modules.  
  
End Sub  
  
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
    'These variables can only be accessed from this module.  
      
    Private WebView As FlingableWebView  
                                                      
    Dim WebViewClient1 As DefaultWebViewClient  
  
    Private PanelWebView As Panel  
    Private PanelImageQuestion As Panel  
    Private LabelImageUrl As Label  
    Private LabelOpenImage As Label  
    Private LabelSaveImage As Label  
    Dim UrlRefresh As String = "http://www.faceworldbu.simplesite.com"  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    'Do not forget to load the layout file created with the visual designer. For example:  
    'Activity.LoadLayout("Layout1")  
      
    Activity.LoadLayout("1")  
      
    WebView.Initialize("WebView")  
    WebView.ZoomEnabled = True  
    WebView.JavaScriptEnabled = True  
    PanelWebView.AddView(WebView, 0, 0, 100%x, 100%y)  
  
    Dim JavascriptInterface1 As DefaultJavascriptInterface  
    JavascriptInterface1.Initialize(WebView)  
    WebView.AddJavascriptInterface(JavascriptInterface1, "B4A")  
      
    ' Enable a _PageFinished event  
    WebViewClient1.Initialize("Handle_DWVC1")  
    WebView.SetWebViewClient(WebViewClient1)  
  
  
End Sub  
  
Sub Activity_Resume  
  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
  
End Sub  
  
Sub Handle_DWVC1_PageFinished (FlingableWebView1 As FlingableWebView, Url As String)  
      
End Sub  
      
Sub Handle_DWVC1_OverrideUrl(FlingableWebView2 As FlingableWebView, url As String) As Boolean  
    PanelImageQuestion.Visible = False  
    Return True  
End Sub  
      
   
Sub FlingableWebViewAj1_LongPress(X As Float, Y As Float)  
    Dim AjHitResult As HitTestResult = WebView.GetHitTestResult  
    LabelImageUrl.Text = AjHitResult.GetExtra  
      
    If LabelImageUrl.Text = "null" Then  
        ToastMessageShow("Null", False)  
    Else  
        PanelImageQuestion.Visible = True  
    End If  
      
End Sub  
  
Sub LabelOpenImage_Click  
    WebView.LoadUrl(LabelImageUrl.Text)  
    PanelImageQuestion.Visible = False  
End Sub  
  
Sub LabelSaveImage_Click  
    PanelImageQuestion.Visible = False  
    LabelImageUrl.Text = UrlRefresh  
    ' See this Url to download an Image : https://www.b4x.com/android/forum/threads/imagedownloader-the-simple-way-to-download-images.30875/  
End Sub
```
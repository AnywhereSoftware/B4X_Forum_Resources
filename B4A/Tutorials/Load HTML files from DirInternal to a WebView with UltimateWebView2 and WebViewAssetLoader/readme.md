### Load HTML files from DirInternal to a WebView with UltimateWebView2 and WebViewAssetLoader by b4x-de
### 01/23/2025
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/165222/)

I would like to contribute to the never-ending question of how to load local HTML files into a WebView. The reason are the following recently asked questions ([here](https://www.b4x.com/android/forum/threads/ultimatewebview2.158340/post-1011623) and [here](https://www.b4x.com/android/forum/threads/ultimatewebviewassetloader.144244/post-1011597) by [USER=117364]@Justmer Rivera[/USER] ), which I found unanswered.  
  
Therefore I would like to give an example of how the library [UltimateWebView2 and the contained WebViewAssetLoader](https://www.b4x.com/android/forum/threads/ultimatewebview2.158340/) can be used to load an HTML file from DirInternal, which refers to other local resources (e.g. an image below the images folder) within the HTML source code.  
  
I have summarized the most important parts of the solution here:  
  

```B4X
Sub Globals  
    Private WebView1 As WebView  
  
    ' from lib: WebViewExtras2 and WebViewSettings  
    Private WebViewEx As WebViewExtras  
    Private WebViewClient As DefaultWebViewClient  
      
    ' from lib: UltimateWebView2  
    Private WebViewAssetLoader1 As WebViewAssetLoader  
      
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("Layout")  
      
    ' Prepare Views  
    WebViewAssetLoader1.Initialize(Application.PackageName)  
    WebViewEx.Initialize(WebView1)  
    WebViewClient.Initialize("WebViewClient")  
    WebViewEx.SetWebViewClient(WebViewClient)  
    WebViewEx.JavaScriptEnabled=True  
  
      
    ' Copy test data  
    File.MakeDir(File.DirInternal, "images")  
    File.Copy(File.DirAssets, "test.html", File.DirInternal, "test.html")  
    File.Copy(File.DirAssets, "test.jpg", File.Combine(File.DirInternal, "images"), "test.jpg")  
End Sub  
  
Private Sub WebViewClient_ShouldInterceptRequest(Url As String) As WebResourceResponse  
    Log("URL: " &  Url)  
      
    Dim Response As WebResourceResponse  
    Dim ResponseReceived As WebResourceResponse  
  
    Try  
        ResponseReceived = WebViewAssetLoader1.ShouldInterceptRequest(Url)  
          
        If Not(ResponseReceived = Null) And ResponseReceived.IsInitialized Then  
            Response.Initialize(ResponseReceived.GetMimeType, ResponseReceived.GetEncoding, ResponseReceived.GetData)  
            Return Response  
        End If  
    Catch  
        ' In case the URL fails to load, we receive an exception here  
        Log("URL not found: " & Url)  
    End Try  
      
    Return Null  
      
End Sub
```

  
  
Attached you will find a working B4A example project. You will need the additional Libraries WebViewExtras2 and WebViewSettings to run it:  
<https://www.b4x.com/android/forum/threads/webviewsettings.12929/>  
<https://www.b4x.com/android/forum/threads/webviewextras.12453/>
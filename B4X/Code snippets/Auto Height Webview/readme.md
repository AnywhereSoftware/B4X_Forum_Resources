###  Auto Height Webview by Biswajit
### 08/27/2020
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/121630/)

**For B4i:**  

```B4X
Sub webview_PageFinished (Success As Boolean, Url As String)  
    wait for (webview.EvaluateJavaScript("document.documentElement.scrollHeight")) webview_JSComplete (Success As Boolean, Result As String)  
    If Success Then webview.Height = DipToCurrent(Result)  
End Sub
```

  
If you are using LoadHtml then add this following code before your html text  

```B4X
<head><meta name='viewport' content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no'/></head>
```

  
  
**For B4A:  
Dependency:** WebViewExtras2 (v2.20)  
  

```B4X
Sub Globals  
    Dim wve As WebViewExtras  
    Dim jsi As DefaultJavascriptInterface  
End Sub
```

  
  

```B4X
wve.Initialize(webview)  
jsi.Initialize  
wve.AddJavascriptInterface(jsi,"B4A")
```

  
  

```B4X
Sub webview_PageFinished (Url As String)  
    wve.ExecuteJavascript("B4A.CallSub('SetWVHeight',true, document.documentElement.scrollHeight);")  
End Sub  
  
Sub SetWVHeight(height As String)  
    webview.Height = DipToCurrent(height)  
End Sub
```
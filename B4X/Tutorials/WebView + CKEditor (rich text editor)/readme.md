###  WebView + CKEditor (rich text editor) by Erel
### 10/20/2022
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/133260/)

![](https://www.b4x.com/android/forum/attachments/117571)  
  
This is a cross platform example that adds CKEditor rich text editor using WebView: <https://ckeditor.com/ckeditor-5/>  
**Make sure to read CKEditor licensing and pricing: <https://ckeditor.com/pricing/>** (related discussion: <https://www.b4x.com/android/forum/threads/rich-editor-that-will-load-html.133256/#post-842092>)  
  
It also shows how to get the html string using this useful sub:  
  

```B4X
Private Sub RunJavaScript (js As String) As ResumableSub  
    #if B4A  
    WebViewExtras1.executeJavascript(WebView1, $"B4A.CallSub('Process_HTML', true, ${js})"$)  
    Wait For Process_Html(html As String)  
    Return html  
    #Else If B4J  
    Return WebView1.As(JavaObject).RunMethodJO("getEngine", Null).RunMethod("executeScript", Array(js))  
    #Else If B4i  
    Dim sf As Object = WebView1.EvaluateJavaScript(js)  
    Wait For (sf) WebView1_JSComplete (Success As Boolean, Result As String)  
    Return Result  
    #end if  
End Sub
```

  
  
It will require more work to make it actually useful but it should be a good start for anyone who is looking for a cross platform rich text editor.  
  
Download link: [www.b4x.com/android/files/CKEditor.zip](https://www.b4x.com/android/files/CKEditor.zip)  
B4A depends on WebViewExtras: <https://www.b4x.com/android/forum/threads/12453/#content>  
B4J requires Java 14. Link is available here: <https://www.b4x.com/android/forum/threads/b4j-v8-30-beta-is-available-for-download.117877/#content>
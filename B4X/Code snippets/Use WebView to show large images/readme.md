###  Use WebView to show large images by Erel
### 09/04/2021
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/102910/)

**Better to use: [[B4X] HugeImageView - show very large images](https://www.b4x.com/android/forum/threads/132905/#content)**   
  
Depends on: XUI and JavaObject.  

```B4X
'xui is a global XUI object.  
Private Sub ShowImage(WV As WebView, Dir As String, FileName As String)  
#if B4A  
    Dim jo As JavaObject = Me  
    jo.InitializeContext 'comment this line if calling this code from class  
    jo.RunMethod("zoom", Array(WV))  
#End If  
    If xui.IsB4J Then  
        WV.LoadHtml($"<img src="${xui.FileUri(Dir, FileName)}"/>"$)  
    Else  
        If Dir = File.DirAssets Then FileName = FileName.ToLowerCase  
        If xui.IsB4A Or Dir = File.DirAssets Then  
            WV.LoadHtml($"<img src="${xui.FileUri(Dir, FileName)}"/>"$)  
        Else  
            WV.LoadUrl("file://" & File.Combine(Dir, FileName))  
        End If  
    End If  
End Sub  
  
#if B4A  
#if Java  
public void zoom(android.webkit.WebView wv) {  
   wv.getSettings().setUseWideViewPort(true);  
   wv.setInitialScale(1);  
}  
#End If  
#End If
```

  
The inline java is required to start zoomed out.  
  
Don't miss the bottom of the code snippet. Scroll it down.
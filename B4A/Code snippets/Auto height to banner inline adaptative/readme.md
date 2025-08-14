### Auto height to banner inline adaptative by asales
### 07/21/2025
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/167869/)

This code (created with a help of ChatGPT) return the auto height to use in the banner inline adaptive.  
  
[Admob Example updated](https://www.b4x.com/android/forum/threads/b4xpages-admob-example.113586/).  

```B4X
Sub GetAutoHeightBannerSize As AdInlineSize  
    LogColor("GetAutoHeightBannerSize", Colors.Blue)  
  
    Dim ctxt As JavaObject  
    ctxt.InitializeContext  
  
    Dim AdSizeJO As JavaObject  
    AdSizeJO.InitializeNewInstance("com.google.android.gms.ads.AdSize", Array(-1, -2)) ' FULL_WIDTH, AUTO_HEIGHT  
  
    Dim res As AdInlineSize  
    res.Initialize  
    res.Inline = AdSizeJO  
  
    res.Width = AdSizeJO.RunMethod("getWidthInPixels", Array(ctxt))  
    res.Height = AdSizeJO.RunMethod("getHeightInPixels", Array(ctxt))  
  
    LogColor("AutoHeight Width (px): " & res.Width, Colors.Green)  
    LogColor("AutoHeight Height (px): " & res.Height, Colors.Cyan)  
  
    Return res  
End Sub
```

  
Usage:  

```B4X
Dim sizein As AdInlineSize = Utils.GetAutoHeightBannerSize  
Log(sizein.Height)  
Log(sizein.Width)
```
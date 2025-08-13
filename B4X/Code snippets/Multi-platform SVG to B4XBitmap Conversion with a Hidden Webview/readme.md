###  Multi-platform SVG to B4XBitmap Conversion with a Hidden Webview by William Lancee
### 03/26/2024
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/160119/)

I needed to scale and manipulate some iconic images for a project.  
There are many sites that offer free, but not unencumbered resources.  
  
I found <https://openmoji.org/>  
All emojis are free to use under the CC BY-SA 4.0 license  
<https://creativecommons.org/licenses/by-sa/4.0/>  
  
These SVG images are scalable. But I still needed a SVG to B4XBitmap converter to manipulate the pixels.  
[USER=9800]@stevel05[/USER] has made wrapper/API for a Java Fx SVG loader. But I needed something that would also work on B4A.  
  
I tried a few things, but then it occurred to me that Webview should be able to do it. And it could!  
  
Here is the conversion Sub:  

```B4X
Private Sub SVG2Bitmap(contents As String) As ResumableSub  
    Dim wv As WebView  
    wv.Initialize("wv")  
    Root.AddView(wv, -2 * Root.Width, 0, Root.Width, Root.Height)  
    wv.LoadHtml(contents)  
    wait for wv_Ready  
      
#if B4J                        'Only difference between B4J and B4A in this snippet  
    Dim bm As B4XBitmap = wv.Snapshot  
#else if B4A  
    Sleep(100)  
    Dim bm As B4XBitmap = wv.CaptureBitmap  
#End If  
    Return bm  
End Sub
```

  
  
I placed the Webview offscreen, so it is hidden. But not '.Visible = False', so it is possible to take a snapshot of the rendered SVG.  
  
The output of the attached example is:  
![](https://www.b4x.com/android/forum/attachments/152190)  
  
  
I have also attached my SVGPicker, feel free to use.
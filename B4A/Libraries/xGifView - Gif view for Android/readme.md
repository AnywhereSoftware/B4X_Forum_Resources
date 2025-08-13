### xGifView - Gif view for Android by tummosoft
### 04/19/2024
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/160599/)

There is GifView component library for Android. The version for B4J will update soon!  
  
![](https://www.b4x.com/android/forum/attachments/152852)  
  

```B4X
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
    Private Panel1 As Panel  
    Private ImageView1 As ImageView  
    Private Button1 As Button  
    Dim gif As xGifView  
    Dim gif1 As xGifView  
    Dim gif2 As xGifView  
    Dim gif3 As xGifView  
    Private Panel2 As Panel  
    Private Panel3 As Panel  
    Private Panel4 As Panel  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("Layout")  
    gif.initialize("gif")  
    gif1.initialize("gif1")  
    gif2.initialize("gif2")  
    gif3.initialize("gif3")  
    Panel1.AddView(gif, 0,0,Panel1.Width, Panel1.Height)  
    Panel2.AddView(gif1, 0,0,Panel1.Width, Panel1.Height)  
    Panel3.AddView(gif2, 0,0,Panel1.Width, Panel1.Height)  
    Panel4.AddView(gif3, 0,0,Panel1.Width, Panel1.Height)  
    File.Copy(File.DirAssets, "giphy.gif", File.DirInternalCache, "giphy.gif")  
    File.Copy(File.DirAssets, "giphy1.gif", File.DirInternalCache, "giphy1.gif")  
    File.Copy(File.DirAssets, "giphy2.gif", File.DirInternalCache, "giphy2.gif")  
    File.Copy(File.DirAssets, "giphy3.gif", File.DirInternalCache, "giphy3.gif")  
     
    Dim giffile As String = File.Combine(File.DirInternalCache, "giphy.gif")  
    gif.GifFile = giffile  
     
    Dim giffile1 As String = File.Combine(File.DirInternalCache, "giphy1.gif")  
    gif1.GifFile = giffile1  
    Dim giffile2 As String = File.Combine(File.DirInternalCache, "giphy2.gif")  
    gif2.GifFile = giffile2  
    Dim giffile3 As String = File.Combine(File.DirInternalCache, "giphy3.gif")  
    gif3.GifFile = giffile3  
     
End Sub
```
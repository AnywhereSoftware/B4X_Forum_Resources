###  SMM + BBCodeView - a great pair by Erel
### 09/01/2022
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/142661/)

![](https://www.b4x.com/android/forum/attachments/133225)  
  
SMM (SimpleMediaManager) is one of the more useful tools available for B4X developers. It takes care of many difficult tasks related to various media types: <https://www.b4x.com/android/forum/threads/b4x-simplemediamanager-smm-framework-for-images-videos-and-more.134716/#content>  
  
It is quite simple to combine it with BBCodeView and easily embed media inside rich text:  

```B4X
    BBCodeView1.Text = $"Title  
j fkselfj wlek fjwklefj klwefj klwef jklwef jklwe f  
 sdfjklsjfd ${Media(100dip, 100dip, "https://b4x-4c17.kxcdn.com/android/forum/data/avatars/m/109/109282.jpg?1520253241")}  
 Animated gif (do not forget to add SMM_GIF): ${Media(100dip, 100dip, "https://www.b4x.com/android/forum/attachments/anywhere-sw-gif.87363/")}  
 And a video (SMM_VIDEO): ${Media(200dip, 300dip, "https://player.vimeo.com/external/354886143.hd.mp4?s=2e182d1b22282a63a9533ffda5bb0b2295cdb8e6&profile_id=175")}  
"$
```

  
  

```B4X
Private Sub Media(Width As Int, Height As Int, URL As String) As String  
    Dim pnl As B4XView = xui.CreatePanel("")  
    pnl.SetLayoutAnimated(0, 0, 0, Width, Height)  
    SMM.SetMedia(pnl, URL)  
    Dim name As String = "view" & BBCodeView1.Views.Size  
    BBCodeView1.Views.Put(name, pnl)  
    Return $"[View=${name}/]"$  
End Sub
```

  
  
A B4J project is attached. It should be simple to port it to B4A / B4i.
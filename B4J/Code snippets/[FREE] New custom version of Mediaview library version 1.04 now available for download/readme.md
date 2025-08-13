### [FREE] New custom version of Mediaview library version 1.04 now available for download by TILogistic
### 12/10/2024
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/160019/)

New custom display version of MediaView and MediaController.  
  
****It is compatible with Simple Media Manager (SMM).****  
  
![](https://www.b4x.com/android/forum/attachments/159400)  
  
![](https://www.b4x.com/android/forum/attachments/159401)  
  
Library (b4xlib) attached for use, download in additional B4J libraries  
  
Library: jMediaView.b4xlib  
Example: MediaView.zip  
  
![](https://www.b4x.com/android/forum/attachments/159402)  
  

```B4X
'    ***********  MediaViewController ***********  
  
    'Example 1    
    MediaViewController1.SetBackgroundColor = xui.Color_ARGB(190,0,0,0)  
    MediaViewController1.SetTextIconColor = xui.Color_White  
     
    'Example 2  
'    Dim Colors() As Int = Array As Int(xui.Color_Black, xui.Color_White)  
'    MediaViewController1.SetBackgroundColorGradient(Colors, "BOTTOM_TOP")  
'    MediaViewController1.SetTextIconColor = xui.Color_Black  
  
    MediaViewController1.SetOnMouseOverVideo = True  
     
'    ***********  MediaView ***********  
     
    MediaView1.SetBackgroundColor = xui.Color_Black  
    MediaView1.SetPreserveRatio = False  
  
'    ***********  Visualize ***********  
  
'   Video  
    Dim VideoURL As String = "https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8"  
  
    MediaViewController1.SetMediaView(MediaView1)  
    MediaView1.Source = VideoURL  
    MediaView1.Play
```

  
  
Regards.
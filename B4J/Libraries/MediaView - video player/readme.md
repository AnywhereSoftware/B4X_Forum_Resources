### MediaView - video player by Erel
### 03/13/2024
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/134666/)

![](https://www.b4x.com/android/forum/attachments/119693)  
  
This library includes two custom views: MediaView and MediaViewController.  
MediaView can play local and remote videos and music.  
The native JavaFX MediaView doesn't include a controller interface. I've implemented one. You can use it or create your own. Tip: the controller code and layout are inside the b4xlib file.  
  
Usage:  
Add the two custom views and connect them:  

```B4X
MediaViewController1.SetMediaView(MediaView1)
```

  
  
Set the video source.  

```B4X
MediaView1.Source = "https://player.vimeo….
```

  
  
Use File.GetUri to play a local file.  
  
**Tip: the simplest way to create a MediaView is with SimpleMediaManager: <https://www.b4x.com/android/forum/threads/134716/#content>  
  
Updates**  
  
v1.03 - The MediaViewController class instance wasn't assigned to mBase.Tag correctly. This is fixed (<https://www.b4x.com/android/forum/threads/smm-access-to-the-mediaviewcontroller-b4j.159864/post-981468>)  
v1.02 - Fixes an issue with setting the volume.  
v1.01 - Fixes a layout issue.
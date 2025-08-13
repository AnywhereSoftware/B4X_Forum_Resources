### ExoPlayer - full screen feature by Erel
### 12/25/2023
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/132854/)

![](https://www.b4x.com/android/forum/attachments/116949)  
  
  
![](https://www.b4x.com/android/forum/attachments/116950)  
  
This example demonstrates how you can add a full screen button to a video. Clicking on the button, starts a new landscape activity and it then uses the native switchTargetView method to reuse the same player in the new SimpleExoPlayerView.  
There is also some calculations involved with adding the button based on the actual video dimension.  
Don't miss the manifest editor code that locks the second activity in landscape.  
  
**Project updated to work with ExoPlayer v3.** The change is simple, line 31 in FullScreen changed to:  

```B4X
jo.InitializeStatic("androidx.media3.ui.PlayerView")
```
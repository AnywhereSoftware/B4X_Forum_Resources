### ExoPlayer - MediaPlayer / VideoView Alternative by Erel
### 12/25/2023
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/72652/)

**Edit: new version: <https://www.b4x.com/android/forum/threads/exoplayer-media3-video-player.158204/>**  
  
ExoPlayer is an open source project that replaces the native MediaPlayer and VideoView types.  
<https://google.github.io/ExoPlayer/>  
License: Apache 2.0  
  
It supports more media formats, it is more powerful and more customizable.  
It is supported by Android 4.1+ (API 16+).  
  
![](https://www.b4x.com/android/forum/attachments/49700)  
  
There are two types: SimpleExoPlayer and SimpleExoPlayerView.  
  
SimpleExoPlayer is the internal engine, it is similar to MediaPlayer. SimpleExoPlayerView provides the interface.  
SimpleExoPlayer can be used without the interface.  
SimpleExoPlayer should be a process global variable.  
  
Example of video playback from an asset file (same exact code will work with audio files as well):  

```B4X
Sub Process_Globals  
   Private player1 As SimpleExoPlayer  
End Sub  
  
Sub Globals  
   Private SimpleExoPlayerView1 As SimpleExoPlayerView  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
   If FirstTime Then  
     player1.Initialize("player")  
     player1.Prepare(player1.CreateFileSource(File.DirAssets, "BLE_Chat.mp4"))  
   End If  
   Activity.LoadLayout("1")  
   SimpleExoPlayerView1.Player = player1 'Connect the interface to the engine  
End Sub
```

  
You can use player.CreateUriSource to load a remote resource:  

```B4X
player1.Prepare(player1.CreateUriSource("https://…"))
```

  
Or you can use one of the following methods for streaming resources:  
  
*CreateHLSSource* - Http Live Streaming  
*CreateDashSource* - Dynamic Adaptive Streaming over Http  
*CreateSmoothStreamingSource* - Smooth Streaming  
  
  
You can also create a playlist with multiple sources:  

```B4X
Sub Activity_Create(FirstTime As Boolean)  
   If FirstTime Then  
     player1.Initialize("player")  
     Dim sources As List  
     sources.Initialize  
     sources.Add(player1.CreateDashSource("http://www.youtube.com/api/manifest/dash/id/bf5bb2419360daf1/source/youtube?as=fmp4_audio_clear,fmp4_sd_hd_clear&sparams=ip,ipbits,expire,source,id,as&ip=0.0.0.0&ipbits=0&expire=19000000000&signature=51AF5F39AB0CEC3E5497CD9C900EBFEAECCCB5C7.8506521BFC350652163895D4C26DEE124209AA9E&key=ik0"))  
     sources.Add(player1.CreateHLSSource("https://devimages.apple.com.edgekey.net/streaming/examples/bipbop_4x3/bipbop_4x3_variant.m3u8"))  
     sources.Add(player1.CreateUriSource("http://html5demos.com/assets/dizzy.mp4"))  
     player1.Prepare(player1.CreateListSource(sources))  
  
   End If  
   Activity.LoadLayout("1")  
   SimpleExoPlayerView1.Player = player1  
   player1.Play  
End Sub
```

  
  
The library is attached.  
  
  
**It depends on several additional aar files (should be copied to the additional libraries folder):**   
[www.b4x.com/android/files/exoplayer-additional\_libs.zip](https://www.b4x.com/android/files/exoplayer-additional_libs.zip)  
  
Updates:  
  
V1.52 - Previous fix was incomplete. New version solves the issue.  
V1.51 - Fixes an incompatibility between ExoPlayer and Firebase. Make sure to update the additional libs package.  
V1.50 - New version based on ExoPlayer 2.13.3 (<https://github.com/google/ExoPlayer/blob/release-v2/RELEASENOTES.md>). The additional libs package was also updated.  
V1.41 - Fixes a bug where the designer properties where missing.  
V1.40 - Based on ExoPlayer v2.11.3. Make sure to update the additional libs as well.  
  
V1.30 - New InitializeCustom method that allows creating the native player with JavaObject.  
  
V1.20 - Based on ExoPlayer v2.10.2. This is a large update. Not all existing customizations (based on JavaObject) will work without modifications.  
  
V1.10 - Based on ExoPlayer v2.5.3.  
  
Make sure to update the additional aar files as well.
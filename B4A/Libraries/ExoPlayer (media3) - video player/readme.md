### ExoPlayer (media3) - video player by Erel
### 08/06/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/158204/)

ExoPlayer is a powerful media player created by Google: <https://developer.android.com/guide/topics/media/exoplayer>  
  
This version is based on Media3 ExoPlayer v1.2. It replaces ExoPlayer 2: <https://www.b4x.com/android/forum/threads/exoplayer-mediaplayer-videoview-alternative.72652/#content>  
The underlying SDK isn't backward compatible so calls with JavaObject may not work without modifications.  
  
Setup:  
1. Download the attached library and copy to the additional libraries folder. ExoPlayer is an internal library, starting with B4A v13.4.  
2. Download the additional dependencies and copy to the additional libraries folder: <https://www.b4x.com/android/files/exoplayer3_additional.zip>  
  
Usage instructions:  
1. Add a SimpleExoPlayerView with the designer.  
2. Declare and initialize a SimpleExoPlayer object.  
3. Set the player:  

```B4X
SimpleExoPlayerView1.Player = Player
```

  
4. Create one or more sources with the various "create" methods and call Player.Prepare to load them.  
  
Example is attached.  
  
![](https://www.b4x.com/android/forum/attachments/148977)  
  
Note that you can use SMM to manage and load videos: [[B4X] SimpleMediaManager (SMM) - framework for images, videos and more](https://www.b4x.com/android/forum/threads/134716/#content)  
  
  
Updates:  
v3.11 - Added missing dependency (androidx.core:core-ktx)  
v3.10 - Updated dependencies. Requires B4A v13.4+ with an updated SDK. **This is an internal library now.**  
v3.02 - Updated dependencies.   
v3.01 - Fixes a compatibility issue with Firebase libraries. The dependencies package was updated as well (step #2 above).
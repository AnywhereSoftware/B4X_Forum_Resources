###  MediaChooser - cross platform videos and images chooser by Erel
### 01/05/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/161093/)

This library makes it simple to let the user choose or capture media.  
  
![](https://www.b4x.com/android/forum/attachments/153679)  
  
Features:  

- Allows the user to capture videos and still pictures (B4A and B4i only).
- Allows the user to pick videos and pictures.
- Very easy to use together with SimpleMediaManager.
- Detects images mime types. Jpeg and Gifs.
- Works with a progress bar that shows when items need to be copied. This is currently only relevant to B4A.
- B4A - no permissions needed.

Usage instructions: see the example. It is quite simple.  
  
Notes:  

- B4i - see #Plist declarations in main module.
- B4A - see FileProvider declarations in manifest editor and the new foregroundServiceType declaration.
- See the build configuration symbols (Ctrl + B) required for SMM features: <https://www.b4x.com/android/forum/threads/b4x-simplemediamanager-smm-framework-for-images-videos-and-more.134716/#content>

Updates:  
  
- v1.02 - (B4A) KeepRunningService.NotificationTitle field. Default value is "Taking picture".  
- v1.01 - (B4A) adds support for targetSdkVersion=34. **New requirement in manifest editor:** SetServiceAttribute(KeepRunningService, android:foregroundServiceType, shortService)  
  
Examples depend on ExoPlayer: <https://www.b4x.com/android/forum/threads/exoplayer-media3-video-player.158204/#content>
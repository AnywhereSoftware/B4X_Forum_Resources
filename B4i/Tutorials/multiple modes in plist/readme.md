### multiple modes in plist by bobbruns
### 12/24/2022
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/145009/)

I wanted my program to run in the background. (Ios requires an addition to the plist, android requires addition to the manifest) It includes both location and audio. You can find out how to do both here.  
  
If you want multiple modes in your plist file, doing it like this seems to work:  
  
#PlistExtra: <key>UIBackgroundModes</key><array><string>location</string><string>audio</string></array>  
  
plists are xml apparently.  
  
cheers.
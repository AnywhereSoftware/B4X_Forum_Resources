### Play SystemSounds (and Vibration) by Mike1970
### 05/12/2021
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/130650/)

Hi, i found [this post](https://www.b4x.com/android/forum/threads/play-beep-sound.98592/#content) on the forum from [USER=74499]@aeric[/USER]  
  
I slightly modified it to play every sound you want from the systemsounds of iOS, by passing the ID.  
The id list can be found here: [iOSSystemSoundsLibrary](https://github.com/TUNER88/iOSSystemSoundsLibrary)  
  

```B4X
Sub PlaySystemSound(id As Int)  
    Dim NativeMe As NativeObject = Me  
    NativeMe.RunMethod("play:", Array(id))  
End Sub  
#If ObjC  
#import <AVFoundation/AVAudioPlayer.h>  
- (void) play: (int) id{  
  AudioServicesPlaySystemSound(id);  
}  
#End If
```

  
  
  
Don't forget to put this in Region Attributes (main):  

```B4X
#IgnoreWarnings: 32
```

  
  
Maybe can be useful
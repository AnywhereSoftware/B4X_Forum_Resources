### play sound in linux by mzsoft
### 11/14/2023
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/157384/)

in linux if use MediaPlayer this error show.  

```B4X
MediaException: UNKNOWN : com.sun.media.jfxmedia.MediaException: Could not create player! : com.sun.media.jfxmedia.MediaException: Could not create player!
```

  
for play sound in linux you can use this java code.  
  

```B4X
Sub play_sound(path as string)  
Dim jo As JavaObject = Me  
jo.RunMethod("playWav", Array As Object(path))  
End Sub  
  
Sub stop_sound  
    Dim jo As JavaObject = Me  
    jo.RunMethod("stopWav", Null)  
  
End Sub  
  
  
#if java  
import javax.sound.sampled.AudioSystem;  
import javax.sound.sampled.Clip;  
import java.io.File;  
  
private static Clip clip;  
  
 public static void playWav(String wavFilePath) {  
        try {  
            clip = AudioSystem.getClip();  
            clip.open(AudioSystem.getAudioInputStream(new File(wavFilePath)));  
            clip.start();  
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
    }  
  
    public static void stopWav() {  
        if (clip != null && clip.isRunning()) {  
            clip.stop();  
        }  
    }  
  
  
#End If
```
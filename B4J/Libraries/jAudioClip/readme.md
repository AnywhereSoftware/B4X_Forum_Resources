### jAudioClip by stevel05
### 09/06/2022
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/37828/)

This is a wrapper for the JavaFX AudioClip class. the Oracle documentation is [here](http://docs.oracle.com/javafx/2/api/javafx/scene/media/AudioClip.html).  
  
It is similar to the Android SoundPool in that it is intended to play short audio files with low latency, mainly for use with games and audio effects.  
  
You can control the volume, pan, rate, looping (cyclecount, set to -1 to play indefinitly) and priority.  
  
**AudioClip  
Author:** Steve Laming  
**Version:** 1.0  
  

- **Methods:**

- **Balance**(balance As double)  As double
*Get / Set the default balance level for this clip.*
**CycleCount**(count As int)  As int
*Get / Set the default cycle count.*
**Initialize**(URI As java.lang.String)  As void
*Initialize the object.  
 Requires a URI obtainable as File.GetURI(Dir,FileName))*
**isPlaying**  As boolean
*Indicate whether this AudioClip is playing.*
**Pan**(pan As double)  As double
*Get / Set the default pan value.*
**Play**
*Play the AudioClip using all the default parameters.*
**Play2**(volume As double)
*Play the AudioClip using all the default parameters except volume.*
**Play3**(volume As double, balance As double, rate As double, pan As double, priority As int)
*Play the AudioClip using the given parameters.*
**Priority**(priority As int)  As int
*Get / Set the default playback priority.*
**Rate**(rate As double)  As double
*Get / Set the default playback rate.*
**SetCompleteListener** (Module As Object, EventName As String)
*Set the callback sub for the complete listener.*
**Source**  As String
*Get the source URL used to create this AudioClip.*
**Stop**
*Immediately stop all playback of this AudioClip.*
**Volume**(value As double)  As double
*Get / Set the default volume level.*
  
**AudioClip\_Static**  
  

- **Methods:**

- **INDEFINATE**
*When cycleCount is set to this value, the AudioClip will loop continuously until stopped.*
**NewAudioClip**](Source As String)  As Audioclip
*Create an AudioClip loaded from the supplied source URL.*
**NewAudioClip2**](Folder As String,FileName As String)  As Audioclip
*Create an AudioClip loaded from the supplied source Folder and FileName..*
  
A very simple example is attached. (jAudioClipTest.zip)  
  
Download the jAudioClipLib.zip file, unzip and copy the jar and xml to your B4j additional libraries folder.  
  
I haven't tested this extensively so please let me know if you find any issues.  
  
428
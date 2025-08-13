### Code Module FFMPeg_Utils for jAudioTrack2 and jAudioRecord2 by stevel05
### 08/23/2022
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/142306/)

Using FFMPeg Command Line and jShell, it is possible to convert most file formats to and from a wav file that jAudioRecord2 writes and a jAudioTrack2 plays.  
  
The conversion is done very quickly, and has many options (see the FFMPeg documentation)  
  
This CodeModule just performs a basic conversion without changing any parameters. The two demo apps are just for completeness. I have included mp3, flac and ogg as that is what I will use most, but I am sure there are more codec that FFMpeg supports you may find useful.  
  
The jAudiorecord2-FFMpeg demo uses Mediaplayer to play the files, although it only supports Mp3's. you are given an option to play on the system default player for the file type if you have one for those not supported, or you can run the jAudiotrack2-FFMpeg demo and play them using that.  
  
This is the source for the code module, it's probably easier to copy it into a new code module than download it, but it's there if you want it. I haven't created a b4xlib for it as you are likely to want to be able to change some parameters in the Shell arguments and there are too many to parameterize, so you can build your own b4xlib when you are happy with it.  
  

```B4X
'Static code module FFMPeg_Utils  
Sub Process_Globals  
    Private fx As JFX  
End Sub  
  
Public Sub Convert(PathTOFFMpeg As String, SourcePath As String,SourceFile As String,TargetPath As String,TargetFile As String)  
    Dim Args As List  
    Args.Initialize  
   
    Args.AddAll(Array("-y","-i"))  
    Args.AddAll(Array(File.Combine(SourcePath,SourceFile),File.Combine(TargetPath, TargetFile)))  
   
    Dim Sh As Shell  
    Sh.Initialize("SH",PathTOFFMpeg,Args)  
    Sh.Run(-1)  
   
    Wait For SH_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)  
End Sub
```

  
  
**Setup**  
Download an unpack FFMpeg from <https://ffmpeg.org/>  
Add it's location to the demos and play away.  
  
  
  
The two demo apps depend on [jAudioTrack2](https://www.b4x.com/android/forum/threads/b4j-jaudiotrack2.142197/) and [jAudioRecord2](https://www.b4x.com/android/forum/threads/b4j-jaudiorecord2.142154/) libraries respectively.  
  
**Update  
JAudioRecord2-FFMpeg V0.11 - 14 Aug 2022**  
 Tidied Error messages  
 Updated to allow capture of non wav files using the FILE method as well as the RAW method
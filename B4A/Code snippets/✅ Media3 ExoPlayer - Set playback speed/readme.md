### ✅ Media3 ExoPlayer - Set playback speed by Peter Simpson
### 08/28/2024
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/162779/)

**SubName:** Set the video playback speed and audio pitch for Media3 ExoPlayer  
**Description:** As Erel now recommends using the newer updated Media3 ExoPlayer library, you can use the following updated code (updated from Erel's original code) to set the video playback speed and audio pitch whilst watching media using Media3 ExoPlayer.  
  

```B4X
    SetSpeedPitch(1.0, 1.0) 'Speed, Audio Pitch
```

  

```B4X
Private Sub SetSpeedPitch (Speed As Float, Pitch As Float)  
    ExoPlayer.As(JavaObject).GetFieldJO("player").RunMethod("setPlaybackParameters", Array(CreatePlaybackParameters(Speed, Pitch)))  
End Sub  
  
Private Sub CreatePlaybackParameters(Speed As Float, Pitch As Float) As JavaObject 'Speed = Video Speed, Pitch = Audio Pitch (The factor by which the pitch of audio will be adjusted)  
    Dim PlaybackParameters As JavaObject  
        PlaybackParameters.InitializeNewInstance("androidx.media3.common.PlaybackParameters", Array(Speed, Pitch))  
    Return PlaybackParameters  
End Sub
```

  
  
  
**Enjoy…  
  
  
Tags:** Media3, ExoPlayer, Playback, Speed, Audio, Pitch
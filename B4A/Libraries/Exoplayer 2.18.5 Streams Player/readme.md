### Exoplayer 2.18.5 Streams Player by Addo
### 04/02/2023
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/141854/)

Hi, **This is Based on the Wrapper of [Erel](https://www.b4x.com/android/forum/threads/exoplayer-mediaplayer-videoview-alternative.72652/) .**   
I was in need to use the latest Exoplayer for only one purpose is to play RTMP Streams.  
also this Exoplayer Replaces deprecated playerview with StyledPlayerView.  
  
**You need this Additional Following AArs to be located in your Additional Libraries Folder in order to use this library.  
  
Version 1.40 required aar.**  
[Additional AAR 2.18.2](https://drive.google.com/file/d/11l_2eq2YD6EKTOEcCu8Wm8lkVkerynqJ/view?usp=share_link)  
  
**Version 1.50 required aar.**  
[Additional AAR 2.18.3](https://drive.google.com/file/d/1__LcrgBE0wrADMQJALxp_7ebIYFFHZL6/view?usp=share_link)  
  
**Version 1.60 required aar.**  
[Additional AAR 2.18.4](https://drive.google.com/file/d/1pTQNWHfhoYosQbqRb0PbQH_HPAepKTzv/view?usp=share_link)  
  
**Version 1.70 required aar.**  
[Additional AAR 2.18.5](https://drive.google.com/file/d/1DnIA8KFm5Ecyu7hoMeVgx-cLF0KDpV0y/view?usp=share_link)  
  
**Functionality :**  

- **CreateUriSource**
- **CreateSmoothStreamingSource**
- **CreateHLSSource**
- **CreateDashSource**
- **CreateFileSource**
- **CreateRtspStreamingSource**
- **CreateRtmpStreamingSource**
- **CreateUdpStreamingSource**
- **CreateListSource**
- **setReapeatMode**
- **getIsPlaying**
- **Prepare**
- **Play**
- **Pause**
- **Release**
- **getPosition**
- **setPosition**
- **getDuration**
- **getVolume**
- **setVolume**
- **getCurrentMediaItemIndex**
- **GetvideoFormatwidth**
- **GetvideoFormatHeight**
- **GetAudioTracksLanguages**
- **GetVideoTrackSubtitles**
- **preferedAudioLanguage**
- **preferedtextLanguage**
- **EnableSubtitles**

 **DesignerProperties**  

- **SPlayerView**
- **ResizeMode [FIT|FIXED\_HEIGHT|FIXED\_WIDTH]**
- **UseController default is true**
- **ShowBuffering [NEVER|PLAYING|ALWAYS] default is NEVER**
- **ControllerTimeout default is 5000**

I may Extends More functionality in the future .  
  
**Requires Appcompat Library  
  
Example is included.  
  
Events :**  

- **Player\_Ready**
- **Player\_Error**
- **Player\_Complete**
- **IDLE**
- **Buffering**

**Update Version 1.40**  

- **FFMPEG Extension is Supported**
- **FFmpegavailabe** << to check weather ffmpeg is available or not.
- **FFMPEG Initialize Choice during initialization Prefer To use FFMPEGAUDIO Decoding only for now**
- **player.Initialize("player", UseFFmpeg as boolean, FFMPEGAUDIO As boolean, FFmpegVideo As Boolean)**
- **FFMPEG AUDIO AND VIDEO Decoder**

**Updated Version 1.50  
Upgrade to latest exoplayer 2.18.3**  
[Change Log](https://github.com/google/ExoPlayer/releases/tag/r2.18.3)  
  
**Updated Version 1.60**  

- **Upgraded to the latest ExoPlayer 2.18.4 >** [**Change Log**](https://github.com/google/ExoPlayer/blob/release-v2/RELEASENOTES.md)
- **Fixed GetvideoFormatwidth, GetvideoFormatHeight when playing media without video it will return -1 if the media doesn't have video.**
- **Added Stop method to stop the player.**

**Updated Version 1.70**  

- **Upgraded to the latest ExoPlayer 2.18.5**
- **Added IDLE EVENT and Buffering Event.**

**download additional aar to use the latest exoplayer fixes.**
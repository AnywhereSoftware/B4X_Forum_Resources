### addoMedia3 - AndroidX Media3 Exoplayer Wrapper by Addo
### 07/09/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/147560/)

This library is wrapper for the new AndroidX Media3 Library which is based on Exoplayer You can still use my [previous wrapper](https://www.b4x.com/android/forum/threads/exoplayer-2-18-5-streams-player.141854/#post-899123).  
Since from now on the new updates and releases will be Published to AndroidX Media3 Library. so i migrate the whole wrapper to the new codebase.  
  
**Version 1.3.1 required aar.**  
[Additional AAR 1.3.1](https://drive.google.com/file/d/1Kq8TAwGyVH6Cfw6oq3h_tpJdV_6HnLGk/view?usp=sharing)  
  
**Functionality :**  

- **CreateUriSource**
- **CreateSmoothStreamingSource**
- **CreateHLSSource**
- **CreateDashSource**
- **CreateFileSource**
- **CreateRtspStreamingSource**
- **CreateRtmpStreamingSource**
- **CreateUdpStreamingSource**
- **clearMediaItems**
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
- **PlaybackSpeed**

  
**DesignerProperties**  

- **Media3PlayerView**
- **ResizeMode [FIT|FIXED\_HEIGHT|FIXED\_WIDTH]**
- **UseController default is true**
- **ShowBuffering [NEVER|PLAYING|ALWAYS] default is NEVER**
- **ControllerTimeout default is 5000**

**Events :**  

- **Player\_Ready**
- **Player\_Error**
- **Player\_Complete**
- **Player\_MetaData(metadataFields As Map)**
- **IDLE**
- **Buffering**

**Library and Example attached. Don't forget to download the required media3 aars, have a good day.  
  
Updated to version 1.3  
  
Added**   

- **TrackMetadata**
- **PlaybackSpeed**

```B4X
Sub Player_Ready  
    addoPlayer.TrackMetadata  
    Log("Ready")  
End Sub  
  
'example of calling th event  
  
Sub Player_MetaData(metadataFields As Map)  
    Log(metadataFields)  
    Label1.Text = ""  
    If metadataFields.ContainsKey("Title") Then  
        Label1.Text = metadataFields.Get("Title")  
    End If  
    ' Handle the metadata fields here  
    If metadataFields.ContainsKey("ArtworkData") Then  
        Dim artworkData() As Byte = metadataFields.Get("ArtworkData")  
        ' Create an InputStream from the byte array  
        Dim inp As InputStream  
        inp.InitializeFromBytesArray(artworkData, 0, artworkData.Length)  
        ' Create a Bitmap from the InputStream  
        Dim bitmap As Bitmap  
        bitmap.Initialize2(inp)  
        ImageView1.Bitmap = bitmap  
        ImageView1.Visible = True  
    End If  
End Sub
```

  
  
**Updated Media3 to the latest 1.3.1  
  
Updated to version 1.4**  

- **Fixes an incompatibility between ExoPlayer and Firebase. Make sure to update the additional libs package.**

**updated to version 1.6**  

- **Updated the dependencies to be compatible with b4a 13+**
- **removed PlayList replaced with CreateListSource**

****updated to version 1.7****  

- ****Added a new view addoMedia3TexureView based on TextureView.****
- ****Added GetVideoTextLanguages2****
- ****Added GetAudioTracksLanguages2****
- ****Added SetTextLanguage2****
- ****SetAudioLanguage2****
- ****Added Event\_GetVideoTextLanguages2(Subtitles As Map)****
- ****Added Event\_Getaudiolanguages2(audiotracks As Map)****

****As mentioned in**** [this thread](https://www.b4x.com/android/forum/threads/exoplayer-2-18-5-streams-player.141854/post-996678) there was issue on setting and retrieving the correct supported languages for audio and subtitles use ****GetVideoTextLanguages2 and ****GetAudioTracksLanguages2******** to retrieve the correct language information.  
  
The TextureView is a new view added to gives the ability to rotate the player [as mentioned here](https://www.b4x.com/android/forum/threads/exoplayer-2-18-5-streams-player.141854/post-996783). the down side of using textureview that the subtitle in videos will not be visible.  
  
****updated to version 1.8  
  
in this update addoMedia3 and ********addoMedia3TexureView has a new method and event.************  

- ****Added a new method takeScreenshot.****
- ****Added a new event OnScreenShot(screensrc() As Byte)****

  
****updated to version 1.9****  
  

- ****Removed the internal dependencies so you can add them selectively as #AdditionalJar in b4a IDE****

```B4X
#Region Additional libs  
  
#AdditionalJar: addoexo/media3-common-1.3.1.aar  
#AdditionalJar: addoexo/media3-container-1.3.1.aar  
#AdditionalJar: addoexo/media3-database-1.3.1.aar  
#AdditionalJar: addoexo/media3-datasource-1.3.1.aar  
#AdditionalJar: addoexo/media3-datasource-rtmp-1.3.1.aar  
#AdditionalJar: addoexo/media3-decoder-1.3.1.aar  
#AdditionalJar: addoexo/media3-exoplayer-1.3.1.aar  
#AdditionalJar: addoexo/media3-exoplayer-dash-1.3.1.aar  
#AdditionalJar: addoexo/media3-cast-1.3.1.aar  
#AdditionalJar: addoexo/media3-exoplayer-hls-1.3.1.aar  
#AdditionalJar: addoexo/media3-exoplayer-rtsp-1.3.1.aar  
#AdditionalJar: addoexo/media3-exoplayer-smoothstreaming-1.3.1.aar  
#AdditionalJar: addoexo/media3-extractor-1.3.1.aar  
#AdditionalJar: addoexo/media3-ui-1.3.1.aar  
#AdditionalJar: addoexo/rtmp-client-3.2.0.aar  
#AdditionalJar: addoexo/guava-31.1-android-without-listenable.jar  
#AdditionalJar: androidx.recyclerview:recyclerview  
#AdditionalJar: androidx.customview:customview-poolingcontainer  
#AdditionalJar: androidx.media:media  
#AdditionalJar: com.google.guava:listenablefuture  
#AdditionalJar: androidx.tracing:tracing-android  
#AdditionalJar: androidx.collection:collection  
#End Region
```

  
  
Example Updated to describe the usage of both views.  
  
**Important Note Additional aar files must be place in a folder with name addoexo.  
  
  
I may add more features to this library..**
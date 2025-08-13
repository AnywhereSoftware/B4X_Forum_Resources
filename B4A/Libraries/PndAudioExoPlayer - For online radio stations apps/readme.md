### PndAudioExoPlayer - For online radio stations apps by Pendrush
### 10/16/2022
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/139173/)

Original library: <https://github.com/google/ExoPlayer>  
Wrapper is based on ExoPlayer version v2.18.1 (22 Jul 2022)  
  
This wrapper is not substitute for [Erel's ExoPlayer](https://www.b4x.com/android/forum/threads/exoplayer-mediaplayer-videoview-alternative.72652/), it was created with one goal in mind, to make it easier to create applications that use the online radio streams.  
  
A few things have been added or made easier in relation to Erel's:  

- Handle audio focus - temporary mute player on call, SMS, etc.
- Player's user agent
- Radio station metadata
- Stream metadata
- Show song name, artist and album art (image) on remote Bluetooth device
- Control player from remote device (smart watch, car's steering wheel, headphones, etc.)
- Audio session ID for future improvements.

  
Some of the data you can extract from metadata: radio station name, song name, bitrate, radio station genre, radio station's url, etc.  
Library can be used in Activity/B4XPage/Service.  
**Requires: B4A v11.5+**, **minSdkVersion: 21+**  
  
![](https://www.b4x.com/android/forum/attachments/126778)  
  
This is how example app looks on my Samsung (Tizen) watch, similar look and same functionality on Android and Huawei watches:  
![](https://www.b4x.com/android/forum/attachments/126719)  
  
If you use non secure HTTP protocol for streams, you need to add this code in manifest:  

```B4X
CreateResourceFromFile(Macro, Core.NetworkClearText)
```

  
  
> **PndAudioExoPlayer  
>   
> Author:** Author: Google - B4a Wrapper: Pendrush  
> **Version:** 1.30  
>
> - **PndAudioExoPlayer**
>
> - **Events:**
>
> - **MediaSessionOnButton** (KeyCode As Int)
> - **MediaSessionOnPause**
> - **MediaSessionOnPlay**
> - **MediaSessionOnStop**
> - **OnAudioSessionIdChanged** (AudioSessionId As Int)
> - **OnIsPlayingChanged** (IsPlaying As Boolean)
> - **OnMetadata** (Metadata As String)
> - **OnPlaybackStateChanged** (PlaybackState As Int)
> - **OnPlayerError** (Error As String)
> - **OnTracksChanged** (Metadata As String)
>
> - **Functions:**
>
> - **AudioSessionId** As Int
>  *Returns the audio session identifier.*- **HlsMediaSource** (Url As String)
>  *For: HLS streams (stream Url ends with .m3u8)  
>  Url - Radio station stream Url*- **Initialize** (EventName As String, UserAgent As String, HandleAudioFocus As Boolean, AllowCrossProtocolRedirects As Boolean)
>  *Initialize player.  
>  EventName - Event name.  
>  UserAgent - User agent of player.  
>  HandleAudioFocus - Whether the player should handle audio focus, for example temporary mute player on call, SMS, etc.  
>  AllowCrossProtocolRedirects - Allow redirect from HTTPS to HTTP and vice versa.   
>  PndAudioExoPlayer1.Initialize("PndAudioExoPlayer1", "MyAppUserAgent/1.0", True, True)*- **IsInitialized** As Boolean
> - **IsPlaying** As Boolean
> *Returns whether the player is playing.*- **Play**
> *Resumes playback.*- **ProgressiveMediaSource** (Url As String)
>  *For: MPEG (MP3), AAC, OGG streams  
>  Url - Radio station stream Url*- **Release**
>  *Releases the player.  
>  This method must be called when the player is no longer required.  
>  The player must not be used after calling this method.*- **Stop**
>  *Stops playback.*- **UpdateMediaSession** (KeyTitle As String, KeyArtist As String, KeyAlbumArt As android.graphics.Bitmap)
>  *This items will display on remote (bluetooth) device like: smart watch, car display, etc.  
>  KeyTitle - Title name or song name  
>  KeyArtist - Artist name or for example radio station name  
>  KeyAlbumArt- Image of album or for example radio station logo.*
> - **Properties:**
>
> - **Volume** As Float
>  *Get or Sets the audio volume.  
>  Range(from = 0.0, to = 1.0)*

  
[SIZE=5]**What's new:**[/SIZE]  
  
v1.30  

- ExoPlayer library v2.18.1 (22 Jul 2022)
- Event name renamed from **OnTracksInfoChanged** to **OnTracksChanged** (event name is changed in original ExoPlayer library).
- Example app updated, with new event, notification (foreground service) and PartialLock to prevent system to kill app/service.

v1.21  

- Resolved conflict with RuntimePermissions library.
- Example app updated, removed AppCompat library.

v1.20  

- Previous, Next and all other media buttons will rise new event MediaSessionOnButton (KeyCode As Int)
- Example app updated

v1.10  

- UpdateMediaSession - Title, song name and album art for remote devices like: smart watch, car display, etc.
- 3 new events for remote devices (Bluetooth): play, pause, stop, this also should work from headphone devices. You can use it FROM remote device to control player on your phone, volume also work from remote device.

  
**Download library from**: <https://www.dropbox.com/s/p1l6ixw758r68wt/PndAudioExoPlayerLibrary.zip?dl=0>
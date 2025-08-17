### SD_Streaming (DEMO) by Star-Dust
### 02/20/2023
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/146306/)

This library is developed in JAVA and is a wrapper of the VLCj library. Is based on the code by [USER=2353]@moster67[/USER] (see [**here**](https://www.b4x.com/android/forum/threads/b4jvlcj-embed-vlc-mediaplayer-in-your-program-app.77098/#content)). It has been reworked to obtain an h.264 streaming from the pc cam, streaming of an mp4 video and finally of the desktop and a portion of it,  
You must have VLC installed in your pc. If you have Window Pro you must have administrator permissions to access a folder where a DLL is contained.  
You can download a second library which builds on this and facilitates some functions (see [**here**](https://www.b4x.com/android/forum/threads/sd_videostreaming-demo.146285/)).  
Special thanks to [USER=2353]@moster67[/USER] for the help.  
  
**NOTE**  
It depends on the following libraries: jna-4.1.0, slf4j-api-1.7.10, jna-platform-4.1.0, vlcj-3.10.1 (Add the extra jars in your B4J Extra/Additional Library folder)  
This version is demo only and the streaming time is limited to 120 seconds. It will take a few seconds before the stream is sent because it needs to create enough cache.  
**It is necessary** to create an fxml file in order to hook the player to a panel. the fxml file attached in the example must be modified based on the packagename and one must be created for each bread that will contain the player  
  
**SD\_StreamingDEMO  
  
Author:** Star-Dust  
**Version:** 1.01  

- **SD\_Streaming**

- **Events:**

- **ChangeState** (state As Int)
- **Error**
- **Finished**
- **Prepared**

- **Fields:**

- **player** As player.VideoPlayer

- **Functions:**

- **CanPause** As Boolean
*Can the current media be paused?  
 returns true if the current media can be paused, otherwise false*- **GetAspectRatio** As String
*Get the video aspect ratio.  
 Returns aspect ratio ONLY if you have set the AspectRatio yourself.*- **GetLength** As Long
*Get the length of the current media item.  
 Returns: length, in milliseconds*- **GetPlaySpeedRate** As Float
*Get the current video play speed rate.  
 speedRate, where 1.0 is normal speed, 0.5 is half speed, 2.0 is double speed and so on*- **GetPosition** As Float
*Get the current play-back position.  
 Returns current position, expressed as a percentage (e.g. 0.15 is returned for 15% complete)*- **GetScale** As Float
*Get the current video scale (zoom factor).*- **GetTime** As Long
*Get the current play-back time.  
 Returns current time, expressed as a number of milliseconds*- **GetVolume** As Int
*Get the current volume.  
 Returns volume, a percentage of full volume in the range 0 to 200*- **Initialize** (EventName As String)
*Initializes B4JVlcj. You must set an event-name if you want to monitor events.  
 Important: Always check if VLC is installed before initializing using  
 the IsVLCInstalled-method.  
 Important: When exiting your app, always make sure to use the release-method!*- **IsInitialized** As Boolean
- **IsPlayable** As Boolean
*Is the current media playable?  
 returns true if the current media is playable, otherwise false*- **IsPlaying** As Boolean
*Is the media player playing?  
 returns true if the media player is playing, otherwise false*- **IsSeekable** As Boolean
*Is the current media seekable?  
 returns true if the current media is seekable, otherwise false*- **IsVLCInstalled** As Boolean
*This method should be the first code you run before initializing B4JVlcj.  
 Returns if VLC has been installed on the computer or not. If VLC has been  
 installed in a non-standard directory, VLC might not be found.*- **Mute**
*Mutes volume*- **Pause**
*Pauses media*- **Play** (source As String)
*Plays media (can be a local file or a streaming source)*- **PlayExtra** (Options As String(), source As String)
- **release**
*Use this on the b4j closing event. Final step to do is to release vlc.*- **SaveCam** (filename As String, DegreeRotate As Int)
- **SaveDesktop** (filename As String)
- **SetAspectRatio** (AspectRatio As String)
*Set the video aspect ratio  
 Param: aspectRatio - aspect ratio, e.g. "16:9", "4:3", "185:100" for 1:85.1 and so on*- **SetPlaySpeedRate** (speedRate As Float) As Int
*Set the video play speed rate.  
 Some media protocols are not able to change the speed rate.  
 speed rate - rate, where 1.0 is normal speed, 0.5 is half speed, 2.0 is double speed and so on  
 Returns: -1 on error, 0 on success*- **SetPosition** (position As Float)
*Jump to a specific position. If the requested position  
 is less than zero, it is normalised to zero.  
 Param: position - position value, a percentage (e.g. 0.15 is 15%)*- **SetScale** (factor As Float)
*Set the video scaling factor  
 Param: factor - scaling factor, or zero to scale the video the size of the container*- **SetTime** (time As Long)
*Jump to a specific moment.  
 If the requested time is less than zero, it is normalised to zero  
 Param: time - time since the beginning, in milliseconds*- **SetVolume** (volumeLevel As Int)
*Set the volume.  
 The volume is actually a percentage of full volume, setting a volume  
 over 100 may cause audible distortion.  
 Param: volumeLevel - a percentage of full volume in the range 0 to 200*- **Skip** (delta As Long)
*Skip forward or backward by a period of time.  
 To skip backwards specify a negative delta.  
 Param: delta - time period, in milliseconds*- **SkipPosition** (delta As Float)
*Skip forward or backward by a change in position.  
 To skip backwards specify a negative delta.  
 Param: delta - amount to skip*- **Stop**
*Stops playing media*- **StreamCam** (localip As String, filename As String, port As Int, DegreeRotate As Int)
- **StreamDesktop** (localip As String, filename As String, port As Int)
- **Unmute** (VolumeLevel As Int)
*Unmutes volume*
- **Properties:**

- **Version** As Double [read only]
- **VideoHeight** As Double [read only]
*Returns Video Height*- **VideoWidth** As Double [read only]
*Returns Video Width*
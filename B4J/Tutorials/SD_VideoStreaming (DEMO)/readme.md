### SD_VideoStreaming (DEMO) by Star-Dust
### 02/23/2023
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/146285/)

This library is a rework of the SD\_Streaming library which is itself based on a source from [USER=2353]@moster67[/USER].  
You must also download [**SD\_Streaming**](https://www.b4x.com/android/forum/threads/sd_streamingdemo.146306/) from here with all its dependencies to work.  
  
***NOTE***  
To the SD\_Streaming library it adds a few functions to make some methods simple. In particular, it is ***not necessary to create an fxml file*** for the player in case you want to use it to receive a stream. The fxml file is generated automatically when you dock the viewer to a ponel.  
This version is demo only and the streaming time is limited to 120 seconds. It will take a few seconds before the stream is sent because it needs to create enough cache.  
  
**SD\_VideoStreamingDEMO  
  
Author:** Star-Dust  
**Version:** 1.05  

- **SD\_VideoStream**

- **Events:**

- **ChangeState** (state As Int)
- **Error**
- **Prepared**
- **ReadyToPlay**
- **ReadyToSend**
- **SpeedRateChange** (Success As Boolean)

- **Functions:**

- **CanPause** As Boolean
- **Class\_Globals** As String
- **GetAspectRatio** As String
- **getDurate** As Long
 *millisecond*- **getPlayRate** As Float
- **getPosition** As Float
*current play position: 0.0-1.0*- **getTime** As Long
*current play time*- **getVolume** As Int
 *Volume = 0-200*- **getZoom** As Float
- **Initialize** (CallBack As Object, EventName As String) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **IsPlayable** As Boolean
- **IsPlaying** As Boolean
- **Mute** As String
- **Pause** As String
- **Play** (source As String)
 *Play("rtsp://192.168.1.1:8554/test.mp4")*- **Player** As JavaObject
 *return Player Object*- **PlayExtra** (Options As String(), Source As String) As String
- **Release** As String
 *release resource*- **SaveCam** (filename As String, DegreeRotate As Int) As String
- **SaveDesktop** (Savefilename As String) As String
 *file .flv*- **SaveDesktopPrimary** (Savefilename As String) As String
 *file .flv*- **SaveDesktopRect** (Savefilename As String, Left As Int, Top As Int, Width As Int, Height As Int) As String
- **setPlaySpeedRate** (speedRate As Float) As String
 *Raise event SpeedRateChange*- **SetPosition** (position As Float) As String
- **setRepeat** (Repeat As Boolean) As String
- **setTime** (time As Long) As String
- **setVolume** (Volume As Int) As String
- **setZoom** (factor As Float) As String
 *0 for adapter;*- **Skip** (delta As Long) As String
 *Slip position time long*- **SkipPosition** (delta As Float) As String
 *Slip position float 0-1*- **Stop** As String
- **StreamCam** (LocalIP As String, Port As Int, DegreeRotate As Int, external\_FileNameMp4 As String) As String
 *StreamCam("192.168.1.100","test.mpa",8554,0) or StreamCam("192.168.1.100","test.mpa",8554,180)  
 for Play: Play("rtsp://192.168.1.1:8554/test.mp4")*- **StreamDesktop** (LocalIP As String, Port As Int, external\_FileNameMp4 As String) As String
- **StreamDesktopPrimary** (LocalIP As String, Port As Int, external\_FileNameMp4 As String) As String
- **StreamDesktopRect** (LocalIP As String, Port As Int, external\_FileNameMp4 As String, Left As Int, Top As Int, Width As Int, Height As Int) As String
- **StreamFile** (LocalFileVideo As String, LocalIP As String, Port As Int, external\_FileNameMp4 As String) As String
- **unMute** (VolumeLevel As Int) As String
 *Volume: 0-200*- **VideoHeight** As Double
- **VideoWidth** As Double

- **Properties:**

- **Durate** As Long [read only]
 *millisecond*- **PlayRate** As Float [read only]
- **PlaySpeedRate**
 *Raise event SpeedRateChange*- **Repeat**
- **Time** As Long
*current play time*- **Volume** As Int
 *Volume = 0-200*- **Zoom** As Float
 *0 for adapter;*
- **StreamSetup**

- **Functions:**

- **HookPlayer** (pNode As Node, VideoPlay As JavaObject) As String
- **LoadLayoput** (base As Pane, pNodeName As String, PakageName As String) As Node
- **Process\_Globals** As String
- **VlcInstalled** As Boolean
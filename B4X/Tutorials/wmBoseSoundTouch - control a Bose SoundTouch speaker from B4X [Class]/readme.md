### wmBoseSoundTouch - control a Bose SoundTouch speaker from B4X [Class] by walt61
### 07/23/2024
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/162205/)

The title says it all; tested with a Bose SoundTouch 20. The API info on which this class is based can be found at <https://firstandsecondhomes.com/assets/uploads/SoundTouchAPI_WebServices_v1.1.0.pdf>.  
  
**Public methods:**  
- Initialize: Initializes the object  
  
- GetBass: Retrieves information about the device's bass settings  
- GetBassCapabilities: Retrieves information about the device's bass capabilities  
- GetInfo: Retrieves device hardware and software information  
- GetNowPlaying: Retrieves information about what's currently playing on the device  
- GetPresets: Retrieves information about the 6 presets  
- GetSources: Retrieves information about the device's available content sources  
- GetVolume: Retrieves information about the device's volume settings  
  
- KeyPress: Programmatically executes a keypress (and, optionally, the key release) on the device; the name of the key is passed to this method  
- KeyRelease: Programmatically executes a key release on the device  
- Mute: Mutes the device if it is unmuted  
- PowerOff: Powers the device off if it is on  
- PowerOn: Powers the device on if it is off  
- SelectAux: Selects the device's AUX source if available  
- SelectBluetooth: Selects the device's Bluetooth source if available  
- SetBass: Sets the device's bass setting. This may or may not be a supported capability, use GetBassCapabilities to find out whether the speaker supports bass configuration.  
- SetName: Sets the device's name  
- SetVolume: Sets the device's volume  
- Unmute: Unmutes the device if it is muted  
  
**B4A-specific note:** you may need to edit the Manifest (see example project).  
  
**Library dependencies:**  
- B4J: jOkHttpUtils2, Xml2Map  
- B4A: OkHttpUtils2, Xml2Map  
  
B4A and B4J demo projects attached.  
  
Enjoy!  
  
**EDIT:**  
- 2024-07-23: added public methods Mute and Unmute  
  
![](https://www.b4x.com/android/forum/attachments/155596)
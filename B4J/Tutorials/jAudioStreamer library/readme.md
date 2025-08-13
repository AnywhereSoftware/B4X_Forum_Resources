### jAudioStreamer library by yo3ggx
### 02/12/2023
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/146107/)

Hello,  
  
This is my tentative to build an AudioStreamer library for B4J, fully user configurable.  
I'm not a Java developer, so please excuse me if something is not implemented using best practices.  
Was build for my own use, but may be helpful for others too.  
  
You can find attached a sample code in B4J that allows you to test different parameters.  
A loopback is created emulating network latency and jitter (using localhost).  
Was tested on Windows , Linux, Raspberry Pi OS and Chromebook (Linux subsystem). The screenshot below is from a Chromebook, using an USB headset.  
  
![](https://www.b4x.com/android/forum/attachments/139216)  
  
The library is pretty straight forward, similar with the one for B4A, but highly customizable.  
  
**[SIZE=6]Classes[/SIZE]  
  
[SIZE=5]aDevice[/SIZE]**  

- **Fields**

- **devID** - audio device ID
- **lineID -** line ID for the current device
- **devName -** audio device name
- **devDescription** - audio device description

**[SIZE=5]AudioStreamer[/SIZE]**  

- **Functions**

- **Initialize**(EventName as String, recID as Int, playID as int, samplerate as int, bits as int, chans as int, recbufsize as int, playbufsize as int)

- **EventName** - EventName
- **recID** - recording device id
- **playID** - playback device id
- **samplerate** - in Hz
- **bits** - number of bits per sample (8 or 16)
- **chans** - number of channels, 1 for mono, 2 for stereo
- **recbufsize** - Line In buffer size. If 0 is used, then an automatic value is used
- **playbufsize** - Line Out buffer size. If 0 is used, then an automatic value is used (usually = samplerate)
- **return** true if AudioStreamer was successfully initialized

- **clearQueue** - clear playback queue
- **flushPlayer** - flush player buffer
- **flushRecorder** - flush recorder buffer
- **IsInitialized** - check if AudioStreamer is initialized. Return true if initialized, false otherwise
- **isPlayerAvailable** - return true if Player thread is active
- **isRecorderAvailable** - return true if Recorder thread is active
- **muteLineOut** - if true, Line Out is muted.
- **PlaybackDevices** - return a list of aDevice audio output devices (see aDevice class)
- **RecordingDevices** - return a list of aDevice audio input devices (see aDevice class)
- **startPlayer** - start Player thread.
- **startRecorder** - start Recorder thread
- **stopPlayer** - stop Player thread
- **stopRecorder** - stop Recorder thread
- **writeData(**buffer() as byte**)** - put a byte array to the player queue
- **validateIP(IP as string)** - return true if the string represent a valid IP v4 address.
- **AllLocalIPs** - return a list containing all locally available IP v4 addresses.

- **Public variables**

- **LineInBufferSize** - (read only), currently used Line In buffer size. Can be set through Initialize. Value can be different from the one in Initialize, because there is a maximum possible value. If you set it bigger than the maximum allowed, maximum allowed is used.
- **LineOutBufferSize** - (read only), currently used Line Out buffer size. Can be set through Initialize. Value can be different from the one in Initialize, because there is a maximum possible value. If you set it bigger than the maximum allowed, maximum allowed is used.
- **RecorderBufferSize** - (read/write), the size of the read buffer (how many bytes are read at once). This can be useful if you want to encode the audio stream and need a specific length.
- **VolumePlayer** - (write only) set the attenuator for playback (0-100, 0 = -80dB, 100=0dB)
- **VolumeRecorder** - (write only) set the attenuator for recorder (0-100, 0 = -80dB, 100=0dB), most of the audio input devices does not support this.
- **queueLength** - (read only), return the playback queue length

  
I am open to any suggestions or observations.  
   
**Current version: 1.0  
Attached files:  
jAudioStreamerLibrary.zip** - the library (jar and xml files)  
**jAudioStreamerExample.zip** - a sample application (see picture above)
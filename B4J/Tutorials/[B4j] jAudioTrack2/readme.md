### [B4j] jAudioTrack2 by stevel05
### 10/24/2023
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/142197/)

This is an new version of the jAudioTrack library (but not a direct plugin replacement) provided as a b4xlib and uses current B4x practices and classes.  
  
It allows selecting the audio output. It also includes the Clip class which allows control over the playback position and looping.  
  

![](https://www.b4x.com/android/forum/attachments/132171) ![](https://www.b4x.com/android/forum/attachments/132172)

  
  
The library no longer relies on the threading library.  
  
There are 3 demo projects.  

- jAudioTrack-Demo

- provides the same functionality as the original jAudioTrack library i.e. Plays a file or URL to the selected device and reads the correct audioformat from the stream.

- jAudioTrack2-ClipDemo

- Plays a file or URL using the Clip class, which allows control over the play position. Supported File size may be limited s it reads the whole file into memory.

- jAudioRecAndPlay

- Demonstrates recording and playing in one app (Requires the [jAudioRecord2](https://www.b4x.com/android/forum/threads/b4j-jaudiorecord2.142154/) library)

  
**B4xlib**  
The jAudioTrack2 b4xlib contains the code and some necessary utilities. Feel free to unzip and inspect or change it as you wish.  
  
**Dependencies**  
There are no external dependencies.  
  
**Comments**  
There are as many device configurations as there are PC's. It does work with mine and I have an external sound card as well as an internal sound card, Whether java supports all devices will remain to be seen.  
  
Only PCM samples are supported, MP3 or flac or other compressed files are not supported.  
  
Please try it and let me know how you get on and report any issues.  
  
**Update to V0.11**  

- Added NewAudioInputStreamFromBytes to jAudioTrack2\_Utils to play from bytes array.
- Added new demo app jAudioRecAndPlay (Requires [jAudioRecord2](https://www.b4x.com/android/forum/threads/b4j-jaudiorecord2.142154/) library)

**Update to V0.12**  

- Added WavRandomAccessFile (More information to follow)
- Added ConvertMillisecondsToString to jAudiotrack2\_Utils

**Update to V0.13**  

- Updated WavRandomAccessFile to access LIST data chunks within the Wav file. Useful for getting the List Info chunk if there is one. (see the demo in [B4xWavRandomAccessFile](https://www.b4x.com/android/forum/threads/b4x-wavrandomaccessfile.142792/) for use)

**Update to V 0.14 - 2023-Oct-14**  

- WavRandomaccessFile

- Added several convienience functions to read data in various formats
- Made WavHeaderChunkMap available after initialization
- Removed references to jfx for non-ui use
- Added non-ui example
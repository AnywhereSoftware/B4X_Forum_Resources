###  Music Tracker Box (xm, s3m, mod) by mazezone
### 04/05/2023
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/147265/)

[SIZE=5]**Music player libraries for MOD, S3M and XM formats.**[/SIZE]  
[SIZE=4]***Support: B4A and B4J.***  
  
*Demo b4a and b4j:*[/SIZE]  
  
![](https://www.b4x.com/android/forum/attachments/140975)![](https://www.b4x.com/android/forum/attachments/140976)  
  
**TrackerBox**  

- **Initialize**
Initialization- **LoadModule** (SampleRate As Int, Dir As String, FileName As String)
*Loading a module into memory  
 SampleRate: 8000 Hz to 128000 Hz*- **ReadyModule** As Boolean [read only]
*Module loaded into memory*- **I\_NEAREST** As Int [read only]
*Constant: No interpolation (value: 0)*- **I\_LINEAR** As Int [read only]
*Constant: Linear interpolation (value: 1)*- **I\_SINC** As Int [read only]
*Constant: Sinc interpolation (value: 2)*- **Interpolation** As Int
*Set the resampling quality to one of I\_NEAREST, I\_LINEAR (default), I\_SINC  
 Return the current resampling quality setting.*- **MixBufferLength** As Int [read only]
*Returns the length of the buffer required by Audio().*- **Audio** (outputBuf() As Int) As Int
*Generate audio.  
 The number of samples placed into outputBuf is returned.  
 The output buffer length must be at least that returned by MixBufferLength().  
 A "sample" is a pair of 16-bit integer amplitudes, one for each of the stereo channels.*- **SongName** As String [read only]
*Return the name of the module*- **SequenceLength** As Int [read only]
*Return the sequence length of the module*- **NumChannels** As Int [read only]
*Return the number of channels of the module*- **SampleRatePlayback** As Int
*Set the sampling rate of playback. This can be used with SampleRate to adjust the tempo and pitch.   
 Return the sampling rate of playback.*- **Muted** (channel As Int, mute As Boolean)
*Mute or unmute the specified channel. If channel is negative, mute or unmute all channels.*- **Row** As Int [read only]
*Get the current row position.*- **NextRow** As Int [read only]
*Get the next row position.*- **BreakSeqPos** As Int [read only]
*Get the break sequence position.*- **SequencePos** As Int
*Set the pattern in the sequence to play. The tempo is reset to the default.  
 Get the current pattern position in the sequence.*- **CalculateSongDuration** As Int [read only]
*Returns the song duration in samples at the current sampling rate.*- **Seek** (samplePos As Int) As Int
*Seek to approximately the specified sample position.  
 The actual sample position reached is returned.*- **SeekSequencePos** (sequencePos As Int, sequenceRow As Int)
*Seek to the specified position and row in the sequence.*- **SequencerEnabled** As Boolean
*Enable or disable the sequencer.  
 Return true if the sequencer is enabled.*- **AudioOpen** (SampleRate As Int)
*Opening a cross-platform\* device for audio playback*- **AudioClose**
*Closing a cross-platform\* device for audio playback*- **AudioReady** As Boolean [read only]
*State AudioWrite. True - busy*- **AudioWrite** (Buf() As Byte, Offset As Int, Size As Int)
*Sample Playback (cross-platform\*). Asynchronous function. Control with AudioReady*- **AudioWrite2** (Buf() As Byte, Offset As Int, Size As Int)
*Sample Playback (cross-platform\*). Synchronous function*
[INDENT=2]cross-platform\*: For Android: android.media.AudioTrack, for PC: javax.sound.sampled.AudioSystem[/INDENT]  
  
Liked? ;)  
![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)  
**[FONT=verdana][SIZE=4]**PayPal:** [/SIZE][/FONT]**[FONT=verdana][SIZE=4][EMAIL]zonemaze@gmail.com[/EMAIL][/SIZE][/FONT]  
**[FONT=verdana][SIZE=4]**Webmoney:** [/SIZE][/FONT]**[FONT=verdana][SIZE=4]Z247137597440[/SIZE][/FONT]
### Audio Ringbuffer by Midimaster
### 09/26/2020
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/122761/)

if you want to build instant music in apps from single sounds, it is important that the samples are absolutely synchron and perfect in timing. So you should send one single stream to the system where all the sounds and instruments and effects are already placed.  
  
Here I demonstrate how to combine sounds to a stream in a ringbuffer. A timer steps through this ringbuffer and sends the current chunk to the AudioStreamer to feed it just in time in the very last moment.  
  
the code in the STARTER module is very short and only tranfers the samples to the AudioStreamer:  

```B4X
Sub Process_Globals  
    Public AudioOut As AudioStreamer  
End Sub  
  
Sub Service_Start (StartingIntent As Intent)  
    AudioOut.Initialize("AudioOut",24000,True,16,AudioOut.VOLUME_MUSIC)  
    AudioOut.StartPlaying  
End Sub  
  
Sub Service_Destroy  
    AudioOut.StopPlaying  
End Sub  
  
public Sub SendToAudio(Bytes() As Byte)  
    AudioOut.Write(Bytes)  
End Sub  
  
Sub Restart(Hertz As Int)  
    AudioOut.StopPlaying  
    AudioOut.Initialize("AudioOut",Hertz,True,16,AudioOut.VOLUME_MUSIC)  
    AudioOut.StartPlaying  
End Sub
```

  
  
**The AudioRingBuffer-Module**  
  

```B4X
Sub Process_Globals  
    Private Converter As ByteConverter  
    Private Interval, BufferSize, Hertz, ChunkSize, ReadPoint, LastNow As Int  
    Private StartTime As Long  
    Private RingBuffer(Hertz*BufferSize) As Short ' where to combine all samples  
End Sub
```

  
We need Short-Arrays to combine the samples and the ByteConverter to bring it in the format for the AudioStreamer  
  
  
A timer in MAIN will call every 20msec the function SendAudio() to feed the AudioStreamer:  

```B4X
Sub SendAudio  
    Dim RingChunk(ChunkSize) As Short  
    Dim Now As Long=DateTime.Now-StartTime  
    Do While Now>LastNow  
        'copy samples from ringbuffer to temp. buffer  
        For i=0 To ChunkSize-1  
            RingChunk(i)=RingBuffer(ReadPoint+i)  
            RingBuffer(ReadPoint+i)=0  
        Next  
      
        ' forward the read point and time  
        ReadPoint=(ReadPoint + ChunkSize) Mod RingBuffer.Length  
        LastNow=LastNow+Interval  
      
        'convert ringbuffer audio and send it  
        Converter.LittleEndian=True  
        Private AudioOutBytes() As Byte =Converter.ShortsToBytes(RingChunk)  
        Starter.SendToAudio(AudioOutBytes)  
    Loop  
End Sub
```

  
This will send a 20msec-chunk (=480 shorts = 960bytes) to the AudioStreamer and if necessary a second one. Because the Timer() is not exact enough, we need to calculate the time from DateTime.Now()  
  
The sending consists of three steps: first step is fetching the chunk from the RingBuffer. Second step is calculating the starting points for the next call of SendAudio(). Last Step is converting the chunk into bytes and sending it to the AudioStreamer.  
  
Tricky: It is important that the Ringbuffer-Size is a multiple of the Chunk size. So I do not have to care about array limits during the FOR/NEXT-loop! This makes the transfer faster. As long as you use a multiple of 1000 for the sample rate, f.e. 24000 you can select any value for the interval that calls the SendAudio() from 1msec to 100msec. 1msec of interval means a chunk size of 24 shorts sended to the audioStreamer each time. 10msec means 240 shorts, etc…  
To prevent a break of the audio stream you need a latency buffer. This means at the beginning you send more than one chunk to the AudioStreamer. In this sample I take 4 chunks. This is realized by setting the reading point to zero, but setting the time to minus 4 times of the interval. This has the effect, that the SendAudio() will send 4 chunks at the beginning at once:  

```B4X
Public Sub ReStartRingBuffer  
    StartTime=DateTime.Now  
    ReadPoint=0  
    ' this brings additional latency buffer  
    LastNow=-4*Interval  
  
    ' clear the ringbuffer array  
    Dim EmptyBuffer(Hertz*BufferSize) As Short  
    RingBuffer=EmptyBuffer  
End Sub
```

  
  
  
The second important function JoinSamples() is for bringing your sounds into the RingBuffer:  

```B4X
Sub JoinSample(Sample() As Short, Time As Int, Volume As Float)  
  
    ' calculate ring buffer write position  
    Time =Time Mod (BufferSize*1000)  
    Dim WritePoint As Int=Time*Hertz/1000  
    Dim RealWritePos As Int  
  
    ' add sample to the ringbuffer  
    For i = 0 To Sample.Length-1  
        RealWritePos=(WritePoint+i) Mod RingBuffer.Length  
        RingBuffer(RealWritePos)=RingBuffer(RealWritePos) + Sample(i)*Volume  
    Next  
End Sub
```

  
It is called from your main code and transfers a Sound as a Short-Array. The Time variable tells (in msec) when the sound should be played or say "where the sound should be placed in the ringbuffer". The time is divided by the maximum length of the ring buffer. BufferSize is the size of the Ringbuffer in sec. WritePoint is the physical position in the buffer related to the time position.  
  
In the second part all samples of the sound are added to the ringbuffer. The formula is a simple Addition of existing buffer value plus the sample. As you see you can simply add a "volume"-factor (0.0 to1.0) now to adjust the volume of the sound. You have to care about overrun. So you need a RealWritePosition to always stay in the buffer's range.  
  
This code is not optimized to speed, but optimized to teach the algorithm. And the final code needs a lot more code lines to prevent crashes, etc…  
  
I link a ZIP-file with the complete AudioRingBuffer module and a calling MAIN-module and it also contains some test-sounds. This example is completely executable and you can play around with it. You will first hear a Drum-loop, then a piano joins, and then audience will give applause.  
  
553kByte:  
<http://www.midimaster.de/temp/realtimeaudio.zip>  
  
This are the complete modules:  
**The AudioRingBuffer-Module**  

```B4X
Sub Process_Globals  
    Private Converter As ByteConverter  
    Private Interval, BufferSize, Hertz, ChunkSize, ReadPoint, LastNow As Int  
    Private StartTime As Long  
    Private RingBuffer(Hertz*BufferSize) As Short ' where to combine all samples  
End Sub  
  
  
Sub SendAudio  
    Dim RingChunk(ChunkSize) As Short  
    Dim Now As Long=DateTime.Now-StartTime  
    Do While Now>LastNow  
        'copy samples from ringbuffer to temp. buffer  
        For i=0 To ChunkSize-1  
            RingChunk(i)=RingBuffer(ReadPoint+i)  
            RingBuffer(ReadPoint+i)=0  
        Next  
       
        ' forward the read point and time  
        ReadPoint=(ReadPoint + ChunkSize) Mod RingBuffer.Length  
        LastNow=LastNow+Interval  
       
        'convert ringbuffer audio and send it  
        Converter.LittleEndian=True  
        Private AudioOutBytes() As Byte =Converter.ShortsToBytes(RingChunk)  
        Starter.SendToAudio(AudioOutBytes)  
    Loop  
End Sub  
  
  
public Sub FirstStart(NewInterval As Int, NewBufferSize As Int, NewHertz As Int)  
    If Main.AudioTimer.IsInitialized=True Then Return  
      Interval = NewInterval   ' how often will be transfered  
    BufferSize = NewBufferSize ' buffer is big enough for x sec of audio  
         Hertz = NewHertz      ' audio files sample rate  
     ChunkSize = Hertz/1000*Interval ' Samples per Interval to transfer  
  
    ReStartRingBuffer  
    If (RingBuffer.Length Mod ChunkSize) <> 0 Then  
        Log("ringbuffer's size must be: (N * chunksize) !!!")  
        ExitApplication  
    End If  
    Starter.Restart(Hertz)  
End Sub  
  
  
Public Sub ReStartRingBuffer  
    StartTime=DateTime.Now  
    ReadPoint=0  
    ' this brings additional latency buffer  
    LastNow=-4*Interval  
  
    ' clear the ringbuffer array  
    Dim EmptyBuffer(Hertz*BufferSize) As Short  
    RingBuffer=EmptyBuffer  
End Sub  
  
Sub JoinSample(Sample() As Short, Time As Int, Volume As Float)  
   
    Dim Now As Long=DateTime.Now-StartTime  
    Dim MaxLength As Int=BufferSize*Hertz-2*ChunkSize  
   
    ' sample is to big:  
    If Sample.Length>MaxLength Then Return  
   
    ' sample starts to much in future:  
    If (Sample.Length/Hertz*1000+Time-Now) > MaxLength Then Return  
  
    'sample is already delayed, send it immediately  
    If Time<Now+2*Interval Then  
        Log("to late")  
        Time=Now+2*Interval  
    End If  
  
    ' calculate ring buffer write position  
    Time =Time Mod (BufferSize*1000)  
    Dim WritePoint As Int=Time*Hertz/1000  
    Dim RealWritePos As Int  
  
    ' add sample to the ringbuffer  
    For i = 0 To Sample.Length-1  
        RealWritePos=(WritePoint+i) Mod RingBuffer.Length  
        RingBuffer(RealWritePos)=RingBuffer(RealWritePos) + Sample(i)*Volume  
    Next  
End Sub
```

  
  
****The Main-Module****  

```B4X
#Region  Project Attributes  
    #ApplicationLabel: B4A Example  
    #VersionCode: 1  
    #VersionName:  
    'SupportedOrientations possible values: unspecified, landscape or portrait.  
    #SupportedOrientations: unspecified  
    #CanInstallToExternalStorage: False  
#End Region  
  
#Region  Activity Attributes  
    #FullScreen: False  
    #IncludeTitle: True  
#End Region  
#BridgeLogger:true  
#ApplicationLabel: Ringbuffer TEMP  
  
Sub Process_Globals  
    Type SoundTyp(Sample() As Short )  
    Type MusicEventTyp(SoundNr, Intervall, NextTime As Int, Volume As Float)  
  
    Private Converter As ByteConverter  
    Public PlayTimer, AudioTimer As Timer  
    Private StartTime As Long  
    Private SoundTime As Int  
  
    Private Music As List 'MusicEventTyp  
    Private Sound(7) As SoundTyp  
End Sub  
  
Sub Globals  
    Private Button1 As Button  
  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("Layout")  
    AudioRingBuffer.FirstStart(20, 8, 24000)  ' feed audio every 20msec, 8sec ring-buffer, 24kHz sampling rate  
    AudioTimer.Initialize("AudioTimer",100)  
    PlayTimer.Initialize("PlayTimer",50)  
    StartTime=DateTime.Now  
    DefineMusic  
End Sub  
  
Sub Activity_Resume  
    AudioRingBuffer.ReStartRingBuffer  
    PlayTimer.Enabled=True  
    AudioTimer.Enabled=True  
End Sub  
  
Sub Button1_Click  
    PlayTimer.Enabled=False  
    AudioTimer.Enabled=False  
    ExitApplication  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
    PlayTimer.Enabled=False  
    AudioTimer.Enabled=False  
End Sub  
  
Sub AudioTimer_Tick  
    AudioRingBuffer.SendAudio  
End Sub  
  
Sub LoadAudioSample(FileName As String) As Short()  
    Dim WAV As RandomAccessFile  
    File.Copy(File.DirAssets,FileName,File.DirInternal,FileName)  
    Dim Size As Int= File.Size(File.DirInternal, FileName)-44  
    Dim ByteBuffer(Size) As Byte  
    WAV.Initialize(File.DirInternal, FileName,True)  
    WAV.ReadBytes(ByteBuffer,0,Size,44)  
    WAV.Close  
    Converter.LittleEndian=True  
    Dim ShortBuffer() As Short=Converter.ShortsFromBytes(ByteBuffer)  
    Return ShortBuffer  
End Sub  
  
Sub PlayTimer_Tick  
    Dim now As Long = DateTime.Now-StartTime ' latency  
   
    For Each loc As MusicEventTyp In Music  
        If loc.NextTime<now+1000 Then  
            AudioRingBuffer.JoinSample(Sound(loc.SoundNr).Sample, loc.NextTime,  loc.volume )  
            loc.NextTime= loc.NextTime + loc.Intervall  
        End If  
    Next  
  
End Sub  
  
Sub DefineMusic  
    Sound(0).sample=LoadAudioSample("Piano0.wav")  
    Sound(1).sample=LoadAudioSample("Piano4.wav")  
    Sound(2).sample=LoadAudioSample("Piano7.wav")  
    Sound(3).sample=LoadAudioSample("BassDrum.wav")  
    Sound(4).sample=LoadAudioSample("SnareDrum.wav")  
    Sound(5).sample=LoadAudioSample("Applaus.wav")  
    Sound(6).sample=LoadAudioSample("Piano-7.wav")  
    Music.Initialize  
    'piano  
    Init(0,3000,2000,0.9)  
    Init(6,4000,2000,0.9)  
    Init(1,3500,1000,0.5)  
    Init(2,3500,1000,0.6)  
    Init(1,3833,1000,0.4)  
    Init(2,3833,1000,0.3)  
    'drums  
    Init(3,1000,1000,0.9)  
    Init(4,1500,1000,0.6)  
    Init(3,1833,2000,0.6)  
    Init(4,1830,2000,0.3)  
    'noise  
    Init(5,7000,3210,0.4)  
End Sub  
  
Sub Init(Nr As Int, Start As Int, Interval As Int, Volume As Float) As MusicEventTyp  
    Dim loc As MusicEventTyp  
    loc.Initialize  
    loc.SoundNr=Nr  
    loc.NextTime=Start  
    loc.Intervall=Interval  
    loc.volume=Volume  
    Music.Add(loc)  
End Sub
```

  
  
******The Starter-Module******  

```B4X
#Region  Service Attributes  
    #StartAtBoot: False  
    #ExcludeFromLibrary: True  
#End Region  
  
Sub Process_Globals  
    Public AudioOut As AudioStreamer  
End Sub  
  
Sub Service_Create  
    'This is the program entry point.  
    'This is a good place to load resources that are not specific to a single activity.  
  
End Sub  
  
Sub Service_Start (StartingIntent As Intent)  
    Service.StopAutomaticForeground 'Starter service can start in the foreground state in some edge cases.  
    AudioOut.Initialize("AudioOut",24000,True,16,AudioOut.VOLUME_MUSIC)  
    AudioOut.StartPlaying  
End Sub  
  
Sub Service_TaskRemoved  
    'This event will be raised when the user removes the app from the recent apps list.  
End Sub  
Sub Application_Error (Error As Exception, StackTrace As String) As Boolean  
    Return True  
End Sub  
  
Sub Service_Destroy  
    AudioOut.StopPlaying  
End Sub  
  
  
public Sub SendToAudio(Bytes() As Byte)  
    AudioOut.Write(Bytes)  
End Sub  
  
  
Sub Restart(Hertz As Int)  
    AudioOut.StopPlaying  
    AudioOut.Initialize("AudioOut",Hertz,True,16,AudioOut.VOLUME_MUSIC)  
    AudioOut.StartPlaying  
End Sub
```
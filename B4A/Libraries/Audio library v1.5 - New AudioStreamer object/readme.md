### Audio library v1.5 - New AudioStreamer object by Erel
### 11/10/2023
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/30550/)

This version includes a new AudioStreamer type. Note that this is a beta version (for this type only).  
  
The purpose of AudioStreamer is to make it simple to stream audio from the microphone and to the speakers. Internally it is based on AudioTrack and AudioRecord.  
  
Next week I plan to create an example of streaming audio between two devices (walkie-talkie app).  
  
Recording is done by calling StartRecording. The RecordBuffer event will be raised multiple times during the recording:  

```B4X
Sub streamer_RecordBuffer (Buffer() As Byte)  
   'collect the recording data  
   buffers.Add(Buffer)  
End Sub
```

  
You can write this data to a file or as done in this example, collect the buffers in a list. Later we will use this list to play the recording:  

```B4X
Sub btnPlay_Click  
   btnStartRecording.Enabled = False  
   streamer.StartPlaying  
   For Each b() As Byte In buffers  
      streamer.Write(b)  
   Next  
   streamer.Write(Null) 'when this "message" will be processed, the player will stop.  
End Sub
```

  
Note that the player has an internal queue. The write method will not block the main thread. The data is just added to the queue. It is processed by another thread.  
  
![](http://www.b4x.com/basic4android/images/SS-2013-06-26_17.07.34.png)
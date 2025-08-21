### Timer not exact enough for sending to stream by Midimaster
### 06/28/2020
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/119547/)

Maybe the code is trivial, but I searched a long time in my code until I found the bug, why my stream always drops out. So maybe this will help somebody.  
  
The Timer() is not that exact as you expect. This is not important as long as you do not calculate with this.  
but…  

```B4X
Sub Process_Globals  
    Public Timer1 As Timer  
…  
  
Sub Activity_Create(FirstTime As Boolean)  
    If FirstTime=True Then  
        Timer1.Initialize("Timer1",100)  
        Timer1.Enabled=True  
    End If  
…  
  
Sub Timer1_Tick  
    If (SongPosition=0) Then  
        SendAudioSamples (2205)  
    End If  
    SendAudioSamples (2205)  
End Sub
```

  
This code sends 10 times a second 2205 Bytes to the AudioStreamer() to keep an audiostream (22050Hz) alive. In the start moment I send the packet twice to have a little "buffer" for contingencies. I first thought this would be enough preventon. But after 20sec you can hear drop-outs and crackling, after 40sec it becomes stronger.  
  
The reason is, because I trusted in the Timer() exactness. But a tick between two calls can last from 99msec to 102msec (avarage=100.3msec)  
  
So you have to care about that. Better you correct the variability with DateTime():  

```B4X
Sub Process_Globals  
    Public Timer1 As Timer  
    Private TicksCount As Long  
…  
  
Sub Activity_Create(FirstTime As Boolean)  
    If FirstTime=True Then  
        Timer1.Initialize("Timer1",100)  
        Timer1.Enabled=True  
    End If  
…  
  
Sub Timer1_Tick  
    If (SongPosition=0) Then  
        SendAudioSamples (2205)  
        TicksCount=DateTime.now-100  
    End If  
    Dim TicksDiff As Long=DateTime.now-TicksCount-100  
    Dim SendCount As Int=2205  
    Log ("ticks-diff" & TicksDiff )  
    If TicksDiff>0 Then  
        TicksCount=TicksCount+101  
        SendCount=2205+22  
    Else  
        TicksCount=TicksCount+100  
    End If  
    SendAudioSamples (SendCount)  
End Sub
```
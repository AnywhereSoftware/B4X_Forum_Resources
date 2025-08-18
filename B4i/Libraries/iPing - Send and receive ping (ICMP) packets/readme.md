### iPing - Send and receive ping (ICMP) packets by Erel
### 07/11/2021
[B4X Forum - B4i - Libraries](https://www.b4x.com/android/forum/threads/132440/)

This library wraps Apple's code: <https://developer.apple.com/library/archive/samplecode/SimplePing/Introduction/Intro.html>  
  
Usage example:  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
    Private Pinger As SimplePing  
End Sub  
  
Public Sub Initialize  
End Sub  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  
    Pinger.Initialize("Pinger", "b4x.com")  
    Pinger.Start  
    Wait For Pinger_Start (Success As Boolean)  
    If Success Then  
        For i = 1 To 5  
            Pinger.Send  
            Wait For Pinger_PacketSent (SequenceNumber As Int, Success As Boolean)  
            Log("sent: " & SequenceNumber & ": " & Success)  
            Sleep(500)  
        Next  
    Else  
        Log("error: " & LastException)  
    End If  
    Pinger.Stop  
End Sub  
  
Private Sub Pinger_PacketReceived (SequenceNumber As Int)  
    Log("Received: " & SequenceNumber)  
End Sub
```
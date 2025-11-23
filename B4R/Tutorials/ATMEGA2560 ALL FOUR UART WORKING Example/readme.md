### ATMEGA2560 ALL FOUR UART WORKING Example by embedded
### 11/21/2025
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/169389/)

```B4X
#Region Project Attributes  
    #AutoFlushLogs: True  
    #CheckArrayBounds: True  
    #StackBufferSize: 2000  
#End Region  
'Ctrl+Click to open the C code folder: ide://run?File=%WINDIR%\System32\explorer.exe&Args=%PROJECT%\Objects\Src  
'JUST CONNECT THE TX3-RX3,TX2-RX2,TX1-RX-1, You see logs UART-1,UART-2,UART-3   
Sub Process_Globals  
    Public Serial As Serial  
    Public SerialNative1 As Stream  
    Private SerialNative2 As Stream  
    Private SerialNative3 As Stream  
    Public Timer1 As Timer  
    Public astream As AsyncStreams  
    Public ledPin As Pin  
End Sub  
  
'tested working-20/11/2025  
Private Sub AppStart  
    Serial.Initialize(115200)  
    Log("AppStart")  
     
    'example of connecting to a local network  
    ledPin.Initialize(26,ledPin.MODE_OUTPUT)  
    ledPin.DigitalWrite(False)  
     
    Timer1.Initialize("Timer1_Tick",2000)  
    Timer1.Enabled=True  
    astream.Initialize(Serial.Stream,"astream_Newdata","astream_Error")  
    astream.MaxBufferSize=512  
    astream.WaitForMoreDataDelay=100  
    Delay(2000)  
    RunNative("SerialNative1",Null)  
    RunNative("SerialNative2",Null)  
    RunNative("SerialNative3",Null)  
End Sub  
  
Sub Timer1_Tick  
    ledPin.DigitalWrite(Not(ledPin.DigitalRead))  
    Log("TMR RUNNING—-")  
    Read_Serial123_Data  
    ledPin.DigitalWrite(Not(ledPin.DigitalRead))  
    SerialNative2.WriteBytes("UART-2".GetBytes,0,6)  
    SerialNative3.WriteBytes("UART-3".GetBytes,0,6)  
    SerialNative1.WriteBytes("UART-1".GetBytes,0,6)  
     
End Sub  
  
  
  
  
  
Sub Astream_NewData (Buffer() As Byte)  
    Log(Buffer)  
    SerialNative2.WriteBytes(Buffer,0,Buffer.Length)  
End Sub  
  
Sub AStream_Error  
    Log("error")  
End Sub  
  
#if C  
// Second Hardware Port  
void SerialNative1(B4R::Object* unused)  
{  
::Serial1.begin(115200);  
b4r_main::_serialnative1->wrappedStream = &::Serial1;  
}  
  
void SerialNative2(B4R::Object* unused)  
{  
::Serial2.begin(115200);  
b4r_main::_serialnative2->wrappedStream = &::Serial2;  
}  
  
void SerialNative3(B4R::Object* unused)  
{  
::Serial3.begin(115200);  
b4r_main::_serialnative3->wrappedStream = &::Serial3;  
}  
  
  
#End If  
  
Sub Read_Serial123_Data  
    Log("READING UART2—")  
    Dim AvailableByte As Int  
    AvailableByte=SerialNative2.BytesAvailable  
    If AvailableByte>0 Then  
        Dim Buff(AvailableByte) As Byte  
        SerialNative2.ReadBytes(Buff,0,AvailableByte)  
        Log("SERIAL-2=",Buff)  
    End If  
    Log("——————–3————–")  
    Delay(1000)  
    AvailableByte=SerialNative3.BytesAvailable  
    If AvailableByte>0 Then  
        Dim Buff(AvailableByte) As Byte  
        SerialNative3.ReadBytes(Buff,0,AvailableByte)  
        Log("SERIAL-3=",Buff)  
    End If  
    Log("——————–4————–")  
    Delay(1000)  
    'AvailableByte=SerialNative4.BytesAvailable  
    If AvailableByte>0 Then  
        Dim Buff(AvailableByte) As Byte  
        SerialNative1.ReadBytes(Buff,0,AvailableByte)  
        Log("SERIAL-1=",Buff)  
    End If  
    Log("——————–END————–")  
End Sub
```
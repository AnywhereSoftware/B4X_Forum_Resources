### DIY NTP Network Atomic Clock Time by emexes
### 02/25/2024
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/159496/)

I just ported some NTP stuff from an old program.  
  
Querying an NTP server is surprisingly easy: just send it a 48 byte UDP packet with the first byte = 27 and the rest of them 0.  
  
The NTP server should return your 48 byte packet updated with the last 16 bytes set to two 64-bit timestamps, being when it (i) received your request and (ii) soon-after sent its response.  
  
My code "returns" 4 timestamps NTPTimeStamp(1) thru NTPTimeStamp(4), matching T1..T4 of this command-line utility:  
  
<https://kb.meinbergglobal.com/kb/public_utilitiy_programs/ntptest_-_check_ntp_server>  
  
except that my timestamps are in Java ticks (ms since 1970) for easy use with DateTime formatting etc.  
  
I did this example with B4J but the same principles work in B4A (as in: I've run similar code successfully there too).  
  

```B4X
#Region Project Attributes  
    #MainFormWidth: 300  
    #MainFormHeight: 300  
#End Region  
  
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
    Private xui As XUI  
    Private Button1 As B4XView  
  
    Dim UDPSocket1 As UDPSocket  
     
    Dim NTPPort As Int = 123  
    Dim NTP1970 As Long = ((1970 - 1900) * 365 + 17).As(Long) * 86400  
     
    Dim NTPTimeStamp(5) As Double  'to match T1..T4 of Meinberg NTPTEST utility  
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("Layout1")  
    MainForm.Show  
     
    UDPSocket1.Initialize("UDP", NTPPort, 8000)  
End Sub  
  
Sub SendNtpRequest(NTPServerName As String)  
    Dim data(48) As Byte  
    data(0) = 27  
  
    Dim Packet As UDPPacket  
    Packet.Initialize(data, NTPServerName, NTPPort)  
     
    NTPTimeStamp(4) = 0    'so can tell if received reply  
    NTPTimeStamp(1) = DateTime.Now  
    UDPSocket1.Send(Packet)  
End Sub  
  
Sub UDP_PacketArrived (Packet As UDPPacket)  
    If Packet.Length < 48 Then Return  
     
    NTPTimeStamp(4) = DateTime.Now  
  
    Dim StartFrom As Int = Packet.Offset + 32  
    For ServerTimeStamp = 2 To 3  
        Dim Temp As Long = 0  
        For I = StartFrom To StartFrom + 6    '7 bytes (32 bits seconds + 24 bits fraction)  
            Temp = Bit.ShiftLeftLong(Temp, 8) + Bit.And(Packet.Data(I), 0xFF)  
        Next  
         
        Dim NTPSeconds As Double = Temp / 0x1000000    'shift binary point 24 bits left  
        Dim JavaTicks As Double = (NTPSeconds - NTP1970) * 1000  
  
        NTPTimeStamp(ServerTimeStamp) = JavaTicks  
         
        StartFrom = StartFrom + 8    'next 64-bit timestamp  
    Next  
End Sub  
  
Sub Button1_Click  
    Dim NTPServerName As String = "au.pool.ntp.org"  
     
    SendNtpRequest(NTPServerName)  
    Sleep(2000)  
  
    If NTPTimeStamp(4) = 0 Then  
        Log("No reply from " & NTPServerName)  
        Return  
    End If  
         
    Log(NTPServerName)  
    For I = 1 To 4  
        Log("T" & I & " = " & NumberFormat2(NTPTimeStamp(I), 1, 3, 3, False))  
    Next  
     
    Dim LocalTimeMiddle As Double = (NTPTimeStamp(1) + NTPTimeStamp(4)) / 2  
    Dim ServerTimeMiddle As Double= (NTPTimeStamp(2) + NTPTimeStamp(3)) / 2  
    Dim DeviceToNTPOffset As Double = ServerTimeMiddle - LocalTimeMiddle  
     
    If DeviceToNTPOffset < 0 Then  
        Dim Direction As String = "ahead of"  
    Else  
        Dim Direction As String = "behind"  
    End If  
     
    Log( _  
        "Device clock is " & _  
        NumberFormat2(Abs(DeviceToNTPOffset), 1, 1, 1, False) & _  
        " ms " & Direction & " NTP server time (roundtrip " & _  
        NumberFormat2(NTPTimeStamp(4) - NTPTimeStamp(1), 1, 1, 1, False) & _  
        " ms)" _  
    )  
  
    DateTime.TimeFormat = "hh:mm:ss.SSS"  
    Dim N As Long = DateTime.Now  
    Log("Device clock = " & DateTime.Time(N))  
    Log("NTP clock = " & DateTime.Time(N + DeviceToNTPOffset))  
End Sub
```
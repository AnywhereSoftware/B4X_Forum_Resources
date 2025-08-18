### ESP32 Ping by thetahsk
### 10/09/2021
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/134954/)

This is a B4R-ESP32 portation from <https://github.com/marian-craciunescu/ESP32Ping>  
Rename to rar and use winrar for decompression because rar attachment are not allowed.  
  

```B4X
Sub Process_Globals  
    Public Serial1 As Serial  
    Private ping As ESP32Ping  
    Private wifi As ESP8266WiFi  
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log("AppStart")  
    If wifi.Connect2("SSID","pssst") Then  
        Log("Connected to network")  
    Else  
        Log("Failed to connect to network")  
        Return  
    End If  
    AddLooper("Looper1")  
End Sub  
  
Private Sub Looper1  
    Log("google.com: ", ping.PingHost("google.com", 2),TAB,ping.AverageTime,TAB,StackBufferUsage,TAB,AvailableRAM)  
    Log("google.de:  ", ping.PingHost("google.de", 2),TAB,ping.AverageTime,TAB,StackBufferUsage,TAB,AvailableRAM)  
    Log("Google DNS: ", ping.PingIP(Array As Byte(8, 8, 8, 8),2),TAB,ping.AverageTime,TAB,StackBufferUsage,TAB,AvailableRAM)  
    Log("Google DNS: ", ping.PingIP(Array As Byte(8, 8, 4, 4),2),TAB,ping.AverageTime,TAB,StackBufferUsage,TAB,AvailableRAM)  
End Sub
```
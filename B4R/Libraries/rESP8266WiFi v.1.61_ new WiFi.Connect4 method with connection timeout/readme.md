### rESP8266WiFi v.1.61: new WiFi.Connect4 method with connection timeout by peacemaker
### 08/31/2025
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/168470/)

WiFi.Connect3 of lib v.1.6 was cloned into WiFi.Connect4 with timeout in seconds - default WiFi connection timeout is very long for me.  
The library files are attached.  
  

```B4X
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'Public variables can be accessed from all modules.  
    Public wifi As ESP8266WiFi  
    Private FailedCounter As Byte  
    Private FailLimit As Byte = 2    'max attempts qty to connect  
End Sub  
  
Sub isWiFiConnected As Boolean  
    Return wifi.IsConnected  
End Sub  
  
Sub Start(tag As Byte)  
    Delay(500)  
    Log("Internet-connection is starting …..")  
    Dim connected As Boolean = Connect  
    If connected = False Then  
        'todo  
        Return  
    End If  
End Sub  
  
Sub Connect As Boolean  
    wifi.Disconnect  
    Log("After disconnect NETip = ", wifi.LocalIp)  
    Dim connected As Boolean  
    'GlobalStore.Slot0 = SSID here;  GlobalStore.Slot1 = password  
    connected = wifi.Connect4(Main.bc.StringFromBytes(GlobalStore.Slot0), Main.bc.StringFromBytes(GlobalStore.Slot1), 0, Null, 5)  '5 seconds for more fast connecting  
    
    If connected Then  
        Log("Connected to WiFi OK: ")  
        Log("NETip = ", wifi.LocalIp)  
        FailedCounter = 0  
        'todo next after connection is OK  
    Else  
        FailedCounter = FailedCounter + 1  
        If FailedCounter < FailLimit Then  
            Log("—–Failed to connect to network !")  
            CallSubPlus("Start", 300, 1)  
        End If  
    End If  
    Return connected  
End Sub
```

  
  
Usage:  
  

```B4X
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Delay(2000)  
    interface.Start(0)  
End Sub
```

  
  
If able - please, try with your project and reply here how works, maybe any troubles…
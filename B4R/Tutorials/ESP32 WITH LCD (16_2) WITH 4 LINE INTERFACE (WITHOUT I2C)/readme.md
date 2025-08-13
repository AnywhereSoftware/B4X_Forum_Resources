### ESP32 WITH LCD (16*2) WITH 4 LINE INTERFACE (WITHOUT I2C) by embedded
### 05/10/2023
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/147891/)

```B4X
Sub Process_Globals  
    Public Serial1 As Serial  
    Private wifi As ESP8266WiFi  
    Public mylcd As LiquidCrystal  
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log("AppStart")  
    'example of connecting to a local network  
    mylcd.Initialize(13, 255, 12, Array As Byte(14, 27, 26, 25))  
    mylcd.Begin(16,2)  
    mylcd.Clear  
    mylcd.SetCursor(0,0)  
    mylcd.Write("B4X WORLD")  
    mylcd.SetCursor(0,1)  
    mylcd.Write("GREAT TOOL 4 ME")  
End Sub
```
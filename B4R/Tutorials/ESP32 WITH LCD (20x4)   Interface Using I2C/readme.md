### ESP32 WITH LCD (20x4)   Interface Using I2C by embedded
### 05/15/2023
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/147989/)

```B4X
#Region Project Attributes  
    #AutoFlushLogs: True  
    #CheckArrayBounds: True  
    #StackBufferSize: 600  
#End Region  
'Ctrl+Click to open the C code folder: ide://run?File=%WINDIR%\System32\explorer.exe&Args=%PROJECT%\Objects\Src  
  
Sub Process_Globals  
    Public Serial1 As Serial  
    Private wifi As ESP8266WiFi  
    Private lcd As LiquidCrystal_I2C  
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log("AppStart")  
    lcd.Initialize(0x27, 20, 4) 'based on the example from the project.  
    lcd.Backlight = True  
    lcd.SetCursor(0,0)  
    lcd.Write("THANK    YOU    EREL")  
    lcd.SetCursor(0,1)  
    lcd.Write("   FOR B4X WORLD")  
    lcd.SetCursor(0,2)  
    lcd.Write("ITS SIMPLIFY")  
    lcd.SetCursor(0,3)  
    lcd.Write("MY PROGRAMMING WORLD")  
    'example of connecting to a local network  
'    If wifi.Connect2("SSID", "PASSWORD") Then  
'        Log("Connected to network")  
'    Else  
'        Log("Failed to connect to network")  
'    End If  
End Sub
```
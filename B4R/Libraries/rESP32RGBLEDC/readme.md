### rESP32RGBLEDC by rwblinn
### 02/12/2025
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/165546/)

**B4R Library rESP32RGBLEDC  
  
Purpose  
rESP32RGBLEDC** is an open source library to set the color of a RGB LED connected to an ESP32 using the Arduino-ESP32 LEDC API.  
  
This B4R library is  

- written in C++ (using the Arduino IDE 2.3.4 and the B4Rh2xml tool).
- tested with an ESP32 Wrover Kit and Keyes KY-016 RGB LED.
- tested with B4R 4.00 (64 bit), ESP32 library 3.1.1.
- triggered by developing an example program (EnvMonitor which uses 2 RGB LED as Temperature&Humidity Comfort Indicator) for the B4R library [rBLEServer](https://www.b4x.com/android/forum/threads/rbleserver-for-esp32.165435/).

**Files**  
rESP32RGBLEDC.zip archive contains the library and sample project.  
  
**Install**  
From the zip archive, copy the content of the library folder, to the B4R additional libraries folder keeping the folder structure.  
  
**Functions**  
See basic example below.  
  
**B4R Basic Example**  

```B4X
'Wiring  
'RGB LED = ESP32 (wirecolor)  
'Red = GPIO25 (D25) (red)  
'Green = GPIO26 (D26) (green)  
'Blue = GPIO27 (D27) (blue)  
'GND = GND (black)  
  
Sub Process_Globals  
    Private VERSION As String = "rESP32RGBLEDC BasicExample v20250210"  
    Public Serial1 As Serial  
    Private rgb As ESP32RGBLEDC  
    Private redPin As Byte = 25  
    Private greenPin As Byte = 26  
    Private bluePin As Byte = 27  
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log(CRLF, "[AppStart]", VERSION)  
    'Init the rgb  
    Dim result As Boolean = rgb.Initialize(redPin, greenPin, bluePin, rgb.FREQUENCY_DEFAULT, rgb.RESOLUTION_DEFAULT)  
    If Not(result) Then  
        Log("[ERROR][Initialize] RGB LEDC not initialized. Check log.")  
        Return  
    Else  
        Log("[Initialize] RGB LEDC OK.")  
    End If  
    'Call method Test after 2 seconds  
    CallSubPlus("Test", 2000, 1)  
End Sub  
  
Private Sub Test(tag As Byte)  
    Dim delayms As ULong = 2000  
  
    rgb.On  
    Delay(delayms)  
  
    'Red low duty  
    rgb.Red = 50  
    Delay(delayms)  
  
    'Green full duty  
    rgb.Green = rgb.DUTY_MAX  
    Delay(delayms)  
  
    'Own method  
    FadingRed  
    Delay(delayms)  
    
    'Blue test out of duty range 0-255  
    '11111 (14bit) overflow > duty set 103 (last 7bit)  
    rgb.Blue = 11111  
    Dim colors(3) As Byte = rgb.GetColor  
    Log("[GetColor] r=",colors(0),",g=",colors(1),",b=",colors(2))  
    '[GetColor] r=0,g=0,b=103  
    Delay(delayms)  
  
    'Yellow  
    rgb.SetColor(255, 255, 0)  
    Delay(delayms)  
  
    Delay(delayms)  
    'Get the RGB LEDC duty values = must be yellow as previous set  
    Dim colors(3) As Byte = rgb.GetColor  
    '[GetColor] r=255,g=255,b=0  
    Log("[GetColor] r=",colors(0),",g=",colors(1),",b=",colors(2))  
    
    Delay(delayms)  
    rgb.Off  
End Sub  
  
'Own method to fade RED LED from duty min to max.  
Private Sub FadingRed  
    For i = rgb.DUTY_MIN To rgb.DUTY_MAX  
        rgb.Red = i  
        Delay(20)  
    Next  
End Sub
```

  
  
**Licence**  
GNU General Public License v3.0.
### rESP32LEDControl by rwblinn
### 06/13/2025
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/167411/)

**B4R Library rESP32LEDControl  
  
Purpose  
rESP32LEDControl** is an open source library to set the state/brightness of an LED connected to an ESP32 using selective functions from the [Arduino-ESP32 LEDC API](https://docs.espressif.com/projects/arduino-esp32/en/latest/api/ledc.html).  
  
This B4R library is  

- written in C++ (using the Arduino IDE 2.3.4 and the B4Rh2xml tool).
- tested with an ESP32 Wrover Kit and DFRobot LED.
- tested with B4R 4.00 (64 bit), ESP32 library 3.2.0.
- requires the Arduino ESP32 library version >= 3 (ESP\_ARDUINO\_VERSION\_MAJOR >= 3)

**Files**  
rESP32LEDControl-NNN.zip archive contains the library and sample project.  
  
**Install**  
From the zip archive, copy the content of the library folder, to the B4R additional libraries folder keeping the folder structure.  
  
**Functions**  
See basic example below.  
  
**Wiring**  

```B4X
LED    = ESP32 (wire-color)  
VCC    = 3V3 (red)  
Signal = GPIO2 (D2) (blue)  
GND    = GND (black)
```

  
  
**B4R Basic Example**  

```B4X
Sub Process_Globals  
    Private VERSION As String = "rESP32LEDControl Basic Example v20250613"  
    Public Serial1 As Serial  
    Private LED As ESP32LEDControl  
    Private LEDCPin As Byte = 2  
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log(CRLF, "[AppStart]", VERSION)  
  
    'Init the led  
    Dim result As Boolean = LED.Initialize(LEDCPin, LED.FREQUENCY_DEFAULT, LED.RESOLUTION_DEFAULT)  
    If Not(result) Then  
        Log("[AppStart][ERROR][Initialize] LED not initialized. Check log.")  
        Return  
    Else  
        Log("[AppStart][Initialize] LED OK.")  
    End If  
  
    'Call method Test immediate  
    CallSubPlus("Test", 0, 1)  
End Sub  
  
Private Sub Test(tag As Byte)  
    Dim delayms As ULong = 2000  
  
    Log("[Test] On")  
    LED.On  
    Delay(delayms)  
  
    Log("[Test] Low duty using Write")  
    LED.Write(50)  
    Delay(delayms)  
  
    Log("[Test] Full duty using Write")  
    LED.Write(LED.DUTY_MAX)  
    Delay(delayms)  
  
    Log("[Test] Set duty cycle 100")  
    LED.DutyCycle = 100  
    Log("[Test] Get duty cycle=",LED.DutyCycle)  
    Delay(delayms)  
  
    Log("[Test] Off")  
    LED.Off  
    Delay(delayms)  
   
    Log("[Test] FadeOut via CallSubPlus")  
    CallSubPlus("FadeOut", 1000, 5)  
End Sub  
  
' Own method to fade in from duty min to max.  
Public Sub FadeIn(fadestep As Byte)  
    For i = LED.DUTY_MIN To LED.DUTY_MAX Step fadestep  
        LED.Write(i)  
        Delay(20)  
    Next  
    Log("[FadeIn] Done")  
End Sub  
  
' Own method to fade out from duty min to max.  
Public Sub FadeOut(fadestep As Byte)  
    For i = LED.DUTY_MAX To LED.DUTY_MIN Step (fadestep * -1)  
        LED.Write(i)  
        Delay(20)  
    Next  
    Log("[FadeOut] Done")  
End Sub
```

  
  
**Licence**  
GNU General Public License v3.0.
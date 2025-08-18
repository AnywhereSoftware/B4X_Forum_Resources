### GY-530 / VL53L0X Time of Flight (ToF) laser ranging sensor - Inline C by Peter Simpson
### 02/04/2021
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/82124/)

**SubName:** Using Time of Flight (ToF) laser raging sensor to measure distances.  
**Description:** A Time of Flight (ToF) laser ranger sensor is an Infrared (IR) distance measurement sensor, the module uses I²C Bus communications (mine is at address 0x29) and can be powered by either a 3.3V or 5V power source. The ToF sensor can measure distances between 30mm to 2000mm (3cm to 2m) or maximum of 6.6 ft with an accuracy of ± 3% (apparently). This module detects the ToF (how long the emitted light has taken to bounce back to the sensor) and returns the distance measured. Since it uses a very narrow light source, it is good for determining distance of only the surface directly in front of it. The readings are returned in millimetres so there are no complicated conversion formulas to deal with.  
  
**PLEASE NOTE:** The internal laser emits 940nm wavelengths of non-visible light and does not harm the eyes, but if you use your phone camera you can see the light on your screen.  
  
[SPOILER="Log results"]  
Range = 51mm  
Range = 66mm  
Range = 78mm  
Range = 91mm  
Range = 129mm  
Range = 146mm  
Range = 171mm  
Range = 195mm  
Range = 203mm  
Range = 212mm  
Range = 225mm  
Range = 248mm  
Range = 260mm  
Range = 272mm  
Range = 277mm  
Range = 281mm  
Range = 305mm  
Range = 325mm  
Range = 326mm  
Range = 342mm  
Range = 332mm  
Range = 306mm  
Range = 277mm  
Range = 243mm  
Range = 222mm  
Range = 194mm  
Range = 159mm  
Range = 122mm  
Range = 95mm  
Range = 87mm  
Range = 83mm  
Range = 71mm  
Range = 71mm  
Range = 75mm  
Range = 75mm  
Range = 87mm  
Range = 98mm  
Range = 70mm  
Range = 76mm  
Range = 43mm  
Range = 46mm  
Range = 39mm  
[/SPOILER]  
  
**The following code has been tested on Arduino and also ESP8266 based devices.**  

```B4X
'Wiring legend for GY-530 / VL53L0X sensor to Arduino / WeMos D1 Mini / NodeMcu  
'VIN = 3.3V or 5V  
'GND = GND  
'SCL = Arduino SCL  
'SDA = Arduino SDA  
'———————————-  
'SCL = WeMos D1 Mini / NodeMcu = D1  
'SDA = WeMos D1 Mini / NodeMcu = D2  
  
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'Public variables can be accessed from all modules.  
    Public Serial1 As Serial  
  
    Private TmrSensor As Timer  
    Private Range As Int 'Ignore  
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log("AppStart")  
  
    RunNative("Setup", Null)  
  
    TmrSensor.Initialize("TmrSensor_Tick", 1000)  
    TmrSensor.Enabled = True  
End Sub  
  
Sub TmrSensor_Tick  
    RunNative("Range", Null)  
    Log("Range = ", Range, "mm")  
End Sub  
  
#If C  
  
#include <Wire.h>  
#include <VL53L0X.h>  
  
VL53L0X sensor;  
  
void Setup(B4R::Object* unused)  
{  
    Wire.begin();  
    sensor.init();  
    sensor.setTimeout(1000); //1000 miliseconds  
    sensor.startContinuous(100); //100 miliseconds  
}  
  
void Range(B4R::Object* unused)  
{  
    b4r_main::_range = sensor.readRangeContinuousMillimeters();  
    if (sensor.timeoutOccurred()) { Serial.print(" TIMEOUT"); }  
}  
  
#End If
```

  
  
**Tags:** Arduino, NodeMcu GY-530, VL53L0X, Time, of, Flight, ToF, Laser, Ranger  
  
**Wiring diagram for Arduino, for ESP8266 devices use D1 for SCL and D2 for SDA.**  
![](https://www.b4x.com/android/forum/attachments/58119)  
  
**GY-530 Time of Flight (ToF) laser ranging module.**  
![](https://www.b4x.com/android/forum/attachments/58118)  
  
**Enjoy…**
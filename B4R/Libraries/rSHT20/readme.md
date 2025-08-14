### rSHT20 by rwblinn
### 06/26/2025
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/167551/)

**B4R Library rSHT20  
  
Purpose  
rSHT20** is an open source library to read the temperature (°C) & humidity (%RH) from an **SHT20 sensor**.  
  
The **SHT20 Humidity and Temperature Sensor** is a sensor that accurately measures humidity and temperature, used where precise environmental monitoring and control is required.  
  
This B4R library is  

- written in C++ (using the Arduino IDE 2.3.4 and the B4Rh2xml tool).
- tested with an ESP-Wroom-32 and a SHT20 sensor from ELV PAD4.
- tested with B4R 4.00 (64 bit), ESP32 library 3.2.0.

**Files**  
rSHT20-NNN.zip archive contains the library and sample project.  
  
**Install**  
From the zip archive, copy the content of the library folder, to the B4R additional libraries folder keeping the folder structure.  
  
**Functions**  
See basic example below.  
  
**Wiring**  

```B4X
SHT20 = ESP32 - wire  
VCC = 3V3 - red  
SDA = GPIO21 - blue  
SCL = GPIO22 - green  
GND = GND - black
```

  
I2C Address = 0x40 (hard-coded in the header SHT20.h).  
  
**B4R Basic Example**  

```B4X
Sub Process_Globals  
    ' Communication  
    Public Serial1 As Serial  
    ' SHT20  
    Private sht As SHT20  
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log(CRLF, "[AppStart]")  
    'Init the module  
    Dim result As Boolean = sht.Initialize()  
    If Not(result) Then  
        Log("[AppStart][ERROR] Can not init the SHT20. Check the wiring.")  
    Else  
        Dim result As Boolean = sht.Measure  
        Log("[Measure] result=",result)  
        Log("[Measure] t=",sht.Temperature,"h=",sht.Humidity,",d=",sht.Dewpoint(sht.Temperature,sht.Humidity))  
    End If  
End Sub
```

  
  
*Log Output Example*  

```B4X
[AppStart]rSHT20 BasicExample v20250626  
[Measure] result=1  
[Measure] t=22.2196h=67.4444,d=15.9005
```

  
  
**License**  
MIT License  
  
**Setup**  
ESP32 with SHT20 Module.  
  
![](https://www.b4x.com/android/forum/attachments/164947)
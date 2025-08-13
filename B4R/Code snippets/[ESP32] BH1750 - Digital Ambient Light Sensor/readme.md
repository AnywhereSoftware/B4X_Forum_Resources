### [ESP32] BH1750 - Digital Ambient Light Sensor by peacemaker
### 08/15/2023
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/149597/)

[Old library](https://www.b4x.com/android/forum/threads/rbh1750fvi-digital-ambient-light-sensor.75663) cannot be compiled well for ESP32 (as declarations are conflicted with ESP SDK declarations), so used again inline-C code for more modern Arduino library:  

```B4X
'module name 'esp_bh1750'  
'install this Arduino library: https://github.com/claws/BH1750  
  
Private Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'Public variables can be accessed from all modules.  
    Dim LightLux As Float  
    Private Timer1 As Timer  
End Sub  
  
Sub Start  
    Log("Start reading BH1750…")  
    RunNative("prepare_bh1750", Null)  
    Timer1.Initialize("Timer1_Tick", 1000)  
    Timer1.Enabled = True  
End Sub  
  
Private Sub Timer1_Tick  
    RunNative("read_bh1750", Null)  
    Log(LightLux, " lx")  
End Sub  
  
#if C  
/*  
  
Advanced BH1750 library usage example  
  
This example has some comments about advanced usage features.  
  
Connections  
  
  - VCC to 3V3 or 5V  
  - GND to GND  
  - SCL to SCL (A5 on Arduino Uno, Leonardo, etc or 21 on Mega and Due, on  
    esp8266 free selectable)  
  - SDA to SDA (A4 on Arduino Uno, Leonardo, etc or 20 on Mega and Due, on  
    esp8266 free selectable)  
  - ADD to (not connected) or GND  
  
ADD pin is used to set sensor I2C address. If it has voltage greater or equal  
to 0.7VCC voltage (e.g. you've connected it to VCC) the sensor address will be  
0x5C. In other case (if ADD voltage less than 0.7 * VCC) the sensor address  
will be 0x23 (by default).  
  
*/  
  
#include <BH1750.h>  
#include <Wire.h>  
  
/*  
  BH1750 can be physically configured to use two I2C addresses:  
    - 0x23 (most common) (if ADD pin had < 0.7VCC voltage)  
    - 0x5C (if ADD pin had > 0.7VCC voltage)  
  
  Library uses 0x23 address as default, but you can define any other address.  
  If you had troubles with default value - try to change it to 0x5C.  
  
*/  
BH1750 lightMeter(0x23);  
  
void prepare_bh1750(B4R::Object* o) {  
  // Initialize the I2C bus (BH1750 library doesn't do this automatically)  
  Wire.begin();  
  // On esp8266 you can select SCL and SDA pins using Wire.begin(D4, D3);  
  
  /*  
  
    BH1750 has six different measurement modes. They are divided in two groups;  
    continuous and one-time measurements. In continuous mode, sensor  
    continuously measures lightness value. In one-time mode the sensor makes  
    only one measurement and then goes into Power Down mode.  
  
    Each mode, has three different precisions:  
  
      - Low Resolution Mode - (4 lx precision, 16ms measurement time)  
      - High Resolution Mode - (1 lx precision, 120ms measurement time)  
      - High Resolution Mode 2 - (0.5 lx precision, 120ms measurement time)  
  
    By default, the library uses Continuous High Resolution Mode, but you can  
    set any other mode, by passing it to BH1750.begin() or BH1750.configure()  
    functions.  
  
    [!] Remember, if you use One-Time mode, your sensor will go to Power Down  
    mode each time, when it completes a measurement and you've read it.  
  
    Full mode list:  
  
      BH1750_CONTINUOUS_LOW_RES_MODE  
      BH1750_CONTINUOUS_HIGH_RES_MODE (default)  
      BH1750_CONTINUOUS_HIGH_RES_MODE_2  
  
      BH1750_ONE_TIME_LOW_RES_MODE  
      BH1750_ONE_TIME_HIGH_RES_MODE  
      BH1750_ONE_TIME_HIGH_RES_MODE_2  
  
  */  
  
  // begin returns a boolean that can be used to detect setup problems.  
  if (lightMeter.begin(BH1750::CONTINUOUS_HIGH_RES_MODE)) {  
    //Serial.println(F("BH1750 Advanced begin"));  
  } else {  
    Serial.println(F("Error initialising BH1750"));  
  }  
}  
  
void read_bh1750(B4R::Object* o) {  
  if (lightMeter.measurementReady()) {  
    float lux = lightMeter.readLightLevel();  
    b4r_esp_bh1750::_lightlux = lux;  
    
   // Serial.print("Light: ");  
   // Serial.print(lux);  
   // Serial.println(" lx");  
  }  
}  
#End If
```
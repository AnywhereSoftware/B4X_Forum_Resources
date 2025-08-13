### BME280 - well known sensor: thermometer, barometer, hygrometer, altimeter by peacemaker
### 11/27/2023
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/157643/)

```B4X
#Region Project Attributes  
    #AutoFlushLogs: True  
    #CheckArrayBounds: True  
    #StackBufferSize: 600  
#End Region  
  
Sub Process_Globals  
    Public Serial1 As Serial  
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log("AppStart")  
    esp_bme280.Start_BME280  
End Sub
```

  
  

```B4X
'module name 'esp_bme280'  
'Library https://github.com/DFRobot/DFRobot_BME280  
'default i2c-address = 0x76 in the Inline-C code  
  
Private Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'Public variables can be accessed from all modules.  
     
    Public TEMPERATURE, PRESSURE, HUMIDITY, ALTITUDE As Double    'degrees C, Pa, % (RH), meters  
    Private Timer1 As Timer  
    Dim Ready_flag As Boolean  
End Sub  
  
Sub Start_BME280  
    Log("Start reading BME280…")  
    Dim res As Byte = RunNative("setup_bme280",Null)  
     
    If res > 0 Then  
        Timer1.Initialize("Timer1_Tick", 2000)  
        Timer1.Enabled = True  
    Else  
        Log("BME280 - prepare error.")  
    End If  
End Sub  
  
Sub Stop  
    Timer1.Enabled = False  
    Log("BME280 stopped")  
End Sub  
  
Private Sub Timer1_Tick  
    RunNative("read_bme280",Null)  
    Log("Temp=", (TEMPERATURE), "; Pressure=", PRESSURE, "; Hum=", HUMIDITY)  
    Ready_flag = True  
End Sub  
  
#if C  
#include <Wire.h>  
#include "DFRobot_BME280.h"  
  
typedef DFRobot_BME280_IIC    BME;    // ******** use abbreviations instead of full names ********  
  
/**IIC address is 0x77 when pin SDO is high */  
/**IIC address is 0x76 when pin SDO is low */  
BME   bme(&Wire, 0x76);   // select TwoWire peripheral and set sensor address  
  
#define SEA_LEVEL_PRESSURE    1015.0f  
  
B4R::Object returnvalue_bme280;  
  
B4R::Object* setup_bme280(B4R::Object* o){  
  if (bme.begin() != BME::eStatusOK) {  
      return returnvalue_bme280.wrapNumber(0);  
  }  
  return returnvalue_bme280.wrapNumber(1);  
}  
  
void read_bme280 (B4R::Object* o) {  
  float   temp = bme.getTemperature();  
  uint32_t    press = bme.getPressure();  
  float   humi = bme.getHumidity();  
  float   alti = bme.calAltitude(SEA_LEVEL_PRESSURE, press);  
    b4r_esp_bme280::_temperature = temp;  
    b4r_esp_bme280::_pressure = press;  
    b4r_esp_bme280::_humidity = humi;  
    b4r_esp_bme280::_altitude = alti;  
}  
  
#End if
```

  
  

```B4X
Dim p As Float = esp_bme280.PRESSURE / 133.32    'mmhg
```
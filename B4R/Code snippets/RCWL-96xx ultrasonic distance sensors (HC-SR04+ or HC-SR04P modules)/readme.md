### RCWL-96xx ultrasonic distance sensors (HC-SR04+ or HC-SR04P modules) by peacemaker
### 11/16/2023
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/157437/)

Old sensors HC-SR04 are analog, with measuring the distance as the impulse width.  
Latest models are with i2c interface based on some RCWL chips, like RCWL-9600, 9610, 9620 or so…  
  
  

```B4X
#Region Project Attributes  
    #AutoFlushLogs: True  
    #CheckArrayBounds: True  
    #StackBufferSize: 600  
#End Region  
  
Sub Process_Globals  
    Public Serial1 As Serial  
    Public bc As ByteConverter  
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log("AppStart")  
    esp_rcwl.Start_rcwl96  
End Sub
```

  
  

```B4X
'https://github.com/ftjuh/RCWL_1X05  
'Adopted by Vlad Pomelov aka Peacemakerv to B4R.  
'v.0.1  
'I2C address: 0x57 - rcwl96xx  
'module esp_rcwl  
  
Private Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'Public variables can be accessed from all modules.  
    Dim Ready_flag As Boolean  
    Private Busy As Boolean  
    Dim init_temperature As Float = 20    'air temperature for calibration, for more correct distance measurement  
    Dim distance As ULong    'millimeters  
    Dim Timer1 As Timer  
End Sub  
  
Sub Start_rcwl96  
    Log("Start reading rcwl96…")  
    Dim res As Byte = RunNative("prepare_rcwl96", Null)  
    If res > 0 Then  
        Timer1.Initialize("Timer1_Tick", 100)  
        Timer1.Enabled = True  
        Timer1_Tick  
    Else  
        Log("rcwl96 - prepare error.")  
    End If  
End Sub  
  
Sub Stop  
    Timer1.Enabled = False  
    Log("esp_rcwl96 stopped")  
End Sub  
  
Private Sub Timer1_Tick  
    If Busy Then  
        Return  
    End If  
    Busy = True  
    Ready_flag = False  
    RunNative("read_rcwl96", Null)  
    Log("distance = ", distance)  
    Ready_flag = True  
    Busy = False  
End Sub  
  
#if C  
#include <RCWL_1X05.h>  
#include <Wire.h>  
  
RCWL_1X05 sensor_rcwl;  
  
B4R::Object returnvalue_rcwl96;  
  
B4R::Object* prepare_rcwl96(B4R::Object* o) {  
  Wire.begin(); // must be called before sensor_rcwl.begin()  
  if (not sensor_rcwl.begin()) {  
    return returnvalue_rcwl96.wrapNumber(0);  
  }  
   
  //Serial.print("One shot mode measurement (blocking) = ");  
  //sensor_rcwl.setMode(RCWL_1X05::oneShot); // not really needed, it's the default mode  
  //Serial.print(sensor_rcwl.read()); Serial.println(" mm\n\n");  
  //delay(2000);  
   
  //Serial.print("Triggered mode measurement (non blocking) = ");  
  sensor_rcwl.setMode(RCWL_1X05::triggered);  
  sensor_rcwl.trigger();  
  delay(100); // do something meaningful here, but wait long enough before reading.  
  //Serial.print(sensor_rcwl.read()); Serial.println(" mm\n\n");  
  //delay(2000);  
   
  //Serial.println("Switching to continuous mode measurement with filter and 50 ms timeout\n\n");  
  sensor_rcwl.setFilter(true); // filter is turned off by default  
  sensor_rcwl.setTimeout(100); // 100 ms is recommended, but lower values might work  
  sensor_rcwl.setMode(RCWL_1X05::continuous);  
  
  float temp = b4r_esp_rcwl::_init_temperature;  
  sensor_rcwl.setTemperature(temp);  
  
  return returnvalue_rcwl96.wrapNumber(1);  
}  
  
   
void read_rcwl96(B4R::Object* o) {  
  bool newData = sensor_rcwl.update(); // calling update() repeatedly is crucial in continuous mode  
  if (newData) {  
    uint32_t res = sensor_rcwl.read();  
      b4r_esp_rcwl::_distance = res;  
    //Serial.print(sensor_rcwl.read()); Serial.println(" mm");  
  }  
}  
#End If
```
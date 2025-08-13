### XGZP6897D pressure sensors family by peacemaker
### 11/17/2023
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/157453/)

Modern pressure sensors where combined the piezoresistive pressure sensor and the ADC chipset with 24-bit resolution and I2C digital interface (and for temperature 16-bit one).  

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
    esp_xgzp.Start_xgzp  
End Sub
```

  
  

```B4X
'https://cfsensor.com/wp-content/uploads/2022/11/XGZP6847D-Pressure-Sensor-V2.5.pdf  
'https://github.com/fanfanlatulipe26/XGZP6897D  
'I2C device found at address: 0x6D (109)  
'Adopted by Vlad Pomelov aka Peacemakerv to B4R.  
'v.0.1  
'module esp_xgzp  
  
Private Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'Public variables can be accessed from all modules.  
    Dim Ready_flag As Boolean  
    Private Busy As Boolean  
    'set K - scale coefficient 8 … 8192 in the inline-c code below for your sensor type  
    Dim temp, pressure As Float    'C°, Pa  
    Dim Timer1 As Timer  
End Sub  
  
Sub Start_xgzp  
    Log("Start reading xgzp…")  
    Dim res As Byte = RunNative("prepare_xgzp", Null)  
    If res > 0 Then  
        Timer1.Initialize("Timer1_Tick", 1000)  
        Timer1.Enabled = True  
        Timer1_Tick  
    Else  
        Log("xgzp - prepare error.")  
    End If  
End Sub  
  
Sub Stop  
    Timer1.Enabled = False  
    Log("esp_xgzp stopped")  
End Sub  
  
Private Sub Timer1_Tick  
    If Busy Then  
        Return  
    End If  
    Busy = True  
    Ready_flag = False  
    RunNative("read_xgzp", Null)  
    Log("temperature = ", temp, "; pressure = ", pressure)  
    Ready_flag = True  
    Busy = False  
End Sub  
  
#if C  
#include <XGZP6897D.h>  
#include <Wire.h>  
  
/*  
   K value for XGZP6897D. It depend on the pressure range of the sensor.  
   Table found in the data sheet from CFSensor.com  
    https://cfsensor.com/product-category/i2c-sensor/  
  pressure_range (kPa)   K value  
  500<P≤1000              8  
  260<P≤500               16  
  131<P≤260               32  
  65<P≤131                64  
  32<P≤65                 128  
  16<P≤32                 256  
  8<P≤16                  512  
  4<P≤8                   1024  
  2≤P≤4                   2048  
  1≤P<2                   4096  
  P<1                     8192  
  the K value is selected according to the positive pressure value only,  
  like -100～100kPa,the K value is 64.  
*/  
  
// K value for a XGZP6897D  -500-500kPa  
#define K 16 // see table above for the correct value for your sensor, according to the sensitivity.  
  
  
XGZP6897D sensor_xgzp(K);  
float pressure, temperature;  
B4R::Object returnvalue_xgzp;  
  
B4R::Object* prepare_xgzp(B4R::Object* o) {  
  Wire.begin();  
  if (!sensor_xgzp.begin()) {  
    return returnvalue_xgzp.wrapNumber(0);  
  }  
  return returnvalue_xgzp.wrapNumber(1);  
}  
  
   
void read_xgzp(B4R::Object* o) {  
  // read the temperature (in °Celsius), and the pressure (in Pa)  
  sensor_xgzp.readSensor(temperature, pressure);  
  b4r_esp_xgzp::_temp = temperature;  
  b4r_esp_xgzp::_pressure = pressure;  
}  
#End If
```

  
  
> AppStart  
> Start reading xgzp…  
> temperature = 29.0078; pressure = 784.1250  
> temperature = 28.9805; pressure = 847.9375  
> temperature = 28.9492; pressure = 797.5000  
> temperature = 28.9336; pressure = 796.6875 'default atmospheric pressure at K = 16  
> temperature = 28.8984; pressure = 902.7500  
> temperature = 28.8750; pressure = 856.1250  
> temperature = 28.8633; pressure = 681.6875  
> temperature = 28.8398; pressure = 799.0625  
> temperature = 28.8164; pressure = 873.8750  
> temperature = 28.8047; pressure = 748.3125  
> temperature = 28.7656; pressure = 992.6875  
> temperature = 28.7500; pressure = 3924.6250 'blowing pressure  
> temperature = 28.7305; pressure = 5456.3125  
> temperature = 28.7109; pressure = 813.3750  
> temperature = 28.6953; pressure = 914.1250  
> temperature = 28.6914; pressure = 809.6250  
> temperature = 28.6641; pressure = 784.8750
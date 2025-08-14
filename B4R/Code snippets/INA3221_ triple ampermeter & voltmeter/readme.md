### INA3221: triple ampermeter & voltmeter by peacemaker
### 08/05/2025
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/168117/)

INA3221 can help with measuring up to 3 points: current and voltage.  
Default shunt resistors on INA3221 board are 0.1 Ohm (R100) and allow to measure up to ±1.638 Amper, so, i have added over them one more 0.1 Ohm resistors (to 1 and 3 channels only), and got the parallel resistance of 0.05 Ohm for measuring up to 3.2 A.  
  
Each i2c sensor board first of all i check by the i2c scanner: <https://www.b4x.com/android/forum/threads/i2c-bus-devices-scanner-with-found-address-description.158928/> to see the default bus address, it was:  
  
> I2C device found at address: 0x40 (64): 0x40

The address is set in the Inline-C code below.   
  
Note1: some INA3221 boards can be defective from the factory: all 3 channels GND terminals are … connected together, so it can measure only for a single channel. So, better to check that 6 pads all are with separate tracks on the board.  
  
Note2: the load must be connected to the left terminal (reading channel names horizontally), the source - to the right, to get measuring working.  
![](https://www.b4x.com/android/forum/attachments/165844)  
  
  

```B4X
'module name: esp_ina3221  
'© Peacemaker  
'v.0.1  
'install this Arduino library: https://github.com/beast-devices/Arduino-INA3221  
  
'I2C device found at address: 0x40 (64): 0x40  
  
Private Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'Public variables can be accessed from all modules.  
    Dim pinSDAnumber As Byte = 5    'default esp32 = 21  
    Dim pinSCLnumber As Byte = 6    'default esp32 = 22  
    Dim Ready_flag As Boolean  
    Private Timer1 As Timer  
    Dim Current1, Current2, Current3 As Float    'ignore  
    Dim Voltage1, Voltage2, Voltage3 As Float    'ignore  
  
End Sub  
  
Sub Start_ina3221  
    Log("Setup ina3221…")  
    Ready_flag = False  
    Dim SCL, SDA As Pin  
    SCL.Initialize(pinSCLnumber, SCL.MODE_INPUT_PULLUP)  
    SDA.Initialize(pinSDAnumber, SCL.MODE_INPUT_PULLUP)  
    If RunNative("prepare_ina3221", Null).As(Byte) = 0 Then  
        Log("ina3221 is not found !")  
        Return  
    End If  
    Timer1.Initialize("Timer1_Tick", 900)  
    Timer1.Enabled = True  
End Sub  
  
Sub Timer1_Tick  
    RunNative("read_ina3221", Null)  
    If Current1 < 0.003 Then Current1 = 0  
    If Current2 < 0.003 Then Current2 = 0  
    If Current3 < 0.003 Then Current3 = 0  
   
    Log("Currents: ", Current1, "; ", Current2, "; ", Current3)  
    Log("Voltages: ", Voltage1, "; ", Voltage2, "; ", Voltage3)  
    Ready_flag = True  
End Sub  
  
#if C  
#include <Wire.h>  
#include <Beastdevices_INA3221.h>  
B4R::Object returnvalue_ina3221;  
  
// Set I2C address to 0x40 (A0 pin -> GND) by default  
Beastdevices_INA3221 ina3221(INA3221_ADDR40_GND);  
  
B4R::Object* prepare_ina3221(B4R::Object* o) {  
  bool inited = ina3221.begin(&Wire, b4r_esp_ina3221::_pinsdanumber, b4r_esp_ina3221::_pinsclnumber);  
  if (!inited) return returnvalue_ina3221.wrapNumber((Byte)0);  
  ina3221.reset();  
  
  // Set shunt resistors to mOhm for all channels  
  ina3221.setShuntRes(50, 100, 50);  
   
  return returnvalue_ina3221.wrapNumber((Byte)1);  
}  
  
void read_ina3221(B4R::Object* o) {  
  float current[3];  
  float voltage[3];  
  
  current[0] = ina3221.getCurrent(INA3221_CH1);  
  voltage[0] = ina3221.getVoltage(INA3221_CH1);  
  
  current[1] = ina3221.getCurrent(INA3221_CH2);  
  voltage[1] = ina3221.getVoltage(INA3221_CH2);  
  
  current[2] = ina3221.getCurrent(INA3221_CH3);  
  voltage[2] = ina3221.getVoltage(INA3221_CH3);  
   
  b4r_esp_ina3221::_voltage1 = voltage[0];  
  b4r_esp_ina3221::_voltage2 = voltage[1];  
  b4r_esp_ina3221::_voltage3 = voltage[2];  
  b4r_esp_ina3221::_current1 = current[0];  
  b4r_esp_ina3221::_current2 = current[1];  
  b4r_esp_ina3221::_current3 = current[2];  
}  
#End If
```

  
  
  
> Currents: 0; 0; 0.1920  
> Voltages: 3.6000; 0; 7.5920  
> ———————-
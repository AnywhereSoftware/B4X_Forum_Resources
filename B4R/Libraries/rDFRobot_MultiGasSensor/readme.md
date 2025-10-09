### rDFRobot_MultiGasSensor by rwblinn
### 10/06/2025
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/168932/)

**B4R Library rDFRobot\_MultiGasSensor**  

---

  
  
**Brief  
rDFRobot\_MultiGasSensor** is an open-source library for the **DFRobot MultiGasSensor** with **focus on measuring CO**.  
  
This library  

- is wrapped from the [DFRobot\_MultiGasSensor library](https://github.com/DFRobot/DFRobot_MultiGasSensor).
- reads the CO gas concentration, VO voltage, and on-board temperature from the **DFRobot SEN0466 Gravity CO sensor**.
- communicates via I2C - UART is not exposed.
- has no support for interrupts & thresholds.
- temperature compensation is ON (using the algorithm in the B4R wrapped library).
- has been developed to detect CO only - any other gases have not been tested (but should be easy to add).

---

  
  
**Development Info**  

- Written in C++ (Arduino IDE 2.3.6, Arduino CLI 1.2.2 and the B4Rh2xml tool).
- Includes the library DFRobot\_MultiGasSensor.
- Tested with

- Hardware - Arduino UNO, ESP-32, DFRobot SEN0466 Gravity CO sensor calibrated I2C & UART.
- Software - B4R 4.00 (64-bit), DFRobot\_MultiGasSensor library v2.0.0.

---

  
  
**CO Sensor**  
The DFRobot SEN0466 Gravity CO sensor calibrated I2C & UART parameter are:  

- Gas type:CO
- Detection Range: 0-1000 ppm
- Resolution: 1 ppm
- V0 Voltage Output Range: 0.6-3 V
- Response Time (T90): <= 30 S

---

  
  
**Wiring & Test Setup**  
  
![](https://www.b4x.com/android/forum/attachments/167604)  

---

  
  
**Files**  
The *rDFRobot\_MultiGasSensor-NNN.zip* archive contains the library and sample projects.  

---

  
  
**Install**  
Copy the *rDFRobot\_MultiGasSensor* library folder from the archive into your B4R **Additional Libraries** folder, keeping the folder structure intact.  

---

  
  
**Wiring**  
Sensor = Arduino  

```B4X
SEN0466 = Arduino UNO / ESP32  
VCC = 3V3 / 3V3  
GND = GND / GND  
D/T SDA = A4 / GPIO21 (Green)  
C/R SCL = A5 / GPIO22 (Blue)
```

  
I2C Address  
Sensor default address: 0x74 (Ensure SEL dip switch set to 0).  

---

  
  
**Basic Example**  

```B4X
Sub Process_Globals  
    Public Serial1 As Serial  
    Private Sensor As DFRobot_MultiGasSensor  
    Private TimerSampler As Timer  
    Private TIMERSAMPLER_INTERVAL As ULong = 15000    ' Every 15 seconds  
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log(CRLF, "[Main.AppStart] Initialize")  
    ' Init the sensor with default I2C address  
    If Not(Sensor.Initialize) Then  
        Log(CRLF, "[Main.AppStart] Sensor initialize Error. Check device connected or I2C address set to 0x74")     
        Return  
    Else  
        Log(CRLF, "[Main.AppStart] Sensor initialize OK")  
    End If  
    ' Init the timer  
    TimerSampler.Initialize("TimerSampler_Tick", TIMERSAMPLER_INTERVAL)  
    TimerSampler.Enabled = True  
    CallSubPlus("ReadData", 0, 5)  
    Log("[Main.AppStart] Done", CRLF)  
End Sub  
  
Private Sub TimerSampler_Tick  
    ReadData(0)  
End Sub  
  
Private Sub ReadData(Tag As Byte)  
    ' Get the type of gas to be obtained - CO  
    Dim gastype As String = Sensor.ReadGasType  
    Dim gastypeid As Byte = Sensor.ReadGasTypeID  
   
    ' Read the gas concentration  
    Dim concentration As Float = Sensor.ReadConcentrationPPM  
   
    ' Read the sensor voltage  
    Dim voltage As Float = Sensor.ReadVoltage  
   
    ' Read the on-board temperature  
    Dim temperature As Float = Sensor.ReadTemperatureC  
   
    ' Log to the IDE  
    Log("[ReadData] ReadGasType=", gastype, " (", gastypeid, "), ReadConcentrationPPM=", concentration, ", ReadVoltage=", voltage, ", ReadTemperatureC=", temperature)  
    ' [ReadData] ReadGasType=CO (4), ReadConcentrationPPM=0, ReadVoltage=0.5566, ReadTemperatureC=21.3411  
End Sub
```

  

---

  
  
**Functions**  
Initialize() As Boolean  
Initialize with default I2C address (0x74).  
Mode of obtaining data is passiv and the temperature compensation is turned on.  
return bool type, indicating whether the initialization is successful.  
retval True succeed.  
retval False failed.  
  
InitializeWithAddress(addr As Byte) As Boolean  
Initialize with a custom I2C address.  
Mode of obtaining data is passiv and the temperature compensation is turned on.  
param addr Byte I2C address.´Default address 0x74.  
return bool type, indicating whether the initialization is successful.  
retval True succeed.  
retval False failed.  
  
bool SetAcquireMode(mode As Byte)  
Set the mode of acquiring sensor data.  
param mode Mode select.  
INITIATIVE The sensor proactively reports data.  
PASSIVITY The main controller needs to request data from sensor.  
return bool type, indicating whether the setting is successful.  
retval True succeed.  
retval False failed.  
  
float ReadConcentrationPPM  
Read the gas concentration from sensor, unit PPM.  
return float type, indicating return gas concentration, if data is transmitted normally, return gas concentration, otherwise, return 0.0.  
  
ReadGasType As String  
Read the type of current gas probe, i.e. O2,CO,H2S,NO2,O3,CL2,NH3,H2,HCL,SO2,HF,PH3.  
return String type, indicating the gas type as string.  
  
ReadGasTypeID As Byte  
Read the type of current gas probe, i.e. O2=0x05,CO=0x04,H2S=0x03,NO2=0x2C,O3=0x2A,CL2=0x31,NH3=0x02,H2=0x06,HCL=0X2E,SO2=0X2B,HF=0x33,PH3=0x45.  
return Byte type, indicating gas type ID as byte.  
  
SetThresholdAlarm(switchoff As Byte, threshold As UInt, alamethod As Byte) As Boolean  
Set sensor alarm threshold.  
Function modified to use the type of the current gas probe (using QueryGasType).  
**NOTE:** It is recommend to create own threshold solution in B4R.  
param switchoff Whether to turn on threshold alarm switch. ON turn on, OFF turn off.  
param threshold The threshold for starting alarm.  
param alamethod Set sensor high or low threshold alarm.  
return bool type, indicating whether the setting is successful.  
retval True succeed.  
retval False failed.  
  
ReadTemperatureC As Float  
Get sensor onboard temperature.  
return float type, indicating return the current onboard temperature.  
  
SetTemperatureCompensation(tempswitch As Byte)  
Set whether to turn on temperature compensation, values output by sensor under different temperatures are various.  
To get more accurate gas concentration, temperature compensation is necessary when calculating gas concentration.  
param tempswitch Whether to turn on temperature compensation. ON Turn on temperature compensation, OFF Turn off temperature compensation.  
  
ReadVoltage As Float  
Read voltage output by sensor probe (for calculating the current gas concentration).  
This is the original voltage output V0 of the gas probe.  
return float type, indicating return voltage value.  
  
IsDataAvailable As Boolean  
Call this function in active mode to determine the presence of data on data line.  
return bool type, indicating whether there is data coming from the sensor.  
retval True Has uploaded data.  
retval False No data uploaded.  
  
SetI2CAddrGroup(group As Byte) As Boolean  
Set the I2C address group.  
param group Address group select.  
return int type, indicating return init status.  
retval bool type.  
retval True Change succeed.  
retval False Change failed.  
  

---

  
  
**Constants**  
I2C\_DEFAULT\_ADDRESS = 0x74  
MODE\_INITIATIVE = 0x03  
MODE\_PASSIVITY = 0x04  
GASTYPE\_UNKNOWN = 0x00  
GASTYPE\_O2 = 0x05  
GASTYPE\_CO = 0x04  
GASTYPE\_H2S = 0x03  
GASTYPE\_NO2 = 0x2C  
GASTYPE\_O3 = 0x2A  
GASTYPE\_CL2 = 0x31  
GASTYPE\_NH3 = 0x02  
GASTYPE\_H2 = 0x06  
GASTYPE\_HCL = 0X2E  
GASTYPE\_SO2 = 0X2B  
GASTYPE\_HF = 0x33  
GASTYPE\_PH3 = 0x45  
  

---

  
  
**Notes & Tips**  
Using the DFRobot SEN0466 (Gravity CO Sensor) with ESP32.  

- This sensor works reliably on Arduino UNO, but requires special attention on ESP32 due to I2C timing and architecture differences.
- The default I2C address for the sensor is 0x74, depending on the DIP switch configuration (A0=0, A1=0).
- Ensure ESP32 wiring SDA = GPIO21, SCL = GPIO22, VCC = 3V3, GND = GND.
- In function `Initialize`, the clock and timeout are explicitly set to 100 kHz and 1 second.
- Acquisition mode: if experience unstable or random readings, use INITIATIVE mode instead of PASSIVITY.

  
**Common issues and solutions**  

- E (72) i2c.master: probe device timeout…: Check pull-up resistors (4.7 kOhm–10 kOhm) on SDA/SCL lines.
- Guru Meditation Error: LoadProhibited: The sensor did not return a complete I2C response. Add small delays or switch to INITIATIVE mode.
- Best practice for wrapped B4R libraries:

- Configure Wire clock and timeout before calling sensor->begin().
- Always verify that begin() returns true before any read operation.
- Do not call readGasConcentrationPPM() until initialization and gas type queries have completed.

---

  
  
**ToDo**  

- Create prototype in a case with this CO sensor, 7-segment-display TM1637, LED traffic-light to be placed in the living room as CO indicator - beside the Smartwares PB-8826 as certified safety backup (audible alarm).
- Integrate this solution in my [Home Assistant Workbook Experiments](http://github.com/rwbl/Home-Assistant-Workbook-Experiments) (already developed & tested with an ESP-32).

---

  
  
**Credits**  
DFRobot for the DFRobot\_MultiGasSensor library.  
  
**Disclaimer**  

- This project is developed for personal use only.
- All examples and code are provided as-is and should be used **at your own risk**.
- Any guidance provided as-is, without any guarantee or liability for errors, omissions, or wrong configurations.
- Always test thoroughly and exercise caution when connecting hardware components.

  
**Licenses**  
Original Library (DFRobot)  
Copyright © 2021 DFRobot. Licensed under the MIT License (see LICENSE file in the original repository).  
  
License for this wrapper  
Copyright © 2025 Robert W.B. Linn. Licensed under the MIT License (see LICENSE file).  
  
Notes  
The DFRobot\_MultiGasSensor library remains under the MIT License.  
This wrapper code is MIT licensed. When distributing, both licenses apply.
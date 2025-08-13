### ENS160 Multi-Gas Sensor by peacemaker
### 11/16/2023
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/157415/)

Sensor [ENS160](https://cdn-learn.adafruit.com/assets/assets/000/115/331/original/SC_001224_DS_1_ENS160_Datasheet_Rev_0_95-2258311.pdf?1663951433) can measure: Air quality index, Concentration of total volatile organic compounds (ppb), Carbon dioxide equivalent concentration (ppm).  
Default I2C address: 0x53 (can also work via SPI interface, not used here).  
  

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
    esp_ens160.Start_ENS160    'start sensor  
End Sub
```

  
  

```B4X
'https://github.com/DFRobot/DFRobot_ENS160  
'Adopted by Vlad Pomelov aka Peacemakerv to B4R.  
'v.0.13  
'I2C address: 0x53 (83) - ens160  
'module esp_ens160  
  
Private Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'Public variables can be accessed from all modules.  
    Dim Ready_flag As Boolean  
    Private Busy As Boolean  
    Dim init_temp As Float = 25    'for sensor pre-calibration temparature  
    Dim init_humidity As Float = 50    '…humidity, can be got from AHT21 sensor that may be placed to the same module PCB  
    Dim aqi, tvoc, eco2 As Float    'Air quality index, Concentration of total volatile organic compounds (ppb), Carbon dioxide equivalent concentration (ppm)  
    Dim Timer1 As Timer  
End Sub  
  
Sub Start_ENS160  
    Log("Start reading ENS160…")  
    Dim res As Byte = RunNative("prepare_ens160", Null)  
    If res > 0 Then  
        Timer1.Initialize("Timer1_Tick", 2000)  
        Timer1.Enabled = True  
        Timer1_Tick  
    Else  
        Log("ens160 - prepare error.")  
    End If  
End Sub  
  
Sub Stop  
    Timer1.Enabled = False  
    Log("esp_ens160 stopped")  
End Sub  
  
Private Sub Timer1_Tick  
    If Busy Then  
        Return  
    End If  
    Busy = True  
    Ready_flag = False  
  
'    Log("init_temp = ", init_temp, "; init_humidity = ", init_humidity)  
    If init_temp + init_humidity > 0 Then  
        aqi = -1  
        tvoc = -1  
        eco2 = -1  
        RunNative("read_ens160", Null)  
        Dim sum As Float = aqi + tvoc + eco2    'sensor often returns zero values, so it needs to ignore then next  
        If sum > 0 Then  
            Log("aqi = ", aqi, "; tvoc = ", tvoc, "; eco2 = ", eco2)  
            Ready_flag = True  
        End If  
    End If  
    Busy = False  
End Sub  
  
#if C  
#include <Wire.h>  
#include <DFRobot_ENS160.h>  
DFRobot_ENS160_I2C ENS160(&Wire, /*I2CAddr*/ 0x53);  
  
B4R::Object returnvalue_ens160;  
  
B4R::Object* prepare_ens160(B4R::Object* o) {  
  Wire.begin(); //Join I2C bus  
  if (NO_ERR != ENS160.begin())  
  {  
    return returnvalue_ens160.wrapNumber(0);  
  }  
  return returnvalue_ens160.wrapNumber(1);  
}  
  
   
void read_ens160(B4R::Object* o) {  
  ENS160.setPWRMode(ENS160_STANDARD_MODE);  
  float temp = b4r_esp_ens160::_init_temp;  
  float humi = b4r_esp_ens160::_init_humidity;  
  ENS160.setTempAndHum(/*temperature=*/temp, /*humidity=*/humi);  
  
  uint8_t Status = ENS160.getENS160Status();  
  //Serial.print("Sensor operating status : ");  
  //Serial.println(Status);  
  
  /**  
   * Get the air quality index  
   * Return value: 1-Excellent, 2-Good, 3-Moderate, 4-Poor, 5-Unhealthy  
   */  
  uint8_t AQI = ENS160.getAQI();  
  //Serial.print("Air quality index : ");  
  //Serial.println(AQI);  
  
  /**  
   * Get TVOC concentration  
   * Return value range: 0–65000, unit: ppb  
   */  
  uint16_t TVOC = ENS160.getTVOC();  
  // Serial.print("Concentration of total volatile organic compounds : ");  
  //Serial.print(TVOC);  
  //Serial.println(" ppb");  
  
  /**  
   * Get CO2 equivalent concentration calculated according to the detected data of VOCs and hydrogen (eCO2 – Equivalent CO2)  
   * Return value range: 400–65000, unit: ppm  
   * Five levels: Excellent(400 - 600), Good(600 - 800), Moderate(800 - 1000),  
   *               Poor(1000 - 1500), Unhealthy(> 1500)  
   */  
  uint16_t ECO2 = ENS160.getECO2();  
  //Serial.print("Carbon dioxide equivalent concentration : ");  
  //Serial.print(ECO2);  
  //Serial.println(" ppm");  
  
  
  
    b4r_esp_ens160::_aqi = AQI;  
    b4r_esp_ens160::_tvoc = TVOC;  
    b4r_esp_ens160::_eco2 = ECO2;  
}  
#End If
```
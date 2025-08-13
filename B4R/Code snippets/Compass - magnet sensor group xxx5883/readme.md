### Compass - magnet sensor group xxx5883 by peacemaker
### 11/25/2023
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/157604/)

There are many versions of compass chip with 5883 number in the name.  
Initial Honeywell's chipset was HMC5883L with the i2c address = 0x1E.  
Also it's known a chinese clone QMC5883 with i2c address = 0x0D. And other versions exist.  
Below is the code with universal library that can detect one of 3 chipsets.  
  

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
    esp_compass.Start  
End Sub
```

  
  

```B4X
'module name 'esp_compass'  
'chipsets Honeywell's HMC5883L (i2c address = 0x1E), QMC5883 i2c address = 0x0D) and other  
'https://github.com/DFRobot/DFRobot_QMC5883 - universal lib  
'v.0.2  
  
Private Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'Public variables can be accessed from all modules.  
    Dim Ready_flag As Boolean  
    Private X,Y,Z As Int, heading As Double  
    Dim azimuth As Double ' 0….359 degrees heading to the magnet North.  
    Private Timer1 As Timer  
    Dim ChipType As Byte    '1/2/3 = HMC5883L/QMC5883/VCM5883L  
End Sub  
  
Sub Start  
    ChipType = RunNative("prepare_compass",Null)  
    If ChipType > 0 Then  
        Timer1.Initialize("Timer1_Tick", 200)  
        Timer1.Enabled = True  
    Else  
        Log("Compass - prepare error.")  
    End If  
End Sub  
  
Sub Stop  
    Timer1.Enabled = False  
    Log("Compass stopped")  
End Sub  
  
Private Sub HandleNewReading(NewValue As Float) As Float  
    Dim N As Int = 3    'smoothing factor, 1 = none, higher = smoother  
    azimuth = (azimuth * (N - 1) + NewValue) / N    'moves FilteredValue 1/Nth towards NewValue  
End Sub  
  
Private Sub Timer1_Tick  
    Ready_flag = False  
    Timer1.Enabled = False  
    RunNative("read_compass",Null)  
    HandleNewReading(heading)  
'    Log("x:  ", X , ",  y:  ", Y ,",  z:  ", Z)  
    Log("azimuth = ", NumberFormat(azimuth, 1, 1), " °")    '"Heading is 0…360 from the North  
    '——————————————  
    Ready_flag = True  
    Timer1.Enabled = True  
End Sub  
  
  
  
#if C  
#include <Wire.h>  
#include <DFRobot_QMC5883.h>  
  
//#define HMC5883L_ADDRESS             (0x1E)  
//#define QMC5883_ADDRESS              (0x0D)  
//#define VCM5883L_ADDRESS             (0x0C)  
  
DFRobot_QMC5883 compass(&Wire, HMC5883L_ADDRESS);  
  
B4R::Object returnvalue_compass;  
  
B4R::Object* prepare_compass(B4R::Object* o) {  
  if (!compass.begin())  
  {  
    return returnvalue_compass.wrapNumber(0);  
  }  
   
  if(compass.isHMC())  
  {  
    Serial.println("Initialize HMC5883");  
    //compass.setRange(HMC5883L_RANGE_1_3GA);  
    //compass.setMeasurementMode(HMC5883L_CONTINOUS);  
    //compass.setDataRate(HMC5883L_DATARATE_15HZ);  
    //compass.setSamples(HMC5883L_SAMPLES_8);  
   
    return returnvalue_compass.wrapNumber(1);  
  }  
  if(compass.isQMC())  
  {  
    Serial.println("Initialize QMC5883");  
    //compass.setRange(QMC5883_RANGE_2GA);  
    //compass.setMeasurementMode(QMC5883_CONTINOUS);  
    //compass.setDataRate(QMC5883_DATARATE_50HZ);  
    //compass.setSamples(QMC5883_SAMPLES_8);  
   
    return returnvalue_compass.wrapNumber(2);  
  }  
  if(compass.isVCM())  
  {  
    Serial.println("Initialize VCM5883L");  
    compass.setMeasurementMode(VCM5883L_CONTINOUS);  
    compass.setDataRate(VCM5883L_DATARATE_200HZ);  
   
    return returnvalue_compass.wrapNumber(3);  
  }  
   
  
}  
   
void read_compass (B4R::Object* o) {  
  //float declinationAngle = (4.0 + (26.0 / 60.0)) / (180 / PI);  
  //compass.setDeclinationAngle(declinationAngle);  
  sVector_t mag = compass.readRaw();  
  compass.getHeadingDegrees();  
  // Serial.print("X:");  
  // Serial.print(mag.XAxis);  
  // Serial.print(" Y:");  
  // Serial.print(mag.YAxis);  
  // Serial.print(" Z:");  
  // Serial.println(mag.ZAxis);  
  // Serial.print("Degress = ");  
  // Serial.println(mag.HeadingDegress);  
   
   b4r_esp_compass::_heading = mag.HeadingDegress;  
   b4r_esp_compass::_x = mag.XAxis;  
   b4r_esp_compass::_y = mag.YAxis;  
   b4r_esp_compass::_z = mag.ZAxis;  
   
}  
  
#End if
```

  
  
  
Maybe better not to use "HandleNewReading" smoothing.  
Actually, the chips are different by the registers and even the orientation: QMC North is along the X+. But HMC North is along Y-.
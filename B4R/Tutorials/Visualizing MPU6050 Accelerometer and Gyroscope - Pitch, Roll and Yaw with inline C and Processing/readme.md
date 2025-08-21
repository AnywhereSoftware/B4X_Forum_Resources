### Visualizing MPU6050 Accelerometer and Gyroscope - Pitch, Roll and Yaw with inline C and Processing by Johan Schoeman
### 02/29/2020
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/114461/)

It is based on [**this tutorial**](https://howtomechatronics.com/tutorials/arduino/arduino-and-mpu6050-accelerometer-and-gyroscope-tutorial/). Nano programmed via B4R and visualizing the data from the MPU6050 with Processing -   
See [**this posting**](https://www.b4x.com/android/forum/threads/visualizing-adxl345-3-axis-accelerometer-pitch-and-roll-with-inline-c-and-processing.113992/) for basic setup  
  
**B4R code:**  

```B4X
#Region Project Attributes  
    #AutoFlushLogs: True  
    #CheckArrayBounds: True  
    #StackBufferSize: 300  
#End Region  
  
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'Public variables can be accessed from all modules.  
    Public Serial1 As Serial  
      
    Private GyroErrorX, GyroErrorY, GyroErrorZ As Float  
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(19200)  
    Log("AppStart")  
      
    RunNative("setup1", Null)  
'    Log("GyroErrorX = ", GyroErrorX)  
    AddLooper("mylooper")  
  
End Sub  
  
Sub myLooper  
      
    RunNative("loop1", Null)  
      
      
End Sub  
  
#If C  
  
  
/*  
   Arduino and MPU6050 Accelerometer and Gyroscope Sensor Tutorial  
   by Dejan, https://howtomechatronics.com  
*/  
  
#include <Wire.h>  
  
const int MPU = 0x68; // MPU6050 I2C address  
float AccX, AccY, AccZ;  
float GyroX, GyroY, GyroZ;  
float accAngleX, accAngleY, gyroAngleX, gyroAngleY, gyroAngleZ;  
float roll, pitch, yaw;  
float AccErrorX, AccErrorY, GyroErrorX, GyroErrorY, GyroErrorZ;  
float elapsedTime, currentTime, previousTime;  
int c = 0;  
  
void calculate_IMU_error();  
  
void setup1(B4R::Object* o) {  
  Serial.begin(19200);  
  Wire.begin();                      // Initialize comunication  
  Wire.beginTransmission(MPU);       // Start communication with MPU6050 // MPU=0x68  
  Wire.write(0x6B);                  // Talk to the register 6B  
  Wire.write(0x00);                  // Make reset - place a 0 into the 6B register  
  Wire.endTransmission(true);        //end the transmission  
  /*  
  // Configure Accelerometer Sensitivity - Full Scale Range (default +/- 2g)  
  Wire.beginTransmission(MPU);  
  Wire.write(0x1C);                  //Talk to the ACCEL_CONFIG register (1C hex)  
  Wire.write(0x10);                  //Set the register bits as 00010000 (+/- 8g full scale range)  
  Wire.endTransmission(true);  
  // Configure Gyro Sensitivity - Full Scale Range (default +/- 250deg/s)  
  Wire.beginTransmission(MPU);  
  Wire.write(0x1B);                   // Talk to the GYRO_CONFIG register (1B hex)  
  Wire.write(0x10);                   // Set the register bits as 00010000 (1000deg/s full scale)  
  Wire.endTransmission(true);  
  delay(20);  
  */  
  // Call this function if you need to get the IMU error values for your module  
  calculate_IMU_error();  
  delay(20);  
  
}  
  
void loop1(B4R::Object* o) {  
  // === Read acceleromter data === //  
  Wire.beginTransmission(MPU);  
  Wire.write(0x3B); // Start with register 0x3B (ACCEL_XOUT_H)  
  Wire.endTransmission(false);  
  Wire.requestFrom(MPU, 6, true); // Read 6 registers total, each axis value is stored in 2 registers  
  //For a range of +-2g, we need to divide the raw values by 16384, according to the datasheet  
  AccX = (Wire.read() << 8 | Wire.read()) / 16384.0; // X-axis value  
  AccY = (Wire.read() << 8 | Wire.read()) / 16384.0; // Y-axis value  
  AccZ = (Wire.read() << 8 | Wire.read()) / 16384.0; // Z-axis value  
  // Calculating Roll and Pitch from the accelerometer data  
  accAngleX = (atan(AccY / sqrt(pow(AccX, 2) + pow(AccZ, 2))) * 180 / PI) + 0.28; // AccErrorX ~(0.58) See the calculate_IMU_error()custom function for more details  
  accAngleY = (atan(-1 * AccX / sqrt(pow(AccY, 2) + pow(AccZ, 2))) * 180 / PI) + 7.05; // AccErrorY ~(-1.58)  
  
  // === Read gyroscope data === //  
  previousTime = currentTime;        // Previous time is stored before the actual time read  
  currentTime = millis();            // Current time actual time read  
  elapsedTime = (currentTime - previousTime) / 1000; // Divide by 1000 to get seconds  
  Wire.beginTransmission(MPU);  
  Wire.write(0x43); // Gyro data first register address 0x43  
  Wire.endTransmission(false);  
  Wire.requestFrom(MPU, 6, true); // Read 4 registers total, each axis value is stored in 2 registers  
  GyroX = (Wire.read() << 8 | Wire.read()) / 131.0; // For a 250deg/s range we have to divide first the raw value by 131.0, according to the datasheet  
  GyroY = (Wire.read() << 8 | Wire.read()) / 131.0;  
  GyroZ = (Wire.read() << 8 | Wire.read()) / 131.0;  
  // Correct the outputs with the calculated error values  
  GyroX = GyroX + 1.67; // GyroErrorX ~(-0.56)  
  GyroY = GyroY - 0.18; // GyroErrorY ~(2)  
  GyroZ = GyroZ - 1.07; // GyroErrorZ ~ (-0.8)  
  
  // Currently the raw values are in degrees per seconds, deg/s, so we need to multiply by sendonds (s) to get the angle in degrees  
  gyroAngleX = gyroAngleX + GyroX * elapsedTime; // deg/s * s = deg  
  gyroAngleY = gyroAngleY + GyroY * elapsedTime;  
  yaw =  yaw + GyroZ * elapsedTime;  
  
  // Complementary filter - combine acceleromter and gyro angle values  
  roll = 0.96 * gyroAngleX + 0.04 * accAngleX;  
  pitch = 0.96 * gyroAngleY + 0.04 * accAngleY;  
   
  // Print the values on the serial monitor  
  Serial.print(roll);  
  Serial.print("/");  
  Serial.print(pitch);  
  Serial.print("/");  
  Serial.println(yaw);  
}  
  
  
void calculate_IMU_error() {  
  // We can call this funtion in the setup section to calculate the accelerometer and gyro data error. From here we will get the error values used in the above equations printed on the Serial Monitor.  
  // Note that we should place the IMU flat in order to get the proper values, so that we then can the correct values  
  // Read accelerometer values 200 times  
  while (c < 200) {  
    Wire.beginTransmission(MPU);  
    Wire.write(0x3B);  
    Wire.endTransmission(false);  
    Wire.requestFrom(MPU, 6, true);  
    AccX = (Wire.read() << 8 | Wire.read()) / 16384.0 ;  
    AccY = (Wire.read() << 8 | Wire.read()) / 16384.0 ;  
    AccZ = (Wire.read() << 8 | Wire.read()) / 16384.0 ;  
    // Sum all readings  
    AccErrorX = AccErrorX + ((atan((AccY) / sqrt(pow((AccX), 2) + pow((AccZ), 2))) * 180 / PI));  
    AccErrorY = AccErrorY + ((atan(-1 * (AccX) / sqrt(pow((AccY), 2) + pow((AccZ), 2))) * 180 / PI));  
    c++;  
  }  
  //Divide the sum by 200 to get the error value  
  AccErrorX = AccErrorX / 200;  
  AccErrorY = AccErrorY / 200;  
  c = 0;  
  // Read gyro values 200 times  
  while (c < 200) {  
    Wire.beginTransmission(MPU);  
    Wire.write(0x43);  
    Wire.endTransmission(false);  
    Wire.requestFrom(MPU, 6, true);  
    GyroX = Wire.read() << 8 | Wire.read();  
    GyroY = Wire.read() << 8 | Wire.read();  
    GyroZ = Wire.read() << 8 | Wire.read();  
    // Sum all readings  
    GyroErrorX = GyroErrorX + (GyroX / 131.0);  
    GyroErrorY = GyroErrorY + (GyroY / 131.0);  
    GyroErrorZ = GyroErrorZ + (GyroZ / 131.0);  
    c++;  
  }  
  //Divide the sum by 200 to get the error value  
  GyroErrorX = GyroErrorX / 200;  
  GyroErrorY = GyroErrorY / 200;  
  GyroErrorZ = GyroErrorZ / 200;  
  // Print the error values on the Serial Monitor  
  Serial.print("AccErrorX: ");  
  Serial.println(AccErrorX);  
  Serial.print("AccErrorY: ");  
  Serial.println(AccErrorY);  
  Serial.print("GyroErrorX: ");  
  Serial.println(GyroErrorX);  
  Serial.print("GyroErrorY: ");  
  Serial.println(GyroErrorY);  
  Serial.print("GyroErrorZ: ");  
  Serial.println(GyroErrorZ);  
   
  b4r_main::_gyroerrorx = GyroErrorX;  
  
}  
  
  
#End If
```

  
  
**Processing code:**  

```B4X
/*  
    Arduino and MPU6050 IMU - 3D Visualization Example  
     by Dejan, https://howtomechatronics.com  
*/  
  
import processing.serial.*;  
import java.awt.event.KeyEvent;  
import java.io.IOException;  
  
Serial myPort;  
  
String data="";  
float roll, pitch,yaw;  
  
void setup() {  
    size(800, 600, P3D);  
  myPort = new Serial(this, "COM46", 19200); // starts the serial communication  
  myPort.bufferUntil('\n');  
}  
  
void draw() {  
  translate(width/2, height/2, 0);  
  background(233);  
  textSize(22);  
  fill(0, 0, 0);  
  text("Roll: " + int(roll) + "     Pitch: " + int(pitch) + "     Yaw: " + int(yaw), -100, 265);  
  
  // Rotate the object  
  rotateX(radians(-pitch));  
  rotateZ(radians(roll));  
  rotateY(radians(yaw));  
   
  // 3D 0bject  
  textSize(30);   
  fill(0, 76, 153);  
  box (386, 40, 200); // Draw box  
  textSize(25);  
  fill(255, 255, 255);  
  text("Nano programmed with B4R", -160, 10, 101);  
  
  //delay(10);  
  //println("ypr:\t" + angleX + "\t" + angleY); // Print the values to check whether we are getting proper values  
}  
  
// Read data from the Serial Port  
void serialEvent (Serial myPort) {  
  // reads the data from the Serial Port up to the character '.' and puts it into the String variable "data".  
  data = myPort.readStringUntil('\n');  
  
  // if you got any bytes other than the linefeed:  
  if (data != null) {  
    data = trim(data);  
    // split the string at "/"  
    String items[] = split(data, '/');  
    if (items.length > 1) {  
  
      //— Roll,Pitch in degrees  
      roll = float(items[0]);  
      pitch = float(items[1]);  
      yaw = float(items[2]);  
    }  
  }  
}
```

  
  
Make sure you set the port correctly in the Processing code - my Nano shows as connected to port 46  

```B4X
myPort = new Serial(this, "COM46", 19200); // starts the serial communication
```

  
  
[MEDIA=youtube]8nvLKmM-p\_w[/MEDIA]
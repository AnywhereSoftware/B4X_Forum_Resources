### Visualizing ADXL345 3-axis Accelerometer Pitch and Roll with inline C and Processing by Johan Schoeman
### 02/23/2020
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/113992/)

The attached project is based on this posting:  
<https://howtomechatronics.com/tutorials/arduino/how-to-track-orientation-with-arduino-and-adxl345-accelerometer/>  
  
Have downloaded and installed <https://processing.org/>  
  
[MEDIA=youtube]3nnqaA1D1Jk[/MEDIA]  
  
Steps:  
1. Connect the ADXL345 to your Arduino device (I am using a Nana with I2C comms. The ADXL345's SDA pin goes to A4 and its SCL pin goes to A5 of the Nano  
2. Download and install Processing  
3. Unzip attached sketch\_200215a.zip and copy it to wherever you want (I have it in my B4R sample project folder). The extracted file will be sketch\_200215a.pde  
4. Unzip attached B4R project  
5. Run the B4R project (with your Nano/Uno/etc) connected  
6. Disconnect the serial logging in the Logs tab of the B4R IDE  
7. Double click on sketch\_200215a.pde (after Processing has been installed)  
8. Click the RUN button once the Processing IDE has opened with the sketch  
9. Move the ADXL345 around and see the block moving.  
  
Make sure you set the port correctly in the .pde sketch. My Nano shows as connected to com46  
  

```B4X
  myPort = new Serial(this, "COM46", 115200); // starts the serial communication
```

  
  
**B4R sample code:**  

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
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log("AppStart")  
     
    RunNative("setup1", Null)  
     
    AddLooper("mylooper")  
     
End Sub  
  
Sub myLooper  
     
    RunNative("loop1", Null)  
    Delay(50)  
End Sub  
  
#If C  
  
  
/*  
    Arduino and ADXL345 Accelerometer - 3D Visualization Example  
     by Dejan, https://howtomechatronics.com  
*/  
#include <Wire.h>  // Wire library - used for I2C communication  
  
int ADXL345 = 0x53; // The ADXL345 sensor I2C address  
  
float X_out, Y_out, Z_out;  // Outputs  
float roll,pitch,rollF,pitchF=0;  
  
void setup1(B4R::Object* o) {  
      Serial.begin(115200); // Initiate serial communication for printing the results on the Serial monitor  
     
      Wire.begin(); // Initiate the Wire library  
      // Set ADXL345 in measuring mode  
      Wire.beginTransmission(ADXL345); // Start communicating with the device  
      Wire.write(0x2D); // Access/ talk to POWER_CTL Register - 0x2D  
      // Enable measurement  
      Wire.write(8); // Bit D3 High for measuring enable (8dec -> 0000 1000 binary)  
      Wire.endTransmission();  
      delay(10);  
  
      //Off-set Calibration  
      //X-axis  
      Wire.beginTransmission(ADXL345);  
      Wire.write(0x1E);  
      Wire.write(1);                  //value specifically for the ADXL345 that I am using  
      Wire.endTransmission();  
      delay(10);  
       
      //Y-axis  
      Wire.beginTransmission(ADXL345);  
      Wire.write(0x1F);  
      Wire.write(-2);                //value specifically for the ADXL345 that I am using  
      Wire.endTransmission();  
      delay(10);  
  
      //Z-axis  
      Wire.beginTransmission(ADXL345);  
      Wire.write(0x20);  
      Wire.write(-9);               //value specifically for the ADXL345 that I am using  
      Wire.endTransmission();  
      delay(10);  
}  
  
void loop1(B4R::Object* o) {  
      // === Read acceleromter data === //  
      Wire.beginTransmission(ADXL345);  
      Wire.write(0x32); // Start with register 0x32 (ACCEL_XOUT_H)  
      Wire.endTransmission(false);  
      Wire.requestFrom(ADXL345, 6, true); // Read 6 registers total, each axis value is stored in 2 registers  
      X_out = ( Wire.read() | Wire.read() << 8); // X-axis value  
      X_out = X_out / 256; //For a range of +-2g, we need to divide the raw values by 256, according to the datasheet  
      Y_out = ( Wire.read() | Wire.read() << 8); // Y-axis value  
      Y_out = Y_out / 256;  
      Z_out = ( Wire.read() | Wire.read() << 8); // Z-axis value  
      Z_out = Z_out / 256;  
  
      // Calculate Roll and Pitch (rotation around X-axis, rotation around Y-axis)  
      roll = atan(Y_out / sqrt(pow(X_out, 2) + pow(Z_out, 2))) * 180 / PI;  
      pitch = atan(-1 * X_out / sqrt(pow(Y_out, 2) + pow(Z_out, 2))) * 180 / PI;  
  
      // Low-pass filter  
      rollF = 0.94 * rollF + 0.06 * roll;  
      pitchF = 0.94 * pitchF + 0.06 * pitch;  
  
      Serial.print(rollF);  
      Serial.print("/");  
      Serial.println(pitchF);  
}  
  
  
#End If
```

  
  
**Processing sample code:**  

```B4X
/*  
    Arduino and ADXL345 Accelerometer - 3D Visualization Example  
     by Dejan, https://howtomechatronics.com  
*/  
  
import processing.serial.*;  
import java.awt.event.KeyEvent;  
import java.io.IOException;  
  
Serial myPort;  
  
String data="";  
float roll, pitch;  
  
void setup() {  
  size (960, 640, P3D);  
  myPort = new Serial(this, "COM46", 115200); // starts the serial communication  
  myPort.bufferUntil('\n');  
}  
  
void draw() {  
  translate(width/2, height/2, 0);  
  background(33);  
  textSize(22);  
  text("Roll: " + int(roll) + "     Pitch: " + int(pitch), -100, 265);  
  
  // Rotate the object  
  rotateX(radians(roll));  
  rotateZ(radians(-pitch));  
  
  // 3D 0bject  
  textSize(30);  
  fill(0, 76, 153);  
  box (386, 40, 200); // Draw box  
  textSize(25);  
  fill(255, 255, 255);  
  text("Connected to B4R", -183, 10, 101);  
//  textAlign(CENTER);  
  
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
    }  
  }  
}
```
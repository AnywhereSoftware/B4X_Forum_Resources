### rESP32Servo by rwblinn
### 08/21/2025
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/168330/)

**B4R Library rESP32Servo**  

---

  
  
**Brief  
rESP32Servo** is an open-source servo motor library for **ESP32-based boards only** (ESP8266 and AVR not supported).  
It has been built up-on the B4R internal library rServo (AVR-based boards) and extended for ESP32-based boards by wrapping the library [ESP32Servo](http://madhephaestus.github.io/ESP32Servo/annotated.html).  

---

  
  
**Development Info**  

- Written in C++ (Arduino IDE 2.3.4 and the B4Rh2xml tool).
- Depends on the library ESP32Servo.
- Tested with hardware ESP-WROOM-32 and servos Power HD 1160A, Tower Pro Micro Servo 99.
- Tested with software B4R 4.00 (64-bit), ESP32 board library 3.3.0, ESP32Servo library v3.0.8.

---

  
  
**Files**  
The *rESP32Servo.zip* archive contains the library and sample projects.  

---

  
  
**Install**  
Copy the *rESP32Servo* library folder from the archive into your B4R **Additional Libraries** folder, keeping the folder structure intact.  
*Ensure* the library ESP32Servo is installed using the Arduino IDE libraries manager.  

---

  
  
**Wiring**  

```B4X
Servo = ESP32  
Signal = D4  
VCC = VIn - Note: ESP32 powered 5V USB  
GND = GND
```

  

---

  
  
**Basic Example**  

```B4X
Sub Process_Globals  
    Private Serial1 As Serial  
    Private ANGLE_MIN_POS As UInt = 60  
    Private ANGLE_MAX_POS As UInt = 100  
    Private Servo1 As ESP32Servo  
    Private PinServo As Pin  
    Private SERVO1_PIN_NR As Byte = 4    ' Recommended pin 4 of the ESP32  
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    PinServo.Initialize(SERVO1_PIN_NR, PinServo.MODE_OUTPUT)  
    TestServoEnds(Servo1, SERVO1_PIN_NR, ANGLE_MIN_POS, ANGLE_MAX_POS, 1000)  
End Sub  
  
' Move servo to min and max positions only  
Private Sub TestServoEnds(servo As ESP32Servo, pinNumber As Byte, minAngle As Int, maxAngle As Int, holdTimeMs As Int)  
    Log("[TestServoEnds] Start")  
  
    servo.Attach(pinNumber)  
    Delay(20)  
  
    servo.Write(minAngle)  
    Delay(20)  
    Log("[TestServoEnds] Moved to min angle=", servo.Read)  
    Delay(holdTimeMs)  
  
    servo.Write(maxAngle)  
    Delay(20)  
    Log("[TestServoEnds] Moved to max angle=", servo.Read)  
    Delay(holdTimeMs)  
  
    servo.Write(minAngle)  
    Delay(20)  
    Log("[TestServoEnds] Moved to min angle=", servo.Read)  
    Delay(holdTimeMs)  
  
    servo.Detach  
    Log("[TestServoEnds] Done")  
End Sub
```

  

---

  
  
**Functions**  
Byte Attach(Pin As Int)  
Attaches the servo to the specified pin.  
Returns 0 in case of a failure.  
Recommended GPIO pins:  
ESP32: 2,4,12-19,21-23,25-27,32-33  
ESP32-S2: 1-21,26,33-42  
ESP32-S3: 1-21,35-45,47-48  
ESP32-C3: 1-10,18-21  
   
Byte Attach2(Pin As Int, MinValue As Int, MaxValue As Int)  
Attaches the servo to the specified pin.  
Returns 0 if there was a failure.  
MinValue and MaxValue set the minimum and maximum pulse width that will be sent to the servo.  
   
Detach()  
Detaches the servo pin.  
  
Write(Int Value)  
Set servo angle.  
If the value is smaller than 200 then it is treated as an angle.  
Otherwise it is treated as pulse width in microseconds.  
   
WriteMicroseconds(Value As Int)  
Writes pulse width in microseconds.  
  
WriteTicks(Value As Int)  
Write ticks, the smallest increment the servo can handle.  
   
Read() As Int  
Returns current pulse width as an angle between 0 to 180 degrees.  
   
ReadMicroseconds() As Int  
Returns current pulse width in microseconds.  
   
ReadTicks() As Int  
Returns current ticks, the smallest increment the servo can handle.  
  
Attached() As Boolean  
Returns true if the servo is attached.  
  
TimerWidth As Int  
Set or get the PWM timer width (ESP32 ONLY).  

---

  
  
**Credits**  

- rESP32Servo wrapped from the library [ESP32Servo](http://madhephaestus.github.io/ESP32Servo/annotated.html) by Kevin Harrington, John K. Bennett (GNU Lesser General Public License).
- Anywhere Software for the B4R rServo library (used as a base).

---

  
  
**License**  
MIT License – see LICENSE file.
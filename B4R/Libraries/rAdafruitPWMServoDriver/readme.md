### rAdafruitPWMServoDriver by rwblinn
### 10/04/2025
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/168915/)

**B4R Library rAdafruitPWMServoDriver**  

---

  
  
**Brief  
rAdafruitPWMServoDriver** is an open-source library for **Adafruit 16-channel PWM & Servo driver (PCA9685)**.  
This library is wrapped from the library [Adafruit\_PWMServoDriver library](https://github.com/adafruit/Adafruit-PWM-Servo-Driver-Library).  

---

  
  
**Development Info**  

- Written in C++ (Arduino IDE 2.3.4 and the B4Rh2xml tool).
- Depends on the library Adafruit\_PWMServoDriver.
- Tested with

- Hardware - Arduino UNO, Adafruit 16-Channel 12-bit PWM/Servo Driver - I2C interface - PCA9685, servos Power HD 1160A & Tower Pro Micro Servo 99
- Software - B4R 4.00 (64-bit), Adafruit\_PWMServoDriver library v2.3.2.

- Notes

- Not all wrapped functions tested. Only those used in the examples.
- It is recommended to provide external power for the servos (1A per servo).

![](https://www.b4x.com/android/forum/attachments/167564)  

---

  
  
**Files**  
The *rAdafruitPWMServoDriver-NNN.zip* archive contains the library and sample projects.  

---

  
  
**Install**  
Copy the *rAdafruitPWMServoDriver* library folder from the archive into your B4R **Additional Libraries** folder, keeping the folder structure intact.  
*Ensure* the library Adafruit\_PWMServoDriver library v2.3.2 is installed using the Arduino IDE libraries manager.  

---

  
  
**Wiring**  
Example wiring with 2 servos connected to PCA9685 channels 0 (first) and 15 (last).  
PCA9685 = Arduino  
SDA = A4 (green)  
SCL = A5 (blue)  
OE = Not used  
GND = GND [common] (black)  
VCC = 5V [logic] (orange)  
V+ = External Power 5V (yellow)  
  
PCA9685 = Servo 1 Channel 0  
PWM = Signal  
V+ = VCC  
GND = GND  
  
PCA9685 = Servo 2 Channel 15  
PWM = Signal  
V+ = VCC  
GND = GND  
  
External Power 5V 2A = PCA9685  
1A for each servo.  
V+ = VCC (orange)  
GND = GND (black)  
  
External Power 5V 2A = Arduino  
GND = GND (black)  
  
I2C Address  
PCA9685 default address: 0x40 (change with A0-A5 jumpers)  
  

---

  
  
**Basic Example**  

```B4X
Sub Process_Globals  
    Private ANGLE_MIN_POS As UInt = 0  
    Private ANGLE_MID_POS As UInt = 90  
    Private ANGLE_MAX_POS As UInt = 180      
    Private SERVO_CHANNEL As Byte = 0        ' 0-15  
  
    Public Serial1 As Serial  
    Public PWMServoDriver As AdafruitPWMServoDriver  
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log(CRLF, "=======================================")  
    Log(CRLF, "[Main.AppStart] Initialize")  
  
    ' Init the servo driver  
    PWMServoDriver.Initialize  
   
    ' Set the pwm frequency - analog servos typically run at ~60 Hz  
    PWMServoDriver.SetPWMFreq(PWMServoDriver.PWM_FREQUENCY_DEFAULT)  
  
    ' Set initial position for the servo at mid pos  
    PWMServoDriver.SetAngle(SERVO_CHANNEL, ANGLE_MID_POS, ANGLE_MIN_POS, ANGLE_MAX_POS, True)  
    Delay(2000)  
   
    ' Move test positions  
    CallSubPlus("TestServo", 1, 5)  
   
    Log("[Main.AppStart] Done", CRLF)  
End Sub  
  
' Move servo to min, mid, max, mid positions.  
Private Sub TestServo(Tag As Byte)    'ignore  
    Log("[TestServo] Start")  
    Dim angle As Int  
   
    angle = ANGLE_MIN_POS  
    PWMServoDriver.SetAngle(SERVO_CHANNEL, angle, ANGLE_MIN_POS, ANGLE_MAX_POS, True)  
    Log("[TestServo] set angle=",angle)  
    Delay(2000)  
  
    angle = ANGLE_MID_POS  
    PWMServoDriver.SetAngle(SERVO_CHANNEL, angle, ANGLE_MIN_POS, ANGLE_MAX_POS, True)  
    Log("[TestServo] set angle=",angle)  
    Delay(2000)  
   
    angle = ANGLE_MAX_POS  
    PWMServoDriver.SetAngle(SERVO_CHANNEL, angle, ANGLE_MIN_POS, ANGLE_MAX_POS, True)  
    Log("[TestServo] set angle=",angle)  
    Delay(2000)  
  
    angle = ANGLE_MID_POS  
    PWMServoDriver.SetAngle(SERVO_CHANNEL, angle, ANGLE_MIN_POS, ANGLE_MAX_POS, True)  
    Log("[TestServo] set angle=",angle)  
  
    Log("[TestServo] last angle=",PWMServoDriver.GetAngle(SERVO_CHANNEL))  
  
    Log("[TestServo] Done")  
End Sub
```

  
  

---

  
  
**Functions**  
Initialize()  
Initialize with default I2C address (0x40).  
  
Initialize2(addr As Byte)  
Initialize with a custom I2C address.  
  
Initialize3(Addr As byte, TwoWire &i2c)  
Initialize with a custom I2C address and I2C bus instance.  
  
Reset  
Reset the device to default settings.  
  
Sleep  
Put the device into low-power sleep mode.  
  
Wakeup  
Wake the device from sleep mode.  
  
SetExtClk(Byte prescale)  
Use an external clock source.  
prescale - The prescale value for the external clock.  
  
SetPWMFreq(float freq)  
Set PWM frequency for all channels.  
freq - Frequency in Hz (typical for servos: 50–60 Hz).  
  
SetOutputMode(bool totempole)  
Configure output mode.  
totempole - true for totem pole, false for open drain.  
  
UInt GetPWM(channel As byte, off As Boolean)  
Read PWM on/off values for a given channel.  
channel - Channel channelber (0–15).  
off - When true, returns the "off" value; otherwise, the "on" value.  
Return - The raw PWM counter value.  
  
Byte SetPWM(channel As Byte, on As UInt, off As UInt)  
Set the on/off tick counts for a channel.  
channel - Channel channelber (0–15).  
on - Counter tick when signal goes high.  
off - Counter tick when signal goes low.  
Return - The last written "off" value.  
  
SetPin(channel As Byte, val As UInt, invert As Boolean)  
Set channel output value.  
channel - Channel channelber (0–15).  
val - PWM value (0–4095).  
invert - When true, output is inverted.  
  
Byte ReadPrescale  
Read current prescale value.  
  
WriteMicroseconds(channel As Byte, microseconds As UInt)  
Write pulse length in microseconds to a channel.  
channel - Channel channelber (0–15).  
microseconds - Pulse width in µs.  
  
SetOscillatorFrequency(freq As ULong)  
Set the internal oscillator frequency.  
freq - Frequency in Hz (e.g. 25,000,000).  
  
GetOscillatorFrequency As ULong  
Get the current oscillator frequency in Hz.  
  

---

  
**Custom Functions**  
  
DisablePWM(channel As Byte)  
Disable PWM (servo free, no buzz) by setting pulse length to 0.  
channel - Channel number (0–15).  
  
SetLimits(channel As Byte, minAngle As Byte, maxAngle As Byte)  
Set servo angle min / max limits on a given channel.  
If not used, the defaults are 0°-180°.  
channel - Channel number (0–15).  
minangle - Minimum servo angle (clamped to ANGLE\_MIN).  
minangle - Maximum servo angle (clamped to ANGLE\_MAX).  
   
UInt SetAngle(channel As Byte, angle As UInt, disable As Boolean)  
Set servo angle on a given channel.  
channel - Channel channelber (0–15).  
angle - Desired servo angle (clamped to servo min / max angle).  
disable - Disable PWM (servo free, no buzz).  
Return - Corresponding pulse length (out of 4096).  
  
int GetAngle(channel As Byte)  
Get servo angle on a given channel.  
channel - Channel channelber (0–15).  
Return - Current angle (0-180) or -1 if channel is invalid.  
  
UInt AngleToPulse(angle As UInt)  
Convert angle (0–180°) to PWM pulse length.  
angle - Angle in degrees.  
Return - Corresponding pulse length (out of 4096).  
  
UInt PulseToAngle(microseconds As UInt)  
Convert PWM pulse length to angle (0–180°).  
microseconds - Pulse width in µs.  
Return - Corresponding angle (0-180°). Not 100% accurate +/- 1°.  
  

---

  
  
**Constants**  
  
CHANNELS = 1 - Number of PWM channels (0-15),  
PWM\_FREQUENCY\_DEFAULT = 6 - Default PWM frequency (Analog servos typically run at ~60 Hz).  
SERVO\_MIN = 15 - Minimum pulse length (out of 4096) corresponding to ~0°.  
SERVO\_MAX = 60 - Maximum pulse length (out of 4096) corresponding to ~180°.  
ANGLE\_MIN = 0 - Minimum angle 0°.  
ANGLE\_MAX = 18 - Maximum angle 180°.  
MOVE\_DELAY = 20 - Servo move delay in microseconds.  
  

---

  
  
**Notes & Tips**  
Servo noise/buzzing  
This is expected, as the PCA9685 continuously refreshes PWM.  
If it’s too loud then:  

- Use setPWMFreq(50) for standard analog servos.
- Make sure the MIN\_PULSE/MAX\_PULSE matches the servo specs.
- Optionally cut power (setPWM(channel, 0, 0)) if no need holding torque.

External power sizing (PSU)  

- 5V/2A is fine for 2 small servos.
- If adding more, servos can stall at 1A each, so upgrade the PSU accordingly.

Brownout prevention  

- If the servos draw too much, the Arduino can reset.
- A decoupling capacitor (470–1000 µF) across PCA9685 V+ and GND helps stabilize.

PWM Enabled/Disabled  

- Use DisablePWM(channel) after moving the servo to its target if holding torque isn’t required.
- For applications needing torque (robot arms, RC steering), consider to keep PWM enabled.

---

  
  
**Credits**  
Adafruit Industries for the Adafruit\_PWMServoDriver library.  
  
**Disclaimer**  

- This project is developed for personal use only.
- All examples and code are provided as-is and should be used at your own risk.
- Any guidance provided as-is, without any guarantee or liability for errors, omissions, or wrong configurations.
- Always test thoroughly and exercise caution when connecting hardware components.

**Licenses**  
Original Library (Adafruit) - Copyright © 2012 Adafruit Industries. Licensed under the BSD 3-Clause License (see LICENSE file in the original repository).  
License for this wrapper - Copyright © 2025 Robert W.B. Linn. Licensed unter the MIT License (see LICENSE file).
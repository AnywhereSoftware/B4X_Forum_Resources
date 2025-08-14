### LED lighting PWM control by peacemaker
### 07/11/2025
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/167741/)

Power can be controlled by the PWM (pulse width modulation).  
![](https://www.b4x.com/android/forum/attachments/1751892743173-png.165194/)  
The positive pulse width (duty) on this photo is 55% of 100% full frequency (10 kHz) period. So, 55% of power now is going to the controlled equipment. 0% means the power is off.  
We can try to control the microcontroller's LED: slowly increase the power by PWM and reduce it back to zero.  
[MEDIA=youtube]UklYq9OhE\_0[/MEDIA]  
  
For ESP32-C3 MCU performance i have chosen 8 KHz frequency and 12-bit resolution of the PWM-signal: the control accuracy depends on MCU's speed, high bit-resolution and high frequency need a speedy MCU.  
The other side a low frequency can be heard by ear from the controlled equipment, so better higher than lower.  
  
LED lighting looks for human eye non-linear, so for better smoothing view the gamma correction of the control values is required (3 versions are tried, logarithmic (classic for CRT monitor), quadratic and cubic).  
![](https://www.b4x.com/android/forum/attachments/165273)  
![](https://www.b4x.com/android/forum/attachments/165270)![](https://www.b4x.com/android/forum/attachments/165271)  
  
  

```B4X
'module name: esp_pwm  
  
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'Public variables can be accessed from all modules.  
    Private const PWM_channel As Byte = 0  
    Private const PWM_frequency As ULong = 8000        'chosen for ESP32-C3 MCU performance  
    Private const PWM_resolution_bits As Byte = 12    'chosen for ESP32-C3 MCU performance  
End Sub  
  
Sub InitPWM(pulledHIGH As Boolean)  
    others.ESP.PWM_AttachPin(Main.PinPWMGPIO, PWM_channel, PWM_frequency, PWM_resolution_bits)    'init PWM  
    SweepPWM(Main.PinPWMGPIO, pulledHIGH)  
End Sub  
  
'Slow PWM power control from zero to the full power, and back  
Sub SweepPWM(pin_gpio As Byte, pulledHIGH As Boolean)  
    If pulledHIGH Then  
        Sweep_DOWN(pin_gpio, PWM_resolution_bits)  
        Sweep_UP(pin_gpio, PWM_resolution_bits)  
    Else  
        Sweep_UP(pin_gpio, PWM_resolution_bits)  
        Sweep_DOWN(pin_gpio, PWM_resolution_bits)  
    End If  
End Sub  
  
'changing the power to one direction: 0% … 100%  
Sub Sweep_UP(pin_gpio As Byte, resolution_bits As Byte)  
    Log("SweepUP is started")  
    For percent = 0 To 100  
        Dim duty1 As ULong = others.ESP.PWM_CalculateDuty(percent, resolution_bits)  
        'Dim duty2 As ULong = PWM_GammaCorrected(duty1, resolution_bits, 3.0)  
        Dim duty2 As ULong = PWM_QuadraticGammaCorrected(duty1, resolution_bits)  
        'Dim duty2 As ULong = PWM_CubeGammaCorrected(duty1, resolution_bits)  
        Log(percent, "_", duty1, "_", duty2)  
        others.ESP.PWM_StartPin(pin_gpio, duty2)  
        Delay(30)  
    Next  
    Log("SweepUP is finished")  
End Sub  
  
'changing the power to back direction: 100% … 0%  
Sub Sweep_DOWN(pin_gpio As Byte, resolution_bits As Byte)  
    Log("SweepDOWN is started")  
    For percent = 100 To 0 Step -1  
        Dim duty1 As ULong = others.ESP.PWM_CalculateDuty(percent, resolution_bits)  
        'Dim duty2 As ULong = PWM_GammaCorrected(duty1, resolution_bits, 3.0)  
        Dim duty2 As ULong = PWM_QuadraticGammaCorrected(duty1, resolution_bits)  
        'Dim duty2 As ULong = PWM_CubeGammaCorrected(duty1, resolution_bits)  
        Log(percent, "_", duty1, "_", duty2)  
        others.ESP.PWM_StartPin(pin_gpio, duty2)  
        Delay(30)  
    Next  
    Log("SweepDOWN is finished")  
End Sub  
  
  
'Universal linear gamma correction function for 8-20 bits PWM  
'Parameters:  
' gamma - gamma correction factor (usually 2.2-2.8)  
'linear_duty - initial target PWM duty percent (linear) to be corrected for human eye; resolution_bits - bit resolution of the PWM  
Sub PWM_GammaCorrected(linear_duty As Float, resolution_bits As Byte, gamma As Float) As ULong  
    If (resolution_bits < 8 Or resolution_bits > 20) Then Return 0  'Checking the acceptable range  
   
    Dim maxValue As ULong = Bit.ShiftLeft(1, resolution_bits) - 1  'The maximum value for a given bit rate  
    Dim normalized As Double = linear_duty / maxValue  'Normalizing to 0…1 range  
   
    'Gamma correction with a threshold for very low values (simulated CRT)  
    Dim corrected As Double  
    If (normalized < 0.01) Then  'Setup the threshold  
        corrected = 0.0  
    Else  
        corrected = Power(normalized, gamma)  
    End If  
   
    Return (corrected * maxValue + 0.5)  'Return to the original range with rounding  
End Sub  
  
'Quadratic  
'linear_duty - initial target PWM duty (linear) to be corrected for human eye; resolution_bits - bit resolution of the PWM  
Sub PWM_QuadraticGammaCorrected(linear_duty As ULong, resolution_bits As Byte) As ULong  
    If (resolution_bits < 8 Or resolution_bits > 20) Then Return 0    ''Checking the acceptable range  
    Dim maxValue As ULong = Bit.ShiftLeft(1, resolution_bits) - 1  'The maximum value for a given bit rate  
    If (linear_duty >= maxValue) Then Return maxValue  
   
    Dim result As ULong = (linear_duty + 1) * linear_duty  
    result = BitShiftRight_ULong(result, resolution_bits)  
   
    Return result  
End Sub  
  
'linear_duty - initial target PWM duty (linear) to be corrected for human eye; resolution_bits - bit resolution of the PWM  
Sub PWM_CubeGammaCorrected(linear_duty As Float, resolution_bits As Byte) As ULong  
    If (resolution_bits < 8 Or resolution_bits > 20) Then Return 0  
    Dim shift_amount As Byte = 2 * resolution_bits - 4    'normalized bit range  
    Dim cube As ULong = (linear_duty + 1) * (linear_duty + 1) * linear_duty    'integer-valued cube curve instead of linear  
    'Log("cube = ", cube)  
    Dim result As ULong = BitShiftRight_ULong(cube, shift_amount)    'integer-valued normalizing  
    Return result  
End Sub  
  
'Bitwise shift right the Value to Shift bits  
Sub BitShiftRight_ULong(Value As ULong, Shift As Byte) As ULong  
    If Shift >= 32 Then Return 0  
    If Shift = 0 Then Return Value  
   
    ' Split into two 16-bit parts  
    Dim lowWord As UInt = Bit.And(Value, 0xFFFF)  
    Dim highWord As UInt = (Value - lowWord) / 65536  
   
    If Shift < 16 Then  
        ' Calculate carry bits from high to low  
        Dim carryMask As UInt = Bit.ShiftLeft(1, Shift) - 1  
        Dim carryBits As UInt = Bit.And(highWord, carryMask)  
        carryBits = Bit.ShiftLeft(carryBits, 16 - Shift)  
   
        ' Shift both parts  
        Dim newHigh As UInt = Bit.ShiftRight(highWord, Shift)  
        Dim newLow As UInt = Bit.Or(Bit.ShiftRight(lowWord, Shift), carryBits)  
   
        ' Combine back  
        Return (newHigh * 65536) + newLow  
    Else  
        ' Only shift high word  
        Return Bit.ShiftRight(highWord, Shift - 16)  
    End If  
End Sub
```

  
  
It's used by just call:  
  

```B4X
esp_pwm.InitPWM(True)  'boolean parameter depends on how your LED is connected, controlling by the HIGH or LOW digital level.
```

  
  
pin\_gpio of the MCU must be chosen only if it's able to make PWM, check the MCU datasheet.  
PWM control functions are released in the lib: <https://www.b4x.com/android/forum/threads/esp32extras-library.106766/post-1027832>
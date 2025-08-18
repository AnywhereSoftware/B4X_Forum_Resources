### Using a PIR to rotate a servo (Emulating PIR opening/closing powered doors) by Peter Simpson
### 05/23/2021
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/129410/)

**SubName:** Reading PIR sensor on digital pin 5 to rotate a servo on digital pin 4.  
**Description:** Basically this example is emulating opening and closing powered doors like in a shopping centre (shopping mall), superstore etc.  
  
You can use this simple code to monitor PIR sensors HC-SR501 or HC-SR505 (tested on both). I'm using the PIR to rotate a servo 90° (door will open) for 10 seconds by using a timer. As long as the PIR sensor senses motion, the servo will stay rotated at 90° (door open). When the PIR sensor no longer senses motion the servo will rotate back to 0° (door closed). If whilst the servo is rotating back to 0° (door is closing) the PIR sensor suddenly detects motion again, the servo will instantly stop rotating (stop closing the door) and the servo will reverse direction (opening the door again).  
  
**PLEASE NOTE:** There are many ways to achieve the same results, using a timer is just one way.  
  
[SPOILER="Walking towards PIR results"]  
\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\* PROGRAM STARTING \*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*  
AppStart  
Door closed - 0°  
Update in 1000ms  
Door closed - 0°  
Update in 1000ms  
Door closed - 0°  
Update in 1000ms  
Door closed - 0°  
Update in 1000ms  
Door open - 90°  
Update in 10000ms  
Door open - 90°  
Update in 10000ms  
Door closed - 0°  
Update in 1000ms  
Door closed - 0°  
Update in 1000ms  
Door closed - 0°  
Update in 1000ms  
Door closed - 0°  
Update in 1000ms  
Door closed - 0°  
Update in 1000ms  
Door open - 90°  
Update in 10000ms  
[/SPOILER]  
  
**Libraries needed:**  
![](https://www.b4x.com/android/forum/attachments/111084)  
  

```B4X
'WIRE LEGEND Servo and PIR  
'GND = GND  
'VCC = 5V  
'Servo s = Digital Pin 4  
'PIR s = Digital Pin 5  
  
'*************************  
'***     BOARD TYPE    ***  
'***        UNO        ***  
'*************************  
  
Sub Process_Globals  
    Public Serial1 As Serial  
    Private Const ServoSpeedDelay = 40, ServoAngle = 90 As Int    'Servo rotation delay speed, Servo opening angle  
  
    Private Servo, PIR, LED As Pin  
    Private SrvDoor As Servo  
    Private TmrPIRSense As Timer  
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log("AppStart")  
  
    Servo.Initialize(4, Servo.MODE_INPUT)    'Servo on Pin 4  
    SrvDoor.Attach(Servo.PinNumber)  
    SrvDoor.Write(0)  
  
    PIR.Initialize(5, PIR.MODE_INPUT)        'PIR on Pin 5  
    LED.Initialize(13, LED.MODE_OUTPUT)        'UNO LED on Pin 13  
  
    TmrPIRSense.Initialize("PIRSense_Tick", 1000)    'Set the timer to check for motion every 1 second  
    TmrPIRSense.Enabled = True                        'Enable the timer  
End Sub  
  
Sub PIRSense_Tick  
    TmrPIRSense.Enabled = False                'Disable the timer  
    If PIR.DigitalRead Then                    'Check for motion  
        LED.DigitalWrite(True)                'Turn LED On when the door is open  
        TmrPIRSense.Interval = 10000        'Set the timer to 10 seconds (People are walking through the door)  
        Do While SrvDoor.Read < ServoAngle    'Check servo angle/door  
            Delay(ServoSpeedDelay)            'Delay to slow down the servo speed (Door opening speed)  
            SrvDoor.Write(SrvDoor.Read + 1)    'Rotate the servo (Open the door)  
        Loop  
    Else  
        LED.DigitalWrite(False)                'Turn LED Off when the door is closed  
        TmrPIRSense.Interval = 1000            'Set the timer back to 1 second      
        Do While SrvDoor.Read > 0            'Check servo angle  
            If PIR.DigitalRead Then            'If motion sensed whilst servo(door) is closing then EMERGENCY…  
                TmrPIRSense.Interval = 0    'Set the timer to open the door instantly  
                TmrPIRSense.Enabled = True    'Enable the timer  
                Return                        'SAFETY STOP - Jump out of the sub to stop closing the door  
            End If  
            Delay(ServoSpeedDelay)            'Delay to slow down the servo speed (Door closing speed)  
            SrvDoor.Write(SrvDoor.Read - 1)    'Rotate the servo (Close the door)  
        Loop  
    End If  
    TmrPIRSense.Enabled = True                'Enable the timer  
  
    If SrvDoor.Read = 0 Then Log("Door closed - ", SrvDoor.Read, "°") Else Log("Door open - ", SrvDoor.Read, "°")  
    Log("Update in ", TmrPIRSense.Interval, "ms")  
End Sub
```

  
  
**Arduino wiring**  
![](https://www.b4x.com/android/forum/attachments/111074)  
  
**Tested on both the HC-SR505 and HC-SR501 PIR Sensors**  
![](https://www.b4x.com/android/forum/attachments/111116)  
  
  
**Enjoy…**
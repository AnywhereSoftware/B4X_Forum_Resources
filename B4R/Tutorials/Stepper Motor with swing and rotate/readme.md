### Stepper Motor with swing and rotate by Mark Read
### 07/24/2020
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/120531/)

Here is some code to demonstrate using a single stepper motor, an Uno, the Adafruit Motor Shield and a three-way switch. The middle position of the switch is OFF. One side rotates the motor until stopped and the other side rotates the motor ±45°. I built this with one of my students to allow honeycombs to be dried. Sorry I cannot show a picture of the finished product ?.  
  
Power is from a 9V, 3A supply which is also converted to 5V for the Uno. The switch is connected with screw connectors mounted directly on the motor shield.  
  

```B4X
Build1=Default,B4RDev  
Group=Default Group  
Library1=rcore  
Library2=radafruitmotorshieldv2  
NumberOfFiles=0  
NumberOfLibraries=2  
NumberOfModules=0  
Version=3.31  
@EndOfDesignText@  
  
#Region Project Attributes  
    #AutoFlushLogs: True  
    #CheckArrayBounds: True  
    #StackBufferSize: 600  
#End Region  
  
#Region  
'A0 on Uno    Swing from switch  
'A1 on Uno    Rotate from switch  
  
'Adafruit Motor Shield v2  
  
'Motor RS-Components 191-8328 Nema 23 5V  
  
'Power 9V 3A  
  
'Micro stepping set to 16 steps!  
  
#End Region  
  
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'Public variables can be accessed from all modules.  
    Public Serial1 As Serial  
     
    'Variables for the motor control  
    Dim mshield As AdafruitMotorShield  
    Dim stepper1 As AdafruitStepperMotor  
    Dim MotorTimer, SwingTimer As Timer  
    Dim Steps As Int  
    Dim TimeDelay As Int  
    Dim SwingPin, RotatePin As Pin  
    Dim SwingPinState As Boolean  
    Dim RPM, Angle As Int  
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log("AppStart")  
     
    'Prepare analog inputs  
    'Using the internal pull up resistor to prevent the pin from floating.  
    SwingPin.Initialize(SwingPin.A0, SwingPin.MODE_INPUT_PULLUP)  
    SwingPin.AddListener("SwingPin_StateChanged")  
    RotatePin.Initialize(RotatePin.A1, RotatePin.MODE_INPUT_PULLUP)  
    RotatePin.AddListener("RotatePin_StateChanged")  
         
    'calculate steps for swing  
    'based on ±45°    =    25 steps  
    Angle=45  
    Steps=Angle*200/360  
         
    'initialise shield  
    mshield.Initialize(0x60, 1600) 'default values  
    stepper1.Initialize(mshield, 200, 1)  
     
    'Set motor speed  
    RPM=6  
    stepper1.Speed=RPM  
     
    'calculate delay for speed  
    'speed is 1 revolution in 10 seconds  
    'TimeDelay is in milliseconds  
    TimeDelay=1000*60/(RPM*200)    '10 seconds = 50 ms  
    MotorTimer.Initialize("MotorTimer_Tick", TimeDelay)  
    SwingTimer.Initialize("SwingTimer_Tick", TimeDelay*100)  
     
End Sub  
  
Sub MotorTimer_Tick  
    'Log("Motor step")  
    stepper1.OneStep(stepper1.DIR_FORWARD, stepper1.STYLE_MICROSTEP)  
End Sub  
  
Sub SwingTimer_Tick  
    'Log("Case 1")  
    'stepper1.OneStep(stepper1.DIR_FORWARD, stepper1.STYLE_MICROSTEP)  
    stepper1.Step(Steps,stepper1.DIR_FORWARD, stepper1.STYLE_MICROSTEP)  
    'Log("Case 2")  
    'stepper1.OneStep(stepper1.DIR_BACKWARD, stepper1.STYLE_MICROSTEP)  
    stepper1.Step(Steps*2,stepper1.DIR_BACKWARD, stepper1.STYLE_MICROSTEP)  
    'Log("Case 3")  
    'stepper1.OneStep(stepper1.DIR_FORWARD, stepper1.STYLE_MICROSTEP)  
    stepper1.Step(Steps,stepper1.DIR_FORWARD, stepper1.STYLE_MICROSTEP)  
  
End Sub  
  
'state will be False when the switch is on because of the PULLUP mode.  
Sub SwingPin_StateChanged (State As Boolean)  
    Log("Swing state = ", State)  
    SwingPinState=State  
    Log("SwingPinstate = ", SwingPinState)  
     
    If SwingPinState=True Then  
        'turn off motor  
        Log("Swing stop")  
        SwingTimer.Enabled=False  
        stepper1.Release  
    Else  
        Log("Swing start")  
        SwingTimer.Enabled=True  
    End If  
     
End Sub  
  
  
'state will be False when the switch is on because of the PULLUP mode.  
Sub RotatePin_StateChanged (State As Boolean)  
    Log("Rotate state = ", State)  
    If State=True Then  
        'turn off motor  
        MotorTimer.Enabled=False  
        stepper1.Release  
    Else  
        MotorTimer.Enabled=True  
    End If  
     
End Sub
```

  
  
![](https://www.b4x.com/android/forum/attachments/97557)
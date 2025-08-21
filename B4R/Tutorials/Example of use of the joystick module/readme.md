### Example of use of the joystick module by WebQuest
### 04/13/2020
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/116266/)

Looking in the tutorial section of B4R I noticed that there was no example of how to connect and use the joystick module. So here is an example  

```B4X
Joystick Module MH / pin  
  
 green : GND  
   Red : +5V  
Yellow : VRX  
 Black : VRY
```

  
  
![](https://www.b4x.com/android/forum/attachments/91711)  

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
    Private btn As Pin  
    Private pinledgreen As Pin  
    Private pinledRed As Pin  
    Private pinledYellow As Pin  
      
    Dim timer1 As Timer  
    Dim timer2 As Timer  
    Dim timer3 As Timer  
      
    Dim Mode1 As Int=0  
    Dim Mode2 As Int=0  
    Dim set1 As Int=0  
    Dim set2 As Int=0  
      
    Private lightOnR=False As Boolean  
    Private lightOnG=False As Boolean  
    Private lightOnV=False As Boolean  
      
    Private Switch, VRx, VRy As Pin  
    Private timerloop As Timer  
  
End Sub  
  
Private Sub AppStart  
      
    Serial1.Initialize(115200)  
    Log("AppStart")  
      
    'inizializzazione Timer  
    timer1.Initialize("timer1_tick",500)  
    timer2.Initialize("timer2_tick",500)  
    timer3.Initialize("timer3_tick",500)  
  
    'inizializzazione btn  
    btn.Initialize(btn.A5, btn.MODE_INPUT_PULLUP)  
    btn.AddListener("btn_StateChanged")  
      
    'inizializzazione led  
    pinledgreen.Initialize(9,pinledgreen.MODE_OUTPUT)  
    pinledYellow.Initialize(8,pinledYellow.MODE_OUTPUT)  
    pinledRed.Initialize(7,pinledRed.MODE_OUTPUT)  
    pinledgreen.DigitalWrite(False)  
    pinledYellow.DigitalWrite(False)  
    pinledRed.DigitalWrite(False)  
      
    'inizializzazione Module Joystick  
    Switch.Initialize(2, Switch.MODE_INPUT_PULLUP)  
    VRx.Initialize(VRx.A0, VRx.MODE_INPUT)  
    VRy.Initialize(VRy.A1, VRy.MODE_INPUT)  
    timerloop.Initialize("timerLoop_Tick", 250)  
    timerloop.Enabled = True  
  
End Sub  
  
Sub TimerLoop_tick  
      
    Log("X = ", VRx.AnalogRead)  
    Log("Y = ", VRy.AnalogRead)  
    Log("Button = ", Switch.DigitalRead)  
    If VRy.AnalogRead>512 And lightOnV=False And lightOnG=True And lightOnR=False Then  
        lightOnG=False  
        pinledYellow.DigitalWrite(False)  
        lightOnV=True  
        pinledgreen.DigitalWrite(True)  
        set1=1  
    End If  
    If VRy.AnalogRead>512 And lightOnV=False And lightOnG=False And lightOnR=True And set1=0 Then  
        lightOnR=False  
        pinledRed.DigitalWrite(False)  
        lightOnG=True  
        pinledYellow.DigitalWrite(True)  
          
    End If  
    If VRy.AnalogRead>512  And lightOnV=True And lightOnG=False And lightOnR=False And set1=0 Then  
        lightOnR=True  
        pinledRed.DigitalWrite(True)  
        lightOnV=False  
        pinledgreen.DigitalWrite(False)  
    End If  
      
    '/////////////////////////////////////Returns////////////////////////////////////////////////////////  
      
    If VRy.AnalogRead<511 And lightOnV=False And lightOnG=True And lightOnR=False Then  
        lightOnG=False  
        pinledYellow.DigitalWrite(False)  
        lightOnR=True  
        pinledRed.DigitalWrite(True)  
        set2=1  
        set1=0  
    End If  
      
    If VRy.AnalogRead<511  And lightOnV=True And lightOnG=False And lightOnR=False Then  
        lightOnG=True  
        pinledYellow.DigitalWrite(True)  
        lightOnV=False  
        pinledgreen.DigitalWrite(False)  
          
    End If  
      
      
    If VRy.AnalogRead>512 And lightOnV=False And lightOnG=False And lightOnR=True And set2=0 Then  
        lightOnR=False  
        pinledRed.DigitalWrite(False)  
        lightOnG=True  
        pinledYellow.DigitalWrite(True)  
    End If  
      
      
End Sub  
  
Sub timer1_tick  
      
    lightOnR=True  
    pinledRed.DigitalWrite(True)  
    lightOnG=False  
    pinledYellow.DigitalWrite(False)  
    lightOnV=False  
    pinledgreen.DigitalWrite(False)  
      
    timer3.Enabled=False  
    timer2.Enabled=True  
      
End Sub  
  
Sub timer2_tick  
      
    lightOnR=False  
    pinledRed.DigitalWrite(False)  
    lightOnG=True  
    pinledYellow.DigitalWrite(True)  
    lightOnV=False  
    pinledgreen.DigitalWrite(False)  
      
    timer1.Enabled=False  
    timer3.Enabled=True  
      
End Sub  
  
Sub timer3_tick  
      
    lightOnR=False  
    pinledRed.DigitalWrite(False)  
    lightOnG=False  
    pinledYellow.DigitalWrite(False)  
    lightOnV=True  
    pinledgreen.DigitalWrite(True)  
  
    timer2.Enabled=False  
    timer1.Enabled=True  
      
End Sub  
  
Sub btn_StateChanged (State As Boolean)  
      
    If State =False Then  
        If Mode2=1 Then  
            timer1.Enabled=False  
            timer2.Enabled=False  
            timer3.Enabled=False  
            lightOnR=True  
            pinledRed.DigitalWrite(True)  
            lightOnG=False  
            pinledYellow.DigitalWrite(False)  
            lightOnV=False  
            pinledgreen.DigitalWrite(False)  
            Mode2=1  
        End If  
    End If  
    If State =False Then  
        If Mode1=0 Then  
        timer1.Enabled=True  
        Mode1=1  
        Mode2=1  
        End If  
    End If  
    Log("state : ",State)  
      
End Sub
```

  
  
  
[MEDIA=youtube]qiKWnMnoYGQ[/MEDIA]
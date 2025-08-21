### B4R Vibration Sensor (shake switch) by inakigarm
### 10/25/2019
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/110795/)

So long that I haven't played with B4R ! Today I want to test a vibration sensor (it's on a closed case yet)   
The sensor signals when a sensor shake happens. It's a simple sensor (detected/not detected) and a simple circuit.  
  
**Sensor**  
  
![](https://www.b4x.com/android/forum/attachments/84924)  
  
**Circuit**  
  
![](https://www.b4x.com/android/forum/attachments/84921)  
 **Code:**  

```B4X
Sub Process_Globals  
    Public Serial1 As Serial  
    Private ip,op As Pin  
    Public timepassed,timeactual As ULong  
      
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log("AppStart")  
    ip.Initialize (6, ip.MODE_INPUT)  
    op.Initialize (7, op.MODE_OUTPUT)  
    op.DigitalWrite(False)  
    ip.AddListener("Change_state")       
End Sub  
  
Sub Change_state (State As Boolean)  
    timeactual=Millis  
    
    Select Case State  
        Case True             
            Log("state: Detected")  
            Do While timeactual-timepassed < 400  
                timeactual=Millis  
            Loop  
            op.DigitalWrite(Not(State))  
        Case False  
            Log("state: Not Detected")  
            op.DigitalWrite(Not(State))             
    End Select  
      
    timepassed=Millis     
End Sub
```

  
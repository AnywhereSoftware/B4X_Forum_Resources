### rAutoPID for B4R by candide
### 06/15/2024
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/161674/)

this is a wrapper for AutoPID from <https://github.com/r-downing/AutoPID>  
  
some modifications were done in original library to work with B4R with "float" because "double" is not managed by B4R  
  
=> input, setpoint and output must be ArrayDouble global variables with 1 element to be modified directly by the library  
  
example :

```B4X
Sub Process_Globals  
    Private AutoPID As AutoPID      
    Public input(1) As Double   
    Public setpoint(1) As Double  
    Public output(1) As Double   
    Private outputMin, outputMax, Kp, Ki, Kd As Double  
End Sub  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log("AppStart")  
    outputMin=0 : outputMax=20000  
    Kp=0: Ki=5: Kd=50  
    input(0)=20.1  :setpoint(0)=12.2  :output(0)=0.25  
    AutoPID.Initialize(input,setpoint,output,outputMin,outputMax,Kp,Ki,Kd)   
    AutoPID.setTimeStep(200)  
End Sub
```
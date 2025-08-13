### Pi4J2 - Raspberry Pi I/O library by Erel
### 06/26/2023
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/136113/)

At some point during 2019, the author of wiringpi, which is the native library that Pi4J was based on, [stopped its development](http://wiringpi.com/wiringpi-deprecated/).  
  
Luckily, there is a new version of Pi4J which is now being actively developed and it works with all recent versions of Raspberry Pi. It is not backward compatible.  
  
jPi4J2 wraps the new [Pi4J2 library](https://pi4j.com/). Currently only DigitalInput and DigitalOutput types are exposed.   
  
Blink example:  

```B4X
Sub Process_Globals  
    Private pi4j As Pi4J  
    Private PinOut As DigitalOutput  
End Sub  
  
Sub AppStart (Args() As String)  
    Log("Hello world!!!")  
    Start  
    StartMessageLoop  
End Sub  
  
Private Sub Start  
    pi4j.Initialize("pi4j")  
    PinOut.Initialize(pi4j, 2) 'BCM addresses: https://pi4j.com/documentation/pin-numbering/  
    Do While True  
        PinOut.State = Not(PinOut.State)  
        Sleep(1000)  
    Loop  
End Sub
```

  
  
Input example:  

```B4X
Sub Process_Globals  
    Private pi4j As Pi4J  
    Private PinIn As DigitalInput  
End Sub  
  
Sub AppStart (Args() As String)  
    Log("Hello world!!!")  
    Start  
    StartMessageLoop  
End Sub  
  
Private Sub Start  
    pi4j.Initialize("pi4j")  
    PinIn.Initialize(pi4j, "PinIn", 2, "PULL_DOWN", 3000)  
End Sub  
  
Private Sub PinIn_StateChange (State As Boolean)  
    Log("New state: " & State)  
End Sub
```

  
  
Note that it requires Java 11+.  
You can install it with:  

```B4X
sudo apt install default-jdk
```

  
And it is recommended to use B4J-Bridge:  

```B4X
wget www.b4x.com/b4j/files/b4j-bridge.jar  
sudo java -jar b4j-bridge.jar
```
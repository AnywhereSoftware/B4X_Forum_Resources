### [IoT] jPi4J - Raspberry Pi GPIO controller by Erel
### 06/26/2023
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/37493/)

**Updated libraries: <https://www.b4x.com/android/forum/threads/pi4j2-raspberry-pi-i-o-library.136113/#content>**  
  
This is a wrapper for [Pi4J library](http://pi4j.com/index.html).  
It allows you are control the Raspberry Pi board GPIO pins.  
  
Using this library is quite simple. You can use it from a UI app or non-UI app.  
  
First you should initialize a GpioController object.  
The second step is to initialize one or more pins.  
  
You can provision each pin to be an input pin or output pin. Input pins allow you to listen for state changes. Output pins allow you to set their state.  
  
The following program initializes two pins. Pin1 is an input pin and pin2 is an output pin. Pin2 state is changed every 5 seconds with a timer:  

```B4X
'Non-UI application (console application)  
#Region  Project Attributes  
   #CommandLineArgs:  
   #MergeLibraries: true  
#End Region  
  
Sub Process_Globals  
   Private controller As GpioController  
   Private Pin2 As GpioPinDigitalInput  
   Private Pin1 As GpioPinDigitalOutput  
   Private Timer1 As Timer  
End Sub  
  
Sub AppStart (Args() As String)  
   controller.Initialize  
   Pin1.Initialize(1, True) 'GpioPinDigitalOutput  
   Pin2.Initialize("Pin2", 2) 'GpioPinDigitalInput  
   Pin2.SetPinPullResistance("PULL_DOWN")  
  
   Log("Monitoring Pin2 state")  
   Timer1.Initialize("Timer1", 5000)  
   Timer1.Enabled = True  
   StartMessageLoop  
End Sub  
  
Sub Timer1_Tick  
   Pin1.State = Not(Pin1.State)  
   Log("Switching Pin1 state. Pin1 state = " & Pin1.State)  
End Sub  
  
Sub Pin2_StateChange(State As Boolean)  
   Log("Pin2 StateChange event: " & State)  
End Sub
```

  
  
The pins scheme is available here: <http://pi4j.com/usage.html>  
  
The output of this program:  
![](http://www.b4x.com/basic4android/images/SS-2014-02-05_14.09.17.png)  
  
B4J-Bridge is very useful when working with this board: <http://www.b4x.com/android/forum/threads/remote-debugging-with-b4j-bridge.38804/>  
You can download it to the board with this command:  

```B4X
wget https://www.b4x.com/b4j/files/b4j-bridge.jar
```

  
**Then run it as root:**  

```B4X
sudo <path to java> -jar b4j-bridge.jar
```

  
  
![](http://www.b4x.com/basic4android/images/SS-2014-03-25_12.42.39.png)  
  
  
**PiFace extension**  
  
V1.00 adds support for the PiFace extension: <http://www.savagehomeautomation.com/piface>  
  
[media=youtube]d3KFhNsDKQ4[/media]  
  
See this post: <http://www.b4x.com/android/forum/threads/jpi4j-raspberry-pi-gpio-controller.37493/#post-232767>  
  
Download link: [www.b4x.com/b4j/files/jPi4J.zip](https://www.b4x.com/b4j/files/jPi4J.zip)
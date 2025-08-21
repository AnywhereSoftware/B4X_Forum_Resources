### ADXL345 Triple Axis Accelerometer Library by Johan Schoeman
### 02/01/2020
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/113559/)

A wrap for [**this Github project**](https://github.com/sparkfun/SparkFun_ADXL345_Arduino_Library) - have wrapped most of the "setters". I am using an ADXL345 module (Keyestudio) and an Arduino Nano.  

```B4X
'Nano/Uno    -    ADXL345 module  
'A4            -    SDA  
'A5            -    SCL  
'ADXL345 module 5V and GND connected to Nano/Uno 5V and GND
```

  
  
Attached B4R project is set up for I2C comms with the ADXL345 module (pins A4 = SDA and A5 = SCL on the Nano/Uno)  
  
I guess one will need to do a whole lot of reading to figure out what to do with the settings and returned values of all the methods. But the wrapper attached B4A project seems to yield the same returned values as that of the sample project in the Github posting when running it from the Arduino IDE. So, I guess it must be "doing it's thing".  
  
Sample code:  

```B4X
'Nano/Uno    -    ADXL345 module  
'A4            -    SDA  
'A5            -    SCL  
'ADXL345 module 5V and GND connected to Nano/Uno 5V and GND  
  
#Region Project Attributes  
    #AutoFlushLogs: True  
    #CheckArrayBounds: True  
    #StackBufferSize: 300  
#End Region  
  
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'Public variables can be accessed from all modules.  
    Public Serial1 As Serial  
     
    Dim adxl As ADXL345  
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log("AppStart")  
  
    adxl.InitializeI2C  
    adxl.powerOn  
    adxl.RangeSetting = adxl.RANGE_16G  
    adxl.setActivityXYZ(True, False, False)  
    adxl.ActivityThreshold = 75  
     
    adxl.setInactivityXYZ(True, True, True)  
    adxl.InactivityThreshold = 75  
     
    adxl.TimeInactivity = 3  
    adxl.setTapDetectionOnXYZ(False, False, True)  
     
    adxl.TapThreshold = 50  
    adxl.TapDuration = 15  
     
    adxl.DoubleTapLatency = 80  
     
    adxl.DoubleTapWindow = 200  
     
    adxl.FreeFallThreshold = 7  
    adxl.FreeFallDuration = 5  
     
    adxl.LowPower = False  
     
    adxl.ActivityINT(True)  
    adxl.doubleTapINT(True)  
    adxl.InactivityINT(True)  
    adxl.singleTapINT(True)  
    adxl.FreeFallINT(True)  
    AddLooper("myLooper")  
     
End Sub  
  
Sub myLooper  
  
    adxl.readAccel  
     
    Log("x accel = ", adxl.X_Accel)  
    Log("y accel = ", adxl.Y_Accel)  
    Log("z accel = ", adxl.Z_Accel)  
    Log(" ")  
    Delay(1000)  
     
    Dim interrputs As Byte = adxl.InterruptSource  
    Log("interrputsource = ", interrputs)  
     
    If adxl.triggered(interrputs, adxl.MASK_ADXL345_FREE_FALL) Then  
        Log("*** FREE FALL ***")  
    End If    
     
    If adxl.triggered(interrputs, adxl.MASK_ADXL345_DOUBLE_TAP) Then  
        Log("*** DOUBLE TAP ***")  
    End If  
     
    If adxl.triggered(interrputs, adxl.MASK_ADXL345_INACTIVITY) Then  
        Log("*** INACTIVITY ***")  
    End If  
     
    If adxl.triggered(interrputs, adxl.MASK_ADXL345_ACTIVITY) Then  
        Log("*** ACTIVITY ***")  
    End If  
     
    If adxl.triggered(interrputs, adxl.MASK_ADXL345_SINGLE_TAP) Then  
        Log("*** SINGLE TAP ***")  
    End If  
     
    Log("isActivityXEnabled = ", adxl.isActivityXEnabled)  
    Log("isActivityYEnabled = ", adxl.isActivityYEnabled)  
    Log("isActivityZEnabled = ", adxl.isActivityZEnabled)  
     
    Log("isInactivityXEnabled = ", adxl.isInactivityXEnabled)  
    Log("isInactivityYEnabled = ", adxl.isInactivityYEnabled)  
    Log("isInactivityZEnabled = ", adxl.isInactivityZEnabled)  
     
    Log("isActivitySourceOnX = ", adxl.isActivitySourceOnX)  
    Log("isActivitySourceOnY = ", adxl.isActivitySourceOnY)  
    Log("isActivitySourceOnZ = ", adxl.isActivitySourceOnZ)  
  
    Log("isTapSourceOnX = ", adxl.isTapSourceOnX)  
    Log("isTapSourceOnY = ", adxl.isTapSourceOnY)  
    Log("isTapSourceOnZ = ", adxl.isTapSourceOnZ)  
     
    Log("isAsleep = ", adxl.isAsleep)  
    Log("isLowPower = ", adxl.isLowPower)  
     
    Log(" ")  
    adxl.printAllRegister  
    Log(" ")  
     
     
     
End Sub
```

  
  
Extract folder rSparkFun\_ADXL345 from attached rSparkFun\_ADXL345.zip and copy the folder and its contents to your B4R additional library folder.  
The attached rSparkFun\_ADXL345.zip also contains rSparkFun\_ADXL345.xml - copy it to the root of your B4R additional library folder  
B4R sample project attached.  
  
Enjoy!
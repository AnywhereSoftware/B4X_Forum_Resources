### rXDM - Set Analog Resolutions (Read/Write) in Seeeduino XIAO and Arduino Due, Arduino Maker by hatzisn
### 12/02/2020
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/125114/)

This b4xlib library is indented for use with the boards Seeeduino XIAO, Arduino Due, Arduino Maker. This is because the setting of analogReadResolution and analogWriteResolution function is available only in these boards. IT WILL NOT WORK WITH OTHER BOARDS.  
  
In order to install in your Arduino IDE the Seeeduino Xiao Board please visit the following link:  
<https://dronebotworkshop.com/seeeduino-xiao-intro/>  
  
Usage:  

```B4X
Private Sub AppStart  
    Serial1.Initialize(9600)  
    Log("AppStart")  
    XDM.SetAnalogReadResolution(12)  
    XDM.SetAnalogWriteResolution(10)  
End Sub
```

  
  
Have fun guys
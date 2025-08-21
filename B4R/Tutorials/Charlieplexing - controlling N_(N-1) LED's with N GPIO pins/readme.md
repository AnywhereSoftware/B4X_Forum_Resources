### Charlieplexing - controlling N*(N-1) LED's with N GPIO pins by Johan Schoeman
### 11/22/2019
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/111607/)

It is based on [**this posting**](https://circuitdigest.com/microcontroller-projects/charlieplexing-arduino-to-control-12-leds-with-4-gpio-pins). I am using an Arduino Nano to control the 12 LEDs using pins 8, 9, 10, and 11 of the Nano. Just thought it would be interesting to give Charlieplexing a go. Working very nicely…:)  
  
![](https://www.b4x.com/android/forum/attachments/85762)  
  
  
![](https://www.b4x.com/android/forum/attachments/85763)  
  

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
      
    Dim p8, p9, p10, p11 As Pin  
      
    Dim t As Timer  
    Dim cnt As Int  
      
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log("AppStart")  
      
    cnt = 0  
      
    p8.Initialize(8, p8.MODE_OUTPUT)  
    p9.Initialize(9, p9.MODE_OUTPUT)  
    p10.Initialize(10, p10.MODE_OUTPUT)  
    p11.Initialize(11, p11.MODE_OUTPUT)  
    t.Initialize("t_tick", 50)  
      
    t.Enabled = True  
End Sub  
  
  
Sub t_tick  
      
    cnt = cnt + 1  
    If cnt = 13 Then cnt = 1  
    If cnt = 1 Then  
        p8.Initialize(8, p8.MODE_OUTPUT)  
        p9.Initialize(9, p9.MODE_OUTPUT)  
        p10.Initialize(10, p10.MODE_INPUT)  
        p11.Initialize(11, p11.MODE_INPUT)  
        p8.DigitalWrite(True)  
        p9.DigitalWrite(False)  
    End If  
      
    If cnt = 2 Then  
        p8.Initialize(8, p8.MODE_OUTPUT)  
        p9.Initialize(9, p9.MODE_OUTPUT)  
        p10.Initialize(10, p10.MODE_INPUT)  
        p11.Initialize(11, p11.MODE_INPUT)  
        p8.DigitalWrite(False)  
        p9.DigitalWrite(True)  
    End If  
      
    If cnt = 3 Then  
        p8.Initialize(8, p8.MODE_INPUT)  
        p9.Initialize(9, p9.MODE_OUTPUT)  
        p10.Initialize(10, p10.MODE_OUTPUT)  
        p11.Initialize(11, p11.MODE_INPUT)  
        p9.DigitalWrite(True)  
        p10.DigitalWrite(False)  
    End If  
      
    If cnt = 4 Then  
        p8.Initialize(8, p8.MODE_INPUT)  
        p9.Initialize(9, p9.MODE_OUTPUT)  
        p10.Initialize(10, p10.MODE_OUTPUT)  
        p11.Initialize(11, p11.MODE_INPUT)  
        p9.DigitalWrite(False)  
        p10.DigitalWrite(True)  
    End If  
      
    If cnt = 5 Then  
        p8.Initialize(8, p8.MODE_INPUT)  
        p9.Initialize(9, p9.MODE_INPUT)  
        p10.Initialize(10, p10.MODE_OUTPUT)  
        p11.Initialize(11, p11.MODE_OUTPUT)  
        p10.DigitalWrite(True)  
        p11.DigitalWrite(False)  
    End If  
      
    If cnt = 6 Then  
        p8.Initialize(8, p8.MODE_INPUT)  
        p9.Initialize(9, p9.MODE_INPUT)  
        p10.Initialize(10, p10.MODE_OUTPUT)  
        p11.Initialize(11, p11.MODE_OUTPUT)  
        p10.DigitalWrite(False)  
        p11.DigitalWrite(True)  
    End If  
      
    If cnt = 7 Then  
        p8.Initialize(8, p8.MODE_OUTPUT)  
        p9.Initialize(9, p9.MODE_INPUT)  
        p10.Initialize(10, p10.MODE_OUTPUT)  
        p11.Initialize(11, p11.MODE_INPUT)  
        p8.DigitalWrite(True)  
        p10.DigitalWrite(False)  
    End If  
      
    If cnt = 8 Then  
        p8.Initialize(8, p8.MODE_OUTPUT)  
        p9.Initialize(9, p9.MODE_INPUT)  
        p10.Initialize(10, p10.MODE_OUTPUT)  
        p11.Initialize(11, p11.MODE_INPUT)  
        p8.DigitalWrite(False)  
        p10.DigitalWrite(True)  
    End If  
      
    If cnt = 9 Then  
        p8.Initialize(8, p8.MODE_INPUT)  
        p9.Initialize(9, p9.MODE_OUTPUT)  
        p10.Initialize(10, p10.MODE_INPUT)  
        p11.Initialize(11, p11.MODE_OUTPUT)  
        p9.DigitalWrite(True)  
        p11.DigitalWrite(False)  
    End If  
      
    If cnt = 10 Then  
        p8.Initialize(8, p8.MODE_INPUT)  
        p9.Initialize(9, p9.MODE_OUTPUT)  
        p10.Initialize(10, p10.MODE_INPUT)  
        p11.Initialize(11, p11.MODE_OUTPUT)  
        p9.DigitalWrite(False)  
        p11.DigitalWrite(True)  
    End If  
      
    If cnt = 11 Then  
        p8.Initialize(8, p8.MODE_OUTPUT)  
        p9.Initialize(9, p9.MODE_INPUT)  
        p10.Initialize(10, p10.MODE_INPUT)  
        p11.Initialize(11, p11.MODE_OUTPUT)  
        p8.DigitalWrite(True)  
        p11.DigitalWrite(False)  
    End If  
      
    If cnt = 12 Then  
        p8.Initialize(8, p8.MODE_OUTPUT)  
        p9.Initialize(9, p9.MODE_INPUT)  
        p10.Initialize(10, p10.MODE_INPUT)  
        p11.Initialize(11, p11.MODE_OUTPUT)  
        p8.DigitalWrite(False)  
        p11.DigitalWrite(True)  
    End If  
  
End Sub
```
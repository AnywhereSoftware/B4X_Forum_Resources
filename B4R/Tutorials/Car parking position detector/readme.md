### Car parking position detector by hatzisn
### 12/19/2022
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/108726/)

Hi everyone,  
  
This project is a parking detector. It is not my idea and it exists already in Stavros Niarchos Foundation Parking already materialized but it has been a great pleasure analyzing it, understanding it and materializing myself (in a CAD oriented materialization at least). One may wonder why do they have used two detectors and not only one over the car. I suppose they have done this for debugging each parking position sensors because if you check regularly 2000 parking positions in a 4-stores parking then you have to employ a lot of personnel but with this materialization the parking position's sensors say to you "we are ill - come and cure us").  
  
Here is the schematic:  
  

![](https://www.b4x.com/android/forum/attachments/83182)

  
  
The parking position sensors are located almost 2,40m (8 ft.) over the floor and have a distance between them of about 1,80m (6 ft.) in the x-axis of the parking position and are located in the middle of the y-axis in each related position. We have something like this:  
  

![](https://www.b4x.com/android/forum/attachments/83183)

  
  
There is a timer and triggers each sensor in regular time distances and if the space distance of a sensor to the closest object is less than 120cm (4 ft.) (in my materialization) then it sets its state to true else it sets each state to false. When the car is out S1=False and S2=False. When it is just entering then S1=True and S2=False. When it is half in the parking position S1=True and S2=True. When the car is full in the parking then S1=False and S2=True. By getting the sequence of the states we understand if the car was parked or the car was unparked. If none of this has happened (the sequence of the states do not correspond to none of "has parked" or "has unparked" statuses) and it hasn't got in a known status within two minutes then the personnel is being notified (I suppose).  
  
Here are the states of the sensors with related meanings and the result statuses:  
  

![](https://www.b4x.com/android/forum/attachments/83184)

  
  
When the car is unparked the Green LED lights indicating an empty position and when the car is parked the Red LED lights indicating a non empty position.  
  
  
Possible Ideas of extra Materialization:  

1. In conjunction with an arduino, a GSM shield and a MOSFET cirquit in your car you can cut off the power of the car and halt it if it exits your garage without your authorization (being stolen f.e.)
2. In conjunction with a relay light up a bulb (let's say for 4 minutes) when your car is parked in the Garage.
3. In conjunction with an ESP8266 report the result status ("Car was parked"/"Car was unparked") in an on-line database to know when your wife left the garage and got in the garage if you have suspicions that she is cheating on you ;);););););) (let's get the b\*tch) :D:D:D:D:D

  
Here is the code:  
  

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
   
    Public triggerpin1 As Pin  
    Public echopin1 As Pin  
    Public pulseduration1 As Double  
   
    Public triggerpin2 As Pin  
    Public echopin2 As Pin  
    Public pulseduration2 As Double  
  
    Dim pinRed As Pin  
    Dim pinGreen As Pin  
   
    Dim bCurrentState1 As Boolean  
    Dim bCurrentState2 As Boolean  
    Dim bPreviousState1 As Boolean = False  
    Dim bPreviousState2 As Boolean = False  
   
    Dim iPointer As Int  
    Dim States1Logged(4), States2Logged(4) As Boolean  
    Dim Parking1(4) As Boolean, UnParking1(4) As Boolean  
    Dim Parking2(4) As Boolean, UnParking2(4) As Boolean  
   
    Dim tm As Timer  
    Dim tm2 As Timer  
   
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log("AppStart")  
    iPointer = 0  
    tm.Initialize("tm_Tick", 500)  
    tm.Enabled = True  
    tm2.Initialize("tm2_Tick", 120000)  
    triggerpin1.Initialize(4, triggerpin1.MODE_OUTPUT)  
    triggerpin2.Initialize(6, triggerpin2.MODE_OUTPUT)  
    echopin1.Initialize(5, echopin1.MODE_INPUT)  
    echopin2.Initialize(7, echopin2.MODE_INPUT)  
  
    pinRed.Initialize(8, pinRed.MODE_OUTPUT)  
    pinGreen.Initialize(9, pinRed.MODE_OUTPUT)  
   
     
    'First sensor parking sequence  
    Parking1(0) = False: Parking1(1) = True: Parking1(2) = True: Parking1(3) = False  
    'Second sensor parking sequence  
    Parking2(0) = False: Parking2(1) = False: Parking2(2) = True: Parking2(3) = True  
   
    'First sensor unparking sequence  
    UnParking1(0) = False: UnParking1(1) = True: UnParking1(2) = True: UnParking1(3) = False  
    'Second sensor unparking sequence  
    UnParking2(0) = True: UnParking2(1) = True: UnParking2(2) = False: UnParking2(3) = False  
   
End Sub  
  
  
Private Sub tm_Tick  
    LogSensor1  
    LogSensor2  
    LogStateAndLightProperPIN  
End Sub  
  
Private Sub tm2_Tick  
    If LightUpProperLED = False Then  
        'Inform me that the sensors have a problem  
        tm.Enabled = False  
    End If  
End Sub  
  
  
  
Private Sub LogSensor1  
    Dim distance1 As Double  
    'Begin trigger  
    triggerpin1.DigitalWrite(True)  
  
    Log("Begin trigger 1")  
  
    'Trigger Off  
    triggerpin1.DigitalWrite(False)  
  
    'Distance proportional to pulse duration received on echo1 Pin  
    RunNative("pulseins1",echopin1.PinNumber)  
    'distance=(0.5*pulsduration)/29.1  
    Log("Pulse duration: ", pulseduration1)  
    distance1=(0.0340*0.5*pulseduration1)  
   
      bCurrentState1 = (distance1<120)  
End Sub  
  
  
#if C  
void pulseins1 (B4R::Object* o) {  
   b4r_main::_pulseduration1 = pulseIn(o->toULong(),HIGH);  
}  
#End if  
  
Private Sub LogSensor2  
    Dim distance2 As Double  
    'Begin trigger  
    triggerpin2.DigitalWrite(True)  
  
    Log("Begin trigger 2")  
  
    'Trigger Off  
    triggerpin2.DigitalWrite(False)  
  
    'Distance proportional to pulse duration received on echo2 Pin  
    RunNative("pulseins2",echopin2.PinNumber)  
    'distance=(0.5*pulsduration)/29.2  
    Log("Pulse duration: ", pulseduration2)  
    distance2=(0.0340*0.5*pulseduration2)  
   
      bCurrentState2 = (distance2<120)  
End Sub  
  
  
#if C  
void pulseins2 (B4R::Object* o) {  
   b4r_main::_pulseduration2 = pulseIn(o->toULong(),HIGH);  
}  
#End if  
  
Sub LogStateAndLightProperPIN  
    'If the states have not changed do not log anything  
    If bPreviousState1 = bCurrentState1 And bPreviousState2 = bCurrentState2 Then Return  
    States1Logged(iPointer) = bCurrentState1  
    States2Logged(iPointer) = bCurrentState2  
    bPreviousState1 = bCurrentState1  
    bPreviousState2 = bCurrentState2  
    iPointer = iPointer + 1  
    If iPointer = 4 Then iPointer = 0  
    LightUpProperLED  
End Sub  
  
Private Sub LightUpProperLED As Boolean  
    Dim iCheck1 As Int = 0  
    Dim iParking2 As Int = 0  
    Dim iUnparking2 As Int = 0  
    Dim bParked As Boolean = False  
    Dim bUnparked As Boolean = False  
    For ii = 0 To 3  
        'We do not need actually the Unparking1 as it is actually the same  
        If Parking1(ii) = States1Logged((iPointer + ii) Mod 4) Then  
            iCheck1 = iCheck1 + 1  
        End If  
        If Parking2(ii) = States2Logged((iPointer + ii) Mod 4) Then  
            iParking2 = iParking2 + 1  
        End If  
        If UnParking2(ii) = States2Logged((iPointer + ii) Mod 4) Then  
            iUnparking2 = iUnparking2 + 1  
        End If  
    Next  
   
    If iCheck1 = 4 Then  
        'It has pakred or unparked  
        If iParking2 = 4 Then bParked = True  
        If iUnparking2 = 4 Then bUnparked = True  
    Else  
        'Give the sensors a 2 minutes grace period and then inform me that they are malfunctioning  
        'The sub is triggered only on a different state logged so the timer will not be constantly enabled and restart  
        tm2.Enabled = True  
    End If  
  
    Select Case True  
        Case bParked = False And bUnparked = True  
            tm2.Enabled = False  
            pinGreen.DigitalWrite(True)  
            pinRed.DigitalWrite(False)  
        Case bParked = True And bUnparked = False  
            tm2.Enabled = False  
            pinGreen.DigitalWrite(False)  
            pinRed.DigitalWrite(True)  
        Case Else  
            'Give the sensors a 2 minutes grace period and then inform me that they are malfunctioning  
            'The sub is triggered only on a different state logged so the timer will not be constantly enabled and restart  
            tm2.Enabled = True  
    End Select  
   
    Return (bParked Or bUnparked)  
End Sub
```

  
  
  
For measuring the distance of each sensor in the code I've got advantage of a code created already in the forum by inakigram who has done it himself (thanks a lot).  
  
  
  
Have fun
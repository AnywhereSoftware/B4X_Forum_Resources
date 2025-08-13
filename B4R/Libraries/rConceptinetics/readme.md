### rConceptinetics by rwblinn
### 06/02/2024
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/161479/)

This is a B4R Library to control LED lights using the DMX512 protocol.  
The library **rConceptinetics** is partially wrapped and enhanced from [this](https://github.com/alfo/arduino-libraries/tree/master/Conceptinetics) GitHub project.  
  
**Test Setup Example (DMXController)**  
An Arduino MEGA with Arduino DMX Shield runs a B4R program listening to serialized data holding the commands to set the light(s) value 0-255 for a selected channel.  
The serialized data is set by a B4J application.  
The Arduino MEGA is used because it has more then 1 serial port and 2 serial ports are required.  
  
![](https://www.b4x.com/android/forum/attachments/154268)  
  
**Hardware**  

- 1x Arduino MEGA
- 1x CQRobot DMX Shield MAX485 for MCU
- 1x LED Mini Flat Par Light LSPA36RC (DMX512 with 3-7 channels)
- 1x Adam Hall Cables 3 STAR DMF 0600 DMX Cable 3-Pol XLR Female auf 3-Pol XLR male 6 m
- 1x Adam Hall Connectors 3 STAR DMX T 3 XLR Cable 3-Pol woth 120OHM resistor

**Arduino MEGA Serial**  
In order to use the Serial on the MEGA For debug and leave the Serial1 for the DMX Shield change the Conceptinetics.h file inside the library rConceptinetics.  

```B4X
// Define which serial port To use As DMX port, only one can be selected at the time by uncommenting one of the following lines  
//#define USE_DMX_SERIAL_0  
#define USE_DMX_SERIAL_1  
//#define USE_DMX_SERIAL_2  
//#define USE_DMX_SERIAL_3
```

  
  
**Arduino MEGA and DMX Shield **Pin Mapping****  
Import is to connect the Arduino MEGA Serial 1 pins to the DMX Shield.  
**MEGA = DMX Shield**  
RX1 GPIO19 = 3 (Orange)  
TX1 GPIO18 = 4 (Blue)  
  
**DMX Shield Jumper Setting**  
Looking from the DMX shield bottom with X2 at the left side:  
EN,DE Master,TX-io,RX-io  
  
**B4R Example Code**  
Show how to init and use the methods from the library rConceptinetics.  

```B4X
Sub Process_Globals  
    Public Serial1 As Serial  
    'DMX object from the library rConceptinetics.  
    Private dmx_master As DMXMaster  
    'Channels - can also use instead the defaults from the library  
    Private DIMMER As Byte = dmx_master.CHANNEL_DIMMER  
    Private Const RED = 2, GREEN = 3, BLUE = 4 As Byte  
End Sub  
  
Private Sub AppStart  
    'IMPORTANT - the dmx master has to be initialized prior Serial1  
    dmx_master.Initialize(10, dmx_master.RXEN_PIN)  
  
    'Init serial1 and asyncstream to handle channel commands  
    Serial1.Initialize(115200)  
  
    'Set Channel 1 DIMMER @ 50%  
    dmx_master.SetChannelLevel(DIMMER, 50)  
    'or use dmx_master.SetChannelValue(1, 127)  
    Log("SetChannelLevel(DIMMER, 50)")  
  
    'Set Channel 2 RED @ low 10% (=255 / 10)  
    dmx_master.SetChannelValue(RED, 25)  
    Log("SetChannelValue(RED, 25)")  
    Delay(2500)  
  
    'Turn channel RED off  
    dmx_master.SetChannelValue(RED, 0)  
  
    'Set Channel 3 GREEN @ mid 50%  
    dmx_master.SetChannelLevel(GREEN, 50)  
    Log("SetChannelLevel(GREEN, 50)")  
    Delay(2500)  
  
    'RGB on     
    dmx_master.SetRGB(RED,GREEN,BLUE,10,20,30)  
    Log("SetRGB(RED,GREEN,BLUE,10,20,30)")  
    Delay(2500)  
  
    'RGB off  
    dmx_master.SetRGBOff(RED,GREEN,BLUE)  
    Log("SetRGBOff(RED,GREEN,BLUE)")  
  
End Sub
```

  
  
**ToDo**  

- DMX Input Listener
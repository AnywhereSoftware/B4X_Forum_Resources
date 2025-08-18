### rLegoinoBoost by rwblinn
### 10/19/2021
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/135237/)

**rLegoinoBoost** - B4R library which is a partial wrapper of the Arduino library Legoino  
  
**Brief**  
This B4R library wraps the Boost methods of the [Legoino Library](https://github.com/corneliusmunz/legoino).  
The rLegoinoBoost library enables controlling the LEGO® Motorized Hub (MoveHUB) from the [LEGO Creative Toolbox 17101](https://www.lego.com/en-de/product/boost-creative-toolbox-17101).  
The MoveHUB has two internal tacho motors, one external basic motor, one distance & color sensor and an internal tilt sensor.  
The rLegoinoBoost library has been developed on a Windows 10 device with B4R v3.90, tested with an ESP-WROOM-32 module (ESP32 NodeMCU) and B4J and B4A clients.  
The library has been developed for personal use only.  
*Disclaimer*: LEGO® is a trademark of the LEGO Group of companies.  
  
**Goal**  
To control the MoveHUB by using an ESP32 as bridge between the MoveHUB (via Bluetooth Low Energy) and B4X (B4A & B4J) Clients (via WiFi or Serial).  

```B4X
MoveHUB BLE <-> ESP32 BLE <—> ESP32 WIFI <-> Clients B4A & B4J WiFi
```

  
Using an ESP32 enables not only controlling the MoveHUB but also ESP32 connected Input/Output devices providing integrated creative digital solutions. Just a few thoughts:  
Remote Controlled Car with distance sensor; Locomotive with sound, lights, distance sensor; Crane with button control, lights, info display; Clock using the 3 motors … and many more …  
As a starter, to test the library, a simple Remote Controlled Car has been build (BoostRCCar, B4XPages example with B4A,B4J clients and B4R shared module).  
  
![](https://www.b4x.com/android/forum/attachments/120439)  
**ToDo**: Share a short video controlling the RC Car.  
  
**Legoino Information**  
As taken from the Legoino README.md:  
**Legoino** is an Arduino Library for controlling all kinds of \*LEGO\* Powered UP devices.  
From the two port hub, move hub (e.g. boost), duplo train hub, technic hub to several devices like distance and color sensor, tilt sensor, train motor, remote control, speedometer, etc. you can control almost everthing with that library and your Arduino sketch.  
It is also possible to use the "old" Power Function IR Modules and control them via an IR LED connected to a PIN of your ESP32 device.  
With the Hub emulation function you can even control an "old" Power Function Light or Motor with the Powered Up App.  
  
The library is implemented for **ESP32 Boards** and does use the ESP32 [NimBLE-Aruino](https://github.com/h2zero/NimBLE-Arduino) Library as dependency.  
This should be installed via the Arduino library manager before using Legoino.  
  
**Hard- and Software**  

- Hardware: ESP32 Dev Module WROOM (like an ESP32 NodeMCU), Lego BOOST Set 17101, Development Device (Windows, B4X), Android Device (B4A apps)
- Software: Legoino v1.1.0, NimBLE-Arduino v1.3.1, B4R v3.90, B4R Additional Library rLegoino v1.0.0, B4A v11.0, B4J v9.10

*Note:* The version information is subject to change.  
  
**Archive**  
The archive rLegoinoBoost.zip contains:  

- The B4R additional library rLegoinoBoost
- The rLegoinoBoost library documentation rLegoinoBoost.html
- Additional information README.md, CHANGELOG.md, TODO.md, Licence
- Various sample projects in subfolder examples.

**Installation  
Arduino Libraries**  
The additional Arduino libraries [Legoino](https://github.com/corneliusmunz/legoino) and [NimBLE-Arduino](https://github.com/h2zero/NimBLE-Arduino) to be installed in the Arduino libraries folder.  
Install via the Arduino IDE (v8.13 or higher) or copy direct to the Arduino Libraries folder (unpack from the ZIP archives).  
*Example Arduino Libraries Folder*  

```B4X
d:\devtools\arduino\libraries\Legoino  
d:\devtools\arduino\libraries\NimBLE-Arduino.
```

  
  
**B4R Additional Library rLegoinoBoost**  
The B4R additional library rLegoinoBoost to be installed in the B4R additional libraries folder.  
Copy from the ZIP Archive  
*Example B4R Additional Library Folder*  

```B4X
d:\b4\b4r\libraries\rLegoinoBoost\rLegoinoBoost.h, rLegoinoBoost.cpp with additional files like the README.md, CHANGELOG.md, TODO.md, Licence  
d:\b4\b4r\libraries\rLegoinoBoost.xml
```

  
  
**MoveHUB  
MoveHUB Components**  

- Communicates via Bluetooth Low Energy (BLE)
- Two internal tacho motors (ports A, B - can be used same time as port AB)
- One external basic motor (port C or D)
- Built-in Tilt Sensor XY axis (not used in this library), Voltage Sensor (max voltage is 9.6 V), Current Sensor (max current is 2444 mA)
- One external Color (detect colors) and Distance (measure distance to an object in mm) Sensor (port C or D)
- Power 6 AAA batteries - recommend rechargeable batteries = MoveHUB uses extensive power draining the batteries fast
- Ports IDs: A=0x00, B=0x01, AB=0x10, C=0x02, D=0x03, LED=0x32, TILT=0x3A, CURRENT=0x3B, VOLTAGE=0x3C
- LED Colors: BLACK=0, PINK=1, PURPLE=2, BLUE=3, LIGHTBLUE=4, CYAN=5, GREEN=6, YELLOW=7, ORANGE=8, RED=9, WHITE=10, NONE=255

*Note:* Sometimes the MoveHUB is called drivebase.  
  
**MoveHUB BLE MAC Address**  
The BLE MAC address is required to connect the ESP32 module with the MoveHUB.  
The address can be obtained by using tools like \*\*hcitool\*\* (via Raspberry Pi) or \*\*Android App Serial Bluetooth\*\* or Bluetooth scanning from Windows 10 device settings.  
The MoveHUB used for development and testing has address (defined as B4X constant):  

```B4X
Private Const MOVEHUB_ADDRESS As String = "00:16:53:AE:9B:27"
```

  
  
**MoveHUB LED Color States**  
Flashing WHITE: Waiting BLE connection, Flashing YELLOW: Battery Low, Steady RED: Battery close getting empty, Steady BLUE: BLE Connected.  
  
**Sample Projects**  
Various sample projects can be found in the ZIP archive subfolder Examples.  

- BoostBasicControl - see below
- BoostColorSensorTimer - Read via timer the color from the Color sensor and set the MoveHUB LED color accordingly
- BoostDistanceSensor - Read via callback the distnce (mm)
- BoostDistanceSensorTimer - Read via timer the distance (mm)
- BoostHUBLED - Set the various colors of the MoveHUB
- BoostRCCar - Remote controlled car via WiFi with B4A & B4J app [B4XPages] and the ESP32 acting as a bridge between the client and the MoveHUB

**Run**  
To run a sample project.  

- Connect an ESP32 module to a development device with B4R. For the ESP32 acting as a bridge, client control requires B4A and/or B4J.
- Open the B4R IDE and load the B4R project file.
- In the B4R IDE, set the board, port, MoveHUB BLE MAC address and compile the code. Depending development device and ESP32 module used, this process takes up-to several minutes. Any next builds take about a minute.
- After uploading has been completed, reset the ESP32 module via its onboard reset button.
- Press on the green button on the Lego MoveHUB. The MoveHUB LED starts to flash white and turns blue if BLE connection made with the ESP32 device.
- If no initial connection between the ESP32 and the MoveHUB, press the MoveHUB green button again whilst resetting the ESP32 module.

**Pseudo Code**  
The pseudo code applies to any of the solutions made.  

```B4X
Create a single LegoinoBoost object.  
Init the object with callback event, the MoveHUB BLE address and debugging option.  
If BLE connection made with the MoveHUB, the callback event is triggered.  
If connection then control the MoveHUB motors or LED or handle color or distance sensor changes.  
If remote control then use serial or websocket communication with serialized data via asyncstreams between the ESP32 acting as a bridge and the B4A/B4i/B4J remote clients.  
If remote connection then asyncstreams newdata event handles data received or asyncstreams write to send data from the ESP32 back to the remore client.
```

  
  
**Code**  
This example project , BoostBasicControl, connects an ESP32 via BLE with the MoveHUB.  
If connection made, the statechanged event triggers various actions (Motors, LED, Battery Level, Voltage) to the MoveHUB.  

```B4X
#Region Project Attributes  
    #AutoFlushLogs: True  
    #CheckArrayBounds: True  
    #StackBufferSize: 500  
#End Region  
  
Sub Process_Globals  
    Public serialLine As Serial  
    Private moveHUB As LegoinoBoost  
    Private Const MOVEHUB_ADDRESS As String = "00:16:53:AE:9B:27"  
End Sub  
  
Private Sub AppStart  
    serialLine.Initialize(115200)  
    ' Init sensor with callback event, MAC adress 00:16:53:AE:9B:27 and debug flag  
    moveHUB.Initialize("MoveHub_StateChanged", MOVEHUB_ADDRESS, True)  
    Log("Waiting for MoveHub Bluetooth connection: ", MOVEHUB_ADDRESS)  
End Sub  
  
' Callback event handling the connection state change.  
' When connected to the move hub, run several actions.  
Sub MoveHub_StateChanged(Connected As Boolean)  
    Log("MoveHub StateChanged: ", Connected)  
    If Connected Then  
        Log("Connected to ", moveHUB.Name)  
        ' HUB LED Color GREEN  
        Log("Set LED Color Green")  
        moveHUB.SetLEDColor(moveHUB.LED_COLOR_GREEN)  
        Delay(3000)  
  
        ' HUB Internal Tacho Motor Port A  
        ' Move forward  
        Log("Set LED Color Blue")  
        moveHUB.SetLEDColor(moveHUB.LED_COLOR_BLUE)  
        Log("Set Tacho Motor A Speed=20 Forward MaxPower=100")  
        moveHUB.SetTachoMotorSpeed(moveHUB.MOVEHUBPORT_A, 20, 100, moveHUB.BRAKINGSTYLE_BRAKE)  
        Delay(3000)  
        ' Stop  
        Log("Stop Tacho Motor A")  
        moveHUB.StopTachoMotor(moveHUB.MOVEHUBPORT_A)  
        Log("Set LED Color Green")  
        moveHUB.SetLEDColor(moveHUB.LED_COLOR_GREEN)  
        Delay(3000)  
        ' Move backward  
        Log("Set LED Color Red")  
        moveHUB.SetLEDColor(moveHUB.LED_COLOR_RED)  
        Log("Set Tacho Motor A Speed=40 Backwards MaxPower=100")  
        moveHUB.SetTachoMotorSpeed(moveHUB.MOVEHUBPORT_A, -40, 100, moveHUB.BRAKINGSTYLE_BRAKE)  
        Delay(3000)  
        ' Stop  
        Log("Stop Tacho Motor A")  
        moveHUB.StopTachoMotor(moveHUB.MOVEHUBPORT_A)  
        Log("Set LED Color Green")  
        moveHUB.SetLEDColor(moveHUB.LED_COLOR_GREEN)  
        Delay(2000)  
        ' External Basic Motor Port C  
        Log("Set LED Color Lightblue")  
        moveHUB.SetLEDColor(moveHUB.LED_COLOR_LIGHTBLUE)  
        Log("Set Basic Motor Port C Position Speed=20, Position=-30")  
        moveHUB.SetAbsoluteMotorPosition(moveHUB.MOVEHUBPORT_C, 20, -30, 100, moveHUB.BRAKINGSTYLE_BRAKE)  
        Delay(2000)  
        ' HUB LED RGB Color - CYAN  
        Log("Set LED Color CYAN")  
        moveHUB.SetLEDRGBColor(0, 255, 255)  
        Delay(1000)  
        ' HUB Properties  
        Log("Properties BatteryLevel: ", moveHUB.BatteryLevel, "%, VoltageSensor: ", moveHUB.VoltageSensor, "V")  
        Delay(1000)  
        Log("HUB Shutdown…")  
        moveHUB.ShutDownHub  
        Log("DONE")  
    End If      
End Sub
```

  
  
**Credits**  
\* Anywhere Software for providing the B4X development tools.  
\* Author and contributors of the Arduino Legoino and NimBLE-Arduino Library.  
\* Author of the [B4X Library Documentation Viewer](https://www.b4x.com/android/forum/threads/b4x-library-documentation-viewer.112771/#content) which is used to create the library documentation rLegoinoBoost.html.  
\* Creator of the LEGO BOOST [Creative Canvas Drive Base](https://robotics.benedettelli.com/lego-boost-17101-building-instructions/).  
  
**Licence**  
GNU General Public License v3.0.
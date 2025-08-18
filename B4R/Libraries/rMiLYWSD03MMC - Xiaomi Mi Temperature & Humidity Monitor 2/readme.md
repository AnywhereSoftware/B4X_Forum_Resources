### rMiLYWSD03MMC - Xiaomi Mi Temperature & Humidity Monitor 2 by rwblinn
### 07/01/2021
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/131806/)

**rMiLYWSD03MMC**  
Open source B4R library for reading temperature, humidity and battery values broadcasted via Bluetooth 4.2 BLE by the **Xiaomi Mi Temperature AND Humidity Monitor 2**.  
  
![](https://www.b4x.com/android/forum/attachments/115238)  
  
The library is based on the Bluetooth Low Energy (BLE) library for Arduino-ESP32 based on NimBLE - [NimBLE-Arduino](https://github.com/h2zero/NimBLE-Arduino) - Thanks.  
The NimBLE-Arduino library functions are not wrapped but used in dedicated functions defined in the rMiLYWSD03MMC library.  
This sensor has model name *LYWSD03MMC*, which is used for the library name - to make the library unique for this sensor.  
Inspired by [this](https://www.b4x.com/android/forum/threads/ble-xiaomi-temperature-sensor-project-esp32-with-ble-wifi.130032//) B4R forum thread - Thanks.  
  
rMiLYWSD03MMC has been tested with a ESP-WROOM-32 module, B4R v3.71, NimBLE library 1.2.0.  
  
**Attached**  
rMiLYWSD03MMC.zip archive contains the library and B4R sample projects.  
  
**Install**  
The library files are installed in the B4R additional libraries folder.  
From the zip archive, copy the content of the library folder, to the B4R additional libraries folder keeping the folder structure.  

```B4X
<path to b4r additional libraries folder>\rMiLYWSD03MMC.xml  
<path to b4r additional libraries folder>\rMiLYWSD03MMC\rMiLYWSD03MMC.h , rMiLYWSD03MMC.cpp
```

  
The examples can be found in the folder *examples*.  
  
*Important*  
The NimBLE-Arduino library is not included and must be installed using the Arduino IDE ([Info](https://www.arduino.cc/reference/en/libraries/nimble-arduino/)).  
Ensure to regular update the library via the Arduino IDE.  
  
**Functions Overview**  
  
**Initialize an Object**  

```B4X
Initialize(SubVoidVoid ScanCompletedSub, B4RString* Addr, bool Debug=false)
```

  
ScanCompletedSub - Sub to call when the scan for data is completed.  
Addr - Device MAC address - Example: a4:c1:38:38:a9:0c.  
Debug - Set to true to log the various steps from init to getting data.  
Notes:  
The power level is set to max +9dbm (ESP\_PWR\_LVL\_P9). This can be changed in the CPP code, function Initialize.  
*Example*  

```B4X
Private miSensor As MiLYWSD03MMC  
miSensor.Initialize("miSensor_ScanCompleted", "a4:c1:38:38:a9:0c", False)  
Sub miSensor_ScanCompleted  
    If (miSensor.StatusCode = miSensor.STATUS_OK) Then  
        Log("T: ", miSensor.Temperature, " C, H: ", miSensor.Humidity, " %, B: ", miSensor.Battery, " V")  
    Else  
        Log("Error scanning BLE device.")  
    End If  
End Sub
```

  
  
**Scan for Sensor Data**  

```B4X
Scan
```

  
This is done once. Use B4R timer to scan frequent.  
Lookup sub ScanCompleted for the result.  
*Example*  

```B4X
miSensor.Scan  
  
Sub miSensor_ScanCompleted  
    Log("Scan completed. Status: ", miSensor.StatusCode)  
End Sub
```

  
  
**Get Temperature in Degree C**  

```B4X
Temperature As Float
```

  
*Example*  

```B4X
Dim t as Double = miSensor.Temperature
```

  
  
**Get Humidity in %RH**  

```B4X
Humidity As Float
```

  
*Example*  

```B4X
Dim h as Double = miSensor.Humidity
```

  
  
**Get Battery Voltage between 2.1 and 3.1 V**  

```B4X
Battery As Float
```

  
*Example*  

```B4X
Dim b as Double = miSensor.Battery
```

  
  
**Get Return Status Code Sensor Scan**  

```B4X
StatusCode As Int
```

  
OK=1 else error (see STATUS constants).  
*Example*  

```B4X
Dim statusCode as Byte = miSensor.StatusCode  
If (miSensor.StatusCode = miSensor.STATUS_OK) Then  
    'OK  
Else  
    'Error  
End
```

  
   
**Fields**  
*UUID's*  

- SERVICE\_UUID "ebe0ccb0-7a0a-4b0c-8a1a-6ff2997da3a6"
- CHAR\_UUID "ebe0ccc1-7a0a-4b0c-8a1a-6ff2997da3a6"

*Status Codes*  
Status codes as **Byte** returned from the scan method.  

- STATUS\_OK
- STATUS\_UNKNOWN
- STATUS\_ERR\_CONNECT - Error can not connect to the device
- STATUS\_ERR\_SERVICEUUID - Error can not find the service UUID (see define SERVICE\_UUID)
- STATUS\_ERR\_CHARUUID - Error can not find the characteristics UUID (see define CHAR\_UUID)

**B4R Examples**  

- **Data Logger** - Scan for data in regular intervals and log the temperature, humidity and battery voltage.
- **Data to Domoticz** - Scan for data in regular intervals and sent the temperature, humidity to [Domoticz](https://domoticz.com/) Home Automation System (HTTP JSON/API GET request).

**Data Logger**  
Scan for data in regular intervals and log the temperature, humidity and battery voltage.  
See archive folder examples/datalogger.  

```B4X
Sub Process_Globals  
    Public VERSION As String = "B4R Library rMiLYWSD03MMC - Example Data Logger v20210619"  
    Public serialLine As Serial  
    Private miSensor1 As MiLYWSD03MMC  
    Private timerGetData As Timer  
    Private TIMER_INTERVAL As ULong = 15000  
End Sub  
  
Private Sub AppStart  
    serialLine.Initialize(115200)  
    Log(VERSION)  
    ' Init sensor with callback event, MAC adress A4:C1:38:38:A9:0C and debug flag  
    miSensor1.Initialize("miSensor1_ScanCompleted", "A4:C1:38:38:A9:0C", True)  
    ' First time scan for data - results handled by sub _ScanCompleted  
    miSensor1.Scan()  
    ' Set the data gathering timer  
    timerGetData.Initialize("TimerGetData_Tick", TIMER_INTERVAL)  
    timerGetData.Enabled = True  
End Sub  
  
' Scan for data - the result is handled by the event sub _ScanCompleted  
Sub TimerGetData_Tick  
    miSensor1.Scan()  
End Sub  
  
Sub miSensor1_ScanCompleted  
    Log("Scan completed. Status: ", miSensor1.StatusCode)  
    Select miSensor1.StatusCode  
        Case miSensor1.STATUS_OK  
            Log("T: ", miSensor1.Temperature, " C, H: ", miSensor1.Humidity, " %, B: ", miSensor1.Battery, " V")  
        Case miSensor1.STATUS_ERR_CONNECT  
            Log("ERROR: Can not connect to the device.")  
        Case miSensor1.STATUS_ERR_SERVICEUUID  
            Log("ERROR: Can not find the device service UUID.")  
        Case miSensor1.STATUS_ERR_CHARUUID  
            Log("ERROR: Can not find the characteristics UUID from the service UUID.")  
        Case Else  
            Log("Unknown status code.")     
    End Select  
    Log("*****")  
End Sub
```

  
  
*B4R Log Snippet (Debug=True)*  

```B4X
B4R Library rMiLYWSD03MMC - Example Data Logger v20210619  
[DEBUG] Initializing  
[DEBUG] Get client data  
[DEBUG] Connecting…  
[DEBUG] Client connected  
[DEBUG] Found service UUID: ebe0ccb0-7a0a-4b0c-8a1a-6ff2997da3a6  
[DEBUG] Found characteristic UUID: ebe0ccc1-7a0a-4b0c-8a1a-6ff2997da3a6  
[DEBUG] Data received HEX: F0 9 47 B9 A  
[DEBUG] T = 25.44 H = 71.0 B = 2.74  
[DEBUG] Background scan stopped  
[DEBUG] Client disconnected  
[DEBUG] Scan completed, Status: 1  
Scan completed. Status: 1  
T: 25.4400 C, H: 71 %, B: 2.7450 V  
*****
```

  
  
**Hints**  

- The client can (only) connect to a single server.
- The *hcitool* is used to get the BLE device MAC address (used under Linux $sudo bluetoothctl).
- The *gatttool* is used to get the BLE device services and characteristics with descripters, but also to write configuration changes (used under Linux $gatttool -I -b A4:C1:38:38:A9:0C).
- If required, change the power level (current highest level P9 = 9dbm) in the CPP file, function Initialize, BLEDevice::setPower(ESP\_PWR\_LVL\_P9, ESP\_BLE\_PWR\_TYPE\_SCAN);.
- If the device gets scanned, the little Bluetooth symbol on the LCD display is visible.

**Licence**  

- GNU General Public License v3.0.

**Changelog**  

- v1.00 (20210620) - Initial version

**ToDo**  

- Checkout if this library can be exposed to other Xiaomi BLE devices.
- Single client connecting to multiple server advertising the same service UUID.
- Explore why: If the connection failed, in cases following error given by the package "lld\_pdu\_get\_tx\_flush\_nb HCI packet count mismatch".
- Explore how to read the comfort status from the device (the "smiley").
- Explore how to read the history data or change various configurations.
- Watch the stack buffer via code Log(StackBufferUsage). Check if 300 is enough.
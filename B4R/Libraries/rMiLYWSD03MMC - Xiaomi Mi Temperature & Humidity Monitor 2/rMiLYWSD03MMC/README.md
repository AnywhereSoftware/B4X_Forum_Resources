[B]rMiLYWSD03MMC[/B] is an open source B4R library for reading temperature, humidity and battery values broadcasted via Bluetooth 4.2 BLE by the [B]Xiaomi Mi Temperature AND Humidity Monitor 2[/B].

[ATTACH type="full" width="145px"]115238[/ATTACH]

The library is based on the Bluetooth Low Energy (BLE) library for Arduino-ESP32 based on NimBLE - [URL='https://github.com/h2zero/NimBLE-Arduino']NimBLE-Arduino[/URL] - Thanks.
The NimBLE-Arduino library functions are not wrapped but used in dedicated functions defined in the rMiLYWSD03MMC library.
This sensor has model name [I]LYWSD03MMC[/I], which is used for the library name - to make the library unique for this sensor.
Inspired by [URL='https://www.b4x.com/android/forum/threads/ble-xiaomi-temperature-sensor-project-esp32-with-ble-wifi.130032//']this[/URL] B4R forum thread - Thanks.

rMiLYWSD03MMC has been tested with a ESP-WROOM-32 module, B4R v3.71, NimBLE library 1.2.0.

[B]Attached[/B]
rMiLYWSD03MMC.zip archive contains the library and B4R sample projects.

[B]Install[/B]
The library files are installed in the B4R additional libraries folder.
From the zip archive, copy the content of the library folder, to the B4R additional libraries folder keeping the folder structure.
[CODE=b4x]
<path to b4r additional libraries folder>\rMiLYWSD03MMC.xml
<path to b4r additional libraries folder>\rMiLYWSD03MMC\rMiLYWSD03MMC.h , rMiLYWSD03MMC.cpp
[/CODE]
The examples can be found in the folder [I]examples[/I].

[I]Important[/I]
The NimBLE-Arduino library is not included and must be installed using the Arduino IDE ([URL='https://www.arduino.cc/reference/en/libraries/nimble-arduino/']Info[/URL]).
Ensure to regular update the library via the Arduino IDE.

[B][SIZE=5]Functions Overview

Initialize Object[/SIZE][/B]
[CODE=b4x]
Initialize(SubVoidVoid ScanCompletedSub, B4RString* Addr, bool Debug=false)
[/CODE]
ScanCompletedSub - Sub to call when the scan for data is completed.
Addr - Device MAC address - Example: a4:c1:38:38:a9:0c.
Debug - Set to true to log the various steps from init to getting data.
Notes:
The power level is set to max +9dbm (ESP_PWR_LVL_P9). This can be changed in the CPP code, function Initialize.
[I]Example[/I]
[CODE=b4x]
Private miSensor As MiLYWSD03MMC
miSensor.Initialize("miSensor_ScanCompleted", "a4:c1:38:38:a9:0c", False)
Sub miSensor_ScanCompleted
    If (miSensor.StatusCode = miSensor.STATUS_OK) Then
        Log("T: ", miSensor.Temperature, " C, H: ", miSensor.Humidity, " %, B: ", miSensor.Battery, " V")
    Else
        Log("Error scanning BLE device.")
    End If
End Sub
[/CODE]

[B][SIZE=5]Scan for Sensor Data[/SIZE][/B]
[CODE=b4x]
Scan
[/CODE]
This is done once. Use B4R timer to scan frequent.
Lookup sub ScanCompleted for the result.
[I]Example[/I]
[CODE=b4x]
miSensor.Scan
[/CODE]

[B][SIZE=5]Get Temperature in Degree C[/SIZE][/B]
[CODE=b4x]
float Temperature
[/CODE]
[I]Example[/I]
[CODE=b4x]
Dim t as Double = miSensor.Temperature
[/CODE]

[B][SIZE=5]Get Humidity in %RH[/SIZE][/B]
[CODE=b4x]
Float Humidity
[/CODE]
[I]Example[/I]
[CODE=b4x]
Dim h as Double = miSensor.Humidity
[/CODE]

[B][SIZE=5]Get Battery Voltage between 2.1 and 3.1 V[/SIZE][/B]
[CODE=b4x]
float Battery
[/CODE]
[I]Example[/I]
[CODE=b4x]
Dim b as Double = miSensor.Battery
[/CODE]

[B][SIZE=5]Get Return Status Code Sensor Scan[/SIZE][/B]
[CODE=b4x]
int StatusCode
[/CODE]
OK=1 else error (see STATUS constants).
[I]Example[/I]
[CODE=b4x]
Dim statusCode as Byte = miSensor.StatusCode
If (miSensor.StatusCode = miSensor.STATUS_OK) Then
    'OK
Else
    'Error
End
[/CODE]
           
[B][SIZE=5]Fields[/SIZE][/B]
[I]UUID's[/I]
SERVICE_UUID "ebe0ccb0-7a0a-4b0c-8a1a-6ff2997da3a6"
CHAR_UUID "ebe0ccc1-7a0a-4b0c-8a1a-6ff2997da3a6"

[I]Status Codes[/I]
Status code returned from the scan method.
Byte STATUS_OK
Byte STATUS_UNKNOWN
Byte STATUS_ERR_CONNECT    - Error can not connect to the device
Byte STATUS_ERR_SERVICEUUID - Error can not find the service UUID (see define SERVICE_UUID)
Byte STATUS_ERR_CHARUUID - Error can not find the characteristics UUID (see define CHAR_UUID)

[B]B4R Examples[/B]
* Data Logger - datalogger.b4r: Scan for data in regular intervals and log the temperature, humidity and battery voltage.
* Data to Domoticz - datatodomoticz.b4r: Scan for data in regular intervals and sent the temperature, humidity to Domoticz Home Automation System (HTTP JSON/API GET request).

[B]Data Logger[/B]
Scan for data in regular intervals and log the temperature, humidity and battery voltage.
See archive folder examples/datalogger.
[CODE=b4x]
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
[/CODE]

[I]B4R Log Snippet (Debug=True)[/I]
[CODE=b4x]
B4R Library rMiLYWSD03MMC - Example Data Logger v20210619
[DEBUG] Initializing
[DEBUG] Get client data
[DEBUG] Connecting...
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
[/CODE]

[B]Hints[/B]
* The [I]hcitool[/I] is used to get the BLE device MAC address (used under Linux $sudo bluetoothctl).
* The [I]gatttool[/I] is used to get the BLE device services and characteristics with descripters, but also to write configuration changes (used under Linux $gatttool -I -b A4:C1:38:38:A9:0C).
* If required, change the power level (current highest level P9 = 9dbm) in the CPP file, function Initialize, BLEDevice::setPower(ESP_PWR_LVL_P9, ESP_BLE_PWR_TYPE_SCAN);.
* If the device gets scanned, the little Bluetooth symbol on the LCD display is visible.

[B]Licence[/B]
GNU General Public License v3.0.

[B]Changelog[/B]
v1.00 (20210620) - Initial version

[B]ToDo[/B]
* Checkout if this library can be exposed to other Xiaomi BLE devices.
* Explore why: If the connection failed, in cases following error given by the package "lld_pdu_get_tx_flush_nb HCI packet count mismatch".
* Explore how to read the comfort status from the device (the "smiley").
* Explore how to read the history data or change various configurations.
* Watch the stack buffer - Log(StackBufferUsage). Check if 300 is enough.
### rBLEBeacon ESP32 by rwblinn
### 02/24/2025
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/165566/)

**B4R Library rBLEBeacon  
  
Purpose  
rBLEBeacon** is an open source library to create a Bluetooth Low Energy (BLE) Beacon using the ESP32 BLE feature.  
  
The purpose is to  

- run the BLE Beacon on ESP32 hardware with connected sensors, like a DHT22 (temperature & humidity).
- advertise sensor data (in regular intervals) with max size of 31 bytes (limited by the protocol).
- read advertised data by clients (no connection required) like BLE scanner, Home-Assistant or a B4A app (triggers reading in regular intervals).

**Features**  

- **advertise from the ESP32 in format Eddystone or Raw.**
- format [Eddystone Protocol Specification](https://github.com/google/eddystone/blob/master/protocol-specification.md) with Namespace ID: D20C9CB0A5D94BF7A3E1 (10 bytes) and Instance ID: 659E5A8E9C42 (6 bytes).
- format Raw with manufacturer\_data (Manufacturer ID + data)) or service\_data (Environmental Sensing service UUID 0x181A, no manufacturer\_data).
- advertising data every 5 seconds (set in B4R, change as required).
- written in C++ (using the Arduino IDE 2.3.4 and the B4Rh2xml tool).
- tested with B4R 4.00 (64 bit), ESP32 library 3.1.1.
- tested with an ESP32 Wrover Kit and the Arduino app nRF Connect.

**Files**  
rBLEBeacon.zip archive contains the library and sample projects.  
  
**Install**  
From the zip archive, copy the content of the library folder, to the B4R additional libraries folder keeping the folder structure.  
  
**Functions**  
Initialize BLE Beacon  
Name - Name of the BLE server.  
ErrorSub - Sub to log an error code.  

```B4X
Initialize (Name As String , Error As SubSubVoidByte)
```

  
  
Advertise Data  
data = Array as Bytes  

```B4X
Advertise(data() As Byte)
```

  
  
Advertise Raw  
Advertise data in raw format using manufacturer data or service data.  
For manufacturer data, the content should contain the manufacturer id + advertised data (from f.e. a sensor).  
For service data, the content could be specific like environment data (from f.e. a sensor).  
Environmental Sensing service UUID is 0x181A (Raw data type 0x16 = UUID + data).  
data - Array as Byte with any format.  
serviceinfo - Bool to use service data in the advertisement, else manufacturer id + data.  

```B4X
AdvertiseRaw(data() As Byte, serviceinfo As Boolean)
```

  
  
**Constants**  
Message Size  
Byte MAX\_ADV\_DATA\_SIZE = 31  
  
Warning and error codes  

```B4X
Byte ERROR_ADV_DATA_SIZE_TOO_LARGE  
Byte ERROR_ADV_DATA_SIZE_TOO_SMALL  
Byte ERROR_ADV_NO_DATA
```

  
  
**Events**  
Error  
Handle errors.  

```B4X
Error(code as byte)
```

  
  
**Examples**  

- Basic - Advertise a counter value every 5 seconds.
- TempHum - Advertise DHT22 sensor data temperature&humidity every 5 seconds.
- HomeAssistant-UI - Home-Assistant Custom Integration BLE Beacon DHT; ESP32 advertised data to 4 entities (see post #2).

**B4R TempHum Example**  
(without comments)  
  
![](https://www.b4x.com/android/forum/attachments/161643)  
  

```B4X
Sub Process_Globals  
    Private VERSION As String = "rBLEBeacon TempHum Example v20250211"  
    Public Serial1 As Serial  
    Private BLEBeacon As BLEBeacon  
    Private SerData As B4RSerializator    'ignore  
    Private DHT As DHTESP  
    Private DHTPinNumber As UInt = 0x04  
    Private Humidity As Int  
    Private Temperature As Int  
    Private TimerDataAdvertising As Timer  
    Private TimerDataAdvertisingInterval As ULong = 5000    'Milliseconds  
    Private bc As ByteConverter  
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log(CRLF, "[AppStart]", VERSION)  
    BLEBeacon.Initialize("BLEBeacon", "BLEBeacon_Error")  
    DHT.Setup22(DHTPinNumber)  
    TimerDataAdvertising.Initialize("TimerDataAdvertising_Tick", TimerDataAdvertisingInterval)  
    TimerDataAdvertising.Enabled = True  
    TimerDataAdvertising_Tick  
End Sub  
  
Sub TimerDataAdvertising_Tick  
    Temperature = DHT.GetTemperature * 100  ' convert float to int 19.30 → 1930  
    Humidity = DHT.GetHumidity * 100        ' convert float to int 92.40 → 9240  
    BLEBeacon_Advertise(bc.IntsToBytes(Array As Int(Temperature, Humidity)))  
End Sub  
  
Private Sub BLEBeacon_Advertise(data() As Byte)  
    If data == Null Then  
        Log("[ERROR][BLEBeacon_Advertise] No data.")  
        Return  
    End If  
    BLEBeacon.Advertise(data)  
End Sub  
  
Private Sub BLEBeacon_Error(code As Byte)  
    Log("[BLEBeacon_Error]code=",code)  
    Select code  
        Case BLEBeacon.ERROR_ADV_DATA_SIZE_TOO_LARGE  
            Log("[ERROR][Advertise] Data size exceeds maximum ", BLEBeacon.MAX_ADV_DATA_SIZE, " bytes.")  
    End Select  
End Sub  
  
Public Sub HexFromByte(b As Byte) As String  
    Return bc.HexFromBytes(Array As Byte(b))  
End Sub
```

  
  
**B4A TempHum Example**  
(B4XPages app, listed is the B4XMainPage without comments)  

```B4X
Sub Class_Globals  
    Private VERSION As String    = "BLEBeaconClient v20250211"  
    Private INFO As String        = "rBLEBeacon TempHum Example"  
    Private DEBUG As Boolean     = False  
    Private xui As XUI  
    Private Root As B4XView  
    Private btnScan As B4XView  
    Private lblState As B4XView  
    Private lblScanStatus As B4XView  
    Private pbScan As B4XLoadingIndicator  
    Private lblInfo As B4XView  
    Private lblTemperatureValue As B4XView  
    Private lblHumidityValue As B4XView  
    Private lblAdvertisedTime As B4XView  
    Private DEVICE_NAME As String            = "BLEBeacon"            'Default device name of the ESP32 BLE beacon as set in B4R    'ignore  
    Private DEVICE_MAC As String            = "30:C9:22:D1:80:2E"    'MAC address of the ESP32 BLE beacon    'ignore  
    Private SCAN_DURATION As Short = 5000                            'Max 5 seconds scannning - see StartScan  
    #if B4A  
    Private Manager As BleManager2  
    Private rp As RuntimePermissions  
    #else if B4i  
    Private manager As BleManager  
    #end if  
    Public  BeaconFound As Boolean = False  
    Private currentStateText As String = "UNKNOWN"  
    Private EDDYSTONE_UID_SIZE As Byte = 18     'Used to extract advertised data from ESP32 (see B4R)  
    Private TimerScanData As Timer  
    Private TimerScanDataInterval As Long = 10000  
    Private bc As ByteConverter    'ignore  
End Sub  
  
Public Sub Initialize  
    B4XPages.GetManager.LogEvents = True  
End Sub  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  
    B4XPages.SetTitle(Me, VERSION)  
    lblTemperatureValue.Text = "–"  
    lblHumidityValue.Text = "–"  
    lblInfo.Text = INFO  
    TimerScanData.Initialize("TimerScanData", TimerScanDataInterval)  
    TimerScanData.Enabled = False  
    Manager.Initialize("manager")  
    StateChanged  
    InitialScan  
End Sub  
  
Sub B4XPage_CloseRequest As ResumableSub  
    Dim sf As Object = xui.Msgbox2Async("Exit the app?", "Confirmation", "Yes", "", "No", Null)  
    Wait For (sf) Msgbox_Result (Result As Int)  
    If Result = xui.DialogResponse_Positive Then  
        'Completely close the app  
        ExitApplication  
    End If  
    Return True  
End Sub  
  
Sub TimerScanData_Tick  
    StartScan  
End Sub  
  
Sub InitialScan  
    Dim Permissions As List  
    Dim phone As Phone  
    If phone.SdkVersion >= 31 Then  
        Permissions = Array("android.permission.BLUETOOTH_SCAN", "android.permission.BLUETOOTH_CONNECT", rp.PERMISSION_ACCESS_FINE_LOCATION)  
    Else  
        Permissions = Array(rp.PERMISSION_ACCESS_FINE_LOCATION)  
    End If  
    For Each per As String In Permissions  
        rp.CheckAndRequest(per)  
        Wait For B4XPage_PermissionResult (Permission As String, Result As Boolean)  
        If Result = False Then  
            ToastMessageShow($"[ERROR] No BLE permission: ${Permission}"$, True)  
            Return  
        End If  
    Next  
    TimerScanData.Enabled = True  
    StateChanged  
End Sub  
  
Private Sub btnScan_Click  
    TimerScanData.Enabled = Not(TimerScanData.Enabled)  
    StateChanged  
End Sub  
  
Public Sub StateChanged  
    lblState.Text = currentStateText  
    lblScanStatus.Text = IIf(TimerScanData.Enabled, "ON", "OFF")  
    pbScan.Hide  
  
    If Not(TimerScanData.Enabled) Then  
        lblTemperatureValue.Text = "–"  
        lblHumidityValue.Text = "–"  
    End If  
End Sub  
  
Public Sub StartScan  
    BeaconFound = False  
    If Manager.State <> Manager.STATE_POWERED_ON Then  
        ToastMessageShow($"[ERROR][StartScan] BLE is not not powered on."$, True)  
    Else  
        pbScan.Show  
        Manager.Scan(Null)  
        Sleep(SCAN_DURATION)  
        Manager.StopScan  
        pbScan.Hide  
        If Not(BeaconFound) Then  
            TimerScanData.Enabled = False  
            StateChanged  
        End If  
    End If  
End Sub  
  
Sub SetSensorData(advertisingData As Map)  
    If advertisingData.ContainsKey(-1) Then  
        Dim rawData() As Byte = advertisingData.Get(-1)  
        If rawData.Length > EDDYSTONE_UID_SIZE Then  
            Dim sensorData(rawData.Length - EDDYSTONE_UID_SIZE) As Byte  
            bc.ArrayCopy(rawData, EDDYSTONE_UID_SIZE, sensorData, 0, rawData.Length - EDDYSTONE_UID_SIZE)  
            Dim thex As String = $"${HexFromByte(sensorData(1))}${HexFromByte(sensorData(0))}"$  
            Dim hhex As String = $"${HexFromByte(sensorData(3))}${HexFromByte(sensorData(2))}"$  
            Dim t As Float = Bit.ParseInt(thex, 16) / 100  
            Dim h As Float = Bit.ParseInt(hhex, 16) / 100  
            lblTemperatureValue.Text    = NumberFormat2(t, 0, 2, 2, False)  
            lblHumidityValue.Text        = NumberFormat2(h, 0 ,2, 2, False)  
            lblAdvertisedTime.Text        = DateTime.Time(DateTime.Now)  
        Else  
            Log("[ERROR][SetSensorData] No sensor data found.")  
        End If  
    Else  
        Log("[ERROR][SetSensorData] No manufacturer data found.")  
    End If  
End Sub  
  
Sub Manager_DeviceFound (Name As String, Id As String, AdvertisingData As Map, RSSI As Double)  
    'Two options: use name or mac  
    If Not(Name.EqualsIgnoreCase(DEVICE_NAME)) Then Return  
    'If Not(Id.EqualsIgnoreCase(DEVICE_MAC)) Then Return  
    BeaconFound = True  
    pbScan.Hide  
    SetSensorData(AdvertisingData)  
End Sub  
  
Sub Manager_StateChanged (State As Int)  
    Select State  
        Case Manager.STATE_POWERED_OFF  
            currentStateText = "POWERED OFF"  
        Case Manager.STATE_POWERED_ON  
            currentStateText = "POWERED ON"  
        Case Manager.STATE_UNSUPPORTED  
            currentStateText = "UNSUPPORTED"  
    End Select  
    StateChanged  
End Sub  
  
Public Sub HexFromByte(b As Byte) As String  
    Return bc.HexFromBytes(Array As Byte(b))  
End Sub
```

  
  
**To-Do**  
Example using serialized data.  
Improve Home Assistant integration.  
  
**Licence**  
GNU General Public License v3.0.
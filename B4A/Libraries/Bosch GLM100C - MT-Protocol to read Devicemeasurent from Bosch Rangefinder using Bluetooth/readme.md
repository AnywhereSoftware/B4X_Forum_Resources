### Bosch GLM100C - MT-Protocol to read Devicemeasurent from Bosch Rangefinder using Bluetooth by DonManfred
### 04/15/2024
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/160495/)

This is a B4A Library which uses the Bosch MT-Protocol to read Measurements from Bosch Rangefinders using Bluetooth/BLE.  
![](https://snapshots.basic4android.de/firefox_jxKwZ9fDUb.png)  
  
The Library should work with these Devices:  
  

```B4X
 static {  
        GLM_100_DEV_TYPES.put("3601K72Y00", "Bosch GLM 100-25 C");  
        GLM_100_DEV_TYPES.put("00Y27K1063", "Bosch GLM 100-25 C");  
        GLM_100_DEV_TYPES.put("3601K72Y50", "Bosch GLM 100-25 C");  
        GLM_100_DEV_TYPES.put("05Y27K1063", "Bosch GLM 100-25 C");  
        GLM_100_DEV_TYPES.put("3601K72YK0", "Bosch GLM 100-25 C");  
        GLM_100_DEV_TYPES.put("0KY27K1063", "Bosch GLM 100-25 C");  
    }  
  
    /**  
     * Static map for GLM 50-2 family devices. Bare tool number is key. Device name is value.  
     */  
    public static final Map<String, String> GLM_50_2_DEV_TYPES = new HashMap<>();  
    static {  
        GLM_50_2_DEV_TYPES.put("3601K72T00", "Bosch GLM50-27 C");  
        GLM_50_2_DEV_TYPES.put("00T27K1063", "Bosch GLM50-27 C");  
        GLM_50_2_DEV_TYPES.put("3601K72U00", "Bosch GLM50-27 CG");  
        GLM_50_2_DEV_TYPES.put("00U27K1063", "Bosch GLM50-27 CG");  
        GLM_50_2_DEV_TYPES.put("3601K72T10", "Bosch Blaze165-27C");  
        GLM_50_2_DEV_TYPES.put("01T27K1063", "Bosch Blaze165-27C");  
        GLM_50_2_DEV_TYPES.put("3601K72U10", "Bosch Blaze165-27CG");  
        GLM_50_2_DEV_TYPES.put("01U27K1063", "Bosch Blaze165-27CG");  
        GLM_50_2_DEV_TYPES.put("3601K72UK0", "Bosch GLM50-27 CG AP");  
        GLM_50_2_DEV_TYPES.put("0KU27K1063", "Bosch GLM50-27 CG AP");  
        GLM_50_2_DEV_TYPES.put("3601K72U50", "Bosch GLM50-27 CG JP");  
        GLM_50_2_DEV_TYPES.put("05U27K1063", "Bosch GLM50-27 CG JP");  
    }
```

  
  
The Library is given to the community by [USER=78150]@Wolli013[/USER] who paid the developement and give it for FREE to any registered B4X Member. Thank you Wolli!  
  
**BoschGLM**  
*…|<http://www.b4x.com>*  
**Author:** DonManfred  
**Version:** 1.0  

- **GLM100C**

- **Events:**

- **devicefound** (MTBluetoothDevice As Object)
- **measure** (value As Float)
- **status** (value As String)

- **Fields:**

- **ACTION\_CONNECTION\_STATUS\_UPDATE** As String
- **ACTION\_DEVICE\_LIST\_UPDATED** As String
- **EXTRA\_CONNECTION\_STATUS** As String
- **EXTRA\_DEVICE** As String
- **REQUEST\_ENABLE\_BT** As Int

- **Functions:**

- **cancelDiscovery**
*Stop Bluetooth scan*- **connect** (mtDevice As com.bosch.glm100c.bluetooth.MTBluetoothDevice) As Boolean
*Open connection to MTBluetoothDevice mtDevice  
 BluetoothConnection (classic connection) is opened if the connected mtDevice supports dual mode  
 BLEConnection (BLE connection) is opened, if the connected mtDevice supports only BLE  
 Return type: @return:true if successful, false otherwise*- **disconnect**
*Close an existing connection*- **Initialize** (EventName As String, debug As Boolean)
- **isBluetoothEnabled** As Boolean
*Checks if Bluetooth is enabled (switched on) on the Android device  
 Return type: @return:true if adapter is enabled, false otherwise*- **onConnectionStateChanged** (connection As com.bosch.mtprotocol.glm100C.connection.MtAsyncConnection)
*Callback that handles connection state changes  
 connection: connection, which state changed*- **onDeviceDiscovered** (result As com.bosch.glm100c.bluetooth.IScanResult)
- **onpause**
- **scanLeDevice** (enable As Boolean)
*Operating function to start or stop BLE device scan.  
 Triggering scan will start scanning for a period of {@value #PERIOD\_TO\_SCAN\_IN\_MS} and quit scan after this period.  
 Stopping scan will quit scan immediately  
 enable: will trigger BLE scanner if true and stop the scanner otherwise*- **startDiscovery** As Boolean
*Start Bluetooth scan*
- **Properties:**

- **Connected** As Boolean [read only]
*Will check if service is connected*- **Connection** As com.bosch.mtprotocol.MtConnection [read only]
*Will return the current Connection*- **ConnectionState** As Int [read only]
*Will return current connection state*- **CurrentDevice** As com.bosch.glm100c.bluetooth.MTBluetoothDevice [read only]
- **VisibleDevices** As java.util.Set [read only]
*Get currently discovered Bluetooth devices*
- **MTBluetoothDevice**

- **Functions:**

- **IsInitialized** As Boolean

- **Properties:**

- **Device** As com.bosch.glm100c.bluetooth.MTBluetoothDevice [read only]
- **DeviceAddress** As String [read only]
- **DeviceAlias** As String [read only]
- **DeviceName** As String [read only]
- **DisplayName** As String
### BLE (Bluetooth Low Energy) library by Erel
### 05/06/2021
[B4X Forum - B4i - Libraries](https://www.b4x.com/android/forum/threads/46099/)

B4i BLE library is now available. This library allows you to connect and read data from BLE peripheral devices.  
  
Using this library is quite simple. There are three main steps:  
1. Search for devices (assuming that the state is STATE\_POWERED\_ON).  
2. Connect to a device.  
3. Read data from the device.  
  
There are several events which you need to handle:  
*StateChanged (State As Int) **-*** This event is raised when you initialize BleManager and when the BLE adapter state changes. Only if the state is STATE\_POWERED\_ON then you can use this feature.  
  
*DeviceFound (Name As String, Id As String, AdvertisingData As Map, RSSI As Double)  **-*** Raised when a new device is discovered (after you call BleManager.Scan). The event parameters include the device Id, name, RSSI value and a Map with additional advertised data.  
  
*Connected (Services As List)* - Raised when a device is connected. The Services list holds the device service ids. The data on the device is stored in a tree like structure made of services that hold characteristics.  
  
*DataAvailable (Service As String, Characteristics As Map)* - Raised after you call Manager.ReadData. Service is the service that was read and Characteristics is a Map that holds the characteristics ids and values. The values are arrays of bytes.  
  
*Disconnected* - Raised after a failed connection or after a device has disconnected.  
  
Make sure to see the video in HD mode (click on the small gear button).  
[MEDIA=youtube]hnY7wVKcpzk[/MEDIA]  
  
  
**iBLE is now included as a preinstalled library.**  
  
Example was updated with a new requirement:  

```B4X
#PlistExtra: <key>NSBluetoothAlwaysUsageDescription</key><string>Bluetooth used to connect to …</string>
```

  
You should change the description as needed.  
  
B4XPages example: <https://www.b4x.com/android/forum/threads/b4x-ble-2-bluetooth-low-energy.59937/>
### BLE Chat - Connecting Android and iOS by Erel
### 03/14/2021
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/66543/)

[MEDIA=youtube]5-QyJEIxO74[/MEDIA]  
  
This example is based on the new PeripheralManager type introduced in iBLE v2.00.  
Please start with this tutorial: <https://www.b4x.com/android/forum/threads/ble-bluetooth-low-energy-peripheral.66542/>  
  
There are three programs: BlePeripheral, BleCentral\_iOS and BleCentral\_Android  
  
BlePeripheral is the one that implements the peripheral role.  
The other devices will connect to the peripheral and communicate with it. The peripheral will relay the messages to all connected devices.  
  
The code is quite simple. I will go over some interesting points:  
- The peripheral stores the connected central ids in a Map (as keys). This makes it easy to add or remove centrals without needing to deal with duplicates.  
  
- The centrals maintain a list with the messages that need to be sent. Only one message can be sent at a time so when WriteComplete is raised the next message is sent.  
  
- In B4i we need to call WriteWithResponse instead of Write as a response is expected. In B4A it is handled automatically.  
  
- The UUID sub is a useful utility that normalizes the 16 bit ids (4 hex characters) based on the platform:  

```B4X
Private Sub UUID(id As String) As String  
#if B4A  
   Return "0000" & id.ToLowerCase & "-0000-1000-8000-00805f9b34fb"  
#else if B4I  
   Return id.ToUpperCase  
#End If  
End Sub
```

  
  
- In B4i central we need to first call ReadData before we can call SetNotify and wait for the DataAvailable event.  
  
- In B4A the communication code is implemented in the Starter service.  
  
**Update:** Add to the B4i examples:  
  

```B4X
#PlistExtra: <key>NSBluetoothAlwaysUsageDescription</key><string>Explanation here</string>
```
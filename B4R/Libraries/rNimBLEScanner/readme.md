### rNimBLEScanner by rwblinn
### 03/27/2026
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/170698/)

**B4R Library rNimBLEScanner**  

---

  
  
**Brief  
rNimBLEScanner** is an open-source library providing BLE scanner functionality on ESP32 for B4R.  

---

  
  
**Purpose**  
This wrapper exposes a minimal BLE scanner interface for B4R, allowing:  

- Scan for BLE peripherals advertising manufacturer or service data.
- Set filters for Company ID and/or MAC address.
- Parse received data for selected devices.

---

  
  
**Development Info**  
This B4R library is:  

- a thin B4R NimBLE Scanner Wrapper.
- Written in C++ (Arduino IDE 2.3.4 and *B4Rh2xml* tool).
- Depends on the platform esp32@3.3.6, NimBLE library 2.3.8.
- Tested with ESP-WROOM-32.
- Tested with B4R 4.00 (64-bit).

---

  
  
**Compatibility**  

- Supports **ESP32-based boards only** (ESP8266 and AVR not supported).

---

  
  
**Files**  
The *rNimBLEScanner-NNN.zip* archive contains the library and examples.  
Examples:  

- Basic - Scan for 60 seconds, listens to new data (no duplicates) and log.
- Filters - Filter advertised data on MAC and Company ID.
- Parser - Parse selective device data for Govee GVH5075, GV5108, RuuviTag, ATC1441.

---

  
  
**Install**  
Copy the *rNimBLEScanner* library folder from the ZIP into your B4R **Additional Libraries** folder, keeping the folder structure intact.  
*Ensure* the ESP32 platform and the NimBLE library are installed using the Arduino IDE libraries manager.  

---

  
  
**Functions**  
  
Initialize(NewData As String)  
Initializes the BLE module and prepares target parameters.  
**NewData** - Callback when new data is received.  
  
Start(DurationMS As ULong, DoNotAllowDuplicates As Boolean)  
Scan for advertisements of the device with target MAC.  
**DurationMS** - Scan duration, 0 = scan forever.  
**DoNotAllowDuplicates** - Set to false to see every advertisement.  
  
Stop  
Stop scanning.  
  
SetCompanyFilter(CompanyID As UInt)  
Set filter for company id.  
**CompanyID** - Company ID as 2 bytes, i.e. 0xEC88  
  
SetMacFilter(TargetMAC() as Byte)  
Set filter for target MAC.  
**TargetMAC** - Array byte length 6, i.e. 0xa4,0xc1,0x38,0x4c,0x30,0x22  
  
SetDebug(Enabled As Boolean)  
Set debug flag.  
**Enabled** - Enable debug logging via Serial  

---

  
  
**Example**  

```B4X
Sub Process_Globals  
    Private VERSION As String = "rNimBLEScanner Basic v20260327"  
    Public Serial1 As Serial  
    Private BleScanner As NimBLEScanner  
    ' Scan duration for 60 seconds, 0=forever  
    Private SCAN_DURATION As ULong = 60000  
End Sub  
  
Sub AppStart  
    Serial1.Initialize(115200)  
    Log("[AppStart] ", VERSION)  
  
    BleScanner.Initialize("OnNewData")  
  
    ' Debug  
    BleScanner.SetDebug(True)  
    
    ' Scan for NN seconds and do not allow duplicates  
    BleScanner.Start(SCAN_DURATION, True)  
    ' See OnNewData for advertised data  
    
    Log("[AppStart] BLE Scanner started, duration=", SCAN_DURATION, " (0=forever)")  
End Sub  
  
' Handle data received from scanned peripherals.  
' Example:  
Sub OnNewData (MAC() As Byte, data() As Byte)  
    Log("[OnNewData] mac=", Convert.BytesToHex(MAC), " data=", Convert.BytesToHex(data))  
End Sub
```

  
  
Log Output  

```B4X
[OnNewData] mac=0DB4CEA52C66 data=060001092022507A0D4FC414306F541223D46B7291B9EC5E4AFA4CACBC  
[OnNewData] mac=702AD57E2326 data=75004204018060702AD57E2326722AD57E232501000000000000  
[OnNewData] mac=A4C138D11757 data=88EC000326603F00  
[OnNewData] mac=5DA8DB23D4A7 data=4C001007381F5B700F8E48  
[OnNewData] mac=CF268CBE962D data=4C0012020003  
[OnNewData] mac=A4C1384C3022 data=88EC0002B1C25600
```

  

---

  
  
**License**  
MIT – see LICENSE file.  

---

  
  
**Credits**  

- Developers & maintainers of the NimBLE library [<https://github.com/h2zero/NimBLE-Arduino>] (Apache License 2.0).

---

  
  
**Disclaimer**  

- All trademarks are property of their respective owners.
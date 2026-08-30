### rOneWireEx by rwblinn
### 08/26/2026
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/171905/)

**B4R Library rOneWireEx**  
  

---

  
  
**Brief  
rOneWireEx** is an open-source library wrapper for the Dallas/Maxim 1-Wire protocol, specifically optimized to fix strict execution timing and macro definition conflicts on the ESP32 platform.  
  

---

  
  
**Purpose**  

- Provides a dependable 1-Wire hardware communication layer for ESP32 and AVR microcontrollers.
- Solves the "all zeros" hardware discovery issue by bypassing internal framework timing lag.
- Allows dynamic resolution tuning (9-bit to 12-bit) to drastically reduce sensor conversion wait cycles.

---

  
  
**Development Info**  
This B4R library is:  

- A [OneWire library](https://github.com/PaulStoffregen/OneWire) wrapper with additional functions.
- Written in C++ using Arduino IDE 2.3.10 and the *B4Rh2xml* parsing tool.
- Depends on the platform (minimum version) esp32@3.3.11, Arduino UNO R4 Boards 1.6.0 and the native OneWire library 2.3.8.
- Tested with ESP-WROOM-32 (32-bit, 3V3 logic), Arduino UNO R4 (32-bit Renesas RA4M1 architecture, 5V logic).
- Tested with B4R 4.00 (64-bit).

---

  
  
**Test Setup**  
Arduino UNO R4, DS1820b Sensor High Temperature.  
  
![](https://www.b4x.com/android/forum/attachments/173151)  
  
  

---

  
  
**Compatibility**  

- Supports boards based on both AVR and ESP32 architectures.

  

---

  
  
**Files**  
The *rOneWireEx.zip* archive contains the compiled library assets and usage examples.  
  

---

  
**Install**  
Copy the *rOneWireEx* library folder from the ZIP into your B4R **Additional Libraries** folder, keeping the directory structure intact.  
*Ensure* the core underlying OneWire library is installed using your Arduino IDE libraries manager first.  
Several example in the folder *examples*.  
  

---

  
  
**Functions**  

- **Initialize (WirePin As Byte)**
Initializes the bus object. Sets the physical 1-Wire signal pin assignment.- **ReadAddress (Address() As Byte) As Boolean**
Scans the OneWire bus for the next available device address. Writes the unique 8-byte ROM address directly to the provided array. Returns True if a device is successfully found.
*Example output:* 28330A9497040373 (28 = Family code for DS18B20, 330A94970403 = Unique hardware serial number, 73 = CRC validation byte).- **ResetSearch**
Clears the internal library search state. The next call to ReadAddress will start scanning from the beginning of the bus.- **ReadTemperature (Address() As Byte) As Float**
Performs a full real-time reading block (Reset, Select, Convert, Delay, Read Scratchpad). Automatically auto-senses the active sensor resolution settings dynamically to optimize performance. Returns calculated Celsius value. Returns -127.0 if transmission fails or CRC checks drop.- **SetResolution (Address() As Byte, ResolutionBits As Byte) As Boolean**
Sets the operational resolution of a specific sensor (Accepted values: 9, 10, 11, 12). Updates internal non-volatile EEPROM registers.- **Reset As Boolean**
Performs a global hardware bus reset function. Returns True if a device on the line asserted a valid presence pulse.- **Select (Address() As Byte)**
Issues a direct hardware select command. Required to address a specific sensor after each bus Reset call.- **Skip**
Skips the long device selection loop process. Highly useful to accelerate data fetching when only a single sensor is wired to the bus pin.- **Write (Value As Byte, Power As Boolean)**
Writes a single command byte directly to the bus. Set Power to True if parasitic power is required immediately following the transmission.- **WriteBytes (Bytes() As Byte, Power As Boolean)**
Writes an entire array sequence to the bus.- **ReadBytes (Bytes() As Byte, Count As UInt)**
Reads raw data from the active bus sensor and populates it directly into the target buffer array up to the specified Count.- **CRC8 (Data() As Byte, Length As Byte) As Byte**
Computes a standard Dallas Semiconductor 8-bit cyclic redundancy check.- **GetDeviceType (Address() As Byte) As Byte**
Identifies the device type numerical category from its 8-byte ROM address.

- 1 = DS18B20
- 2 = DS18S20
- 3 = DS1822
- 4 = MAX31820
- 0 = Unknown / Other Hardware Profile

- **GetDeviceTypeName (Address() As Byte) As String**
Identifies the human-readable device model name directly from its 8-byte ROM address. Returns a memory-safe string allocated on the B4R internal memory frame stack.

- 0x28 = "DS18B20"
- 0x10 = "DS18S20OLD"
- 0x22 = "DS1822"
- 0x3B = "MAX31820"
- 0x01 = "iButton Key"
- 0x24 = "EEPROM Storage"
- Other = "UNKNOWN"

---

  
  
**Constants**  

- **RESOLUTION\_9 As Byte** = 9 (DS18B20 9-bit resolution profile)
- **RESOLUTION\_10 As Byte** = 10 (DS18B20 10-bit resolution profile)
- **RESOLUTION\_11 As Byte** = 11 (DS18B20 11-bit resolution profile)
- **RESOLUTION\_12 As Byte** = 12 (DS18B20 12-bit resolution profile)

---

  
  
**Example**  

```B4X
Sub Process_Globals  
    Private VERSION As String = "rOneWireEx Basic v20260826"  
    ' Communication  
    Public Serial1 As Serial  
    ' Sensor Bus  
    Private WireBus As OneWireEx  
    Private BUS_PIN As Byte = 4  
    Private Address(8) As Byte  
    ' Helper Tool  
    Private bc As ByteConverter  
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Log(CRLF, "[AppStart] ", VERSION)  
    ' Init onewire bus pin  
    WireBus.Initialize(BUS_PIN)  
    ' Search and read the connected device 64-bit address  
    WireBus.ResetSearch  
    If WireBus.ReadAddress(Address) Then  
        Log("[AppStart] address=", bc.HexFromBytes(Address), " type=", WireBus.GetDeviceTypeName(Address))  
        ' Expected log: [AppStart] address=28330A9497040373 type=DS18B20  
    End If  
End Sub
```

  

---

  
  
**Troubleshooting**  

- Pull-Up Resistor: The DS18B20 requires a 4.7 kΩ resistor connected between the Data line (Pin 4) and VCC (3.3V or 5V). Without this physical hardware pull-up, the data line cannot pull high, and communication or discovery fails completely returning all zeros.
- Ensure your specified pin variable declaration matches the physical hardware GPIO map layout of your target AVR or ESP32 module manufacturer specifications.
- Always issue a call to **ResetSearch** before starting a brand new multi-device iteration search loop sequence.

---

  
  
**License**  
MIT License - see LICENSE file.  
  

---

  
  
**Credits**  

- Developers & maintainers of the native Arduino [OneWire library](https://github.com/PaulStoffregen/OneWire).

---

  
**Disclaimer**  

- All product names, logos, and brands are property of their respective owners.
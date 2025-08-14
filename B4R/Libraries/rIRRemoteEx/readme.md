### rIRRemoteEx by rwblinn
### 06/06/2025
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/166899/)

**B4R Library rIRRemoteEx  
  
Purpose  
rIRRemoteEx** is an open source library for sending & receiving of infra-red (IR) signals.  
  
**Information**  

- This library is partial wrapped from the [Arduino-IRremote library](https://github.com/Arduino-IRremote/Arduino-IRremote).
- Enhanced with constants, functions and events.
- Protocols supported: NEC/NEC2/Onkyo/Apple, Panasonic/Kaseikyo, Denon/Sharp, Sony, RC5, RC6, LG, JVC, Samsung, FAST, Whynter, Lego Power Functions, Bosewave, MagiQuest, Universal Pulse Distance Width, Hash.
- Remote Controls (RC) used for testing (brackets protocol): NEC (NEC), SONY (SONY), Samsung (Samsung), Philips (RC6).
- Library developed in CPP, compiled using the Arduino-CLI and the B4Rh2xml tool. Exploring sketched with the Arduino IDE 2.3.6.
- Software: B4R 4.00 (64 bit), Arduino-CLI 1.2.2, IRremote 4.4.2.
- Hardware: Arduino UNO (AVR board), ESP32 (ESP32-WROOM-32), IR Modules Keyes KY-022 (IR Receiver) and KY-005 (IR-Transmitter).

**Notes**  
The background for developing this library is a request to create a Bluetooth to Infra-Red bridge (BT2IR-Bridge) to control via Android App a custom device in a factory.  
  
The library has been tested with the boards Arduino UNO and ESP32.  
  
The hardware pin definitions are in the file PinDefinitionsAndMore.h, located in the same folder as rIRRemoteEx.h & cpp.  
Lookup the pin mapping tables for the hardware used. Examples: Arduino UNO AVR board IR\_RECEIVE\_PIN (RX)=2,IR\_SEND\_PIN (TX)=3, ESP32 RX=15,TX=4.  
  
The transmitting LED  

- range differs by RC, from few cm to several meters.
- should be connected with a resistor: power supply 3,3V=120Ω, 5V=220Ω.

**Files**  
rIRRemoteEx-NNN.zip archive contains the library and sample projects.  
  
**Install**  
In the Arduino IDE 2.x install the library [IRremote](https://github.com/Arduino-IRremote/Arduino-IRremote).  
From the zip archive rIRRemoteEx-NNN.zip, copy the content of the library folder, to the B4R additional libraries folder keeping the folder structure.  
  
**Functions**  
See the folder examples.  
  
**Examples**  
List of some examples receiving, sending and both.  

- IrReceiver
- IrReceiverNEC
- IrReceiverUNKNOWN
- IrReceiverDumpToSerial
- IrReceiverSenderSONY
- IrReceiverSenderNECRaw
- IrReceiverSenderNECRawWithMicroseconds
- IrReceiverSenderMultipleProtocols
- IrSenderNEC
- IrRGBLEDStrip
- Make Project [make-ir-frame-visualizer](https://www.b4x.com/android/forum/threads/ir-frame-visualizer.167155/#post-1024746)

**B4R Basic Example IR Receiver**  
Receive commands from IR Remote Controls.  

```B4X
#Region Wiring  
'IR-Receiver KY-022 = Arduino UNO (wirecolor)  
'VCC = 5V (RED)  
'RX = 2 (YELLOW)  
'GND = GND (BLACK)  
#End Region  
  
#Region Project Attributes  
    #AutoFlushLogs: True  
    #CheckArrayBounds: True  
    #StackBufferSize: 300  
#End Region  
  
Sub Process_Globals  
    Private serialLine As Serial  
    Private irreceiver As IrReceiver  
    Private bc As ByteConverter  
End Sub  
  
Private Sub AppStart  
    serialLine.Initialize(115200)  
    Log(CRLF, "[AppStart]")  
   
    'Init the ireceiver with default pin 2 (see PinDefinitionsAndMore.h) and set the callback event NewData.  
    irreceiver.Initialize("NewData")  
  
    Log(CRLF, "[AppStart] waiting for commands from IR remote control…")  
End Sub  
  
'Handle new IR data received for all protocols including UNKNOWN.  
Private Sub NewData(data As IrDecodedData)  
   
    Log("[NewData] +++")  
    Log("[NewData] protocol=", data.Protocol, ",name=", data.ProtocolName, ",address=", data.Address, ",command=", data.Command, ",commandhex=", HexFromByte(data.Command), ",flags=", data.Flags, ",initialgapticks=", data.InitialGapTicks, ",flags_is_repeat=",irreceiver.IRDATA_FLAGS_IS_REPEAT)  
    Log("[NewData] rawdata len=", data.RawDataLen, ",decoded=", data.RawDataDecoded, ",hex=",HexFromULong(data.RawDataDecoded))  
    Log("[NewData] —")  
   
    'Delay must be greater than 5 ms (RECORD_GAP_MICROS), otherwise the receiver sees it As one long signal.  
    Delay(irreceiver.DELAY_LONG_AFTER_RECEIVE)  
End Sub  
  
#Region HELPER  
'Depends on: ByteConverter defined as global public bc as ByterConverter.  
  
'Get the HEX string from a single byte value.  
Public Sub HexFromByte(value As Byte) As String  
    Return bc.HexFromBytes(Array As Byte(value))  
End Sub  
  
'Get the HEX string from an ULong value.  
Public Sub HexFromULong(value As ULong) As String  
    Return bc.HexFromBytes(bc.ULongsToBytes(Array As ULong(value)))  
End Sub  
#End Region
```

  
  
**B4R Basic Example IR Sender**  
Send command using the NEC protocol with an Arduino UNO.  

```B4X
#Region Wiring  
'IR-Sender KY-005 = Arduino UNO (wirecolor)  
'VCC = 5V (RED)  
'TX = 3 (YELLOW)  
'GND = GND (BLACK)  
'The transmitting LED should be connected with a resistor: 3,3V=120Ω, 5V=220Ω  
#End Region  
  
#Region Project Attributes  
    #AutoFlushLogs: True  
    #CheckArrayBounds: True  
    #StackBufferSize: 300  
#End Region  
  
Sub Process_Globals  
    Public SerialLine As Serial  
    Public irsender As IrSender  
End Sub  
  
Private Sub AppStart  
    SerialLine.Initialize(115200)  
    Log(CRLF, "[AppStart]")  
   
    'Init the sender using the default pin 3.  
    irsender.Initialize()  
   
    CallSubPlus("SendNEC", 1000, 5)  
End Sub  
  
Private Sub SendNEC(tag As Byte)  
    Log("[SendNEC] Start")  
    irsender.SendNEC(0, 0x19, 0)  
End Sub
```

  
  
**To-Do**  

- Deeper dive in protocol PULSE\_DISTANCE (analyze timings using JT-LCR-T7).

**Credits**  

- Developer(s) of the IRremote library (License up to the version 2.7.0 GPLv2, from version 2.8.0 MIT).
- and of course Anywhere Software for providing the B4X suite of development tools plus the B4X community for sharing solutions&hints.

**License**  
GNU General Public License v3.0.  
  
**Development Notes**  
Some hints gathered during library development.  
  
**Documentation**  
Important is to carefully read the IRremote library documentation ([GitHub](https://github.com/Arduino-IRremote/Arduino-IRremote) & [API](https://arduino-irremote.github.io/Arduino-IRremote/index.html)).  
Prior wrapping the IRremote library, run some of the CPP examples from the Arduino IDE 2.x to get familiar with the library functions.  
For specific functions required, create simple CPP sketches first, which can be used in the wrapped library.  
  
**IRremote.hpp**  
rIRRemoteEx is wrapped from the library IRremote v4.4.1, installed in the Arduino IDE 2.x and referenced in the wrapped library.  
The library has been redesigned and it is advised to include the IRremote.hpp.  
After creating a minimal wrapped library, following error during linking of a simple B4R example:  

```B4X
C:\Users\NAME\AppData\Local\arduino\sketches\E3E7992B63366F312260AB202EF03CEE\sketch\B4RCore.cpp.o (symbol from plugin): In function `B4R::PrintToMemory::write(unsigned char)':  
(.text+0x0): multiple definition of `FeedbackLEDControl'  
and many more.
```

  
The IRremote doc provides [info](https://github.com/Arduino-IRremote/Arduino-IRremote?tab=readme-ov-file#using-the-new-hpp-files) to prevent this.  
Solution for rIRRemoteEx is to include the hpp file in the code (rIRRemoteEx.cpp) and not in the header (rIRRemoteEx.h).  
Header rIRRemoteEx.h  

```B4X
// Defines actual pin number for pins like IR_RECEIVE_PIN, IR_SEND_PIN for many different boards and architectures  
// Ensure this file is in the same folder as the rIRRemote.h.  
#include "PinDefinitionsAndMore.h"
```

  
Code rIRRemoteEx.cpp  
Include IRremote.hpp.  

```B4X
#include <IRremote.hpp>
```

  
  
**Custom Protocol**  
For a custom protocol, define own timing rules:  

- Mark duration is usually fixed (e.g., 560µs)
- Space for bit 0: short (e.g., 560µs)
- Space for bit 1: long (e.g., 1690µs)

So to encode bits like 0101, generate:  
Bit 0: 560, 560  
Bit 1: 560, 1690  
Bit 0: 560, 560  
Bit 1: 560, 1690  
Add header if needed (e.g., 9000, 4500) and optionally a final 560 mark.  
Use the data in the function SendRawWithMicroseconds.  
  
Next an example sub (advice call with CallSubPlus) of how to send raw data with carrier frequency 38 kHz:  

```B4X
Private Sub SendRawWithMicroseconds(Tag As Byte)  
    'Header mark, 0, 1, 0, 1, Final mark  
    Dim rawdata() As UInt = Array As UInt(9000, 4500, 560, 1690, 560, 1690, 560)  
    Log("[SendRawWithMicroseconds] rawdata len=", rawdata.Length)  
    irsender.SendRawWithMicroseconds(rawdata, 38)  
End Sub
```

  
  
**StackBufferSize**  
During the development of the examples, got issues like MCU endless restarting or IR send function hangs.  
After reducing the #StackBufferSize to 100 (or in some cases 300 was also fine), no issues anymore.  
It has been the opposite of what I expected — smaller stack = less room.  
But in this case, a large stack buffer (>300) may have:  

- Used too much SRAM, leaving too little for IR timing buffers or log output
- Caused heap fragmentation early in execution

Reducing the buffer freed up heap space for:  

- a function like SendRawWithMicroseconds() internal buffer use
- Log message strings
- B4R background tasks

Rule of Thumb: Balance Stack and Heap  

- Stack is for temporary/local vars in recursive calls
- Heap is for Array(), Log(), and libraries like IRsend

If not doing deep recursion or big local arrays, keep stack small (like 100–200) and let the rest be used by heap.
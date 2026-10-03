### rCommUart by rwblinn
### 09/29/2026
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/172171/)

**B4R Library rCommUart**  
  

---

  
  
**Brief  
rCommUart** is an open-source B4R library for generalized binary framed command transport over UART.   
It provides fixed-length frame handling, asynchronous reception, frame validation, data transmission, and standardized status responses.  
  

---

  
  
**Purpose**  

- Provides a simple binary communication layer over UART.
- Supports fixed-length data frames defined during initialization.
- Uses asynchronous reception to process incoming data without blocking the application.
- Provides *OnReceived* and *OnError* event callbacks.
- Provides standardized status responses for OK (ACK), Error (NAK), and Busy conditions.
- Supports the default UART interface and additional hardware UART ports on supported boards.
- Can be used as a lightweight transport layer between B4R and other systems or microcontrollers.

  

---

  
  
**Development Info**  
This B4R library is:  

- Written in B4R with inline C/C++ code for native hardware UART access.
- Dependent on the B4R runtime and the native UART implementation provided by the selected Arduino platform.
- Tested with Arduino UNO, Arduino Mega 2560, and ESP32 Wrover Kit.
- Tested with B4R 4.00 (64-bit).

  
**Platform Notes**  

- The default UART (UART0) is available through the standard B4R *Serial* object.
- Additional hardware UARTs require the corresponding conditional to be enabled.
- For Arduino Mega, set the *MEGA* conditional to enable UART1, UART2, and UART3.
- For ESP32, set the *ESP32* conditional to enable the additional UART interface supported by the library.
- Check the electrical voltage levels of the selected board before connecting external hardware. Arduino Mega uses 5 V logic; ESP32 uses 3.3 V logic.

  

---

  
  
**Test Setup**  
  
The development test program uses a simple LED control example.   
A three-byte binary frame is transmitted to the B4R device:  
  

```B4X
Byte 0: Header    = 0x19 (fixed)  
Byte 1: LED state = 0 or 1  
Byte 2: Footer    = 0x58 (fixed)
```

  
  
The configured frame size is 3 bytes. The client must ensure that exactly 3 bytes are transmitted for each frame.  
  
Example wiring:  
  

```B4X
MCU = LED  
D4  = Signal - White (DFRobot)  
5V  = VCC  
GND = GND  
  
MCU = Button  
D5  = Signal - Yellow (DFRobot)  
5V  = VCC  
GND = GND
```

  
  

---

  
  
**Files**  

- **rCommUart.b4xlib** - rCommUart library.
- **rCommUart-Examples.zip** - Example projects demonstrating library usage.

  

---

  
  
**Install**  
Copy the *rCommUart.b4xlib* file into your B4R **Additional Libraries** folder.  
  
No external platform libraries are required.  
  

---

  
  
**Functions**  

- **Initialize (stream As Stream, size As Int)**
Initializes the serial line and internal framing parameters. The frame size defines the number of bytes expected for each received frame.- **Write (data() As Byte)**
Sends the specified byte array as a frame or message over the serial interface.- **WriteStatusOk**
Dispatches a standardized success verification frame (ACK).- **WriteStatusErr**
Dispatches a standardized error fault frame (NAK).- **WriteStatusBusy**
Dispatches a standardized processing delay frame.- **InitializeMegaUART1 (size As Int)**
Initializes the additional hardware UART 1 on an Arduino Mega using TX1 and RX1. The frame size specifies the number of bytes expected for each received frame.- **InitializeMegaUART2 (size As Int)**
Initializes the additional hardware UART 2 on an Arduino Mega using TX2 and RX2. The frame size specifies the number of bytes expected for each received frame.- **InitializeMegaUART3 (size As Int)**
Initializes the additional hardware UART 3 on an Arduino Mega using TX3 and RX3. The frame size specifies the number of bytes expected for each received frame.- **InitializeEsp32UART1 (size As Int)**
Initializes hardware UART 1 on an ESP32 using TX1 and RX1. Not recommended; use UART 2 where possible.- **InitializeEsp32UART2 (size As Int)**
Initializes hardware UART 2 on an ESP32 using TX2 and RX2. The frame size specifies the number of bytes expected for each received frame.
  

---

  
  
**Events**  

- **CommUART\_OnReceived (buffer() As Byte)**
Called when a complete frame has been received. The received byte array contains the frame data.- **CommUART\_OnError**
Called when an error occurs during asynchronous UART reception.
  
The event methods must be implemented in the *Main* module:  
  

```B4X
Public Sub CommUART_OnReceived(buffer() As Byte)  
    ' Handle received frame.  
End Sub  
  
Public Sub CommUART_OnError  
    ' Handle reception error.  
End Sub
```

  
  

---

  
  
**Frame Format**  
  
rCommUart treats received data as fixed-length binary frames. The frame size is specified when the library is initialized.  
  
For the example application, the frame consists of three bytes:  
  

```B4X
+——–+————-+——–+  
| Byte 0 |    Byte 1   | Byte 2 |  
+——–+————-+——–+  
| 0x19   | LED state   | 0x58   |  
+——–+————-+——–+  
| Header |   Data      | Footer |  
+——–+————-+——–+
```

  
  

- **Byte 0 - Header:** Fixed value 0x19.
- **Byte 1 - Data:** LED state, where 0 = OFF and 1 = ON.
- **Byte 2 - Footer:** Fixed value 0x58.

  
The client is responsible for transmitting exactly the configured number of bytes for each frame.  
  

---

  
  
**Example**  
  

```B4X
Sub Process_Globals  
    Public SerialLine As Serial       ' UART0 (Port 0)  
    Private FRAME_SIZE As Int = 3     ' Must match the configured frame size  
    Private Led As Pin  
    Private LED_PINNR As Byte = 4     ' D4  
    Private LED_ON As Byte = 1  
End Sub  
  
Private Sub AppStart  
    SerialLine.Initialize(115200)  
    Led.Initialize(LED_PINNR, Led.MODE_OUTPUT)  
    Led.DigitalWrite(False)  
    CommUart.Initialize(SerialLine.Stream, FRAME_SIZE)  
End Sub  
  
' CommUART_OnReceived  
' Handle new data from the client.  
' Parameter:  
'   buffer - Byte array received  
Public Sub CommUART_OnReceived(buffer() As Byte)  
    If buffer.Length = FRAME_SIZE Then  
        Led.DigitalWrite(IIf(buffer(1) = LED_ON, True, False))  
    End If  
End Sub  
  
' CommUART_OnError  
Public Sub CommUART_OnError  
    Log("[Main.CommUART_OnError]")  
End Sub  
  
' CommUART_Write  
' Write data to the connected client.  
' Parameter:  
'   data - Byte array with frame-size length  
Private Sub CommUART_Write(data() As Byte)  
    CommUart.Write(data)  
End Sub
```

  
  

---

  
  
**Additional UART Ports**  
  
The additional UART methods are conditionally compiled because the available hardware serial ports depend on the target board.  
  
For an Arduino Mega, enable the *MEGA* conditional to provide access to:  

- **UART1:** TX1 / RX1
- **UART2:** TX2 / RX2
- **UART3:** TX3 / RX3

  
For ESP32, enable the *ESP32* conditional to provide the additional UART functionality supported by the library.  
  
**Important:** Arduino Mega uses 5 V logic levels, while ESP32 uses 3.3 V logic levels. Ensure that connected hardware is electrically compatible.  
  

---

  
  
**Troubleshooting**  

- **No data received:** Check that the UART is initialized at the same baud rate on both devices and that TX and RX are connected correctly.
- **Incomplete frames:** Ensure that the client transmits exactly the configured frame size for every frame.
- **Incorrect frame size:** The frame size passed to *Initialize* must match the number of bytes transmitted by the client.
- **Additional UART unavailable:** Check that the appropriate *MEGA* or *ESP32* conditional is enabled for the target board.
- **Electrical levels:** Verify that the connected devices use compatible logic levels. Arduino Mega uses 5 V logic and ESP32 uses 3.3 V logic.

  

---

  
  
**License**  
MIT License - see LICENSE file.  
  

---

  
  
**Disclaimer**  

- This library is provided "as is", without warranty of any kind, express or implied.
- The author assumes no responsibility for damage resulting from the use or misuse of the library or connected hardware.
- All product names, logos, and brands are property of their respective owners.
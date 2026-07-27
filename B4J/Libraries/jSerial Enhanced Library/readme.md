### jSerial Enhanced Library by Peter Simpson
### 07/24/2026
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/171635/)

Hello everyone.  
This is my own personal all‑in‑one **jSerial Enhanced** library. I use this library for all my personal and client work when it comes to serial communications. No iRandomAccessFile is needed to receive new data.  
  
I’ve added plenty of extra features for myself, but obviously you don’t need to use them. The basic send‑and‑receive functionality works perfectly once the COM port has been initialized and is open.  
  
This is the latest version of **jSerial** available on GitHub, so I wrapped it for my own use (and for my clients), and now I’m sharing it with the B4X community.  
  
I sometimes use this library to monitor industrial hardware communications, and also when testing Arduino and ESP32 code, as well as for other serial based communication solutions.  
  
[CLICK HERE](https://www.b4x.com/android/forum/threads/jserial-library.34762/) to use Erels original JSerial library.  
  
This library is fully asynchronous and non‑blocking. It operates on its own dedicated thread, and disconnecting the serial adapter while the port is open and the application is active does not result in a crash, ANR, or any other instability.  
  
This library can be used to monitor applications, control or query microcontrollers (such as Arduino, ESP, etc devices), or simply send and receive any data required when interacting with RS232‑based hardware.  
  
**B4J library tab:**  
![](https://www.b4x.com/android/forum/attachments/172565)  
  
**CH340**  
![](https://www.b4x.com/android/forum/attachments/172566)  
  
**Standard serial adapters also work**  
![](https://www.b4x.com/android/forum/attachments/172567)  
  
**SS\_jSerialEnhanced  
  
Author:** Peter Simpson  
**Version:** 1.0  

- **jSerialEnhanced**
*Enhanced Serial library for B4J using the jSerialComm backend.*

- **Events:**

- **BreakInterrupt()**
- **Closed()**
- **DataSent** (Data() As Byte)
- **Error** (Message As String)
- **FramingError** (Message As String)
- **LineReceived** (Line As String)
- **NewData** (Data() As Byte)
- **Opened()**
- **OverrunError** (Message As String)
- **ParityError** (Message As String)
- **PortAdded** (PortName As String)
- **PortDisconnected()**
- **PortReconfigured()**
- **PortRemoved** (PortName As String)
- **Reconnected()**
- **StatsUpdated** (Stats As Map)

- **Fields:**

- **AggregationIdleWindowMs** As Int
*Idle window (ms) after the last received byte before emitting one  
 aggregated \_NewData event. Increase to capture microbursts; decrease for lower latency.  
 Default: 20*- **AggregationMaxTotalMs** As Int
*Safety cap (ms) for total aggregation time to avoid waiting indefinitely  
 while coalescing a burst. Only raise this for very slow, long bursts.  
 Default: 500*- **AggregationPollMs** As Int
*Poll interval (ms) used while aggregating incoming bytes.  
 Lower values reduce aggregation latency; higher values reduce CPU wakeups.  
 Default: 5*- **EnableLoopbackSimulation** As Boolean
*Enables software loopback simulation.  
 EnableLoopbackSimulation returns written data as incoming data.*- **EnableLowLatency** As Boolean
*Requests low‑latency read behaviour.  
 EnableLowLatency reduces driver timeouts where supported.*- **SetDebugLogging** As Boolean
*Enables diagnostic logging.  
 SetDebugLogging writes internal debug messages to the log.*
- **Functions:**

- **BytesToHex** (data As Byte(), offset As Int, length As Int) As String
*Converts a byte array to a space‑separated hexadecimal string.  
 data is the byte array to convert.  
 Return a formatted hexadecimal string, or an empty string if the array is null or empty.*- **ClearInternalBuffer**
*Clears the internalBuffer contents.*- **Close**
*Closes the port and performs full cleanup.  
 Triggers PortDisconnected and Closed events.*- **DecodeBase64ToString** (base64 As String) As String
- **EncodeBase64FromString** (text As String) As String
*Encodes a standard Java String into a Base64 text representation.  
 text is the plain text String to encode. Must not be null.  
 Return a Base64‑encoded String representing the original text.*- **GetDeviceType** (portName As String) As String
*Returns a short chipset identifier based on the port's VID.*- **GetOpenPortName** As String
*Returns the system name of the currently open port.  
 Returns an empty string if no port is open.*- **GetPortInfo** (portName As String) As Map
*Returns a Map containing detailed hardware and USB information for the port.*- **GetStats** As Map
*Returns a Map containing current statistics.*- **HexToBytes** (hex As String) As Byte()
*Converts a hexadecimal string to a byte array.  
 Non‑hex characters are ignored. The string must contain an even number of hex digits.  
 hex is the hexadecimal string to convert.  
 Return a byte array containing the converted values.*- **Initialize** (EventName As String)
*Initialises the object and sets the event prefix.  
 EventName: the event name prefix for callbacks.*- **IsCTS** As Boolean
*Returns true if the CTS line is asserted.*- **IsDCD** As Boolean
*Returns true if the DCD line is asserted.*- **IsDSR** As Boolean
*Returns true if the DSR line is asserted.*- **IsPortBusy** (portName As String) As Boolean
*Returns true if the specified port appears to be busy.  
 Returns false if it can be opened or is already open by this instance.*- **IsRI** As Boolean
*Returns true if the RI line is asserted.*- **ListPorts** As List
*Returns a B4X List of available system COM port names.  
 The list is sorted in a human-friendly order.*- **Open** (portName As String, baud As Int, dataBits As Int, stopBits As Int, parity As Int) As Boolean
*Opens the specified serial port with the given parameters.  
 Returns true on success, false on failure.*- **PurgeAll**
*Clears internal buffers and attempts hardware purge if supported.*- **PurgeRX**
*Clears internal RX buffer and attempts hardware RX purge.*- **PurgeTX**
*Clears TX queue and attempts hardware TX purge.*- **ReadAvailable** As Byte()
*Returns a snapshot of currently available bytes in internalBuffer without consuming them.*- **ReadExact** (count As Int, timeoutMs As Long) As Byte()
*Read exactly 'count' bytes or null on timeout.  
 timeoutMs = 0 means non-blocking (single check).*- **ReadUntil** (terminator As Byte, timeoutMs As Long) As Byte()
*Read until the terminator byte is seen or timeout expires.  
 Returns the bytes up to and including the terminator, or null on timeout.  
 timeoutMs = 0 means non-blocking (single check).*- **ReadWithTimeout** (minBytes As Int, timeoutMs As Int) As Byte()
*Reads until at least minBytes are available or timeout expires.  
 Returns whatever bytes are available.*- **SendBreak** (durationMs As Int)
*Sends a break signal for the specified duration in milliseconds.*- **SetAccumulationDelay** (ms As Int)
*Sets the accumulation delay used to reduce fragmentation.  
 ms: delay in milliseconds.*- **SetFlowControl** (mode As Int)
*Sets the hardware flow control mode.  
 mode: one of the SerialPort.FLOW\_CONTROL\_\* constants.*- **SetParameters** (baud As Int, dataBits As Int, stopBits As Int, parity As Int)
*Applies new serial parameters to the open port and raises the  
 PortReconfigured event if the port is active.  
 baud specifies the baud rate.  
 dataBits specifies the number of data bits.  
 stopBits specifies the number of stop bits.  
 parity specifies the parity mode (0–4).*- **Write** (data As Byte())
*Queues a byte array for transmission.  
 If loopback is enabled, data is injected locally.*
- **Properties:**

- **EnableAutoReconnect** As Boolean
*Returns the current AutoReconnect setting.*- **SetDTR** As Boolean
*Returns the last known DTR state.*
  
**Enjoy…**
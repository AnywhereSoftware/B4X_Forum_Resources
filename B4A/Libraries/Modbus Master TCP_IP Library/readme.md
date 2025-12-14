### Modbus Master TCP/IP Library by Peter Simpson
### 12/11/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/169453/)

Hello everyone,  
Here is a Modbus library that I just wrapped to test some industrial Modbus TCP valves, so I thought that I would share it with the community. Using this library, you can connect your B4A apps directly to industrial devices (PLCs) over TCP to read and write Modbus data. Your app should (in theory) connect to any Modbud Server (Slave) devices running over Ethernet or WiFi.  
  
**B4A library tab (Network, not really needed)**  
![](https://www.b4x.com/android/forum/attachments/168795)  
  
**Important:**  
There are 4 separate files in the attached library zip file, place all 4 files in your B4A additional libraries folder.  
  
**Updated - B4A Modbus Master test app:**  
![](https://www.b4x.com/android/forum/attachments/168796)  
  
**SS\_ModbusMaster  
  
Author:** Peter Simpson  
**Version:** 1.01  

- **ModbusMasterTCP**

- **Events:**

- **CoilRead** (Success As Boolean, Data() As Boolean, Message As String)
- **ConnectionCheckDone** (IsLive As Boolean, Message As String)
- **DiagnosticRequest** (SubFunction As Int, Data As Int)
- **DiscreteInputRead** (Success As Boolean, Data() As Boolean, Message As String)
- **HoldingRegisterRead** (Success As Boolean, Data() As Short, Message As String)
- **InitResult** (Success As Boolean, Message As String)
- **InputRegisterRead** (Success As Boolean, Data() As Short, Message As String)
- **TestCompleted** (Success As Boolean, Message As String)
- **WriteResult** (Success As Boolean, Message As String)

- **Fields:**

- **TEST\_COIL** As Int
- **TEST\_DISCRETE** As Int
- **TEST\_HOLDING** As Int
- **TEST\_INPUT** As Int
- **TEST\_NONE** As Int
*Constants to control the initial connection test behavior.*
- **Functions:**

- **DiagnosticRequest** (SubFunction As Int, Data As Int) As Int
*Performs Modbus Function Code 8 (Diagnostics).  
 Supports Subfunction 0 (Return Query Data / Loopback) — echoes the integer data.  
 Raises the DiagnosticRequest event so B4A/B4J can receive the response.  
 SubFunction: The diagnostics subfunction code (only 0 supported).  
 Data: The integer data to echo back.*- **Disconnect**
*Disconnects and closes the underlying Modbus TCP connection.  
 After calling this, the connection must be re-initialised with Initialize() before further requests.*- **Initialize** (EventName As String, Host As String, Port As Int, Encapsulated As Boolean, KeepAlive As Boolean, Timeout As Int, Retries As Int, TestFunction As Int, TestAddress As Int)
*Initializes the Modbus TCP connection parameters and attempts to configure the library.  
 This function is asynchronous and raises the InitResult event upon completion.  
 EventName: The prefix used for the callback events (e.g., "MB" will raise MB\_InitResult).  
 Host: The IP address or hostname of the Modbus TCP slave device (or TCP/RTU gateway).  
 Port: The TCP port of the Modbus device (usually 502).  
 Encapsulated: If true, uses Modbus RTU over TCP (Encapsulated). False for standard Modbus TCP.  
 KeepAlive: If true, the TCP socket connection is kept alive between requests.  
 Timeout: The connection and request timeout in milliseconds.  
 Retries: The number of retries the library will perform for failed requests.  
 TestFunction: The memory area to use for the connection heartbeat test. Use one of TEST\_\* constants (0–4).  
 TestAddress: The address to read during the heartbeat test (ignored if TestFunction is TEST\_NONE).*- **IsInitialized** As Boolean
*Returns whether the Modbus connection is currently ready to process requests.*- **ReadCoil** (Start As Int, Len As Int)
*Reads a contiguous block of Coil Statuses (Function Code 1).  
 The result is returned asynchronously in the CoilRead event.  
 Start: The starting address of the first coil to read (0-based).  
 Len: The number of coils to read.*- **ReadDiscreteInput** (Start As Int, Len As Int)
*Reads a contiguous block of Discrete Inputs (Function Code 2).  
 The result is returned asynchronously in the DiscreteInputRead event.  
 Start: The starting address of the first discrete input to read (0-based).  
 Len: The number of discrete inputs to read.*- **ReadHoldingRegisters** (Start As Int, Len As Int)
*Reads a contiguous block of Holding Registers (Function Code 3).  
 The result is returned asynchronously in the HoldingRegisterRead event.  
 Data is returned as an array of Short (16-bit signed integers).  
 Start: The starting address of the first register to read (0-based).  
 Len: The number of registers to read.*- **ReadInputRegisters** (Start As Int, Len As Int)
*Reads a contiguous block of Input Registers (Function Code 4).  
 The result is returned asynchronously in the InputRegisterRead event.  
 Data is returned as an array of Short (16-bit signed integers).  
 Start: The starting address of the first register to read (0-based).  
 Len: The number of registers to read.*- **ReadWriteMultipleRegisters** (ReadStart As Int, ReadLen As Int, WriteStart As Int, WriteValues As Short())
*Function Code 23: Read/Write Multiple Registers (implemented as FC16 followed by FC3).  
 Reads a block of holding registers while writing another block in a chained two-step sequence.  
 On success, results are raised via HoldingRegisterRead; write results and errors via WriteResult.  
 ReadStart: The starting address of the registers to read (0-based).  
 ReadLen: The number of registers to read.  
 WriteStart: The starting address of the registers to write (0-based).  
 WriteValues: The array of values to write starting at WriteStart.*- **TestFunction**
*Executes a full self-test sequence based on the underlying Modbus connection state.  
 The result is returned asynchronously in the TestCompleted event.  
 Should be called after a successful Initialize().*- **WriteCoil** (Offset As Int, Value As Boolean)
*Writes a single Coil value (Function Code 5).  
 The result is returned asynchronously in the WriteResult event.  
 Offset: The address of the coil to write to (0-based).  
 Value: The boolean value (True/False) to write to the coil.*- **WriteCoils** (Start As Int, Values As Boolean())
*Writes multiple Coil values (Function Code 15).  
 The result is returned asynchronously in the WriteResult event.  
 Start: The starting address of the first coil to write (0-based).  
 Values: An array of boolean values written sequentially starting from Start.*- **WriteRegister** (Offset As Int, Value As Int)
*Writes a single Holding Register value (Function Code 6).  
 The result is returned asynchronously in the WriteResult event.  
 Offset: The address of the register to write to (0-based).  
 Value: The 16-bit integer value (Short-compatible) to write to the register.*- **WriteRegisters** (Start As Int, Values As Short())
*Writes multiple Holding Register values (Function Code 16).  
 The result is returned asynchronously in the WriteResult event.  
 Start: The starting address of the first register to write (0-based).  
 Values: An array of 16-bit integer values written sequentially starting from Start.*
- **Properties:**

- **HostAddress** As String [read only]
*Returns the host address configured during Initialize().*- **SlaveID** As Int
*Property: Gets and Sets the Modbus Slave Unit ID (1–247).  
 This value is used for all subsequent requests while the connection is active.*
[HEADING=1][SIZE=4]B4A Modbus Master quick reference (FC → Method)[/SIZE][/HEADING]  
[TABLE]  
[TR]  
[TH]FC (Hex)[/TH]  
[TH]FC (Dec)[/TH]  
[TH]Description[/TH]  
[TH]Data Type[/TH]  
[TH]R/W Operation[/TH]  
[TH]Method Name[/TH]  
[TH]Event Raised[/TH]  
[/TR]  
[TR]  
[TD]0x01[/TD]  
[TD]FC1[/TD]  
[TD]Read Coils[/TD]  
[TD]Coil (Discrete Output)[/TD]  
[TD]Read (R)[/TD]  
[TD]ReadCoil(Start, Len)[/TD]  
[TD]\_coilread[/TD]  
[/TR]  
[TR]  
[TD]0x02[/TD]  
[TD]FC2[/TD]  
[TD]Read Discrete Inputs[/TD]  
[TD]Discrete Input[/TD]  
[TD]Read (R)[/TD]  
[TD]ReadDiscreteInput(Start, Len)[/TD]  
[TD]\_discreteinputread[/TD]  
[/TR]  
[TR]  
[TD]0x03[/TD]  
[TD]FC3[/TD]  
[TD]Read Holding Registers[/TD]  
[TD]Holding Register[/TD]  
[TD]Read (R)[/TD]  
[TD]ReadHoldingRegisters(Start, Len)[/TD]  
[TD]\_holdingregisterread[/TD]  
[/TR]  
[TR]  
[TD]0x04[/TD]  
[TD]FC4[/TD]  
[TD]Read Input Registers[/TD]  
[TD]Input Register[/TD]  
[TD]Read (R)[/TD]  
[TD]ReadInputRegisters(Start, Len)[/TD]  
[TD]\_inputregisterread[/TD]  
[/TR]  
[TR]  
[TD]0x05[/TD]  
[TD]FC5[/TD]  
[TD]Write Single Coil[/TD]  
[TD]Coil (Discrete Output)[/TD]  
[TD]Write (W)[/TD]  
[TD]WriteCoil(Offset, Value)[/TD]  
[TD]\_writeresult[/TD]  
[/TR]  
[TR]  
[TD]0x06[/TD]  
[TD]FC6[/TD]  
[TD]Write Single Register[/TD]  
[TD]Holding Register[/TD]  
[TD]Write (W)[/TD]  
[TD]WriteRegister(Offset, Value)[/TD]  
[TD]\_writeresult[/TD]  
[/TR]  
[TR]  
[TD]0x08[/TD]  
[TD]FC8[/TD]  
[TD]Diagnostic (Loopback)[/TD]  
[TD]N/A[/TD]  
[TD]Diagnostic[/TD]  
[TD]DiagnosticRequest(SubFunction, Data)[/TD]  
[TD]\_diagnosticrequest[/TD]  
[/TR]  
[TR]  
[TD]0x0F[/TD]  
[TD]FC15[/TD]  
[TD]Write Multiple Coils[/TD]  
[TD]Coil (Discrete Output)[/TD]  
[TD]Write (W)[/TD]  
[TD]WriteCoils(Start, Values)[/TD]  
[TD]\_writeresult[/TD]  
[/TR]  
[TR]  
[TD]0x10[/TD]  
[TD]FC16[/TD]  
[TD]Write Multiple Registers[/TD]  
[TD]Holding Register[/TD]  
[TD]Write (W)[/TD]  
[TD]WriteRegisters(Start, Values)[/TD]  
[TD]\_writeresult[/TD]  
[/TR]  
[TR]  
[TD]0x17[/TD]  
[TD]FC23[/TD]  
[TD]Read/Write Multiple Registers.  
Implemented as Chained **FC16 + FC3**[/TD]  
[TD]Holding Register[/TD]  
[TD]Read/Write (R/W)[/TD]  
[TD]ReadWriteMultipleRegisters  
(ReadStart, ReadLen, WriteStart, WriteValues)[/TD]  
[TD]\_holdingregisterread and \_writeresult[/TD]  
[/TR]  
[/TABLE]  
  
**PLEASE TAKE NOTE**:  

1. The \_Initialize function was updated adding TestFunction & TestAddress to the end of the signature
2. Renamed the library from ModbusMaster to ModbusMasterTCP for continuity with the Slave library
3. Removed SLAVE\_ID = x (No longer needed)
4. Removed ALL references of 'SlaveId As Int' from all of the Read and Write signatures. If need be, you can now set or switch the SlaveID at will by using ModBus.SlaveID = x (x being the ID number).

**Update: V1.01**  

- Cleaned up the JavaDoc comments
- Updated all \_write events to show wrote values
- Added TestCompleted Event
- Added DiagnosticRequest Event
- Added InputRegisterRead Event
- Added DiscreteInputRead Event
- Added Modbus Function 8 (Loopback)
- Added Modbus Function 15
- Added Modbus Function 23 (FC16 + FC3 chained)
- Added TestFunction Function
- Added WriteCoils Function
- Added ReadWriteMultipleRegisters Function
- Added TEST\_NONE Field
- Added TEST\_COIL Field
- Added TEST\_DISCRETE Field
- Added TEST\_HOLDING Field
- Added TEST\_INPUT Field
- Added isModbusReady Field
- Updated the test app (attached)

Plus a few other improvements.  
  
D = 61+64  
  
  
[SIZE=4]**Enjoy…**[/SIZE]
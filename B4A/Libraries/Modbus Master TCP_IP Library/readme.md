### Modbus Master TCP/IP Library by Peter Simpson
### 12/01/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/169453/)

Hello everyone,  
Here is a Modbus library that I just wrapped to test something out, so I thought that I would share it with the community. Using this library, you can connect your B4A apps directly to industrial devices (PLCs) over TCP to read and write Modbus data. Your app should (in theory) connect to any Modbud slave device running over Ethernet or WiFi. I've fully tested this library and it should work as advertised. I'll be releasing V1.01 in the next few days with the extra functions highlighted red in the table below).  
  
**B4A library tab (XUI Views is just for the test app)**  
![](https://www.b4x.com/android/forum/attachments/168588)  
  
**Important:**  
There are 4 separate files in the attached library zip file, place all 4 files in your B4A additional libraries folder.  
  
**B4A Modbus Master test app screenshot:**  
![](https://www.b4x.com/android/forum/attachments/168589)  
  
**SS\_ModbusMaster  
  
Author:** Peter Simpson  
**Version:** 1.0  

- **ModbusMaster**

- **Events:**

- **CoilRead** (Success As Boolean, Data() As Boolean, Message As String)
- **ConnectionCheckDone** (IsLive As Boolean, Message As String)
- **DiscreteInputRead** (Success As Boolean, Data() As Boolean, Message As String)
- **HoldingRegisterRead** (Success As Boolean, Data() As Short, Message As String)
- **InitResult** (Success As Boolean, Message As String)
- **InputRegisterRead** (Success As Boolean, Data() As Short, Message As String)
- **WriteResult** (Success As Boolean, Message As String)

- **Functions:**

- **Disconnect**
*Disconnects and closes the underlying Modbus TCP connection.  
 This should be called when the application exits or the Modbus communication is no longer required.  
 After calling this, the connection must be re-initialized using Initialize() before further requests can be made.*- **Initialize** (EventName As String, Host As String, Port As Int, Encapsulated As Boolean, KeepAlive As Boolean, Timeout As Int, Retries As Int)
*Initializes the Modbus TCP connection parameters and attempts to connect to the PLC/slave device.  
 This function is asynchronous and raises the InitResult event upon completion.  
 EventName: The prefix used for the callback events (e.g., "MB" will raise MB\_InitResult).  
 Host: The IP address or hostname of the Modbus TCP slave device.  
 Port: The TCP port of the Modbus slave (usually 502).  
 Encapsulated: If true, uses Modbus RTU over TCP (Encapsulated) format. Set false for standard Modbus TCP.  
 KeepAlive: If true, the TCP socket connection is kept alive between requests.  
 Timeout: The connection and request timeout in milliseconds.  
 Retries: The number of times the library will retry a failed connection or request.*- **IsInitialized** As Boolean
*Checks if the Modbus connection has been successfully initialized and is currently ready to process requests.  
 This returns true only after the initial connection heartbeat is successful.  
 Return type: @return:True if the connection is ready; otherwise, False.*- **ReadCoil** (SlaveId As Int, Start As Int, Len As Int)
*Reads a contiguous block of Coil Statuses (Function Code 1).  
 The result is returned asynchronously in the CoilRead event.  
 SlaveId: The unique slave address (unit identifier) of the Modbus device.  
 Start: The starting address of the first coil to read (0-based).  
 Len: The number of coils to read.*- **ReadDiscreteInput** (SlaveId As Int, Start As Int, Len As Int)
*Reads a contiguous block of Discrete Inputs (Function Code 2).  
 The result is returned asynchronously in the DiscreteInputRead event.  
 SlaveId: The unique slave address (unit identifier) of the Modbus device.  
 Start: The starting address of the first discrete input to read (0-based).  
 Len: The number of discrete inputs to read.*- **ReadHoldingRegisters** (SlaveId As Int, Start As Int, Len As Int)
*Reads a contiguous block of Holding Registers (Function Code 3).  
 The result is returned asynchronously in the HoldingRegisterRead event. The data is returned as an array of Short (16-bit signed integers).  
 SlaveId: The unique slave address (unit identifier) of the Modbus device.  
 Start: The starting address of the first register to read (0-based).  
 Len: The number of registers to read.*- **ReadInputRegisters** (SlaveId As Int, Start As Int, Len As Int)
*Reads a contiguous block of Input Registers (Function Code 4).  
 The result is returned asynchronously in the InputRegisterRead event. The data is returned as an array of Short (16-bit signed integers).  
 SlaveId: The unique slave address (unit identifier) of the Modbus device.  
 Start: The starting address of the first register to read (0-based).  
 Len: The number of registers to read.*- **WriteCoil** (SlaveId As Int, Offset As Int, Value As Boolean)
*Writes a single Coil value (Function Code 5).  
 The result is returned asynchronously in the WriteResult event.  
 SlaveId: The unique slave address (unit identifier) of the Modbus device.  
 Offset: The address of the coil to write to (0-based).  
 Value: The boolean value (True/False) to write to the coil.*- **WriteRegister** (SlaveId As Int, Offset As Int, Value As Int)
*Writes a single Holding Register value (Function Code 6).  
 The result is returned asynchronously in the WriteResult event.  
 SlaveId: The unique slave address (unit identifier) of the Modbus device.  
 Offset: The address of the register to write to (0-based).  
 Value: The 16-bit integer value (Short in B4A) to write to the register.*- **WriteRegisters** (SlaveId As Int, Start As Int, Values As Short())
*Writes multiple Holding Register values (Function Code 16).  
 The result is returned asynchronously in the WriteResult event.  
 SlaveId: The unique slave address (unit identifier) of the Modbus device.  
 Start: The starting address of the first register to write (0-based).  
 Values: An array of 16-bit integer values (Shorts in B4A) to write sequentially starting from the Start address.*
- **Properties:**

- **HostAddress** As String [read only]
*Returns the IP address or hostname of the Modbus TCP slave device   
 that was set during the last call to Initialize().*
[HEADING=1][SIZE=4]B4A Modbus Master quick reference (FC → Method)[/SIZE][/HEADING]  
[TABLE]  
[TR]  
[TH][SIZE=4]FC (Hex)[/SIZE][/TH]  
[TH][SIZE=4]FC (Dec)[/SIZE][/TH]  
[TH][SIZE=4]Description[/SIZE][/TH]  
[TH][SIZE=4]Data Type[/SIZE][/TH]  
[TH][SIZE=4]R/W Operation[/SIZE][/TH]  
[TH][SIZE=4]Method Name[/SIZE][/TH]  
[TH][SIZE=4]Event Raised[/SIZE][/TH]  
[/TR]  
[TR]  
[TD][SIZE=4]0x01[/SIZE][/TD]  
[TD][SIZE=4]FC1[/SIZE][/TD]  
[TD][SIZE=4]Read Coils[/SIZE][/TD]  
[TD][SIZE=4]Coil (Discrete Output)[/SIZE][/TD]  
[TD][SIZE=4]Read (R)[/SIZE][/TD]  
[TD][SIZE=4]ReadCoil(SlaveId, Start, Len)[/SIZE][/TD]  
[TD][SIZE=4]\_coilread[/SIZE][/TD]  
[/TR]  
[TR]  
[TD][SIZE=4]0x02[/SIZE][/TD]  
[TD][SIZE=4]FC2[/SIZE][/TD]  
[TD][SIZE=4]Read Discrete Inputs[/SIZE][/TD]  
[TD][SIZE=4]Discrete Input[/SIZE][/TD]  
[TD][SIZE=4]Read (R)[/SIZE][/TD]  
[TD][SIZE=4]ReadDiscreteInput(SlaveId, Start, Len)[/SIZE][/TD]  
[TD][SIZE=4]\_discreteinputread[/SIZE][/TD]  
[/TR]  
[TR]  
[TD][SIZE=4]0x03[/SIZE][/TD]  
[TD][SIZE=4]FC3[/SIZE][/TD]  
[TD][SIZE=4]Read Holding Registers[/SIZE][/TD]  
[TD][SIZE=4]Holding Register[/SIZE][/TD]  
[TD][SIZE=4]Read (R)[/SIZE][/TD]  
[TD][SIZE=4]ReadHoldingRegisters(SlaveId, Start, Len)[/SIZE][/TD]  
[TD][SIZE=4]\_holdingregisterread[/SIZE][/TD]  
[/TR]  
[TR]  
[TD][SIZE=4]0x04[/SIZE][/TD]  
[TD][SIZE=4]FC4[/SIZE][/TD]  
[TD][SIZE=4]Read Input Registers[/SIZE][/TD]  
[TD][SIZE=4]Input Register[/SIZE][/TD]  
[TD][SIZE=4]Read (R)[/SIZE][/TD]  
[TD][SIZE=4]ReadInputRegisters(SlaveId, Start, Len)[/SIZE][/TD]  
[TD][SIZE=4]\_inputregisterread[/SIZE][/TD]  
[/TR]  
[TR]  
[TD][SIZE=4]0x05[/SIZE][/TD]  
[TD][SIZE=4]FC5[/SIZE][/TD]  
[TD][SIZE=4]Write Single Coil[/SIZE][/TD]  
[TD][SIZE=4]Coil (Discrete Output)[/SIZE][/TD]  
[TD][SIZE=4]Write (W)[/SIZE][/TD]  
[TD][SIZE=4]WriteCoil(SlaveId, Offset, Value)[/SIZE][/TD]  
[TD][SIZE=4]\_writeresult[/SIZE][/TD]  
[/TR]  
[TR]  
[TD][SIZE=4]0x06[/SIZE][/TD]  
[TD][SIZE=4]FC6[/SIZE][/TD]  
[TD][SIZE=4]Write Single Register[/SIZE][/TD]  
[TD][SIZE=4]Holding Register[/SIZE][/TD]  
[TD][SIZE=4]Write (W)[/SIZE][/TD]  
[TD][SIZE=4]WriteRegister(SlaveId, Offset, Value)[/SIZE][/TD]  
[TD][SIZE=4]\_writeresult[/SIZE][/TD]  
[/TR]  
[TR]  
[TD][SIZE=4]0x08[/SIZE][/TD]  
[TD][SIZE=4]FC8 Using Loopback V1.01[/SIZE][/TD]  
[TD][SIZE=4]Diagnostic (Loopback)[/SIZE][/TD]  
[TD][SIZE=4]N/A[/SIZE][/TD]  
[TD][SIZE=4]Diagnostic[/SIZE][/TD]  
[TD][SIZE=4]DiagnosticRequest(SlaveId, SubFunction, Data)[/SIZE][/TD]  
[TD][SIZE=4]\_diagnosticrequest[/SIZE][/TD]  
[/TR]  
[TR]  
[TD][SIZE=4]0x0F[/SIZE][/TD]  
[TD][SIZE=4]FC15 V1.01[/SIZE][/TD]  
[TD][SIZE=4]Write Multiple Coils[/SIZE][/TD]  
[TD][SIZE=4]Coil (Discrete Output)[/SIZE][/TD]  
[TD][SIZE=4]Write (W)[/SIZE][/TD]  
[TD][SIZE=4]WriteCoils(SlaveId, Start, Values)[/SIZE][/TD]  
[TD][SIZE=4]\_writeresult[/SIZE][/TD]  
[/TR]  
[TR]  
[TD][SIZE=4]0x10[/SIZE][/TD]  
[TD][SIZE=4]FC16[/SIZE][/TD]  
[TD][SIZE=4]Write Multiple Registers[/SIZE][/TD]  
[TD][SIZE=4]Holding Register[/SIZE][/TD]  
[TD][SIZE=4]Write (W)[/SIZE][/TD]  
[TD][SIZE=4]WriteRegisters(SlaveId, Start, Values)[/SIZE][/TD]  
[TD][SIZE=4]\_writeresult[/SIZE][/TD]  
[/TR]  
[TR]  
[TD][SIZE=4]0x17[/SIZE][/TD]  
[TD][SIZE=4]FC23 Using FC16 + FC3 V1.01[/SIZE][/TD]  
[TD][SIZE=4]Read/Write Multiple Registers. Implemented as Chained **FC16 + FC3**[/SIZE][/TD]  
[TD][SIZE=4]Holding Register[/SIZE][/TD]  
[TD][SIZE=4]Read/Write (R/W)[/SIZE][/TD]  
[TD][SIZE=4]ReadWriteMultipleRegisters(…)[/SIZE][/TD]  
[TD][SIZE=4]\_holdingregisterread and \_writeresult[/SIZE][/TD]  
[/TR]  
[/TABLE]  
[HEADING=2][/HEADING]  
  
[SIZE=4]**Enjoy…**[/SIZE]
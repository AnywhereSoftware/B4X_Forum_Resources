### Modbus Master TCP/IP Library by Peter Simpson
### 11/26/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/169453/)

Hello everyone,  
Here is a Modbus library that I just wrapped to test something out, so I thought that I would share it with the community. Using this library, you can connect your B4A apps directly to industrial devices (PLCs) over TCP to read and write Modbus data. Your app should (in theory) connect to any device running over Ethernet or WiFi. I've fully tested this library and it should work as advertised. I'll be releasing V1.01 in the next few days with extra functions (highlighted in red in the table below).  
  
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
  
**The library has the following Function Code (FC) functions:**  
[TABLE]  
[TR]  
[TH]FC (Hex)[/TH]  
[TH]FC (Dec)[/TH]  
[TH]Description[/TH]  
[TH]Modbus Data Type[/TH]  
[TH]Data Access Type[/TH]  
[TH]R/W Operation[/TH]  
[/TR]  
[TR]  
[TD]0x01[/TD]  
[TD]1[/TD]  
[TD]Read Coils[/TD]  
[TD]Coil (Discrete Output)[/TD]  
[TD]Read/Write[/TD]  
[TD]Read (R)[/TD]  
[/TR]  
[TR]  
[TD]0x02[/TD]  
[TD]2[/TD]  
[TD]Read Discrete Inputs[/TD]  
[TD]Discrete Input[/TD]  
[TD]Read-Only[/TD]  
[TD]Read (R)[/TD]  
[/TR]  
[TR]  
[TD]0x03[/TD]  
[TD]3[/TD]  
[TD]Read Holding Registers[/TD]  
[TD]Holding Register[/TD]  
[TD]Read/Write[/TD]  
[TD]Read (R)[/TD]  
[/TR]  
[TR]  
[TD]0x04[/TD]  
[TD]4[/TD]  
[TD]Read Input Registers[/TD]  
[TD]Input Register[/TD]  
[TD]Read-Only[/TD]  
[TD]Read (R)[/TD]  
[/TR]  
[TR]  
[TD]0x05[/TD]  
[TD]5[/TD]  
[TD]Write Single Coil[/TD]  
[TD]Coil (Discrete Output)[/TD]  
[TD]Read/Write[/TD]  
[TD]Write (W)[/TD]  
[/TR]  
[TR]  
[TD]0x06[/TD]  
[TD]6[/TD]  
[TD]Write Single Register[/TD]  
[TD]Holding Register[/TD]  
[TD]Read/Write[/TD]  
[TD]Write (W)[/TD]  
[/TR]  
[TR]  
[TD]0x0F[/TD]  
[TD]15 Next version V1.01[/TD]  
[TD]Write Multiple Coils[/TD]  
[TD]Coil (Discrete Output)[/TD]  
[TD]Read/Write[/TD]  
[TD]Write (W)[/TD]  
[/TR]  
[TR]  
[TD]0x10[/TD]  
[TD]16[/TD]  
[TD]Write Multiple Registers[/TD]  
[TD]Holding Register[/TD]  
[TD]Read/Write[/TD]  
[TD]Write (W)[/TD]  
[/TR]  
[TR]  
[TD]0x17[/TD]  
[TD]23 Next version V1.01[/TD]  
[TD]Read/Write Multiple Registers[/TD]  
[TD]Holding Register[/TD]  
[TD]Read/Write[/TD]  
[TD]Read/Write (R/W)[/TD]  
[/TR]  
[/TABLE]  
  
  
**Enjoy…**
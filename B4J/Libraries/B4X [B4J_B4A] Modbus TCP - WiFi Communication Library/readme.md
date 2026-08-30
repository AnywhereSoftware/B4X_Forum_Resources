### B4X [B4J/B4A] Modbus TCP - WiFi Communication Library by Peter Simpson
### 08/23/2026
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/171880/)

Hello everyone,  
Here is a Modbus TCP library designed to work with industrial Modbus WiFi hardware. Using this library, B4X developers can easily connect their B4J/B4A develooed software directly to industrial devices via WiFi (TCP) communications to read and write Modbus data. Using this library, your software should connect to any WiFI Modbus protocol devices.  
  
I believe that this library may also work with B4A, as I also have this library in my B4A additional libraries folders, plus in the the Initialize method Javadocs.   
  
The serial version can be found [**HERE**](https://www.b4x.com/android/forum/threads/modbus-rtu-serial-communication-library.171649/)  
  
**B4J library tab**  
![](https://www.b4x.com/android/forum/attachments/173087)  
  
**B4J Modbus WiFi TPC test app (Identical in B4A):**  
![](https://www.b4x.com/android/forum/attachments/173090)  
  
**SS\_EasyModbusClient  
  
Author:** Peter Simpson  
**Version:** 1.0  

- **EasyModbusClient**
*This library provides Modbus TCP communication with support for 16-bit and 32-bit data.*

- **Events:**

- **CoilsReceived** (Values() As Boolean)
- **Connected** (Message As String, Connected As Boolean)
- **ConnectionCheckDone** (IsLive As Boolean, Message As String)
- **DiagnosticRequest** (SubFunction As Int, Data As Int)
- **Disconnected** (Message As String)
- **DiscreteInputsReceived** (Values() As Boolean)
- **Error** (Message As String)
- **HoldingRegistersReceived** (Values() As Int)
- **InputRegistersReceived** (Values() As Int)
- **MultipleCoilsWritten** (StartingAddress As Int, Values() As Boolean)
- **MultipleRegistersWritten** (StartingAddress As Int, Values() As Int)
- **TestCompleted** (Success As Boolean, Message As String)
- **WriteResult** (Success As Boolean, Message As String)

- **Fields:**

- **PostReadDelay** As Int
*Property: Sets the post read delay in ms(milliseconds).  
 Set between (50–250) if you are having concurrent read issues.  
 The default value is 0.*- **PostWriteDelay** As Int
*Property: Sets the post write delay in ms(milliseconds).  
 Set between (50–250) if you are having concurrent write issues.  
 The default value is 0.*- **TEST\_COIL** As Int
- **TEST\_DISCRETE** As Int
- **TEST\_HOLDING** As Int
- **TEST\_INPUT** As Int
- **TEST\_NONE** As Int

- **Functions:**

- **Connect** (ipAddress As String, port As Int, timeoutMs As Int)
*Connects to a Modbus TCP slave at the specified IP address and port.  
 IpAddress The IP address of the Modbus TCP slave.  
 Port The TCP port of the Modbus TCP slave.  
 TimeoutMs The connection timeout in milliseconds.  
 Raises the Connected event when complete.*- **Connected** As Boolean
*Indicates whether the Modbus TCP client is currently connected.  
 Return true if connected, otherwise false.*- **DiagnosticRequest** (SubFunction As Int, Data As Int) As Int
*Diagnostic Request (Function Code 8).  
 SubFunction - The diagnostic sub-function code.  
 Data - The data value to send.  
 This implementation currently handles SubFunction 0 (Loopback/Echo).  
 Raises the DiagnosticRequest event.*- **Disconnect**
*Closes the connection to the Modbus TCP slave.  
 Always raises the Disconnected event when complete.*- **FloatToRegisters** (Value As Float) As Int()
*Converts a 32-bit Float into two 16-bit registers (Hi/Lo).  
 Returns an Int array where index 0 is high and index 1 is low.*- **Initialize** (EventName As String)
*Initialises the EasyModbusClient wrapper for use in B4A/B4J.  
 EventName The event name prefix used for raising events.*- **ReadCoils** (startingAddress As Int, quantity As Int) As Boolean()
*Reads coil values (Function Code 1).  
 StartingAddress The 0-based starting coil address.  
 Quantity Number of coils to read.  
 Return an array of boolean values.  
 Results are also raised asynchronously in the CoilsReceived event.*- **ReadDiscreteInputs** (startingAddress As Int, quantity As Int) As Boolean()
*Reads discrete input values (Function Code 2).  
 StartingAddress The 0-based starting input address.  
 Quantity Number of inputs to read.  
 Return an array of boolean values.  
 Results are also raised asynchronously in the DiscreteInputsReceived event.*- **ReadHoldingRegisters** (startingAddress As Int, quantity As Int) As Int()
*Reads holding registers as unsigned 16-bit values (Function Code 3).  
 StartingAddress The 0-based starting register address.  
 Quantity Number of registers to read.  
 Return an array of unsigned 16-bit integers.  
 Results are also raised asynchronously in the HoldingRegistersReceived event.*- **ReadInputRegisters** (startingAddress As Int, quantity As Int) As Int()
*Reads input registers as unsigned 16-bit values (Function Code 4).  
 StartingAddress The 0-based starting register address.  
 Quantity Number of registers to read.  
 Return an array of unsigned 16-bit integers.  
 Results are also raised asynchronously in the InputRegistersReceived event.*- **ReadWriteMultipleRegisters** (readStartingAddress As Int, quantityToRead As Int, writeStartingAddress As Int, valuesToWrite As Int()) As Int()
*FC23: Read/Write Multiple Registers.  
 Supports both 16-bit and 32-bit (via register pairing) data types.  
 All register data is treated as unsigned 16-bit integers (0-65535).  
 Read results are returned in HoldingRegistersReceived; write results in WriteResult.*- **RegistersToFloat** (RegHi As Int, RegLo As Int) As Float
*Converts two 16-bit registers (Hi/Lo) into a 32-bit Float.*- **SetTestConfig** (TestFunction As Int, TestAddress As Int)
*Configures the test function used by TestFunction().  
 TestFunction The type of register to read for the test (use TEST\_ constants).  
 TestAddress The 0-based address to read for the test.*- **TestFunction**
*Executes a self-test based on the configured TestFunction and TestAddress.  
 Results are returned asynchronously in the TestCompleted and ConnectionCheckDone events.*- **WriteCoil** (Offset As Int, Value As Boolean)
*Writes a single coil value (Function Code 5).  
 Offset The 0-based coil address.  
 Value The boolean value to write.  
 Results are raised asynchronously in the WriteResult event.*- **WriteCoils** (startingAddress As Int, values As Boolean())
*Writes multiple coil values (Function Code 15).  
 StartingAddress The 0-based starting coil address.  
 Values Array of boolean values to write.  
 Results are raised asynchronously in the MultipleCoilsWritten event.*- **WriteRegister** (Offset As Int, Value As Int)
*Writes a single holding register (Function Code 6).  
 Offset The 0-based register address.  
 Value The 16-bit value to write.  
 Results are raised asynchronously in the WriteResult event.*- **WriteRegisters** (startingAddress As Int, values As Int())
*Writes multiple holding registers (Function Code 16).  
 StartingAddress The 0-based starting register address.  
 Values Array of 16-bit values to write.  
 Results are raised asynchronously in the MultipleRegistersWritten event.*
- **Properties:**

- **SlaveID** As Int
*Returns the current Modbus Slave Unit ID.  
 Return the active SlaveID value.*- **VerboseLogs** As Boolean
*Indicates whether verbose logging is currently enabled.  
 Return true if verbose logging is enabled.*
  
**Please note:**  
I’ve wrapped the server library and created a B4J app for it. I may or may not release the server library, as it’s mainly for testing whether WiFi clients connect and communicate successfully.  
  
  
**Enjoy…**
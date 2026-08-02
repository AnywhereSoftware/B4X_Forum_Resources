### Modbus RTU - Serial Library by Peter Simpson
### 07/26/2026
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/171649/)

Hello everyone,  
Here is a Modbus library that I wrapped to test some industrial Modbus Serial hardware, so I thought that I would share it with the community. Using this library, you can connect your B4J software directly to industrial devices via serial ports to read and write Modbus data. Using this library, your software should connect to any serial Modbus protocol devices.  
  
**B4J library tab**  
![](https://www.b4x.com/android/forum/attachments/172593)  
  
**B4J Modbus Serial RTU test app:**  
![](https://www.b4x.com/android/forum/attachments/172594)  
  
**SS\_ModbusSerialRTU  
  
Author:** Peter Simpson  
**Version:** 1.0  

- **ModbusSerialRTU**
*ModbusSerialDesktop - Serial implementation for desktop applications.  
 This library provides robust Modbus RTU communication via jSerialComm.*

- **Events:**

- **CoilRead** (Success As Boolean, Data() As Boolean, Message As String)
- **ConnectionCheckDone** (IsLive As Boolean, Message As String)
- **DiagnosticRequest** (SubFunction As Int, Data As Int)
- **Disconnected** (Success As Boolean, Message As String)
- **DiscreteInputRead** (Success As Boolean, Data() As Boolean, Message As String)
- **FloatArrayRead** (Success As Boolean, Values() As Float, Data() As Float, Message As String)
- **FloatRead** (Success As Boolean, Value As Float, Data() As Float, Message As String)
- **HoldingRegisterRead** (Success As Boolean, Data() As Short, Message As String)
- **InitResult** (Success As Boolean, Message As String)
- **InputRegisterRead** (Success As Boolean, Data() As Short, Message As String)
- **Int32ArrayRead** (Success As Boolean, Values() As Int, Message As String)
- **Int32Read** (Success As Boolean, Value As Int, Message As String)
- **TestCompleted** (Success As Boolean, Message As String)
- **WriteResult** (Success As Boolean, Message As String)

- **Fields:**

- **ByteOrderMode** As Int
*Sets the byte order used for 32-bit data conversions (Float and Int32).  
 Defaults to ORDER\_ABCD (Big-Endian).*- **GapReadWriteMultipleDelay** As Int
*Property: Sets the gap read write multiple delay in ms(milliseconds).  
 Set between (50–250) if you are having GapReadWriteMultipleDelay issues.  
 The default value is 0.*- **ORDER\_ABCD** As Int
*Big-Endian: The standard Network order (e.g., 0x41 0x42 0x43 0x44)*- **ORDER\_BADC** As Int
*Byte Swap: Swaps bytes within each 16-bit word (e.g., 0x42 0x41 0x44 0x43)*- **ORDER\_CDAB** As Int
*Word Swap: Swaps the high and low 16-bit words (e.g., 0x43 0x44 0x41 0x42)*- **ORDER\_DCBA** As Int
*Little-Endian: Complete reverse order (e.g., 0x44 0x43 0x42 0x41)*- **PostReadDelay** As Int
*Property: Sets the post read delay in ms(milliseconds).  
 Set between (50–250) if you are having concurrent read issues.  
 The default value is 0.*- **PostWriteDelay** As Int
*Property: Sets the post write delay in ms(milliseconds).  
 Set between (50–250) if you are having concurrent write issues.  
 The default value is 0.*- **SlaveID** As Int
*Property: Gets or sets the Modbus Slave Unit ID (1–247).  
 The default value is 1.*- **TEST\_COIL** As Int
- **TEST\_DISCRETE** As Int
- **TEST\_HOLDING** As Int
- **TEST\_INPUT** As Int
- **TEST\_NONE** As Int

- **Functions:**

- **BytesToFloat** (Data As Byte()) As Float
*Enhanced BytesToFloat that respects the selected ByteOrderMode.*- **BytesToFloatFromFloats** (Data As Float()) As Float
*Overloaded helper that accepts a Float array  
 and re-converts it using the current ByteOrderMode.*- **BytesToInt32** (Data As Byte()) As Int
*Enhanced BytesToInt32 that respects the selected ByteOrderMode.*- **Connect** (PortName As String)
*Connects to the specified serial port using the configured parameters.  
 PortName The system name of the port (e.g., "COM3", "/dev/ttyUSB0").  
 Raises the InitResult event when complete.*- **Connected** As Boolean
*Returns whether the serial port is currently open and connected.  
 Return true if connected, otherwise false.*- **DiagnosticRequest** (SubFunction As Int, Data As Int) As Int
*Diagnostic Request (Function Code 8).  
 SubFunction - The diagnostic sub-function code.  
 Data - The data value to send.  
 This implementation currently handles SubFunction 0 (Loopback/Echo).  
 Raises the DiagnosticRequest event.*- **Disconnect**
*Closes the active serial connection.  
 Raises the Disconnected event when complete.*- **FloatToRegisters** (Value As Float) As Int()
*Converts a 32-bit Float into two 16-bit registers (Hi/Lo).  
 Returns an Int array where index 0 is high and index 1 is low.*- **Initialize** (EventName As String)
*Initialises the Modbus RTU object and sets the event prefix  
 callbacks.  
 EventName The event prefix used for raised events.*- **IsInitialized** As Boolean
*Checks if the object is initialized.  
 Return true if initialized, otherwise false.*- **ListPorts** As List
*Returns a list of available serial ports on the system,  
 sorted numerically (COM1, COM2, COM3, COM10, etc).*- **RaiseFloatArrayRead** (Data As Byte(), Message As String)
*Converts a byte array into multiple Floats (4 bytes per float) and raises FloatArrayRead.*- **RaiseFloatRead** (Data As Byte(), Message As String)
*Converts a 4-byte array to a Float and raises the FloatRead event.  
 Useful for processing raw Modbus responses into high-level logic.*- **ReadCoils** (Start As Int, Len As Int)
*Reads coil values (Function Code 1).  
 Start The 0-based starting coil address.  
 Len Number of coils to read.  
 Results are returned asynchronously in the CoilRead event.*- **ReadDiscreteInputs** (Start As Int, Len As Int)
*Reads discrete input values (Function Code 2).  
 Start The 0-based starting input address.  
 Len Number of inputs to read.  
 Results are returned asynchronously in the DiscreteInputRead event.*- **ReadFloat** (Address As Int)
*Reads a 32-bit float from two holding registers.  
 Address The starting register address.  
 Raises the FloatRead event when complete.*- **ReadFloatArray** (Address As Int, Count As Int)
*Reads an array of 32-bit floats from holding registers.  
 Address The starting register address.  
 Count Number of float values to read (each uses 2 registers).  
 Return an array of float values.  
 Raises FloatArrayRead event with the result.*- **ReadHoldingRegisters** (Start As Int, Len As Int) As Int()
*Reads holding registers (Function Code 3).  
 Start The 0-based starting register address.  
 Len Number of registers to read.  
 Return an array of unsigned 16-bit values.  
 Results are also returned asynchronously in the HoldingRegisterRead event.*- **ReadInputRegisters** (Start As Int, Len As Int) As Int()
*Reads input registers (Function Code 4).  
 Start The 0-based starting register address.  
 Len Number of registers to read.  
 Return an array of unsigned 16-bit values.  
 Results are also returned asynchronously in the InputRegisterRead event.*- **ReadInt32** (Address As Int)
*Reads a 32-bit integer from two holding registers.  
 Address The starting register address.  
 Return the reconstructed 32-bit integer.  
 Raises Int32Read event with the result.*- **ReadInt32Array** (Address As Int, Count As Int)
*Reads an array of 32-bit integers from holding registers.  
 Address The starting register address.  
 Count Number of Int32 values to read (each uses 2 registers).  
 Return an array of 32-bit integers.  
 Raises Int32ArrayRead event with the result.*- **ReadWriteMultipleRegisters** (ReadStart As Int, ReadLen As Int, WriteStart As Int, WriteValues As Int()) As Int()
*Read/Write Multiple Registers helper.  
 Performs a write (FC16) followed by a read (FC3) as two distinct transactions.  
 All values are treated as unsigned 16-bit. Returns the read blocksynchronously  
 and also raises HoldingRegisterRead and WriteResult events.*- **ReconvertFloat** (Data As Float()) As Float
*Re-shuffles a float's internal bits based on the current ByteOrderMode.  
 Use this when you want to see how different modes affect the same value.*- **RegistersToFloat** (RegHi As Short, RegLo As Short) As Float
*Converts two 16-bit registers (Hi/Lo) into a 32-bit Float.  
 Uses BIG\_ENDIAN format for high/low register pairs.*- **SetParameters** (BaudRate As Int, DataBits As Int, StopBits As Int, Parity As Int)
*Sets the serial communication parameters for the port.  
 BaudRate Speed in bits per second.  
 DataBits Number of data bits per character.  
 StopBits Number of stop bits.  
 Parity Parity mode (0=None, 1=Odd, 2=Even, 3=Mark, 4=Space).*- **SetTestConfig** (TestFunction As Int, TestAddress As Int)
*Configures the test function used by TestFunction().  
 TestFunction The type of register to read for the test (use TEST\_ constants).  
 TestAddress The 0-based address to read for the test.*- **TestFunction**
*Executes a self-test based on the configured TestFunction and TestAddress.  
 Results are returned asynchronously in the TestCompleted and  
 ConnectionCheckDone events.*- **WriteCoil** (Offset As Int, Value As Boolean)
*Writes a single coil value (Function Code 5).  
 Offset The 0-based coil address.  
 Value The boolean value to write.  
 Results are returned asynchronously in the WriteResult event.*- **WriteCoils** (Start As Int, Values As Boolean())
*Writes multiple coil values (Function Code 15).  
 Start The 0-based starting coil address.  
 Values Array of boolean values to write.  
 Results are returned asynchronously in the WriteResult event.*- **WriteFloat** (Address As Int, Value As Float)
*Writes a 32-bit float to two holding registers.  
 Address The starting register address.*- **WriteFloatArray** (Start As Int, Values As Float())
*Writes an array of 32-bit floating point values (IEEE 754).  
 Each float occupies 2 consecutive holding registers.  
 Start - The 0-based starting register address.  
 Values - Array of floats to write.  
 Results are returned asynchronously in the WriteResult event.*- **WriteInt32** (Start As Int, Value As Int)
*Writes a 32-bit signed integer to two holding registers.  
 Address The starting register address.*- **WriteInt32Array** (Start As Int, Values As Int())
*Writes an array of 32-bit signed integer to two holding registers.  
 Address The starting register address.*- **WriteRegister** (Offset As Int, Value As Int)
*Writes a single holding register (Function Code 6).  
 Offset The 0-based register address.  
 Value The 16-bit value to write.  
 Results are returned asynchronously in the WriteResult event.*- **WriteRegisters** (Start As Int, Values As Int())
*Writes multiple holding registers (Function Code 16).  
 Start The 0-based starting register address.  
 Values Array of 16-bit values to write.  
 Results are returned asynchronously in the WriteResult event.*
- **Properties:**

- **PortNames** As String [read only]
*Returns the name of the currently connected serial device.  
 Return the device name, or an empty string if not connected.*
  
**PLEASE NOTE:  
TO RUN THE ATTACHED EXAMPLE, YOU NEED TO DOWNLOAD THE THIRD-PARTY **JAVA DEPENDENCIES** LINKED BELOW, AS WELL AS USING THE ATTACHED POST LIBRARY.  
[CLICK HERE](https://www.dropbox.com/scl/fi/8ajla9ubrk3hw9ec2f9ca/Modbus-Serial-RTU-Dependencies.zip?rlkey=qo3f1qa99g5c7ehnminv7y6k4&dl=0)**[- Download Dependencies](https://www.dropbox.com/scl/fi/8ajla9ubrk3hw9ec2f9ca/Modbus-Serial-RTU-Dependencies.zip?rlkey=qo3f1qa99g5c7ehnminv7y6k4&dl=0) <<<<<<<<<<<<<<<<<<<<<<<<  
  
  
**Enjoy…**
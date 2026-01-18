### USBSerial Enhanced - Based on usb-serial-for-android-3.10.0 by Peter Simpson
### 01/11/2026
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/169981/)

Hello everyone,  
The usb-serial-for-android library is a popular open-source driver collection designed for Android devices acting as a USB host. It enables communication with various USB-to-serial converters without requiring root access or custom kernel drivers.  
  
Here is an updated version of the current excellent USB Serial library from [agraham](https://www.b4x.com/android/forum/threads/usbserial-library-2-0-supports-more-devices.28176), which in turn was originally wrapped from [here](https://github.com/mik3y/usb-serial-for-android). I have wrapped the latest version from the aforementioned GitHub repository. I added a few extra functions to the library, I hope they will be useful to other developers. This library has been tested on and targets SDK 35+. I name the library V1+ simply because I've added extra functions, thus the name enhanced.  
  
**This library supports a wide range of common hardware, including:**  

- CDC/ACM devices (such as Arduino Uno and Mega).
- FTDI chips (FT232R, FT232H, etc.).
- Silicon Labs CP210x controllers.
- Prolific PL2303 chips.
- Qinheng CH340 and CH341 devices.

There are two files in the attached lib zip file. Place both files in your additional libraries folder.  
  
**B4A library tab:**  
![](https://www.b4x.com/android/forum/attachments/169261)  
  
This library handles the low-level USB communication protocols and baud rate configurations, allowing developers to focus on the data exchange logic. This is the standard choice for connecting an Android tablet or phone to industrial equipment, sensors, or microcontrollers via a physical USB cable. It simplifies the process of requesting USB permissions from the user and managing the connection lifecycle.  
  
**Hotplug support** is optional and can easily be removed. Hotplug USB devices support is integrated into the example app for developers who are interested in using it.  
  
**What does hotplug mean?**  
In the context of the usb-serial-for-android library and Android USB communication, hotplugging refers to the ability of the system to detect and handle USB devices being plugged in or removed while the application is running, without requiring a restart. When plugging in a compatible USB device, the app will launch automatically and a popup dialog will appear displaying “Open USB Serial to handle XXX…” (see the attached screenshot below). Adding the correct XML code in the manifest in conjunction with the XML file, allows your app to launch automatically when inserting compatible USB devices.  
  
**Screenshot in action:**  
![](https://www.b4x.com/android/forum/attachments/169262)  
  
**Take note:**  
In the folder called objects/res/xml, there is a read-only file called device\_filter.xml. The primary purpose of this file is to tell the Android operating system which specific USB devices your application is interested in. It acts as a whitelist based on hardware identifiers. This XML file works in conjunction with optional XML code in the manifest which in turn works with the B4A receiver module. If you are not interested in hotplug support, you can comment out the optional manifest code, but that is **NOT** recommended.  
  
**SS\_USBSerialEnhanced  
  
Author:** Peter Simpson  
**Version:** 1.01  

- **USBSerialEnhanced**
*Enhanced USB Serial library with support for 32-bit data types,  
 advanced flow control, hotplugging, and synchronous I/O.  
 Based on usb-serial-for-android-v3.10.0.aar*

- **Events:**

- **Closed** (Vid As Int, Pid As Int, Serial As String, PortName As String)
- **Error** (Message As String)
- **NewData** (Data() As Byte)
- **Open** (Vid As Int, Pid As Int, Serial As String, PortName As String)
- **PermissionDenied**
- **PermissionGranted**
- **SentData** (Data() As Byte)

- **Fields:**

- **AutoReconnect** As Boolean
*Enables automatic reconnection when a previously used device is reattached.  
 Matches devices using VID, PID, and optional serial number.*- **DevicePort** As Int
*Selects the port index to open on the USB device.  
 Defaults to 0 for single‑port devices.*- **PermissionGranted** As Boolean
*Indicates whether the user has granted permission for the current USB device.  
 Updated automatically during permission handling.*- **ReadBlock** As Boolean
*When true, incoming data is ignored and the NewData event is not raised.  
 Useful for temporarily suspending asynchronous reads.*- **SetPortByName** As String
*Allows selecting a port by its internal driver name.  
 Set a substring such as "CDC" or "FTDI" to match a specific port.*- **UseAsyncMode** As Boolean
*When true, the IO manager is started automatically on Open().  
 Set to false if you intend to use ReadBlocking() only.*
- **Functions:**

- **AddCustomDevice** (VendorID As Int, ProductID As Int, DriverType As String)
*Adds a custom VID and PID mapping for devices not recognised automatically.  
 VendorID The USB vendor identifier.  
 ProductID The USB product identifier.  
 DriverType The driver class name such as "CdcAcmSerialDriver".*- **BytesToFloat** (Data As Byte()) As Float
*Converts a 4-byte array into a single 32-bit Float.  
 Data is the 4-byte array containing the float value in Big-Endian order.  
 Return a reconstructed floating point value, or 0.0f if the array length is not 4.*- **BytesToHex** (data As Byte(), offset As Int, length As Int) As String
*Converts a byte array to a space‑separated hexadecimal string.  
 data is the byte array to convert.  
 Return a formatted hexadecimal string, or an empty string if the array is null or empty.*- **BytesToInt32** (Data As Byte()) As Int
*Converts a 4-byte array back into a 32-bit Signed Integer.  
 Data is the 4-byte array in Big-Endian order.  
 Return a reconstructed integer value, or 0 if the array length is not 4.*- **Close**
*Closes the serial port connection and stops the internal IO manager.*- **CombineTo32Bit** (highOrder As Int, lowOrder As Int) As Int
*Combines two 16-bit integers into a single 32-bit integer.*- **DecodeBase64ToString** (base64 As String) As String
- **Dispose**
*Releases all resources held by this instance.  
 Call this when the object is no longer needed.  
 If the app is closing, you may want to unregister the hotplug receiver.  
 Return no value; further use after disposal is not supported.*- **EncodeBase64FromString** (text As String) As String
*Encodes a standard Java String into a Base64 text representation.  
 text is the plain text String to encode. Must not be null.  
 Return a Base64‑encoded String representing the original text.*- **EnumerateDevices** As List
*Returns a list of all connected USB serial devices.  
 Each list item contains Index, VID, PID, Manufacturer, Product, and Serial.*- **FloatToBytes** (Value As Float) As Byte()
*Converts a 32-bit Float to a 4-byte array.*- **GetConnectedUsbDevices** As List
*Returns a list of all connected USB devices, not limited to serial devices.  
 Each item includes VID, PID, Class, SubClass, Protocol, Manufacturer, Product, and Serial.*- **GetConnectionState** As String
*Returns the current connection state of the USB serial interface.  
 Possible values:  
 - Disconnected  
 - Connected  
 - Opening*- **GetDeviceInfo** As Map
*Returns information about the currently opened USB device.  
 If no device is open, this method returns Null.  
 The returned Map contains:  
 - VID  
 - PID  
 - Serial  
 - Manufacturer  
 - Product  
 - PortName (if available)*- **GetDeviceManufacturer** As String
*Returns the manufacturer name of the last successfully opened USB device if available.  
 May return Null if the device does not expose a manufacturer string or no device has been opened.*- **GetDeviceProduct** As String
*Returns the product name of the last successfully opened USB device if available.  
 May return Null if the device does not expose a product string or no device has been opened.*- **GetDeviceProductId** As Int
*Returns the Product ID of the last successfully opened USB device.  
 Returns 0 if no device has been opened yet.*- **GetDeviceSerial** As String
*Returns the serial number of the last successfully opened USB device if available.  
 May return Null if the device does not expose a serial number or no device has been opened.*- **GetDeviceVendorId** As Int
*Returns the Vendor ID of the last successfully opened USB device.  
 Returns 0 if no device has been opened yet.*- **GetFloat32** (highOrder As Int, lowOrder As Int) As Float
*Converts two 16-bit registers into a 32-bit Float (IEEE 754).*- **GetHotplugStatus** As Boolean
*Returns whether the hotplug receiver is currently registered.*- **GetLastEvent** As String
*Returns the last USB-related event that occurred.  
 Useful for dashboards that display live USB activity.*- **GetPortCount** As Int
*Returns the number of serial ports available on the selected device.  
 Returns zero if no driver is available.*- **HasPermission** (vendorId As Int, productId As Int) As Boolean
*Checks if the application has permission to access the specified USB device.  
 This updates the public PermissionGranted field.  
 vendorId The Vendor ID of the hardware.  
 productId The Product ID of the hardware.*- **HexToBytes** (hex As String) As Byte()
*Converts a hexadecimal string to a byte array.  
 Non‑hex characters are ignored. The string must contain an even number of hex digits.  
 hex is the hexadecimal string to convert.  
 Return a byte array containing the converted values.*- **Initialize** (EventName As String)
*Initialises the USBSerialEnhanced object and prepares it for use.  
 EventName The prefix used for all raised events.*- **InspectDevice** (vid As Int, pid As Int) As Map
*Returns detailed capability information for a USB device matching the given VID and PID.  
 Includes interfaces, endpoints, and descriptive fields.  
 vid The vendor identifier.  
 pid The product identifier.*- **Int32ToBytes** (Value As Int) As Byte()
*Converts a 32-bit Signed Integer to a 4-byte array.  
 Value The integer value to convert.*- **Open** As Boolean
*Opens the selected USB serial device and starts asynchronous I/O.  
 Returns true if the port is opened successfully, otherwise false.*- **PurgeHwBuffers** (ReadBuffer As Boolean, WriteBuffer As Boolean)
*Clears the hardware input and output buffers.  
 ReadBuffer True to clear the input buffer.  
 WriteBuffer True to clear the output buffer.*- **ReadBlocking** (Buffer As Byte(), Timeout As Int) As Int
*Performs a synchronous blocking read into the supplied buffer.  
 Buffer The byte array to store received data.  
 Timeout The read timeout in milliseconds.  
 Returns the number of bytes read.*- **RefreshDevices** As List
*Refreshes and returns the current list of connected USB devices.  
 Convenience wrapper around GetConnectedUsbDevices().*- **RequestPermission** (vendorId As Int, productId As Int)
*Requests temporary access permission for the specified USB hardware.  
 This method handles the Android 14 requirement for explicit intents and  
 raises PermissionGranted/PermissionDenied events based on the user's decision.*- **SetParameters** (BaudRate As Int, DataBits As Int, StopBits As Int, Parity As Int)
*Sets the serial communication parameters for the active port.  
 BaudRate The baud rate such as 9600 or 115200.  
 DataBits The number of data bits.  
 StopBits The number of stop bits.  
 Parity The parity mode (0=None, 1=Odd, 2=Even, 3=Mark, 4=Space).*- **SplitFrom32Bit** (value As Int) As Int()
*Splits a 32-bit integer into an array of two 16-bit integers.*- **StopIoManager**
*Stops the SerialInputOutputManager and disables asynchronous reads.  
 Required before using ReadBlocking().*- **Swap32BitEndianness** (value As Int) As Int
*Reverses the byte order of a 32-bit integer.*- **Write** (Data As Byte())
*Writes a byte array to the serial port.  
 Data The bytes to send to the device.  
 Raises the SentData event after a successful write.*
- **Properties:**

- **GetPortName** As Int [write only]
*Property setter used to support syntax USBSerial.GetPortName = Index.  
 This acts as a no-op but keeps API compatibility.*- **IsConnected** As Boolean [read only]
*Returns true if the serial port is currently open.  
 Indicates whether communication is active.*- **SelectDeviceByIndex** As Int [write only]
*Selects a USB device by its index from the EnumerateDevices list.  
 Index The index of the device to select.*- **SetBreak** As Boolean [write only]
*Sends or clears a break condition on the serial line.  
 Value True to start break, False to stop it.*- **SetDebugLogging** As Boolean
*Returns whether debug logging is enabled for USB communication.  
 When true, detailed diagnostic messages are written to the log.*- **SetDTR** As Boolean [write only]
*Sets the Data Terminal Ready (DTR) line.  
 Value True to assert DTR, False to release it.*- **SetFlowControl** As Int [write only]
*Sets the hardware flow control mode for the serial port.  
 Mode 0=None, 1=RTS/CTS, 2=DTR/DSR, 3=XON/XOFF.*- **SetRTS** As Boolean [write only]
*Sets the Request To Send (RTS) line.  
 Value True to assert RTS, False to release it.*
  
**Update: V1.01**  

- Merged the aar file into the jar file (Thank you [USER=31245]@drgottjr[/USER] for the idea)
- Cleaned up the JavaDoc comments

D = 18 + 3  
  
**Enjoy…**
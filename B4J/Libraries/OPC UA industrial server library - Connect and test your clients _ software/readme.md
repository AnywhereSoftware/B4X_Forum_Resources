### OPC UA industrial server library - Connect and test your clients / software by Peter Simpson
### 09/05/2026
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/171976/)

Hello everyone,  
Here is my OPC UA Server library for B4J. I use this library to host OPC UA endpoints for testing, development, and general industrial communication work. It is designed to be simple to run, reliable, and fully compatible with standard OPC UA clients, including my own B4J OPC UA Client library.  
  
**OPC UA client library link below**  
<https://www.b4x.com/android/forum/threads/opc-ua-industrial-client-library-connect-to-servers.171977/>  
  
**What is OPC UA?**  
OPC UA is a high‑performance industrial communication standard designed for secure, structured, and reliable data exchange. It is widely used in automation, robotics, manufacturing, SCADA systems, and IIoT platforms. The one line takeaway is that OPC UA is a secure, structured, real time industrial protocol that allows devices and software to communicate using a unified information model.  
  
Once this library is up and running, OPC UA clients can connect to your server to read and write variables, subscribe to data changes, browse the node tree, and interact with your information model. Although OPC UA is commonly deployed on embedded devices and industrial controllers, it can be used just as effectively on a desktop or server to support multiple simultaneous client sessions. This library implementation fully supports all of the above.  
  
**B4J Library Tab**  
![](https://www.b4x.com/android/forum/attachments/173411)  
  
**SS\_OPCUAServer  
  
Author:** Peter Simpson  
**Version:** 1.0  

- **OPCUAServer**
*OPC UA Server library.  
 This class provides a bridge to OPC UA services including node management,  
 session monitoring, and data communication.*

- **Events:**

- **ClientConnected** (SessionName As String)
- **ClientConnecting** (SessionId As String)
- **ClientDisconnected** (SessionName As String)
- **Error** (Message As String)
- **ServerFailed** (Reason As String)
- **ServerStarted** (EndpointUrl As String)
- **ValueChanged** (Name As String, Value As Object)
- **ValueRead** (Name As String, Value As Object)

- **Functions:**

- **AddVariable** (Name As String, InitialValue As Object)
*Adds a variable node under the Data folder.  
 Name - The name of the variable.  
 InitialValue - The initial value for the variable.*- **CreateTCPHardwareController** (host As String, port As Int) As Object
*Creates a simple TCP-based hardware controller for remote communication.  
 host - The remote hostname.  
 port - The remote port.*- **Initialize** (EventName As String, Host As String, Port As Int, ServerName As String, ApplicationUri As String)
*Initialises the OPC UA server configuration only.  
 ba - The BA instance.  
 EventName - The B4J event name prefix.  
 Host - The hostname or IP address to bind to.  
 Port - The TCP port for the server.  
 ServerName - The display name of the server.  
 ApplicationUri - The unique application URI.*- **SetAllowAnonymous** (Allow As Boolean)
*Allows explicitly enabling or disabling anonymous access alongside credentials.*- **SetCredentials** (Username As String, Password As String)
*Sets the username and password required for basic auth connections.  
 If credentials are set, anonymous connections can also be explicitly toggled.*- **SetHardwareController** (controller As Object)
*Assigns an object to handle hardware-related writes.  
 controller - The controller object.*- **SetVariableAccessLevel** (name As String, accessLevel As Int, userAccessLevel As Int)
*Sets the access level for a specific variable using a bitmask.  
 name - The variable name.  
 accessLevel - The access level bitmask.  
 userAccessLevel - The user access level bitmask.  
   
 Bit 0 (Value 1): CurrentRead - The current value is readable.  
 Bit 1 (Value 2): CurrentWrite - The current value is writable.  
 Bit 2 (Value 4): HistoryRead - The history of the value is readable.  
 Bit 3 (Value 8): HistoryWrite - The history of the value is writable.  
 Common Combinations  
 Because they are bitmasks, you add the values together to combine permissions:  
 1: Read-only (CurrentRead only)  
 2: Write-only (CurrentWrite only)  
 3 (1 + 2): Read and Write (CurrentRead + CurrentWrite)  
 5 (1 + 4): Read current value and read history (CurrentRead + HistoryRead)  
 Note: An operation is only permitted if both accessLevel and userAccessLevel  
 contain the corresponding bit.*- **Start**
*Starts the OPC UA server and registers the custom namespace.  
 This logic is executed synchronously to ensure the server is ready  
 before the B4J application proceeds.*- **Stop**
*Stops the OPC UA server and shuts down all active sessions.  
 Executed asynchronously to prevent blocking the B4J main thread.*- **UpdateVariable** (name As String, value As Object)
*Updates the value of an existing variable on the server.  
 name - The name of the variable to update.  
 value - The new value.*
  
**PLEASE NOTE:  
TO RUN THE ATTACHED EXAMPLE, YOU NEED TO DOWNLOAD THE THIRD-PARTY **JAVA DEPENDENCIES** LINKED BELOW, AS WELL AS USING THE ATTACHED POST LIBRARY.**  
[**CLICK HERE**](https://www.dropbox.com/scl/fi/uw21i4xi22ng61bod0a8o/UPC-UA-Server-Dependencies.zip?rlkey=tjw22bdvynkp5ygqvypv3wtva&dl=0) to download extra dependencies <<<<<<<<<<<<<<<<<<<<<<<<  
  
  
**Enjoy…**
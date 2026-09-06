### OPC UA industrial client library - Connect to servers / devices by Peter Simpson
### 09/05/2026
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/171977/)

Hello everyone,  
Here is my OPC UA Client library for B4J. I use this library to connect to OPC UA servers for testing, development, and general industrial communication work. It is designed to be simple to use, reliable, and fully compatible with standard OPC UA servers, including my own B4J OPC UA Server library.  
  
**OPC UA server library link below**  
<https://www.b4x.com/android/forum/threads/opc-ua-industrial-server-library-connect-and-test-your-clients.171976/>  
  
**What is OPC UA?**  
OPC UA is a high‑performance industrial communication standard designed for secure, structured, and reliable data exchange. It is widely used in automation, robotics, manufacturing, SCADA systems, and IIoT platforms. The one line takeaway is that OPC UA is a secure, structured, real time industrial protocol that allows devices and software to communicate using a unified information model.  
  
Once initialised, this client library can connect to any compliant OPC UA server and perform the core OPC UA operations you would expect. These include reading and writing variables, subscribing to data changes, browsing the server’s node tree, and interacting with the server’s information model. The library is designed to work with both local and remote servers and supports multiple sessions, secure connections, and structured data access.  
  
**Who is this library for?**  
This library is ideal for developers building:  

- **Industrial dashboards:** Used to visualise live data from PLCs, CNC machines, robotic cells, production lines, and factory sensors.
- **Machine monitoring systems:** Connect to industrial controllers such as Siemens S7, Allen‑Bradley ControlLogix, Beckhoff TwinCAT, Mitsubishi, Omron, and other OPC UA‑enabled PLCs to monitor temperatures, pressures, speeds, counters, and alarms.
- **SCADA‑style applications:** Integrate with plant‑wide control systems, HMIs, distributed controllers, and OPC UA gateways for supervisory control and data acquisition.
- **IIoT gateways:** Aggregate data from industrial sensors, smart devices, OPC UA edge modules, and factory equipment for cloud analytics or local processing.
- **Hardware integration via TCP bridge:** Use your TCP hardware controller to expose ESP32‑based devices, microcontrollers, and custom electronics as OPC UA variables for testing, prototyping, and lightweight automation.

This client implementation is ideal for connecting to and testing OPC UA servers, building industrial dashboards, monitoring machine data, or integrating OPC UA communication into your B4J applications.  
  
**B4J Library Tab**  
![](https://www.b4x.com/android/forum/attachments/173414)  
  
[SPOILER="OPC UA client test logs"]  
Starting OPC UA test harness  
Connecting to: opc.tcp://localhost:4840/  
opc.tcp://localhost:4840/  
[milo-shared-thread-pool-0] INFO org.eclipse.milo.opcua.sdk.client.OpcUaClient - Java version: 19.0.2  
[milo-shared-thread-pool-0] INFO org.eclipse.milo.opcua.sdk.client.OpcUaClient - Eclipse Milo OPC UA Stack version: dev  
[milo-shared-thread-pool-0] INFO org.eclipse.milo.opcua.sdk.client.OpcUaClient - Eclipse Milo OPC UA Client SDK version: dev  
[milo-nonce-util-secure-random] INFO org.eclipse.milo.opcua.stack.core.util.NonceUtil - SecureRandom seeded in 0ms.  
Connected  
BrowseResult: 14 items  
(MyMap) {NodeId=ns=0;i=2269, DisplayName=ServerProfileArray, NodeClass=Variable}  
(MyMap) {NodeId=ns=0;i=2271, DisplayName=LocaleIdArray, NodeClass=Variable}  
(MyMap) {NodeId=ns=0;i=2272, DisplayName=MinSupportedSampleRate, NodeClass=Variable}  
(MyMap) {NodeId=ns=0;i=2735, DisplayName=MaxBrowseContinuationPoints, NodeClass=Variable}  
(MyMap) {NodeId=ns=0;i=2736, DisplayName=MaxQueryContinuationPoints, NodeClass=Variable}  
(MyMap) {NodeId=ns=0;i=2737, DisplayName=MaxHistoryContinuationPoints, NodeClass=Variable}  
(MyMap) {NodeId=ns=0;i=3704, DisplayName=SoftwareCertificates, NodeClass=Variable}  
(MyMap) {NodeId=ns=0;i=11702, DisplayName=MaxArrayLength, NodeClass=Variable}  
(MyMap) {NodeId=ns=0;i=11703, DisplayName=MaxStringLength, NodeClass=Variable}  
(MyMap) {NodeId=ns=0;i=12911, DisplayName=MaxByteStringLength, NodeClass=Variable}  
(MyMap) {NodeId=ns=0;i=11704, DisplayName=OperationLimits, NodeClass=Object}  
(MyMap) {NodeId=ns=0;i=2996, DisplayName=ModellingRules, NodeClass=Object}  
(MyMap) {NodeId=ns=0;i=2997, DisplayName=AggregateFunctions, NodeClass=Object}  
(MyMap) {NodeId=ns=0;i=11192, DisplayName=HistoryServerCapabilities, NodeClass=Object}  
ReadResult: ns=0;i=2258 Status: StatusCode{name=Good, value=0x00000000, quality=good}  
Type: org.eclipse.milo.opcua.stack.core.types.builtin.DateTime  
Single value: DateTime{utcTime=134328352687660000, javaDate=Wed Sep 02 16:07:48 BST 2026}  
ReadResult: i=2255 Status: StatusCode{name=Good, value=0x00000000, quality=good}  
Type: [Ljava.lang.String;  
Item 0: <http://opcfoundation.org/UA/>  
Item 1: urn:simplysoftware:eek:pcuaserver  
Item 2: urn:simplysoftware:b4j  
ReadResult: ns=2;s=MyHex Status: StatusCode{name=Good, value=0x00000000, quality=good}  
Type: java.lang.String  
Single value: 77 77 77 2e 62 34 78 2e 63 6f 6d  
ReadResult: ns=2;s=MyInt Status: StatusCode{name=Good, value=0x00000000, quality=good}  
Type: java.lang.Integer  
Single value: 771  
ReadResult: ns=2;s=MyDouble Status: StatusCode{name=Good, value=0x00000000, quality=good}  
Type: java.lang.Double  
Single value: 123.45  
ReadResult: ns=0;i=2258 Status: StatusCode{name=Good, value=0x00000000, quality=good}  
Type: org.eclipse.milo.opcua.stack.core.types.builtin.DateTime  
Single value: DateTime{utcTime=134328352697010000, javaDate=Wed Sep 02 16:07:49 BST 2026}  
ReadResult: i=2255 Status: StatusCode{name=Good, value=0x00000000, quality=good}  
Type: [Ljava.lang.String;  
Item 0: <http://opcfoundation.org/UA/>  
Item 1: urn:simplysoftware:eek:pcuaserver  
Item 2: urn:simplysoftware:b4j  
ReadResult: ns=2;s=MyInt Status: StatusCode{name=Good, value=0x00000000, quality=good}  
Type: java.lang.Integer  
Single value: 771  
ReadResult: ns=2;s=MyDouble Status: StatusCode{name=Good, value=0x00000000, quality=good}  
Type: java.lang.Double  
Single value: 123.45  
ReadResult: ns=2;s=MyHex Status: StatusCode{name=Good, value=0x00000000, quality=good}  
Type: java.lang.String  
Single value: 77 77 77 2e 62 34 78 2e 63 6f 6d  
ReadWriteResult: ns=2;s=MyDouble old=123.45 new=6.3 success=true  
ReadWriteResult: ns=2;s=MyInt old=771 new=1395 success=true  
WriteResult: ns=2;s=MyDouble success=true  
WriteResult: ns=2;s=MyInt success=true  
WriteResult: ns=2;s=MyInt success=true  
WriteResult: ns=2;s=MyDouble success=true  
WriteResult: ns=2;s=MyBoolean success=true  
WriteVerified: ns=2;s=MyDouble success=true  
[/SPOILER]  
  
**B4J test applications**  
![](https://www.b4x.com/android/forum/attachments/173415)  
  
**SS\_OPCUAClient  
  
Author:** Peter Simpson  
**Version:** 1.0  

- **OPCUAClient**
*OPC UA Client library.  
 This class provides a bridge to OPC UA services including endpoint discovery,  
 session management, subscription monitoring, and data communication.*

- **Events:**

- **BrowseResult** (Nodes As List)
- **Connected**
- **ConnectionError** (Error As String)
- **Disconnected**
- **ReadResult** (NodeId As String, Value As Object, Status As String)
- **SubscriptionValueChanged** (NodeId As String, Value As Object, Timestamp As Long)
- **WriteResult** (NodeId As String, Success As Boolean)

- **Fields:**

- **FireOnlyOnChange** As Boolean
*When set to True, subscription events are only raised when the value changes.  
 Duplicate values are ignored even if they arrive seconds apart.*- **SuppressDuplicateValues** As Boolean
*When set to True, duplicate values arriving too quickly are suppressed.  
 This prevents rapid duplicate events caused by server timestamp behaviour.*
- **Functions:**

- **Browse** (NodeIdString As String)
*Browses the specified node.  
 NodeIdString is the OPC UA node identifier such as ns=2;s=MyNode.  
 Returns a List of browse names.  
 Raises BrowseResult or ConnectionError.*- **BrowseFull** (NodeIdString As String)
*Browses a node and returns full details.  
 NodeIdString is the OPC UA node identifier such as ns=2;s=MyNode.  
 Returns a List of Maps with NodeId, DisplayName and NodeClass.  
 Raises BrowseResult.*- **Connect** (EndpointUrl As String)
*Connects to an OPC UA server using anonymous authentication.  
 EndpointUrl is the OPC UA endpoint such as opc.tcp://host:4840.  
 Selects the server's None/None endpoint.  
 Raises Connected or ConnectionError.*- **ConnectAuth** (EndpointUrl As String, Username As String, Password As String, SecurityPolicyName As String, MessageSecurityModeName As String)
*Connects to a secure OPC UA server using username and password.  
 EndpointUrl is the OPC UA endpoint such as opc.tcp://host:4840.  
 Username is the OPC UA user name.  
 Password is the OPC UA password.  
 SecurityPolicyName specifies the required security policy such as Basic256Sha256.  
 MessageSecurityModeName specifies the required security mode such as Sign or SignAndEncrypt.  
 Raises Connected or ConnectionError.*- **ConnectAuthWithCertificate** (EndpointUrl As String, Username As String, Password As String, SecurityPolicyName As String, MessageSecurityModeName As String, p12Path As String, p12Password As String)
*Connect using a client certificate (PKCS#12) for TLS and username/password for user identity.  
 SecurityPolicyName: e.g. "Basic256Sha256" or full URI  
 MessageSecurityModeName: e.g. "SignAndEncrypt" or "Sign"  
 Raises Connected or ConnectionError.*- **ConnectAutoSecure** (EndpointUrl As String)
*Connects using the strongest secure endpoint available.  
 Automatically selects the best SecurityPolicy and MessageSecurityMode.  
 Uses anonymous authentication.  
 Raises Connected or ConnectionError.*- **ConnectAutoSecureWithCertificate** (EndpointUrl As String, p12Path As String, p12Password As String)
*Auto secure connect: choose the strongest endpoint available, use client certificate for TLS.  
 Anonymous user identity.  
 Raises Connected or ConnectionError.*- **ConnectWithCertificate** (EndpointUrl As String, p12Path As String, p12Password As String)
*Connect using a client certificate (PKCS#12) and anonymous user identity.  
EndpointUrl: opc.tcp://host:port/…  
 p12Path: full path to the .p12/.pfx file  
 p12Password: password for the keystore  
 Raises Connected or ConnectionError.*- **DebugDump** As Map
*Returns a basic Map summarizing active subscriptions and items.*- **DebugDumpDetailed** As Map
*Returns a detailed Map containing every subscription and its monitored items currently active in the client.*- **Disconnect**
*Disconnects from the OPC UA server.  
 Closes the client session and releases resources.  
 Raises Disconnected or ConnectionError.*- **HasMonitoredItem** (NodeIdString As String) As Boolean
*Checks if a specific NodeId is currently being monitored in any subscription.*- **HasSubscription** (NodeIdString As String) As Boolean
*Returns True if any active subscription contains the specified node, otherwise False.  
 NodeIdString is the OPC UA node identifier.*- **Initialize** (EventName As String)
*Initialises the OPC UA client.  
 EventName is the prefix used for all raised events.*- **IsConnected** As Boolean
*Returns whether the client is currently connected.  
 Returns true when the OPC UA session is active.  
 Returns false when not connected or after a disconnect.*- **ListMonitoredItems** (SubscriptionId As String) As List
*Returns a List of NodeIds being monitored in the given subscription.*- **ListSubscriptions** As List
*Returns a List of active subscription IDs.*- **Read** (NodeIdString As String)
*Reads a single node.  
 NodeIdString is the OPC UA node identifier such as ns=2;s=MyNode.  
 Returns Value and Status in the ReadResult event.  
 Raises ReadResult or ConnectionError.*- **ReadMultiple** (NodeIds As List)
*Reads multiple nodes.  
 NodeIds is a List of node id strings.  
 Raises ReadResult for each node.*- **ReadWrite** (NodeIdString As String, NewValue As Object)
*Reads a value from a node, writes a new value, then reads again to verify.  
 NodeIdString is the OPC UA node identifier.  
 NewValue is the value to write.  
 Raises ReadWriteResult.*- **Subscribe** (NodeIdString As String, SamplingIntervalMs As Int)
*Subscribes to value changes on an node.  
 NodeIdString is the OPC UA node identifier such as ns=2;s=MyNode.  
 SamplingIntervalMs specifies the sampling interval in milliseconds.  
 Raises SubscriptionValueChanged or ConnectionError.*- **SubscribeMultiple** (NodeIds As List, SamplingIntervalMs As Int)
*Subscribes to multiple nodes at once.  
 NodeIds is a B4X List of node id strings.  
 SamplingIntervalMs specifies the sampling interval.  
 Raises SubscriptionValueChanged for each node.*- **SubscribeOnce** (NodeIdString As String, SamplingIntervalMs As Int)
*Subscribes to a node only if it is not already monitored.  
 NodeIdString is the OPC UA node identifier such as ns=2;s=MyNode.  
 SamplingIntervalMs is the sampling interval in milliseconds.*- **UnSubscribe** (NodeIdString As String)
*Unsubscribes from a specific node.  
 Deletes the entire subscription containing that node.*- **UnsubscribeAll**
*Unsubscribe all monitored subscriptions.*- **Write** (NodeIdString As String, Value As Object)
*Writes a value to an node.  
 NodeIdString is the OPC UA node identifier such as ns=2;s=MyNode.  
 Value is the new value to write.  
 Raises WriteResult or ConnectionError.*- **WriteAndVerify** (NodeIdString As String, Value As Object)
*Writes a value to a node and then reads it back to verify success.  
 NodeIdString is the node identifier.  
 Value is the value to write.  
 Raises WriteVerified.*- **WriteMultiple** (NodeIds As List, Values As List)
*Writes multiple nodes.  
 NodeIds is a B4X List of node id strings.  
 Values is a B4X List of values matching the node ids.  
 Raises WriteResult for each node.*
  
**PLEASE NOTE:  
TO RUN THE ATTACHED EXAMPLE, YOU NEED TO DOWNLOAD THE THIRD-PARTY **JAVA DEPENDENCIES** LINKED BELOW, AS WELL AS USING THE ATTACHED POST LIBRARY.**  
[**CLICK HERE**](https://www.dropbox.com/scl/fi/7uovvgw0ndaqgflv6id7y/UPC-UA-Client-Dependencies.zip?rlkey=zdujqeqqqbnm5bq4m8mxt7m2x&dl=0) to download extra dependencies <<<<<<<<<<<<<<<<<<<<<<<<  
  
  
**Enjoy…**
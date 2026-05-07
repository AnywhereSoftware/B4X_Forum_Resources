### rESPNOW by rwblinn
### 05/05/2026
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/170943/)

**B4R Library rESPNOW**  

---

  
  
**Brief  
rESPNOW** is an open-source B4R library that enables communication between ESP32 boards using the ESP-NOW protocol (connectionless, low-latency wireless).  
ESP-NOW does not require WiFi router or pairing  
  

---

  
  
**Purpose**  

- Provide a simple and lightweight ESP-NOW wrapper for B4R.
- Enable reliable communication between two or more ESP32 devices.
- Support sender, receiver, or bidirectional communication.
- Offer an event-driven interface for sending and receiving data.

---

  
  
**Development Info**  
This B4R library is:  

- A thin B4R wrapper around the native ESP-NOW functionality.
- Written in C++ (Arduino IDE 2.3.4 and *B4Rh2xml* tool).
- Based on ESP32 platform version **esp32@3.3.8**.
- Tested with ESP-WROOM-32 modules.
- Tested with B4R v4.00 (64-bit).

---

  
  
**Compatibility**  

- Supports **ESP32-based boards only**.
- Requires ESP32 Arduino Core 3.x (uses new ESP-NOW callback API).

---

  
  
**Files**  
The *rESPNOW.zip* archive contains the library and example projects.  
  

---

  
  
**Install**  

- Copy the *rESPNOW* folder into your B4R **Additional Libraries** folder.
- Keep the folder structure intact.
- Ensure the ESP32 platform is installed via Arduino IDE Boards Manager.

---

  
  
**Functions**  
  
Initialize(DataReceivedSub As String, DataSentSub As String) As Boolean  
Initializes ESP-NOW communication.  
**DataReceivedSub** - Callback for received data  
**DataSentSub** - Callback for send result  
**Returns** - True if initialization succeeded, False otherwise.  
  
SetChannel(Channel As Byte)  
Set WiFi channel used for ESP-NOW communication.  
**Channel** - WiFi channel (1–13). All peers must use the same channel.  
  
GetMAC As Byte()  
Returns the device MAC address (STA interface).  
**Returns** - Byte array (6 bytes)  
  
AddPeer(Mac() As Byte) As Boolean  
Adds a peer device for communication.  
**Mac** - MAC address of the peer  
**Returns** - True if added successfully, False otherwise.  
  
RemovePeer(Mac() As Byte) As Boolean  
Removes a peer device.  
**Mac** - MAC address of the peer  
**Returns** - True if removed successfully, False otherwise.  
  
SendData(Mac() As Byte, Data() As Byte) As Boolean  
Sends data to a peer device.  
Triggers event **OnDataSent**.  
**Mac** - MAC address of the peer  
**Data** - Byte array to send  
**Returns** - True if send request accepted, False otherwise.  
  

---

  
  
**Events**  
  
Sub OnReceived(Mac() As Byte, Data() As Byte)  
Triggered when data is received from a peer.  
  
Sub OnDataSent(Mac() As Byte, Status As Byte)  
Triggered after sending data.  
Status  

- 1 = SEND\_OK (data sent successfully)
- 0 = SEND\_FAIL (send failed or peer not reachable)

---

  
  
Constants  
  
Byte SEND\_OK = 1 - Send successful  
Byte SEND\_FAIL = 0 - Send failed  
  

---

  
  
**Examples**  

- **sendrecv** – ESP32 A sends 2 bytes to ESP32 B (one-way communication).
- **sendrecvheartbeat** – ESP32 A and B communicate in both directions using a heartbeat and ACK mechanism.
- **sendrecvpacket** – ESP32 A sends a fixed 8-byte structured packet (with checksum) to ESP32 B.
- **sendrecvserialized** – ESP32 A sends multiple values (Float, Byte, Byte, Byte) using B4RSerializer to ESP32 B.

---

  
  
**Which Example to use?**  
  
[TABLE]  
[TR]  
[TH]Example[/TH]  
[TH]Use Case[/TH]  
[TH]Pros[/TH]  
[TH]Cons[/TH]  
[/TR]  
[TR]  
[TD]sendrecv[/TD]  
[TD]Basic testing / first setup[/TD]  
[TD]Very simple, minimal code[/TD]  
[TD]No structure, no reliability[/TD]  
[/TR]  
[TR]  
[TD]sendrecvheartbeat[/TD]  
[TD]Connection monitoring, bidirectional comms[/TD]  
[TD]Detects connection loss, simple ACK mechanism[/TD]  
[TD]Extra traffic, no data structure[/TD]  
[/TR]  
[TR]  
[TD]sendrecvpacket[/TD]  
[TD]Efficient, reliable data transfer (recommended for production)</TD]  
[TD]Small payload, checksum, deterministic format[/TD]  
[TD]More implementation effort[/TD]  
[TD][/TD]  
[/TR]  
[TR]  
[TD]sendrecvserialized[/TD]  
[TD]Flexible data exchange, rapid prototyping[/TD]  
[TD]Easy to use, supports multiple data types[/TD]  
[TD]Larger payload, less control over format[/TD]  
[/TR]  
[/TABLE]  
  

---

  
  
**Example Basic**  
  
This example demonstrates communication between two ESP32 devices.  
The sender transmits 2 bytes to the receiver using ESP-NOW.  
  
Important:  

- Use the receiver MAC address in the sender code.
- Both ESP32 devices must use the same WiFi channel.
- Open two B4R IDE instances for testing (separate COM ports).

Example MAC addresses:  
- Sender: E08CFE34B4AC  
- Receiver: 80F3DA4C3678  
  

---

  
  
ESP32 Sender  

```B4X
Sub Process_Globals  
    Private VERSION As String = "rESPNOW Sender v20260505"  
    
    Public SerialLine As Serial  
    Private SERIAL_LINE_BAUDRATE As ULong = 115200  
  
    Private Esp As ESPNow  
    Private PeerMac() As Byte = Array As Byte(0x80,0xF3,0xDA,0x4C,0x36,0x78)  
End Sub  
  
Private Sub AppStart  
    SerialLine.Initialize(SERIAL_LINE_BAUDRATE)  
    Log("[Main.AppStart] ", VERSION)  
  
    Esp.Initialize("OnReceived", "OnDataSent")  
    Log("[Main.AppStart] espmac=", Convert.BytesToHex(Esp.GetMAC()))  
  
    Esp.AddPeer(PeerMac)  
  
    Dim data() As Byte = Array As Byte(0x19, 0x58)  
    Esp.SendData(PeerMac, data)  
End Sub  
  
Private Sub OnReceived(mac() As Byte, data() As Byte)  
    Log("[OnReceived] mac=", Convert.BytesToHex(mac), " data=", Convert.BytesToHex(data))  
End Sub  
  
Private Sub OnDataSent(mac() As Byte, status As Byte)  
    Log("[OnDataSent] mac=", Convert.BytesToHex(mac), " status=", Convert.ByteToHex(status))  
    
    If status = Esp.SEND_OK Then  
        Log("[OnDataSent] TX OK")  
    Else  
        Log("[OnDataSent][E] TX FAILED")  
    End If  
End Sub
```

  
  

---

  
  
ESP32 Receiver  

```B4X
Sub Process_Globals  
    Private VERSION As String = "rESPNOW Receiver v20260505"  
    
    Public SerialLine As Serial  
    Private SERIAL_LINE_BAUDRATE As ULong = 115200  
  
    Private Esp As ESPNow  
End Sub  
  
Private Sub AppStart  
    SerialLine.Initialize(SERIAL_LINE_BAUDRATE)  
    Log("[Main.AppStart] ", VERSION)  
  
    Esp.Initialize("OnReceived", "OnDataSent")  
    Log("[Main.AppStart] espmac=", Convert.BytesToHex(Esp.GetMAC()))  
End Sub  
  
Private Sub OnReceived(mac() As Byte, data() As Byte)  
    Log("[OnReceived] mac=", Convert.BytesToHex(mac), " data=", Convert.BytesToHex(data))  
End Sub  
  
Private Sub OnDataSent(mac() As Byte, status As Byte)  
    Log("[OnDataSent] mac=", Convert.BytesToHex(mac), " status=", Convert.ByteToHex(status))  
End Sub
```

  
  

---

  
  
**Troubleshooting**  

- Ensure both ESP32 devices use the same WiFi channel.
- Verify the peer MAC address is correct.
- Ensure the peer device is powered on.
- If sending fails, check the OnDataSent status.

---

  
  
**License**  
MIT License – see LICENSE file.  
  

---

  
  
**Disclaimer**  

- All trademarks are property of their respective owners.
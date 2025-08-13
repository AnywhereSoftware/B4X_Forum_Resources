###  SP IFStatus - Check if interface status (WiFi, cell network data or LAN) has enabled or disabled by Sergio Haurat
### 06/28/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/161849/)

- **IFStatus**

- **Events**

- **SocketStarted** (Port As Int)
Triggers when the socket starts- **SocketClosed**
Triggers when socket closes- **ConnectionStatusChanged** (IPStatus As tpeIPs)
Triggers when there is a change in the connection. Returns a tpeIPs type variable. *See details below*- **Error** (Msg As String)
Trigger when an error occurs, they can be the following:

- Socket not initialized.
- The IP format is not valid. Includes *IPv4 or IPv6*
- Can't initialize socket.
- Can't initialize socket on port *NUM\_OF\_PORT*
- Socket is already initialized on port *NUM\_OF\_PORT*

- **Types**

- **tpeIPs** (IsConnected As Boolean, ConnType As String, IP As String)

- IsConnected: True or False
- ConnType: NONE (B4X), WIFI (B4A/B4I), CELL (B4A/B4I) or LAN (B4J)
- IP: Valid IPv4 or IPv6

- **Fields**

- **Tag** As Object
Default: Null (It is always valuable to have a Tag field ;))- **IPs** As tpeIPs
Default: IsConnected = False, ConnType = "NONE", IP: "127.0.0.1"- **blnIPv4IsValid** As Boolean
Default: false- **blnIPv6IsValid** As Boolean
Default: false
- **Methods**

- **Initialize** (CallBack As Object, EventName As String)
Initializes the object*. Add parameters to this method.*- **Start** (Port As Int)
Start the socket on the desired port
*IMPORTANT: The number can be 0 or one greater than or equal to 1025 up to 65535.  
 Search on* [*this list of ports*](https://en.wikipedia.org/wiki/List_of_TCP_and_UDP_port_numbers) *for one that is available and does not conflict with another service*- **GetIfChanged** (ForceRaiseStatus As Boolean)
Update **IPs** variable
Default: False. If *ForceRaiseStatus* is **True**, raise event **ConnectionStatusChanged** whether the IP has changed or not- **Close**
Close socket
Change log:  

- **1.00**

- Release

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
    Private ifSts As IFStatus  
    Private btnCheck As Button  
End Sub  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  
    ifSts.Initialize(Me, "SPIFStatus")  
End Sub  
  
Private Sub SPIFStatus_SocketStarted (Port As Int)  
  
End Sub  
  
Private Sub SPIFStatus_SocketClosed  
  
End Sub  
  
Private Sub SPIFStatus_ConnectionStatusChanged (IPStatus As tpeIPs)  
    If ifSts.IPs.IsIfConnected Then  
        Log("— Interface General info —")  
        Log("Interface connected?: " & ifSts.IPs.IsIFConnected)  
        Log("Connection type: " & ifSts.IPs.ConnType)  
        Log("Local IP: " & ifSts.IPs.IP)  
    End If  
End Sub  
  
Private Sub SPIFStatus_Error (Msg As String)  
  
End Sub  
  
Private Sub btnCheck_Click  
    If Not (ifSts.IPs.IsIfConnected) Then  
        ifSts.Start(0)  
    Else  
        ifSts.GetIfChanged(True)  
    End If  
End Sub
```

  
  
The result in the log  
![](https://www.b4x.com/android/forum/attachments/154973)
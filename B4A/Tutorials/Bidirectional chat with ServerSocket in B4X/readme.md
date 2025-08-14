### Bidirectional chat with ServerSocket in B4X by WebQuest
### 06/05/2025
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/167296/)

I developed a two-way chat system using ServerSocket and Socket in B4X. This project allows a connection to be established between a client and a server within a local network, enabling messages to be exchanged in real time.  
  
🔹 ***[SIZE=4]Code structure[/SIZE]***  
   
 The system is based on:  
  
- **ServerSocket** for accepting incoming connections.  
- **Socket** for connecting the client to the server.  
- **AsyncStreams** for handling two-way communication.  
- **ListView** to show available IPs and sent/received messages.  
  
🏗️ ***Operation***  
1️⃣ The server starts listening on the default port (5050).  
2️⃣ The client connects to a selected IP via ClientSocket.Connect().  
3️⃣ Data is transmitted using AsyncStreams.Write().  
4️⃣ Received messages are handled in the AStreamsServer\_NewData() and AStreamsClient\_NewData()  
  
methods:  
📌 GetLocalIP() - Obtains the IP address of the device.  
📌 ScanNetwork() - Generates a list of IPs available on the local network.  
📌 Ping() - Checks the reachability of a given IP.  
📌 SendMessage\_Click() - Sends the entered text to the server or client.  
  
[MEDIA=youtube]RxBU9oeO3bY[/MEDIA]  
  
If you think this codicie is useful support my efforts here: [Donate![](https://www.b4x.com/android/forum/attachments/164578)](https://paypal.me/SamuelLaManna?country.x=DE&locale.x=en_US)  
  
'B4XPages   

```B4X
Sub Class_Globals  
Private Root As B4XView  
    Private xui As XUI  
    Private lstIPs As ListView  
    Private btnConnect As Button  
    Private selectedIP As String  
   
    Private xui As XUI  
    Private ServerSocket As ServerSocket  
    Private ClientSocket As Socket  
    Private AStreamsServer As AsyncStreams  
    Private AStreamsClient As AsyncStreams  
    Private defaultPort As Int = 5050  
    Private EditTextIP As EditText  
    Private BT_clear_log As Button  
    Private SendMessage As Button  
End Sub  
  
Public Sub Initialize  
'    B4XPages.GetManager.LogEvents = True  
End Sub  
  
'This event will be called once, before the page becomes visible.  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  
    lstIPs.SingleLineLayout.Label.TextSize = 13  
    lstIPs.SingleLineLayout.ItemHeight = 16dip  
    Dim myIP As String = GetLocalIP  
    lstIPs.AddSingleLine("Indirizzi ip:"&myIP)  
    Log("IP Device:"&myIP)  
    Sleep(500)  
    ' Avvia il server  
    ServerSocket.Initialize(defaultPort, "ServerSocket")  
    ServerSocket.Listen  
    lstIPs.AddSingleLine("VMS server in ascolto… "&myIP)  
    Sleep(500)  
    lstIPs.AddSingleLine("porta predefinita: "&defaultPort)  
    Sleep(500)  
   
End Sub  
  
Sub GetLocalIP As String  
    Dim Server As ServerSocket  
    Server.Initialize(0, "")  
    Dim localIP As String = Server.GetMyWifiIP  
    Server.Close  
    Return localIP  
End Sub  
  
  
'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.  
  
  
Sub lstIPs_ItemClick(Position As Int, Value As Object)  
    lstIPs.Clear  
   
    selectedIP = Value  
    ToastMessageShow("IP selezionato: " & selectedIP, False)  
    lstIPs.AddSingleLine("IP Selezionato: "&selectedIP)  
    Sleep(500)  
    If selectedIP <> "" Then  
        ToastMessageShow("Connessione a " & selectedIP, False)  
        lstIPs.AddSingleLine("Connessione a:" & selectedIP)  
        Sleep(500)  
        ' Qui puoi avviare la connessione al server  
     
        ' Avvia il server  
'ServerSocket.Initialize(defaultPort, "ServerSocket")  
    'ServerSocket.Listen  
ToastMessageShow("Server in attesa di connessioni…", False)  
        lstIPs.AddSingleLine("Server in attesa di connessione…:" )  
        Sleep(500)  
'        ' Connetti al server remoto (modifica l'IP con quello del dispositivo server)  
ClientSocket.Initialize("ClientSocket")  
ClientSocket.Connect(selectedIP, defaultPort, 5000) ' Sostituisci con l'  
     
    Else  
        ToastMessageShow("Seleziona un IP prima di connetterti!", True)  
    End If  
End Sub  
  
Sub btnConnect_Click  
    ScanNetwork  
End Sub  
  
' Gestione connessione in entrata (Server)  
Sub ServerSocket_NewConnection (Successful As Boolean, NewSocket As Socket)  
    If Successful Then  
        ToastMessageShow("Connessione stabilita con un client!", False)  
        lstIPs.AddSingleLine("Connessione stabilita con client: " & selectedIP)  
        Sleep(500)  
        AStreamsServer.Initialize(NewSocket.InputStream, NewSocket.OutputStream, "AStreamsServer")  
    Else  
        ToastMessageShow("Connessione fallita!", True)  
        lstIPs.AddSingleLine("Connessione fallita: " & selectedIP)  
        Sleep(500)  
    End If  
End Sub  
  
' Gestione connessione in uscita (Client)  
Sub ClientSocket_Connected (Successful As Boolean)  
    If Successful Then  
        ToastMessageShow("Connesso al server remoto!", False)  
        lstIPs.AddSingleLine("Client connesso al server remote: " & selectedIP)  
        Sleep(500)  
        AStreamsClient.Initialize(ClientSocket.InputStream, ClientSocket.OutputStream, "AStreamsClient")  
    Else  
        ToastMessageShow("Connessione fallita!", True)  
        lstIPs.AddSingleLine("Connessione fallita: " & selectedIP)  
        Sleep(500)  
    End If  
End Sub  
  
' Ricezione dati dal server  
Sub AStreamsServer_NewData (Buffer() As Byte)  
    Dim msg As String = BytesToString(Buffer, 0, Buffer.Length, "UTF8")  
    ToastMessageShow("client: " & msg, False)  
    lstIPs.AddSingleLine("client: " & msg)  
    Sleep(500)  
End Sub  
' Ricezione dati dal client  
Sub AStreamsClient_NewData (Buffer() As Byte)  
    Dim msg As String = BytesToString(Buffer, 0, Buffer.Length, "UTF8")  
    'ToastMessageShow("Messaggio ricevuto dal server: " & msg, False)  
    lstIPs.AddSingleLine("client: " & msg)  
    Sleep(500)  
End Sub  
' Invio messaggio al server o client  
Sub SendMessage_Click  
    Dim str As String = EditTextIP.Text  
    If AStreamsServer.IsInitialized Then AStreamsServer.Write(str.GetBytes("UTF8"))  
    If AStreamsClient.IsInitialized Then AStreamsClient.Write(str.GetBytes("UTF8"))  
    ToastMessageShow("Messaggio inviato!", False)  
    lstIPs.AddSingleLine("@> "&EditTextIP.Text)  
    Sleep(500)  
End Sub  
  
  
Sub ScanNetwork()  
    ToastMessageShow("Scansione Avviata…",True)  
   
    Dim baseIP As String = "192.168.178."  
    Dim activeIPs As List  
    activeIPs.Initialize  
    Log(activeIPs)  
    For i = 1 To 255  
        Dim ip As String = baseIP & i  
            'If Ping(ip) Then  
        activeIPs.Add(ip)  
        Log(activeIPs)  
        'End If  
    Next  
    Log(activeIPs)  
    lstIPs.Clear  
    lstIPs.AddSingleLine("Generazione lista IP")  
    For Each ip As String In activeIPs  
        lstIPs.AddSingleLine(ip)  
    Next  
End Sub  
  
Sub Ping(targetIP As String) As Boolean  
    Dim p As Phone  
    Dim result As Int = p.Shell("ping", Array As String("-c", "178", targetIP), Null, Null)  
    Return (result = 0)  
End Sub  
  
Sub GetConnectedDevices  
    Dim p As Phone  
    Dim result As String = p.Shell("ip", Array As String("neigh"), Null, Null)  
    Log("Dispositivi connessi: " & result)  
    lstIPs.AddSingleLine(result)  
End Sub  
  
Private Sub BT_Connetti_Click  
  
    ToastMessageShow("Server in attesa di connessioni…", False)  
    lstIPs.AddSingleLine("Server in attesa di connessione… ")  
    Sleep(500)  
'        ' Connetti al server remoto (modifica l'IP con quello del dispositivo server)  
If EditTextIP.Text.Length>0 Then  
selectedIP= EditTextIP.Text  
    ClientSocket.Initialize("ClientSocket")  
    ClientSocket.Connect(selectedIP, defaultPort, 5000) ' Sostituisci con l'  
Else  
    ToastMessageShow("Inserisci un indirizzo IP e premi 'Connetti'",True)  
    End If  
   
End Sub  
  
Private Sub BT_clear_log_Click  
    lstIPs.Clear  
    Dim myIP As String = GetLocalIP  
    lstIPs.AddSingleLine("Indirizzo ip:"&myIP&" ~ VMLOG Ver.1.1")  
    Sleep(500)  
End Sub
```
###  Check if Internet interfaces are enabled and internet status + type (WiFi/Cell/LAN) by Sergio Haurat
### 07/04/2024
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/161750/)

This project combines two libraries, [B4X] SP Ping and [B4X] IFStatus. The following code shows how to use both libraries.  
  
<https://www.b4x.com/android/forum/threads/b4x-sp-ping-run-the-ping-command-from-b4a-b4j-and-b4i.161861/>  
  
<https://www.b4x.com/android/forum/threads/b4x-sp-ifstatus-check-if-interface-status-wifi-cell-network-data-or-lan-has-enabled-or-disabled.161849/>  
  
  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
    Private ifSts As IFStatus  
    Private SPPing As Ping  
    Private btnCheck As Button  
End Sub  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  
    ifSts.Initialize(Me, "SPIFStatus")  
    SPPing.Initialize(Me, "SPPing")  
End Sub  
  
Private Sub SPPing_PingStarted  
  
End Sub  
Private Sub SPPing_PingFinished  
    If SPPing.pingResult.Success Then  
        Log("— Ping info —")  
        Log("Ping Success: " & SPPing.pingResult.Success)  
        Log("Ping To host: " & SPPing.pingResult.toHost)  
        Log("Ping To IP: " & SPPing.pingResult.toIP)  
        Log("Ping From host: " & SPPing.pingResult.fromDest)  
        For Each bteKey As Byte In SPPing.pingResult.mapResponse.Keys  
            Dim seqMap As Map = SPPing.pingResult.mapResponse.Get(bteKey)  
            Log("Ping Sequence " & bteKey & " - TTL : " & seqMap.Get("ttl") & " - Time : " & seqMap.Get("time"))  
        Next  
        Dim stats As Map = SPPing.pingResult.mapStatistics  
        Log("Internet connected?: " & SPPing.pingResult.Success)  
        Log("Ping Packets transmitted: " & stats.Get("packets transmitted"))  
        Log("Ping Packets received: " & stats.Get("received"))  
        Log("Ping Packets loss: " & stats.Get("packet loss"))  
        Log("Ping Round Trip Time (Minimum): " & stats.Get("rtt min"))  
        Log("Ping Round Trip Time (Average): " & stats.Get("rtt agv"))  
        Log("Ping Round Trip Time (Maximum): " & stats.Get("rtt max"))  
        Log("Ping Round Trip Time (Mean Deviation): " & stats.Get("rtt mdev"))  
    End If  
End Sub  
  
Private Sub SPPing_PingError(Msg As String)  
    Log(Msg)  
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
        SPPing.Destination = "google.com"  
        SPPing.Attempts = 1  
        SPPing.Timeout = 200  
        SPPing.Start  
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

  
  
Log result  
![](https://www.b4x.com/android/forum/attachments/154998)
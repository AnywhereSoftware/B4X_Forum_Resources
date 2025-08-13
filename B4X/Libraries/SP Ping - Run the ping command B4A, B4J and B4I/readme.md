###  SP Ping - Run the ping command B4A, B4J and B4I by Sergio Haurat
### 06/28/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/161861/)

SP Ping allows you to run the ping command on B4A, B4J and B4I. The characteristics of each operating system require different external libraries and change the amount of information returned after execution. In **red** we show you the fields that are empty in each operating system.  
  

- **Ping**

- **Events**

- **PingStarted**
Triggers when the ping starts- **PingFinished**
Triggers when ping stops- **PingError** (Msg As String)
- Trigger when an error occurs, they can be the following:

- Attempts must be greater than or equal to 1
- Host unreachable
- ERROR: LANGUAGE NOT FOUND (Only B4J)
- Can't run ping command on your system (Only B4J)

- **Types**

- **tpePing** (Success As Boolean, toHost As String, toIP As String, fromDest As String, mapResponse As Map, mapStatistics As Map)

- IsConnected: True or False
- toHost: This value can be a URL or an IP
- toIP: The local IP address that DNS resolves to the URL mapped in toHost (if toHost is an IP address, repeat the same value)
- fromDest: The IP address or hostname that responds to the Ping command
- mapResponse: Map variable with a collection of Ping responses (details below)
- mapStatistics: Map type variable with a collection of Ping command statistics (details below)

- **Fields**

- **Tag** As Object

- Default: Null (It is always valuable to have a Tag field ;))

- **pingResult** As tpePing

- Default: Success = False, toHost = "", toIP = "", fromDest = "", mapResponse = Null, mapStatistics = Null

- **Destination** As String

- Default: "google.com"

- **Attempts** As Byte

- Default = 1

- **Timeout** As Int

- Default = 200

- **Methods**

- **Initialize** (CallBack As Object, EventName As String)
Initializes the object*. Add parameters to this method.*- **Start**
Start the ping command on your system
Change log:  

- **1.00**

- Release

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
    Private spPing As Ping  
    Private Button1 As Button  
End Sub  
  
Public Sub Initialize  
    B4XPages.GetManager.LogEvents = True  
    spPing.Initialize(Me, "SPPing")  
    spPing.Destination = "google.com"  
    spPing.Attempts = 4  
    spPing.Timeout = 200  
End Sub  
  
Private Sub SPPing_PingStarted  
    Log("Ping started")  
End Sub  
  
Private Sub SPPing_PingFinished  
    If spPing.pingResult.Success Then  
        Log("Success: " & spPing.pingResult.Success)  
        Log("To host: " & spPing.pingResult.toHost)  
        Log("To IP: " & spPing.pingResult.toIP)  
        Log("From host: " & spPing.pingResult.fromDest)  
        For Each bteKey As Byte In spPing.pingResult.mapResponse.Keys  
            Dim seqMap As Map = spPing.pingResult.mapResponse.Get(bteKey)  
            Log("Sequence " & bteKey & " - TTL : " & seqMap.Get("ttl") & " - Time : " & seqMap.Get("time"))  
        Next  
        Dim stats As Map = spPing.pingResult.mapStatistics  
        Log("Packets transmitted: " & stats.Get("packets transmitted"))  
        Log("Packets received: " & stats.Get("received"))  
        Log("Packets loss: " & stats.Get("packet loss"))  
        Log("Round Trip Time (Minimum): " & stats.Get("rtt min"))  
        Log("Round Trip Time (Average): " & stats.Get("rtt agv"))  
        Log("Round Trip Time (Maximum): " & stats.Get("rtt max"))  
        Log("Round Trip Time (Mean Deviation): " & stats.Get("rtt mdev"))  
    End If  
End Sub  
  
Private Sub SPPing_PingError(Msg As String)  
    Log(Msg)  
End Sub  
  
Private Sub Button1_Click  
    spPing.Start  
End Sub
```

  
  
**[SIZE=6]B4A[/SIZE]  
Additional libraries (not internal):** Does not depend on additional libraries  
**Additional files:** None  
**Information returned in this environment:**  
> Success: true  
> To host: google.com  
> To IP: 216.58.202.78  
> From host: gru10s11-in-f14.1e100.net  
> Sequence 1 - TTL : 116 - Time : 24.0  
> Sequence 2 - TTL : 116 - Time : 24.0  
> Sequence 3 - TTL : 116 - Time : 24.0  
> Sequence 4 - TTL : 116 - Time : 24.0  
> Packets transmitted: 4  
> Packets received: 4  
> Packets loss: 0  
> Round Trip Time (Minimum): 22.321  
> Round Trip Time (Average): 25.255  
> Round Trip Time (Maximum): 29.231  
> Round Trip Time (Mean Deviation): 2.549

  
**[SIZE=6]B4J[/SIZE]  
Additional libraries (not internal):** Attached B4JPing by [USER=115245]@Mariano Ismael Castro[/USER] (includes the java source code)  
**Additional files:** It [depends on this json file](https://www.b4x.com/android/forum/threads/b4x-ping-json-file.161790/) that contains the ping responses in different languages. If you can't find your language, follow the instructions in the post.  
**Information returned in this environment:**  
> Success: true  
> To host: google.com  
> To IP: 172.217.173.238  
> From host: 172.217.173.238  
> Sequence 1 - TTL : 116 - Time : 18  
> Sequence 2 - TTL : 116 - Time : 18  
> Sequence 3 - TTL : 116 - Time : 18  
> Sequence 4 - TTL : 116 - Time : 18  
> Packets transmitted: 4  
> Packets received: 4  
> Packets loss: 0  
> Round Trip Time (Minimum): 17  
> Round Trip Time (Average): 20  
> Round Trip Time (Maximum): 18  
> **Round Trip Time (Mean Deviation)**: null

  
**[SIZE=6]B4I[/SIZE]  
Additional libraries (not internal):** [USER=1]@Erel[/USER]'s [iPing library](https://www.b4x.com/android/forum/threads/iping-send-and-receive-ping-icmp-packets.132440/)  
**Information returned in this environment:**  
> Success: true  
> To host: google.com  
> **To IP**:  
> **From host:**   
> Sequence 1 - **TTL** : null - Time : 44  
> Sequence 2 - **TTL** : null - Time : 44  
> Sequence 3 - **TTL** : null - Time : 44  
> Sequence 4 - **TTL** : null - Time : 44  
> **Packets transmitted**: null  
> **Packets received**: null  
> **Packets loss**: null  
> **Round Trip Time (Minimum)**: null  
> **Round Trip Time (Average)**: null  
> **Round Trip Time (Maximum)**: null  
> **Round Trip Time (Mean Deviation)**: null

  
The result in the log  
![](https://www.b4x.com/android/forum/attachments/154993)  
  
I want to thank the users who helped create this library for B4X.  
  
Thank you, [USER=1]@Erel[/USER], for your infinite patience with questions that many have surely asked you hundreds of times, and a very special thanks to [USER=115245]@Mariano Ismael Castro[/USER] for sharing your knowledge in Java and not only sharing the library, also the source code available.
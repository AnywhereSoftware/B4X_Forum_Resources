### Send and Save Data into SQLite on Another Device (using UDP) by aeric
### 11/27/2023
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/157655/)

**Data Sender App**  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
    Private UDPSocket1 As UDPSocket  
    Private txtHost As EditText  
End Sub  
  
Public Sub Initialize  
  
End Sub  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  
    B4XPages.SetTitle(Me, Application.LabelName)  
    UDPSocket1.Initialize("UDP", 5000, 8000)  
    txtHost.Text = "192.168.50.91"  
End Sub  
  
Private Sub BtnSend_Click  
    SendData  
End Sub  
  
Private Sub SendData  
    Dim Names As List = Array As String("Tom", "Jerry", "Spike", "Tyke")  
    Dim Name As String = Names.Get( Rnd(0, 4) )  
    Dim Age As Int = Rnd(1, 99)  
      
    Dim M As Map = CreateMap("Action": "INSERT", "Query": "INSERT INTO Data (Name, Age) VALUES (?, ?)", "Parameters": Array(Name, Age))  
    Dim data() As Byte = M.As(JSON).ToCompactString.GetBytes("UTF8")  
    Dim Packet As UDPPacket  
    Packet.Initialize(data, txtHost.Text, 5000)  
    UDPSocket1.Send(Packet)  
    xui.MsgboxAsync("Data sent!", "B4X")  
End Sub
```

  
  
**Data Receiver App**  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
    Private UDPSocket1 As UDPSocket  
    Private DB As SQL  
    Private DATA_FOLDER As String  
    Private DATA_FILE As String  
End Sub  
  
Public Sub Initialize  
    DATA_FOLDER = xui.DefaultFolder  
    DATA_FILE = "Database.db"  
End Sub  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  
    B4XPages.SetTitle(Me, Application.LabelName)  
    UDPSocket1.Initialize("UDP", 5000, 8000)  
    If File.Exists(DATA_FOLDER, DATA_FILE) Then  
        DB.Initialize(DATA_FOLDER, DATA_FILE, False)  
    Else  
        DB.Initialize(DATA_FOLDER, DATA_FILE, True)  
        CreateTable  
    End If  
End Sub  
  
Private Sub BtnQuery_Click  
    Dim Query As String = $"SELECT * FROM Data"$  
    QueryDatabase(Query)  
End Sub  
  
Private Sub QueryDatabase (strSQL As String)  
    Dim RS As ResultSet = DB.ExecQuery(strSQL)  
    Do While RS.NextRow  
        Log($"${RS.GetInt("id")}: ${RS.GetString("Name")} (${RS.GetInt("Age")})"$)  
    Loop  
    RS.Close  
End Sub  
  
Private Sub CreateTable  
    Dim strSQL As String = $"CREATE TABLE Data (id INTEGER PRIMARY KEY AUTOINCREMENT, Name TEXT, Age INTEGER)"$  
    DB.ExecNonQuery(strSQL)  
End Sub  
  
Private Sub ExecuteCommand (strSQL As String, Parameters As List)  
    DB.ExecNonQuery2(strSQL, Parameters)  
End Sub  
  
Sub UDP_PacketArrived (Packet1 As UDPPacket)  
    Dim msg As String = BytesToString(Packet1.Data, Packet1.Offset, Packet1.Length, "UTF8")  
    Log("Message received: " & msg) ' received from 192.168.50.33  
    ToastMessageShow("Message received", False)  
    Dim M As Map = msg.As(JSON).ToMap  
    If M.IsInitialized Then  
        Dim Action As String = M.Get("Action")  
        Dim strSQL As String = M.Get("Query")  
        Dim Parameters As List = M.Get("Parameters")  
        Select Action.ToUpperCase  
            Case "INSERT"                 
                ExecuteCommand(strSQL, Parameters)  
            Case Else  
                  
        End Select  
    End If  
End Sub
```
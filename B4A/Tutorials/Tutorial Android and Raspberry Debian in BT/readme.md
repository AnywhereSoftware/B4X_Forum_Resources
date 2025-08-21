### Tutorial Android and Raspberry Debian in BT by MarcoRome
### 03/01/2020
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/114474/)

Hi all. In this example we have Raspberry Pi Rasbian and Android App ( communicate via BlueTooth ).  
  
Through Android we give the command to access and turn off/on the LED, and from the Raspberry we read in Android the status of the LED.  
  
[MEDIA=youtube]2Kxsc3RJ7Kk[/MEDIA]  
  
The code B4J ( Library JavaObject + jBluetooth + jPi4J + jRandomAccessFile )  
  

```B4X
'Non-UI application (console / server application)  
#Region  Project Attributes  
    #CommandLineArgs:  
    #MergeLibraries: True  
#End Region  
  
#AdditionalJar: bluecove-gpl-2.1.1-SNAPSHOT  
#AdditionalJar: bluecove-bluez-2.1.1-SNAPSHOT  
  
Sub Process_Globals  
    Private bt As Bluetooth  
    Private astream As AsyncStreams  
      
    Private controller As GpioController  
    Private Pin1 As GpioPinDigitalOutput  
      
    Dim timer1 As Timer  
      
End Sub  
  
Sub AppStart (Args() As String)  
    'Per connettersi via BT  
    'SetSystemProperty("bluecove.debug", "true")  
    bt.Initialize("bt")  
    If bt.IsEnabled = False Then  
        Log("Bluetooth not available1")  
        ExitApplication  
    End If  
    Log($"My address: ${GetBluetoothAddress}"$)  
    bt.Listen  
  
    'Per inizializzare e settare i PIN da controllare  
    controller.Initialize  
    Pin1.Initialize(1, False) 'GpioPinDigitalOutput –> GPIO18 Vedi schema Libreria jPi4J  
      
    timer1.Initialize("timer1",2000)  
        
    StartMessageLoop  
      
End Sub  
  
  
'Ok  
Sub timer1_Tick  
    If Pin1.State = True Then  
        Pin1.State = False  
        astream.Write(Array As Byte(1, 0))  
    Else  
        Pin1.State = True  
        astream.Write(Array As Byte(1, 1))  
    End If  
    Log(Pin1.State)  
End Sub  
  
  
Sub bt_Connected (Success As Boolean, Connection As BluetoothConnection)  
    If Success Then  
        If astream.IsInitialized Then  
            astream.Close  
        End If  
        Log($"Connected to: ${Connection.Name} - ${Connection.MacAddress}"$)  
        astream.InitializePrefix(Connection.InputStream, True, Connection.OutputStream, "astream")  
        bt.Listen  
    Else  
        Log("Error connecting…")  
    End If  
End Sub  
  
'Per Input da Raspberry  
Sub Switch_StateChange(Checked As Boolean)  
    If astream.IsInitialized Then  
        Dim index As Int =  switches.IndexOf(Sender)  
        Dim State As Byte  
        If Checked Then State = 1 Else State = 0  
        astream.Write(Array As Byte(index, State))  
    End If  
End Sub  
  
'Per input da Android  
Private Sub Astream_NewData (Buffer() As Byte)  
'    'Dim ledNumber As Int = Buffer(0)  
'    Dim state As Boolean = Buffer(1) = 1  
'    Pin1.State = state  
      
    Dim state As Boolean = Buffer(1) = 1  
    Pin1.State = state  
      
    If state = True Then       
        timer1.Enabled = True  
    Else  
        timer1.Enabled = False  
    End If  
End Sub  
  
Private Sub AStream_Error  
    AStream_Terminated  
End Sub  
  
Private Sub AStream_Terminated  
    Log("Connected terminated")  
End Sub  
  
Private Sub GetBluetoothAddress As String  
    Dim jo As JavaObject = bt  
    Dim raw As String = jo.GetFieldJO("device").RunMethod("getBluetoothAddress", Null)  
    Dim sb As StringBuilder  
    sb.Initialize  
    For i = 0 To raw.Length - 1 Step 2  
        If sb.Length > 0 Then sb.Append(":")  
        sb.Append(raw.SubString2(i, i + 2))  
    Next  
    Return sb.ToString  
End Sub
```

  
  
The Code B4A ( Library JavaObject + RandomAccessFile + Serial )  

```B4X
#Region  Project Attributes  
    #ApplicationLabel: Raspberry BT  
    #VersionCode: 1  
    #VersionName:  
    'SupportedOrientations possible values: unspecified, landscape or portrait.  
    #SupportedOrientations: portrait  
    #CanInstallToExternalStorage: False  
#End Region  
  
#Region  Activity Attributes  
    #FullScreen: True  
    #IncludeTitle: False  
#End Region  
  
Sub Process_Globals  
    Private astream As AsyncStreams  
    Private serial As Serial  
    Private connected As Boolean  
End Sub  
  
Sub Globals  
    Private txtMAC As EditText  
    Private lblState As Label  
    Private txtLogs As EditText  
    Private btnConnect As Button  
    Private btnDisconnect As Button  
  
    Private btn_accendi As Button  
    Private lbl_led As Label  
      
    Dim stato_led As Int  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    If FirstTime Then  
        serial.Initialize("serial")  
    End If  
    Activity.LoadLayout("1")  
    txtMAC.Text = "B8:27:EB:D6:79:DF"  
End Sub  
  
Sub Activity_Resume  
    UpdateState  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
  
End Sub  
  
Sub UpdateState  
    btnConnect.Enabled = serial.IsEnabled And Not(connected)  
    btnDisconnect.Enabled = connected  
    btn_accendi.Enabled = connected  
'    For Each v As View In pnlSwitches  
'        v.Enabled = connected  
'    Next  
    If connected Then  
        lblState.TextColor = Colors.Green  
        lblState.Text = "Connected"  
          
    Else  
        lblState.TextColor = Colors.Red  
        lblState.Text = "Not connected"  
    End If  
End Sub  
  
  
'ON / OFF led  
Sub btn_accendi_Click  
      
    'If Checked Then state = 1 Else state = 0  
    'astream.Write(Array As Byte(v.Switch.Tag, state))  
    'ON  
    Dim c2 As ColorDrawable  
    If stato_led = 1 Then  
        astream.Write(Array As Byte(1, 0))  
        stato_led = 0  
        c2.Initialize2(Colors.Red,50dip,1dip,Colors.White)  
        txtLogs.Text = $"State Remote Led 1 is OFF"$  
    Else  
        astream.Write(Array As Byte(1, 1))  
        stato_led = 1  
        c2.Initialize2(Colors.Green,50dip,1dip,Colors.White)  
        txtLogs.Text = $"State Remote Led 1 is ON"$  
    End If  
    lbl_led.Background = c2  
      
End Sub  
  
Sub btnConnect_Click  
    Try  
        serial.Connect(txtMAC.Text)  
    Catch  
        Log(LastException)  
        ToastMessageShow(LastException.Message, True)  
    End Try  
End Sub  
  
Sub Serial_Connected (Success As Boolean)  
    Log($"Connected ${Success}"$)  
    If Success Then  
        If astream.IsInitialized Then astream.Close  
        astream.InitializePrefix(serial.InputStream, True, serial.OutputStream, "astream")  
        connected = True  
        UpdateState  
    End If  
End Sub  
  
Sub btnDisconnect_Click  
    serial.Disconnect  
    astream.Close  
    connected = False  
    UpdateState  
End Sub  
  
Sub astream_NewData (Buffer() As Byte)  
    Dim state As String  
    If Buffer(1) = 1 Then state = "ON" Else state = "OFF"  
    txtLogs.Text = $"State Remote Led ${Buffer(0)} is ${state}"$  
    Dim c2 As ColorDrawable  
    If Buffer(1) = 1 Then  
        c2.Initialize2(Colors.Green,50dip,1dip,Colors.White)  
    Else  
        c2.Initialize2(Colors.Red,50dip,1dip,Colors.White)  
    End If  
    lbl_led.Background = c2  
      
End Sub  
  
Sub astream_Error  
    astream_Terminated  
End Sub  
  
Sub astream_Terminated  
    connected = False  
    UpdateState  
End Sub
```
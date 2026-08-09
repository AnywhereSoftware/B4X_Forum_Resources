### Connecting ESP32 to Android device by Beja
### 08/07/2026
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/171737/)

This is a clean code for beginners, to connect Andoid phone or tablet to ESP32 through Bluetooth. no external bluetooth is necessary as the ESP32 has embedded classic Bluetooth.  
you will need Core, seial and randomaccessfile libraries only. you will make a PAL file with 3 views -a buuton, a label and text box. enjoy:  
  
  

```B4X
#Region  Project Attributes  
    #ApplicationLabel: ESP32 Bluetooth Test  
    #VersionCode: 1  
    #VersionName: 1.0  
    #SupportedOrientations: unspecified  
    #CanInstallToExternalStorage: False  
#End Region  
  
#Region  Activity Attributes  
    #FullScreen: False  
    #IncludeTitle: True  
#End Region  
  
  
Sub Process_Globals  
  
    Private Serial1 As Serial  
    Private AStreams1 As AsyncStreams  
  
    Private BluetoothConnected As Boolean = False  
  
    Private Const ESP32_MAC As String = "nn:nn:nn:nn:nn:nn"  
  
End Sub  
  
  
Sub Globals  
  
    Private btnConnect As Button  
    Private btnSend As Button  
    Private txtNumber As EditText  
    Private lblAnswer As Label  
  
End Sub  
  
  
Sub Activity_Create(FirstTime As Boolean)  
  
    Activity.LoadLayout("Main")  
  
    If FirstTime Then  
        Serial1.Initialize("Serial1")  
    End If  
  
    lblAnswer.Text = "Connecting…"  
  
    Serial1.Connect("nn:nn:nn:nn:nn:nn") 'replace with the ESP32 MAC address  
  
End Sub  
  
  
Sub Activity_Resume  
  
End Sub  
  
  
Sub Activity_Pause(UserClosed As Boolean)  
  
    If UserClosed Then  
        CloseBluetooth  
    End If  
  
End Sub  
  
  
'===========================================================  
' CONNECT BUTTON  
'===========================================================  
  
Sub btnConnect_Click  
  
  
  
    If BluetoothConnected Then  
  
        CloseBluetooth  
  
        btnConnect.Text = "CONNECT"  
        btnSend.Enabled = False  
        lblAnswer.Text = "Disconnected"  
  
        Return  
  
    End If  
  
    lblAnswer.Text = "Connecting…"  
  
    Serial1.Connect(ESP32_MAC)  
  
  
End Sub  
  
  
'===========================================================  
' BLUETOOTH CONNECTION RESULT  
'===========================================================  
  
Sub Serial1_Connected(Success As Boolean)  
  
    If Success Then  
  
        AStreams1.Initialize( _  
            Serial1.InputStream, _  
            Serial1.OutputStream, _  
            "AStreams1")  
  
        BluetoothConnected = True  
  
        btnConnect.Text = "DISCONNECT"  
        btnSend.Enabled = True  
        lblAnswer.Text = "Connected"  
  
        ToastMessageShow("Connected to ESP32", False)  
  
    Else  
  
        BluetoothConnected = False  
  
        btnConnect.Text = "CONNECT"  
        btnSend.Enabled = False  
        lblAnswer.Text = "Connection failed"  
  
        ToastMessageShow("Bluetooth connection failed", True)  
  
    End If  
  
End Sub  
  
  
'===========================================================  
' SEND BUTTON  
'===========================================================  
  
Sub btnSend_Click  
  
    If BluetoothConnected = False Then  
        ToastMessageShow("Connect to the ESP32 first.", False)  
        Return  
    End If  
  
    Dim NumberText As String  
    NumberText = txtNumber.Text.Trim  
  
    If NumberText = "" Then  
        ToastMessageShow("Enter a number.", False)  
        Return  
    End If  
  
    Dim Message As String  
  
    'The ESP32 uses readStringUntil('\n'),  
    'so every number must end with a newline.  
    Message = NumberText & Chr(10)  
  
    AStreams1.Write(Message.GetBytes("UTF8"))  
  
    lblAnswer.Text = "Waiting…"  
  
End Sub  
  
  
'===========================================================  
' RECEIVE ESP32 ANSWER  
'===========================================================  
  
Sub AStreams1_NewData(Buffer() As Byte)  
  
    Dim ReceivedText As String  
  
    ReceivedText = BytesToString( _  
        Buffer, _  
        0, _  
        Buffer.Length, _  
        "UTF8")  
  
    ReceivedText = ReceivedText.Trim  
  
    If ReceivedText <> "" Then  
        lblAnswer.Text = ReceivedText  
    End If  
  
End Sub  
  
  
'===========================================================  
' ASYNCSTREAMS ERROR EVENTS  
'===========================================================  
  
Sub AStreams1_Error  
  
    BluetoothConnected = False  
  
    btnConnect.Text = "CONNECT"  
    btnSend.Enabled = False  
    lblAnswer.Text = "Bluetooth error"  
  
    ToastMessageShow("Bluetooth communication error", True)  
  
End Sub  
  
  
Sub AStreams1_Terminated  
  
    BluetoothConnected = False  
  
    btnConnect.Text = "CONNECT"  
    btnSend.Enabled = False  
    lblAnswer.Text = "Connection closed"  
  
End Sub  
  
  
'===========================================================  
' CLOSE BLUETOOTH  
'===========================================================  
  
Private Sub CloseBluetooth  
  
    If AStreams1.IsInitialized Then  
        AStreams1.Close  
    End If  
  
    If Serial1.IsInitialized Then  
        Serial1.Disconnect  
    End If  
  
    BluetoothConnected = False  
  
End Sub
```
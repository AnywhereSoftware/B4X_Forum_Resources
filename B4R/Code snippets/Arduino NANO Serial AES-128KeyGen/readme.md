### Arduino NANO Serial AES-128KeyGen by QtechLab
### 04/28/2021
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/130219/)

[SIZE=4]Hello guys,[/SIZE]  
  
I would like to show you my little project that i ported in **B4R** and **B4J** (from Arduino IDE and .NET framework).  
As you know Arduino boards can be used for countless activities; in my case i use the NANO board as keygen for a software that i'm coding.  
  
The NANO can store any values you need in the EEPROM, i use just 16 bytes for AES128 encription key.  
Remember that the EEPROMs have limited life, so do not call EEPROM.Write inside a While(true) :p  
  
The data stored inside the board is accessible with jSerial library  
In this B4J application AES128 isn't coded. it just read the key.  
  
![](https://www.b4x.com/android/forum/attachments/112418)  
  
In the example the Arduino board can handle two commands via serial.  

- **CMD\_GENERATE\_KEYS** : NANO stores a random 16 bytes array to the EEPROM.
- **CMD\_READ\_KEYS** : NANO read the 16 bytes from the EEPROM and write them to the serial

The software in B4J is a jSerial implementation that allow to send and receive the data with the Arduino.  
  
In order to let this work:  
Connect Arduino BOARD (install driver if needed) to an USB  
Start the b4j software and connect the COM port.  
Read or Write the key.  
  
Here the HOT things, the codes:  
  

```B4X
Sub Process_Globals  
    Public Serial1 As Serial  
    Private Astream As AsyncStreams  
    Private eeprom As EEPROM  
      
    Dim boardLed As Pin  
    Private rndKeys(16) As Byte  
      
    'CMD  
    Private CMD_GENERATE_KEYS As Byte = 0x1A  
    Private CMD_READ_KEYS As Byte = 0x1B  
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(38400)  
    Astream.Initialize(Serial1.Stream, "Astream_NewData", "Astream_Error")  
      
    'Init board led  
    boardLed.Initialize(13, boardLed.MODE_OUTPUT)  
    boardLed.DigitalWrite(False)  
End Sub  
  
Sub Astream_NewData(buffer() As Byte)  
    'Led ON for stream operation  
    boardLed.DigitalWrite(True)  
      
    If buffer.Length > 0 Then  
        If buffer(0) = CMD_GENERATE_KEYS Then  
            GenerateRandomKeys  
            sendCommand(CMD_GENERATE_KEYS, Array As Byte(0))  
            '  
        Else If buffer(0) = CMD_READ_KEYS Then  
            Dim tmpKeys(16) As Byte  
            eeprom.ReadBytes2(0, 16, tmpKeys)  
            sendCommand(CMD_READ_KEYS, tmpKeys)  
        End If  
    End If  
      
    'Led OFF for idle  
    boardLed.DigitalWrite(False)  
End Sub  
  
private Sub sendCommand(cmd As Byte, values() As Byte)  
    'Prepare buffer to send  
    Dim ary2Send(values.Length + 1) As Byte  
    ary2Send(0) = cmd  
    For i=0 To values.Length-1  
        ary2Send(i+1) = values(i)  
    Next  
      
    'Send command to serial  
    Astream.Write(ary2Send)  
End Sub  
  
Sub Astream_Error  
      
End Sub  
  
private Sub GenerateRandomKeys  
    'Get seed from microseconds and generate random AES128 key  
    RndSeed(Micros)  
    For i=0 To 16-1  
        rndKeys(i) = Rnd(0, 256)  
        Log(rndKeys(i))  
    Next  
      
    'Store keys in eeprom  
    eeprom.WriteBytes(rndKeys, 0)  
End Sub
```

  
  

```B4X
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
    Private ComboBox As ComboBox  
    Private TextAreaInfo As TextArea  
    '  
    Private SerialManager As Serial  
    Private aStream As AsyncStreams  
    '  
    Private aesKey(16) As Byte  
    Private BtGenerateKeys As Button  
    Private BtReadKeys As Button  
    '  
    Private const CMD_GENERATE_KEYS As Byte = 0x1A  
    Private const CMD_READ_KEYS As Byte = 0x1B  
    '  
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("Layout1") 'Load the layout file.  
    MainForm.Show  
      
    SerialManager.Initialize("SerialManager")  
  
    loadPorts  
End Sub  
  
Private Sub loadPorts  
    ComboBox.SelectedIndex = -1  
    ComboBox.Items.Clear  
    ComboBox.Items.AddAll(SerialManager.ListPorts)  
End Sub  
  
#region "Form controls"  
Sub BtRefresh_Click  
    loadPorts  
End Sub  
  
Sub ComboBox_SelectedIndexChanged(Index As Int, Value As Object)  
    If Index = -1 Then Return  
    If Index >= SerialManager.ListPorts.Size Then Return  
    '  
    ConnectSerial(SerialManager.ListPorts.Get(Index))  
End Sub  
  
Sub AddTextLine(text As String)  
    TextAreaInfo.text = text & CRLF & TextAreaInfo.text  
End Sub  
  
Sub BtGenerateKeys_Click  
    AddTextLine("Generate new key request")  
    SendCommandToSerial(CMD_GENERATE_KEYS)  
End Sub  
  
Sub BtReadKeys_Click  
    AddTextLine("Key request")  
    SendCommandToSerial(CMD_READ_KEYS)  
End Sub  
  
#end region  
  
#region "Serial manager"  
  
Sub ConnectSerial(port As String)  
    AddTextLine("Connection to: " & port)  
    SerialManager.Open(port)  
    'SerialManager.SetParams(SerialManager.BAUDRATE_38400, SerialManager.DATABITS_8, SerialManager.STOPBITS_1, SerialManager.PARITY_NONE)  
    SerialManager.SetParams(SerialManager.BAUDRATE_38400, 8, 1, 0)  
    aStream.Initialize(SerialManager.GetInputStream, SerialManager.GetOutputStream, "aStream")  
End Sub  
  
private Sub SendCommandToSerial(command As Byte)  
    If aStream.IsInitialized Then  
        aStream.Write(Array As Byte(command))  
        Dim hexStr As String = Bit.ToHexString(command).ToUpperCase  
        hexStr = hexStr.SubString(hexStr.Length -2)  
    End If  
End Sub  
  
Sub AStream_NewData (Buffer() As Byte)  
    If Buffer.Length = 0 Then Return  
      
    If Buffer(0) = CMD_GENERATE_KEYS Then  
        AddTextLine("Keys generated. Ask for new keys")  
        'Keys generated: send read command  
        SendCommandToSerial(CMD_READ_KEYS)  
          
    else if Buffer(0) = CMD_READ_KEYS Then  
        '  
        Dim str As String = "0x"  
        For i=0 To 16-1  
            'Add key values  
            aesKey(i) = Buffer(i+1)  
            '  
            str = str & Bit.ToHexString(aesKey(i)).ToUpperCase.Replace("FFFFFF", "")  
        Next  
        AddTextLine("Received Keys: " & str)  
        '  
    Else  
        'Received data not handled  
    End If  
  
End Sub  
  
Sub AStream_Error  
    Log("Error: " & LastException)  
    AddTextLine("Connection error: " & LastException)  
    aStream.Close  
    AStream_Terminated  
End Sub  
  
Sub AStream_Terminated  
    Log("Connection is broken.")  
    AddTextLine("Connection broken")  
    '  
    loadPorts  
End Sub  
  
#end region
```

  
  
Feel free to leave any comment.  
Best regards
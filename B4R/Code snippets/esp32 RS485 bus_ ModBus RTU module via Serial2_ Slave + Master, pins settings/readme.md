### esp32 RS485 bus: ModBus RTU module via Serial2: Slave + Master, pins settings by peacemaker
### 07/28/2025
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/167976/)

Next update of the [first code](https://www.b4x.com/android/forum/threads/rs485-modbus-master.133538/post-844156), without SoftwareSerial for esp32-family.  

```B4X
'Slave + Master RS485 ModBus RTU module  
'v.2.0  
'Slave code © OGmac https://www.b4x.com/android/forum/members/ogmac.107192/  
'Modifications for Master © Peacemaker https://www.b4x.com/android/forum/members/peacemaker.1637/  
  
Private Sub Process_Globals  
    Private bc As ByteConverter  
    Private sstream As AsyncStreams  
    Private SerialNative2 As Stream  
    Private Rx_GPIO, Tx_GPIO As Byte, Port_Speed As ULong    'ignore, but setup first  
    Private Master As Boolean = True  
    Private RS485    As Pin  
    Private Send     As Boolean = True  
    Private Recv     As Boolean = False  
    Private Sa(1)    As Byte  ' Slave Address  
    Private Fc(1)    As Byte  ' Function Code  
    Private Fr(2)    As Byte  ' First Register  
    Private Nr(2)    As Byte  ' Number Register  
    '———————————————–  
    Public FCR       As Int = 0      ' First Coil  
    Public FDI       As Int = 10001  ' First Discrete Input  
    Public FIR       As Int = 30001  ' First Input Register  
    Public FHR       As Int = 40001  ' First Holding Register  
    Public CO(8)    As Boolean       ' Coil    Register  00000 - 00007  
    Public DI(8)    As Boolean       ' Discrete Input    10001 - 10008  
    Public IR(8)    As Int           ' Input Register    30001 - 30008  
    Public HR(8)    As Int           ' Holding Register  40001 - 40008  
   
   
End Sub  
  
'Tx  Transmition  Pin RS485  
'Rx  Receive      Pin RS485  
'Dir Direction    Pin RS485 - ignored here for the adapter without direction pin  
'Baud Rate        RS485  
Public Sub Initial(Rx As Byte, Tx As Byte, Dir As Byte, BaudRate As ULong)  
    Rx_GPIO = Rx  
    Tx_GPIO = Tx  
    Port_Speed = BaudRate  
    RunNative("SerialNative2", Null)  
    sstream.Initialize(SerialNative2, "Sstream_newdata", "Stream_Error")  
  
    RS485.Initialize(Dir, RS485.MODE_OUTPUT)  
    RS485.DigitalWrite(Send)  
    RS485.DigitalWrite(Recv)  
End Sub  
  
#if C  
void SerialNative2(B4R::Object* unused)  
{  
::Serial2.begin(b4r_modbus::_port_speed, SERIAL_8N1, b4r_modbus::_rx_gpio, b4r_modbus::_tx_gpio);  
b4r_modbus::_serialnative2->wrappedStream = &::Serial2;  
}  
#End If  
  
#Region Functions  
Private Sub Stream_Error  
    Log("Modbus stream error")  
End Sub  
  
Private Sub Receive (Buffer() As Byte)  
    Dim raw_len As UInt = Buffer.Length  
    If raw_len > 3 Then  
        bc.ArrayCopy2(Buffer,0,Sa,0,1)  
        bc.ArrayCopy2(Buffer,1,Fc,0,1)  
        Dim Sc As UInt = HexToInt(Fc)    'command  
    End If  
  
    If Not(Master) Then  
        If raw_len > 5 Then  
            bc.ArrayCopy2(Buffer,2,Fr,0,2)  
            bc.ArrayCopy2(Buffer,4,Nr,0,2)  
            Dim Sr As UInt = HexToInt(Fr)    'first register address  
            Dim Sn As UInt = HexToInt(Nr)    'registers qty  
        End If  
       
        Select Sc  
            Case 1  
                If Sr >= FCR And Sr < FCR+CO.Length Then Read_Coil_Status(Sr,Sn)  
            Case 2  
                If Sr >= FDI And Sr < FDI+DI.Length Then Read_Input_Status(Sr,Sn)  
            Case 3  
                If Sr >= FHR And Sr < FHR+HR.Length Then Read_Holding_Registers(Sr,Sn)  
            Case 4  
                If Sr >= FIR And Sr < FIR+IR.Length Then Read_Input_Registers(Sr,Sn)  
            Case 5  
                If Sr >= FCR And Sr < FCR+HR.Length Then Force_Single_Coil(Sr,Sn)  
            Case 16  
                If Sr >= FHR And Sr < FHR+HR.Length Then Preset_Multiple_Registers(Buffer,Sr,Sn)  
            Case Else  
        End Select  
    Else    'response from Slave  
        Master = False  
        'Log("From Slave: ", bc.HexFromBytes(Buffer))  
        Dim c(Buffer.Length - 2) As Byte  
        bc.ArrayCopy2(Buffer, 0, c, 0, c.Length)  
        Dim CalculatedCRC(2) As Byte = CRC©  
        'Log("Calculated CRC = ", bc.HexFromBytes(CalculatedCRC))  
        Dim ReceivedCRC(2) As Byte  
        bc.ArrayCopy2(Buffer, Buffer.Length - 2, ReceivedCRC, 0, ReceivedCRC.Length)  
        If bc.ArrayCompare(ReceivedCRC, CalculatedCRC) = 0 Then  
            vibrosensor.Modbus_NewData©    'pass the received data block to needed module  
        Else  
            Log("CRC error, response was ignored")  
        End If  
    End If  
End Sub  
'FC = 1  
Private Sub Read_Coil_Status(Register As UInt,Length As UInt)  
    Dim index As Int = Abs(Register - FCR)  
    Dim nd     As  Int = Length / 8  
    Dim Mbs    As  Int = GetCoilStatus(index,Length)  
    Dim c() As Byte = bc.IntsToBytes(Array As Int(nd))  
    c = bc.SubString2(c,0,1)  
    Dim a() As Byte = bc.UIntsToBytes(Array As UInt(Mbs))  
    Dim d() As Byte = JoinBytes(Array(Sa,Fc,c,a))  
    Write(d)  
End Sub  
'FC = 2  
Private Sub Read_Input_Status(Register As UInt,Length As UInt)  
    Dim index As Int = Abs(Register - FDI)  
    Dim nd     As  Int = Length / 8  
    Dim Mbs    As  Int = GetInputStatus(index,Length)  
    Dim c() As Byte = bc.IntsToBytes(Array As Int(nd))  
    c = bc.SubString2(c,0,1)  
    Dim a() As Byte = bc.UIntsToBytes(Array As UInt(Mbs))  
    Dim d() As Byte = JoinBytes(Array(Sa,Fc,c,a))  
    Write(d)  
End Sub  
'FC = 3  
Private Sub Read_Holding_Registers(Register As UInt,Length As UInt)  
    Dim index As Int = Abs(Register - FHR)  
    Dim a() As Byte  
    For i = 0 To Length-1  
        Dim b() As Byte =  bc.IntsToBytes(Array As Int(HR(index+i)))  
        a = JoinBytes(Array(a, ByteInv(b)))  
    Next  
    Dim c() As Byte = bc.IntsToBytes(Array As Int(Length*2))  
    c = bc.SubString2(c,0,1)  
    Dim d() As Byte = JoinBytes(Array(Sa,Fc,c,a))  
    Write(d)  
End Sub  
'FC = 4  
Private Sub Read_Input_Registers(Register As UInt,Length As UInt)  
    Dim index As Int = Abs(Register - FDI)  
    Dim a() As Byte  
    For i = 0 To Length-1  
        Dim b() As Byte =  bc.IntsToBytes(Array As Int(IR(index+i)))  
        a = JoinBytes(Array(a, ByteInv(b)))  
    Next  
    Dim c() As Byte = bc.IntsToBytes(Array As Int(Length*2))  
    c = bc.SubString2(c,0,1)  
    Dim d() As Byte = JoinBytes(Array(Sa,Fc,c,a))  
    Write(d)  
End Sub  
'FC = 5  
Private Sub Force_Single_Coil(Register As UInt,Status As UInt)  
    Dim index As Int = Abs(Register - FCR)  
    If Status = 65280 Then CO(index) = True Else CO(index) = False  
    Dim b() As Byte = JoinBytes(Array(Sa,Fc,Fr,Nr))  
    Write(b)  
End Sub  
'FC = 16  
Private Sub Preset_Multiple_Registers(Buffer() As Byte,Register As UInt,Length As UInt)  
    Dim index As Int = Abs(Register - FHR)  
    For i = 0 To Length -1  
        Dim val() As Byte = bc.SubString2(Buffer, (i*2)+7,(i*2)+9)  
        HR(index+i) = bc.IntsFromBytes(ByteInv(val))(0)  
    Next  
    Dim b() As Byte = JoinBytes(Array(Sa, Fc,Fr,Nr))  
    Write(b)  
End Sub  
  
Private Sub Sstream_NewData (Buffer() As Byte)  
    Receive(Buffer)  
End Sub  
  
Private Sub Write(Data() As Byte)  
    RS485.DigitalWrite(Send)  
    Master = False  
    Dim d() As Byte = JoinBytes(Array(Data,CRC(Data)))  
    Log("Slave writing: ", bc.HexFromBytes(d))  
    SerialNative2.WriteBytes(d, 0, d.Length)    'sstream.Write(d)  
    RS485.DigitalWrite(Recv)  
End Sub  
  
Private Sub HexToInt(input() As Byte) As UInt  
    Return Bit.ParseInt(bc.HexFromBytes(input), 16)  
End Sub  
  
Private Sub ByteInv(input() As Byte) As Byte()  
    Dim l() As Byte = bc.SubString2(input,0,1)  
    Dim h() As Byte = bc.SubString(input,1)  
    Dim c() As Byte = JoinBytes(Array(h, l))  
    Return c  
End Sub  
  
Private Sub CRC(buf() As Byte) As Byte()  
   Dim CRC1 As Short  
   CRC1 = 0xFFFF  
   For i = 0 To buf.Length - 1  
        CRC1 = Bit.Xor(CRC1,Bit.And( buf(i),0xFF))  
         For j = 0 To 7  
            If Bit.And(CRC1, 1) > 0 Then  
                 CRC1 =Bit.And( Bit.ShiftRight(CRC1,1),0x7FFF)  
                CRC1=Bit.Xor(CRC1, 0xA001)  
            Else  
                 CRC1 =Bit.And( Bit.ShiftRight(CRC1,1),0x7FFF)  
            End If  
        Next  
    Next      
    Return (bc.IntsToBytes(Array As Int(CRC1)))  
End Sub  
Private Sub GetCoilStatus(StarMb As Byte,NumberMB As Byte) As UInt  
    Dim nm    As  Int = NumberMB / 2  
    Dim h(2) As Byte  
    h(0) = 0  
    h(1) = 0  
    For i = 0 To nm - 1  ' 0 - 7  
        If CO(i+StarMb)   Then Bit.Set(h(0), i)  
        If CO(i+StarMb+8) Then Bit.Set(h(1), i)  
    Next  
    Return bc.UIntsFromBytes(h)(0)  
End Sub  
Private Sub GetInputStatus(StarMb As Byte,NumberMB As Byte) As UInt  
    Dim nm    As  Int = NumberMB / 2  
    Dim h(2) As Byte  
    h(0) = 0  
    h(1) = 0  
    For i = 0 To nm - 1  ' 0 - 7  
        If DI(i+StarMb)   Then Bit.Set(h(0), i)  
        If DI(i+StarMb+8) Then Bit.Set(h(1), i)  
    Next  
    Return bc.UIntsFromBytes(h)(0)  
End Sub  
#End Region  
  
#Region Master subs  
'Requests from Master to Slave with ID  
'Operation: 1/2/3/4 = Read Coil Status/Read Input Status/Read Holding Registers/Read Input Registers  
'Reading starting FirstRegister from registers qty of RegistersNumber  
Public Sub MasterRequest(toSlaveID As Byte, Operation As Byte, FirstRegister As UInt, RegistersNumber As UInt)  
    Dim b(6) As Byte    'command  
    b(0) = toSlaveID  
    b(1) = Operation  
    Dim ui(1) As UInt  
    ui(0) = FirstRegister  
    Dim a(2) As Byte = bc.UIntsToBytes(ui)  
    b(2) = a(1)  
    b(3) = a(0)  
   
    ui(0) = RegistersNumber  
    Dim a2(2) As Byte = bc.UIntsToBytes(ui)  
    b(4) = a2(1)  
    b(5) = a2(0)  
    WriteMaster(b)    'send command + CRC  
End Sub  
  
Private Sub WriteMaster(Data() As Byte)  
    RS485.DigitalWrite(Send)  
    Master = True  
    Dim d() As Byte = JoinBytes(Array(Data,CRC(Data)))  
    'Log("Master is writing: ", bc.HexFromBytes(d))  
    SerialNative2.WriteBytes(d, 0, d.Length)  
    RS485.DigitalWrite(Recv)  
End Sub  
#End region
```

  
  

```B4X
Private bc As ByteConverter  
Modbus.Initial(Rx, Tx, Direction, 4800)    'for ex. for classic esp32 Rx=16 and Tx=17  
Modbus.MasterRequest(SensorID, 3, 0, 13)    'read 13 pcs of the holding registers from device with hardcoded SensorID number and hardcoded 4800 bps speed  
'….  
  
'Parsing the received data:  
Sub Modbus_NewData (Buffer() As Byte)  
    'bytes of data, first 3 bytes are address + function code + data bytes number  
    Dim DataBlock(Buffer.Length - 3) As Byte  
    bc.ArrayCopy2(Buffer, 3, DataBlock, 0, DataBlock.Length)  
    'Log("Data block = ", bc.HexFromBytes(DataBlock))  
    Dim counter As UInt = 0  
   
    If SensorID = 1 Then    'sensor with ID=1  
        'parsing  
        Dim Pair(2) As Byte  
        bc.ArrayCopy2(DataBlock, counter, Pair, 0, 2)  
        Dim Tobj As Float = TwoBytesToFloat(Pair, 10)    'Temperature * 10  
        Log("Temperature = ", Tobj)  
       
        counter = 1 * 2  'each register is 2-byte  
        bc.ArrayCopy2(DataBlock, counter, Pair, 0, 2)  
        VelocityX = TwoBytesToFloat(Pair, 10)    'X-axis velocity measurement value (increased by 10 times)  
        'Log("VelocityX, mm/s = ", VelocityX)  
'……..  
End Sub  
  
  
'the digit is devided to the devider  
Sub TwoBytesToFloat(b() As Byte, Divider As UInt) As Float  
    Dim b2(2) As Byte  
    b2(0) = b(1)    'swap bytes  
    b2(1) = b(0)  
    Dim Ints(1) As Int  
    Ints = bc.IntsFromBytes(b2)  
    'Log(Ints(0))  
    Dim res As Float = Ints(0) / Divider  
    Return res  
End Sub  
  
'the digit is devided to the devider  
Sub FourBytesTo32bitFloat(FourBytes() As Byte, Divider As UInt) As Float  
    Dim Swapped(4) As Byte  
    Swapped(0) = FourBytes(1)  
    Swapped(1) = FourBytes(0)  
    Swapped(2) = FourBytes(3)  
    Swapped(3) = FourBytes(2)  
    Dim b(4) As Byte  
    bc.ArrayCopy2(Swapped, 0, b, 0, 4)  
    Dim d() As Double = bc.DoublesFromBytes(b)  
    Dim res As Float = d(0) / Divider  
    Return res  
End Sub
```
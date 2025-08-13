B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=11.8
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
	#StartCommandReturnValue: android.app.Service.START_STICKY
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Private Client As Socket
	Private Stream As AsyncStreams
	Type ModbusQuery(Id As Byte,Function As Short, StartAddress As Short, Count As Short, Busy As Boolean)
	Type ConnectionParams(IPAddress As String, Port As Int, Timeout As Int, UnitID As Byte, ReadTime As Int, Paramered As Boolean)
	Public COM As ConnectionParams
	Public ReadingQuery As Map
	Private ClockIndex As Short = 0
	Private bc As ByteConverter
	Private Coils(65536) As Boolean
	Private Holds(65536) As Short
	Public WriteRequest As Boolean
	Private Lock As PhoneWakeState
	Private DefaultQuery As ModbusQuery
End Sub

Sub Service_Create
	Service.AutomaticForegroundMode = Service.AUTOMATIC_FOREGROUND_NEVER
	Client.Initialize("Client")
	InitDefaultQuery
	Lock.KeepAlive(True)
End Sub

Sub InitDefaultQuery()
	DefaultQuery.Initialize
	DefaultQuery.Busy = True
	DefaultQuery.Count = 0
	DefaultQuery.Function = 0
	DefaultQuery.Id = 0
	DefaultQuery.StartAddress = 0
End Sub


Sub Service_Start (StartingIntent As Intent)
	If COM.Paramered = True Then
		Client.Connect(COM.IPAddress,COM.Port,COM.Timeout)
	End If
'	Service.StopAutomaticForeground 'Call this when the background task completes (if there is one)
End Sub

Sub Service_Destroy
	Client.Close
	Lock.ReleaseKeepAlive
End Sub

Sub Client_Connected (Successful As Boolean)
	If Successful Then
		Stream.Initialize(Client.InputStream,Client.OutputStream,"Stream")
		CallSubDelayed(Me,"CallerCycle")
	End If
End Sub

Sub CallerCycle()
	Dim State As Boolean = IsPaused(Me)
	Do While State = False
		Sleep(COM.ReadTime)
		CallSub2(Me,"ExecuteQuery",WriteRequest)
	Loop	
End Sub

#Region StreamProcess
Sub Stream_NewData (Buffer() As Byte)
	Dim Id As Short = Conversion.To_Short(Buffer(0),Buffer(1))
	Dim Len As Short = Conversion.To_Short(Buffer(4),Buffer(5))
	Dim Data(Buffer.Length - 6) As Byte
	bc.ArrayCopy(Buffer,6,Data,0,Len)
'	Dim UnitID As Byte = Data(0)
	Dim FC As Byte = Data(1)
	Select FC
		Case 1
			CallSubDelayed3(Me,"AnalizeFC01",Data,Id)
		Case 3
			CallSubDelayed3(Me,"AnalizeFC03",Data,Id)		
	End Select
	Sleep(10)
End Sub

private Sub SendPacket(Frame() As Byte) As Boolean
	Try
		Stream.Write2(Frame,0,Frame.Length)
		Return True
	Catch
		Return False
		Log(LastException)
	End Try	
End Sub
#End Region

#Region QueryManagement

Sub ExecuteQuery(Permit As Boolean)
	If Permit = False Then
		Try
			If ReadingQuery.ContainsKey(ClockIndex) Then
				Dim rq As ModbusQuery = ReadingQuery.Get(ClockIndex)
			Else
				ClockIndex = 0
				Dim rq As ModbusQuery = ReadingQuery.GetDefault(ClockIndex,DefaultQuery)
			End If
		
		
			If rq.Busy = False Then
				Select rq.Function
					Case 1
						Dim Frame() As Byte = CreateFC01(rq.Id,rq.StartAddress,rq.Count)
						SendPacket(Frame)
						rq.Busy = True
					Case 3
						Dim Frame() As Byte = CreateFC03(rq.Id,rq.StartAddress,rq.Count)
						SendPacket(Frame)
						rq.Busy = True
				End Select
			End If
			ClockIndex = ClockIndex + 1
			
		Catch
			Log(LastException)
			Return
		End Try
	End If
End Sub

Sub UnbusyQuery(Id As Short)
	Dim rq As ModbusQuery = ReadingQuery.Get(Id)
	rq.Busy = False
End Sub

Public Sub UpdateQuery(NewQuery As Map)
	WriteRequest = True
	Sleep(COM.ReadTime)
	ReadingQuery = NewQuery
	Sleep(COM.ReadTime)
	WriteRequest = False
End Sub


#End Region

#Region Analizing

Sub AnalizeFC01(data() As Byte,Id As Short)
	Dim InTemp() As Int = bc.IntsFromBytes(Array As Byte(0,0,0,data(2)))	
	Dim ByteLen As Int = InTemp(0)

	
	Dim Idx As Int = 0
	
	Dim q As ModbusQuery = ReadingQuery.Get(Id)
	Idx = q.StartAddress
	
	Try
		Dim MyBitBytes(ByteLen) As Byte
		bc.ArrayCopy(data,3,MyBitBytes,0,ByteLen)
		Dim sb As StringBuilder
		sb.Initialize
		For i = 0 To MyBitBytes.Length - 1
			Dim itemp() As Int = bc.IntsFromBytes(Array As Byte(0,0,0,MyBitBytes(i)))
			sb.Insert(0, Conversion.To_Bin(itemp(0),8))
		Next
		For x = sb.Length - 1 To 0 Step -1
			Dim stemp As String = sb.ToString.CharAt(x)
			If stemp = "1" Then
				Coils(Idx) = True 
			Else
				Coils(Idx) = False
			End If
			Idx = Idx + 1
		Next
		CallSubDelayed2(Me,"UnbusyQuery",Id)
	Catch
		Log(LastException)
	End Try
End Sub

Sub AnalizeFC03(data() As Byte, Id As Short)
	Dim InTemp() As Int = bc.IntsFromBytes(Array As Byte(0,0,0,data(2)))
	Dim ByteLen As Int = InTemp(0)

	Dim Offset As Int = 0
	Dim q As ModbusQuery = ReadingQuery.Get(Id)
	Offset = q.StartAddress
	
	Try
		Dim MyShortBytes(ByteLen) As Byte
		bc.ArrayCopy(data,3,MyShortBytes,0,ByteLen)
		Dim s() As Short = bc.ShortsFromBytes(MyShortBytes)
		For i = 0  To s.Length - 1
			Holds(i+Offset) = s(i)
		Next
		CallSubDelayed2(Me,"UnbusyQuery",Id)
	Catch
		Log(LastException)
	End Try
End Sub

#End Region

#Region Methods

Public Sub GetCoil() As Boolean()
	Return Coils
End Sub

Public Sub GetHolds() As Short()
	Return Holds
End Sub

public Sub SetCoil(Address As Short, Value As Boolean)
	WriteRequest = True
	Dim Frame() As Byte = CreateFC05(1,Address,Value)
	SendPacket(Frame)
	WriteRequest = False
End Sub

public Sub SetHold(Address As Short, Value As Short)
	WriteRequest = True
	Dim Frame() As Byte = CreateFC06(2,Address,Value)
	SendPacket(Frame)
	WriteRequest = False
End Sub

public Sub SetMultipleHold(Address As Short, Value() As Short)
	WriteRequest = True
	Dim Frame() As Byte = CreateFC16(3,Address,Value)
	SendPacket(Frame)
	WriteRequest = False
End Sub

#End Region

#Region ModbusTCPMessage

Private Sub CreateFC01(Id As Byte,StartAddress As Short, Count As Short) As Byte()
	Dim Frame(12) As Byte
	Dim Length() As Byte = Conversion.To_Bytes(6,False,False)
	Dim Adr() As Byte = Conversion.To_Bytes(StartAddress,False,False)
	Dim Cnt() As Byte = Conversion.To_Bytes(Count,False,False)
	
	Frame(0) = 0
	Frame(1) = Id
	Frame(2) = 0
	Frame(3) = 0
	Frame(4) = Length(0)
	Frame(5) = Length(1)
	Frame(6) = COM.UnitID
	Frame(7) = 1
	Frame(8) = Adr(0)
	Frame(9) = Adr(1)
	Frame(10) = Cnt(0)
	Frame(11) = Cnt(1)
	
	Return Frame
End Sub

Private Sub CreateFC03(Id As Byte,StartAddress As Short, Count As Short) As Byte()
	Dim Frame(12) As Byte
	Dim Length() As Byte = Conversion.To_Bytes(6,False,False)
	Dim Adr() As Byte = Conversion.To_Bytes(StartAddress,False,False)
	Dim Cnt() As Byte = Conversion.To_Bytes(Count,False,False)
	
	Frame(0) = 0
	Frame(1) = Id
	Frame(2) = 0
	Frame(3) = 0
	Frame(4) = Length(0)
	Frame(5) = Length(1)
	Frame(6) = COM.UnitID
	Frame(7) = 3
	Frame(8) = Adr(0)
	Frame(9) = Adr(1)
	Frame(10) = Cnt(0)
	Frame(11) = Cnt(1)
	
	Return Frame
End Sub

Private Sub CreateFC05(Id As Byte,StartAddress As Short, Value As Boolean) As Byte()
	Dim Frame(12) As Byte
	Dim Length() As Byte = Conversion.To_Bytes(6,False,False)
	Dim Adr() As Byte = Conversion.To_Bytes(StartAddress,False,False)
	
	
	Frame(0) = 0
	Frame(1) = Id
	Frame(2) = 0
	Frame(3) = 0
	Frame(4) = Length(0)
	Frame(5) = Length(1)
	Frame(6) = COM.UnitID
	Frame(7) = 5
	Frame(8) = Adr(0)
	Frame(9) = Adr(1)
	If Value Then
		Frame(10) = 255
	Else
		Frame(10) = 0
	End If
	Frame(11) = 0
	
	Return Frame
End Sub

Private Sub CreateFC06(Id As Byte,StartAddress As Short, Value As Short) As Byte()
	Dim Frame(12) As Byte
	Dim Length() As Byte = Conversion.To_Bytes(6,False,False)
	Dim Adr() As Byte = Conversion.To_Bytes(StartAddress,False,False)
	Dim Val() As Byte = Conversion.To_Bytes(Value,False,False)
	
	Frame(0) = 0
	Frame(1) = Id
	Frame(2) = 0
	Frame(3) = 0
	Frame(4) = Length(0)
	Frame(5) = Length(1)
	Frame(6) = COM.UnitID
	Frame(7) = 6
	Frame(8) = Adr(0)
	Frame(9) = Adr(1)
	Frame(10) = Val(0)
	Frame(11) = Val(1)
	
	Return Frame
End Sub

Private Sub CreateFC16(Id As Byte,StartAddress As Short, Value() As Short) As Byte()
	Dim ByteLen As Short = Value.Length * 2
	Dim Frame(13+ByteLen) As Byte
	Dim Length() As Byte = Conversion.To_Bytes(6+ByteLen,False,False)
	Dim Adr() As Byte = Conversion.To_Bytes(StartAddress,False,False)
	Dim Cnt() As Byte = Conversion.To_Bytes(Value.Length,False,False)
	
	Frame(0) = 0
	Frame(1) = Id
	Frame(2) = 0
	Frame(3) = 0
	Frame(4) = Length(0)
	Frame(5) = Length(1)
	Frame(6) = COM.UnitID
	Frame(7) = 16
	Frame(8) = Adr(0)
	Frame(9) = Adr(1)
	Frame(10) = Cnt(0)
	Frame(11) = Cnt(1)
	Frame(12) = ByteLen
	
	
	Dim Index As Int = 0
	
	For i = 13 To Frame.Length - 1 Step 2
		Dim sTemp() As Byte = Conversion.To_Bytes(Value(Index),False,False)
		Frame(i) = sTemp(0)
		Frame(i+1) = sTemp(1)
		Index = Index + 1
	Next
	
	Return Frame
End Sub

#End Region



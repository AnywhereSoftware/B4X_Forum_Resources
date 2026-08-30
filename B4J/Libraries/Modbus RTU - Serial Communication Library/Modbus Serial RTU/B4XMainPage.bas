B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip
'Ctrl + click To export As zip: ide://run?File=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip

Sub Class_Globals
	Private Root As B4XView
	Private XUI As XUI

	Private Modbus As ModbusSerialRTU

	Private cmbPorts As ComboBox
	Private lblStatus As Label
	Private txtLog As B4XView
End Sub

Public Sub Initialize
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(Me, "Modbus Serial RTU")

	Modbus.Initialize("Modbus")

	Dim Ports As List = Modbus.ListPorts
	For Each p As String In Ports
		cmbPorts.Items.Add(p)
	Next
	If cmbPorts.Items.Size > 0 Then cmbPorts.SelectedIndex = 0
End Sub

Private Sub B4XPage_CloseRequest As ResumableSub
	ExitApplication
	Return True
End Sub

' ============================================================
'   BUTTONS
' ============================================================

Private Sub btnConnect_Click
	Modbus.SetParameters(9600, 8, 1, 0) '115200
	Modbus.Connect(cmbPorts.Value)
	Modbus.SlaveID = 1
End Sub

Private Sub btnDisconnect_Click
	Modbus.Disconnect
End Sub

Private Sub btnReadData_Click
	If Modbus.Connected Then
		'Coils
		Modbus.ReadCoils(7, 1)
		Modbus.ReadCoils(1, 9)

		'Holding Registers
		Modbus.ReadHoldingRegisters(14, 1)
		Modbus.ReadHoldingRegisters(21, 2)
		Modbus.ReadInt32(128)
		Modbus.ReadInt32Array(256, 12)

		'Discrete Inputs
		Modbus.ReadDiscreteInputs(0, 10)

		'Input Registers
		Modbus.ReadInputRegisters(0, 10)

'		Log("***************************************")
'		'Temp sensor
'		Modbus.ReadHoldingRegisters(0, 8)
	Else
		Log("Not connected!")
	End If
End Sub

Private Sub btnWrite_Click
	If Modbus.Connected Then
		Dim SF As Object = XUI.Msgbox2Async($"Writing these test values to an actual Modbus device${CRLF _
		}could cause your device to work oddly or not work at all.${CRLF _
		}Double check or change the values before continuing."$, "Write values", "Yes", "", "No", Null)
		Wait For (SF) Msgbox_Result (Result As Int)
		If Result = XUI.DialogResponse_Positive Then
			'Coils
			Modbus.WriteCoil(7, True)
			Modbus.WriteCoils(11, Array As Boolean(True, False, True, False, True, False, False, False, False))

			'Holding Registers
			Modbus.WriteRegister(14, 1395)
			Modbus.WriteRegisters(21, Array As Int(123, 456))
			Modbus.WriteInt32(128, 128)
			Modbus.WriteInt32Array(256, Array As Int(2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096))

			'Reading and writing multiple values into x number of Holding Registers at once
			Modbus.ReadWriteMultipleRegisters(50, 7, 50, Array As Int(1, 2, 3, 4, 5, 6, 7))
		End If
	Else
		Log("Not connected!")
	End If
End Sub

Private Sub btnReadWrite_Click
	If Modbus.Connected Then
		Dim SF As Object = XUI.Msgbox2Async($"Writing this test value to an actual Modbus device${CRLF _
		}could cause your device to work oddly or not work at all.${CRLF _
		}Double check or change the value before continuing."$, "Write float", "Yes", "", "No", Null)
		Wait For (SF) Msgbox_Result (Result As Int)
		If Result = XUI.DialogResponse_Positive Then
			Modbus.GapReadWriteMultipleDelay = 0
			Dim RWArray() As Int = Array As Int(1, 2, 3, 4, 5, 6, 7)
			Modbus.ReadWriteMultipleRegisters(63, RWArray.Length, 63, RWArray)
		End If
	Else
		Log("Not connected!")
	End If
End Sub

Private Sub btnRWFloat_Click
	If Modbus.Connected Then
		Dim SF As Object = XUI.Msgbox2Async($"Writing this test value to an actual Modbus device${CRLF _
		}could cause your device to work oddly or not work at all.${CRLF _
		}Double check or change the value before continuing."$, "Write float", "Yes", "", "No", Null)
		Wait For (SF) Msgbox_Result (Result As Int)
		If Result = XUI.DialogResponse_Positive Then
			Modbus.WriteFloat(100, 123.45)
			Sleep(50) 'Added sleep for slower devices. In reality, one would never Write and then instantly read from the device
			Modbus.ReadFloat(100) '_FloatRead event will be raised
		End If
	Else
		Log("Not connected!")
	End If
End Sub

' ============================================================
'   EVENT HANDLERS
' ============================================================

Sub Modbus_InitResult(Success As Boolean, Message As String)
	If Success Then
		Log("Connected → " & Message)
		LogToScreen("Connected → " & Message)
		lblStatus.Text = "Connected: " & Message

		Modbus.PostWriteDelay = 75 '100 is a nice safe number
		Modbus.PostReadDelay = 75 '100 is a nice safe number

		'Read runction tests
		Dim Tests() As Int = Array As Int(Modbus.TEST_COIL, Modbus.TEST_DISCRETE, Modbus.TEST_HOLDING, Modbus.TEST_INPUT, Modbus.TEST_NONE)
		For Each t In Tests
			Modbus.SetTestConfig(t, 0)
			Modbus.TestFunction
		Next
	Else
		lblStatus.Text = "Connection failed"
		Log("Connection failed: " & Message)
		LogToScreen("Connection failed: " & Message)
		XUI.MsgboxAsync("Connection failed: " & Message, "Error")
	End If
End Sub

Sub Modbus_Disconnected(Success As Boolean, Message As String)
	Log("Disconnected → " & Success & " | " & Message)
	LogToScreen("Disconnected → " & Success & " | " & Message)
	lblStatus.Text = "Disconnected: " & Message
End Sub

' ============================================================
'   FC1 / FC2
' ============================================================

Sub Modbus_CoilRead(Success As Boolean, Data() As Boolean, Message As String)
	Log("EVENT: CoilRead → " & Success & ", " & Message)
	LogToScreen("EVENT: CoilRead → " & Success & ", " & Message)
	If Data.Length = 0 Then Return
	If Success Then
		For Each d As Boolean In Data
			Log("Coil: " & d)
			LogToScreen("Coil: " & d)
		Next
	End If
'	If Success Then Log("  Coils: " & Array As String(Data))
End Sub

Sub Modbus_DiscreteInputRead(Success As Boolean, Data() As Boolean, Message As String)
	Log("EVENT: DiscreteInputRead → " & Success & ", " & Message)
	
	If Data.Length = 0 Then Return
	
	If Success Then
		For Each d As Boolean In Data
			Log("Discrete Inpur: " & d)
			LogToScreen("Discrete Inpur: " & d)
		Next
	End If
'	If Success Then Log("  Inputs: " & Array As String(Data))
End Sub

' ============================================================
'   FC3 / FC4
' ============================================================

Sub Modbus_HoldingRegisterRead(Success As Boolean, Data() As Int, Message As String)
	Log("EVENT: HoldingRegisterRead → " & Success & ", " & Message)
	LogToScreen("EVENT: HoldingRegisterRead → " & Success & ", " & Message)
	If Data.Length = 0 Then Return
	
	If Success Then
		For Each d As Int In Data
			Log("Holding register: " & d)
			LogToScreen("Holding register: " & d)
		Next
	End If

'	'TEMPERATURE SENSER - To read the below, use Modbus.ReadHoldingRegisters(0, 8)
'	If Data.Length >= 2 Then
'		Dim rawHum  As Int = Data(0)
'		Dim rawTemp As Int = Data(1)
'
'		Dim humidity As Double = rawHum / 10.0
'		Dim temperature As Double = rawTemp / 10.0
'
'		Log("HoldingRegisterRead → Temperature = " & temperature & " °C, Humidity = " & humidity & " %")	
'
'		If Data.Length >= 2 And Data.Length <= 8 Then
'			Dim tempCal As Int = Data(2)
'			Log("Temp Cal: " & tempCal)
'			Dim tempCalRW As Int = Data(4)
'			Log("Temp Cal R/W: " & tempCalRW)
'
'			Dim humCal As Int = Data(3)
'			Log("Hum Cal: " & humCal)
'			Dim humCalRW As Int = Data(5)
'			Log("Hum Cal R/W: " & humCalRW)
'		End If	
'	End If
End Sub

Sub Modbus_InputRegisterRead(Success As Boolean, Data() As Int, Message As String)
	Log("EVENT: InputRegisterRead → " & Success & ", " & Message)
	LogToScreen("EVENT: InputRegisterRead → " & Success & ", " & Message)
	If Data.Length = 0 Then Return

	If Success Then
		For Each d As Int In Data
			Log("Input register: " & d)
			LogToScreen("Input register: " & d)
		Next
	End If
End Sub

' ============================================================
'   FLOAT / INT32 EVENTS
' ============================================================

Sub Modbus_FloatRead(Success As Boolean, Value As Float, Data() As Float, Message As String)
	Log("EVENT: FloatRead → " & Success & ", " & Message)
	LogToScreen("EVENT: FloatRead → " & Success & ", " & Message)
	If Success Then Log("Float value = " & NumberFormat(Value, 1, 2))
	LogToScreen("Float value = " & NumberFormat(Value, 1, 2))

	'Swap back to ABCD (Big Endian)
	Modbus.ByteOrderMode = Modbus.ORDER_ABCD
	Dim NormalFloat As Float = Modbus.ReconvertFloat(Data)
	Log("ABCD Conversion: " & NormalFloat) ' This will be 123.45 again
	LogToScreen("ABCD Conversion: " & NormalFloat) ' This will be 123.45 again

	'Swap to DCBA (Little Endian) and re-convert
	Modbus.ByteOrderMode = Modbus.ORDER_DCBA
	Dim SwappedFloat As Float = Modbus.ReconvertFloat(Data)
	Log("DCBA Conversion: " & SwappedFloat) ' This will be a totally different number!
	LogToScreen("DCBA Conversion: " & SwappedFloat) ' This will be a totally different number!
End Sub

Sub Modbus_FloatArrayRead(Success As Boolean, Values() As Float, Data() As Float, Message As String)
	Log("EVENT: FloatArrayRead → " & Success & ", " & Message)
	LogToScreen("EVENT: FloatArrayRead → " & Success & ", " & Message)
	If Success Then
		For Each f As Float In Values
			Log("Float = " & f)
			LogToScreen("Float = " & f)
		Next
	End If

	'Swap back to ABCD (Big Endian)
	Modbus.ByteOrderMode = Modbus.ORDER_ABCD
	Dim NormalFloat As Float = Modbus.ReconvertFloat(Data)
	Log("ABCD Conversion: " & NormalFloat) ' This will be 123.45 again
	LogToScreen("ABCD Conversion: " & NormalFloat) ' This will be 123.45 again

	'Swap to DCBA (Little Endian) and re-convert
	Modbus.ByteOrderMode = Modbus.ORDER_DCBA
	Dim SwappedFloat As Float = Modbus.ReconvertFloat(Data)
	Log("DCBA Conversion: " & SwappedFloat) ' This will be a totally different number!
	LogToScreen("DCBA Conversion: " & SwappedFloat) ' This will be a totally different number!
End Sub

Sub Modbus_Int32Read(Success As Boolean, Value As Int, Message As String)
	Log("EVENT: Int32Read → " & Success & ", " & Message)
	LogToScreen("EVENT: Int32Read → " & Success & ", " & Message)
	If Success Then Log("Int32 value = " & Value)
	LogToScreen("Int32 value = " & Value)
End Sub

Sub Modbus_Int32ArrayRead(Success As Boolean, Values() As Int, Message As String)
	Log("EVENT: Int32ArrayRead → " & Success & ", " & Message)
	LogToScreen("EVENT: Int32ArrayRead → " & Success & ", " & Message)
	If Success Then
		For Each v As Int In Values
			Log("Int32 = " & v)
			LogToScreen("Int32 = " & v)
		Next
	End If
End Sub

' ============================================================
'   OTHER EVENTS
' ============================================================

Sub Modbus_WriteResult(Success As Boolean, Message As String)
	If Not(Success) Then Return
	Log("EVENT: WriteResult → " & Success & ", " & Message)
	LogToScreen("EVENT: WriteResult → " & Success & ", " & Message)
End Sub

Sub Modbus_DiagnosticRequest(SubFunction As Int, Data As Int)
	Log("EVENT: DiagnosticRequest → " & SubFunction & ", " & Data)
	LogToScreen("EVENT: DiagnosticRequest → " & SubFunction & ", " & Data)
End Sub

Sub Modbus_ConnectionCheckDone(IsLive As Boolean, Message As String)
	Log("EVENT: ConnectionCheckDone → " & IsLive & ", " & Message)
	LogToScreen("EVENT: ConnectionCheckDone → " & IsLive & ", " & Message)
End Sub

Sub Modbus_TestCompleted(Success As Boolean, Message As String)
	If Not(Success) Then Return
	Log("EVENT: TestCompleted → " & Success & ", " & Message)
	LogToScreen("EVENT: TestCompleted → " & Success & ", " & Message)
End Sub

'DISPLAY MESSAGES IN THE ON-SCREEN LOG AND SYSTEM LOG
Private Sub LogToScreen(Msg As String)
	txtLog.Text = txtLog.Text & Msg & CRLF
	txtLog.SelectionStart = txtLog.Text.Length
End Sub

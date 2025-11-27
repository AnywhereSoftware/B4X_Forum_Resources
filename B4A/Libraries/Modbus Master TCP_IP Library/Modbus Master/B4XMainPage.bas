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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip

Sub Class_Globals
	Private Root As B4XView
	Private XUI As XUI

	Private ModBus As ModbusMaster
   
	Private CONST TARGET_IP As String = "192.168.0.138"
	Private CONST TARGET_Port As Int = 502
	Private CONST TARGET_Encapsulated As Boolean = False
	Private CONST TARGET_KeepAlive As Boolean = False
	Private CONST TARGET_Timeout As Int = 2000
	Private CONST TARGET_Retries As Int = 0

	Private CONST SLAVE_ID As Int = 1

	Private BtnConnect, BtnReadRegister, BtnWriteRegister, BtnReadRegisters, BtnWriteRegisters, BtnWriteCoil, BtnReadCoil As B4XView
	Private TxtLog As B4XView
End Sub

Public Sub Initialize
	'B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(Me, "Modbus Master")
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

'INITIALIZE / CONNECT TO THE TARGET DEVICE
Sub BtnConnect_Click
	Log(ModBus.IsInitialized)
	
	LogToScreen("Initialising connection to " & TARGET_IP & "...")
	'Initialize the library using the full signature with default values in the Class_Globals
	ModBus.Initialize("MB", TARGET_IP, TARGET_Port, TARGET_Encapsulated, TARGET_KeepAlive, TARGET_Timeout, TARGET_Retries)
	
	Sleep(100)
	Log(ModBus.IsInitialized)
End Sub

Private Sub BtnDisconnect_Click
	ModBus.Disconnect
End Sub

'READ FROM REGISTER
Private Sub BtnReadRegister_Click
	LogToScreen("Reading 1 Holding Register...")
	'ReadHoldingRegisters(SlaveId, StartAddress, Length)
	ModBus.ReadHoldingRegisters(SLAVE_ID, 5, 1)

	Sleep(100) 'Needed to separate read functions

	'ReadInputRegisters(SlaveId, StartAddress, Length)
	ModBus.ReadInputRegisters(SLAVE_ID, 5, 1)
End Sub

'WRITE To REGISTER
Private Sub BtnWriteRegister_Click
	LogToScreen("Writing Values to Register 5...")
	'WriteRegister(SlaveId, StartAddress, Value)
	ModBus.WriteRegister(SLAVE_ID, 5, 7)
End Sub

'READ FROM REGISTERS
Private Sub BtnReadRegisters_Click
	LogToScreen("Reading 10 Holding Registers...")
	'ReadHoldingRegisters(SlaveId, StartAddress, Length)
	ModBus.ReadHoldingRegisters(SLAVE_ID, 100, 10)
End Sub

'WRITE TO REGISTERS
Sub BtnWriteRegisters_Click
	Dim startAddress As Int = 100
    
	'Create an array of 16-bit values (Short)
	Dim Values() As Short = Array As Short(10, 20, 30, 40, 50, 60, 70, 80, 90, 100)
   
	LogToScreen("Writing 10 Registers starting at address " & startAddress & "...")
	'WriteRegisters(SlaveId, StartAddress, ValuesArray)
	ModBus.WriteRegisters(SLAVE_ID, startAddress, Values)
End Sub

'READ FROM COIL
Private Sub BtnReadCoil_Click
	ModBus.ReadCoil(SLAVE_ID, 0, 10)
	Log(ModBus.HostAddress)
End Sub

'WRITE TO COIL
Sub BtnWriteCoil_Click 'Renamed sub
	LogToScreen("Writing True to Coil 5...")
	'WriteCoil(SlaveId, Address, Value)
	ModBus.WriteCoil(SLAVE_ID, 5, True)
End Sub

'INITIALIZATION RESULTS
Sub MB_InitResult(Success As Boolean, Message As String)
	If Success Then
		LogToScreen("Connection Successful!")
		BtnReadRegister.Enabled = True
		BtnWriteRegister.Enabled = True
		BtnReadRegisters.Enabled = True
		BtnWriteRegisters.Enabled = True
		BtnWriteCoil.Enabled = True
		BtnReadCoil.Enabled = True
		TxtLog.Enabled = True
	Else
		LogToScreen("Connection Failed: " & Message)
		BtnReadRegister.Enabled = False
		BtnWriteRegister.Enabled = False
		BtnReadRegisters.Enabled = False
		BtnWriteRegisters.Enabled = False
		BtnWriteCoil.Enabled = False
		BtnReadCoil.Enabled = False
		TxtLog.Enabled = False
	End If
End Sub

'READ INPUT REGISTER
Sub MB_InputRegisterRead(Success As Boolean, Data() As Short, Message As String)
	If Success Then
		LogToScreen("")
		LogToScreen("Input Register Read Success. Values:")
		
		If Data.Length = 1 Then
			LogToScreen(Data(0))
		Else
			For i = 0 To Data.Length - 1
				LogToScreen("Reg[" & i & "] = " & Data(i))
			Next			
		End If
	Else
		LogToScreen("Read Failed: " & Message)
	End If
End Sub

'READ HOLDING REGISTER
Sub MB_HoldingRegisterRead(Success As Boolean, Data() As Short, Message As String)
	If Success Then
		LogToScreen("")
		LogToScreen("Holding Register Read  Success. Values:")

		If Data.Length = 1 Then
			LogToScreen(Data(0))
		Else
			For i = 0 To Data.Length - 1
				LogToScreen("Reg[" & i & "] = " & Data(i))
			Next
		End If
	Else
		LogToScreen("Read Failed: " & Message)
	End If
End Sub

'WRITE RESULTS
Sub MB_WriteResult(Success As Boolean, Message As String)
	If Success Then
		LogToScreen("Write Successful: " & Message)
	Else
		LogToScreen("Write Failed: " & Message)
	End If
End Sub

'READ COIL
Sub MB_CoilRead(Success As Boolean, Data() As Boolean, Message As String)
	If Success Then
		LogToScreen("")
		LogToScreen("Coils Read Success.")
		For i = 0 To Data.Length - 1
			LogToScreen("Coil[" & i & "] = " & Data(i))
		Next
	Else
		LogToScreen("Coil Read Error: " & Message)
	End If	
End Sub

'HELPER THAT PRINTS TO THE SCREEN LOGS
Sub LogToScreen(Msg As String)
	Log(Msg)
	TxtLog.Text = TxtLog.Text & Msg & CRLF
	TxtLog.SelectionStart = TxtLog.Text.Length
End Sub

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

	Private ModBus As ModbusMasterTCP
	Private Server As ServerSocket
  
	Private IPAddress As String
	Private Port As Int = 5020 'Modbus port number
	Private Encapsulated As Boolean = False
	Private KeepAlive As Boolean = True
	Private Timeout As Int = 5000
	Private Retries As Int = 0

	'FC23 ReadWriteMultipleRegisters Test Parameters
	Private CONST FC23_WRITE_START_ADDR As Int = 200	'Start address for the write part of FC23
	Private CONST FC23_WRITE_VALUE As Short = 5678		'Value to write to the register
	Private CONST FC23_WRITE_VALUE_2 As Short = 8765	'Value to write to the register
	Private CONST FC23_READ_START_ADDR As Int = 200 	'Start address for the read part of FC23
	Private CONST FC23_READ_LENGTH As Int = 3			'Number of registers to read back

	Private BtnConnect, BtnWriteRegister, BtnReadRegisters, BtnWriteRegisters, BtnWriteCoil, BtnWriteCoils, BtnReadCoil, BtnReadWriteRegisters, BtnReadDiscreteInputs, BtnReadInputRegisters As B4XView
	Private SBarValue As B4XView
	Private LblConnInfo, LblValue As B4XView
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

	Server.Initialize(0, "")
	IPAddress = "192.168.0.138" 'Set the ip address manually
	'IPAddress = Server.GetMyIP 'In this case, there is a Slave/Server on the same device
	Server.Close
	
	ModBus.SlaveID = 1
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

'INITIALIZE / CONNECT TO THE TARGET DEVICE
Private Sub BtnConnect_Click
	LogToScreen($"Initialising connection to ${IPAddress}..."$)
	ModBus.Initialize("MB", IPAddress, Port, Encapsulated, KeepAlive, Timeout, Retries, ModBus.TEST_NONE, 0)
End Sub

Private Sub BtnConnect_LongClick
	TxtLog.Text = ""
End Sub

Private Sub BtnDisconnect_Click
	ModBus.Disconnect
End Sub

'READ FROM COIL
Private Sub BtnReadCoil_Click
	LogToScreen("Reading 10 Coils...")
	ModBus.ReadCoil(0, 10)

	Sleep(100) 'Needed to separate read functions

	ModBus.ReadCoil(100, 10)
	LogToScreen("-----------------------------------")
End Sub

'WRITE TO COIL
Private Sub BtnWriteCoil_Click
	LogToScreen("Writing True to Coil 5...")
	ModBus.WriteCoil(5, True)
	LogToScreen("-----------------------------------")
End Sub

'WRITE TO COILS
Private Sub BtnWriteCoils_Click
	LogToScreen("Writing True/False to 5 Coils...")
	Dim StartOffset As Int = 100
   
	'Create the array of Boolean values to write. This array will write 5 coils starting from address 100 (101).
	Dim Values(5) As Boolean
		Values(0) = True    ' Coil 100 (101) will be set to ON
		Values(1) = False   ' Coil 101 (102) will be set to OFF
		Values(2) = True    ' Coil 102 (103) will be set to ON
		Values(3) = True    ' Coil 103 (104) will be set to ON
		Values(4) = False   ' Coil 104 (105) will be set to OFF

	ModBus.WriteCoils(StartOffset, Values)
	Log($"Sending ${Values.Length} coils starting at address ${StartOffset} to Slave ID ${ModBus.SlaveID}"$)
	LogToScreen("-----------------------------------")
End Sub

'WRITE To REGISTER
Private Sub BtnWriteRegister_Click
	LogToScreen("Writing Value to Register 5...")
	ModBus.WriteRegister(100, 7)
	LogToScreen("-----------------------------------")
End Sub

'READ FROM REGISTERS
Private Sub BtnReadRegisters_Click
	LogToScreen("Reading 10 Holding Registers...")
	ModBus.ReadHoldingRegisters(100, 10)
	LogToScreen("-----------------------------------")
End Sub

'WRITE TO REGISTERS
Private Sub BtnWriteRegisters_Click
	Dim StartAddress As Int = 100

	'Create an array of 16-bit values (Short)
	Dim Values() As Short = Array As Short(10, 20, 30, 40, 50, 60, 70, 80, 90, 100)
  
	LogToScreen($"Writing 10 Registers starting at address ${StartAddress}..."$)
	ModBus.WriteRegisters(StartAddress, Values)
	LogToScreen("-----------------------------------")
End Sub

'READ/WRITE MULTIPLE REGISTERS (FC 23)
Private Sub BtnReadWriteRegisters_Click
	Dim RegistersToWrite(2) As Short
		RegistersToWrite(0) = FC23_WRITE_VALUE 		' e.g. 5678
		RegistersToWrite(1) = FC23_WRITE_VALUE_2 	' e.g. 8765

	LogToScreen($"Attempting chained Write (FC16) to Reg ${FC23_WRITE_START_ADDR} then Read (FC3) of ${FC23_READ_LENGTH} registers starting at Reg ${FC23_READ_START_ADDR}..."$)

	' ReadWriteMultipleRegisters(ReadStart, ReadLen, WriteStart, WriteValues)
	ModBus.ReadWriteMultipleRegisters(FC23_READ_START_ADDR, FC23_READ_LENGTH, FC23_WRITE_START_ADDR, RegistersToWrite)
	LogToScreen("-----------------------------------")
End Sub

Private Sub BtnReadDiscreteInputs_Click
	LogToScreen("Reading 10 Discrete Inputs...")
	ModBus.ReadDiscreteInput(0, 10)
	LogToScreen("-----------------------------------")
End Sub

Private Sub BtnReadInputRegisters_Click
	LogToScreen("Reading 10 Input Registers...")
	ModBus.ReadInputRegisters(0, 10)
	LogToScreen("-----------------------------------")
End Sub

'SEEKBAR VALUE WRITES DIRECTLY TO THE REGISTER
Private Sub SBarValue_ValueChanged (Value As Int, UserChanged As Boolean)
	LblValue.Text = Value
	ModBus.WriteRegister(5, Value)
End Sub

'INITIALIZATION RESULTS
Private Sub MB_InitResult(Success As Boolean, Message As String)
	If Success Then
		ModBus.TestFunction()
		ModBus.DiagnosticRequest(0, 12345)
	
		LogToScreen("Connection Successful!")
		LblConnInfo.Text = $"${IPAddress}:${Port}"$
		BtnWriteRegister.Enabled = True
		BtnReadRegisters.Enabled = True
		BtnWriteRegisters.Enabled = True
		BtnWriteCoil.Enabled = True
		BtnWriteCoils.Enabled = True
		BtnReadCoil.Enabled = True		
		BtnReadWriteRegisters.Enabled = True
		BtnReadDiscreteInputs.Enabled = True
		BtnReadInputRegisters.Enabled = True
		SBarValue.Enabled = True
		LblValue.Enabled = True
		TxtLog.Enabled = True
	Else
		LogToScreen($"Connection Failed: ${Message}"$)
		LblConnInfo.Text = "Disconnected"
		BtnWriteRegister.Enabled = False
		BtnReadRegisters.Enabled = False
		BtnWriteRegisters.Enabled = False
		BtnWriteCoil.Enabled = False
		BtnWriteCoils.Enabled = False
		BtnReadCoil.Enabled = False
		BtnReadWriteRegisters.Enabled = False
		BtnReadDiscreteInputs.Enabled = False
		BtnReadInputRegisters.Enabled = False
		SBarValue.Enabled = False
		LblValue.Enabled = False
		TxtLog.Enabled = False
	End If
	
	SBarValue.Progress = 0
	LblValue.Text = 0
	TxtLog.Text = ""
End Sub

' Raised asynchronously after the TestFunction() method is called.
' Success (Boolean) indicates whether the Modbus connection is currently initialised and ready.
' Message (String) provides detailed information about the test result.
Private Sub MB_TestCompleted(Success As Boolean, Message As String)
	If Success Then
		LogToScreen("Modbus Connection Ready!")
		LogToScreen(Message)
	Else
		' Update UI to show failure
		LogToScreen($"Connection Failed: ${Message}"$)
		ToastMessageShow("Modbus test failed. Check settings.", True)
	End If
End Sub

' Raised when a Modbus Function Code 8 (Diagnostics) request is completed.
' SubFunction (Int) is the diagnostics sub-function code (e.g., 0 for Loopback).
' Data (Int) is the echo'd 16-bit integer value returned by the slave.
Private Sub MB_DiagnosticRequest(SubFunction As Int, Data As Int)
	If Data = 0 Then
		LogToScreen("Diagnostic event: not connected or unsupported subfunction")
	Else
		LogToScreen($"Diagnostic event: SubFunction=${SubFunction}, Data=${Data}"$)
	End If
End Sub

'READ INPUT REGISTER
Private Sub MB_InputRegisterRead(Success As Boolean, Data() As Short, Message As String)
	If Success Then
		LogToScreen("")
		LogToScreen("Input Register Read Success. Values:")

		If Data.Length = 1 Then
			LogToScreen(Data(0))
		Else
			For i = 0 To Data.Length - 1
				LogToScreen($"Reg[${i}] = ${Data(i)}"$)
			Next
		End If
	Else
		LogToScreen($"Read Failed: ${Message}"$)
	End If
End Sub

'READ DISCRETE INPUTS
Sub MB_DiscreteInputRead(Success As Boolean, Data() As Boolean, Message As String)
	If Success Then
		LogToScreen("")
		LogToScreen("Discrete Input Read Success. Values:")

		If Data.Length = 1 Then
			LogToScreen(Data(0))
		Else
			For i = 0 To Data.Length - 1
				LogToScreen($"Reg[${i}] = ${Data(i)}"$)
			Next
		End If
	Else
		LogToScreen($"Read Failed: ${Message}"$)
	End If
End Sub

'READ HOLDING REGISTER
'This sub handles both standard FC3 reads and the final read result from the FC23 chain.
Private Sub MB_HoldingRegisterRead(Success As Boolean, Data() As Short, Message As String)
	If Success Then
		LogToScreen("")

		' Check if this result is from the chained FC23 operation for better logging
		Dim IsChainedResult As Boolean = Message.Contains("Chained FC16 Write + FC3 Read")

		If IsChainedResult Then
			LogToScreen("Holding Register Read Success (From FC23 Chain).")
			LogToScreen($"Wrote ${FC23_WRITE_VALUE} & ${FC23_WRITE_VALUE_2} and read back ${Data.Length} registers:"$)
		Else
			LogToScreen("Holding Register Read  Success. Values:")
		End If

		If Data.Length = 1 Then
			LogToScreen(Data(0))
		Else
			For i = 0 To Data.Length - 1
				If IsChainedResult Then
					Dim RegAddr As Int = FC23_READ_START_ADDR + i
					LogToScreen($"Reg[${RegAddr}] = ${Data(i)}"$)
				Else
					' For generic reads, we don't know the exact starting address unless explicitly tracked
					LogToScreen($"Reg[${i}] = ${Data(i)}"$)
				End If
			Next
		End If
	Else
		LogToScreen($"Read Failed: ${Message}"$)
	End If
End Sub

'WRITE RESULTS
'This sub handles all FC5, FC6, FC15, FC16 successes, AND any FC16 failures during the FC23 chain.
Private Sub MB_WriteResult(Success As Boolean, Message As String)
	If Success Then
		LogToScreen($"Write Successful: ${Message}"$)
	Else
		If Message.Contains("Chained Read/Write Failed during FC16 Write") Then
			LogToScreen("CHAIN FAILED: Modbus Write (FC16) failed during chained operation. Read not performed.")
		End If
		LogToScreen($"Write Failed: ${Message}"$)
	End If
End Sub

'READ COIL
Private Sub MB_CoilRead(Success As Boolean, Data() As Boolean, Message As String)
	If Success Then
		LogToScreen("")
		LogToScreen("Coils Read Success.")
		For i = 0 To Data.Length - 1
			LogToScreen($"Coil[${i}] = ${Data(i)}"$)
		Next
	Else
		LogToScreen($"Coil Read Error: ${Message}"$)
	End If
End Sub

'HELPER THAT PRINTS TO THE SCREEN LOGS
Private Sub LogToScreen(Msg As String)
	Log(Msg)
	TxtLog.Text = TxtLog.Text & Msg & CRLF
	TxtLog.SelectionStart = TxtLog.Text.Length
End Sub

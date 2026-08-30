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

Sub Class_Globals
	Private Root As B4XView
	Private XUI As XUI

	Private ModBus As EasyModbusClient
	Private FullTestSequence As Boolean = False

	Private TxtIPAddress, TxtPort, TxtLog As B4XView	
	Private BtnReadDiscreteInputs, BtnReadInputRegisters, BtnReadCoils, BtnWriteCoil, BtnWriteMultipleCoils, _
			BtnReadHoldingRegisters, BtnWriteRegister, BtnWriteMultipleRegisters, BtnReadWrite As B4XView
End Sub

'Initialises the class and sets up variables.
Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")

	B4XPages.SetTitle(Me, "Easy Modbus Client - Master")

	ModBus.SlaveID = 1	
	ModBus.Initialize("ModBus")
End Sub

Private Sub B4XPage_CloseRequest As ResumableSub
	ModBus.Disconnect
	Return True
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

'The 4 Main starting addresses (Or prefixes) in Modbus addressing, indicating the data Type, 
'are 0 For Output Coils, 1 For Discrete Inputs, 3 For Input Registers, And 4 For Holding Registers, 
'followed by the actual memory offset, with common ranges running from 00001 up to 65536 for each data type. 

'Here is a breakdown of the four primary types:
'0xxxx (Coils): For discrete (on/off) outputs, read/write access, starting at 00001.
'1xxxx (Discrete Inputs): For discrete (on/off) inputs, read-only access, starting at 10001.
'3xxxx (Input Registers): For 16-Bit analog inputs, read-only access, starting at 30001.
'4xxxx (Holding Registers): For 16-Bit analog values, read/write access, starting at 40001.

'CONNECTS TO THE SLAVE DEVICE USING THE SPECIFIED IP, PORT, AND TIMEOUT
Private Sub BtnConnect_Click
	ModBus.Connect(TxtIPAddress.Text, TxtPort.Text, 3000)
	LogToScreen("--------------------------------------------")
End Sub

'DISCONNECTS FROM THE SLAVE DEVICE
Private Sub BtnDisconnect_Click
	ModBus.Disconnect
	LogToScreen("--------------------------------------------")
End Sub

'CONNECTION IS SUCCESSFULLY ESTABLISHED
Private Sub ModBus_Connected (Message As String, Connected As Boolean)
	If Connected Then SetButtonState(True) Else SetButtonState(False)
	LogToScreen(Message)
	LogToScreen("--------------------------------------------")
	
	ModBus.PostReadDelay = 50
	ModBus.PostWriteDelay = 50
	
	'Individual config tests TEST_COIL, TEST_HOLDING etc 
'	ModBus.SetTestConfig(ModBus.TEST_HOLDING, 0)
'	ModBus.TestFunction

	Log("=== BEGIN FULL MODBUS TEST SEQUENCE ===")
	If FullTestSequence Then RunAllTests
End Sub

'CONNECTION IS SUCCESSFULLY TERMINATED
Private Sub ModBus_Disconnected (Message As String)
	SetButtonState(False)
	LogToScreen(Message)
	LogToScreen("--------------------------------------------")
End Sub

'ERROR OCCURS WITHIN THE MODBUS CLIENT
Private Sub ModBus_Error (Message As String)
	LogToScreen($"Error event: ${Message}"$)
	LogToScreen("--------------------------------------------")
End Sub

'COILS (0XXXX) ARE READ FROM THE SLAVE
Private Sub ModBus_CoilsReceived (Values() As Boolean)
	LogToScreen($"Received Coils count = ${Values.Length}"$)
	For i = 0 To Values.Length - 1
		LogToScreen($"Coil ${i} = ${Values(i)}"$)
	Next
End Sub

'DISCRETE INPUTS (1XXXX) ARE READ FROM THE SLAVE
Private Sub ModBus_DiscreteInputsReceived (Values() As Boolean)
	LogToScreen($"Received Discrete Inputs count = ${Values.Length}"$)
	For i = 0 To Values.Length - 1
		LogToScreen($"DI ${i} = ${Values(i)}"$)
	Next
End Sub

'HOLDING REGISTERS (4XXXX) ARE READ FROM THE SLAVE
Private Sub ModBus_HoldingRegistersReceived (Values() As Int)
	LogToScreen($"Received Holding Registers count = ${Values.Length}"$)
	For i = 0 To Values.Length - 1
		LogToScreen($"HR ${i} = ${Values(i)}"$)
	Next
End Sub

'INPUT REGISTERS (3XXXX) ARE READ FROM THE SLAVE
Private Sub ModBus_InputRegistersReceived (Values() As Int)
	LogToScreen($"Received Input Registers count = ${Values.Length}"$)
	For i = 0 To Values.Length - 1
		LogToScreen("IR " & i & " = " & Values(i))
	Next
End Sub

'SINGLE COIL IS SUCCESSFULLY WRITTEN TO THE SLAVE
Private Sub ModBus_CoilWritten (Address As Int, Value As Boolean)
	LogToScreen($"Written Coil addr = ${Address} value = ${Value}"$)
End Sub

'SINGLE HOLDING REGISTER IS SUCCESSFULLY WRITTEN TO THE SLAVE
Private Sub ModBus_RegisterWritten (Address As Int, Value As Int)
	LogToScreen($"Written Register addr = ${Address} value = ${Value}"$)
End Sub

'MULTIPLE COILS ARE SUCCESSFULLY WRITTEN TO THE SLAVE
Private Sub ModBus_MultipleCoilsWritten (StartingAddress As Int, Values() As Boolean)
	LogToScreen($"Written Multiple Coils start = ${StartingAddress} count = ${Values.Length}"$)
End Sub

'MULTIPLE HOLDING REGISTERS ARE SUCCESSFULLY WRITTEN TO THE SLAVE
Private Sub ModBus_MultipleRegistersWritten (StartingAddress As Int, Values() As Int)
	LogToScreen($"Written Multiple Registers start = ${StartingAddress} count = ${Values.Length}"$)
End Sub

Sub Modbus_TestCompleted(Success As Boolean, Message As String)
	Log("EVENT: TestCompleted → Success=" & Success & ", Message=" & Message)
End Sub

'READ REQUEST FOR COILS (0XXXX)
Private Sub BtnReadCoils_Click
	ModBus.ReadCoils(0, 14)
	LogToScreen("--------------------------------------------")
End Sub

'READ REQUEST FOR DISCRETE INPUTS (1XXXX)
Private Sub BtnReadDiscreteInputs_Click
	ModBus.ReadDiscreteInputs(0, 14)
	LogToScreen("--------------------------------------------")
End Sub

'READ REQUEST FOR HOLDING REGISTERS (4XXXX)
Private Sub BtnReadHoldingRegisters_Click
	ModBus.ReadHoldingRegisters(0, 14)
	LogToScreen("--------------------------------------------")
End Sub

'READ REQUEST FOR INPUT REGISTERS (3XXXX)
Private Sub BtnReadInputRegisters_Click
	ModBus.ReadInputRegisters(0, 14)
	LogToScreen("--------------------------------------------")
End Sub

'WRITE REQUEST FOR A SINGLE COIL
Private Sub BtnWriteCoil_Click
	ModBus.WriteCoil(0, True)
	LogToScreen("--------------------------------------------")
End Sub

'WRITE REQUEST FOR MULTIPLE COILS
Private Sub BtnWriteMultipleCoils_Click
	ModBus.WriteCoils(0, Array As Boolean(True, False, True, False, True, False, True, False, True, False))
	LogToScreen("--------------------------------------------")
End Sub

'WRITE REQUEST FOR A SINGLE HOLDING REGISTER
Private Sub BtnWriteRegister_Click
	Dim rValue As Float = 123.45
	Dim Regs() As Int = ModBus.FloatToRegisters(rValue)
	ModBus.WriteRegisters(100, Regs)
	
	Dim Registers() As Int = ModBus.ReadHoldingRegisters(100, 2)
	Dim MyFloat As Float = ModBus.RegistersToFloat(Registers(0), Registers(1))
	Log("The returned float value is: " & MyFloat.As(Double))
	LogToScreen("--------------------------------------------")
	
	ModBus.WriteRegister(1, 123)
	LogToScreen("--------------------------------------------")
End Sub

'WRITE REQUEST FOR MULTIPLE HOLDING REGISTERS
Private Sub BtnWriteMultipleRegisters_Click
	ModBus.WriteRegisters(3, Array As Int(100, 200, 300))
	LogToScreen("--------------------------------------------")
End Sub

'READ/WRITE REQUEST FOR MULTIPLE HOLDING REGISTERS IN ONE GO
Private Sub BtnReadWrite_Click
	'Example: FC23 Read/Write Multiple Registers
	Dim WriteValues() As Int = Array As Int(123, 456, 789)
	ModBus.ReadWriteMultipleRegisters(10, WriteValues.Length, 10, WriteValues)
	
	LogToScreen($"Write values using FC23: ${ArrayToString(WriteValues)}"$)
	LogToScreen($"Reading values using FC23: ${ArrayToString(WriteValues)}"$)
	LogToScreen("--------------------------------------------")
End Sub

'UTILITY TO PRINT ARRAYS
Private Sub ArrayToString(arr() As Int) As String
	Dim SB As StringBuilder
		SB.Initialize

	For Each v As Int In arr
		SB.Append(v).Append(", ")
	Next

	If SB.Length > 2 Then SB.Remove(SB.Length - 2, SB.Length)
	Return SB.ToString
End Sub

'DISPLAY MESSAGES IN THE ON-SCREEN LOG AND SYSTEM LOG
Private Sub LogToScreen(Msg As String)
	Log(Msg)
	TxtLog.Text = TxtLog.Text & Msg & CRLF
	TxtLog.SelectionStart = TxtLog.Text.Length
End Sub

'ENABLE / DISABLE THE BUTTON STATE
Private Sub SetButtonState (State As Boolean)
	If State Then
		BtnReadDiscreteInputs.Enabled = True
		BtnReadInputRegisters.Enabled = True
		BtnReadCoils.Enabled = True
		BtnWriteCoil.Enabled = True
		BtnWriteMultipleCoils.Enabled = True
		BtnReadHoldingRegisters.Enabled = True
		BtnWriteRegister.Enabled = True
		BtnWriteMultipleRegisters.Enabled = True
		BtnReadWrite.Enabled = True
		TxtLog.Enabled = True
	Else
		BtnReadDiscreteInputs.Enabled = False
		BtnReadInputRegisters.Enabled = False
		BtnReadCoils.Enabled = False
		BtnWriteCoil.Enabled = False
		BtnWriteMultipleCoils.Enabled = False
		BtnReadHoldingRegisters.Enabled = False
		BtnWriteRegister.Enabled = False
		BtnWriteMultipleRegisters.Enabled = False
		BtnReadWrite.Enabled = False
		TxtLog.Enabled = False
	End If
	TxtLog.Text = ""
End Sub

' ============================================================
'   TEST SEQUENCE ENGINE
' ============================================================

Private Sub RunAllTests 'ignore
'	TestStep = TestStep + 1

'	Select Case TestStep
'		Case 1
			Log("STEP 1: FC1 Read Coils")
			ModBus.ReadCoils(0, 8)
'		Case 2
			Log("STEP 2: FC2 Read Discrete Inputs")
			ModBus.ReadDiscreteInputs(0, 8)
'		Case 3
			Log("STEP 3: FC3 Read Holding Registers")
			ModBus.ReadHoldingRegisters(0, 4)
'		Case 4
			Log("STEP 4: FC4 Read Input Registers")
			ModBus.ReadInputRegisters(0, 4)
'		Case 5
			Log("STEP 5: FC5 Write Single Coil")
			ModBus.WriteCoil(0, True)
'		Case 6
			Log("STEP 6: FC6 Write Single Register")
			ModBus.WriteRegister(1, 1234)
'		Case 7
			Log("STEP 7: FC15 Write Multiple Coils")
			Dim coils() As Boolean = Array As Boolean(True, False, True, True)
			ModBus.WriteCoils(10, coils)
'		Case 8
			Log("STEP 8: FC16 Write Multiple Registers")
			Dim regs() As Int = Array As Int(100, 200, 300)
			ModBus.WriteRegisters(20, regs)
'		Case 9
			Log("STEP 9: FC23 Read/Write Multiple Registers")
			Dim writeVals() As Int = Array As Int(999, 888)
			ModBus.ReadWriteMultipleRegisters(30, 4, 30, writeVals)
'		Case 10
			Log("STEP 10: FC8 Diagnostic Loopback")
			ModBus.DiagnosticRequest(0, 12345)
'		Case 11
			Log("STEP 11: TestFunction Heartbeat")
			ModBus.TestFunction
'		Case Else
			Log("=== ALL TESTS COMPLETE ===")
'			Return
'	End Select
End Sub

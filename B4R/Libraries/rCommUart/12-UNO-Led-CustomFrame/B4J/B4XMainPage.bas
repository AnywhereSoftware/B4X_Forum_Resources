B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
'==============================================
' Project:      rCommUART
' Brief:        UART communication example to set the state of an LED connected to an Arduino.
' Date:         2026-09-29
' Author:       Robert W.B. Linn (c) 2026 MIT
' Description:  Select the COM port to which the Arduino UNO is connected.
'               Connects to the selected COM port and handles binary stream framing.
'               Sends a 3-byte frame (raw bytes) to switch the LED connected to the Arduino on or off.
'               3-Byte Frame Layout:
'               Byte 0: 0xFE - Header (STX)
'               Byte 1: 0x00 or 0x01 - Target LED Payload State (0=Off, 1=On)
'               Byte 2: 0xFF - Footer (ETX / ASCII 'X')
' Hardware:     Arduino UNO
' Software:     B4J 10.70 (64-bit), jSerial 1.40, jRandomAccessFile 2.35, HMITilesIO 0.8, ByteConverter 1.10

'[ B4J Test App ]                                     [ Arduino UNO ]
'       │                                                    │
'       │  ─── (Command: 0x19 0x01 0x58) ─────────────────►  │ (Receives & Parses)
'       │                                                    │ ── Hardware Action: 
'       │                                                    │    Sets DigitalPin 4 = HIGH
'       │                                                    │
'       │  ◄── (Confirmation: 0x19 0x11 0x58) ─────────────  │ (Sends ACK State)
'       ▼                                                    ▼
'(Logs success & toggles GUI checkbox)
'==============================================
#End Region

#Region Shared Files
' #CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

#Macro: Title, Export B4XPages, ide://run?File=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip


Sub Class_Globals
	Private VERSION 	As String = "rCommUART Example Custom Frame Set LED State v20260930"
	Private COPYRIGHT 	As String = "rCommUART (c) Robert W.B. Linn - MIT"
	
	' Core
	Private xui As XUI
	Private Root As B4XView

	' Communication
	Private SerialLine As Serial
	Private IsConnected As Boolean = False
	Private IsCommError As Boolean = False
	Private AStreams As AsyncStreams
	Private FRAME_SIZE As Int = 3
	Private FRAME_HEADER As Byte = 0xFE
	Private FRAME_FOOTER As Byte = 0xFF

	' UI
	Private SelectorCOMPort As HMITilesIO
	Private SwitchCOMPort As HMITilesIO
	Private SwitchLed As HMITilesIO
	Private LabelCopyright As B4XView

	' LED
	Private STATE_ON As Byte = 0x01
	Private STATE_OFF As Byte = 0x00

	' Helper
	Private bc As ByteConverter
End Sub

Public Sub Initialize
	B4XPages.GetManager.LogEvents = True
End Sub

'==============================================
' B4XPAGES
'==============================================


' This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Log(VERSION)
	Root = Root1
	Root.LoadLayout("MainPage")
	Root.Color = xui.Color_RGB(0xE0, 0xE0, 0xE0)

	' B4XPages	
	B4XPages.SetTitle(Me, VERSION)
	B4XPages.GetNativeParent(Me).Resizable = False

	' UI
	LabelCopyright.Text = COPYRIGHT

	' HMITiles
	' Ensure to set short sleep to let the customviews complete
	Sleep(50)
	InitHMITiles
End Sub

Private Sub B4XPage_CloseRequest As ResumableSub
	If xui.IsB4A Then
	End If
	CloseSerialConnection
	Return True
End Sub

'==============================================
' HMITILES
'==============================================

Private Sub InitHMITiles
	SelectorCOMPort.Value = "NONE"
	SelectorCOMPort.Items = SerialLine.ListPorts
	If SelectorCOMPort.Items.Size > 0 Then
		SelectorCOMPort.Value = SelectorCOMPort.Items.Get(0)
	End If
	SwitchCOMPort.State = False
	SwitchCOMPort.Footer = "Disconnected"
	SwitchLed.State = False
End Sub

Private Sub ResetHMITiles
	SwitchCOMPort.State = False
	If IsCommError Then
		SwitchCOMPort.Footer = "ERROR"		
	Else
		SwitchCOMPort.Footer = "Disconnected"
	End If
	SwitchLed.State = False
End Sub

' Hardened B4J Connection Lifecycle Management Engine
Private Sub InitPort(port As String)
	Log($"[InitPort] Attempting connection on port: ${port}"$)
	
	' Clear any zombie streaming loops or legacy buffers before opening a new one
	CloseSerialConnection
	
	SerialLine.Initialize("SerialLine")
	Try
		SerialLine.Open(port)
		SerialLine.SetParams(115200, 8, 1, 0)
        
		' Prefix mode ensures perfect frame alignment
		AStreams.Initialize(SerialLine.GetInputStream, SerialLine.GetOutputStream, "AStreams")
		'AStreams.InitializePrefix(SerialLine.GetInputStream, False, SerialLine.GetOutputStream, "AStreams")
		Log($"[InitPort] Telemetry parser successfully activated on: ${port}"$)
		IsConnected = True
		IsCommError = False
		' Must be done as last step
		SwitchCOMPort.State = True
		SwitchCOMPort.Footer = "Connected"
	Catch
		Log($"[InitPort][E] Connection Exception: Port ${port} is busy, locked, or unavailable."$)
		IsCommError = True
		CloseSerialConnection
	End Try
End Sub

' Safe connection teardown routine - completely shields against null pointer exceptions
Private Sub CloseSerialConnection As Boolean
	Try
		' Terminate background polling threads first
		If AStreams.IsInitialized Then
			AStreams.Close
		End If
	Catch
		Log("[CloseSerialConnection][E] Error closing streams thread.")
	End Try

	Try
		' Release the operating system virtual hardware handle resource
		If IsConnected Then
			SerialLine.Close
			IsConnected = False
			IsCommError = False
		End If
	Catch
		Log("[CloseSerialConnection][E] Error closing serial hardware port.")
		IsCommError = True
	End Try
	ResetHMITiles
	Log("[CloseSerialConnection] Serial pipeline safely shutdown and isolated.")
	return true
End Sub

'==============================================
' ASYNCSTREAMS EVENTS
'==============================================

' This fires instantly whenever a full serialized frame block lands on the PC stream
Sub AStreams_NewData (buffer() As Byte)
	Log($"[AStreams_NewData] Incoming payload. Length: ${buffer.Length}, Hex: ${bc.HexFromBytes(buffer)}"$)
	
	' Delegate parsing and state extraction to its own method
	ProcessIncomingPayload(buffer)
End Sub

' ProcessIncomingPayload
' Parses raw data chunks to distinguish between binary protocol frames and text traffic.
' Parameter:
'    Buffer - The raw byte data received from the serial stream
Private Sub ProcessIncomingPayload(buffer() As Byte)
	' -------------------------------------------------------------
	' 1. Strict 3-Byte Binary Protocol Verification
	' -------------------------------------------------------------
	If buffer.Length = FRAME_SIZE Then
		Dim Header As Byte = buffer(0)
		Dim Status As Byte = buffer(1)
		Dim Footer As Byte = buffer(2)
		
		' Confirm absolute structural boundary alignment (0x19 ... 0x58)
		If Header = FRAME_HEADER And Footer = FRAME_FOOTER Then
			Select Case Status
				Case 0x06 ' STATUS_OK (ASCII ACK)
					Log("[CommUART.Response][I] Handshake verified: Operation executed successfully.")
					' Call your UI update routines here (e.g., UpdateLedUI(True))
					SwitchLed.Footer = DateTime.Time(DateTime.Now)
					
				Case 0x15 ' STATUS_ERR (ASCII NAK)
					Log("[CommUART.Response][E] Hardware Alert: Arduino rejected command or data corrupted.")
					
				Case 0x16 ' STATUS_BUSY (ASCII SYN)
					Log("[CommUART.Response][W] Hardware Warning: Controller is processing a blocking task.")
					
				Case Else
					Log($"[CommUART.Response][W] Unhandled operational status code: 0x${bc.HexFromBytes(Array As Byte(Status))}"$)
			End Select
			Return ' Verification finished successfully
		Else
			Log("[CommUART.Response][E] Frame structural anomaly: Incorrect boundary tracking bytes.")
			Return
		End If
	End If
	
	' -------------------------------------------------------------
	' 2. Fallback: Plain Text Logging / Diagnostic Traffic
	' -------------------------------------------------------------
	' If it's not a 3-byte binary command, handle it safely as native text layout strings.
	Try
		Dim TextTraffic As String = BytesToString(buffer, 0, buffer.Length, "UTF8")
		Log($"[CommUART.Response][Text] ${TextTraffic.Trim}"$)
	Catch
		Log($"[CommUART.Response][E] Corrupted data block received. Hex: ${bc.HexFromBytes(buffer)}"$)
	End Try
End Sub

' THIS EVENT FIRES THE MOMENT THE USB PLUG IS PULLED!
Sub AStreams_Error
	Log("[AStreams_Error] Hardware connection pipe broken unexpectedly (-1 byteCount caught).")
	
	' CRITICAL DEFENSE: Instantly isolate the hardware handle to prevent the background
	' thread from hammering the missing virtual COM port and throwing deep JVM crashes.
	CloseSerialConnection
	
	' --- GRAPHICAL USER EXPERIENCE SAFETY FEEDBACK ---
	' Force the dashboard indicators to reflect an offline state gracefully
	' Set engine toggle switches to off, clear gauges, or warn the driver
	' SwitchEngine.State = False
	Log("[AStreams_Error] Dashboard isolated safely. System offline.")
End Sub

Sub AStreams_Terminated
	Log("[AStreams_Terminated] Telemetry stream line severed gracefully.")
	CloseSerialConnection
End Sub

'==============================================
' HMITilesIO
'==============================================

Private Sub SelectorCOMPort_Click(State As Boolean, Value As String)
	SelectorCOMPort.Value = Value
End Sub

' COM port connect/disconnect
Private Sub SwitchCOMPort_Click(State As Boolean, Value As String)
	' No COM port > do nothing
	If SelectorCOMPort.Value = "NONE" Then
		Return
	End If
	State = Not(State)

	If State Then
		InitPort(SelectorCOMPort.Value)
	Else
		CloseSerialConnection
	End If
	Log($"[SwitchCOMPort] state=${State}"$)
End Sub

' Set the state of te LED
Private Sub SwitchLed_Click(State As Boolean, Value As String)
	State = Not(State)

	Dim newstate As Byte = IIf(State, STATE_ON, STATE_OFF)
	Dim frame(FRAME_SIZE) As Byte = Array As Byte(FRAME_HEADER, newstate, FRAME_FOOTER)
	AStreams.Write(frame)

	' Must be done as last step
	SwitchLed.State = State
	Log($"[SwitchCOMLed] state=${State} value=${Value} frame=${bc.HexFromBytes(frame)}"$)
End Sub

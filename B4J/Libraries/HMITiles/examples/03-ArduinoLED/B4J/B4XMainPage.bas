B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Class Header
' ================================================================
' File:			ArduinoLED
' Brief:		Control the state of an LED connected to an Arduino UNO via the serial line.
' Date:			2025-12-26
' Author:		Robert W.B. Linn (c) 2025 MIT
' Description:	The application connects to the Arduino UNO via the serial line (COM).
'				The state of the Arduino onboard LED (pin 0x0D) is set via byte:
'				0x00 (OFF), 0x01 (ON), 0x02 (Blink)
' Notes:		Ensure the B4R IDE is disconnected else the COM port is locked.
' ================================================================
#End Region

#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
#End Region

Sub Class_Globals
	' ================================================================
	' APPLICATION METADATA
	' ================================================================
	Private VERSION As String	= "ArduinoLED v20251226"
	Private ABOUT As String 	= $"HMITiles Example ${VERSION} (c) 2025 Robert W.B. Linn - MIT"$

	' ================================================================
	' UI ROOT & CORE
	' ================================================================
	Private xui As XUI
	Private Root As B4XView
	Private LabelAbout As B4XView

	' ================================================================
	' TILES
	' ================================================================
	' Button to open the COM port
	Private TileButtonOpenPort As HMITileButton
	
	' Select COM port
	Private TileSelectPort As HMITileSelect

	' Select LED command ON, OFF, Blink
	Private TileSelectLEDCommand As HMITileSelect

	' Button to toggle the LED
	Private TileButtonLEDOnOff As HMITileButton

	' ReadOut to show the LED state
	Private TileReadoutLEDState As HMITileReadout
	
	' Event / alarm viewer
	Private TileEvents As HMITileEventViewer
	
	' ================================================================
	' SERIAL COMMUNICATION ARDUINO
	' ================================================================
	Private SerialLine As Serial
	Private const BAUDRATE As Int = 115200
	Private PortSelected As String = ""
	Private IsPortOpen As Boolean = False
	Private AStream As AsyncStreams

	' ================================================================
	' LED COMMANDS & STATES
	' ================================================================
	Private CMD_LED_OFF As Byte 	= 0x00
	Private CMD_LED_ON As Byte		= 0x01
	Private CMD_LED_BLINK As Byte 	= 0x02

	Private STATE_LED_OFF As Byte 	= CMD_LED_OFF
	Private STATE_LED_ON As Byte	= CMD_LED_ON
	Private STATE_ERROR As Byte 	= 0xFF
End Sub

Public Sub Initialize
	' Enable lifecycle logging for debugging and learning
	B4XPages.GetManager.LogEvents = True
End Sub

' Called once when the page is created
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")

	' ================================================================
	' SERIAL LINE
	' ================================================================
	SerialLine.Initialize("")

	' ================================================================
	' GENERAL UI SETTINGS
	' ================================================================
	Root.Color = HMITileUtils.COLOR_BACKGROUND_SCREEN
	B4XPages.SetTitle(Me, VERSION)
	B4XPages.GetNativeParent(Me).Resizable = False
	LabelAbout.Text = ABOUT

	' Allow CustomViews to fully initialize
	Sleep(1)

	' ================================================================
	' EVENT VIEWER
	' ================================================================
	TileEvents.CompactMode = False
	TileEvents.Insert(VERSION, HMITileUtils.EVENT_LEVEL_INFO)

	' ================================================================
	' BUTTONS
	' ================================================================
	TileButtonOpenPort.StateText = IIf(False, "Open", "Closed")
	TileButtonLEDOnOff.StateText = IIf(False, "ON", "OFF")

	' ================================================================
	' SELECT LIST
	' ================================================================
	TileSelectPort.AddAll(SerialLine.ListPorts)
	If SerialLine.ListPorts.Size < 3 Then
		TileSelectPort.Scrollbar = False
	End If
	If TileSelectPort.Size == 1 Then
		TileSelectPort.SetSelectedItem(0)
		PortSelected = TileSelectPort.SelectedItem
	End If
	If TileSelectPort.Size == 0 Then
		TileEvents.Insert($"No port(s) found"$, HMITileUtils.EVENT_LEVEL_WARNING)
	End If
	TileSelectLEDCommand.AddAll(Array As String("On", "Off", "Blink"))

	' ReadOut
	TileReadoutLEDState.Value = TileButtonLEDOnOff.StateText
End Sub

' ================================================================
' LED CONTROL BUTTON
' ================================================================
Private Sub TileButtonOpenPort_Click
	If PortSelected.Length == 0 Then
		TileEvents.Insert($"[TileButtonOpenPort_Click] No port(s) found or selected"$, HMITileUtils.EVENT_LEVEL_WARNING)
		Return
	End If

	TileButtonOpenPort.SetState(TileButtonOpenPort.State)
	TileButtonOpenPort.StateText = IIf(TileButtonOpenPort.State, "Open", "Closed")
	' TileEvents.Insert($"[TileButtonOpenPort_Click] port=${PortSelected}, state=${TileButtonOpenPort.State}"$, HMITileUtils.EVENT_LEVEL_INFO)

	If AStream.IsInitialized Then
		AStream.Close
		SerialLine.Close
		IsPortOpen = False
	End If
	
	If TileButtonOpenPort.State Then
		Try
			SerialLine.Open(PortSelected)
			SerialLine.SetParams(BAUDRATE, 8, 1, 0)
			AStream.Initialize(SerialLine.GetInputStream, SerialLine.GetOutputStream, "AStream")
			IsPortOpen = True
			TileEvents.Insert($"[TileButtonOpenPort] port=${PortSelected}, open=${IsPortOpen}"$, HMITileUtils.EVENT_LEVEL_INFO)			
		Catch
			IsPortOpen = True
			TileEvents.Insert($"[TileButtonOpenPort] ${LastException}"$, HMITileUtils.EVENT_LEVEL_ALARM)
		End Try
	End If
End Sub

Private Sub TileButtonLEDOnOff_Click
	If Not(IsPortOpen) Then Return
	Dim data(1) As Byte
	
	TileButtonLEDOnOff.SetState(TileButtonLEDOnOff.State)
	TileButtonLEDOnOff.StateText = IIf(TileButtonLEDOnOff.State, "ON", "OFF")
	TileEvents.Insert($"[TileButtonLEDOnOff] state=${TileButtonLEDOnOff.State}"$, HMITileUtils.EVENT_LEVEL_INFO)
	
	If TileButtonLEDOnOff.State Then
		data(0) = CMD_LED_ON
	Else
		data(0) = CMD_LED_OFF
	End If
	AStreamWrite(data)
End Sub

Private Sub TileSelectLEDCommand_ItemClick (Index As Int, Value As Object)
	If Not(IsPortOpen) Then Return
	Dim data(1) As Byte
	
	TileEvents.Insert($"[TileSelectLEDCommand_ItemClick] index=${Index}, value=${Value}"$, HMITileUtils.EVENT_LEVEL_INFO)
	Select Index
		Case 0
			data(0) = CMD_LED_ON
		Case 1
			data(0) = CMD_LED_OFF
		Case 2
			data(0) = CMD_LED_BLINK
	End Select
	AStreamWrite(data)
End Sub

' ================================================================
' EVENT VIEWER & TILE CALLBACKS
' ================================================================
Private Sub TileEvents_ItemClick (Index As Int, Value As Object)
	TileEvents.Insert($"[TileEvents_ItemClick] index=${Index}, value=${Value}"$, _
		HMITileUtils.EVENT_LEVEL_INFO)
End Sub

Private Sub TileSelect_ItemClick (Index As Int, Value As Object)
	TileEvents.Insert($"[TileSelect_ItemClick] index=${Index}, value=${Value}"$, _
		HMITileUtils.EVENT_LEVEL_INFO)
	PortSelected = Value.As(String)
End Sub

' ================================================================
' ASYNCSTREAM
' ================================================================
Sub AStream_NewData (Buffer() As Byte)
	Dim state As Byte
	Dim statetext As String 
	
	If Buffer.Length = 1 Then
		state = Buffer(0)
		TileEvents.Insert($"[AStream_NewData] data=${HMITileUtils.ByteConv.HexFromBytes(Buffer)}"$, HMITileUtils.EVENT_LEVEL_INFO)
		Select state
			Case STATE_LED_OFF
				statetext = "OFF"
			Case STATE_LED_ON
				statetext = "ON"
			Case STATE_ERROR
				statetext = "ERROR"
		End Select
		TileReadoutLEDState.Value = statetext		
	End If
End Sub

Sub AStream_Error
	TileEvents.Insert($"[AStream_Error] "$, HMITileUtils.EVENT_LEVEL_ALARM)
End Sub

Sub AStream_Terminated
	TileEvents.Insert($"[AStream_Terminated] "$, HMITileUtils.EVENT_LEVEL_WARNING)
End Sub

Public Sub AStreamWrite(data() As Byte)
	Try
		AStream.Write(data)
		TileEvents.Insert($"[AStreamWrite] sending=${HMITileUtils.ByteConv.HexFromBytes(data)}"$, HMITileUtils.EVENT_LEVEL_INFO)
	Catch
		TileEvents.Insert($"[AStreamWrite] failed=${LastException}"$, HMITileUtils.EVENT_LEVEL_ALARM)
	End Try
End Sub

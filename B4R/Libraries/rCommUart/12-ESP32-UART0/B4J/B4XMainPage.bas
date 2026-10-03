B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
'==============================================
' Project:		rCommUART
' Brief:		Uart communication example
' Date:			2026-09-27
' Author: 		Robert W.B. Linn (c) 2026 MIT
' Description:	
' Hardware:		Arduino MEGA.
' Software:		B4R 4.00 (64 bit)
'				Arduino UNO R4 Boards 1.6.0
' Wiring:		N/A
' TestLog:
'==============================================
#End Region

#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

#Macro: Title, Export B4XPages, ide://run?File=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip


Sub Class_Globals
	Private VERSION 	As String = "CommUART Example v20260927"
	Private COPYRIGHT 	As String = "rCommUART (c) Robert W.B. Linn - MIT"
	
	' Core
	Private xui As XUI
	Private Root As B4XView

	' Communication
	Private SerialLine As Serial
	Private IsConnected As Boolean
	Private AStreams As AsyncStreams
    
	' UI
	Private SelectorCOMPort As HMITilesIO
	Private SwitchCOMPort As HMITilesIO
	Private SwitchLed As HMITilesIO
	Private LabelCopyright As B4XView

	' Helper
	Private bc As ByteConverter
End Sub

Public Sub Initialize
	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Log(VERSION)
	Root = Root1
	Root.LoadLayout("MainPage")
	Root.Color =xui.Color_RGB(0xE0, 0xE0, 0xE0)

	' B4XPages	
	B4XPages.SetTitle(Me, VERSION)
	B4XPages.GetNativeParent(Me).Resizable = False

	' UI
	LabelCopyright.Text = COPYRIGHT

	' HMITiles
	' Ensure to set short sleep to let the customviews complete
	Sleep(50)
	InitHMITilesIO
End Sub

Private Sub InitHMITilesIO
	Log($"[InitHMITilesIO]"$)
	SelectorCOMPort.Value = "NONE"
	SelectorCOMPort.Items = SerialLine.ListPorts
	If SelectorCOMPort.Items.Size > 0 Then
		SelectorCOMPort.Value = SelectorCOMPort.Items.Get(0)
	End If

	SwitchCOMPort.State = False
	SwitchLed.State = False
End Sub

' Hardened B4J Connection Lifecycle Management Engine
Private Sub InitPort(port As String)
	Log($"[InitPort] Attempting connection on port: ${port}"$)
	
	' 1. Clear any zombie streaming loops or legacy buffers before opening a new one
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
		' Optional: Update UI dashboard tile status here to "ONLINE"
	Catch
		IsConnected = False
		Log($"[InitPort][E] Connection Exception: Port ${port} is busy, locked, or unavailable."$)
		CloseSerialConnection
	End Try
End Sub

' Safe connection teardown routine - completely shields against null pointer exceptions
Private Sub CloseSerialConnection
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
		End If
	Catch
		Log("[CloseSerialConnection][E] Error closing serial hardware port.")
	End Try

	InitHMITilesIO
	
	Log("[CloseSerialConnection] Serial pipeline safely shutdown and isolated.")
End Sub

' This fires instantly whenever a full serialized frame block lands on the PC stream
Sub AStreams_NewData (Buffer() As Byte)
	Log($"[AStreams_NewData] ${bc.HexFromBytes(Buffer)}"$)
	Log($"[AStreams_NewData] ${bc.StringFromBytes(Buffer, "UTF8")}"$)
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
' HMITiledsIO
'==============================================

Private Sub SelectorCOMPort_Click(State As Boolean, Value As String)
	SelectorCOMPort.Value = Value
End Sub

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
		Return
	End If
	' Must be done as last step
	Sleep(50)
	If IsConnected Then
		SwitchCOMPort.State = State
		Log($"[SwitchCOMPort] state=${State}"$)		
	End If
End Sub

Private Sub SwitchLed_Click(State As Boolean, Value As String)
	If Not(IsConnected) Then Return

	State = Not(State)
	Dim newstate As Byte = IIf(State, 0x01, 0x00)
	Dim frame(3) As Byte = Array As Byte(0x19, newstate, 0x58)
	AStreams.Write(frame)

	' Must be done as last step
	SwitchLed.State = State
	Log($"[SwitchCOMLed] state=${State} value=${Value}"$)
End Sub

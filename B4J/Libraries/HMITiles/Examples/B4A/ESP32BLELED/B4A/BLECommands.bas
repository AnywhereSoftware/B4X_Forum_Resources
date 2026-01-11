B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
#Region Class Header
' Class:        BLECommands
' Brief:        Registry of BLE command definitions.
' Date:         2025-12-31
' Author:       Robert W.B. Linn (c) 2025 MIT
' Description:  Provides TCommand definitions and utilities.
' Note:			B4R uses unsigned bytes (0–255)
'				B4J uses signed bytes (–128 to +127) > use Int for DeviceID and CommandID and NOT Byte
#End Region

Private Sub Class_Globals
	' Command definition
	Type TCommand (Name As String, DeviceId As Int, CommandId As Int, Description As String, Value() As Byte)

	' List of commands
	Public ListCommands As List
End Sub

' Initializes the object.
' The list must contain unique command names.
Public Sub Initialize
	' Init the list
	ListCommands.Initialize

	Add("Connect",  BLEConstants.DEV_SYSTEM, BLEConstants.CMD_SET_STATE, "Connect ESP32",  Array As Byte(BLEConstants.STATE_ON))
	Add("Disconnect",  BLEConstants.DEV_SYSTEM, BLEConstants.CMD_SET_STATE, "Disconnect ESP32",  Array As Byte(BLEConstants.STATE_OFF))

	Add("LED ON",  BLEConstants.DEV_LED, BLEConstants.CMD_SET_STATE, "Turn LED on",  Array As Byte(BLEConstants.STATE_ON))
	Add("LED OFF", BLEConstants.DEV_LED, BLEConstants.CMD_SET_STATE, "Turn LED off", Array As Byte(BLEConstants.STATE_OFF))
	Add("LED STATE", BLEConstants.DEV_LED, BLEConstants.CMD_GET_STATE, "Request LED state", Null)

	Log($"[BLECommands.Initialize] commands=${ListCommands.Size}"$)
End Sub

#Region CommandList
' Adds a command definition
Public Sub Add(name As String, devid As Int, cmdid As Int, desc As String, value() As Byte)
	Dim c As TCommand
	c.Initialize
	c.Name = name
	c.DeviceId = devid
	c.CommandId = cmdid
	c.Description = desc
	c.Value = value
	ListCommands.Add(c)
End Sub

' Get a command (must match both Device + Command)
Public Sub Get(deviceId As Byte, commandId As Byte) As TCommand
	For Each c As TCommand In ListCommands
		If c.DeviceId = deviceId And c.CommandId = commandId Then
			Return c
		End If
	Next
	Return Null
End Sub

' Find a command by name
Public Sub Find(name As String) As TCommand
	For Each c As TCommand In ListCommands
		If c.Name.ToLowerCase = name.ToLowerCase Then
			Return c
		End If
	Next
	Return Null
End Sub

' Build BLE payload
Public Sub BuildPayload(cmd As TCommand) As Byte()
	If cmd = Null Then Return Null

	Dim val() As Byte = cmd.Value
	Dim vlen As Int = IIf(val = Null, 0, val.Length)

	Dim payload(2 + vlen) As Byte
	payload(0) = cmd.DeviceId
	payload(1) = cmd.CommandId

	If vlen > 0 Then
		For i = 0 To vlen - 1
			payload(2 + i) = val(i)
		Next
	End If
	Return payload
End Sub
#End Region

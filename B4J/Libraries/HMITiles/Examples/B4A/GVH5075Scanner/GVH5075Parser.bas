B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=13.4
@EndOfDesignText@
' ================================================================
' File:			GVH5075Parser
' Brief:		Parse RuuviTag BLE advertised data.
' Date:			2026-01-09
' Author:		Robert W.B. Linn (c) 2026 MIT
' DependsOn:	ByteConverter
' Description:	GVH5075 is a wireless Bluetooth Low Energy (BLE) sensor node.
'				Sends current readings temperature & humidity & battery health every 2 seconds.
'				Advertised device name is GVH5075_NNNN last 2 bytes from its MAC address.
' ================================================================

Sub Process_Globals

	' Default Device Name & MAC used by device found to filter
	' Public GVH_NAME As String			= "GVH5075"
	' Private DEV_NAME As String		= "GVH5075_3022"
	' Public GVH_MAC_DEFAULT As String	= "A4:C1:38:4C:30:22"

	' ADV Data
	Type TGVH5075AdvData (	Ticks As Long, TimeStamp As String, TimeStampDate As String, TimeStampTime As String, TimeStampTimeHourMin As String, _
							Temperature As Double, Humidity As Double, _ 
							BatteryPct As Int)

	' LOG Data
	' Not used
		
	' Error
	Public LastErrorMessage As String
End Sub

' ================================================================
' DEVICE ADV DATA PARSER
' ================================================================

' Parse the advertised data from the BLE device Govee 5075 (GVH5075_NNNN).
' Dataformat:
' The manufacturer key 0xEC88 (2 Bytes) is used as the key to extract the manufacturer data.
' The manufacturer data has 6 bytes.
' Example: key=0XEC88, data=00029E436400
' Data Conversion:
' Data (6 Bytes)			= 00029E436400 > 00 02 9E 43 64 00
'											 Temp + Hum  Bat Not Used
' Temp + Hum (Bytes 0-4)	= HEX 00 02 9E 43 > converted to DEC 171587
' Temperature 				= 171587 / 10000 = 17.1 °C              (Round, 1)
' Humidity    				= 171587 % 1000 = 587 / 10 = 58.7 %RH   (Double)
' Battery (Byte 5)			= HEX 64 > DEC 100            			(Int)
'"""

' Parse
' Parse the advertised data.
' Parameters:
'	adv Byte array
' Returns:
'	Type with properties
Public Sub Parse(adv() As Byte) As TGVH5075AdvData
	' Result type
	Dim result As TGVH5075AdvData
	
	' Manufacterer data
	Dim manudata() As Byte = GetManuData(adv, 0xFF, Array As Byte(0x88, 0xEC), 6)
	' Log($"[ParseGVH5075] manudata=${HMITileUtils.ByteConv.HexFromBytes(manudata)}"$)

	LastErrorMessage = ""

	' 00 02 D8 BC 64 00
	If manudata.Length == 6 Then
		
		' Convert first 4 bytes to int
		Dim ints() As Int = HMITileUtils.ByteConv.IntsFromBytes(Array As Byte(manudata(0),manudata(1),manudata(2),manudata(3)))

		' Get the first int which is raw value holding t & h
		Dim raw As Int = ints(0)

		' Calculate temperature
		Dim t As Double =  raw / 10000

		' Calculate Humidity
		Dim hRaw As Int = raw Mod 1000	' raw - (raw / 1000) * 1000 ' emulate %
		Dim h As Double = hRaw / 10

		' Battery = byte 4
		Dim b As Int = manudata(4)

		' Build the result type
		result.Initialize

		' Timestamp Ticks
		result.Ticks = DateTime.Now

		' Timestamp String
		result.TimeStampDate = DateTime.Date(DateTime.Now)
		result.TimeStampTime = DateTime.Time(DateTime.Now)
		result.TimeStampTimeHourMin = result.TimeStampTime.SubString2(0, 5)
		result.TimeStamp = $"${result.TimeStampDate} ${result.TimeStampTime}"$

		result.Temperature = t
		result.Humidity = h
		result.BatteryPct = b
		Log($"[ParseGVH5075] ${result}"$)
	Else
		LastErrorMessage = $"Incorrect manufacturer data."$
		Log($"[ParseGVH5075][E] ${LastErrorMessage}"$)
	End If

	Return result
End Sub

' Helper to get the manufacturer data
' Parameters:
'	adv Byte Array - Adv data
' 	datatype Byte - FF = Manufacturer data Type
'	id Byte Array - 88 EC = Company id
'	len Int - Data length
' Return:
'	Data Byte Array - Like 0002D8BC6400
Sub GetManuData(src() As Byte, datatype As Byte, id() As Byte, len As Int) As Byte()
	Dim data(len) As Byte
	For i = 0 To src.Length - 1
		If src(i) == datatype Then
			If src(i + 1) == id(0) And src(i + 2) == id(1) Then
				For j = 0 To len - 1
					data(j) = src(j + i + 3)
				Next
				Return data
			End If
		End If
	Next
	Return data
End Sub


B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=11.8
@EndOfDesignText@
' ================================================================
' File:			RuuviTagParser
' Brief:		Parse RuuviTag BLE advertised data.
' Date:			2026-01-08
' Author:		Robert W.B. Linn (c) 2026 MIT
' DependsOn:	ByteConverter
' Description:	The RuuviTag is a wireless Bluetooth Low Energy (BLE) sensor node
'				Current readings temperature & humidity & battery health are send every 2 seconds.
'				Scanning for data is done only once (can be turned off).
' ================================================================

Sub Process_Globals
	Private VERSION As String = "RuuviTagParser v20260109"	'ignore

	'Device
	'Public BLE_MAC_ADDRESS As String = "F7:6F:D8:27:B7:8D"

	'UUIDs (lowercase)
	'UUID remote service to connect (UART_SERVICE_UUID)
	Public SERVICE_UUID As String			= "6e400001-b5a3-f393-e0a9-e50e24dcca9e"
	Public ADV_CHAR_UUID As String			= "6e400003-b5a3-f393-e0a9-e50e24dcca9e"	'UUID Advertising (ADV)
	Public LOG_CHAR_UUID As String			= "6e400002-b5a3-f393-e0a9-e50e24dcca9e"	'UUID Logging History (LOG)

	'Data formats
	Public DATA_FORMAT_ADV As Byte 			= 0x05	'Example 050E8A6B66C097FFC003E80018A8D66FCBB1
	Public DATA_FORMAT_LOG As Byte 			= 0x3A	'Example 3A31105DC1461F00001597
	Public DATA_POINT_TEMPERATURE As Byte	= 0x30  'Temperature  [0,01°C]
	Public DATA_POINT_HUMIDITY As Byte     	= 0x31  'Humidity     [0,01%rH]
	Public DATA_POINT_AIR_PRESSURE As Byte 	= 0x32  'Air pressure [1Pa]
	Public DATA_POINT_ALL_SENSORS  As Byte 	= 0x3A  'All of the above
	Public DATA_END_OF_OUTPUT As String		= "FFFFFFFF"

	' Data Length Ruuvi V5 format
	Private DATA_LEN_V5 As Int				= 18

	' Battery voltage min/max range
	Private BAT_Min_VOLTAGE As Double		= 1.6
	Private BAT_MAX_VOLTAGE As Double		= 3.646

	' ADV Data
	Type TRuuviTagAdvData (	Ticks As Long, TimeStamp As String, TimeStampDate As String, TimeStampTime As String, TimeStampTimeHourMin As String, _
							Temperature As Double, Humidity As Double, Pressure As Double, _
							BatteryPct As Int, BatteryVoltage As Double, _
							AccelerationX As Int, AccelerationY As Int, AccelerationZ As Int, _
							MovementCounter As Int, MeasurementSequence As Int)

	' LOG Data
	
	' Error
	Public LastErrorMessage As String
	
	' Helpers
	Private bc As ByteConverter
End Sub

#Region AdvData
' ================================================================
' AdvData
' ================================================================

' GetAdvData
' Convert the advertised payload from the TX characteristics (6e400003-b5a3-f393-e0a9-e50e24dcca9e)
' Reference: https://github.com/ruuvi/ruuvi-sensor-protocols
' Data Format V5
' The data length without MAC is 18 bytes.
' Offset | Allowed values       | Description 
' -------| ---------------------|-----------
' 0		 | 5 					| Data format (8bit). ID: 0x05
' 1-2	 | -32767 ... 32767     | Temperature in 0.005 degrees
' 3-4	 | 0 ... 40 000         | Humidity (16bit unsigned) in 0.0025% (0-163.83% range, though realistically 0-100%)
' 5-6 	 | 0 ... 65534          | Pressure (16bit unsigned) in 1 Pa units, with offset of -50 000 Pa
' 7-8 	 | -32767 ... 32767     | Acceleration-X (Most Significant Byte first)
' 9-10   | -32767 ... 32767     | Acceleration-Y (Most Significant Byte first)
' 11-12  | -32767 ... 32767     | Acceleration-Z (Most Significant Byte first)
' 13-14  | 0 ... 2046, 0 ... 30 | Power info (11+5bit unsigned), first 11 bits Is the battery voltage above 1.6V, in millivolts (1.6V To 3.646V range). Last 5 bits unsigned are the TX Power above -40dBm, in 2dBm steps. (-40dBm To +20dBm range)
' 15 	 | 0 ... 254            | Movement counter (8 Bit unsigned), incremented by motion detection interrupts from accelerometer
' 16-17  | 0 ... 65534          | Measurement sequence number (16 Bit unsigned), each time a measurement Is taken, this Is incremented by one, used For measurement de-duplication. Depending on the transmit interval, multiple packets with the same measurements can be sent, And there may be measurements that never were sent.
' 18-23  | Any valid MAC        | 48bit MAC address.
' NOTE
' For the byte(s) conversion the bit.parseint is mainly used, is simpler then bit shifting.
' Parameters:
'	data - Advertised byte array
' Returns:
'	Data as structured type
Private Sub GetAdvData(data() As Byte) As TRuuviTagAdvData
	Dim Result As TRuuviTagAdvData
	Dim hex As String
	Dim payload As String = bc.HexFromBytes(data)
'	Log($"GetAdvData: ${payload}"$)

	' Init the result
	Result.Initialize

	' Check the data array length
	If data.length <> DATA_LEN_V5 Then
		LastErrorMessage = $"[ERROR] GetAdvData has wrong data size ${data.length} (must be 18)."$
		Log($"[RuuviTagParser.GetAdvData] ${LastErrorMessage}"$)
		Return Result
	End If

	'Data format (8 bits) = Byte 0 = value must be 5 (dataformat_05)
	Dim hex As String = payload.SubString2(1,2)
	If hex <> 5 Then
		LastErrorMessage = $"[ERROR] GetAdvData has wrong data format ${hex} (must be 05)."$
		Log($"[RuuviTagParser.GetAdvData] ${LastErrorMessage}"$)
		Return Result
	End If

	' Timestamp Ticks
	Result.Ticks = DateTime.Now

	' Timestamp String
	Result.TimeStampDate = DateTime.Date(DateTime.Now)
	Result.TimeStampTime = DateTime.Time(DateTime.Now)
	Result.TimeStampTimeHourMin = Result.TimeStampTime.SubString2(0, 5)
	Result.TimeStamp = $"${Result.TimeStampDate} ${Result.TimeStampTime}"$

	' Temperature Degree C = Bytes 1 and 2, -32767 ... 32767
	hex = payload.SubString2(2, 6)
	Result.Temperature = Bit.ParseInt(hex, 16)
	' Handle neg temperature
	If Result.Temperature > 32767 Then Result.Temperature = Result.Temperature - 65534
	Result.Temperature = Result.Temperature * 0.005

	'Humidity %RH = Bytes 3 and 4, 0 ... 40 000
	hex = payload.SubString2(6, 10)
	Result.Humidity = Bit.ParseInt(hex, 16) * 0.0025

	'Pressure Pa - Bytes 5 and 6, 0 ... 65534
	hex = payload.SubString2(10, 14)
	Result.Pressure = Bit.ParseInt(hex, 16) + 50000
	If Result.Pressure > 0 Then Result.Pressure = Result.Pressure / 100

	'Acceleration-X (Most Significant Byte first) - Bytes 7 and 8, -32767 ... 32767
	Result.AccelerationX = BytesToInt(data(7), data(8))
	If Result.AccelerationX > 32767 Then Result.AccelerationX = Result.AccelerationX - 65534

	'Acceleration-Y (Most Significant Byte first) - Bytes 9 and 10, -32767 ... 32767
	Result.AccelerationY = BytesToInt(data(9), data(10))
	If Result.AccelerationY > 32767 Then Result.AccelerationY = Result.AccelerationY - 65534

	'Acceleration-Z (Most Significant Byte first) - Bytes 11 and 12, -32767 ... 32767
	Result.AccelerationZ = BytesToInt(data(11), data(12))
	If Result.AccelerationZ > 32767 Then Result.AccelerationZ = Result.AccelerationZ - 65534

	'Battery V - Bytes 13 and 14
	'Power info (11+5bit unsigned), first 11 bits is the battery voltage above 1.6V, in millivolts (1.6V to 3.646V range). 
	'Last 5 bits unsigned are the TX power above -40dBm, in 2dBm steps. (-40dBm to +20dBm range)
	Dim bits As String = $"${ByteToBinaryString(data(13))}${ByteToBinaryString(data(14))}"$
	Result.BatteryVoltage = (Bit.ParseInt(bits.SubString2(0, 11), 2) * 0.001) +  1.6
	Result.BatteryPct = 0
	If Result.BatteryVoltage > 0 Then
		Result.BatteryPct = Round(( (Result.BatteryVoltage - BAT_Min_VOLTAGE) / (BAT_MAX_VOLTAGE - BAT_Min_VOLTAGE)) * 100)
	End If
	
	'Movement Counter - Byte 15, 0 ... 254 (8 bit unsigned), incremented by motion detection interrupts from accelerometer
	Result.MovementCounter = data(15)

	'Measurement Sequence Number - Bytes 16 and 17, 0 ... 65534 (16 bit unsigned)
	'Each time a measurement is taken, this is incremented by one, used for measurement de-duplication. Depending on the transmit interval, multiple packets with the same measurements can be sent, and there may be measurements that never were sent.
	hex = payload.SubString2(32, 36)
	Result.MeasurementSequence = Bit.ParseInt(hex, 16)
	
	' Log($"[RuuviTagParser.GetAdvData] ${Result}"$)
	Return Result
End Sub
#End Region

#Region LogData
' ================================================================
' LOG REQUEST
' ================================================================

' SetLogRequestData
' Dataformat
' Byte 0:	Destination = Data Endpoint Identifier (0x30,0x31,0x32,0x3A)
' Byte 1: 	Source = Data Endpoint Identifier (0x30,0x31,0x32,0x3A)
' Byte 2: 	Type = Central Or Peripheral data: 0x11=Central, 0x11=Peripheral
' Example:	Header 0x3A3A11 - All sensors
' Byte 3-6: 	TimeStamp start (now) 4 Bytes
' Byte 7-10: TimeStamp previous 4 Bytes
' Example: payload 3A 3A 11 632ACA3A 632AC332
' 632ACA3A - 1663748666 - Wed Sep 21 2022 08:24:26 GMT+0000
' 632AC332 - 1663746866 - Wed Sep 21 2022 07:54:26 GMT+0000

' Request log data by default for all sensors (0x3A).
' logseconds - Timeframe in seconds from actual time. 0 = request all log entries.
' But can be changed if required (see doc https://docs.ruuvi.com/communication/bluetooth-connection/nordic-uart-service-nus/log-read)
' The request response is handled by the BLE Manager_DataAvailable by checking first byte holding the dataformat 0x3A.
' BLE Manager_DataAvailable: dataformat=3A, payload=3A3A11632ACA3A632AC332.
Public Sub SetLogRequestData(logseconds As Long) As Byte()
	'Build request data header - IMPORTANT: the dates must be in Int (4 Bytes). The DateUtils library method TicksToUnixTime is used.
	Dim tnow As Int	= DateUtils.TicksToUnixTime(DateTime.Now).As(Int)
	Dim tprev As Int = tnow - logseconds
	't=1663668984, hexnow=632992F8, hexprev=632990A0
	'Log($"t=${tnow}, hexnow=${bc.HexFromBytes(bc.IntsToBytes(Array As Int(tnow)))}, hexprev=${bc.HexFromBytes(bc.IntsToBytes(Array As Int(tprev)))}"$)
	'Convert the dates as int into 4 bytes array
	Dim tnowbytes() As Byte		= bc.IntsToBytes(Array As Int(tnow))
	Dim tprevbytes() As Byte	= bc.IntsToBytes(Array As Int(tprev))
	If logseconds == 0 Then
		tprevbytes = Array As Byte(0,0,0,0)
	End If
	'Define the request as byte array.
	Dim requestdata() As Byte = Array As Byte(DATA_POINT_ALL_SENSORS,DATA_POINT_ALL_SENSORS,0x11,tnowbytes(0),tnowbytes(1),tnowbytes(2),tnowbytes(3),tprevbytes(0),tprevbytes(1),tprevbytes(2),tprevbytes(3))
	'SetLogRequest: logseconds=1800, requestdata=3A3A11632ACA3A632AC332
	'Log($"SetLogRequest: logseconds=${logseconds}, requestdata=${bc.HexFromBytes(requestdata)}"$)
	Return requestdata
End Sub

' History Data LOG
' Convert the payload from the request returned by the TX characteristics (6e400003-b5a3-f393-e0a9-e50e24dcca9e)
' The first byte holds the data format from the request, i.e. 3A for all sensors.
' Byte 1:	Data endpoint required to select & assign the data. 0x30=Temperature, 0x31=Humidity, 0x32=AirPressure, 0x33=All environmental values, 0x20=Battery voltage
' Byte 2:	0x10 = device peripheral, 0x11 = device central.
' Byte 3-6:	Iimestamp in ticks (unix time in seconds, 4 bytes, integer).
' Byte 7-10:	Temperature  [0,01 °C] or humidity [0,01 %RH] or air pressure [1 Pa].
' NOTE: End of log data has a special payload 0xFFFFFFFFFFFFFFFF and a map is returned "ticks":0
Public Sub GetLogData(data() As Byte) As Map
	Dim Result As Map
	Dim bc As ByteConverter
	Dim t,h,p As Double
	Dim tsticks As Long
	Dim ts As String

	' Log($"GetLogData: ${bc.HexFromBytes(data)}"$)

	Result.Initialize
	Result = CreateMap("ticks":0)

	'Check the data array size
	If data.length <> 11 Then
		LastErrorMessage = $"[ERROR] Log data has wrong data size ${data.length} (must be 11)."$
		Log($"${LastErrorMessage}"$)
		Return Result
	End If
	'Check if end of output received and do nothing. Returns an empty map.
	If bc.HexFromBytes(data).Contains(DATA_END_OF_OUTPUT) Then
		' Log($"GetLogData: END OF OUTPUT"$)
		Return Result
	End If

	'Byte 1: Datapoint required to select & assign the data
	Dim datapoint As Byte = data(1)

	'Byte 3-6: Timestamp in ticks (unix time in seconds) und string
	tsticks = BytesToLong(data(3),data(4),data(5),data(6))
	Dim unixtimeticks As Long = DateUtils.UnixTimeToTicks(tsticks)
	ts = DateTime.Date(unixtimeticks) & " " & DateTime.Time(unixtimeticks)
	'Log($"GetLogData: tsticks=${tsticks}, ts=${ts}, hex=${bc.HexFromBytes(data)}, data3456=${bc.HexFromBytes(Array As Byte(data(3)))}${bc.HexFromBytes(Array As Byte(data(4)))}${bc.HexFromBytes(Array As Byte(data(5)))}${bc.HexFromBytes(Array As Byte(data(6)))}"$)

	'Byte 7-10: T, H or P
	'Temperature [0,01 °C]
	If (datapoint = DATA_POINT_TEMPERATURE) Then
		t = BytesToLong(data(7),data(8),data(9),data(10)) * 0.01
		Result = CreateMap("ticks":tsticks, "ts":ts, "t":t)
	End If
	'Humidity [0,01 %RH]
	If (datapoint = DATA_POINT_HUMIDITY) Then
		h = BytesToLong(data(7),data(8),data(9),data(10)) * 0.01
		Result = CreateMap("ticks":tsticks, "ts":ts, "h":h)
	End If
	'Air pressure [1 Pa]
	If (datapoint = DATA_POINT_AIR_PRESSURE) Then
		p = BytesToLong(data(7),data(8),data(9),data(10))
		Result = CreateMap("ticks":tsticks, "ts":ts, "p":p)
	End If
	'Special case - NOT USED
	If (datapoint = DATA_POINT_ALL_SENSORS) Then
	End If
	'Log(Result)
	Return Result
End Sub
#End Region

#Region ParseAdvData
' ================================================================
' ParseAdvData
' ================================================================

' ParseAdvData
' Parse the advertised data from the BLE device RuuviTag.
' Example Full Payload Advertised:
' 0201061BFF9904050E7050EAC5500044001803FCB4B60601A4F76FD827B78D11079ECADC240EE5A9E093F3A3B50100406E0B095275757669204237384400
' Manufacturer Data starts after 0xFF9904 and has 18 bytes:
' 050E7050EAC5500044001803FCB4B60
' Parsed by sub GetAdvData
Public Sub ParseAdvData(payload() As Byte) As TRuuviTagAdvData
	Dim Result As TRuuviTagAdvData

	' The data must start at 0x05 after 0xFF9904.
	' FF =Manufacturer Specific Data
	' 99 04 = Ruuvi Innovations Company ID (0x0499, little-endian)
	' 05 = Data Format = RAW v5
	Dim rawdata() As Byte = ExtractRuuviRaw(payload)

	'Dataformat first byte
	Dim dataformat As Byte = rawdata(0)
	Log($"[ParseRuuviTag] dataformat=${rawdata(0)}, payload=${HMITileUtils.ByteConv.HexFromBytes(rawdata)}"$)
	
	'Select dataformat ADV = Advertising
	' Note: NOT USED LOG = Log data requested via BLERequestLogData
	Select dataformat
		Case DATA_FORMAT_ADV
			Result = GetAdvData(rawdata)
			' Log($"[ParseRuuviTag] Adv=${Result}"$)

'		Case RuuviTag.DATA_FORMAT_LOG
'			'Example: "ticks":tsticks, "ts":ts, "t":t, "h":h, "p":p
'			Dim data As Map = RuuviTag.GetLogData(payload)
'			'Check if not end of output then add logdata
'			If data.Get("ticks") > 0 Then
'				TileEventViewerLog.Insert($"[ParseRuuviTag] Log=${data}"$, HMITileUtils.EVENT_LEVEL_INFO)
'			Else
'				'End of output
'				Wait For(UpdateLogData) Complete (result As Boolean)
'				TileEventViewerLog.Insert($"[ParseRuuviTag] Read data completed"$, HMITileUtils.EVENT_LEVEL_INFO)
'			End If
	End Select
	Return Result
End Sub

Public Sub ExtractRuuviRaw(payload() As Byte) As Byte()
	Log("[ExtractRuuviRaw] payload=" & HMITileUtils.ByteConv.HexFromBytes(payload))

	Dim i As Int

	' stop at Length-4 because we read i..i+3
	For i = 0 To payload.Length - 4
		
		If ByteToUnsigned(payload(i)) == 0xFF Then
			If ByteToUnsigned(payload(i + 1)) == 0x99 Then
				If ByteToUnsigned(payload(i + 2)) == 0x04 Then
					If ByteToUnsigned(payload(i + 3)) == 0x05 Then
						' Found FF 99 04 05
						Dim start As Int = i + 3
						Dim outLen As Int = DATA_LEN_V5	' payload.Length - start

						Dim raw(outLen) As Byte
						HMITileUtils.ByteConv.arraycopy(payload, start, raw, 0, outLen)

						Log("[ExtractRuuviRaw] raw=" & HMITileUtils.ByteConv.HexFromBytes(raw))
						Return raw
					End If
				End If
			End If
		End If

	Next
	Return Null
End Sub
#End Region

#Region HELPERS
' ================================================================
' Helpers
' ================================================================

'Utility to convert short UUIDs to long format on Android
'NOT USED for RuuviTag as different Service & Characteristics UUIDs.
Private Sub BLESetUUID(id As String) As String	'ignore
	Return "0000" & id.ToLowerCase & "-0000-1000-8000-00805f9b34fb"
End Sub

Public Sub ByteToUnsigned(b As Byte) As Int
	Return Bit.And(0xFF, b)
End Sub

'Convert byte and return as int
Private Sub ByteToInt(b1 As Byte) As Int	'ignore
	Dim b1i As Int = Bit.ParseInt(bc.HexFromBytes(Array As Byte(b1)), 16)
	'Log(b1i)
	Return b1i
End Sub

'Convert two bytes and return as int
Private Sub BytesToInt(b1 As Byte, b2 As Byte) As Int	'ignore
	Dim hex As String = $"${bc.HexFromBytes(Array As Byte(b1))}${bc.HexFromBytes(Array As Byte(b2))}"$
	Return Bit.ParseInt(hex, 16)
End Sub

'Convert four bytes return as long
Private Sub BytesToLong(b1 As Byte, b2 As Byte, b3 As Byte, b4 As Byte) As Long	'ignore
	Dim hex As String = $"${bc.HexFromBytes(Array As Byte(b1))}${bc.HexFromBytes(Array As Byte(b2))}${bc.HexFromBytes(Array As Byte(b3))}${bc.HexFromBytes(Array As Byte(b4))}"$
	Return Bit.ParseLong(hex, 16)
End Sub

'Convert a Byte to its Binary string
Private Sub ByteToBinaryString(b As Byte) As String
	Dim bc As ByteConverter
	Dim hex As String = bc.HexFromBytes(Array As Byte(b))
	Dim binarystring As String = Bit.ToBinaryString(Bit.ParseInt(hex, 16))
	Dim sb As StringBuilder
	sb.Initialize
	For i = binarystring.Length - 8 To binarystring.Length - 1
		If i < 0 Then
			sb.Append("0")
		Else
			sb.Append(binarystring.CharAt(i))
		End If
	Next
	Return sb.ToString
End Sub
#End Region

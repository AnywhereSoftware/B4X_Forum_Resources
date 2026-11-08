B4R=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=4
@EndOfDesignText@
'==============================================
' Project:		rNimBLEScanner
' File:			BleAdvParser.bas
' Brief:		Code module to parse selective device data
' Date: 		2026-03-27
' Author:      	Robert W.B. Linn (c) 2026 MIT
' Description:	...
' DependsOn:	rNimBLEScanner, rConvert
' Hardware:		ESP32
' Wiring:		None
' Log:
'==============================================

Private Sub Process_Globals
	' Devices tested with 16-bit Company IDs (As Int)
	Public Const ID_GOVEE_EC88      	As Int = 0xEC88	' Bytes: 88 EC	(Device GVH5075)
	Public Const ID_GOVEE_0001      	As Int = 0x0001	' Bytes: 01 00	(Device GV5108)
	Public Const ID_RUUVI_0499   		As Int = 0x0499	' Bytes: 99 04	(Device RuuviTag)
	Public Const ID_ATC1441_74C2    	As Int = 0x74C2	' Bytes: C2 74	(Device ATC1441 Firmware specific for older versions)
	Public Const ID_ATC1441_3058		As Int = 0x3058	' Bytes: 30 58	(Device ATC1441 Firmware specific for newer versions)
	
	' Example using structure
	Type TGovee (Temperature As Float, Humidity As Float, Battery As Int)
	Public GoveeData As TGovee
End Sub

' Parse
' Parse the data.
Public Sub Parse(Mac() As Byte, Data() As Byte) As Boolean
	Dim result As Boolean = False
	
	If Data.Length < 2 Then Return result
    
	' Company ID extract (Little Endian so reverse bytes)
	Dim CompanyID As Int = Bit.Or(Bit.ShiftLeft(Data(1), 8), Data(0))
    
	' Select and parse
	Select CompanyID
		Case ID_GOVEE_EC88
			result = ParseGVH5075(Data)

		Case ID_GOVEE_0001
			result = ParseGV5108(Data)
			
		Case ID_RUUVI_0499
			result = ParseRuuviTag(Data)

		Case ID_ATC1441_74C2
			result = ParseATC1441(Data)

		Case ID_ATC1441_3058
			result = ParseATC1441(Data)
	End Select
	Return result
End Sub

'==============================================
' GVH5075 
'==============================================

' GVH5075 parse raw data hex string as byte array.
' Data example:		88 EC 00 03 85 49 49 00
'					0  1  2  3  4  5  6  7  
' Data length:		8 bytes without MAC
' Byte 0-1 (2):		Manufacturer Key EC88 as little endian
' Byte 2-7 (6):		Sensor data 00 03 85 49 49 00
' Sensor Data Calculation
' Byte 2-5 (4):	The temp+hum are calculated from the first 4 bytes:
'					The data bytes 0-4 = HEX 00 03 85 49 > DEC 230729
'					temperature = 230729 / 10000 = 23.1 °C (Round, 1)
'					humidity    = 230729 % 1000 = 729 / 10 = 72.9 %RH
' Byte 6 (1):		battery     = data byte 5 = 49 > DEC 49%
'
' Verified Test Logs:
' [BleAdvParser.ParseGVH5075][I] Data=88EC000273505600
' [BleAdvParser.ParseGVH5075][I] t=16.0592,h=59.2000,b=86
Public Sub ParseGVH5075(data() As Byte) As Boolean
    ' Expected: 88 EC [00 03 85 49] 49 00
	' Index:    0  1  2  3  4  5  6  7
	Log("[BleAdvParser.ParseGVH5075][I] data=", Convert.BytesToHex(data))
    
    If data.Length < 8 Then 
		Log("[BleAdvParser.ParseGVH5075][E] Invalid data length: ",  data.Length, " expect ", 8)
		Return False
	End If

    ' We need to combine data(2) to data(5) into one 32-bit value.
    ' We use Bit.or(..., NN) to ensure the byte is treated as unsigned 
    ' before shifting, preventing B4R sign-extension bugs.
    
	Dim raw As Long = 0
	raw = Bit.Or(Bit.ShiftLeft(data(2), 24), _
          Bit.Or(Bit.ShiftLeft(data(3), 16), _
          Bit.Or(Bit.ShiftLeft(data(4), 8), data(5))))

    ' Calculation per Govee spec
    GoveeData.Temperature = raw / 10000
    GoveeData.Humidity = (raw Mod 1000) / 10
	GoveeData.Battery = data(6)
	Log("[BleAdvParser.ParseGVH5075][I] t=", GoveeData.temperature, ",h=",GoveeData.humidity,",b=",GoveeData.battery)
    
	Return True
End Sub

'==============================================
' GV5108
'==============================================

' GV5108 parse raw data hex string as byte array.
' Data Example:      01 00 01 01 82 BD 90 5F 00 00
'                    0  1  2  3  4  5  6  7  8  9
' Data Length:       10 bytes
' Byte 0-3 (4):      Product / Protocol ID (01 00 01 01)
' Byte 4-7 (4):      Sensor Data Block (e.g., 82 BD 90 5F)
' 
' Sensor Data Calculation (Bytes 4-7)
' ------------------------------------------------------------------------------
' Byte 4-6 (3):      Combined value for Temp + Hum (Big Endian)
'                    Example HEX: 82 BD 90 -> DEC 8,568,208
'
'                    1. Sign Check (Bit 23 / 0x800000):
'                       If DEC >= 8,388,608 -> Temperature is NEGATIVE.
'                       Formula: (8,568,208 - 8,388,608) / 10000 = 17.96
'                       Result: -17.96 °C
'
'                    2. Humidity (Modulo 1000 of the raw combined value):
'                       Formula: 8,568,208 % 1000 = 208
'                       Result: 208 / 10 = 20.8 %RH
'
' Byte 7 (1):        Battery level (Hex 5F -> DEC 95%)
' Byte 8-9 (2):      Reserved / Padding (00 00)
'
' Verified Test Logs:
' Positive: [BleAdvParser.ParseGV5108][I] data=0100010102F4405F0000 -> t=19.36, h=60.0, b=95
' Negative: [BleAdvParser.ParseGV5108][I] data=0100010182BD905F0000 -> t=-17.96, h=20.8, b=95
' ==============================================================================
Public Sub ParseGV5108(data() As Byte) As Boolean
	Log("[BleAdvParser.ParseGV5108][I] data=", Convert.BytesToHex(data))

	' Check packert length
	If data.Length < 8 Then 
		Log("[BleAdvParser.ParseGV5108][E] Invalid data length: ",  data.Length, " expect ", 8)
		Return False
	End If

	' Govee 3-Byte-combination (Bytes 4, 5, 6)
	' 0x02E888 = 190600
	Dim b1 As Long = Bit.And(data(4), 0xFF)
	Dim b2 As Long = Bit.And(data(5), 0xFF)
	Dim b3 As Long = Bit.And(data(6), 0xFF)

	Dim combined As Long = Bit.Or(Bit.ShiftLeft(b1, 16), Bit.Or(Bit.ShiftLeft(b2, 8), b3))

	' Correction for neg. temperatures (Bit 23 is sign)
	' 0x800000 = 8388608
	If combined >= 8388608 Then
		' Value neg: Remove flag and multiply with -1
		Dim absoluteValue As Long = combined - 8388608
		GoveeData.Temperature = (absoluteValue / 10000.0) * -1
	Else
		' Value pos
		GoveeData.Temperature = combined / 10000.0
	End If

	' Humidiy remains as it (always last 3 digits of aboslute value)
	GoveeData.Humidity = (combined Mod 1000) / 10.0
    
	' Battery often Byte 7 (0x5F = 95%)
	GoveeData.Battery = Bit.And(data(7), 0xFF)

	Log("[BleAdvParser.ParseGV5108][I] t=", GoveeData.temperature, ", h=", GoveeData.humidity, ", b=", GoveeData.battery)
    
	Return True
End Sub

'==============================================
' ParseRuuviTag (Data Format 5)
'==============================================

' RuuviTag V5 parse raw advertising data (RAWv2)
' Data Example (hex): 	F7 6F D8 27 B7 8D 99 04 05 10 DE 75 D8 C8 0C 00 58 00 98 04 0C B9 F6 04 01 51 F7 6F D8 27 B7 8D
' 						0  1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
' Payload:				0  1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18 19 20 21 22 23
' Data Length: 			>= 26 bytes required
' Ruuvi RAWv2 Format:
' Byte 0-5 (6):			MAC address (repeated later)
' Byte 6-7 (2):   		0x04 = manufacturer-specific data
' Byte 8-31 (23):		Actual payload
' Payload breakdown:
' Byte 8 (1):   		Ruuvi RAWv2 Format ID (0x05)
' Byte 9-10 (2):   		Temperature (int16_t), 0.005 °C/LSB, big-endian
' Byte 11-12 (2): 		Humidity (uint16_t), 0.0025 %RH/LSB, big-endian
' Byte 13-14 (2): 		Pressure (uint16_t), value + 50,000 Pa
' Byte 15-16 (2): 		Acceleration X (int16_t), milli-g
' Byte 17-18 (2): 		Acceleration Y (int16_t), milli-g
' Byte 19-20 (2): 		Acceleration Z (int16_t), milli-g
' Byte 21-22 (2):     	Power info: upper 5 bits = battery (in 10 mV), lower 3 bits = TX power
' Byte 23 (1):     		Movement counter
' Byte 24-25 (2):  		Sequence number
' Byte 26-31:  			MAC address 48bit (6 bytes)
'
' Verified Test Logs:
' [BleAdvParser.ParseRuuviTag][I] data=9904050E2F54A9C8D30054002C0404B1960C005AF76FD827B78D
' [BleAdvParser.ParseRuuviTag][I] T=18.1550 H=54.1825 P=1014.1100
Public Sub ParseRuuviTag(data() As Byte) As Boolean
	Log("[BleAdvParser.ParseRuuviTag][I] data=", Convert.BytesToHex(data))
	' Ruuvi ID: 99 04
	' Data Format 5 starts at Index 2
	If data.Length < 20 Or data(2) <> 0x05 Then
		Log("[BleAdvParser.ParseRuuviTag][E] Wrong data format")
		Return False
	End If
    
	' Temperature: 16-bit signed (Index 3,4) - 0.005°C units
	Dim tRaw As Int = Bit.Or(Bit.ShiftLeft(data(3), 8), data(4))
	Dim temp As Float = tRaw * 0.005
    
	' Humidity: 16-bit unsigned (Index 5,6) - 0.0025% units
	Dim hRaw As Int = Bit.Or(Bit.ShiftLeft(Bit.And(data(5),0xFF), 8), Bit.And(data(6),0xFF))
	Dim hum As Float = hRaw * 0.0025
    
	' Pressure: 16-bit unsigned (Index 7,8) + 50000 Pa
	'Dim pRaw As Int = Bit.Or(Bit.ShiftLeft(Bit.And(data(7),0xFF), 8), Bit.And(data(8),0xFF))
	'Dim pres As Float = (pRaw + 50000) / 100.0 ' hPa

	' 3. Pressure: 16-bit unsigned (Index 7,8) + 50000 Pa
	' Your data: 96 C8 -> 38600 + 50000 = 88600 Pa
	Dim pRaw As Int = Bit.Or(Bit.ShiftLeft(Bit.And(data(7), 0xFF), 8), Bit.And(data(8), 0xFF))
	Dim presPa As Long = Bit.And(pRaw, 0xFFFF) + 50000
	Dim pres As Float = presPa / 100.0

	Log("[BleAdvParser.ParseRuuviTag][I] T=", temp, " H=", hum, " P=", pres)
	Return True
End Sub

'==============================================
' ParseATC1441
'==============================================

' Xiaomi Mi TempHum Monitor with ATC1441 firmware
' Data example:		C2 74 52 38 C1 A4 1E 06 5E 16 AF 0B 64 37 0E
'					 0  1  2  3  4  5  6  7  8  9 10 11 12 13 14
' Data length:		15
' Byte 0-5 (6):		MAC (reversed)
' Byte 6-7 (2):		Temperature (int16 LE, /100)
' Byte 8-9 (2): 	Humidity (uint16 LE, /100)
' Byte 10-11 (2):	Battery voltage (uint16 LE)
' byte 12 (1):	   	Battery %
' Byte 13 (1):	   	Packet counter
' Byte 14 (1):		Flags
'
' Verified Test Logs:
' [BleAdvParser.ParseATC1441][I] data=C2745238C1A41E065E16AF0B64370E
' [BleAdvParser.ParseATC1441][I] t=15.66 h=57.26% b=100% (2991mV) cnt=55
Public Sub ParseATC1441(Data() As Byte) As Boolean
	Log("[BleAdvParser.ParseATC1441][I] data=", Convert.BytesToHex(Data))
	If Data.Length < 15 Then
		Log("[BleAdvParser.ParseATC1441][E] Incorrect data length ", Data.Length, " expect 15")
		Return False
	End If

	' temperature (0.01 °C)
	Dim tRaw As Int = Bit.Or(Bit.ShiftLeft(Data(7),8), Bit.And(Data(6),0xFF))
	Dim temp As Float = tRaw / 100.0

	' humidity (0.01 %)
	Dim hRaw As Int = Bit.Or(Bit.ShiftLeft(Data(9),8), Bit.And(Data(8),0xFF))
	Dim hum As Float = hRaw / 100.0

	' battery voltage
	Dim vRaw As Int = Bit.Or(Bit.ShiftLeft(Data(11),8), Bit.And(Data(10),0xFF))

	' battery percent
	Dim batt As Int = Bit.And(Data(12),0xFF)

	' packet counter
	Dim cnt As Int = Bit.And(Data(13),0xFF)

	Log("[BleAdvParser.ParseATC1441][I]", _
		" t=", NumberFormat(temp,1,2), _
        " h=", NumberFormat(hum,1,2), "%", _
        " b=", batt, "% (", vRaw, "mV)", _
        " cnt=", cnt)

	Return True
End Sub

B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=10.3
@EndOfDesignText@
#Region Code Module Header
' ================================================================
' File: 	Convert.bas
' Brief:	Conversion routines
' Date:		2025-12-01
' Author:	Robert W.B. Linn (c) 2025 MIT
' ================================================================
#End Region

Sub Process_Globals
	Public ByteConv As ByteConverter
End Sub

' =================================================================
' Conversion Helpers
' =================================================================

'----------------------------------------------
' BytesToInt
' Converts a 2-byte array (little-endian) to an unsigned 16-bit integer (ULong).
'----------------------------------------------
Public Sub BytesToInt(b() As Byte) As Long
	If b == Null Or b.Length <> 2 Then Return 0
	Return Bit.Or(Bit.And(b(0), 0xFF), Bit.ShiftLeft(Bit.And(b(1), 0xFF), 8))
End Sub

' ------------------------------------------------------------
' IntFromBytes
'
' Converts 2 bytes into a signed Int (respecting endian layout).
'
' Parameters:
'   b1  - First byte
'   b2  - Second byte
'
' Returns:
'   Int - Combined value (0–65535)
' ------------------------------------------------------------
Public Sub IntFromBytes(b1 As Byte, b2 As Byte) As Int
	Dim hex As String = ByteConv.HexFromBytes(Array As Byte(b1, b2))
	Return Bit.ParseInt(hex, 16)
End Sub

' ------------------------------------------------------------
' IntToByte
'
' Converts an Int value (0–255) to a single byte.
'
' Parameters:
'   value - Integer in range 0–255
'
' Returns:
'   Byte - Converted byte (0 if out of range)
' ------------------------------------------------------------
Public Sub IntToByte(value As Int) As Byte
	If value >= 0 And value <= 255 Then
		Return value
	End If
	Log($"[HKUtils.IntToByte] int out of range (0–255): ${value}. Using 0."$)
	Return 0
End Sub

' ------------------------------------------------------------
' ByteToHex
'
' Converts a single byte to a two-character HEX string.
' Parameters:
'   b - Byte to convert
' Returns:
'   String - HEX representation, e.g., "0A"
' ------------------------------------------------------------
Public Sub ByteToHex(b As Byte) As String
	Return ByteConv.HexFromBytes(Array As Byte(b))
End Sub

Public Sub HexFromBytes(b() As Byte) As String
	Return ByteConv.HexFromBytes(b)
End Sub

'----------------------------------------------
' ByteToBool
' Converts a single byte to boolean.
' Parameters:
'   b - Byte to convert
' Returns:
'   Boolean - Bool representation, e.g., True or False
'----------------------------------------------
Public Sub ByteToBool(b As Byte) As Boolean
	Return IIf(b == 1, True, False)
End Sub

'----------------------------------------------
' BoolToByte
' Converts a boolean to a single byte.
' Parameters:
'   b - Bool to convert
' Returns:
'   Boolean - Byte representation, e.g., 0 or 1
'----------------------------------------------
Public Sub BoolToByte(b As Boolean) As Byte
	Return IIf(b, 1, 0)
End Sub

'----------------------------------------------
' BoolToOnOff
' Converts bool to string ON or OFF.
' Parameters:
'   b - Boolean to convert
' Returns:
'   String - Bool representation, e.g., ON or OFF
'----------------------------------------------
Public Sub BoolToOnOff(b As Boolean) As String
	Return IIf(b, "ON", "OFF")
End Sub

' =================================================================
' Map Helpers
' =================================================================
#Region Map

' ------------------------------------------------------------
' PrintMap
'
' Logs all keys and values of a Map (for debugging).
'
' Parameters:
'   m - Map to inspect
' ------------------------------------------------------------
Public Sub PrintMap(m As Map)
	For Each key As String In m.Keys
		Log($"[HKUtils.PrintMap] key=${key}, value=${m.Get(key)}"$)
	Next
End Sub

' ------------------------------------------------------------
' BytesMapToString
'
' Creates a human-readable dump of a Map(Object → Byte()).
'
' Parameters:
'   map   - Map where values are byte arrays
'   title - Header title
'
' Returns:
'   String - Multi-line formatted result
' ------------------------------------------------------------
Public Sub BytesMapToString(map As Map, title As String) As String
	Dim sb As StringBuilder
	sb.Initialize

	If map.Size > 0 Then
		sb.Append(title).Append(CRLF)

		For Each key As Object In map.Keys
			Dim b() As Byte = map.Get(key)
			sb.Append($"${key}: ${BytesToString(b, 0, b.Length, "ASCII")}"$).Append(CRLF)
		Next
	End If

	Return sb.ToString
End Sub
#End Region

' ================================================================
' Converts int value to percentage
' Input:  int
' Output: percentage 0..100
' Example:
'	Dim maxvoltage As Int = 4095	' ESP32 or 1023 for Arduino
'	ValueToPercent(2300, 4095)
' ================================================================
Public Sub ValueToPercent(value As Int, maxvalue As Int) As Int
	' Map value to 0..100%
	Dim pct As Int
	pct = value * 100 / maxvalue
	If pct > 100 Then pct = 100
	If pct < 0 Then pct = 0

	Return pct
End Sub

' ================================================================
' Converts int value as 2 bytes to percentage
' Input:  2 bytes
' Output: percentage 0..100
' Example:
'	Dim maxvoltage As Int = 4095	' ESP32 or 1023 for Arduino
'	Dim b(2) as int = array as byte(0x01, 0x02)
'	ValueToPercent(b, 4095)
' ================================================================
Public Sub ValueToPercentFromBytes(b() As Byte, maxvalue As Int) As Int
	If b = Null Or b.Length <> 2 Then Return 0

	' Combine LSB + MSB
	Dim raw As Int
	raw = b(0) + b(1) * 256  ' or b(0) + Bit.ShiftLeft(b(1), 8) if needed

	' Map raw value to 0..100%
	Dim pct As Int
	pct = raw * 100 / maxvalue
	If pct > 100 Then pct = 100
	If pct < 0 Then pct = 0

	Return pct
End Sub

' =================================================================
' Selection
' =================================================================
#Region Selection
Public Sub IIIF(state As Byte, options() As String) As String
	If state < 0 Or state > options.Length - 1 Then
		Return Null
	End If
	Return options(state)
End Sub
#End Region


' =================================================================
' Parsing Helpers
' =================================================================
#Region Parse

' ------------------------------------------------------------
' ParseErrorMessage
'
' Extracts a clean error message from a standardized exception line.
' Expected input format example:
'   "(TimeoutError) - Method: BLE.PyBridge: Something went wrong"
' Parameters:
'	Raw String - Raw message
' Returns:
'   String - Extracted readable message
' ------------------------------------------------------------
Public Sub ParseErrorMessage(Raw As String) As String
	Dim m As Matcher = Regex.Matcher("\(([^)]+)\) - Method: [^.]+\.[^:]+:(.*)$", Raw)
	If m.Find Then
		Dim msg As String = m.Group(1)
		If m.Group(2).Trim <> "" Then msg = msg & " - " & m.Group(2)
		Return msg
	End If
	Return Raw
End Sub
#End Region

' ------------------------------
' Base64 encode/decode
' ------------------------------

' Encode a string to Base64
Public Sub EncodeBase64(Data As String) As String
	Dim jo As JavaObject
	jo.InitializeStatic("java.util.Base64")
	Dim encoder As JavaObject = jo.RunMethod("getEncoder", Null)
	Dim bytes() As Byte = Data.GetBytes("UTF8")
	Dim base64 As String = encoder.RunMethod("encodeToString", Array(bytes))
	Return base64
End Sub

' Decode a Base64 string
Public Sub DecodeBase64(Base64Text As String) As String
	Dim jo As JavaObject
	jo.InitializeStatic("java.util.Base64")
	Dim decoder As JavaObject = jo.RunMethod("getDecoder", Null)
	Dim bytes() As Byte = decoder.RunMethod("decode", Array(Base64Text))
	Return BytesToString(bytes, 0, bytes.Length, "UTF8")
End Sub

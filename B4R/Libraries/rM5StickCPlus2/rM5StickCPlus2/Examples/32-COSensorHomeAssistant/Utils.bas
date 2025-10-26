B4R=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=4
@EndOfDesignText@
#Region Code Module Info
' File:		Utils.bas
' Brief:	Utility constants & methods.
#End Region

' These global variables will be declared once when the application starts.
' Public variables can be accessed from all modules.
Sub Process_Globals
	' JSON Parser
	Private QUOTEARRAY() As Byte = """"
	Private LastIndex As Int = 0			'ignore

	' Byteconverter
	Private bc As ByteConverter	'ignore	
End Sub

' Convert first byte of MQTT payload ("0" or "1") to Boolean
Public Sub ByteToBool(Payload() As Byte) As Boolean
	Return IIf(Payload(0) == 49, True, False)
End Sub

' Convert first byte of MQTT payload ("0" to "9") to integer (0 to 9)
Public Sub ByteToInt(Payload() As Byte) As Int
	Return Payload(0) - Asc("0")
End Sub

' Convert boolean true to string "1", false to string "0"
Public Sub BoolToString(state As Boolean) As String
	If state Then
		Return "1"
	Else
		Return "0"
	End If
End Sub

' Convert boolean true to string "ON", false to "OFF"
Public Sub BoolToOnOff(state As Boolean) As String
	If state Then
		Return "ON"
	Else
		Return "OFF"
	End If
End Sub

' Convert string ON or OFF to boolean true or false.
' The string must be in uppercase.
Public Sub OnOffToBool(value As String) As Boolean
	If value == "ON" Or value == "On" Or value == "on" Then Return True
	Return False
End Sub

' Convert direction given as byte to string
Public Sub DirectionToString(direction As Byte) As String
	Select direction
		Case 0: Return "RIGHT"
		Case 1: Return "LEFT"
		Case 2: Return "UP"
		Case 3: Return "DOWN"
		Case Else
			Return ""
	End Select
End Sub

' Convert bytes to string
Public Sub BytesToString(bytes() As Byte) As String
	Return bc.StringFromBytes(bytes)
End Sub

'Dim rawValue As String = bc.StringFromBytes(buffer)
'Dim trimmedValue As String = StringTrim(rawValue)
'Dim state As Boolean = Utils.OnOffToBool(trimmedValue)
Public Sub StringTrim(s As String) As String
	Dim b() As Byte = s.GetBytes
	Dim startIndex As Int = 0
	Dim endIndex As Int = b.Length - 1

	Do While startIndex <= endIndex And (b(startIndex) = 32 Or b(startIndex) = 9)
		startIndex = startIndex + 1
	Loop

	Do While endIndex >= startIndex And (b(endIndex) = 32 Or b(endIndex) = 9)
		endIndex = endIndex - 1
	Loop

	If startIndex > endIndex Then Return ""

	Dim trimmedLength As Int = endIndex - startIndex + 1
	Dim result(trimmedLength) As Byte
	For i = 0 To trimmedLength - 1
		result(i) = b(startIndex + i)
	Next
	Return bc.StringFromBytes(result)
End Sub

'Dim txt As String = "Esp32_Ready"
'Log("UPPER: ", ToUpperCase(txt))  ' ESP32_READY
'Log("lower: ", ToLowerCase(txt))  ' esp32_ready

Public Sub ToUpperCase(s As String) As String
	Dim b() As Byte = s.GetBytes
	For i = 0 To b.Length - 1
		If b(i) >= Asc("a") And b(i) <= Asc("z") Then
			b(i) = b(i) - 32
		End If
	Next
	Return bc.StringFromBytes(b)
End Sub

Public Sub ToLowerCase(s As String) As String
	Dim b() As Byte = s.GetBytes
	For i = 0 To b.Length - 1
		If b(i) >= Asc("A") And b(i) <= Asc("Z") Then
			b(i) = b(i) + 32
		End If
	Next
	Return bc.StringFromBytes(b)
End Sub


'If EqualsIgnoreCase(bc.StringFromBytes(buffer), "on") Then
'    state = True
'Else If EqualsIgnoreCase(bc.StringFromBytes(buffer), "off") Then
'    state = False
'Else
'    state = LightStateLast ' fallback
'End If
Public Sub EqualsIgnoreCase(s1 As String, s2 As String) As Boolean
	Dim b1() As Byte = s1.GetBytes
	Dim b2() As Byte = s2.GetBytes
	If b1.Length <> b2.Length Then Return False

	For i = 0 To b1.Length - 1
		Dim c1 As Byte = b1(i)
		Dim c2 As Byte = b2(i)

		If c1 >= 65 And c1 <= 90 Then c1 = c1 + 32 ' A-Z to a-z
		If c2 >= 65 And c2 <= 90 Then c2 = c2 + 32

		If c1 <> c2 Then Return False
	Next

	Return True
End Sub

' ReplaceString
' CREDIT: https://www.b4x.com/android/forum/threads/strings-and-bytes.66729/#post-435001
Public Sub ReplaceString(Original() As Byte, SearchFor() As Byte, ReplaceWith() As Byte) As Byte()
	' Count number of occurrences
	Dim bc2 As ByteConverter
	Dim c As Int = 0
	Dim i As Int
	If SearchFor.Length <> ReplaceWith.Length Then
		i = bc2.IndexOf(Original, SearchFor)
		Do While i > -1
			c = c + 1
			i = bc2.IndexOf2(Original, SearchFor, i + SearchFor.Length)
		Loop
	End If
	Dim result(Original.Length + c * (ReplaceWith.Length - SearchFor.Length)) As Byte
	Dim prevIndex As Int = 0
	Dim targetIndex As Int = 0
	i = bc2.IndexOf(Original, SearchFor)
	Do While i > -1
		bc2.ArrayCopy2(Original, prevIndex, result, targetIndex, i - prevIndex)
		targetIndex = targetIndex + i - prevIndex
		bc2.ArrayCopy2(ReplaceWith, 0, result, targetIndex, ReplaceWith.Length)
		targetIndex = targetIndex + ReplaceWith.Length
		prevIndex = i + SearchFor.Length
		i = bc2.IndexOf2(Original, SearchFor, prevIndex)
	Loop
	If prevIndex < Original.Length Then
		bc2.ArrayCopy2(Original, prevIndex, result, targetIndex, Original.Length - prevIndex)
	End If
	Return result
End Sub

#Region JSON

' JSON Get Text Value from Key.
' Note: Can not handle if the text is not enclosed between "".
' Returns array as Byte.
Public Sub GetTextFromKey (json() As Byte, jsonkey() As Byte) As Byte()
	Dim MAXSIZE As Int = 20
	Dim buffer(MAXSIZE) As Byte
	
	GetTextValueFromKey(json, jsonkey, 0, buffer, MAXSIZE)
	' Log("[GetValueFromKey] jsonkey=",jsonkey,",buffer=", buffer)
	Return buffer
End Sub

' JSON Get Number Value from Key.
' Note: Can not handle if the value in enclosed between "". 
' Return double.
Public Sub GetNumberFromKey (json() As Byte, jsonkey() As Byte) As Double
	Return GetNumberValueFromKey(json, jsonkey, 0)
End Sub

' JSON Get Text Value from Key   
' Dim MaxSize As Int = 20
' Dim buffer(MaxSize) As Byte
' GetTextValueFromKey(jsontext, "get_status", 0, buffer, MaxSize)
Private Sub GetTextValueFromKey (json() As Byte, Key() As Byte, StartIndex As Int, ResultBuffer() As Byte, MaxLength As UInt)	'ignore
   Dim qkey() As Byte = JoinBytes(Array(QUOTEARRAY, Key, QUOTEARRAY))
   Dim i As Int = bc.IndexOf2(json, qkey, StartIndex)
   If i = -1 Then
       bc.ArrayCopy(Array As Byte(), ResultBuffer)
       Return
   End If
   Dim i1 As Int = bc.IndexOf2(json, QUOTEARRAY, i + qkey.Length + 1)
   Dim i2 As Int = bc.IndexOf2(json, QUOTEARRAY, i1 + 1)
   bc.ArrayCopy(bc.SubString2(json, i1 + 1, Min(i2, i1 + 1 + MaxLength)), ResultBuffer)
   LastIndex = i2
End Sub

' JSON Get Number Value from Key. If key not found, -1 is returned.
' Dim MaxSize As Int = 20
' Dim buffer(MaxSize) As Byte
' Log(GetNumberValueFromKey(jsontext, "value", 0))
' Log(GetNumberValueFromKey(jsontext, "value", LastIndex)) 'second value
Private Sub GetNumberValueFromKey (json() As Byte, Key() As Byte, StartIndex As Int) As Double	'ignore
   Dim qkey() As Byte = JoinBytes(Array(QUOTEARRAY, Key, QUOTEARRAY))
   Dim i As Int = bc.IndexOf2(json, qkey, StartIndex)
   If i = -1 Then Return -1
   Dim colon As Int = bc.IndexOf2(json, ":", i + qkey.Length)
   Dim i2 As Int = 0
   For Each c As String In Array As String(",", "}", "]")
       i2 = bc.IndexOf2(json, c, colon + 1)
       If i2 <> -1 Then
           Exit       
       End If
   Next
   Dim res() As Byte = bc.SubString2(json, colon + 1, i2)
   LastIndex = i2 + 1
   res = bc.Trim(res)
   Dim s As String = bc.StringFromBytes(res)
   Dim value As Double = s
   Return value
End Sub
#End Region

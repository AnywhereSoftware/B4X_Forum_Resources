B4R=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=4
@EndOfDesignText@
#Region Code Module Info
' File:		JSONUtils.bas
' Brief:	JSON utility constants & methods.
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

B4R=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=3.9
@EndOfDesignText@


Private Sub Process_Globals
	Private bc As ByteConverter

End Sub


Sub Encode(StringToURLEncode() As Byte, EncodedURL() As Byte) As String
	Dim buffer(StringToURLEncode.Length * 3) As Byte
	Dim length As Int = UrlEncode(StringToURLEncode, buffer)
	bc.ArrayCopy(bc.SubString2(buffer, 0, length), EncodedURL)
End Sub

Sub Decode(StringToURLDecode() As Byte, DecodedURL() As Byte) As String
	Dim buffer(StringToURLDecode.Length) As Byte
	Dim length As Int = UrlDecode(StringToURLDecode, buffer)
	bc.ArrayCopy(bc.SubString2(buffer, 0, length), DecodedURL)
End Sub


Private Sub UrlEncode (s() As Byte, Buffer() As Byte) As Int
	Dim index As Int = 0
	For i = 0 To s.Length - 1
		Dim c As Byte = s(i)
		
		If c = 32 Then
			Buffer(index) = Asc("+")
			index = index + 1
		Else if (c >= Asc("0") And c <= Asc("9")) Or (c >= Asc("A") And c <= Asc("Z")) Or (c >= Asc("a") And c <= Asc("z")) Then
			Buffer(index) = c
			index = index + 1
		Else
			Dim code1 As Byte = Bit.And(c, 0xf) + Asc("0")
			If Bit.And(c, 0xf) > 9 Then
				code1 = Bit.And(c, 0xf) - 10 + Asc("A")
			End If
			c = Bit.And(Bit.ShiftRight(c, 4), 0xf)
			Dim code0 As Byte = c + Asc("0")
			If c > 9 Then
				code0 = c - 10 + Asc("A")
			End If
			Buffer(index) = Asc("%")
			index = index + 1
			Buffer(index) = code0
			index = index + 1
			Buffer(index) = code1
			index = index + 1
		End If
	Next
	Return index
End Sub



Private Sub UrlDecode(s() As Byte, Buffer() As Byte) As Int

	Dim index As Int = 0
	
	For i = 0 To s.Length - 1
		
		Dim c As Byte = s(i)
		If c = Asc("+") Then
			Buffer(index) = Asc(" ")
			index = index + 1
		Else If c=Asc("%") Then
			i = i + 1
			Dim code0 As Byte = s(i)
			i = i + 1
			Dim code1 As Byte = s(i)
			
			If code0 >= Asc("0") And code0 <= Asc("9") Then
				code0 = code0 - Asc("0")
			else if code0 >= Asc("a") And code0 <= Asc("f") Then
				code0 = code0 - Asc("a") + 10
			else if code0 >= Asc("A") And code0 <= Asc("F") Then
				code0 = code0 - Asc("A") + 10		
			Else
				code0 = 0
			End If
			
			If code1 >= Asc("0") And code1 <= Asc("9") Then
				code1 = code1 - Asc("0")
			else if code1 >= Asc("a") And code1 <= Asc("f") Then
				code1 = code1 - Asc("a") + 10
			else if code1 >= Asc("A") And code1 <= Asc("F") Then
				code1 = code1 - Asc("A") + 10		
			Else
				code1 = 0
			End If
			
			Buffer(index) = Bit.Or(Bit.ShiftLeft(code0,4), code1)
			index = index + 1
		Else
			Buffer(index) = c
			index = index + 1
		End If
	Next
	
	Return index
End Sub



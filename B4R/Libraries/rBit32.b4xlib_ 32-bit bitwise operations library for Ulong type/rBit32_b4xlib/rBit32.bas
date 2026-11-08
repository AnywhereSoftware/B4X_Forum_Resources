B4R=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=4
@EndOfDesignText@
'(c) Vlad Pomelov aka Peacemaker
'v.0.56

Private Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'Public variables can be accessed from all modules.
	
End Sub

'binary logging Ulong variable to check visually
Sub LogNumber(name As String, v As ULong)
	Dim Binary As String = BinaryToString(v)
	Log(name, ": ", v, "; Binary = ", Binary)
End Sub

' Returns the lower 16 bits (0-15) of ULong as UInt
Sub LowWord(value As ULong) As UInt
	Return Bit.And(value, 0xFFFF)
End Sub

' Returns the higher 16 bits (16-31) of ULong as UInt
Sub HighWord(value As ULong) As UInt
	Return (value - (value Mod 65536)) / 65536
End Sub

' Combines two 16-bit words into a 32-bit ULong
Sub CombineWords(high As UInt, low As UInt) As ULong
	Return (high * 65536) + low
End Sub

' 32-bit AND (bitwise AND)
Sub And32(a As ULong, b As ULong) As ULong
	Dim aLow As UInt = LowWord(a)
	Dim aHigh As UInt = HighWord(a)
	Dim bLow As UInt = LowWord(b)
	Dim bHigh As UInt = HighWord(b)
	Return CombineWords(Bit.And(aHigh, bHigh), Bit.And(aLow, bLow))
End Sub

' 32-bit OR (bitwise OR)
Sub Or32(a As ULong, b As ULong) As ULong
	Dim aLow As UInt = LowWord(a)
	Dim aHigh As UInt = HighWord(a)
	Dim bLow As UInt = LowWord(b)
	Dim bHigh As UInt = HighWord(b)
	Return CombineWords(Bit.Or(aHigh, bHigh), Bit.Or(aLow, bLow))
End Sub

' 32-bit XOR (exclusive OR)
Sub Xor32(a As ULong, b As ULong) As ULong
	Dim aLow As UInt = LowWord(a)
	Dim aHigh As UInt = HighWord(a)
	Dim bLow As UInt = LowWord(b)
	Dim bHigh As UInt = HighWord(b)
	Return CombineWords(Bit.Xor(aHigh, bHigh), Bit.Xor(aLow, bLow))
End Sub

'Bitwise shift right the Value to Shift bits
Sub ShiftRight(Value As ULong, Shift As Byte) As ULong
	If Shift >= 32 Then Return 0
	If Shift = 0 Then Return Value
    
	' Split into two 16-bit parts
	Dim LowWord1 As UInt = Bit.And(Value, 0xFFFF)
	Dim HighWord1 As UInt = (Value - LowWord1) / 65536
    
	If Shift < 16 Then
		' Calculate carry bits from high to low
		Dim carryMask As UInt = Bit.ShiftLeft(1, Shift) - 1
		Dim carryBits As UInt = Bit.And(HighWord1, carryMask)
		carryBits = Bit.ShiftLeft(carryBits, 16 - Shift)
        
		' Shift both parts
		Dim newHigh As UInt = Bit.ShiftRight(HighWord1, Shift)
		Dim newLow As UInt = Bit.Or(Bit.ShiftRight(LowWord1, Shift), carryBits)
        
		' Combine back
		Return (newHigh * 65536) + newLow
	Else
		' Only shift high word
		Return Bit.ShiftRight(HighWord1, Shift - 16)
	End If
End Sub

'Bitwise shift left the Value to Shift bits
Sub ShiftLeft(Value As ULong, Shift As Byte) As ULong
	If Shift >= 32 Then Return 0
	If Shift = 0 Then Return Value
    
	' Split into two 16-bit parts
	Dim LowWord1 As UInt = Bit.And(Value, 0xFFFF)
	Dim HighWord1 As UInt = (Value - LowWord1) / 65536
    
	If Shift < 16 Then
		' Calculate carry bits from lowWord to highWord
		Dim carryBits As UInt = Bit.ShiftRight(LowWord1, 16 - Shift)
        
		' Shift both parts
		Dim newLow As UInt = Bit.ShiftLeft(LowWord1, Shift)
		Dim newHigh As UInt = Bit.Or(Bit.ShiftLeft(HighWord1, Shift), carryBits)
        
		' Combine back
		Return (newHigh * 65536) + newLow
	Else If Shift < 32 Then
		' Only shift lowWord, carry to highWord
		Dim newHigh As UInt = Bit.ShiftLeft(LowWord1, Shift - 16)
		Return newHigh * 65536 ' newLow = 0
	Else
		Return 0
	End If
End Sub

' Sets a bit (0-31) to 1
Sub Set(value As ULong, Bit_num As Byte) As ULong
	If Bit_num >= 32 Then Return value
	Dim mask As ULong = ShiftLeft(1, Bit_num)
	Return Or32(value, mask)
End Sub

' Clears a bit (0-31) to 0
Sub Clear(value As ULong, bitNum As Byte) As ULong
	' Check for out of bounds
	If bitNum >= 32 Then Return value
    
	If bitNum < 16 Then
		' Clear bit in lower word (bits 0-15)
		' Create mask with zero at bitNum position: ~(1 << bitNum)
		Dim mask As UInt = Bit.Not(Bit.ShiftLeft(1, bitNum))
		' Apply mask with AND to lower word
		Dim newLow As UInt = Bit.And(LowWord(value), mask)
		' Combine with unchanged higher word
		Return CombineWords(HighWord(value), newLow)
	Else
		' Clear bit in higher word (bits 16-31)
		' Create mask with zero at (bitNum - 16) position
		Dim mask As UInt = Bit.Not(Bit.ShiftLeft(1, bitNum - 16))
		' Apply mask with AND to higher word
		Dim newHigh As UInt = Bit.And(HighWord(value), mask)
		' Combine with unchanged lower word
		Return CombineWords(newHigh, LowWord(value))
	End If
End Sub

'binary formatting Ulong: 0b00000000 00000000 00000000 00000001
Sub BinaryToString(value As ULong) As String
	Dim result As String = "0b"
	Dim i As Int
	Dim bitCounter As Int = 0
    
	' Process high word (bits 31-16)
	Dim HighWord1 As UInt = HighWord(value)
	For i = 15 To 0 Step -1
		Dim mask As UInt = Bit.ShiftLeft(1, i)
		If Bit.And(HighWord1, mask) <> 0 Then
			result = JoinStrings(Array As String(result, "1"))
		Else
			result = JoinStrings(Array As String(result, "0"))
		End If
        
		bitCounter = bitCounter + 1
		' Adding a space after every 8 bits except the last one
		If bitCounter Mod 8 = 0 And (i > 0 Or bitCounter < 32) Then
			result = JoinStrings(Array As String(result, " "))
		End If
	Next
    
	' Process low word (bits 15-0)
	Dim LowWord1 As UInt = LowWord(value)
	For i = 15 To 0 Step -1
		Dim mask As UInt = Bit.ShiftLeft(1, i)
		If Bit.And(LowWord1, mask) <> 0 Then
			result = JoinStrings(Array As String(result, "1"))
		Else
			result = JoinStrings(Array As String(result, "0"))
		End If
        
		bitCounter = bitCounter + 1
		' Adding a space after every 8 bits except the last one
		If bitCounter Mod 8 = 0 And i > 0 Then
			result = JoinStrings(Array As String(result, " "))
		End If
	Next
    
	Return result
End Sub

'Bitwise Inverse
Sub Not32(value As ULong) As ULong
	Return Xor32(value, 0xFFFFFFFF)
End Sub

' Gets a bit value (0-31) as Boolean
' Returns True if bit is 1, False if bit is 0
Sub Get(value As ULong, Bit_num As Byte) As Boolean
	' Check for out of bounds
	If Bit_num >= 32 Then Return False
    
	If Bit_num < 16 Then
		' Check bit in lower word (bits 0-15)
		Dim mask As UInt = Bit.ShiftLeft(1, Bit_num)
		Return Bit.And(LowWord(value), mask) <> 0
	Else
		' Check bit in higher word (bits 16-31)
		Dim mask As UInt = Bit.ShiftLeft(1, Bit_num - 16)
		Return Bit.And(HighWord(value), mask) <> 0
	End If
End Sub
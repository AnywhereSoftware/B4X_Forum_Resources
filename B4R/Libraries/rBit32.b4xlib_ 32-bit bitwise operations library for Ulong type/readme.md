### rBit32.b4xlib: 32-bit bitwise operations library for Ulong type by peacemaker
### 07/11/2025
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/167743/)

v0.56 alfa  
  
It's first alfa-version, please, help to test and debug.  
  

```B4X
'© Vlad Pomelov aka Peacemaker  
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
```

  
  

```B4X
#Region Project Attributes  
    #AutoFlushLogs: True  
    #CheckArrayBounds: True  
    #StackBufferSize: 5600  
#End Region  
'v0.56  
  
Sub Process_Globals  
    Public Serial1 As Serial  
End Sub  
  
Private Sub AppStart  
    Serial1.Initialize(115200)  
    Delay(2000)  
    Log(CRLF, "AppStart")  
'    BugTest  
  
    Log(rBit32.Get(5, 0))  
    Log(rBit32.Get(5, 1))  
    Log(rBit32.Get(0x7FFF, 31))  
    Log(rBit32.Get(0xFFFF, 31))  
   
    Dim source_uint1 As UInt = 65535  
    Log("NotUint1: ", Bit.Not(source_uint1))  
    Dim source_uint2 As UInt = 0xFFFF  
    Log("NotUint2: ", Bit.Not(source_uint2))  
    Dim source_ulong1 As UInt = 4294967294 '= 0xFFFFFFFE  
    Log("NotUlong1: ", Bit.Not(source_ulong1))  
    Dim source_ulong2 As UInt = 0xFFFFFFFE '= 4294967294  
    Log("NotUlong2: ", Bit.Not(source_ulong2))  
   
   
    Dim source As ULong = 4294967295  
    Dim source2 As ULong = 1431655765    '0xAAAAAAAA  
   
    Dim source3 As ULong = 0x1234000F  
    Dim source4 As ULong = 0xFFFFFFFE  
    rBit32.LogNumber("HighWord3", rBit32.HighWord(source3))  
    rBit32.LogNumber("HighWord4", rBit32.HighWord(source4))  
   
    rBit32.LogNumber("Source", source)  
    rBit32.LogNumber("Not", rBit32.Not32(4294967295))  
    rBit32.LogNumber("And", rBit32.And32(4294967295, source2))  
    rBit32.LogNumber("Or", rBit32.Or32(4294967295, source2))  
    rBit32.LogNumber("xOr", rBit32.Xor32(4294967295, source2))  
    rBit32.LogNumber("LowWord", rBit32.LowWord(305419896))  
    rBit32.LogNumber("HighWord1", rBit32.HighWord(305419896))    'works OK  
    rBit32.LogNumber("HighWord2", rBit32.HighWord(source3))    'works wrong  
    rBit32.LogNumber("SetBit", rBit32.Set(0, 30))  
   
    Dim num As ULong = 4294967295 ' All bits set  
    rBit32.LogNumber("ClearBit30", rBit32.Clear(num, 30)) ' 0b10111111_11111111_11111111_11111111  
    rBit32.LogNumber("ClearBit16", rBit32.Clear(num, 16)) ' 0b11111111_11111110_11111111_11111111  
  
   
    For i = 1 To 32  
        Dim res As ULong = rBit32.ShiftRight(4294967295, i)  
        Log("Res, right ", NumberFormat(i, 2, 0),": ", rBit32.BinaryToString(res))  
    Next  
   
    For i = 1 To 32  
        Dim res As ULong = rBit32.ShiftLeft(4294967295, i)  
        Log("Res, left ", NumberFormat(i, 2, 0),": ", rBit32.BinaryToString(res))  
    Next  
End Sub
```

  
  
My test log is here:  
> AppStart  
> 1  
> 0  
> 0  
> 1  
> NotUint1: 4294901760  
> NotUint2: 4294901760  
> NotUlong1: 4294901761  
> NotUlong2: 4294901761  
> HighWord3: 0; Binary = 0b00000000 00000000 00000000 00000000  
> HighWord4: 65535; Binary = 0b00000000 00000000 11111111 11111111  
> Source: 4294967295; Binary = 0b11111111 11111111 11111111 11111111  
> Not: 0; Binary = 0b00000000 00000000 00000000 00000000  
> And: 1431655765; Binary = 0b01010101 01010101 01010101 01010101  
> Or: 4294967295; Binary = 0b11111111 11111111 11111111 11111111  
> xOr: 2863311530; Binary = 0b10101010 10101010 10101010 10101010  
> LowWord: 22136; Binary = 0b00000000 00000000 01010110 01111000  
> HighWord1: 4660; Binary = 0b00000000 00000000 00010010 00110100  
> HighWord2: 0; Binary = 0b00000000 00000000 00000000 00000000  
> SetBit: 1073741824; Binary = 0b01000000 00000000 00000000 00000000  
> ClearBit30: 3221225471; Binary = 0b10111111 11111111 11111111 11111111  
> ClearBit16: 4294901759; Binary = 0b11111111 11111110 11111111 11111111  
> Res, right 01: 0b01111111 11111111 11111111 11111111  
> Res, right 02: 0b00111111 11111111 11111111 11111111  
> Res, right 03: 0b00011111 11111111 11111111 11111111  
> Res, right 04: 0b00001111 11111111 11111111 11111111  
> Res, right 05: 0b00000111 11111111 11111111 11111111  
> Res, right 06: 0b00000011 11111111 11111111 11111111  
> Res, right 07: 0b00000001 11111111 11111111 11111111  
> Res, right 08: 0b00000000 11111111 11111111 11111111  
> Res, right 09: 0b00000000 01111111 11111111 11111111  
> Res, right 10: 0b00000000 00111111 11111111 11111111  
> Res, right 11: 0b00000000 00011111 11111111 11111111  
> Res, right 12: 0b00000000 00001111 11111111 11111111  
> Res, right 13: 0b00000000 00000111 11111111 11111111  
> Res, right 14: 0b00000000 00000011 11111111 11111111  
> Res, right 15: 0b00000000 00000001 11111111 11111111  
> Res, right 16: 0b00000000 00000000 11111111 11111111  
> Res, right 17: 0b00000000 00000000 01111111 11111111  
> Res, right 18: 0b00000000 00000000 00111111 11111111  
> Res, right 19: 0b00000000 00000000 00011111 11111111  
> Res, right 20: 0b00000000 00000000 00001111 11111111  
> Res, right 21: 0b00000000 00000000 00000111 11111111  
> Res, right 22: 0b00000000 00000000 00000011 11111111  
> Res, right 23: 0b00000000 00000000 00000001 11111111  
> Res, right 24: 0b00000000 00000000 00000000 11111111  
> Res, right 25: 0b00000000 00000000 00000000 01111111  
> Res, right 26: 0b00000000 00000000 00000000 00111111  
> Res, right 27: 0b00000000 00000000 00000000 00011111  
> Res, right 28: 0b00000000 00000000 00000000 00001111  
> Res, right 29: 0b00000000 00000000 00000000 00000111  
> Res, right 30: 0b00000000 00000000 00000000 00000011  
> Res, right 31: 0b00000000 00000000 00000000 00000001  
> Res, right 32: 0b00000000 00000000 00000000 00000000  
> Res, left 01: 0b11111111 11111111 11111111 11111110  
> Res, left 02: 0b11111111 11111111 11111111 11111100  
> Res, left 03: 0b11111111 11111111 11111111 11111000  
> Res, left 04: 0b11111111 11111111 11111111 11110000  
> Res, left 05: 0b11111111 11111111 11111111 11100000  
> Res, left 06: 0b11111111 11111111 11111111 11000000  
> Res, left 07: 0b11111111 11111111 11111111 10000000  
> Res, left 08: 0b11111111 11111111 11111111 00000000  
> Res, left 09: 0b11111111 11111111 11111110 00000000  
> Res, left 10: 0b11111111 11111111 11111100 00000000  
> Res, left 11: 0b11111111 11111111 11111000 00000000  
> Res, left 12: 0b11111111 11111111 11110000 00000000  
> Res, left 13: 0b11111111 11111111 11100000 00000000  
> Res, left 14: 0b11111111 11111111 11000000 00000000  
> Res, left 15: 0b11111111 11111111 10000000 00000000  
> Res, left 16: 0b11111111 11111111 00000000 00000000  
> Res, left 17: 0b11111111 11111110 00000000 00000000  
> Res, left 18: 0b11111111 11111100 00000000 00000000  
> Res, left 19: 0b11111111 11111000 00000000 00000000  
> Res, left 20: 0b11111111 11110000 00000000 00000000  
> Res, left 21: 0b11111111 11100000 00000000 00000000  
> Res, left 22: 0b11111111 11000000 00000000 00000000  
> Res, left 23: 0b11111111 10000000 00000000 00000000  
> Res, left 24: 0b11111111 00000000 00000000 00000000  
> Res, left 25: 0b11111110 00000000 00000000 00000000  
> Res, left 26: 0b11111100 00000000 00000000 00000000  
> Res, left 27: 0b11111000 00000000 00000000 00000000  
> Res, left 28: 0b11110000 00000000 00000000 00000000  
> Res, left 29: 0b11100000 00000000 00000000 00000000  
> Res, left 30: 0b11000000 00000000 00000000 00000000  
> Res, left 31: 0b10000000 00000000 00000000 00000000  
> Res, left 32: 0b00000000 00000000 00000000 00000000

  
p.s. It's important to test and debug due to i have touched a strange B4R v.4.0 IDE compilation (Arduino v2.3.6):  
  
<https://www.b4x.com/android/forum/threads/ide-parsing-hex.167736/>  
  
and  
<https://www.b4x.com/android/forum/threads/why-dim-mask-as-ulong-2147483648-0x80000000.167728/>  
  
and "HighWord2" result in the test log is strange
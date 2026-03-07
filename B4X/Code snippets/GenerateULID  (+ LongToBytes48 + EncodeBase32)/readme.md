###  GenerateULID  (+ LongToBytes48 + EncodeBase32) by LucaMs
### 03/03/2026
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/170482/)

**ULID (Universally Unique Lexicographically Sortable Identifier)**  
  
A ULID is a 128‑bit globally unique identifier designed to be both universally unique and *lexicographically sortable*  
  
It consists of a 48‑bit timestamp (in milliseconds) followed by 80 bits of randomness. Because the timestamp is encoded first, ULIDs naturally sort in chronological order when compared as strings. This makes them ideal for distributed systems, databases, synchronization logic, and any scenario where both uniqueness and temporal ordering are importan  
  
ULIDs are more readable than UUIDs and avoid collisions even when generated on multiple devices.  
  

```B4X
'Return an ULID = 48-bit timestamp + 80-bit randomness  
' (Timestamp = ms since 01/01/1970 (48-bit))  
Public Sub GenerateULID As String  
'USES: LongToBytes48 and EncodeBase32.  
  
    Dim ts As Long = DateTime.Now  
    Dim tsBytes() As Byte = LongToBytes48(ts)  
     
    ' Randomness = 10 bytes (80-bit)  
    Dim rndBytes(10) As Byte  
    For i = 0 To 9  
        rndBytes(i) = Rnd(0, 256)  
    Next  
     
    ' Concatenate timestamp + randomness  
    Dim all(16) As Byte  
    For i = 0 To 5  
        all(i) = tsBytes(i)  
    Next  
    For i = 0 To 9  
        all(6 + i) = rndBytes(i)  
    Next  
     
    ' Encode using Crockford Base32 (unambiguous)  
    Return EncodeBase32(all)  
End Sub  
  
  
' ============================  
'   Convert Long → 48-bit  
' ============================  
Private Sub LongToBytes48(l As Long) As Byte()  
    Dim b(6) As Byte  
    For i = 5 To 0 Step -1  
        b(i) = Bit.And(l, 0xFF)  
        l = Bit.UnsignedShiftRight(l, 8)  
    Next  
    Return b  
End Sub  
  
  
' ============================  
'   Crockford Base32  
' ============================  
Private Sub EncodeBase32(data() As Byte) As String  
    Dim alphabet As String = "0123456789ABCDEFGHJKMNPQRSTVWXYZ"  
    Dim bits As Long = 0  
    Dim bitCount As Int = 0  
    Dim out As StringBuilder  
    out.Initialize  
     
    For Each b As Byte In data  
        bits = Bit.Or(Bit.ShiftLeft(bits, 8), Bit.And(b, 0xFF))  
        bitCount = bitCount + 8  
         
        Do While bitCount >= 5  
            bitCount = bitCount - 5  
            Dim index As Int = Bit.And(Bit.UnsignedShiftRight(bits, bitCount), 31)  
            out.Append(alphabet.CharAt(index))  
        Loop  
    Next  
     
    If bitCount > 0 Then  
        Dim index As Int = Bit.And(Bit.ShiftLeft(bits, (5 - bitCount)), 31)  
        out.Append(alphabet.CharAt(index))  
    End If  
     
    Return out.ToString  
End Sub
```
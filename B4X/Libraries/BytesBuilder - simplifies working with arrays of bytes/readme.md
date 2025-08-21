###  BytesBuilder - simplifies working with arrays of bytes by Erel
### 10/13/2019
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/89008/)

**Edit: BytesBuilder is included in B4XCollections library (named B4XBytesBuilder).**  
  
BytesBuilder class, which is compatible with B4A, B4i and B4J, makes it easier to work with bytes.  
You can think of it as a combination of String and StringBuilder, but instead of holding characters it holds bytes.  
  
Modifying the stored data is done with:  

- Append - Adds data at the end.
- Insert - Inserts data at the given index.
- Set - Replaces data starting from the given index
- Remove - Removes the data in the given range.
- Clear - Clears the data.

Note that the internal buffer grows automatically as needed.  
  
Reading the data is done with:  

- SubArray / SubArray2 - Similar to String.SubString
- ToArray - Similar to StringBuilder.ToString. Returns a complete copy of the data.
- IndexOf / IndexOf2 - Similar to String.IndexOf

  
Dependencies:  
B4A, B4J - ByteConverter  
B4i - iRandomAccessFile  
  
Example:  

```B4X
Dim bb As BytesBuilder  
bb.Initialize  
For i = 0 To 255  
   bb.Append(Array As Byte(i))  
Next  
bb.Insert(1, Array As Byte(0xFF, 0XFF, 0xFF))  
Log(bb.IndexOf(Array As Byte(10, 11, 12)))  
Log(bb.IndexOf(Array As Byte(0)))  
Log(bb.IndexOf2(Array As Byte(0xFF), 3))  
Dim bc As ByteConverter  
Log(bc.HexFromBytes(bb.ToArray))  
Log(bc.HexFromBytes(bb.SubArray2(250, 300)))
```
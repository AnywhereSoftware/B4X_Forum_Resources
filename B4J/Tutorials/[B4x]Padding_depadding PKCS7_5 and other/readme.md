### [B4x]Padding/depadding PKCS7/5 and other by KMatle
### 04/30/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/130258/)

**EDIT: If the message length is equal to the pad length, you have to pad to the next multiple. E.g. 16 bytes would be padded to 32 because one would not know how long the message was because the last byte defines the number of added (=padded) values.**   
  
Here's another example to pad/depad data for many use cases (like Encryption).  
  
Explanation on this site: <https://asecuritysite.com/encryption/padding>  
  
Example how it works:  
  
1. You have a string or bytes with a lenght of 5. Let's say it's the string "Hello"  
2. The function you use (e.g. AES) needs the data with a length of a multiple of x (here: 16)  
3. You then need to fill the rest of the 16 bytes ("Hello" has 5, so it's 11) with a filler (Pad-Value)  
4. 16 bytes is easy bit usually you have much more data to pad  
5. The example calculates the next multiple of 16 (you can use any pad-size) and fills it with pad-values  
6. The last byte (here the 16th) is filled with the total length of padded bytes (otherwise you wouldn't know how many were added)  
7. The pad value (what it uses to fill up) depends on the usage and is regulated (RFC's, etc.)  
8. It can be  
  
- any byte value  
- random bytes  
- the count of the added bytes (here it would be 11 bytes or 0xb for all bytes to fill)  
  
I use it to exchange AES encrypted data with my ESP32 (as far as I know it only supports "no padding" so I had to pad the data on my own).   
  
Padding:  
  
Pad-Mode  
1=Random Bytes  
2=Value given in PadValue  
3=Number of padded bytes is jused as the pad value  
  

```B4X
Sub Pad (mess() As Byte, PadTo As Int,PadMode As Int,PadValue As Object) As Byte()  
    Dim MessLength As Int = mess.Length  
    Dim PaddedLength As Int  
    PaddedLength = MessLength-MessLength Mod PadTo + PadTo  
    Log("Original length: " & MessLength & ", padded: " & PaddedLength)  
    Dim PaddedMess(PaddedLength) As Byte  
    bc.ArrayCopy(mess,0,PaddedMess,0,mess.Length)  
    For i=mess.Length To PaddedLength-2  
        Select PadMode  
        Case 1      
           PaddedMess(i)=Rnd(0,256)-127  
        Case 2  
           PaddedMess(i)=PadValue  
        Case 3  
           PaddedMess(i)=PaddedLength-MessLength  
        End Select   
    Next   
    PaddedMess(PaddedLength-1)=PaddedLength-MessLength  
    Return PaddedMess  
  
End Sub
```

  
  
Un-Pad:  

```B4X
Sub Unpad (PaddedMess() As Byte) As Byte()  
    Dim OrigMess(PaddedMess.Length-PaddedMess(PaddedMess.Length-1)) As Byte  
    bc.ArrayCopy(PaddedMess,0,OrigMess,0,OrigMess.Length)  
    Return OrigMess  
End Sub
```

  
  
Call:  

```B4X
Dim padded() As Byte=Pad("Hello".GetBytes("UTF8"),16,2,15)  
Dim unpadded() As Byte= Unpad(padded)  
Log(BytesToString(unpadded,0,unpadded.Length,"UTF8"))
```
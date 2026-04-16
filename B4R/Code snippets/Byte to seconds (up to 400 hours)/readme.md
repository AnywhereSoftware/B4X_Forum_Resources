### Byte to seconds (up to 400 hours) by peacemaker
### 04/13/2026
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/170804/)

It's useful for me to use with the MCU sleep.  
  
![](https://www.b4x.com/android/forum/attachments/171123)  
  

```B4X
'Converts byte (0..255) to seconds (0..1440000)  
Sub ByteToSeconds(b As Byte) As ULong  
    Dim MAX_SEC As ULong = 1440000    '400 hours max  
    If b <= 49 Then  
        Return b  
    Else If b <= 99 Then  
        Return 60 * (b - 49)  
    Else If b <= 199 Then  
        Return 3600 * (b - 99)  
    Else  
        'Range 200..255: linear from 100 to 400 hours  
        Dim delta As ULong = (b - 200) * 216000  
        Dim result As ULong = 360000 + delta / 11  
        If result > MAX_SEC Then result = MAX_SEC  
        Return result  
    End If  
End Sub  
  
'Converts seconds (0..1440000) to byte (0..255)  
Sub SecondsToByte(sec As ULong) As Byte  
    Dim MAX_SEC As ULong = 1440000    '400 hours max  
    Dim s As ULong = sec  
    If s > MAX_SEC Then s = MAX_SEC  
     
    If s <= 49 Then  
        Return s  
    Else If s <= 3000 Then  
        'Round to nearest minute  
        Dim b As ULong = (s + 30) / 60 + 49  
        If b > 99 Then b = 99  
        Return b  
    Else If s <= 360000 Then  
        'Round to nearest hour  
        Dim b As ULong = (s + 1800) / 3600 + 99  
        If b > 199 Then b = 199  
        Return b  
    Else  
        'Range: 100..400 hours  
        Dim numerator As ULong = (s - 360000) * 55  
        Dim b As ULong = 200 + (numerator + 540000) / 1080000   'with rounding  
        If b > 255 Then b = 255  
        Return b  
    End If  
End Sub
```
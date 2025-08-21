### [XUI] SD Base64 - Encode / Decode by Star-Dust
### 07/19/2020
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/105755/)

Today I was looking for a method for encoding and decoding in Base64.  
There are many libraries including the well-known StringUtils. But the decoding signaled me an error but it was not possible to understand exactly what the error was  
  
So I created for B4J a class that using inline Java code decoded the string, but getting the same error. In any case it would not work for B4i  

```B4X
#if java  
import java.util.Base64;  
  
public byte[] decode(byte[] original) {  
     byte[] decoded = Base64.getDecoder().decode(original);  
     return decoded;  
}  
#END if
```

  
  
So I searched around a bit until I found **[this site](https://en.wikibooks.org/wiki/Algorithm_Implementation/Miscellaneous/Base64)** and ***translated the code in B4X*** (hoping there are no errors). Want to share it, maybe it can be useful to someone else :D  
  
**Decode**  

```B4X
Public Sub Base64Decode(S As String) As String  
    Dim base64chars As String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"  
    Dim P,R = "" As String  
  
    #IF B4J or B4A  
    Dim Ob As JavaObject = S 'ignore  
    S=Ob.RunMethod("replaceAll",Array As Object("[^ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=]",""))  
    #ELSE  
    ' Don't known - Working Progress  
    #End If  
  
    If S.CharAt(S.Length-1)="=" Then  
        If S.CharAt(S.Length-2)="=" Then  
            p="AA"  
        Else  
            P="A"  
        End If  
    Else  
        P=""  
    End If  
    S=S.SubString2(0,S.Length-P.Length) & P  
  
    For C = 0 To S.Length-1 Step 4  
        Try  
            Dim n As Int = Bit.ShiftLeft(base64chars.IndexOf(S.CharAt(C)),18) + Bit.ShiftLeft(base64chars.IndexOf(S.CharAt(C+1)),12) + Bit.ShiftLeft(base64chars.IndexOf(S.CharAt(C+2)),6)+ base64chars.IndexOf(S.CharAt(C+3))  
            r = r & Chr(Bit.And(Bit.ShiftRight(n,16),0xFF)) & Chr(Bit.And(Bit.ShiftRight(n,8),0xFF)) & Chr(Bit.And(n,0xFF))  
        Catch  
            Log("Position: " & C)  
        End Try  
    Next  
  
    Return R.SubString2(0, R.Length - P.Length)  
End Sub
```

  
  
**Encode**  

```B4X
Public Sub Base64Encode(S As String) As String  
    Dim c As Int = S.Length Mod 3  
    Dim base64chars As String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"  
    Dim P = "",R = "" As String  
  
    ' add a right zero pad To make this string a multiple of 3 characters  
    If c>0 Then  
        Do While c<3  
            P = P & "="  
            S = S & "0"  
            c=c+1  
        Loop  
    End If  
  
    For c = 0 To S.Length-1 Step 3  
        If (c > 0 And (c / 3 * 4) Mod 76 = 0) Then R=R & Chr(10) & Chr(13)  
        Dim n As Int = Bit.ShiftLeft(Asc(S.CharAt©),16) + Bit.ShiftLeft(Asc(S.CharAt(c+1)),8) + Asc(S.CharAt(c+2))  
        Dim n1 As Int = Bit.And(Bit.ShiftRight(n,18),63)  
        Dim n2 As Int = Bit.And(Bit.ShiftRight(n,12),63)  
        Dim n3 As Int = Bit.And(Bit.ShiftRight(n,6),63)  
        Dim n4 As Int = Bit.And(n,63)  
  
        R = R & base64chars.CharAt(n1) & base64chars.CharAt(n2) & base64chars.CharAt(n3) & base64chars.CharAt(n4)  
    Next  
    Return r.substring2(0, r.length - p.length) & p  
End Sub
```

  
  
Although it is slower than existing libraries, it is possible to compress and decompress with B4X code and therefore not linked to a specific platform and modifiable to adapt them to the many existing variants.  
*Especially if there is an error in the data to be decoded it is possible to do a more specific debugging*
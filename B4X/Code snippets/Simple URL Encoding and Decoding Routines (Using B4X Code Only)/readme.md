###  Simple URL Encoding and Decoding Routines (Using B4X Code Only) by TILogistic
### 08/26/2024
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/162723/)

Simple URL Encoding and Decoding Routines (Using B4X Code Only)  
**Note:  
You can modify it according to your needs.  
It is similar to stringutils but without charset, you can even encode with stringutils and decode with these routines.**  
ex.  

```B4X
    Dim s As String = $"https://www.b4x.com/android/forum/whats-new/posts/4054187/"$  
    Log(URL_Encode(s))  
    Log(URL_Decode(URL_Encode(s)))
```

  

```B4X
Public Sub URL_Encode(s As String) As String  
    Dim Output As StringBuilder  
    Output.Initialize  
    For i = 0 To s.Length - 1  
        Dim c As Char = s.CharAt(i)  
        If IsAlphanumeric(Asc©) Or c="-" Or c="_" Or c="." Or c="~" Then  
            Output.Append©  
        Else  
            Output.Append("%").Append(Bit.ToHexString(Asc©).ToUpperCase)  
        End If  
    Next  
    Return Output.ToString  
End Sub  
  
Private Sub IsAlphanumeric(c As Int) As Boolean  
    Return (c>=48 And c <=57) Or (c>=65 And c<=90) Or (c>=97 And c<=122)  
End Sub  
  
Public Sub URL_Decode(s As String) As String  
    Dim Output As StringBuilder  
    Output.Initialize  
    Dim i = 0 As Int  
    Do While i < s.Length  
        Dim c As Char = s.CharAt(i)  
        If c = "%" And i + 2 < s.Length Then  
            Dim HexCode As String = s.SubString2(i + 1, i + 3)  
            Dim Code As Int = Bit.ParseInt(HexCode,16)  
            Output.Append(Chr(Code))  
            i = i + 3  
        Else  
            Output.Append©  
            i = i + 1  
        End If  
    Loop  
    Return Output.ToString  
End Sub
```

  
  
![](https://www.b4x.com/android/forum/attachments/156334)  
  
Your comments will be welcome  
  
Regards
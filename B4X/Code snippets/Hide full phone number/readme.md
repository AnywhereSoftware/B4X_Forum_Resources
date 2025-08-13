###  Hide full phone number by Alexander Stolte
### 12/06/2023
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/157843/)

It does not always make sense to make the entire phone number visible. So we only show the prefix code and the last 4 characters. We replace the rest with \*  
  
Regex is unfortunately still a mytherium to me, hence this workaround:  
  

```B4X
Private Sub HideFullPhoneNumber(PhoneNumber As String) As String  
    Dim PasswordChars As String = ""  
    For i = 0 To PhoneNumber.Length -1  
        If i >= 3 And i <= PhoneNumber.Length -4 Then  
            PasswordChars = PasswordChars & "*"  
        End If  
    Next  
    Return PhoneNumber.SubString2(0,3) & PasswordChars & PhoneNumber.SubString2(PhoneNumber.Length -4,PhoneNumber.Length)  
End Sub
```

  
  

```B4X
Log(HideFullPhoneNumber("+4918153451234"))  
'+49********1234
```
###  Check Valid E-Mail Format by Alexander Stolte
### 05/18/2020
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/117913/)

```B4X
Private Sub EmailAddressCheck(email As String) As Boolean     
    Return Regex.IsMatch("^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$",email)  
End Sub
```

  

```B4X
If EmailAddressCheck("test@b4x.de") = True Then  
        Log("E-Mail is valid")  
        Else  
        Log("E-Mail is not valid")  
    End If
```
###  Validate Password strength by Alexander Stolte
### 05/18/2020
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/117907/)

This is a port from [this](https://docs.microsoft.com/de-de/dotnet/visual-basic/programming-guide/language-features/strings/walkthrough-validating-that-passwords-are-complex) VB.NET code.  

```B4X
Private Sub ValidatePassword(pwd As String,minLength As Int,numUpper As Int,numLower As Int,numNumbers As Int,numSpecial As Int) As Boolean     
    If pwd.Length < minLength Then Return False  
    If CountMatches(pwd,"[A-Z]") < numUpper Then Return False  
    If CountMatches(pwd,"[a-z]") < numLower Then Return False  
    If CountMatches(pwd,"[0-9]") < numNumbers Then Return False  
    If CountMatches(pwd,"[^a-zA-Z0-9]") < numSpecial Then Return False  
    ' Passed all checks.  
    Return True     
End Sub
```

  
**CountMatches** you can find [here](https://www.b4x.com/android/forum/threads/b4x-count-regex-matches.117906/#post-737742).  
  

```B4X
If ValidatePassword("Willkommen2020!",8,1,1,1,1) = True Then  
        Log("Password is ok")  
    Else  
        Log("Password is not ok")  
    End If
```
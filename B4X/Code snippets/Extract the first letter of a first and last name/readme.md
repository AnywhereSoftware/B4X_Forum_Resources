###  Extract the first letter of a first and last name by TILogistic
### 05/16/2024
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/161153/)

Extracts the first letter of a first name and last name.  
If you wish, you can extract the first letter of the first name and the full last name.  
  

```B4X
    Log(GetNameLetter("ti-logistic"))  
    Log(GetNameLetter("Aeric Poon"))  
    Log(GetNameLetter("McFarland, Dave"))  
    Log(GetNameLetter("A & W"))  
    Log(GetNameLetter("Stewart & Andrew"))
```

  
  

```B4X
Public Sub GetNameLetter(Text As String) As String  
    Dim Result As StringBuilder, Pattern As String = "(\w+).*\W+(\w+)$"  
    Dim Matcher As Matcher = Regex.Matcher(Pattern, Text)  
    Result.Initialize  
    If Matcher.Find Then  
        For i = 1 To Matcher.GroupCount  
            Result.Append(Matcher.Group(i).SubString2(0,1))  
        Next  
    End If  
    Result.ToString.ToUpperCase  
End Sub
```

  
  
test:  
![](https://www.b4x.com/android/forum/attachments/153762)  
  
  
Your comments are welcome
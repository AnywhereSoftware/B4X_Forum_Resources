###  Count Regex Matches by Alexander Stolte
### 05/18/2020
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/117906/)

```B4X
Sub CountMatches(text As String,pattern As String) As Int     
    Dim tmp_count As Int = 0     
    Dim Matcher1 As Matcher  
    Matcher1 = Regex.Matcher(pattern, text)  
    Do While Matcher1.Find  
        tmp_count = tmp_count +1  
    Loop  
    Return tmp_count  
End Sub
```
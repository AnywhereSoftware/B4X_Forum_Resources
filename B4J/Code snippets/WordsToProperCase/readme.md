### WordsToProperCase by aeric
### 05/23/2022
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/140746/)

```B4X
Sub AppStart (Args() As String)  
    Log(WordsToProperCase("RINGGIT   MALAYSIA ONe   thouSAND     anD  Five hundRed")) ' Ringgit Malaysia One Thousand And Five Hundred  
End Sub  
  
Sub WordsToProperCase (Words As String) As String  
    If Words.Length < 1 Then Return Words  
    Do While Words.Contains("  ")  
        Words = Words.Replace("  ", " ")  
    Loop  
    Dim SB As StringBuilder  
    SB.Initialize  
    Dim Word() As String = Regex.Split(" ", Words)  
    For i = 0 To Word.Length - 1  
        If SB.Length > 0 Then SB.Append(" ")  
        SB.Append(Word(i).SubString2(0, 1).ToUpperCase)  
        If Word(i).Length > 1 Then SB.Append(Word(i).SubString(1).ToLowerCase)  
    Next  
    Return SB.ToString  
End Sub
```
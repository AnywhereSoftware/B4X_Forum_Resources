###  Occurrences by LucaMs
### 04/24/2023
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/147386/)

Three functions that might be useful.  
  
**EDIT**:  
Given the right observation by [USER=16350]@Mahares[/USER] ([post #4](https://www.b4x.com/android/forum/threads/b4x-occurrences.147386/post-935334)), I modified the first two functions to take "case insensitive" into account.  
  

```B4X
'Returns the number of occurrences of Pattern in Text.  
Sub OccurrCount(Pattern As String, Text As String, CaseSensitive As Boolean) As Int  
    Dim MatcherX As Matcher  
    Dim Counter As Int  
  
    If CaseSensitive Then  
        MatcherX = Regex.Matcher(Pattern, Text)  
    Else  
        MatcherX = Regex.Matcher2(Pattern, Regex.CASE_INSENSITIVE, Text)  
    End If  
    
    Counter = 0  
    Do While MatcherX.Find  
        Counter = Counter + 1  
    Loop  
   
    Return Counter  
End Sub
```

  
  

```B4X
Sub OccurrIndexes(SubString As String, Text As String, CaseSensitive As Boolean) As List  
    Dim lstResult As List : lstResult.Initialize  
      
    If CaseSensitive = False Then  
        SubString = SubString.ToLowerCase  
        Text = Text.ToLowerCase  
    End If  
      
    Dim StartIndex As Int = Text.IndexOf2(SubString, 0)  
    Dim Found As Boolean = StartIndex <> - 1  
      
    Do While Found  
        lstResult.Add(StartIndex)  
        StartIndex = Text.IndexOf2(SubString.ToLowerCase, StartIndex + SubString.Length)  
        Found = StartIndex <> - 1  
    Loop  
      
    Return lstResult  
End Sub
```

  
  

```B4X
'Returns all numbers in Text.  
Sub NumbersIn(Text As String) As List  
    Dim lstResult As List : lstResult.Initialize  
   
    Dim Matcher1 As Matcher = Regex.Matcher("\d+", Text)  
    Do While Matcher1.Find  
        lstResult.Add(Matcher1.Match)  
    Loop  
   
    Return lstResult  
End Sub
```

  
  
  
*Note: I know very little about regular expressions (sooner or later I'll study them SERIOUSLY), so I don't know if it's possible to simplify/improve these functions.*
###  Simple function to highlight searchword in texts in CSBuilder Format by fredo
### 12/28/2024
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/164837/)

This simple function highlights all occurrences of a search term in a given text and returns the result as a CSBuilder.   
The output can then be used for labels or MsgBox text.  
  
[SPOILER="The code"]  

```B4X
 Sub HighlightCsTextWithRegex(OriginalText As String, searchWord As String) As CSBuilder  
    Dim escapedSearchWord As String = RegexEscapeSpecialChars(searchWord)  
    Dim pattern As String = "(?i)" & escapedSearchWord ' (?i) case-insensitive!  
    Dim matcher As Matcher = Regex.Matcher(pattern, OriginalText)  
    Dim cs As CSBuilder  
    cs.Initialize  
    Dim lastIndex As Int = 0  
    Do While matcher.Find  
        Dim startIndex As Int = matcher.GetStart(0)  
        Dim endIndex As Int = matcher.GetEnd(0)  
        cs.Append(OriginalText.SubString2(lastIndex, startIndex))  
        cs.BackgroundColor(xui.Color_Yellow) ' <<<<——————– you may underline, bold, italic etc. (any format you need)  
        cs.Append(OriginalText.SubString2(startIndex, endIndex))  
        cs.Pop  
        lastIndex = endIndex  
    Loop  
    cs.Append(OriginalText.SubString(lastIndex))  
    Return cs  
End Sub  
  
Sub RegexEscapeSpecialChars(input As String) As String  
    Dim specialChars As List  
    specialChars.Initialize2(Array As String("\", ".", "$", "^", "{", "[", "(", "|", ")", "*", "+", "?", "<", ">", "-", "&", "%"))  
    For Each charX As String In specialChars  
        input = input.Replace(charX, "\\" & charX)  
    Next  
    Return input  
End Sub
```

  
[/SPOILER]  
  
[SIZE=2]Testproject attached[/SIZE]  
  
![](https://www.b4x.com/android/forum/attachments/160023) ![](https://www.b4x.com/android/forum/attachments/160026)
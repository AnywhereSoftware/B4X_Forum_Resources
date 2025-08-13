###  Unescape Unicode by Erel
### 03/27/2025
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/166340/)

Unescapes characters encoded with the \uXXXX notion.  
  
Example:  

```B4X
Log(UnescapeUnicode("this is a test \u2764\ufe0f\u2764\ufe0f\u2764\ufe0f1234!!!"))
```

  
  

```B4X
Sub UnescapeUnicode(s As String) As String  
    Dim sb As StringBuilder  
    sb.Initialize  
    Dim lastMatchEnd As Int = 0  
    Dim m As Matcher = Regex.Matcher("\\u+([0-9A-Fa-f]{4})", s)  
    Do While m.Find  
        Dim currentStart As Int = m.GetStart(0)  
        sb.Append(s.SubString2(lastMatchEnd, currentStart))  
        sb.Append(Chr(Bit.ParseInt(m.Group(1), 16)))  
        lastMatchEnd = m.GetEnd(0)  
    Loop  
    If lastMatchEnd < s.Length Then sb.Append(s.SubString(lastMatchEnd))  
    Return sb.ToString  
End Sub
```
### String to Number (or remove all non-numbers) by tchart
### 07/08/2020
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/119952/)

I couldnt find this on the forum. I needed a way to extract the numeric portion of a string that could be alphanumeric.  
  

```B4X
Dim alphanumeric As String = "This string contains (12345.67) some numbers"  
  
Dim justnumbers As String = Regex.Replace("[^0-9.]",alphanumeric,"")  
  
Log(justnumbers) 'Shows 12345.67
```
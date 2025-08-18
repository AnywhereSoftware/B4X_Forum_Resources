###   Greedy Trim by epiCode
### 05/26/2022
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/140808/)

Replaces all multiple spaces / tabs (whitespaces) to single space in a string  
  

```B4X
Sub greedyTrim (Text As String) As String  
    If Text = "" Then Return Text Else Return Regex.Replace("\h+",text," ")   
End Sub
```
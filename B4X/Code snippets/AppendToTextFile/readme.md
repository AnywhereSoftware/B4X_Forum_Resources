###  AppendToTextFile by LucaMs
### 11/30/2021
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/136469/)

**Description**: appends text to a text file ?  
  
**Author**: [USER=1]@Erel[/USER] (original code [here](https://www.b4x.com/android/forum/threads/append-edit-text-to-file.136435/post-863374))  
  
**Platforms**: B4A, B4J, B4i  
  

```B4X
Private Sub AppendToTextFile(Dir As String, FileName As String, Text As String, NewLine As Boolean)  
    If NewLine Then  
        Text = CRLF & Text  
    End If  
    Dim out As OutputStream = File.OpenOutput(Dir, FileName, True)  
    Dim b() As Byte = Text.GetBytes("utf8")  
    out.WriteBytes(b, 0, b.Length)  
    out.Close  
End Sub
```
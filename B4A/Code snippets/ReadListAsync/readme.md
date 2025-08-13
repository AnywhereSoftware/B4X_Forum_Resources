### ReadListAsync by arfprogramas
### 05/06/2024
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/160977/)

```B4X
Private Sub ReadListAsync(dir As String, arq As String) As ResumableSub  
    Dim l As List  
    l.Initialize  
    Dim Reader As TextReader  
    Reader.Initialize(File.OpenInput(dir, arq))  
    Dim i As Int  
    Dim line As String  
    line = Reader.ReadLine  
    Do While line <> Null  
        i = i + 1  
        l.Add(line)  
        If i = 1000 Then  
            Sleep(1)  
            i = 0  
        End If  
        line = Reader.ReadLine  
    Loop  
    Reader.Close  
    Return l  
End Sub
```
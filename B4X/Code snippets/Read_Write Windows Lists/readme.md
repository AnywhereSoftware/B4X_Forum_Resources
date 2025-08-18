###  Read/Write Windows Lists by LucaMs
### 05/27/2021
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/131105/)

After reading [this thread](https://www.b4x.com/android/forum/threads/file-txt-non-leggibile-correttamente.131090/post-825411)…  
  
[A code module]  
  

```B4X
'Static code module  
Sub Process_Globals  
    Private mWinEOL As String  
End Sub  
  
Public Sub Init  
    mWinEOL = Chr(13) & Chr(10)  
End Sub  
  
Public Sub WriteListForWindows(Dir As String, Filename As String, lst As List)  
    Dim SB As StringBuilder  
    SB.Initialize  
      
    For Each Line As String In lst  
        SB.Append(Line & mWinEOL)  
    Next  
      
    File.WriteString(Dir, Filename, SB.ToString)  
End Sub  
  
Public Sub ReadWindowsList(Dir As String, Filename As String) As List  
    Dim lstResult As List  
    lstResult.Initialize  
      
    Dim FileString As String = File.ReadString(Dir, Filename)  
    Dim Lines() As String = Regex.Split(mWinEOL, FileString)  
      
    For Each Line As String In Lines  
        lstResult.Add(Line)  
    Next  
      
    Return lstResult  
End Sub
```

  
  
**[Little tested]**
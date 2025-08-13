### Map and List Initiators - a work-around by William Lancee
### 01/26/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/165270/)

As requested by [USER=74499]@aeric[/USER] and others, this is a work around for string keys and values, while anticipating a better solution.  
<https://www.b4x.com/android/forum/threads/createmap-and-createlist-but-shorter.165232/>  
  
Add this code module to your App  
  

```B4X
'Static code module NU  
Sub Process_Globals  
    Private fx As JFX  
End Sub  
  
Sub Map(s As String) As Map        'ignore  
    Dim mp As Map  
    mp.Initialize  
    Dim q() As String = Regex.Split("'", s & Chr(255))  
    If q.Length Mod 2 = 1 Then  
        For i = 0 To q.length - 2 Step 2  
            Dim w() As String = Regex.Split(",", q(i))  
            For j = 0 To w.Length - 2  
                Dim v() As String = Regex.Split(":", w(j))  
                mp.Put(v(0).Trim.ToLowerCase, v(1).Trim)  
            Next  
            v = Regex.Split(":", q(i + 1))  
            mp.Put(v(0).Trim.ToLowerCase, v(1).Trim)  
        Next  
    End If  
    Return mp  
End Sub  
  
Sub List(s As String) As List        'ignore  
    Dim lst As List  
    lst.Initialize  
    Dim q() As String = Regex.Split("'", s & Chr(255))  
    If q.Length Mod 2 = 1 Then  
        For i = 0 To q.length - 2 Step 2  
            Dim w() As String = Regex.Split(",", q(i))  
            For j = 0 To w.Length - 2  
                lst.add(w(j))  
            Next  
            lst.Add(q(i + 1))  
        Next  
    End If  
    Return lst  
End Sub  
  
Sub SB As StringBuilder        'ignore  
    Dim sbx As StringBuilder  
    sbx.Initialize  
    Return sbx  
End Sub
```

  
  
Usage   
  

```B4X
    Dim myName As String = "William, Lancee"  
    Dim mp As Map = NU.Map($"1:A, 2:B, 3:C, 'NAME:${myName}', 5:DDDD"$)  
    Dim lst As List = NU.List("cat, dog, giraffe, 'rabbit, out of a hat'")  
  
    Log(mp.Get("name"))        'William, Lancee  
    Log(lst.Get(3))            'rabbit, out of a hat
```
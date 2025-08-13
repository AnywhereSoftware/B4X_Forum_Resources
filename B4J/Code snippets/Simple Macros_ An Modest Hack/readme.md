### Simple Macros: An Modest Hack by William Lancee
### 09/07/2023
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/150587/)

Recently there was a post about sum++.  
<https://www.b4x.com/android/forum/threads/is-there-a-shortcut-like-to-add-1-to-a-same-variable.150349/>  
  
It made me think. Not really about ++ and – but about a lot of code sections that we all repeatedly type.  
So simple macros. A single variable name as an parameter and one or more lines of generated code.  
Because of the fx.Clipboard object, it is most convenient to implement it in B4J (but using the Log instead, could be done in B4A and B4i)  
  
For this to be useful, the amount of typing has to be minimal. I chose the following schema, but you can make your own.  
To stop the IDE from complaining I start a macro with a single quote. This is followed by the name of the variable.  
And this is immediately followed by the name of the macro.  
  
In my scheme the macro names are two or three characters from the top of a standard keyboard.  
(Loosely: ^=initialize \*=list @=map ~=stringbuilder)  
  
The generated code is shown below the macro reference in the examples.  
  

```B4X
    'x++  
    x = x + 1  
  
    'y–  
    y = y - 1  
  
    'sb~^  
    Dim sb As StringBuilder  
    sb.Initialize  
  
    'bList*^  
    Dim bList As List  
    bList.Initialize  
      
    'bList*+  
    For i = 0 To bList.Size - 1  
  
    Next  
  
    'bList*-  
    For i = bList.Size - 1 To 0 Step -1  
  
    Next  
      
    'blist*s  
    For Each str As String In bList  
  
    Next  
      
    'aMap@^  
    Dim aMap As Map  
    aMap.Initialize  
      
    'aMap@s  
    For Each str As String In aMap.Keys  
  
    Next  
      
    applyMacros
```

  
  
To use it:  
1. Register a Macro - add it to the smart string in "Private Sub registerMacros"  
2. Highlight the macro reference - Cntl C to copy to clipboard   
3. Run applyMacros (this can be done each time you need it or for a cluster of macros)  
4. Paste the generated code (You can leave the macro reference or delete it)  
  
Non-macro lines on the clipboard are ignored, it doesn't hurt to include them on the clipboard.  
  

```B4X
Private Sub registerMacros  
    macros.Initialize        'macros is a global map  
    Dim m As String = $"  
++    ? = ? + 1  
–    ? = ? - 1  
*^    Dim ? As List|?.Initialize  
@^    Dim ? As Map|?.Initialize  
~^    Dim ? As StringBuilder|?.Initialize  
*+    For i = 0 To ?.Size - 1||Next  
*-    For i = ?.Size - 1 To 0 Step -1||Next  
()+    For i = 0 To ?.Length - 1||Next  
()-    For i = ?.Length - 1 To 0 Step -1||Next  
*i    For Each itm As Int In ?||Next  
*o    For Each obj As Object In ?||Next  
*s    For Each str As String In ?||Next  
@i    For each itm As Int In ?.Keys||Next  
@o    For each obj As Object In ?.Keys||Next  
@s    For each str As String In ?.Keys||Next  
    "$  
    Dim v() As String = Regex.Split(CRLF, m)  
    For Each s As String In v  
        s = s.trim  
        If s.Length > 0 Then  
            Dim w() As String = Regex.Split(TAB, s)  
            macros.Put(w(0), w(1))  
        End If  
    Next  
End Sub  
  
Private Sub applyMacros  
    Dim s As String = fx.clipboard.GetString  
    Dim v() As String = Regex.Split(CRLF, s)  
    Dim sb As StringBuilder  
    sb.Initialize  
    For Each t As String In v  
        t = t.trim  
        If t.StartsWith("'") Then  
            For Each kw As String In macros.keys  
                If t.EndsWith(kw) Then  
                    Dim vname As String = t.SubString2(1, t.IndexOf(kw))  
                    Dim g As String = macros.Get(kw)  
                    sb.Append(TAB).Append(g.replace("?", vname).Replace("|", CRLF)).Append(CRLF)  
                End If  
            Next  
        End If  
    Next  
    fx.clipboard.SetString(sb.toString)        'fx needs to be defined in global  
    'You could also put sb.toString on the Log and cut and paste from there when needed.  
End Sub
```

  
  
If you're offended by the ugliness of this hack, turn your eyes away and ignore it.  
Or offer something more elegant.
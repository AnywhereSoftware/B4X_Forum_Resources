### Word wrap paragraph text to specified maximum characters line length by emexes
### 11/11/2022
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/144078/)

We needed to do some word-wrapping re: [this thread](https://www.b4x.com/android/forum/threads/make-a-pdf-file-with-large-text.143819/#post-913037) and figured I may as well post my tawdry effort in case anybody else is looking for ideas ? or code to hang s\*\*t on ?  
  
It has some niceish bonus features like:  
  
- if the first line of the paragraph is indented, then it can indent the entire paragraph accordingly (or just the first line, or just ignore leading spaces altogether)  
- it wraps on other reasonable-to-wrap-on characters like hyphens, ampersands, commas, semicolons ie not just the usual boring spaces  
  
If you use this word-wrapping routine:  
  

```B4X
Sub WrapParagraph(S As String, LineLength As Int) As String()  
   
    Dim IndentMode As Int = 2    '0 = none, 1 = first line only, 2 = entire paragraph  
  
    If IndentMode = 0 Then  
        Dim IndentSpaces As Int = 0  
    Else  
        Dim IndentSpaces As Int = (S & ".").Length - (S & ".").Trim.Length    'number of leading spaces of S  
    End If  
   
    Dim ParagraphLines As List  
    ParagraphLines.Initialize  
   
    Dim StillToWrap As String = S.Trim    'leading spaces not lost: (optionally) reincarnated by IndentSpaces  
   
    Do While True    'poor man's do : loop until  
        Dim WrapLength As Int = LineLength - IndentSpaces  
    
        If StillToWrap.Length > WrapLength Then    'doesn't fit = need to wrap  
            Dim TrimToLength As Int = WrapLength    'start off assuming worst case line split  
            If StillToWrap.CharAt(WrapLength) <> " " Then  
                For I = WrapLength - 1 To 1 Step -1    'look for less-worse line split  
                    Select Case StillToWrap.CharAt(I)  
                        Case " "                        'wrap at space character  
                            TrimToLength = I  
                            I = -999    'poor man's exit for  
                        
                        Case "-", "+", ",", "&", ";"    'or these other usually-good-to-wrap-on characters  
                            TrimToLength = I + 1  
                            I = -999    'poor man's exit for  
                        
                    End Select  
                Next  
            End If  
        
            Dim ThisLine As String = StillToWrap.SubString2(0, TrimToLength).Trim  
            StillToWrap = StillToWrap.SubString(TrimToLength).Trim  
        Else    'already fits = no need to wrap  
            Dim ThisLine As String = StillToWrap  
            StillToWrap = ""  
        End If  
  
        If IndentSpaces <> 0 And ThisLine.Length <> 0 Then  
            Dim sb As StringBuilder  
            sb.Initialize  
            For I = 1 To IndentSpaces  
                sb.Append(" ")  
            Next  
            ThisLine = sb.Append(ThisLine).ToString    'add indent spaces to start of string  
        End If  
    
        ParagraphLines.Add(ThisLine)  
    
        If IndentMode = 1 Then IndentSpaces = 0    'if only indent first line then "turn off" for rest of lines  
    
        If StillToWrap.Length = 0 Then    'poor man's do : loop until  
            Exit  
        End If  
    Loop  
        
    Return ListToStringArray(ParagraphLines)  
   
End Sub
```

  
  
and helper routine:  
  

```B4X
Sub ListToStringArray(L As List) As String()  
   
    Dim SA(L.Size) As String  
    For I = 0 To L.Size - 1  
        SA(I) = L.Get(I)  
    Next  
   
    Return SA  
  
End Sub
```

  
  
and test it with:  
  

```B4X
Dim Test1 As String = "Now is the time for all good men to come to the first-aid of the rock&roll party."  
Dim Test2 As String = Test1 & "  " & Test1  
Dim Test3 As String = Test2 & "  " & Test2  
Dim Test4 As String = Test3 & "  " & Test3  
Dim Test5 As String = Test4 & "  " & Test4  
  
Dim UseTest As String = Test3  
  
Dim S() As String = WrapParagraph(UseTest, 35)    'widths 19, 23, 35 have breaks on both "-" and "&"  
  
Log(UseTest)  
Log(UseTest.Length & " character paragraph wrapped to " & S.Length & " lines")  
For I = 0 To S.Length - 1  
    Log(I & TAB & S(I).Length & TAB & """" & S(I) & """")  
Next
```

  
  
then you should get something like this:  
  

```B4X
Waiting for debugger to connect…  
Program started.  
Now is the time for all good men to come to the first-aid of the rock&roll party.  Now is the time for all good men to come to the first-aid of the rock&roll party.  Now is the time for all good men to come to the first-aid of the rock&roll party.  Now is the time for all good men to come to the first-aid of the rock&roll party.  
330 character paragraph wrapped to 10 lines  
0    35    "Now is the time for all good men to"  
1    34    "come to the first-aid of the rock&"  
2    32    "roll party.  Now is the time for"  
3    34    "all good men to come to the first-"  
4    35    "aid of the rock&roll party.  Now is"  
5    33    "the time for all good men to come"  
6    33    "to the first-aid of the rock&roll"  
7    31    "party.  Now is the time for all"  
8    33    "good men to come to the first-aid"  
9    23    "of the rock&roll party."  
Call B4XPages.GetManager.LogEvents = True to enable logging B4XPages events.
```
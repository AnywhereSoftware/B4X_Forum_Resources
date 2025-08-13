### Compare text strings by emexes
### 03/03/2024
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/159635/)

Written last century, resurrection prompted by [related question in Spanish forum](https://www.b4x.com/android/forum/threads/comparar-strings.159623/)  
  
It is a very nice algorithm, even if I do say so myself. ?   
  

```B4X
Dim S1 As String = "Now is the time for all good men to come to the aid of the party"  
Dim S2 As String = "It was the time for good women to come to the aid of the men too"  
  
Log("S1 = """ & S1 & """")  
Log("S2 = """ & S2 & """")  
Log("TO GET FROM S1 TO S2:")  
WhatChanged(S1, S2)  
  
Sub WhatChanged(S1 As String, S2 As String)  
    If S1.Length = 0 And S2.Length = 0 Then  
        'nothing to do  
    else if S1.Length = 0 Then  
        Log("delete """ & S2 & """")  
    else if S2.Length = 0 Then  
        Log("add """ & S1 & """")  
    Else  
        For L = S1.Length To 5 Step -1    'less than 5 = just do replacement  
            For P1 = 0 To S1.Length - L  
                Dim LookFor As String = S1.SubString2(P1, P1 + L)  
                Dim P2 As Int = S2.IndexOf(LookFor)  
                If P2 >= 0 Then  
                    WhatChanged(S1.SubString2(0, P1), S2.SubString2(0, P2))  
                    Log("keep """ & LookFor & """")  
                    WhatChanged(S1.SubString(P1 + L), S2.SubString(P2 + L))  
                    Return  
                End If  
            Next  
        Next  
        Log("replace """ & S1 & """ with """ & S2 & """")  
    End If  
End Sub
```

  

```B4X
Waiting for debugger to connect…  
Program started.  
S1 = "Now is the time for all good men to come to the aid of the party"  
S2 = "It was the time for good women to come to the aid of the men too"  
TO GET FROM S1 TO S2:  
replace "Now i" with "It wa"  
keep "s the time for "  
replace "all good " with "good wo"  
keep "men to come to the aid of the "  
replace "party" with "men too"
```
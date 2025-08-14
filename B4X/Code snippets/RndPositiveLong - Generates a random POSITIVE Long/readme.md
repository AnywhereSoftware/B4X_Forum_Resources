###  RndPositiveLong - Generates a random POSITIVE Long by LucaMs
### 07/17/2025
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/167820/)

Cross‑platform random 62‑bit generator (non‑negative values from 0 to 2^62−1),  
  

```B4X
'Generates a random non-negative Long number.  
Public Sub RndPositiveLong As Long  
    ' Generates two random Ints up to 2^31−1 and combines them.  
    Dim High As Long = Rnd(0, 2147483647) ' 31 bits  
    Dim Low As Long = Rnd(0, 2147483647) ' another 31 bits  
    ' Move High 31 places and add Low.  
    Return High * 2147483648 + Low  
End Sub
```
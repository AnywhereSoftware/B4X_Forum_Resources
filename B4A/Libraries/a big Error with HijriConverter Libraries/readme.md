### a big Error with HijriConverter Libraries by Alhootti
### 03/23/2024
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/160055/)

Hello everybody  
i using this Libraries since long time without any error but in couple of days i advanced the date to 2025 i find out this unexpected error.  
when i want convert Hijri date to Gregorian by using the following code :  

```B4X
Dim Meladi As List = HijriConverter.HijriToGregorian("1445","09","01" )
```

  
the result id 30/02/2025 it must be 01/03/2025  
February has maximum of 29 days on leap years. On 2025, it only has 28 days.  
  
How we can solve this issue?  
  

```B4X
Sub HijriToGregorian( Y As Int,M As Int,D As Int) As Long  
    Dim jd As Long  
    Dim I As Long  
    Dim N As Long  
    Dim J As Long  
    Dim K As Long  
    Dim H As Long  
  
    jd = Fix((11 * Y + 3) / 30) + 354 * Y + 30 * M - Fix((M - 1) / 2) + D + 1948440 - 385  
    If jd > 2299160 Then  
        I = jd + 68569  
        N = Fix((4 * I) / 146097)  
        I = I - Fix((146097 * N + 3) / 4)  
        H = Fix((4000 * (I + 1)) / 1461001)  
        I = I - Fix((1461 * H) / 4) + 31  
        J = Fix((80 * I) / 2447)  
        D = I - Fix((2447 * J) / 80)  
        I = Fix(J / 11)  
        M = J + 2 - 12 * I  
        Y = 100 * (N - 49) + H + I  
    Else  
        J = jd + 1402  
        K = Fix((J - 1) / 1461)  
        I = J - 1461 * K  
        N = Fix((I - 1) / 365) - Fix(I / 1461)  
        H = I - 365 * N + 30  
        J = Fix((80 * H) / 2447)  
        D = H - Fix((2447 * J) / 80)  
        H = Fix(J / 11)  
        M = J + 2 - 12 * H  
        Y = 4 * K + N + H - 4716  
    End If  
    DateTime.DateFormat="dd/MM/yyyy"  
    Return DateTime.DateParse(D&"/"&M&"/"&Y)  
End Sub  
Sub GregorianToHijri(TheDate As Long) As List  
    Dim jd As Long  
    Dim I As Long  
    Dim N As Long  
    Dim J As Long  
   
  
    Dim D As Long  
    Dim M As Long  
    Dim Y As Long  
  
    D = DateTime.GetDayOfMonth( TheDate)  
    M = DateTime.getMonth(TheDate)  
    Y = DateTime.GetYear(TheDate)  
    If ((Y > 1582) Or ((Y = 1582) And (M > 10)) Or ((Y = 1582) And (M = 10) And (D > 14))) Then  
        jd = Fix((1461 * (Y + 4800 + Fix((M - 14) / 12))) / 4) + Fix((367 * (M - 2 - 12 * (Fix((M - 14) / 12)))) / 12) - Fix((3 * (Fix((Y + 4900 + Fix((M - 14) / 12)) / 100))) / 4) + D - 32075  
    Else  
        jd = 367 * Y - Fix((7 * (Y + 5001 + Fix((M - 9) / 7))) / 4) + Fix((275 * M) / 9) + D + 1729777  
    End If  
    I = jd - 1948440 + 10632  
    N = Fix((I - 1) / 10631)  
    I = I - 10631 * N + 354  
    J = (Fix((10985 - I) / 5316)) * (Fix((50 * I) / 17719)) + (Fix(I / 5670)) * (Fix((43 * I) / 15238))  
    I = I - (Fix((30 - J) / 15)) * (Fix((17719 * J) / 50)) - (Fix(J / 16)) * (Fix((15238 * J) / 43)) + 29  
    M = Fix((24 * I) / 709)  
    D = I - Fix((709 * M) / 24)  
    Y = 30 * N + J - 30  
    Return Array (Y,M,D)  
End Sub  
Sub Fix(arg As Int) As Int  
    Return Ceil(arg)  
End Sub
```
###  Format 10,000 (Ten Thousand) to Lakh by aeric
### 07/12/2021
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/132212/)

**B4J 2.80+**  

```B4X
Sub FormatLakh(number As Double, decimals As Int) As String  
    Dim dd As Int, ss As String  
    Dim mm As Long = Abs(number)  
    Dim nn As Long = mm / 1000  
    Dim dc As Double = (mm Mod 1000) + Abs(number) - mm  
    Dim lakh As String = NumberFormat2(dc, 1, decimals, decimals, False)  
    Do Until (nn < 100)  
        dd = nn Mod 100 : nn = nn / 100  
        If ss <> "" Then ss = $",${ss}"$  
        If dd < 10 Then ss = $"0${dd}${ss}"$ Else ss = $"${dd}${ss}"$  
    Loop  
    If nn > 0 Then  
        If (mm Mod 1000) >= 10 And (mm Mod 1000) < 100 Then lakh = $"0${lakh}"$  
        If (mm Mod 1000) < 10 Then lakh = $"00${lakh}"$  
    End If  
    If ss <> "" Then lakh = $"${ss},${lakh}"$  
    If nn > 0 Then lakh = $"${nn},${lakh}"$  
    If number < 0 Then lakh = $"-${lakh}"$  
    Return lakh  
End Sub
```

  
  

```B4X
' Using BigNumbers library (B4A, B4J)  
' Library: https://www.b4x.com/android/forum/threads/bignumbers-library.9540/  
' Note: The 5th parameter Unused can be removed. It's a dummy so that the function signature same as NumberFormat2 for quick replace.  
Sub LakhFormat2(Number As String, MinIntegers As Int, MaxFractions As Int, MinFractions As Int, Unused As Boolean) As String  
    Dim bi, si, mm, nn, threedigit, thousand, hundred, ten, zero As BigInteger  
    Dim bd, sd, od, ad As BigDecimal  
    thousand.Initialize3(1000)  
    hundred.Initialize3(100)  
    ten.Initialize3(10)  
    zero.Initialize3(0)  
    bd.Initialize(Number)  
    od.Initialize5(bd)  
    ad.Initialize5(bd)  
    ad.Abs  
    si.Initialize6(ad)  
    mm.Initialize6(ad)  
    nn.Initialize6(ad)  
    nn.Divide(thousand)  
    threedigit.Initialize7(mm)  
    threedigit.Remainder(thousand)  
    Dim id As Int = threedigit.LongValue  
    bd.SetScale2(MaxFractions, bd.ROUND_HALF_UP)  
    bi.Initialize6(bd)  
    sd.Initialize6(bi)    
    Dim dd As Double = Abs(bd.Subtract(sd).DoubleValue)  
    Unused = False  
    Dim lakh As String = NumberFormat2(id + dd, MinIntegers, MaxFractions, MinFractions, Unused)  
    Dim sb As StringBuilder  
    sb.Initialize  
    Do Until (nn.CompareTo(hundred) < 0)  
        si.Initialize7(nn)  
        si.Remainder(hundred)  
        nn.Divide(hundred)  
        If sb.Length > 0 Then sb.Insert(0, ",")  
        If si.CompareTo(ten) < 0 Then sb.Insert(0, $"0${si.LongValue}"$) Else sb.Insert(0, $"${si.LongValue}"$)  
    Loop  
    If nn.CompareTo(zero) > 0 Then  
        If id >= 10 And id < 100 Then lakh = $"0${lakh}"$  
        If id < 10 Then lakh = $"00${lakh}"$  
    End If  
    If sb.Length > 0 Then lakh = $"${sb.ToString},${lakh}"$  
    If nn.LongValue > 0 Then lakh = $"${nn.LongValue},${lakh}"$  
    If od.DoubleValue < 0 Then lakh = $"-${lakh}"$  
    Return lakh  
End Sub
```

  
  
**Edit (10 Jul 2021): Bug fixed for 1,001.00 and 1,00,000.00**  
There are known issue with number > 10,000,000,000,000 (1,00,00,00,00,00,000)  
<https://www.b4x.com/android/forum/threads/doubt-on-number-format.132150/post-834354>  
  
****Edit (12 Jul 2021): LakhFormat2****  
Pass number as String to support big numbers  
e.g:   

```B4X
Log(NumberFormat2(-67891245678912345678910.5553, 1, 2, 2, True))    ' Input number converted to Double    –>     -67,891,245,678,912,340,000,000.00  
Log(LakhFormat2(-67891245678912345678910.5553, 1, 2, 2, True))      ' Input number converted to Double    –>  -67,89,12,45,67,89,12,34,00,00,000.00  
Log(LakhFormat2("-67891245678912345678910.5553", 1, 2, 2, True))    ' Input number as String              –>  -67,89,12,45,67,89,12,34,56,78,910.56
```
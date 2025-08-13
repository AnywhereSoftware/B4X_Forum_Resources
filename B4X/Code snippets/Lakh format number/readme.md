###  Lakh format number by TILogistic
### 08/04/2023
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/132433/)

Attached is a demo and code to convert numbers to Lakh format.  
  
**UPDATE:**  
Formatting using the B4XFormatter library.  
Ref:  
<https://www.b4x.com/android/forum/threads/convert-number-into-lakhs-with-decimal.149419/>  
> NumberFormatLakh(250000, 1, 2)

  
![](https://www.b4x.com/android/forum/attachments/144441) ![](https://www.b4x.com/android/forum/attachments/144444)  
   

```B4X
'Converts the specified number to a string in "Lakh" format.  
'The string will include at least Minimum Integers and at most Maximum Fractions digits.  
'Example:  
'Log(NumberFormatLakh(123456.6789, 0, 2)) '"1,23,456.68"  
'Log(NumberFormatLakh(123456, 7 ,0)) '"01,23,456"  
Public Sub NumberFormatLakh(Number As Double, MinimumIntegers As Int, MaximumFractions As Int) As String  
    Dim value() As String = Regex.Split("\.",SetFormmatter(Number, MinimumIntegers, MaximumFractions))  
    Dim sb As StringBuilder  
    sb.Initialize  
    Dim sw As Boolean  
    For i = value(0).Length - 1 To 0 Step - 1  
        If (sb.ToString.Length < 3) Then  
            sb.Append(value(0).CharAt(i))  
            Continue  
        End If  
        If Not(sw Or value(0).CharAt(i) = "-") Then  
            sb.Append(",").append(value(0).CharAt(i))  
            sw = True  
        Else  
            sb.append(value(0).CharAt(i))  
            sw = False  
        End If  
    Next  
    Dim result As StringBuilder  
    result.Initialize  
    For i = sb.Length - 1 To 0 Step - 1  
        result.Append(sb.ToString.CharAt(i))  
    Next  
    If value.Length > 1 Then  
        result.Append(".").Append(value(1))  
    End If  
    Return result  
End Sub  
  
Public Sub SetFormmatter(iNumber As Double, iMinimumIntegers As Int, iMaximumFractions As Int) As String  
    Dim Formatter As B4XFormatter  
    Formatter.Initialize  
    Formatter.GetDefaultFormat.GroupingCharacter = ""  
    Formatter.GetDefaultFormat.DecimalPoint = "."  
    Formatter.GetDefaultFormat.MinimumIntegers  = iMinimumIntegers  
    Formatter.GetDefaultFormat.MaximumFractions = iMaximumFractions  
    Formatter.GetDefaultFormat.MinimumFractions = iMaximumFractions  
    Formatter.GetDefaultFormat.FractionPaddingChar = "0"  
    Return Formatter.Format(iNumber)  
End Sub
```

  
TEST:
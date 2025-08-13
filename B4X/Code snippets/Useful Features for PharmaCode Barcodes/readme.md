###  Useful Features for PharmaCode Barcodes by TILogistic
### 04/29/2024
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/160846/)

These are some useful functions for Pharmacode barcodes.  
  
1. Generate Digit Verifier  

```B4X
Public Sub PharmacodeDigitVerifier(Value As String) As String  
    Dim Result As String  
   
    If Not (Regex.IsMatch("[0-9]+", Value)) Then Return Result 'Invalid  
    If Not (Value.Length < 9) Then Return Result 'too long  
   
    Dim Base32Value As StringBuilder  
    Base32Value.Initialize  
   
    For Each s As String In Regex.Split("", Value)  
        Base32Value.Append(s)  
    Next  
   
    'Fill with zeros  
    For i = 1 To 8 - Base32Value.Length  
        Base32Value.Insert(0,"0")  
    Next  
   
    ' Calculate digit  
    Dim CheckValue() As String, CheckSum As Int, Checkpart As Int  
    CheckValue = Regex.Split("", Base32Value.ToString)  
    For i = 0 To 3  
        Checkpart = CheckValue(i * 2)  
        CheckSum  = CheckSum + Checkpart  
        Checkpart = CheckValue((i * 2) + 1) * 2  
        If Checkpart >= 10 Then  
            CheckSum = CheckSum + (Checkpart - 10) + 1  
        Else  
            CheckSum = CheckSum + Checkpart  
        End If  
    Next  
   
    ' Add digit  
    Dim Digit As Int = CheckSum Mod 10  
    Result = Base32Value.Append(Digit).ToString  
    Return Result  
End Sub
```

  
  
2. Convert Decimal to Base32  

```B4X
Public Sub DecimalToBase32(DecimalValue As Int) As String  
    Dim Base32Chars As String = "0123456789BCDFGHJKLMNPQRSTUVWXYZ"  
    Dim Base32Value As StringBuilder  
    Base32Value.Initialize  
    Do While DecimalValue > 0  
        Dim Remainder As Int = DecimalValue Mod 32  
        Base32Value.Insert(0,Base32Chars.CharAt(Remainder))  
        DecimalValue = DecimalValue / 32  
    Loop  
    Return Base32Value.ToString  
End Sub
```

  
  
3. Convert Base32 to Decimal  

```B4X
Public Sub Base32ToDecimal(Base32Value As String) As Long  
    Dim Base32Chars As String = "0123456789BCDFGHJKLMNPQRSTUVWXYZ"  
    Dim DecimalValue As Long  
    Dim Exponent As Long  
    For i = Base32Value.Length - 1 To 0 Step - 1  
        DecimalValue = DecimalValue + (Base32Chars.IndexOf(Base32Value.CharAt(i)) * Power(32, Exponent))  
        Exponent = Exponent + 1  
    Next  
    Return DecimalValue  
End Sub
```

  
  
**Test:**  

```B4X
Public Sub TestBase32  
    Dim Value As String = 123456  
   
    Value = PharmacodeDigitVerifier(Value)  
    Log("A" & Value)  
   
    Value = DecimalToBase32(Value)  
    Log(Value)  
   
    Value = Base32ToDecimal(Value)  
    Log(Value)  
End Sub
```

  
  
**Result:**  
![](https://www.b4x.com/android/forum/attachments/153246)  
  
ref.  
<https://github.com/woo-j/OkapiBarcode/blob/master/src/main/java/uk/org/okapibarcode/backend/Code32.java>  
<https://www.computalabel.com/aboutpharmacodes.htm>  
  
**Your comments will be welcome.**
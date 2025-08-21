### Decimal Number to Greek Words - Olografos by makis_best
### 10/07/2019
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/110275/)

With this example I show how a decimal number can be translated to Greek words.  
  
For example: Log(DeployCurrencyToText(1234.04)) give the result χίλια διακόσια τριάντα τέσσερα ευρώ και τέσσερα λεπτά  
  
The code is   

```B4X
Sub DeployCurrencyToText(TheDouble As Double) As String  
    Dim Olografos As StringBuilder  
    Olografos.Initialize  
    Dim DoubleForRegex As String = NumberFormat2(TheDouble, 2, 2, 2, False)  
    Dim Buffer() As String  
    Buffer = Regex.Split("\.", DoubleForRegex)  
    Olografos.Append(CurrencyToText(Buffer(0)) & "ευρώ ").Append("και " & CurrencyToText(Buffer(1)) & " λεπτά")  
    Return Olografos.ToString  
End Sub  
  
  
Sub CurrencyToText(curamount As Double) As String  
    Dim curhmth, curtmth, curmth, curhth, curtth, curth, curh, curt, curo As Int  
    If curamount < 0 Then  
        Return False  
    End If  
    curhmth = (curamount / 100000000)  
    curtmth = (((curamount) Mod 100000000) / 10000000)  
    curmth = (((curamount) Mod 10000000) / 1000000)  
    curhth = (((curamount) Mod 1000000) / 100000)  
    curtth = (((curamount) Mod 100000) / 10000)  
    curth = (((curamount) Mod 10000) / 1000)  
    curh = (((curamount) Mod 1000) / 100)  
    curt = (((curamount) Mod 100) / 10)  
    curo = (((curamount) Mod 10))  
    Dim curarray1() As String = Array("μια", "δύο", "τρεις", "τέσσερις", "πέντε", "έξι", "επτά", "οκτώ", "εννέα")  
    Dim curarray2() As String = Array("δέκα", "έντεκα", "δώδεκα", "δεκατρείς", "δεκατέσσερις", "δεκαπέντε", "δεκαέξι", "δεκαεπτά", "δεκαοκτώ", "δεκαεννέα")  
    Dim curarray3() As String = Array("", "είκοσι", "τριάντα", "σαράντα", "πενήντα", "εξήντα", "εβδομήντα", "ογδόντα", "ενενήντα")  
    Dim curarray4() As String = Array("εκατό", "διακόσιες", "τριακόσιες", "τετρακόσιες", "πεντακόσιες", "εξακόσιες", "επτακόσιες", "οκτακόσιες", "εννιακόσιες")  
    Dim curarray5() As String = Array("ένα", "δύο", "τρία", "τέσσερα", "πέντε", "έξι", "επτά", "οκτώ", "εννέα")  
    Dim curarray6() As String = Array("εκατό", "διακόσια", "τριακόσια", "τετρακόσια", "πεντακόσια", "εξακόσια", "επτακόσια", "οκτακόσια", "εννιακόσια")  
    Dim curarray7() As String = Array("δέκα", "έντεκα", "δώδεκα", "δεκατρία", "δεκατέσσερα", "δεκαπέντε", "δεκαέξι", "δεκαεπτά", "δεκαοκτώ", "δεκαεννέα")  
    Dim part1m, part2m, part3m, part4m, part1, part2, part3, part4, part5, part6, part7 As String  
    If curhmth = 0 Then  
         part1m = ""  
    Else  
        part1m = curarray6(curhmth - 1) & " "  
    End If  
    If curtmth = 0 Then  
        part2m = ""  
    Else If curtmth = 1 Then  
        part2m = curarray7(curtmth - 1 + curmth - 1) & " "  
    Else  
        part2m = curarray3(curtmth - 1) & " "  
    End If  
    If curmth = 0 Or curtmth = 1 Then  
        part3m = ""  
    Else  
        part3m = curarray5(curmth - 1) & " "  
    End If  
    If curhmth = 0 And curtmth = 0 And curmth = 0 Then  
        part4m = ""  
    Else If curhmth = 0 And curtmth = 0 And curmth = 1 Then  
        part4m = "εκατομμύριο "  
    Else  
        part4m = "εκατομμύρια "  
    End If  
    If curhth = 0 Then  
        part1 = ""  
    Else  
        part1 = curarray4(curhth - 1) & " "  
    End If  
    If curtth = 0 Then  
        part2 = ""  
    Else If curtth = 1 Then  
        part2 = curarray2(curtth - 1 + curth - 1) & " "  
    Else  
        part2 = curarray3(curtth) & " "  
    End If  
    If curth = 0 Or curtth = 1 Then  
        part3 = ""  
    Else If curhth = 0 And curtth = 0 And curth = 1 Then  
        part3 = "χίλια "  
    Else  
        part3 = curarray1(curth - 1) & " "  
    End If  
    If curhth = 0 And curtth = 0 And curth = 0 Then  
        part4 = ""  
    Else If curhth = 0 And curtth = 0 And curth = 1 Then  
        part4 = ""  
    Else  
        part4 = "χιλιάδες "  
    End If  
    If curh = 0 Then  
        part5 = ""  
    Else  
        part5 = curarray6(curh - 1) & " "  
    End If  
    If curt = 0 Then  
        part6 = ""  
    Else If curt = 1 Then  
        part6 = curarray7(curt - 1 + curo) & " "  
    Else  
        part6 = curarray3(curt - 1) & " "  
    End If  
    If curamount < 1 Then  
        part7 = "μηδέν "  
    Else If curo = 0 Or curt = 1 Then  
        part7 = ""  
    Else  
        part7 = curarray5(curo - 1) & " "  
    End If  
          
    Return part1m & part2m & part3m & part4m & part1 & part2 & part3 & part4 & part5 & part6 & part7  
  
End Sub
```
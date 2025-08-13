### Valid EAN13 Barcode String by Hamied Abou Hulaikah
### 10/18/2022
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/143608/)

Generate random valid EAN13 barcode string:  

```B4X
Public Sub BarcodeEAN13() As String  
      
    Dim brcod As String = Rnd(100000000,214000000)  
    brcod = "950" & brcod  '<<< change the beginning 3 digits according country, see: https://en.wikipedia.org/wiki/List_of_GS1_country_codes  
      
    Dim x As Int = 0  
    If brcod.Length=12 Then  
        Dim odds,evens As List  
        odds.Initialize  
        evens.Initialize  
        For i=0 To 11  
            If i=0 Or i=2 Or i=4 Or i=6 Or i=8 Or i=10 Then odds.Add(brcod.CharAt(i))  
            If i=1 Or i=3 Or i=5 Or i=7 Or i=9 Or i=11 Then evens.Add(brcod.CharAt(i))  
        Next  
        Dim od As Int = odds.Get(0) + odds.Get(1) +odds.Get(2) +odds.Get(3) +odds.Get(4) +odds.Get(5)  
        Dim ev As Int = (evens.Get(0) + evens.Get(1) +evens.Get(2) +evens.Get(3) +evens.Get(4) +evens.Get(5)) * 3  
        Dim tt As String = od + ev  
        Dim ld As String = tt.SubString2(tt.Length-1,tt.Length)  
        If ld=0 Then  
            x = 0  
        Else  
            x = 10 - ld  
        End If  
    End If  
      
    Return brcod & x  
      
End Sub
```

  
How to draw it see [this](https://www.b4x.com/android/forum/threads/creating-1d-and-2d-barcodes-using-inline-java-code-and-the-zxing-core-library.60831/#content).
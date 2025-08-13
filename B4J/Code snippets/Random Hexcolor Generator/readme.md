### Random Hexcolor Generator by Mashiane
### 10/18/2022
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/143597/)

Ola…  
  
I needed something like this… here we go…  
  

```B4X
'generate a random hex color  
Sub RandomHexColor As String  
    Dim shex As StringBuilder  
    shex.initialize  
    shex.append("#")  
     
    Dim hexValues As List  
    hexValues.Initialize  
    hexValues.AddAll(Array(0, 1 , 2 , 3 ,4 ,5 , 6 , 7 , 8 , 9, "A", "B", "C", "D", "E", "F"))  
    '  
    Dim i As Int  
    For i = 0 To 5  
        Dim idx As Int = Rnd(0, hexValues.Size)  
        Dim hvalue As String = hexValues.Get(idx)  
        shex.Append(hvalue)  
    Next  
    Return shex.tostring  
End Sub
```

  
  
Update: Oops, fixed **Rnd** 2nd parameter to be (exclusive)
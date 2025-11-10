###  String Similarity - Levenshtein distance by Magma
### 11/07/2025
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/169247/)

<https://en.wikipedia.org/wiki/Levenshtein_distance>  
  

```B4X
Sub StringSimilarity(str1 As String, str2 As String) As Double  
  
    Dim i As Int, j As Int, len1 As Int, len2 As Int  
    Dim cost As Int, delCost As Int, insCost As Int, subCost As Int, levenshtein As Int  
    Dim d(0, 0) As Int  
      
    str1 = str1.ToUpperCase  
    str2 = str2.ToUpperCase  
    len1 = str1.Length  
    len2 = str2.Length  
      
    Dim d(len1 + 1, len2 + 1) As Int  
      
    For i = 0 To len1  
        d(i, 0) = i  
    Next  
      
    For j = 0 To len2  
        d(0, j) = j  
    Next  
      
    For i = 1 To len1  
        For j = 1 To len2  
            If str1.CharAt(i - 1) = str2.CharAt(j - 1) Then  
                cost = 0  
            Else  
                cost = 1  
            End If  
              
            delCost = d(i - 1, j) + 1  
            insCost = d(i, j - 1) + 1  
            subCost = d(i - 1, j - 1) + cost  
              
            d(i, j) = Min3(delCost, insCost, subCost)  
        Next  
    Next  
      
    levenshtein = d(len1, len2)  
    Dim maxLen As Int  
      
    If len1 > len2 Then  
        maxLen = len1  
    Else  
        maxLen = len2  
    End If  
      
    If maxLen = 0 Then  
        Return 100  
    Else  
        Return NumberFormat2((1 - (levenshtein / maxLen)) * 100, 1, 2, 2, False)  
    End If  
End Sub  
  
Private Sub Min3(a As Int, b As Int, c As Int) As Int  
    If a <= b And a <= c Then  
        Return a  
    Else If b <= a And b <= c Then  
        Return b  
    Else  
        Return c  
    End If  
End Sub
```

  
  
**How to use it ?**  

```B4X
    Log("test | toast")  
    Log(StringSimilarity("test","toast") & "%")
```

  
  
Result:  
![](https://www.b4x.com/android/forum/attachments/168190)  
  
Happy Coding!
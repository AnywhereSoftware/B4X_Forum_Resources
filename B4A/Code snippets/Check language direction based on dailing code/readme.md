### Check language direction based on dailing code by Hamied Abou Hulaikah
### 06/06/2022
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/141018/)

```B4X
'Assume all languages are LTR direction except these:  
Public Sub isRTL(number As String) As Boolean  
    Dim b As Boolean=False  
      
    If number.StartsWith("967") Then b=True  
    If number.StartsWith("973") Then b=True  
    If number.StartsWith("98") Then b=True  
    If number.StartsWith("964") Then b=True  
    If number.StartsWith("972") Then b=True  
    If number.StartsWith("962") Then b=True  
    If number.StartsWith("965") Then b=True  
    If number.StartsWith("961") Then b=True  
    If number.StartsWith("968") Then b=True  
    If number.StartsWith("92") Then b=True  
    If number.StartsWith("970") Then b=True  
    If number.StartsWith("974") Then b=True  
    If number.StartsWith("966") Then b=True  
    If number.StartsWith("963") Then b=True  
    If number.StartsWith("971") Then b=True  
    If number.StartsWith("20") Then b=True  
    If number.StartsWith("216") Then b=True  
    If number.StartsWith("212") Then b=True  
    If number.StartsWith("213") Then b=True  
    If number.StartsWith("218") Then b=True  
    If number.StartsWith("222") Then b=True  
    If number.StartsWith("249") Then b=True  
    If number.StartsWith("211") Then b=True  
    If number.StartsWith("252") Then b=True  
      
    Return b     
End Sub
```
### [B4XLib] lmB4XPermutations by LucaMs
### 01/12/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/165073/)

Small library that generates all possible permutations of a given list of items (of any type).  
  
Library and example attached (there is no B4i example but it is a B4XPages project, just select the library and create the layout - copy it from the B4A project).  
  

```B4X
    Dim lstItems As List  
    lstItems.Initialize  
    lstItems.AddAll(Array ("A", "B", "C", "D"))  
     
    Wait For (lmB4XPermutations.Generate(lstItems)) Complete(lstPermutations As List)  
    For Each lst As List In lstPermutations  
        Logs.Text = Logs.Text & lst & CRLF 'ignore  
    Next  
     
    Logs.Text = Logs.Text & CRLF & lstPermutations.Size & " lists."
```

  
  
![](https://www.b4x.com/android/forum/attachments/160765)
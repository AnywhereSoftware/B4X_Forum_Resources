###  GUID by Erel
### 10/31/2019
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/99529/)

```B4X
Sub GUID As String  
   Dim sb As StringBuilder  
   sb.Initialize  
   For Each stp As Int In Array(8, 4, 4, 4, 12)  
       If sb.Length > 0 Then sb.Append("-")  
       For n = 1 To stp  
           Dim c As Int = Rnd(0, 16)  
           If c < 10 Then c = c + 48 Else c = c + 55  
           sb.Append(Chr©)  
       Next  
   Next  
   Return sb.ToString  
End Sub
```

  
  
Example:  

```B4X
Log(GUID)  
Log(GUID)  
Log(GUID)  
Log(GUID)
```

  
  
055AF933-59E8-C059-7291-E3BA80BD9804  
60040AA2-B054-3E3B-44D3-80616AD78915  
00A21FC9-EFFE-9C4F-9560-ABBECCA47E2E  
614B0C4D-C52B-E745-2F3C-B8ED55B67D14  
  
Code to generate UUID version 4: <https://www.b4x.com/android/forum/threads/guid-vs-uuid-can-i-use-guid-as-uuid.110970/#post-692302>
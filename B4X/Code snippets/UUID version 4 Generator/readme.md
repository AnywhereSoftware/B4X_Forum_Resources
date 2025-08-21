###  UUID version 4 Generator by mcqueccu
### 10/31/2019
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/110975/)

Extracted from this Thread:  
<https://www.b4x.com/android/forum/threads/guid-vs-uuid-can-i-use-guid-as-uuid.110970/#post-692302>  
  

```B4X
Sub UUIDv4 As String  
   Dim sb As StringBuilder  
   sb.Initialize  
   For Each stp As Int In Array(8, 4, 4, 4, 12)  
       If sb.Length > 0 Then sb.Append("-")  
       For n = 1 To stp  
           Dim c As Int = Rnd(0, 16)  
           If c < 10 Then c = c + 48 Else c = c + 55  
           If sb.Length = 19 Then c = Asc("8")  
           If sb.Length = 14 Then c = Asc("4")  
           sb.Append(Chr©)  
       Next  
   Next  
   Return sb.ToString.ToLowerCase  
End Sub
```
### Dynamic (Random String) Example by Eng. Nizar
### 02/20/2024
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/159378/)

I made Function to create a random String by asking for  
 Permission (Repeat char :True/False - Start With 0 :True/False) .  
i thing it is usefull .  

```B4X
sub random_any(allStr As String,Lngth As Int,Repeat As Boolean,Start0 As Boolean) As String  
    If allStr="" Then allStr="0123456789ABCDEFGHIJKLMNPQRSTUVWXYZ"  
    Lngth=Min(allStr.Length,Lngth)  
    Dim rndm As Int  
    Dim res As String  
    Dim trnd As Char  
    For i =0 To Lngth-1  
        rndm=Rnd(0,allStr.Length-1)  
        If i=0 And rndm=0 And Start0=False Then rndm=Rnd(1,allStr.Length-1)  
        trnd =allStr.CharAt(rndm)  
        res=res  & trnd  
        If Repeat=False Then allStr=allStr.Replace(trnd,"")  
    Next  
    Return res  
End Sub
```
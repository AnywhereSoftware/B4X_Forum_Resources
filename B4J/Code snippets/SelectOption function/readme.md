### SelectOption function by RodM
### 12/12/2021
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/136784/)

**SelectOption**  
  
I use it as a replacement of Select/Case statement, when I only have to get one result among many options.  
Most of times I think its better to use Select/Case or even If/Else.  
  
  

```B4X
Sub SelectOption(objSearch As Object, IfList As List, ThenList As List, objElse As Object) As Object  
    For i = 0 To IfList.Size - 1  
        If IfList.Get(i) = objSearch Then Return ThenList.Get(i)  
    Next  
    Return objElse   'in the case objSearch not found in IfList  
End Sub
```

  
  
Example:  

```B4X
Sub AppStart (Args() As String)  
    Dim List1 As List = Array(0, 1, 2, 3)  
    Dim List2 As List = Array("Zero", "One", "Two", "Three")  
      
    For i = 0 To 9  
        Dim a As Int = Rnd(0, 7)  
        Dim Picked As String = SelectOption(a, List1,List2, "")  
        Log(a & ", " & Picked)  
    Next  
End Sub
```
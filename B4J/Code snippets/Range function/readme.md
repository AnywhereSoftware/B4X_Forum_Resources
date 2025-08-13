### Range function by Daestrum
### 05/10/2024
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/161041/)

This may be useful.  
This little method allows you to specify a range for 'For Each' loops etc, or set an array to a range of values.  

```B4X
Sub AppStart (Args() As String)  
      
    Dim a() As Int = range(-4,4)  
      
    For Each item As Object In a  
        Log(item)  
    Next  
      
    For Each number In range(10,-9)  
        Log(number)  
    Next  
End Sub  
  
Sub range(s As Int,e As Int) As Int()  
    Dim ret(IIf(s < e ,e - s + 1,s - e + 1)) As Int  
    Dim count As Int  
  
    For a = s To e Step IIf(s<e,1,-1)  
        ret(count) = a  
        count = count + 1  
    Next  
  
    Return ret  
End Sub
```
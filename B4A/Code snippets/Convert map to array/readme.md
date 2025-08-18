### Convert map to array by toby
### 06/12/2022
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/141176/)

```B4X
public Sub mapToArray(m As Map) As Object()  
    Dim arr(m.Size * 2) As Object  'array size is double of the map because both keys and values are elements  
    Dim i As Int=0  
    Dim value As Object   
    For Each key As Object In m.Keys  
           value=m.Get(key)  
        LogColor($"key=${key}, value=${value}"$, Colors.blue)  
        arr(i)=key  
        i = i +1  
        arr(i)=value  
        i =i +1   
    Next  
      
    Return arr   
End Sub
```

  
  

```B4X
    Dim mapMonths As Map = CreateMap("January": "1", "February": "2")  
    Dim a() As Object=mapToArray(mapMonths)  
    For Each item As Object In a  
        Log(item) 'print out each array element  
    Next
```
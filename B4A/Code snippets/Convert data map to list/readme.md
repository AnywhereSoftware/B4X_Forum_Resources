### Convert data map to list by toby
### 07/01/2022
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/141527/)

```B4X
'Convert a map into a list  
'if KeyList=True, then return a list of keys, otherwise a list of values  
public Sub MapToList(myMap As Map, KeyList As Boolean) As List  
    Dim lst As List  
    lst.Initialize  
    If KeyList Then  
        For Each item As Object In myMap.Keys  
            lst.Add(item)  
        Next  
    Else  
        For Each item As Object In myMap.Values  
            lst.Add(item)  
        Next  
    End If  
          
    Return lst  
End Sub
```

  
  

```B4X
    Dim mapWeekdays As Map=CreateMap("Sunday": 1, "Monday":2, "Tuesday":3, "Wednesday":4, "Thursday":5, "Friday":6, "Saturday":7)  
    Dim lstValue As List=MapToList(mapWeekdays, False)  
   log("value list:")  
    For Each item As String In lstValue  
        Log(item)  
    Next  
    Dim lstKey As List=MapToList(mapWeekdays, True)  
   log("key list:")  
    For Each item As String In lstKey  
        Log(item)  
    Next
```

  
  
> value list:  
> 1  
> 2  
> 3  
> 4  
> 5  
> 6  
> 7

key list:  
> Sunday  
> Monday  
> Tuesday  
> Wednesday  
> Thursday  
> Friday  
> Saturday
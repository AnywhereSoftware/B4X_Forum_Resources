### [LOA] Fast range lookups based on binary search by Erel
### 09/20/2026
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/172108/)

Depends on ListOfArrays v1.01+  
  
Works with numbers or strings. Make sure to sort the LOA based on the key column.  

```B4X
'Returns a sorted LOA containing all rows where the value in the specified column is within the given range (inclusive).  
'The input LOA must be sorted by the specified column.  
Private Sub FindRange(loa As ListOfArrays, Column As Object, StartRange As Object, EndRange As Object) As ListOfArrays  
    Dim ix1 As Int = loa.BinarySearch(Column, StartRange)  
    Dim ix2 As Int = loa.BinarySearch(Column, EndRange)  
    If ix1 < 0 Then  
        ix1 = -(ix1 + 1)  
    Else  
        Do While ix1 >= 0 And SafeCompare(StartRange, loa.GetValue(ix1, Column))  
            ix1 = ix1 - 1  
        Loop  
        ix1 = ix1 + 1  
    End If  
    If ix2 < 0 Then  
        ix2 = -(ix2 + 1) - 1  
    Else  
        Do While ix2 < loa.Size And SafeCompare(EndRange, loa.GetValue(ix2, Column))  
            ix2 = ix2 + 1  
        Loop  
        ix2 = ix2 - 1  
    End If  
    ix1 = ix1 + loa.mFirstDataRowIndex  
    ix2 = ix2 + loa.mFirstDataRowIndex  
    Dim SubList As List = B4XCollections.CreateList(loa.mInternalArray.SubList(ix1, ix2 + 1))  
    If loa.FirstRowIsHeader Then  
        Return LOAUtils.WrapAddHeader(SubList, loa.Header)  
    Else  
        Return LOAUtils.WrapWithoutHeader(SubList)  
    End If  
End Sub  
  
Private Sub SafeCompare (o1 As Object, o2 As Object) As Boolean  
    If o1 Is Long Then  
        Return o1.As(Long) = o2  
    Else If o1 Is String Then  
        Return o1.As(String) = o2  
    Else  
        Return o1.As(Double) = o2  
    End If  
End Sub
```

  
  
Usage example:  

```B4X
Dim data As ListOfArrays = LOAUtils.CreateEmpty(Array("Id", "Price"))  
For i = 1 To 1000  
    data.AddRow(Array("Item #" & NumberFormat2(i, 3), Rnd(1, 1000)))  
Next  
data.Sort("Price")  
Dim r As ListOfArrays = FindRange(data, "Price", 50, 60)  
Log(r.ToString(0))
```

  
  
Output:  
Id Price (#rows=9, #cols=2)  
—————————–  
Item #648 50  
Item #951 51  
Item #347 53  
Item #042 56  
Item #263 56  
Item #240 57  
Item #311 58  
Item #677 58  
Item #086 60
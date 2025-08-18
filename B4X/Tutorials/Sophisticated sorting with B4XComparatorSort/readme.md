###  Sophisticated sorting with B4XComparatorSort by Erel
### 03/08/2022
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/139006/)

B4XCollections v1.13 includes a new sorting feature named B4XComparatorSort.  
This feature allows sorting using a custom comparator class.  
The comparator class is a class that you create and it should include a sub with the following signature:  

```B4X
'Return a positive number if o1 greater than o2 (=o1 comes after o2), 0 if o1 equals to o2 and a negative number if o1 smaller than o2.  
Public Sub Compare (o1 As Object, o2 As Object) As Int
```

  
  
For example, if we want to sort a list of strings based on the strings lengths:  

```B4X
'Return a positive number if o1 greater than o2 (=o1 comes after o2), 0 if o1 equals to o2 and a negative number if o1 smaller than o2.  
Public Sub Compare (o1 As Object, o2 As Object) As Int  
 Dim s1 As String = o1  
 Dim s2 As String = o2  
 If s1.Length > s2.Length Then  
  Return 1  
 Else If s1.Length < s2.Length Then  
  Return -1  
 Else  
  Return 0  
 End If  
'or:  
 Return s1.Length - s2.Length
```

  
  
This allows us to sort lists using all kinds of sophisticated ordering.  
Attached is an example of sorting "person" records. The fields are:  

```B4X
Type Person (Name As String, Age As Int, Status As String)
```

  
  
We want to first list the employees, sorted by their names and then sorted by their ages.  
  

```B4X
Public Sub Compare (o1 As Object, o2 As Object) As Int  
    Dim p1 As Person = o1  
    Dim p2 As Person = o2  
    If p1.Status = "Employee" And p2.Status <> "Employee" Then Return -1  
    If p2.Status = "Employee" And p1.Status <> "Employee" Then Return 1  
    If p1.Name = p2.Name Then  
        If p1.Age > p2.Age Then Return 1  
        If p1.Age < p2.Age Then Return - 1  
    End If  
    Return p1.Name.CompareTo(p2.Name)  
End Sub
```

  
  
![](https://www.b4x.com/android/forum/attachments/126447)  
  
Note that there is relatively a large difference in the performance of this sort feature between debug mode and release mode.
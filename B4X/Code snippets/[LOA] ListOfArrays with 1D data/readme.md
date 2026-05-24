### [LOA] ListOfArrays with 1D data by Erel
### 05/21/2026
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/171073/)

ListOfArrays data structure can be useful even with single dimensional data.  
LOA v0.96 adds a helper method for creating such LOAs:  

```B4X
Dim colors As ListOfArrays = LOAUtils.CreateFrom1DList("Color", Array("red", "green", "blue"))
```

  
The header is optional. Pass empty string if not needed.  
  
Another new method is ListOfArray.AddColumnWithValue. It adds a new column, filled with the same value.  
  
We have an AI generated list of names:  

```B4X
Dim Names() As String = Array As String( _  
    "John", _  
    "Emma", _  
    "Michael", _  
    "Olivia", _  
    "Daniel", _  
    "Sophia", _  
    "James", _  
    "Ava", _  
    …  
)  
    Dim AllNames As ListOfArrays = LOAUtils.CreateFrom1DList("Name", Names)
```

  
  
We want to split this list based on the names' lengths. LOASet, the iterator, is useful for such tasks:  

```B4X
'collect the indices of all rows where the name length is shorter than or equal to 4:  
Dim ls As LOASet = AllNames.CreateLOASet  
Do While ls.NextRow  
    If ls.GetValue(0).As(String).Length <= 4 Then ls.CollectIndex  
Loop  
'create two collections. One with the collected indices and another with the non-collected indices  
Dim ShortNames As ListOfArrays = AllNames.GetRows(ls.CollectedValues)  
Dim LongNames As ListOfArrays = AllNames.GetRows(AllNames.NegateRowsSelection(ls.CollectedValues))
```

  
Using the new AddColumnWithValue method, we add a new column that will store the lengths:  

```B4X
AllNames.AddColumnWithValue("Length", 0)
```

  
Now we iterate over the rows and set the lengths:  

```B4X
Dim ls As LOASet = AllNames.CreateLOASet  
Do While ls.NextRow  
    Dim Name As String = ls.GetValue("Name")  
    'set the length value for each row  
    ls.SetValue("Length", Name.Length)  
Loop
```

  
  
We can sort the names based on the length column:  

```B4X
AllNames.Sort("Length", True)
```

  
And get back a 1d list:  

```B4X
Dim SortedNames As List = AllNames.GetColumn("Name")  
Log(SortedNames)
```

  
  
Output:  
Name (#rows=4, #cols=1)  
—————————–   
John  
Emma  
Ava  
Mia  
Name (#rows=16, #cols=1)  
—————————–   
Michael  
Olivia  
Daniel  
Sophia  
James  
Name Length (#rows=20, #cols=2)  
—————————–   
Ava 3  
Mia 3  
John 4  
Emma 4  
James 5  
(ArrayList) [Ava, Mia, John, Emma, James, Lucas, Henry, Ethan, Grace, Olivia, Daniel, Sophia, Amelia, Evelyn, Michael, William, Benjamin, Isabella, Charlotte, Alexander]  
  
  
Project is attached.
###  [ListOfArrays] Sorting by multiple columns by Erel
### 09/16/2026
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/172086/)

Example of sorting a table by 2 or more columns.  
  
Data:  

```B4X
Dim loa As ListOfArrays = LOAUtils.CreateEmpty(Array("Last Name", "First Name", "Age", "Favorite Color"))  
loa.AddRow(Array("Smith", "John", 32, "Blue"))  
loa.AddRow(Array("Smith", "Emily", 27, "Green"))  
loa.AddRow(Array("Smith", "Michael", 41, "Red"))  
  
loa.AddRow(Array("Brown", "Sarah", 35, "Purple"))  
loa.AddRow(Array("Brown", "Daniel", 29, "Orange"))  
loa.AddRow(Array("Brown", "Laura", 38, "Yellow"))  
  
loa.AddRow(Array("Taylor", "James", 24, "Black"))  
loa.AddRow(Array("Taylor", "Olivia", 31, "Pink"))  
loa.AddRow(Array("Taylor", "David", 45, "Gray"))  
loa.AddRow(Array("Taylor", "Emma", 26, "White"))
```

  
We want it to be sorted by last name and then first name if last names are identical.  
  
The super sophisticated trick - we sort the table starting with the least important column and up to the primary column:  

```B4X
loa.Sort("First Name") 'first we sort the secondary column  
loa.Sort("Last Name") 'and then we sort the primary column  
Log(loa.ToString(0))
```

  
  
Output:  
  
  
Last Name First Name Age Favorite Color (#rows=10, #cols=4)  
—————————–   
Brown Daniel 29 Orange  
Brown Laura 38 Yellow  
Brown Sarah 35 Purple  
Smith Emily 27 Green  
Smith John 32 Blue  
Smith Michael 41 Red  
Taylor David 45 Gray  
Taylor Emma 26 White  
Taylor James 24 Black  
Taylor Olivia 31 Pink  
  
Dependence: ListOfArrays v1.01+ (B4i only). In older versions the sorting method isn't guaranteed to be stable in regards to handling of equal values.
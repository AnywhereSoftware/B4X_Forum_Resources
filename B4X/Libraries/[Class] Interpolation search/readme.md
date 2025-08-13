###  [Class] Interpolation search by LucaMs
### 12/04/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/164470/)

Short (long-winded 😁) premise.  
  
I needed a function that, given a list, returned the index of the element with the closest value to a searched one.  
List.IndexOf is great but it only returns the index if it finds exactly the searched value.  
  
I immediately thought of a binary search (I remember the good old days, about 45 years ago :confused:, when I "studied" the various Bubble, Shell and Quick sort) but I wondered if there was a better algorithm.  
  
I discovered the existence of this "Interpolation search".  
The biggest advantage is in the case in which the list of values are uniformly distributed. In the worst case, this algorithm will be as fast as a "normal" binary search.  
  
I publish the function in a class (in the attached project) rather than a library because it will be easier to change the data type of the list, if desired. In my case, I want to pass it a list of custom types (it would be nice to be able to pass it the type and the field to search on, but as far as I know it is impossible).  
  
I hope (and think) that my implementation is correct and optimal.  
  
With the following values:  

```B4X
    For i = 1 To 20  
        SortedList.Add(i * 5) ' 5, 10, 15, …, 100  
    Next
```

  
  
![](https://www.b4x.com/android/forum/attachments/159208)
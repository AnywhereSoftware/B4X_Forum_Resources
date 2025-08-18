###  Class - clsRndItems by LucaMs
### 04/08/2022
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/136776/)

A simple class for randomly picking items from a group without repetitions (but also with repetitions, if desired).  
It works on all platforms (B4A, B4J, B4I), of course.  
  
  
Main methods:  
  
**Initialize(…, NumOfItems As Int)**  
Creates, by default, a list of numeric items, from 1 to NumOfItems you will provide.  
You can change next the total number of Items using the "NumOfItems" property.  
You can also set a list of Items of any size and type using the "Items" property.  
  
**PopRndItem**  
Returns a random item among those still available, making it no longer available.  
Useful to get unique Items.  
  
**GetRndAvailItem**  
Returns a random item among those still available, without removing it.  
  
**GetRndItemAmongAll**  
Returns a random item among all existing ones (not only among those still available),  
without removing it.  
  
**Reset**  
Makes all the previously "popped" items available again.
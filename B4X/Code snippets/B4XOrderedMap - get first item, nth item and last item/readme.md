###  B4XOrderedMap - get first item, nth item and last item by Erel
### 06/04/2020
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/118642/)

B4XOrderedMap from B4XCollections, is a combination of a List with a Map.   
Avoid calling OrderedMap.Values unless you need to access all values, as it creates and fills a new List each call.   
The Keys list, on the other hand, is a list maintained by the collection and can be accessed directly.  

```B4X
'first item  
Dim key As String = OrderedMap.Keys.Get(0) 'key type can be different  
Dim value As Object = OrderedMap.Get(key)  
'nth item  
Dim key As String = OrderedMap.Keys.Get(n)  
Dim value As Object = OrderedMap.Get(key)  
'last item  
Dim key As String = OrderedMap.Keys.Get(OrderedMap.Size - 1)  
Dim value As Object = OrderedMap.Get(key)
```
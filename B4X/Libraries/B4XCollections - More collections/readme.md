###  B4XCollections - More collections by Erel
### 03/08/2022
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/101071/)

B4XCollections is a b4x lib. It adds several cross platform collections.  
It includes a static module named B4XCollections which should be used to create new instances of the collections.  
You can either create new empty collections or pass the initial data.  
  
**B4XSet** - A set is a collection of unique items. It is similar to a map where only the keys are used. Note that the order of items is preserved.  
Example:  

```B4X
Dim s As B4XSet = B4XCollections.CreateSet  
For i = 1 To 1000  
   s.Add(Rnd(1, 5))  
Next  
For Each Value As Int In s.AsList  
   Log(Value)  
Next
```

  
Output:  
1  
4  
2  
3  
  
Like with other types of collections the values in the set can be of any type.  
  
**B4XOrderedMap** - Similar to a Map with two advantages:  
  
1. The order of items is preserved. This is the case with regular Maps in B4A and B4J as well, however not the case with B4i regular Maps.  
  
2. You can sort the items based on the keys.  
  

```B4X
Dim om As B4XOrderedMap = B4XCollections.CreateOrderedMap2(Array("a", "b", "c", "d"), Array(1, 2, 3, 4))  
For Each k As Object In om.Keys  
   Log(k & ": " & om.Get(k))  
Next  
Log("sorting…")  
om.Keys.Sort(False) 'sorts descending  
For Each k As Object In om.Keys  
   Log(k & ": " & om.Get(k))  
Next
```

  
Output:  
a: 1  
b: 2  
c: 3  
d: 4  
sorting…  
d: 4  
c: 3  
b: 2  
a: 1  
  
  
**B4XBitSet** - An efficient collection of bits. Similar to an array of booleans but requires less memory (approximately 1/8 of a similar sized array).  
  
Finding all primes up to 1000 based on Sieve of Eratosthenes algorithm (<https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes>):  
  

```B4X
Dim bitset As B4XBitSet = B4XCollections.CreateBitSet(1000)  
Dim n As Int = bitset.Size -1  
For i = 2 To Sqrt(n)  
   If bitset.Get(i) = False Then  
       For j = i * i To n Step i  
           bitset.Set(j, True)  
       Next  
   End If  
Next  
For i = 2 To bitset.Size - 1  
   If bitset.Get(i) = False Then Log(i)  
Next
```

  
  
**B4XBytesBuilder** - Replaces [BytesBuilder.](https://www.b4x.com/android/forum/threads/b4x-bytesbuilder-simplifies-working-with-arrays-of-bytes.89008/#content)  
  
A collection with features similar to String and StringBuilder features. Holds raw bytes instead of characters.  
Very useful when you need to work with binary data.  
  
**B4XCache** - Simple and useful key/value cache collection.  
<https://www.b4x.com/android/forum/threads/b4x-b4xcache-simple-and-useful-cache-collection.136292/>  
  
Q: What is a b4xlib?  
A: <https://www.b4x.com/android/forum/threads/new-feature-b4x-lib-a-new-type-of-library.100383/#content>  
  
**Updates**  
  
V1.13 - New B4XSortComparator class: <https://www.b4x.com/android/forum/threads/b4x-sophisticated-sorting-with-b4xcomparatorsort.139006/>  
V1.12 - B4XBytesBuilder.InternalBuffer was removed by mistake. It is added back in this version. It should only be used in special cases where access to the full array is needed.  
V1.11 - B4XBytesBuilder.Append2 - Similar to Append, with StartIndex and Length parameters.  
V1.10 - B4XCache: <https://www.b4x.com/android/forum/threads/b4x-b4xcache-simple-and-useful-cache-collection.136292/>  
V1.07 - B4XOrderedMap.GetDataForSerializator / SetDataFromSerializator: <https://www.b4x.com/android/forum/threads/b4x-b4xcollections-more-collections.101071/post-745277>  
V1.06 - B4XOrderedMap.Values property.  
V1.05 - B4XBytesBuilder added.  
  
**B4XCollections is included as an internal library.**
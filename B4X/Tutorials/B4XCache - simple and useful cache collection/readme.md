###  B4XCache - simple and useful cache collection by Erel
### 11/24/2021
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/136292/)

B4XCache is a new collection added in B4XCollections v1.10.  
It is key / value store collection, similar to Map.  
When the cache reaches the set maximum size, the least recent used items are removed (30% of the items).  
The item recency is updated when it is added to the cache and whenever it is accessed, using Cache.Get.  
  
You can also add "eternal" items using PutEternal. Those items will never be removed automatically and they also don't count when testing the maximum limit.  
  

```B4X
Dim cache As B4XCache  
cache.Initialize  
cache.MaxSize = 20  
cache.Put("Image 1", bmp1)  
cache.Put("Image 2", bmp2)  
cache.Put("Image 3", bmp3)  
cache.Put("Image 4", bmp4)  
cache.PutEternal("Default Image", bmpDefault)  
  
'Getting an item from the cache, don't assume that it is there:  
Dim bmp As B4XBitmap  
Dim Key As String = "Image 4"  
If cache.ContainsKey(Key) Then  
    bmp = cache.Get(Key)  
Else  
    'Put also returns the Value.  
    bmp = cache.Put(Key, XUI.LoadBitmap(…))  
End If
```
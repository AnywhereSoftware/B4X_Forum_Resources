### Caffeine Cache by Erel
### 02/28/2023
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/146485/)

Caches can be critical for servers and other apps where you cannot store all data in memory and still need good performance.  
A simple and cross platform cache implementation is available in the B4XCollections library: <https://www.b4x.com/android/forum/threads/b4x-b4xcache-simple-and-useful-cache-collection.136292/#content>  
  
This library, based on caffeine open source project: <https://github.com/ben-manes/caffeine>, is much more powerful. It is a B4J only library and requires OpenJDK 11+.  
  
The open source project is well documented and quite interesting: <https://github.com/ben-manes/caffeine/wiki>  
I will explain how to use it.  
  
1. Define the cache settings and initialize the cache.  
2. Implement the Load event. This will be called whenever a value is requested for a key that isn't in the cache.  
3. Use the cache.  
  
Here are the cache settings, note that they are all optional:  
MaximumSize - maximum number of cached items  
ExpireAfterWriteMs - If >0 then items will be removed after X milliseconds passed since the insertion point. This is useful for cases where the data becomes stale after some time.  
ExpireAfterAccessMs - If > 0 then items will be removed after X milliseconds passed since the last access (read or write).  
RecordStats - If True then the cache will track hit/miss statistics.  
  
There is a nice separation between the consumers and the supplier implementations. The consumers request a value and if needed the Load event is raised.  
  

```B4X
Private Sub Cache_Load (Key As Object) As Object
```

  
The value returned from this event will be stored in the cache and returned to the consumer.  
Note that it will be raised on the same thread that called the Get method.  
Return Null if no value is available. The cache doesn't store Null values.  
  
Other methods:  
*GetIfPresent* - Return the value if it is in the cache or Null. Doesn't raise the Load event.  
*Invalidate* / InvalidateAll - Removes items from the cache.  
*Put* - Adds an item to the cache.  
*Stats -* Returns a CaffeineStats object with cache statistics. Will be empty if Settings.RecordStats is false.  
*EstimatedSize* - estimated number of cached items.  
  
A simple UI example is attached.  
  
Library + dependencies (600kb) - <https://www.b4x.com/b4j/files/caffeine.zip>
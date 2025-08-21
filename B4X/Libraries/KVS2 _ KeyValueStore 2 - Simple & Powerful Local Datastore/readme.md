###  KVS2 / KeyValueStore 2 - Simple & Powerful Local Datastore by Erel
### 07/16/2020
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/63633/)

Recommended to use the newer b4xlib: <https://www.b4x.com/android/forum/threads/b4x-kvs2-keyvaluestore2-library.120234/>  
[SPOILER="old version"]KeyValueStore is a persistent key/value based data store. It is similar to the [useful Map collection](https://www.b4x.com/android/forum/threads/map-collection-the-most-useful-collection.60304/), however unlike Map which stores the data in memory, KVS stores the data in a database. This means that you don't need to worry about losing data or saving the state when the program ends.  
  
This version replaces the [older version](https://www.b4x.com/android/forum/threads/26317/#content). **It is not backwards compatible.** You cannot use it with databases created with the previous version.  
  
The main differences between v2 and v1:  
The new version is based on B4XSerializator to serialize the values and on B4XCipher to encrypt it.  
This means that the data can be shared between B4A, B4J and B4i. For example you can create the data store in B4J and embed it in your mobile app.  
B4XSerializator is also faster and simpler to use.  
  
Using KVS is similar to using a Map. You initialize it once (use the Starter service in B4A) and then you can put or get items with Put, Get or GetDefault methods.  
You can use PutEncrypted to encrypt the value before it is stored. Use GetEncrypted to get an encrypted value.  
If you want to put bitmaps then use PutBitmap and GetBitmap.  
  
The supported types of objects are:  
  
Lists, Maps, Strings, primitives (numbers), user defined types and arrays (only arrays of bytes and arrays of objects are supported).  
Custom types should be declared in the main module.  
Including combinations of these types (a list that holds maps for example).  
  
KeyValueStore depends on the following libraries: SQL, RandomAccessFile and B4XEncryption (iEncryption on B4i).  
Note that in B4J you need to download the [bouncy castle jar](https://www.bouncycastle.org/download/bcprov-jdk15on-154.jar) and add the following two lines to the main module:  

```B4X
#AdditionalJar: sqlite-jdbc-3.7.2  
#AdditionalJar: bcprov-jdk15on-154
```

  
  
  
A B4A example is attached. The class module is compatible with B4A, B4J and B4i.  
  
Tip: Check CloudKVS for an auto-synchronizing solution: <https://www.b4x.com/android/forum/threads/b4x-cloudkvs-synchronized-key-value-store.63536/#content>  
  
Updates:  
  
- V2.20 - Adds support for GetMapAsync and PutMapAsync. These methods allow to asynchronously insert or retrieve multiple items.  
Examples:  

```B4X
'getting all items:  
Wait For (Starter.kvs.GetMapAsync(Starter.kvs.ListKeys)) Complete (Result As Map)  
Log(Result)  
'getting specific items:  
Wait For (Starter.kvs.GetMapAsync(Array("Key1", "Key2", "Key3")) Complete (Result As Map)  
Log(Result)
```

  
  
Note that starting from B4A v8.0 KeyValueStore2 is included as an internal library.[/SPOILER]
###  KVS - KeyValueStore library by Erel
### 07/21/2021
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/120234/)

A key / value persistent store. The data is serialized using B4XSerializator and is stored in an internal database. The database can be shared between B4A, B4i and B4J.  
  
Using KVS is similar to using a Map. You initialize it once and then you can put or get items with Put, Get or GetDefault methods.  
  
The supported types of objects are:  
  
Lists, Maps, Strings, primitives (numbers), user defined types and arrays (only arrays of bytes and arrays of objects are supported).  
Including combinations of these types (a list that holds maps for example).  
Custom types should be declared in the main module or in B4XMainPage.  
Bitmaps are supported with PutBitmap / GetBitmap methods.  
  
**Adding encryption:**  
[SPOILER="Encryption"]  
Encryption is also supported but is not enabled by default as it requires some configuration:  
  
1. Add KVS\_ENCRYPTION to the build configuration (Ctrl + B):  
  
![](https://www.b4x.com/android/forum/attachments/97220)  
  
2.  
B4A: Add reference to B4XEncryption.  
B4i: Add reference to iEncryption  
B4J:  
Add reference to jB4XEncryption  
Download bouncycastle: <https://www.bouncycastle.org/download/bcprov-jdk15on-154.jar> and put it in the additional libraries folder.  
Add to main module:  

```B4X
#AdditionalJar: bcprov-jdk15on-154
```

  
3. Use PutEncrypted / GetEncrypted  
[/SPOILER]  
  
Usage example:  

```B4X
xui.SetDataFolder("kvs")  
    kvs.Initialize(xui.DefaultFolder, "kvs.dat")  
    kvs.Put("time", DateTime.Now)  
  
    'fetch this value  
    Log(DateTime.Time(kvs.Get("time")))  
    Log(kvs.Get("doesn't exist"))  
    Log(kvs.GetDefault("doesn't exist", 10))  
    'put a Bitmap  
    kvs.PutBitmap("bitmap1", xui.LoadBitmap(File.DirAssets, "smiley.gif"))  
    'fetch a bitmap  
    ImageView1.SetBitmap(kvs.GetBitmap("bitmap1"))  
    'remove the bitmap from the store  
    kvs.Remove("bitmap1")  
    'put an array with two custom types  
    kvs.Put("2 custom types", Array(CreateCustomType(1, "one"), CreateCustomType(2, "two")))  
    'get them  
    Dim mytypes() As Object = kvs.Get("2 custom types") 'the array type must be object or bytes
```

  
  
**This library is named KeyValueStore.** There is an older library named KeyValueStore2. Don't confuse between the two. It is recommended to use this one.  
It is an internal library now.  
  
**Updates**  
  
v2.31 - New Vacuum method. This method frees unused space from the database file. It can be used after doing large deletes to free space.
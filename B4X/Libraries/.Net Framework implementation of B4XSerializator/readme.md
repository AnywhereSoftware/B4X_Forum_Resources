###  .Net Framework implementation of B4XSerializator by Erel
### 03/20/2020
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/73080/)

**B4XSerializator is included in the internal RandomAccessFile library. The attached dll is for .Net Framework applications.**  
B4XSerializator is a great tool that makes it simple to share data between B4A, B4i and B4J. It takes care of converting objects, including complex objects, to bytes and vice versa. (It also has a smaller brother named B4RSerializator that is supported by B4A, B4i, B4J and B4R but is less powerful.)  
  
Example: <https://www.b4x.com/android/forum/threads/network-asyncstreams-b4xserializator.72149/#content>  
  
The attached .Net dll is a .Net implementation of B4XSerializator. You can use it if you need to communicate with a .Net application or server.  
  
Using it is simple. Create a B4XSerializator object and call ConvertBytesToObject or ConvertObjectToBytes.  
Custom B4X types will be converted to a class named B4XType. B4XType holds the class name and a dictionary (map) with the fields names and values.  
You can also create B4XType instances yourself.  
  
Tips & Notes  
  
- The following types are supported: primitives, strings, List<Object>, Dictionary<Object, Object>, arrays of objects, arrays of bytes and B4XType objects. Including combinations of these types (lists of maps with custom types for example).  
- It depends on SharpZipLib. It is included in the zip file. License (allows commercial usage): <http://icsharpcode.github.io/SharpZipLib/>  
- The c# code is included.
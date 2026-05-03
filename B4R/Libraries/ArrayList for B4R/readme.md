### ArrayList for B4R by candide
### 04/25/2026
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/170892/)

For Arduino, ArrayList Class is :  
The ArrayList class is a C++ template class that provides an implementation of an ArrayList for easy storage of values of any designated type.  
It allows efficient storage and retrieval using indexes, similar to Java's ArrayList.  
sources : <https://github.com/braydenanderson2014/C-Arduino-Libraries/tree/main/lib/ArrayList>  
  
for B4R:  
This wrapper provide an acces to ArrayList from B4R : you can store and manipulate ArrayList in Arduino memory from B4R.  
ArrayLists are accessible from all sub, callsubplus, inlineC of your B4R script because data are not in stack.  
  
ArrayList can be with Fixed Size (like standard Array) or Dynamic Resizing  
ArrayList supported :Byte, Int, UInt, Long, ULong, Double and String  
  
functions supported (byte item example)  
 void Initialize( byte typeSize, uint16\_t initialSize);  
 bool add( byte item);   
 bool insert(uint16\_t index, byte item);  
 bool removeItem(byte item);  
 bool remove(uint16\_t index);  
 void clear();  
 byte get(uint16\_t index);  
 B4RString\* getAsString(uint16\_t index);  
 bool contains(byte item);   
 int16\_t indexOf(byte item);  
 uint16\_t capacity();  
 uint16\_t size();  
 bool isEmpty();  
 bool set( uint16\_t index, byte item);  
 bool removeRange(uint16\_t fromIndex, uint16\_t toIndex);  
 void ensureCapacity(uint16\_t minCapacity);  
 bool trimToSize();   
 bool addAll(ArrayByte\* other);  
 bool insertAll(uint16\_t index, ArrayByte\* other);  
 bool toArray(ArrayByte\* outputArray);   
 bool subtoArray(ArrayByte\* outputArray, uint16\_t fromIndex, uint16\_t toIndex);   
 void setSizeType(byte typeSize);  
 byte getSizeType();
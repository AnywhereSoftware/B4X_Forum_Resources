### Useful defines by Daestrum
### 02/29/2024
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/159579/)

I use these quite often and they may be of use to others.  

```B4X
// gets the lenth of a c array  
#define lengthOf(a) std::end(a) - std::begin(a)  
  
// gets the object type inside a B4R::Object —- Look in rCore.h for the type numbers   
#define OBJType(a)    (int)  a->type  
  
// gets the value inside a B4R::Object (simple objects not arrays)  
#define OBJtoInt(a)   (int)  a->data.LongField  
#define OBJtoLong(a)  (long) a->data.LongField  
#define OBJtoShort(a) (short)a->data.LongField  
  
// object value to int or long  else return long value  
#define OBJtoNumber(o) o->type==3?OBJtoInt(o):o->type==5?OBJtoLong(o):o->data.LongField  
  
// returns a const char * from inside a string array inside an object variable.  
#define OBJtoStringfromArray(a,idx) (((B4R::B4RString**)((B4R::Array*)a)->getData((UInt) (idx)))[B4R::Array::staticIndex])->data
```

  
  
Example usage:  
  
lengthOf  

```B4X
    const char* s[] = {"one","two","three","four","five"};  
     
    for(int a = 0; a < lengthOf(s); a++){  
        Serial.println(s[a]);  
    }
```

  
  
OBJtoLong etc  

```B4X
void listAdder(B4R::Object* o){  
    long v = OBJtoLong(o);  
…
```

  
  
OBJtoStringfromArray  

```B4X
    Dim g() As String = Array As String("aaaaa","bbbb","ccccc")  
…  
    RunNative("arrayLister",g)  
…  
  
  
void arrayLister(B4R::Object * o){  
// params are object, index you want  
// following line Object is o  and the index is 1  
    const char * thisString = OBJtoStringfromArray(o,1);  
    Serial.println(thisString);  
}
```
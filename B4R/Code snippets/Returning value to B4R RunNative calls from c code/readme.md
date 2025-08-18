### Returning value to B4R RunNative calls from c code by Daestrum
### 02/20/2021
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/127847/)

I couldn't find an easy way for me to use code like  

```B4X
Dim x As Int = RunNative("myRoutine",Null)
```

  
I know I could use \_x and put the value into it, but if you rename variables, you then have to search through the c code and change the references in there. (find doesn't seem to look at the c code)  
  
So I came up with this (it handles Int, Uint, Long, ULong, Double and bool types).  
The enums BR\_INT, BR\_UINT etc are predefined in B4R. Just use the one suitable for your return type.  
I only use one Object (tmp) so there could be cases where if you call it more than once per function, you dont get the value you expect, but for single calls it should be fine.  
  

```B4X
#if C  
B4R::Object* tmp = new B4R::Object();  
  
template <typename T>  
B4R::Object* respond(int type,T const & value){  
    tmp->type = type;  
    switch (type){  
        case BR_INT:  
                tmp->data.LongField = (Int)value;  
                break;  
        case BR_LONG:  
                tmp->data.LongField = (Long)value;  
                break;  
        case BR_DOUBLE:  
                tmp->data.DoubleField = (Double)value;  
                break;  
        case BR_ULONG:  
                tmp->data.ULongField = (ULong)value;  
                break;  
        case BR_UINT:  
                tmp->data.ULongField = (UInt)value;  
                break;  
        case BR_BOOL:  
                tmp->data.ULongField = (bool)value;  
                break;        
        default:  
            ::Serial.println("Unknown type "+type);  
    }  
    return tmp;  
}  
#End If
```

  
  
You can call it from a c function like  

```B4X
B4R::Object* longTest(B4R::Object* o){  
     long myNum = 56 * 2 * 100;  
    // this is the long I want to return to B4R code  
    return respond(BR_LONG, myNum);  
}
```

  
  
Which lets you use B4R code like  

```B4X
Dim x As Int = RunNative("myFuncThatReturnsAnInt",something)  
doSomethingWith(x)
```

  
  
Hope it's useful to you.
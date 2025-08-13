### [python] B4XSerializator implementation in Python by Erel
### 01/15/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/165109/)

Python is a very nice programming language and it rules several domains such as data science, machine learning, large language models and etc. There are alternative Java frameworks for these fields, however they are less popular, less powerful and also less friendly. For this reason, I decided to build several utilities to make it easier to integrate and communicate with Python scripts.  
The first module is an implementation of B4XSerializator.  
  
Usage example:  

```B4X
from b4x_serializator import B4XSerializator  
  
ser = B4XSerializator()  
b = ser.convert_object_to_bytes([1, 2, 3, 4])
```

  
  
It also supports converting B4X types to Python dataclass. In order to deserialize dataclasses, the classes need to be passed to B4XSerializator constructor:  

```B4X
from dataclasses import dataclass, field  
from b4x_serializator import B4XSerializator  
  
  
@dataclass  
class Testing:  
    Aa: int  
    Bb: str  
    Cc: list  
  
  
if __name__ == '__main__':  
    ser = B4XSerializator(types=[Testing])  
    t = Testing(Aa=11, Bb="from python", Cc=[1, 2, 3, 4])  
    b = ser.convert_object_to_bytes(obj=t)  
    with open(r"C:\Users\H\Downloads\1.dat", "wb") as f:  
        f.write(b)  
    tt = ser.convert_bytes_to_object(b)  
    print(tt)
```

  
  
Combinations of maps(dicts), lists and custom types are supported.  
Note that Python ints will be serialized as Integer unless the number is larger than the possible range. In that case they will be serialized as Longs.  
Python floats are serialized as Doubles by default, this can be changed by setting the prefer\_doubles parameter in the constructor to False.
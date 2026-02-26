###  Native B4X Implementation of Two Pandas-like Classes: DataFrame and Series by William Lancee
### 02/21/2026
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/170385/)

Pandas is a Python libary heavily used in Machine Learning (ML) applications.  
While investigating ML, when using Pandas with Python, I kept thinking: "I could do this in B4X".  
This tutorial is the result of my experimentation. The tutorial comes in 5 parts.  
  
Part 1. Introduction to Pandas methods and B4X implementation challenges  
  
B4X can communicate with Python through PyBridge and therefore use the Pandas library. That works well.  
 <https://www.b4x.com/android/forum/threads/b4j-pybridge-pyworks-a-class-to-facilitate-running-python-code.170072/>  
My self-assigned challenge was to implement the functionality of Pandas in NATIVE B4X (B4J, B4A).  
  
But B4X and Python are very different languages.  
  
An example of a Pandas series, defined as a 1-dimensional labeled array.  

```B4X
    import pandas as pd  
  
    x = pd.series([1, 2, 3, 4, 5])  
    x.index = ['a', 'b', 'c', 'd', 'e']  
    print(x + 100)  
a    101  
b    102  
c    103  
d    104  
e    105
```

  
  
How do we do this in B4X?  
  
B4X, like Java, is strongly typed at time of coding. Variables in Python do not have an a priori data type.  
 Solution: Use the B4X Object type to communicate with the Series class  
   
B4X has a fixed number of arguments in Sub calls. Python can have a variable number of arguments, as well as named arguments.  
 Solution: Use a List or a Map to pass unnamed and/or named arguments  
   
B4X, in the spirit of avoiding brackets, does not use [] for lists or {} for maps (although there is long-standing wish for these).  
 Solution: Use Array(…) for [], and automatically convert to a List where needed. Use createMap() for {}.  
   
B4X does not have polymorphism of operators (+,-, \*, /). Python does.  
 Solution: (1) wrap operators in a small sub: x.op("+", 100) and (2) provide an alias for this: x.plus(100)  
  
The above code, using B4X and the Series class:  
  

```B4X
    Private pd As WiLPandas  
    pd.Initialize(Me)  
    
    Dim x As Series = pd.items(Array(1, 2, 3, 4, 5))  
    x.addIndex(Array("a", "b", "c", "d", "e"))  
    x.op("+", 100).print  
a    101  
b    102  
c    103  
d    104  
e    105
```

  
   
Obviously the two versions are not the same, but they are similar in function and 'spirit'.  
  
Note 1: 'as' has different meanings in B4X (instance of) and Python (alias)  
Note 2: WiLPandas is the manager class that creates instances of a Series and DataFrames. It also has utilities used by these instances.  
Note 3: Most methods accept Objects as arguments. These are turned into Lists and Maps for processing - scalars become one-element Lists  
  
For example code and classes, see Part 2 next.
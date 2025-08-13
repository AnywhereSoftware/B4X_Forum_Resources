### Emulate javas ability to have default and value constructors in B4J by Daestrum
### 05/28/2024
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/161377/)

Java can have multiple constructors for a class that can take none or more parameters  
  
With B4J we have the Initialize sub in a class - we can add parameters if we want, but what if sometimes we want to add parameters and other times we want a default constructor.  
  

```B4X
'A simple class  
Sub Class_Globals  
    Public parent As Pair  
    Public f As Double  
    Public g As Double  
    Public h As Double  
End Sub
```

  
  
the Initialize  

```B4X
Public Sub Initialize  
  
End Sub
```

  
  
This will create the class with default values  
  
If we want to set the values we have to initialize the class then apply the values to it  
  

```B4X
Dim a As myClass  
myClass.Initialize  
myClass.var1 = 2   ' assuming var1 is public or else we need setter/getters
```

  
  
Now if we change Initialize to take parameters we can't create a default class  
  
Unless we use this type of Initialize (this code is taken from actual code I am writing at present)  
  

```B4X
Sub Class_Globals  
    Public parent As Pair  
    Public f As Double  
    Public g As Double  
    Public h As Double  
End Sub  
  
Public Sub Initialize(obj() As Object)  
    If obj = Null Then  
        Dim tmpParent As Pair  
        tmpParent.Initialize(-1,-1)  
        parent = tmpParent  
        f = -1  
        g = -1  
        h = -1  
        Log("called with null")  
    Else  
        parent = obj(0)  
        f = obj(1)  
        g = obj(2)  
        h = obj(3)  
        Log("called with values")  
     End If  
End Sub
```

  
  
Basically if you call the Initialize like  

```B4X
Dim a As myClass  
a.Initialize(null)  
…
```

  
  
You get the default constructor.  
  
If you call it like  

```B4X
Dim a As myClass  
a.Initialize(Array(p,1,2,3))  
…
```

  
  
You set all the values to the parameters you put in the array.  
  
Hope this is useful to others.
### Sneaky JavaObject by Daestrum
### 08/28/2023
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/149865/)

Sometimes you just need to use a JavaObject to get a value to log for example. ( Be aware it makes the code harder to read using the tips below)  
  
Normally you would write  

```B4X
…  
Dim jo As JavaObject  
Log( jo.InitializeStatic("some.java.class").RunMethod("someJavaMethod",Null) )  
…
```

  
  
You can get the same result without having to create a new JavaObject - just cast Null to JavaObject  
  

```B4X
…  
Log( (Null).As(JavaObject).InitializeStatic("some.java.class").RunMethod("someJavaMethod", Null) )  
…
```

  
  
Or create a JavaObject on it's Dim line  

```B4X
…  
Dim myVar As JavaObject = (Null).As(JavaObject).InitializeStatic("some.java.class")  
myVar.RunMethod("someMethod",Null)   
..
```

  
  
Use at your peril lol.
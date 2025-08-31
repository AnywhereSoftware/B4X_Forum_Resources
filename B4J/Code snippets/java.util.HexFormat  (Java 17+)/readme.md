### java.util.HexFormat  (Java 17+) by Daestrum
### 08/25/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/168383/)

Nifty little class - turns numbers into hex strings and vice versa  

```B4X
Dim hx As JavaObject  
hx = hx.InitializeStatic("java.util.HexFormat").RunMethodJO("of",Null).RunMethod("withUpperCase",Null)
```

  
  
Then use like  

```B4X
Dim a As Int = 12345  
log(hx.RunMethod("toHexDigits",array(a)))  '-> to hex string
```

  
  
Lots of other useful methods like hex string to byte array.  
  
Ref: [HexFormat](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/util/HexFormat.html)
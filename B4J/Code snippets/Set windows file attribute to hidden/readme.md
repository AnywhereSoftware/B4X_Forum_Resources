### Set windows file attribute to hidden by aeric
### 03/01/2023
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/146494/)

```B4X
Dim jo As JavaObject  
jo.InitializeStatic("java.lang.Runtime")  
jo.RunMethodJO("getRuntime", Null).RunMethod("exec", Array("attrib +H <path_to_your_file>"))
```
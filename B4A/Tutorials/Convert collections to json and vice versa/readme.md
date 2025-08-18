### Convert collections to json and vice versa by Erel
### 03/27/2022
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/132678/)

The JSON libraries, which are internal libraries, were updated. The new version is 1.20.  
  
There is a new JSON type which is used to convert maps or lists to json strings and vice versa, using the new As keyword.  
The idea is that you have a collection or string, you direct the compiler to treat it as "JSON" and then convert it to a string or a collection.  
  
It looks like this:  

```B4X
Dim m As Map = CreateMap("asdasd": Array(1, 2, 3, 4))  
  
Dim s As String = m.As(JSON).ToString  
'equivalent to:  
Dim jg As JsonGenerator  
jg.Initialize(m)  
Dim s As String = jg.ToPrettyString(4)  
  
'and the other direction:  
Dim s As String =  $"{"aaa": "bbb"}"$  
  
Dim m As Map = s.As(JSON).ToMap 'ignore  
'equivalent to:  
Dim jp As JsonParser  
jp.Initialize(s)  
Dim m As Map = jp.NextObject
```

  
It also works with Lists.
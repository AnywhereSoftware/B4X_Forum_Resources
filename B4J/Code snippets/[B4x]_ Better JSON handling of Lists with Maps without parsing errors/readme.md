### [B4x]: Better JSON handling of Lists with Maps without parsing errors by KMatle
### 01/12/2021
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/126438/)

I've seen some threads about problems parsing JSON strings (esp. lists/maps) due to special chars (e.g. when a value contains a Base64 string). I now had one app which sends JSON strings (a list with n maps) via network. In some cases I had problems parsing the strings due to "invalid chars or delimiters).  
  
The reason was that I've added maps directly to a list and then converted the list to a JSON string. Somehow this doesn't work when you send the data via network (AsyncStreams or Http) when you don't url encode the data.  
  
  
  

```B4X
    Dim l As List  
    l.Initialize  
    Dim m1 As Map = CreateMap("key":"value")  
    Dim m2 As Map = CreateMap("key":"value")  
      
      
'adding maps to the list  
    l.Add(m1) 'add the map to the list  
    l.Add(m2)  
    JG.Initialize2(l)  
    Dim JSONString As String = JG.ToString  
    Log(JSONString)
```

  
  
Output: **[{"key":"value"},{"key":"value"}] -> problematic**  
  
To solve this issue I convert the maps to a JSON string BEFORE I add them to the list. This seems to escape chars which can interfere.  
  

```B4X
'Better: Adding maps which were converted to JSON-Strings before  
    l.Clear  
    JG.Initialize(m1)  
    l.Add(JG.ToString)  
    JG.Initialize(m2)  
    l.Add(JG.ToString)  
    JG.Initialize2(l)  
    JSONString=JG.ToString  
    Log(JSONString)
```

  
  
Output: **["{\"key\":\"value\"}","{\"key\":\"value\"}"] -> good**
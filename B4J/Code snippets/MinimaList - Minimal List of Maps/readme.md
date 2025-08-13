### MinimaList - Minimal List of Maps by aeric
### 10/09/2024
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/149341/)

[TABLE]  
[TR]  
[TH]Update[/TH]  
[/TR]  
[TR]  
[TD]Please refer to the B4X library  
<https://www.b4x.com/android/forum/threads/b4x-web-minimalistutils.155724/>[/TD]  
[/TR]  
[/TABLE]  
  
**MinimaList**  
Description: Minimal List of Maps  
Version : 1.02  
  
Treat it as some kind of a NoSQL for key-value pair or KVS.  
It is suitable for small demo but I don't recommend it for serious project.  
  
**Properties**  

- List (read/write)
- First As Map (read)
- Last As Map (read)

**Methods**  

- Add (M As Map)
- CopyList As Object
- Count (key As String, id As Long) As Int
- Remove (Index As Long)
- Remove2 (M As Map)
- RemoveKey (Key As String, Index As Long)
- RemoveKey2 (Key As String, M As Map)
- IndexFromMap (M As Map) As Long
- IndexFromId (id As Long) As Long
- Find (id As Long) As Map
- FindFirst (keys As List, values As List) As Map
- FindAll (keys As List, values As List) As List
- FindAnyLike (keys As List, values As List) As List
- Exclude (id As Long) As List
- ExcludeAll (keys As List, values As List) As List
- ExcludeAny (keys As List, values As List) As List

Related library:  
<https://www.b4x.com/android/forum/threads/web-minimalist-controller.152966/#post-956297>
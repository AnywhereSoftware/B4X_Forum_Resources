###  MinimaListUtils by aeric
### 09/19/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/155724/)

**MinimaListUtils**  
Version : 2.00  
A utility class to manipulate a simple List of Map to do basic CRUD.  
  
Treat it as some kind of a NoSQL for key-value pairs.  
It is suitable for small demo if you don't want to use SQL database.  
  
It depends on **KeyValueStore** library. It depends on **RandomAccessFile** library.  
Note: You can use File.ReadBytes and File.WriteBytes to read/write to a file.  
  
This b4xlib replaces the class from [MinimaList](https://www.b4x.com/android/forum/threads/minimalist.149341/) formerly published in B4J code snippet.  
  
**Code snippets** also included for creating RESTful API subs for MinimaList Controller when developing with Web API Template 2.04+.  
  
![](https://www.b4x.com/android/forum/attachments/146981)  
  
**Properties**  

- First As Map (read/write)
- Last As Map (read/write)
- List (read/write)

**Methods**  

- Add (M As Map)
- Clone As MinimaList
- ContainsKey (key As String) As Boolean
- CopyList As Object
- CopyObject (xo As Object) As Object
- Count (key As String, id As Long) As Int
- Exclude (id As Long) As List
- ExcludeAll (keys As List, values As List) As List
- ExcludeAny (keys As List, values As List) As List
- Find (id As Long) As Map
- FindAll (keys As List, values As List) As List
- FindAnyLike (keys As List, values As List) As List
- FindByKey (key As String, value As Object)
- FindFirst (keys As List, values As List) As Map
- IndexFromId (id As Long) As Long
- IndexFromMap (M As Map) As Long
- Limit (Number As Int) As MinimaList
- Remove (index As Long)
- Remove2 (M As Map)
- RemoveKey (key As String, index As Long)
- RemoveKey2 (key As String, M As Map)
- Reverse As MinimaList
- SortByKey (key As String, ascending As Boolean)
- SortByKey2 (key As String, ascending As Boolean, default As Object)

What's New  

- Version 2.00

- Update Clone method
- Add #Macro tags

- Version 1.80

- Added ContainsKey
- Renamed CreatemType to CreateType

- Version 1.07

- Added Limit
- Replace dependency of KeyValueStore to RandomAccessFile

- Version 1.06

- Added Clone
- Update Reverse return the resulted object
- Update SortByKey
- Added SortByKey2
- First and Last properties are now writable

- Version 1.05

- Fix bug in SortByKey
- Added CopyObject
- Update CopyList

- Version 1.04

- Added Reverse, FindByKey, SortByKey
- Updated Snippet 08

- Version 1.03

- Update Snippets, removed #plural tag

- Version 1.02

- Added CopyList sub

- Version 1.01

- Add KeyValueStore dependency to manifest file

  
GitHub: <https://github.com/pyhoon/MinimaListUtils-B4X>
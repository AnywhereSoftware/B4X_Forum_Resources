### Convert Map to List (of Keys and Values) by aeric
### 08/16/2023
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/149606/)

Similar to this thread: <https://www.b4x.com/android/forum/threads/convert-data-map-to-list.141527/>  
But I use a custom Type which I call KeyValueList.  
I only tested this on B4J, it should also work in B4A too.  
  

```B4X
Type KeyValueList (Keys As List, Values As List)  
  
Public Sub ConvertMap2KeyValueList (obj As Map) As KeyValueList  
    Dim Keys As List  
    Dim Values As List  
    Keys.Initialize  
    Values.Initialize  
    For Each key As String In obj.Keys  
        Keys.Add(key)  
        Values.Add(obj.Get(key))  
    Next  
    Return CreateKeyValueList(Keys, Values)  
End Sub  
  
Public Sub CreateKeyValueList (Keys As List, Values As List) As KeyValueList  
    Dim t1 As KeyValueList  
    t1.Initialize  
    t1.Keys = Keys  
    t1.Values = Values  
    Return t1  
End Sub
```

  
  
Example usage:  

```B4X
Dim data As Map = Utility.RequestData(Request) ' a map of data from Http Post body as JSON  
Dim KVL As KeyValueList = Utility.ConvertMap2KeyValueList(data)  
Dim M1 As Map = Main.UserList.QueryFirst(KVL.Keys, KVL.Values)  
' Dim M1 As Map = Main.UserList.QueryFirst(data.Keys, data.Values) ' <– Error  
  
' Note: QueryFirst is a function in MinimaList  
' Query first item where key and value list matched  
Public Sub QueryFirst (keys As List, values As List) As Map  
    ' Code  
End Sub
```

  
  
If we pass Map.Keys or Map.Values to a function which expect a List, we will get an error:  
java.lang.ClassCastException: class anywheresoftware.b4a.objects.collections.Map$IterableMap cannot be cast to class java.util.List (anywheresoftware.b4a.objects.collections.Map$IterableMap is in unnamed module of loader 'app'; java.util.List is in module java.base of loader 'bootstrap')  
  
I can also create another function that expect a KeyValueList:  

```B4X
Public Sub QueryFirst2 (data As KeyValueList) As Map  
    ' Code  
End Sub  
  
' Usage:  
Dim M1 As Map = Main.UserList.QueryFirst2(KVL)
```
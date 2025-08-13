### [BANano] BANanoOrderedMap by Mashiane
### 09/19/2023
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/152002/)

Hi  
  
Just took some stuff out of B4XCollections so I can use with BANano. Hope its helpful to someone. Just create a class and copy the code.  
  

```B4X
Sub Class_Globals  
    Private xmap As Map  
    Private xlist As List  
End Sub  
  
Public Sub Initialize  
    xmap.Initialize  
    xlist.Initialize  
End Sub  
  
'Puts a key / value pair to the map. If the key already exists the new value replaces the previous one (and the order doesn't change).  
Public Sub Put (Key As Object, Value As Object)  
    If xmap.ContainsKey(Key) = False Then  
        xlist.Add(Key)  
    End If  
    xmap.Put(Key, Value)  
End Sub  
  
'Removes a pair from the map. This is an O(n) operation.  
Public Sub Remove (Key As Object)  
    If xmap.ContainsKey(Key) = False Then Return  
    xlist.RemoveAt(xlist.IndexOf(Key))  
    xmap.Remove(Key)  
End Sub  
  
'Clears the map.  
Public Sub Clear  
    xlist.Clear  
    xmap.Clear  
End Sub  
  
'Returns the keys as a list. You can sort this list to change the order.  
Public Sub getKeys As List  
    Return xlist  
End Sub  
  
'Gets the value mapped to the key.  
Public Sub Get (Key As Object) As Object  
    Return xmap.Get(Key)  
End Sub  
  
'Gets the value mapped to the key. Returns the passed DefaultValue is no such key exists.  
Public Sub GetDefault (Key As Object, DefaultValue As Object) As Object  
    Return xmap.GetDefault(Key, DefaultValue)  
End Sub  
'Tests whether the map contains the key.  
Public Sub ContainsKey (Key As Object) As Boolean  
    Return xmap.ContainsKey(Key)  
End Sub  
  
'Returns the map size.  
Public Sub getSize As Int  
    Return xmap.Size  
End Sub  
  
'Returns a (copied) list of the collection values.  
Public Sub getValues As List  
    Dim res As List  
    res.Initialize  
    For Each key As Object In xlist  
        res.Add(xmap.Get(key))  
    Next  
    Return res  
End Sub  
  
'Returns an object that can be serialized with B4XSerializator.  
Public Sub GetDataForSerializator As Object  
    Return Array(xmap, xlist)  
End Sub  
  
'Sets the map data from a deserialized object.  
Public Sub SetDataFromSerializator (Data As Object)  
    Dim o() As Object = Data  
    xmap = o(0)  
    xlist = o(1)  
End Sub  
  
public Sub GetKeyAt(idx As Int) As Object  
    Dim s As Int = getSize - 1  
    If idx >= 0 And idx <= s Then  
        Dim itemKey As Object = xlist.Get(idx)  
        Return itemKey  
    Else  
        Return Null  
    End If  
End Sub  
  
public Sub GetValueAt(idx As Int) As Object  
    Dim s As Int = getSize - 1  
    If idx >= 0 And idx <= s Then  
        Dim itemKey As Object = xlist.Get(idx)  
        Dim item As Object = xmap.Get(itemKey)  
        Return item  
    Else  
        Return Null  
    End If  
End Sub
```
### [PyBridge] Convert Python object to dict / map by Erel
### 08/12/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/168194/)

This methods extracts a list of fields from a Python object and creates a dict (Python equivalent to Map) with the field names as keys and the values.  
It is useful when the relevant fields are serializable.  
  

```B4X
Private Sub ObjectToDict (Obj As PyWrapper, Fields As List) As PyWrapper  
    Dim entries As List = B4XCollections.CreateList(Null)  
    For Each key As String In Fields  
        entries.Add(Array(key, Obj.GetField(key)))  
    Next  
    Return Py.Builtins.Run("dict").Arg(entries)  
End Sub
```

  
  
Usage example:  

```B4X
Public Sub RunCommand (Command As String) As ResumableSub  
    Wait For (mConn.RunAwait("run", Array(Command), Null)) Complete (Result As PyWrapper)  
    'Result is a Python object that can't be serialized directly, so we extract the fields:  
    Wait For (ObjectToDict(Result, Array("stdout", "stderr", "exit_status")).Fetch) Complete (Result As PyWrapper)  
    Return Result  
End Sub
```

  
  
An alternative and more powerful option is to add a converter as demonstrated here: <https://www.b4x.com/android/forum/threads/pybridge-non-linear-regression-with-scipy.166985/#content>
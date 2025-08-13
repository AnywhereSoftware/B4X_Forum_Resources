### [PyBridge] Few tips for library developers by Erel
### 03/10/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/166047/)

Here are a few tips I collected while writing the wrapper for Bleak (BLE). Bleak is the first non-small library written for PyBridge and it is worth going over its code. You can unzip the b4xlib to find the two classes.  
  
1. All the Python code that is added with Py.RunCode and the other similar methods, goes into the "global namespace". Practically it is like a single module (code file).  
Py.RunCode / RunCodeAwait accept a MemberName parameter as the first parameter. This is used as a key to prevent the code from being added more than once.  
This key is expected to be the same as the method name and is used to actually execute the method.  
  
You can do something similar in two steps with:  

```B4X
Py.RunNoArgsCode($"  
def func12(x, y):  
    return x + y  
"$)  
'And call this method:  
Dim res As PyWrapper = Py.GetMember("func12").Call.Arg(10).Arg(20)  
res.Print
```

  
And once defined you can call "func12" like this from every place.   
  
2. Raising events:  
Python:  

```B4X
bridge_instance.raise_event("DeviceDisconnected", {"device": client.address})
```

  
B4J:  

```B4X
Private Sub Py_DeviceDisconnected (Args As Map)
```

  
  
3. "Stealing" events:  
In most cases there is a single PyBridge object, that is initialized in B4XMainPage. This means that by default the events are raised there. If you want to handle events in your library code then you can call Py.SetEventMapping:  

```B4X
Py.SetEventMapping("DeviceFound", Me, "Py")  
Py.SetEventMapping("DeviceDisconnected", Me, "Py")  
Py.SetEventMapping("CharNotify", Me, "Py")
```

  
These calls override the default mapping of these events, with Me (current class) as the callback and Py as the event name.   
  
4. Now for something a bit more tricky. The dict that is sent to B4J with the *raise\_event* call, is serialized with B4XSerializator. This means that the types must be compatible with B4XSerializator. There are several ways to extend the types supported by B4XSerializator, but for many complex objects, it doesn't really make sense to serialize them. You actually want to hold a pointer to a Python object. This happens all the time with PyWrapper. The Python process memory is managed by B4J. This makes it a bit more complicated to create Python objects during events.   
It goes like this:  
First we call store\_python\_object with the target object. The returned value is a number which acts as a pointer.  

```B4X
slot = bridge_instance.store_python_object(device)
```

  
The "slot" number is sent in the event dict.  
And in the B4J code we must call *get\_and\_remove\_object* to convert the slot number to a PyWrapper:  

```B4X
t1.BLEDevice = Py.Bridge.Run("get_and_remove_object").Arg(DataFromEvent.Get("device_slot"))
```

  
Now t1.BLEDevice is a PyWrapper pointing to the Python object. Note that if we won't call *get\_and\_remove\_object* then we will have a memory leak.   
  
5. Code to make Python errors more clear:  

```B4X
Public Sub ParseErrorMessage(Raw As String) As String  
    Dim m As Matcher = Regex.Matcher("\(([^)]+)\) - Method: [^.]+\.[^:]+:(.*)$", Raw)  
    Dim msg As String = Raw  
    If m.Find Then  
        msg = m.Group(1)  
        If m.Group(2).Trim <> "" Then  
            msg = msg & " - " & m.Group(2)  
        End If  
    End If  
    Return msg  
End Sub
```

  
It might be added to PyBridge at some point.
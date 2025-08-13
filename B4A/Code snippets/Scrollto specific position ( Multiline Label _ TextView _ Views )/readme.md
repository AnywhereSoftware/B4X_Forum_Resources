### Scrollto specific position ( Multiline Label / TextView / Views ) by epiCode
### 10/21/2024
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/163677/)

If you have a multiline label or view and wish to scroll to specific position programatically,  
 ( provided native view has mScrollY property), you can use the following code to get or set scrollY position:  
( It does not require ScrollView )  
  

```B4X
Public Sub setScrollY(v As View, pos As Int)  
    Dim jo As JavaObject  
    jo = v  
    Try  
        jo.RunMethod("setScrollY",Array(pos))         
    Catch  
        Log(LastException)  
    End Try  
End Sub  
  
Public Sub getScrollY(v As View) As Int  
    Dim jo As JavaObject  
    jo = v  
    return jo.RunMethod("getScrollY", Null)  
End Sub
```
### Return the number of arguements in a compiled sub by Mashiane
### 07/07/2026
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/171479/)

Hi Fam  
  
Declare argCache as a global Map variable…  
  
Third parameter is NOT USED in b4a and b4J…  
  

```B4X
xui.SubExists(subName, "mymymy", 1)
```

  
  

```B4X
Public Sub SubArgCount(Target As Object, SubName As String) As Int  
    #If B4A  
    If Target = Null Then Return -1  
    If argCache.IsInitialized = False Then argCache.Initialize  
    '  
    Try  
    Dim r As Reflector  
    r.Target = Target   
    'get the class name  
    Dim className As String = r.TypeName ' Retrieves the class name  
    'lets see if we have a cache already  
    Dim key As String = className & "|" & SubName.ToLowerCase  
    Dim cached As Object = argCache.Get(key)  
    If cached <> Null Then  
        Dim ci As Int = cached  
        Return ci  
    End If  
      
    ' 1. Get the java.lang.Class object and set it as the new Reflector target  
    r.Target = r.RunMethod("getClass")  
  
    ' 2. Retrieve the array of declared methods from the Class object  
    Dim methods() As Object = r.RunMethod("getDeclaredMethods")  
    Dim paramCount As Int = -1  
    ' 4. Iterate through the methods to find the one you want  
    For Each mObj As Object In methods  
        Dim m As JavaObject = mObj ' Wrap the java.lang.reflect.Method in a JavaObject  
        Dim methodName As String = m.RunMethod("getName", Null)  
        ' Check if it is the target method   
        ' (note: B4A compiled subs start with an underscore and are lowercased)  
        If methodName = $"_${SubName.ToLowerCase}"$ Then  
            ' 5. Call getParameterCount using JavaObject  
            paramCount = m.RunMethod("getParameterCount", Null)  
            Exit  
        End If  
    Next  
    argCache.Put(key, paramCount)  
    Return paramCount  
    Catch  
        Return -1  
    End Try      
    #Else  
        Return -1  
    #End If  
End Sub
```
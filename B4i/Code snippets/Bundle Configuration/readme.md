### Bundle Configuration by AlfaizDev
### 05/30/2022
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/140871/)

This is a list where you can extract some application information  
As you need  
I found it and I said I share it with you  
  
<https://developer.apple.com/documentation/bundleresources/information_property_list/bundle_configuration>  
  

```B4X
Sub PackageName As String  
    Dim no As NativeObject  
    no = no.Initialize("NSBundle").RunMethod("mainBundle", Null)  
    Dim name As Object = no.RunMethod("objectForInfoDictionaryKey:", Array(<property list key>))  
    Return name  
End Sub
```

  
  
Example  
  

```B4X
Sub PackageName As String  
    Dim no As NativeObject  
    no = no.Initialize("NSBundle").RunMethod("mainBundle", Null)  
    Dim name As Object = no.RunMethod("objectForInfoDictionaryKey:", Array("CFBundleIdentifier"))  
    Return name  
End Sub
```

  
  
Choose the information you want to extract
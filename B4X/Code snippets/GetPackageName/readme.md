###  GetPackageName by Alexander Stolte
### 04/17/2024
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/160565/)

I needed one function for all 3 platforms.  
  

```B4X
Private Sub GetPackageName As String  
    #If B4A  
    Return Application.PackageName  
    #Else If B4I  
    Dim no As NativeObject  
    no = no.Initialize("NSBundle").RunMethod("mainBundle", Null)  
    Dim name As Object = no.RunMethod("objectForInfoDictionaryKey:", Array("CFBundleIdentifier"))  
    Return name  
    #Else If B4J  
    Dim joBA As JavaObject  
    joBA.InitializeStatic("anywheresoftware.b4a.BA")  
    Return joBA.GetField("packageName")  
    #End If  
End Sub
```
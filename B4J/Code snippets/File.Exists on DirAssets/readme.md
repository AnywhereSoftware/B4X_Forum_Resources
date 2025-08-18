### File.Exists on DirAssets by Star-Dust
### 02/21/2022
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/138614/)

The need arose within a library to know if there was a Font in the DirAssets.  
I didn't know if the developer had uploaded the font to the App, but if he didn't, the library would crash.  
  
How to do? This was the solution  

```B4X
Private Sub FontExist(FileName As String) As Boolean  
    'If File.Exists(File.DirAssets, "ftypes") Then Return True  
    Dim r As Reflector  
    r.Target = Me  
    r.Target = r.RunMethod("getClass")  
    Dim In As InputStream = r.RunMethod2("getResourceAsStream", "/Files/" &  FileName, "java.lang.String")  
    If In.IsInitialized = False Then Return False  
    In.Close  
    Return True  
End Sub
```
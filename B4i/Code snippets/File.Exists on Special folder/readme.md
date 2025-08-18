### File.Exists on Special folder by Star-Dust
### 07/30/2022
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/138615/)

The need arose within a library to know if there was a Font in the Assets folder.  
I didn't know if the developer had uploaded the font to the App, but if he didn't, the library would crash.  
  
How to do? This was the solution  
  

```B4X
Dim no As NativeObject  
Dim SpecialFolder As String = no.Initialize("NSBundle").RunMethod("mainBundle", Null).RunMethod("bundlePath", Null).AsString  
  
If File.Exists(SpecialFolder,FontFileName) Then  
    '…'  
End If
```
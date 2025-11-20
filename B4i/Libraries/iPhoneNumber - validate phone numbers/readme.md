### iPhoneNumber - validate phone numbers by Erel
### 11/18/2025
[B4X Forum - B4i - Libraries](https://www.b4x.com/android/forum/threads/164417/)

This is a compilation of this open source project: <https://github.com/iziz/libPhoneNumber-iOS>  
  
Usage:  
Add to main module  

```B4X
#AdditionalLib: iPhoneNumber.xcframework.b4i
```

  
  
Validate:  

```B4X
Log(IsNumberValid("(800) 555‑0199", "US"))  
  
  
Private Sub IsNumberValid(Number As String, DefaultRegion As String) As Boolean  
    Dim util As NativeObject  
    util = util.Initialize("NBPhoneNumberUtil").RunMethod("sharedInstance", Null)  
    Dim PhoneNumber As NativeObject = util.RunMethod("parse:defaultRegion:", Array(Number, DefaultRegion))  
    Dim error As NativeObject = util.GetField("gerror")  
    If error.IsInitialized Then  
        Log(error)  
        Return False  
    End If  
    Return util.RunMethod("isValidNumber:", Array(PhoneNumber)).AsBoolean  
End Sub
```
###  check if the time format is 12h or 24h format by Alexander Stolte
### 04/21/2024
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/160644/)

I needed a way to check if the user lives in 12h or 24h time format to give him the possibility to show an AM/PM switch when selecting a time.  
  
There may be a better way to check this, but if I display the following code on an affected device, I see an "a" at the end which indicates AM/PM.  

```B4X
Log(DateTime.DeviceDefaultTimeFormat) 'h:mm a
```

  
  

```B4X
Public Sub is12hTimeFormat As Boolean  
    If DateTime.DeviceDefaultTimeFormat.ToLowerCase.Contains("a") Then  
        Return True  
    Else  
        Return False  
    End If  
End Sub
```
###  AS Settings - Deactivate a property if a certain condition is met by Alexander Stolte
### 02/10/2024
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/158498/)

<https://www.b4x.com/android/forum/threads/b4x-xui-as-settings.147435/>  
  
You need AS\_Settings V2.00+ for this example  
  
The object property has a new variable called "view". It contains the view with which the user interacts. e.g. for a boolean it is the B4XSwitch, for a text it is the TextField.  
  
In the following example, I deactivate PropertyName\_2 and PropertyName\_3 whenever PropertyName\_1 is not True.  
  

```B4X
Private Sub AS_Settings1_ValueChanged(Property As AS_Settings_Property, Value As Object)  
    Select Property.PropertyName  
        Case "PropertyName_1"  
            AS_Settings1.MainPage.GetProperty("PropertyName_2").View.As(B4XSwitch).Enabled = Value  
            AS_Settings1.MainPage.GetProperty("PropertyName_3").View.As(B4XSwitch).Enabled = Value  
        Case Else  
            Log("PropertyName: " & Property.PropertyName & " Value: " & Value)  
    End Select  
End Sub
```

  
  
![](https://www.b4x.com/android/forum/attachments/149412)
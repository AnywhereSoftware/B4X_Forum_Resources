###  AS Settings - Master and child switch by Alexander Stolte
### 02/10/2024
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/158497/)

<https://www.b4x.com/android/forum/threads/b4x-xui-as-settings.147435/>  
  
You need AS\_Settings V2.00+ for this example.  
  
In the following example, PropertyName\_2 and PropertyName\_3 are set to the same value as PropertyName\_1. e.g. PropertyName\_2 and PropertyName\_3 are dependent on PropertyName\_1, if PropertyName\_1 = False then the other 2 should also be False.  
  

```B4X
Private Sub AS_Settings1_ValueChanged(Property As AS_Settings_Property, Value As Object)  
    Select Property.PropertyName  
        Case "PropertyName_1"  
            AS_Settings1.MainPage.SetProperty_Boolean("PropertyName_2",Value)  
            AS_Settings1.MainPage.SetProperty_Boolean("PropertyName_3",Value)  
        Case Else  
            Log("PropertyName: " & Property.PropertyName & " Value: " & Value)  
    End Select  
End Sub
```

  
  
![](https://www.b4x.com/android/forum/attachments/149411)
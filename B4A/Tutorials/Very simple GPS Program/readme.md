### Very simple GPS Program by Justcooldev
### 01/03/2023
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/145210/)

Hi guys,  
  
how to use :  
  
1. copy the starter into your project  
  

```B4X
    If Starter.GPS1.GPSEnabled = False Then  
        ToastMessageShow("Please enable the GPS device.", True)  
        StartActivity(Starter.GPS1.LocationSettingsIntent) 'Will open the relevant settings screen.  
    Else  
        Starter.rp.CheckAndRequest(Starter.rp.PERMISSION_ACCESS_FINE_LOCATION)  
        Wait For Activity_PermissionResult (Permission As String, Result As Boolean)  
        If Result Then CallSubDelayed(Starter, "StartGPS")  
    End If
```

  
  
  
please enjoy it ;)  
  
some images :  
  
![](https://www.b4x.com/android/forum/attachments/137637)
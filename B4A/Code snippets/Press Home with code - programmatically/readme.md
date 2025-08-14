###  Press Home with code - programmatically by Magma
### 07/24/2025
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/167924/)

Well..  
  
If you need to press "Home" without say at user… press Home… but do it programmatically… here the way:  
  

```B4X
Private Sub PressHome  
        Dim iHome As Intent  
        iHome.Initialize("android.intent.action.MAIN", "")  
        iHome.AddCategory("android.intent.category.HOME")  
        iHome.Flags = 0x10000000   ' FLAG_ACTIVITY_NEW_TASK  
        Dim joIntent As JavaObject = iHome  
        Dim joContext As JavaObject  
        joContext.InitializeContext  
        Dim pm As Object = joContext.RunMethod("getPackageManager", Null)  
        If joIntent.RunMethod("resolveActivity", Array(pm)) <> Null Then  
            StartActivity(iHome)  
            Else  
            ToastMessageShow("Seems that you run different launcher or unknown android.",True)  
        End If  
End Sub
```

  
  
\* I ve tested in many devices… and works
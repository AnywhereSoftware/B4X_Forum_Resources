### Open app details page in settings app by Erel
### 07/20/2023
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/149099/)

```B4X
Private Sub OpenAppSettingsPage  
    Dim in As Intent  
    in.Initialize("android.settings.APPLICATION_DETAILS_SETTINGS", "package:" & Application.PackageName)  
    Try  
        StartActivity(in)  
    Catch  
        Log(LastException)  
        ToastMessageShow("Failed to open settings app", True)  
    End Try  
End Sub
```
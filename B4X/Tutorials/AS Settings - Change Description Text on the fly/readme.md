###  AS Settings - Change Description Text on the fly by Alexander Stolte
### 08/08/2024
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/162452/)

<https://www.b4x.com/android/forum/threads/b4x-xui-as-settings.147435/>  
  
How to change the description text of a property:  

```B4X
AS_Settings1.MainPage.GetProperty("ExportDatabase").Description = "Last Backup: Now"  
AS_Settings1.MainPage.Refresh
```

  
  
Simple, isn't it?  
  
The .Refresh method rebuilds the entire list, but the user does not notice this because the changes are immediately visible.
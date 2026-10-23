### XUI.DefaultFolder with Sub Folder by Guenter Becker
### 10/17/2026
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/172308/)

If you like to have all your Apps DataFolder located as Sub Folder in the XUI.DataFolder here is a working solution:  
  
Example B4J/Windows:  
C:\users\<username>\AppData\Roaming\<DeveloperName> as central Folder.  
C:\users\<username>\AppData\Roaming\<DeveloperName>\<AppName> as App Data Folder.  
  

```B4X
XUI.setDefauldFolder("<CentralName>")  'Create central Folder  
file.makeDir(xui.Defaultfolder,"<AppName>")  ' create Sub Folder  
XUI.setDefaultFolder("<CentalName>\<AppName>")   'Update DefaultFolder
```

  
  
And as Result: C:\users\<username>\AppData\Roaming\TechDoc\AppName  
  
Have fun….
### Tip: SQLite Column Does not exist even if you know it exists!!! by Mashiane
### 01/19/2021
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/126721/)

Ola  
  
When you run your app and developing it during debug and release mode. You will find out that you encounter this error.  
  
NB: If during development you make changes to your schema on your files inside "Files" tab.  
  
Now if your code has this kinda of statement.  
  

```B4X
'copy the default DB to working folder  
    If File.Exists(xui.DefaultFolder, DbaseLocal) = False Then  
        File.Copy(File.DirAssets, DbaseLocal, xui.DefaultFolder, DbaseLocal)  
    End If
```

  
  
This means that the database should only be copied if it does not exist. If it exists and you made new changes, you have a bomb!  
  
Solution: Completely de-install your app from your device, this will remove the database also. Installing over and over and coding will not update your db, unless of course you directly run File.Copy each time you debug your app.  
  
#FromARustyB4AHead.
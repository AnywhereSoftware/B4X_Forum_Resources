### The B4J UI program restarts itself by byz
### 11/14/2024
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/164128/)

This is a piece of code that restarts the UI program itself, thanks to the help of the community, I will now organize and publish it. This is useful in scenarios where the program needs to be updated and restarts automatically.  
**Use:** Modify the code of the highlighted line.  
Note: I only tested the Windows UI program packaged into a standalone package  

```B4X
#Region Project Attributes  
    #MainFormWidth: 900  
    #MainFormHeight: 600  
    #PackagerProperty: ExeName = zz  
#End Region
```

  
  

```B4X
Private Sub Button1_Click  
    RestartSelf("zz.exe")  
End Sub  
  
Private Sub RestartSelf(exeName As String)  
    Dim exePath As String=File.Combine(File.GetFileParent(File.DirApp), exeName)  
    Dim shell As Shell  
    shell.Initialize("",exePath,Null)  
    shell.run(-1) 'Run exe  
    Sleep(0) 'important  
    ExitApplication 'Exit exe  
End Sub
```
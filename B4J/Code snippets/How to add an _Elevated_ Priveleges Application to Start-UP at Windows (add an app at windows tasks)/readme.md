### How to add an "Elevated" Priveleges Application to Start-UP at Windows (add an app at windows tasks) by Magma
### 09/22/2022
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/143077/)

Hi there…  
  
Don't Forget… This is a Windows Solution  
  
Well I am sure for those need such a solution, this will help… until now I was using the Registry lib of hatzisn (simple and solid)… but when the .lnk or the standalone exe has Administrator Rights or RunAS Administrator - it will just pass our registry trick without running…  
  
So the only solution (simple and solid) found is this and I am sharing you with you gus:  

```B4X
Sub AddElevatedAppToTasks(TaskFolderAndNameofApp As String,apppath As String)  
    Dim t1 As String=sys32run("schtasks.exe",Array("/create","/SC","ONLOGON","/TN",QUOTE & TaskFolderAndNameofApp & QUOTE,"/TR",QUOTE & apppath & QUOTE,"/RL","HIGHEST"))  
    Log(t1)  
End Sub  
  
Sub DeleteElevatedAppFromTasks(TaskFolderAndNameofApp As String)  
    Dim t1 As String=sys32run("schtasks.exe",Array("/delete","/TN",QUOTE & TaskFolderAndNameofApp & QUOTE,"/f"))  
    Log(t1)  
End Sub  
  
Sub sys32run(app As String,params As List) As String  
    Dim js As Shell  
    js.Initialize("js", app, params)  
    js.WorkingDirectory="c:\windows\system32"  
    'If Main.ShellEncoding.Length>0 Then js.Encoding=Main.ShellEncoding  
    Dim string1 As ShellSyncResult  
    Dim string2 As String  
    string1=js.RunSynchronous(-1)  
    string2=string1.StdOut  
    Return string2  
End Sub
```

  
  
You can use it like this:  
> ' This will add the app at Tasks with the name of exe produced by b4jpackager !  
> AddElevatedAppToTasks("Magma\mSupport",File.GetFileParent(File.DirApp) & "\" & "msupport.exe")  
>   
> 'This will remove it from Tasks…  
> DeleteElevatedAppFromTasks("Magma\mSupport")
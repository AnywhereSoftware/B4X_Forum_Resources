### Print files via jShell and a VBS script (Windows only) by KMatle
### 02/10/2021
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/127500/)

I use this VBS script to print all files in a folder on the standard printer (in my case PDF-files). Windows recognizes the file type and uses the defined program (e.g. Acrobat for PDFs) to print the files. You can easily add some functions (use Google to find out how) like getting the names of all printers and print it to a specified printer.   
  
Change the paths like you need it (here I have created a folder "PRINT" and before I copied the script from the assets folder. So just add it via files dialog).  
  

```B4X
Set fso = CreateObject("Scripting.FileSystemObject")  
Set objArgs = Wscript.Arguments  
WScript.echo objArgs(0)  
if fso.FolderExists(objArgs(0)) then  
   WScript.echo "Exists"  
else  
   WScript.echo "Does not exist"  
end if  
  
set shApp = CreateObject("shell.application")  
set oWsh = CreateObject ("Wscript.Shell")  
  
currentPath = objArgs(0)  
set shFolder = shApp.NameSpace( currentPath )  
  
set files = shFolder.Items()  
  
for each files in files  
    files.InvokeVerbEx ("Print")  
next
```

  
  
Call the script:  
  

```B4X
Sub Print (Folder As String)  
    Dim PrintersSh As Shell  
    PrintersSh.Initialize("Print", "c:\windows\system32\cscript.exe", Array As String("//nologo", File.DirApp & "\PRINT\print.vbs",Folder))  
    PrintersSh.WorkingDirectory = File.DirApp &  "\PRINT\"  
    PrintersSh.Run(120000)  
End Sub  
  
Sub Print_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)  
    Log(StdOut)  
    Log(StdErr)  
    If Success And ExitCode = 0 Then  
    End If     
End Sub
```
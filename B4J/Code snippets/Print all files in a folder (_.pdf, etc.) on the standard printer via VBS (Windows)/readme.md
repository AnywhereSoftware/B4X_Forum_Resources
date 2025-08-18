### Print all files in a folder (*.pdf, etc.) on the standard printer via VBS (Windows) by KMatle
### 11/02/2021
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/135663/)

I use this small vbs script to print all documents (in my case pdf files) on the standard printer (works fine in a WIN 10 production system). Call it via jShell with the folder as a parameter where the docs are. Printing PDF's is very easy as you don't need to know the installed PDF viever and it's path/parms (however you need to have a viewer installed - I have Adobe, others should do, too).  
  
  

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
### B4J Linux app: log file home folder by peacemaker
### 02/23/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/165732/)

This code is well known, to switch the system logging into the file for the Release app version:  
  

```B4X
#if B4J  
Sub RedirectOutput (Dir As String, FileName As String)  
   #if RELEASE  
   Dim out As OutputStream = File.OpenOutput(Dir, FileName, False) 'Set to True to append the logs  
   Dim ps As JavaObject  
   ps.InitializeNewInstance("java.io.PrintStream", Array(out, True, "utf8"))  
   Dim jo As JavaObject  
   jo.InitializeStatic("java.lang.System")  
   jo.RunMethod("setOut", Array(ps))  
   jo.RunMethod("setErr", Array(ps))  
   #end if  
End Sub  
#end if
```

  
  
But for Linux it needs to make extra app's folder in user's home folder, to avoid messing B4J app files to be stored separately for each app:  
  

```B4X
#PackagerProperty: VMArgs = -Dfile.encoding=UTF-8 -Dsun.stdout.encoding=UTF-8 -Dsun.stderr.encoding=UTF-8 -Djdk.gtk.version=2  
  
#if LinuxDebugging or LinuxProduction  
    #VirtualMachineArgs: -Djdk.gtk.version=2 –add-opens javafx.controls/com.sun.javafx.scene.control.skin=ALL-UNNAMED  
#Else  
    #VirtualMachineArgs: -Dfile.encoding=UTF-8 -Dsun.stdout.encoding=UTF-8 -Dsun.stderr.encoding=UTF-8  
#End If  
  
Sub Process_Globals  
    Dim fx As JFX  
    Dim MainForm As Form  
    Dim appname As String = "MyB4Japp"  
    Dim ver As String = "0.995"  
    Dim xui As XUI  
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    #if LinuxDebugging or LinuxProduction  'for Linux we have to create the subfolder in the user home folder  
        If File.Exists(File.DirData(appname), appname) = False Then  
            File.MakeDir(File.DirData(appname), appname)  
        End If  
        #if Release  
            others.RedirectOutput(File.Combine(File.DirData(appname), appname), "logs.txt")  
        #end if  
    #else  
        #if Release and Production  
            RedirectOutput(File.DirData(appname), "logs.txt")    'Windows will store log into %system_drive%:\Users\%user_name%\AppData\Roaming\%appname% that is read- and writeable  
        #end if  
    #End If
```

  
  
Note that here extra build configurations are to be used:  
  
![](https://www.b4x.com/android/forum/attachments/161965)  
  
And do not forget everywhere in the project (where File.DirData is needed) to refer such path for shared files:  
  

```B4X
Sub Folder As String  
    Dim res As String  
    #if B4J  
        #if LinuxDebugging or LinuxProduction  
            res = File.Combine(File.DirData(Main.appname), Main.appname)  
        #else  
            res = File.DirData(Main.appname)  
        #End If  
    #end if  
    Return res  
End Sub
```
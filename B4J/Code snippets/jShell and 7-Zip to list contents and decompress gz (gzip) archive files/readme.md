### jShell and 7-Zip to list contents and decompress gz (gzip) archive files by raphael75
### 05/11/2020
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/117584/)

I use jShell and 7-Zip to unpack/decompress gz (gzip) files in a B4J UI app.  
7-Zip supports also 7z, xz, lzma, cab, zip, bzip2 and tar formats.  
  
**About jShell library:**  
<https://www.b4x.com/android/forum/threads/jshell-library.34661/>  
<https://www.b4x.com/b4j/help/jshell.html>  
  
**About 7-Zip stand-alone tool:**  
<https://www.b4x.com/android/forum/threads/any-library-or-class-to-work-with-tar-gz-files-solved.111971/#post-698205>  
Go to <https://www.7-zip.org/download.html> , download the 7-Zip Extra standalone console version (for instance '7z1900-extra.7z' for version 19.00), and decompress it on your computer.  
Copy '7za.exe' file to 'Objects' directory in your B4J project directory (where the compiled JAR file is generated).  
If you want to embed the 7-Zip tool in the compiled JAR file, see more information at the end of this post.  
  
**7-Zip Help documentation:**  
Download the desktop version of 7-Zip (for instance '7z1900-x64.exe' for 64-bit Windows), and launch it on your computer in order to install it.  
Open Windows Start menu > 7-Zip > 7-Zip Help, and choose 'Command Line Version' Chapter.  
There you will find information about all commands, switches and exit codes.  
  
  
**B4J code to see the list of compressed files in the .gz archive:**  
  

```B4X
Sub btnChooseGzFile_Click  
    '[…] For instance dialog box to choose GZ file  
     
    ' .gz file path including file name  
    Dim sFilePathName As String = "C:\xxx\yyyy.gz"  
     
    Dim sh As Shell  
     
    ' Shell/7-Zip command:  
    ' - "sh": Event name, used later in "sh_ProcessCompleted" to read output  
    ' - "cmd": Windows command interpreter to be run by Shell  
    ' - "/c": Run a command or executable program  
    ' - "7za.exe": Stand-alone 7-Zip program  
    ' - "l": (Command) List contents of archive  
    ' - "-slt": (Switch) Show technical information. Optional.  
    ' - sFilePathName: File path including file name  
    sh.Initialize("sh", "cmd", Array As String("/c", "7za.exe", "l", "-slt", sFilePathName))  
    ' Directory containing '7za.exe'  
    sh.WorkingDirectory = File.DirApp  ' Same directory as the compiled JAR file  
    ' Start the process  
    sh.Run(-1)  
     
    ' Wait for the process to be completed, and read outputs  
    ' "sh" in "sh_ProcessCompleted" must be the Event name defined in sh.Initialize("sh", …)  
    Wait For sh_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)  
    Log("sh_ProcessCompleted [00505_1201]. Success: " & Success)  
    Log("sh_ProcessCompleted [00505_1202]. ExitCode: " & ExitCode)  
    Log("sh_ProcessCompleted [00505_1203]. StdOut: " & StdOut)  
    Log("sh_ProcessCompleted [00505_1204]. StdErr: " & StdErr)  
     
    'If Success = False Or ExitCode <> 0 Then Return  
End Sub
```

  
  
**Example of output in log pane, if the 7-Zip command does not contain **"-slt" option**:**  
  
[FONT=courier new]1: 15:29:43.826: sh\_ProcessCompleted [00505\_1201]. Success: true  
2: 15:29:43.834: sh\_ProcessCompleted [00505\_1202]. ExitCode: 0  
3: 15:29:43.839: sh\_ProcessCompleted [00505\_1203]. StdOut:  
7-Zip (a) 19.00 (x86) : Copyright © 1999-2018 Igor Pavlov : 2019-02-21[/FONT]  
[FONT=courier new]Scanning the drive for archives:  
1 file, 253 bytes (1 KiB)  
Listing archive: C:\xxx\yyyy.gz  
–  
Path = C:\xxx\yyyy.gz  
Type = gzip  
Headers Size = 40  
 Date Time Attr Size Compressed Name  
——————- —– ———— ———— ————————  
2020-03-08 07:25:17 ….. 276 253 zzzzz.zzz  
——————- —– ———— ———— ————————  
2020-03-08 07:25:17 276 253 1 files[/FONT]  
[FONT=courier new]4: 15:29:43.918: sh\_ProcessCompleted [00505\_1204]. StdErr:[/FONT]  
  
**Example of output in log pane, **if the 7-Zip command contains **"-slt" option****:**  
  
[FONT=courier new]1: 15:32:33.607: sh\_ProcessCompleted [00505\_1201]. Success: true  
2: 15:32:33.611: sh\_ProcessCompleted [00505\_1202]. ExitCode: 0  
3: 15:32:33.616: sh\_ProcessCompleted [00505\_1203]. StdOut:  
7-Zip (a) 19.00 (x86) : Copyright © 1999-2018 Igor Pavlov : 2019-02-21[/FONT]  
[FONT=courier new]Scanning the drive for archives:  
1 file, 253 bytes (1 KiB)  
Listing archive: C:\xxx\yyyy.gz  
–  
Path = C:\xxx\yyyy.gz  
Type = gzip  
Headers Size = 40  
———-  
Path = zzzzz.zzz  
Size = 276  
Packed Size = 253  
Modified = 2020-03-08 07:25:17  
Host OS = 255  
CRC = 07501AC0[/FONT]  
  
[FONT=courier new]4: 15:32:33.622: sh\_ProcessCompleted [00505\_1204]. StdErr:[/FONT]  
  
You may parse the StdOut string in order to extract some useful information.  
  
  
**B4J code to decompress the .gz archive:**  
  

```B4X
Sub btnChooseGzFile_Click  
    '[…]  
     
    ' Directory where to put decompressed files  
    Dim sDirPath As String = "C:\xxx\"  
     
    ' 7-Zip command:  
    ' - "x": (Command) Extract with full paths  
    ' - sFilePathName: File path including file name  
    ' -    "-aoa": (Switch) Overwrite All existing files without prompt  
    '   or "-aos": Skip extracting of existing files  
    '   or "-aou": aUto rename extracting file (for example, name.txt will be renamed to name_1.txt)  
    '   or "-aot": auto rename existing file (for example, name.txt will be renamed to name_1.txt)  
    ' - "-o" & sDirPath: (Switch) Set output directory  
    sh.Initialize("sh", "cmd", Array As String("/c", "7za.exe", "x", sFilePathName, "-aot", "-o" & sDirPath))  
    sh.WorkingDirectory = File.DirApp  
    sh.Run(-1)  
     
    Wait For sh_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)  
    Log("sh_ProcessCompleted [00505_1206]. Success: " & Success)  
    Log("sh_ProcessCompleted [00505_1207]. ExitCode: " & ExitCode)  
    Log("sh_ProcessCompleted [00505_1208]. StdOut: " & StdOut)  
    Log("sh_ProcessCompleted [00505_1209]. StdErr: " & StdErr)  
     
    'If Success = False Or ExitCode <> 0 Then Return  
End Sub
```

  
  
**Example of output in log pane:**  
  
[FONT=courier new]1: 18:04:16.402: sh\_ProcessCompleted [00505\_1206]. Success: true  
2: 18:04:16.407: sh\_ProcessCompleted [00505\_1207]. ExitCode: 0  
3: 18:04:16.412: sh\_ProcessCompleted [00505\_1208]. StdOut:  
7-Zip (a) 19.00 (x86) : Copyright © 1999-2018 Igor Pavlov : 2019-02-21[/FONT]  
[FONT=courier new]Scanning the drive for archives:  
1 file, 253 bytes (1 KiB)  
Extracting archive: C:\xxx\yyyy.gz  
–  
Path = C:\xxx\yyyy.gz  
Type = gzip  
Headers Size = 40  
Everything is Ok  
Size: 276  
Compressed: 253[/FONT]  
[FONT=courier new]4: 18:04:16.418: sh\_ProcessCompleted [00505\_1209]. StdErr:[/FONT]  
  
  
**7-Zip tool embedded in compiled JAR file:**  
  
If you want to distribute your JAR file, there are two solutions:  
  
1. Send the '7za.exe' file in addition to the compiled JAR file.  
The user must put both files in the same directory.  
  
2. Embed/include the '7za.exe' file in the compiled JAR file.  
<https://www.b4x.com/android/forum/threads/embed-7-zip-stand-alone-tool-7za-exe-inside-compiled-jar-file.117428>  
  
Procedure if you want to embed '7za.exe' in the JAR file:  
Copy '7za.exe' file to 'Files' directory in your B4J project directory.  
In your B4J project window, click on 'Files' pane, click on 'Synchronize'.  
The '7za.exe' file will be included in the JAR file during compilation.  
In the B4J code, add following lines:  
  

```B4X
Sub Process_Globals  
    ' NB: Following lines are only necessary if you want to embed '7za.exe' in the compiled JAR file  
    ' Customize the name of DirData directory on computer  
    Dim sDirDataName As String = "Raphael_B4J"  
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    ' NB: Following lines are only necessary if you want to embed '7za.exe' in the compiled JAR file  
    ' Copy '7za.exe' from the JAR file to DirData directory on computer  
    'File.Copy(File.DirAssets, "7za.exe", File.DirData(sDirDataName), "7za.exe")  
    If File.Exists(File.DirData(sDirDataName), "7za.exe") = False Then  
        File.Copy(File.DirAssets, "7za.exe", File.DirData(sDirDataName), "7za.exe")  
    End If  
End Sub
```

  
  
In the rest of the code, replace  
  

```B4X
    sh.WorkingDirectory = File.DirApp  ' Same directory as the compiled JAR file
```

  
  
with  
  

```B4X
    sh.WorkingDirectory = File.DirData(sDirDataName)  ' '7za.exe' embedded in JAR file and copied to DirData
```

  
  
In that way '7za.exe' will be embedded in the JAR file during compilation, and it will be extracted/copied from the JAR file to File.DirData when you start the app.  
  
Raphaël
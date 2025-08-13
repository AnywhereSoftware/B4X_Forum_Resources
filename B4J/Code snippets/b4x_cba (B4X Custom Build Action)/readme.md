### b4x_cba (B4X Custom Build Action) by tchart
### 04/12/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/164556/)

Ever since Erel introduced custom build actions I have used a collection of batch files to do certain things when I do a release build eg copy the jar to another folder, compile only etc.  
  
I've finally decided to combine these into a single console application (in C#) instead of a bunch of messy batch files that use RoboCopy, WinRar, 7-zip etc.  
  
This is a single C# console app that you copy to the B4X install folder (eg C:\Program Files\Anywhere Software\B4J) and can use in all of your B4X projects  
  
The tool is free and open source.  
  
The tool and source code is on GitHub - <https://github.com/ope-nz/b4x_cba>  
  
**If you have any suggestions for new custom build actions reply to this topic.**  
  
Supported actions;  

- compileonly - returns an error to stop b4x launching the release version of your app
- copy - copy files or folder
- copyjar - copys the output jar to another directory
- buildtime - creates a file named build.txt with the build time
- updateversion - maintains a version.txt file with increment version number
- zip - zips a file or folder
- moveautobackups - moves auto backup files to another directory
- checksum - writes a SHA256 checksum of the jar file to a text file
- githubpush - pushes the project code to a GitHub repo
- setexeicon - replace or set the icon for an exe
- setexefileinfo - set or replace the exe file info eg CompanyName

[HEADING=2]B4X Custom Build Action (b4x\_cba)[/HEADING]  
This is a C# console application that can be used by B4X for custom build actions.  
  
[HEADING=2]Setup;[/HEADING]  

1. Copy b4x\_cba.exe to your B4X install folder eg C:\Program Files\Anywhere Software\B4J
2. Set up some custom-build actions in your project

[HEADING=2]Usage[/HEADING]  
In your custom actions section call b4x\_cba.exe with an action and other parameters  
  

```B4X
#CustomBuildAction: 2, b4x_cba.exe, -action compileonly
```

  
  
Alternatively as an ide link  

```B4X
'Ctrl + click to increment version: ide://run?File=b4x_cba.exe&Args=-action&Args=updateversion
```

  
  
See <https://github.com/ope-nz/b4x_cba/blob/main/TestCustomBuildActions.b4j> for all examples I use during testing.  
[HEADING=2]Variables[/HEADING]  
The following variables are available when using b4x\_cba.exe  

- %JAR% - the full name of the jar file eg "Example.jar"
- %JAR\_NAME% - just the name of the jar file eg "Example"
- %VERSION% - the version number from version.txt eg 1.0.5
- %PROJECT\_NAME% - the project name eg TestCustomCommands
- %DATE% - a date string in format yyyyMMdd
- %TIME% - a time string in format HHmmss

[HEADING=2]Usage and Supported actions;[/HEADING]  
[HEADING=2]compileonly[/HEADING]  
b4x\_cba returns a 1 exit statement to B4X which stops the app launching. This is useful for release build when you just want to compile.  
  
NOTE: You should run this action last as it stops any further actions running.  
  
#CustomBuildAction: 2, b4x\_cba.exe, -action compileonly  
  
[HEADING=2]copy[/HEADING]  
b4x\_cba will copy a file or folder from the source to the destination directory. "Files" can be used as a shortcut to the assets folder.  
  
#CustomBuildAction: 2, b4x\_cba.exe, -action copy –source ObfuscatorMap.txt -destination D:\Temp  
  
or  
  
#CustomBuildAction: 2, b4x\_cba.exe, -action copy –source src -destination D:\Temp  
  
or  
  
#CustomBuildAction: folders ready, b4x\_cba.exe, -action copy -source D:\Temp\index.html -destination Files  
  
[HEADING=2]copyjar[/HEADING]  
b4x\_cba will copy the output jar to the specified destination directory  
  
#CustomBuildAction: 2, b4x\_cba.exe, -action copyjar -destination D:\Temp  
  
NOTE: In the first release the second argument was named "directory" this has been changed to "destination" for consistency.  
  
[HEADING=2]buildtime[/HEADING]  
b4x\_cba will create a file called build.txt in the Files directory of your project with the current date/time. If you omit the date/time formats they will default to yyyy-MM-dd HH:mm:ss.  
  
NOTE: Remember to sync the files after the first run.  
  
#CustomBuildAction: folders ready, b4x\_cba.exe, -action buildtime  
  
or  
  
#CustomBuildAction: folders ready, b4x\_cba.exe, -action buildtime -dateformat dd/MM/yyyy -timeformat HH:mm:ss  
  
[HEADING=2]updateversion[/HEADING]  
b4x\_cba will create a file called version.txt in the Files directory of your project with an incrementing version number in format 0.0.0-9.9.9  
  
NOTE: Remember to sync the files after the first run.  
  
#CustomBuildAction: folders ready, b4x\_cba.exe, -action updateversion  
  
[HEADING=2]zip[/HEADING]  
b4x\_cba will zip a file or folder from the source to the destination. "Files" can be used as a shortcut to the assets folder. If the source is a file and destination filename is ommitted then the filename will be used but with a .zip extension.  
  
#CustomBuildAction: 2, b4x\_cba.exe, -action zip -source ObfuscatorMap.txt -destination D:\Temp\  
  
or  
  
#CustomBuildAction: 2, b4x\_cba.exe, -action zip -source Files -destination D:\Temp  
  
[HEADING=2]moveautobackups[/HEADING]  
b4x\_cba will move all auto backup files from the projects "AutoBackups" folder to another location.  
  
NOTE: The destination is a directory but the tool will create a subfolder with the project name eg if you use D:\Temp the backups will be moved to D:\Temp\ProjectName  
  
#CustomBuildAction: 2, b4x\_cba.exe, -action moveautobackups -destination D:\Temp  
  
or  
  
'Ctrl + click to move autobackups: ide://run?File=b4x\_cba.exe&Args=-action&Args=moveautobackups&Args=-destination&Args=D:\Temp  
  
[HEADING=2]checksum[/HEADING]  
  
b4x\_cba will calulate a SHA256 checksum of the output jar file and write it to a text file  
  
NOTE: If the destination is a folder then the jar name will be used for the checksum eg example.jar will result in example\_checksum.txt  
  
#CustomBuildAction: 2, b4x\_cba.exe, -action checksum -destination D:\Release  
  
[HEADING=2]githubpush[/HEADING]  
b4x\_cba will push the project to a GitHub repository.  
  
'Ctrl + click to push to GitHub: ide://run?File=b4x\_cba.exe&Args=-action&Args=githubpush  
  
[HEADING=2]setexeicon[/HEADING]  
b4x\_cba will set or replace the icon for an exe.  
  
#CustomBuildAction: 2, b4x\_cba.exe, -action setexeicon -exe D:\Release\application.exe -icon D:\Temp\icon.ico  
  
[HEADING=2]setexefileinfo[/HEADING]  
b4x\_cba will set or replace the file info for an exe.  
  
#CustomBuildAction: 2, b4x\_cba.exe, -action setexefileinfo -exe D:\Release\application.exe -key "FileDescription" -value "Ope Ltd"  
or  
#CustomBuildAction: 2, b4x\_cba.exe, -action setexefileinfo -exe D:\Release\application.exe -key "ProductName" -value "My App"
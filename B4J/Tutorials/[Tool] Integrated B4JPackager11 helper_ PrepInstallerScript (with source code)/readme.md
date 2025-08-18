### [Tool] Integrated B4JPackager11 helper: PrepInstallerScript (with source code) by walt61
### 07/22/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/132798/)

I was making the switch from Java 8 to Java 11 and wanted to use the 'Integrated B4JPackager11' as explained by [USER=1]@Erel[/USER] in <https://www.b4x.com/android/forum/threads/integrated-b4jpackager11-the-simple-way-to-distribute-standalone-ui-apps.117880/>. Nice, but too much work for a lazy guy like me as the InstallerScript template needed copying and editing (and updating each time the version number changes) and then InnoSetup needed to be run. Instead of spending time doing all that for all my programs, I preferred creating this one; all you need to do is add one #CustomBuildAction to your project and Bob's your uncle: your installer will be created automatically. The project is attached to this post.  
  
**General info**  
- PrepInstallerScript's command line arguments must be paired: a key and value combination is expected for each one  
- Values that contain spaces can be enclosed in double quotes  
- In case of issues with PrepInstallerScript, its stdout and stderr can be found in %APPDATA%\PrepInstallerScript  
- You'll probably also have to increase the Process Timeout in the IDE, as Inno Setup will be launched and that step can take some time: Tools -> IDE Options -> Configure Process Timeout (I changed mine to 90 seconds)  
- Additional libraries used (both are internal ones): JavaObject, jShell  
  
**Valid key/value combinations**  
- installerscripttemplate <template file path>: the path of the template file; optional if the 'installerscript' file already exists  
- installerscript <target file path>: the path of the InstallerScript file that is to be updated, or created from the template file (if the file exists, it will be updated, not overwritten)  
- myappname <name of your app>: if omitted, the existing value (possibly from the template file) will remain  
- myappversion <version of your app>: if omitted, the existing value (possibly from the template file) will remain  
- myapppublisher <publisher name for your app>: if omitted, the existing value (possibly from the template file) will remain  
- myappexename <filename.exe>: the file name to be used for your app's executable; don't include path information, do include '.exe'; if omitted, the existing value (possibly from the template file) will remain  
- setupiconfile <icon file path>: the path of the .ico file to be used as icon for your app  
- run <Inno Setup's Compil32.exe path>: optional; if specified, Inno Setup will be run after successful completion  
- deletetempfolder <anything as value>: if specified and Inno Setup was run successfully, the Objects/temp folder will be deleted, which can free up +100Mb  
  
**Example with all possible pairs (split into several lines here for readability; in your project they need to be present on one line)**  

```B4X
#CustomBuildAction: After Packager, YOUR_PATH_HERE\PrepInstallerScript.jar,  
     installerscripttemplate ./temp/InstallerScript-Template.iss  
     installerscript ../InstallerScript.iss  
     myappname "Sample App"  
     myappversion 1.0  
     myapppublisher "My Company Inc"  
     myappexename SampleApp.exe  
     setupiconfile ../files/appicon.ico  
     run "C:\Program Files (x86)\Inno Setup 6\Compil32.exe"  
     deletetempfolder YeahWhyNot
```

  
  
Upon completion, this example would have created a file called 'Setup Sample App.exe' in your project folder, and the Objects\temp folder would have been removed.  
  
Enjoy!
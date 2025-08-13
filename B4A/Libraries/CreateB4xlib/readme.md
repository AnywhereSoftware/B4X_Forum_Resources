### CreateB4xlib by Filippo
### 05/24/2023
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/146240/)

Hi,  
  
with this small Windows application you can easily create a B4xlib library.  
You can save the application "CreateB4xlib.exe" wherever you want.  
The best way is to create a shortcut to the application and save it under this path: C:\Users\your-username\AppData\Roaming\Microsoft\Windows\SendTo  
![](https://www.b4x.com/android/forum/attachments/139435)  
  
This way you can easily create a B4xlib from the contents of a directory using the "Send-To" command.  
  
![](https://www.b4x.com/android/forum/attachments/139433)  
  
The prerequisite is that the compression tool 7-zip is installed and located under "C:\Program Files\7-Zip".  
Only all "\*.bas" and \*.txt" files as well as the directory "Files" are stored in the B4xlib.  
  
18.02.2023: Update to v1.001  
Fixed error when creating.  
  
18.02.2023: Update to v1.002  
The "Objects" directory was mistakenly integrated into the library.  
  
20.02.2023: Update to v1.003  
- Translate messages to English, German and Italian.  
- Create a InnoSetup script to install application and create its shortcut on "C:\Users\[username]\AppData\Roaming\Microsoft\Windows\SendTo".  
- The limitation "no blank character" remains, because the B4xlib should not contain spaces anyway.  
- I had to split the zip-file in 2, because the forum doesn't allow larger files than 512KB.  
 Please delete the ".txt" extension from the zip files.  
  
24.05.2023: Update to v1.004  
- In this new version, classes/files can be excluded.  
 Just add the attribute "ExcludedFiles" in the file "manifest.txt" and the application excludes it from the library.  
 Example of a "manifest.txt" file:  
 Version=1.00  
 B4A.DependsOn=XUI  
 B4i.DependsOn=iXUI  
 ExcludedFiles=clsTest1.bas, clsTest2.bas  
- In the zip file "CreateB4xlib.v1.004.zip" is only the exe file, just uncompress it and replace the old version.
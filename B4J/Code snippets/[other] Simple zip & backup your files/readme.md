### [other] Simple zip & backup your files by KMatle
### 06/14/2021
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/131605/)

This \*.bat file   
  
- creates a new backup folder on a drive (with a timestamp)  
- zips defined folders with a password  
- copies the zip files to another location (here: Google Drive folder which is synched automatically when you've installed it on your pc)  
 -xr! excludes files or file types (e.g. -xr!\*.pdf excludes pdf files)  
  
Note: 7Zip needs to be installed. Even with pw, the filenames are still shown when you open the archive, but the files themselfes are encrypted.  
  
  
  

```B4X
set ts=_%date:~6,4%-%date:~3,2%-%date:~0,2%_%time:~0,2%-%time:~3,2%-%time:~6,2%  
  
set pw=zippassword  
set pathto7zip=C:\Programme\7-Zip\7z.exe  
set backupfolder=D:\Sicherungen\SingleFolders\S%ts%  
  
mkdir "%backupfolder%"  
  
%pathto7zip% a -p%pw% -mx5 -tzip  "%backupfolder%\B4AAPPS_S%ts%.zip" "C:\Users\Klaus\Documents\B4A Apps\KlausSourceCode" -xr!objects -xr!files -xr!autobackups -xr!*.jar  
%pathto7zip% a -p%pw% -mx5 -tzip  "%backupfolder%\B4JAPPS_S%ts%.zip" "C:\Users\Klaus\Documents\B4JApps\" -xr!objects -xr!files -xr!autobackups -xr!*.db -xr!*.jar  
%pathto7zip% a -p%pw% -mx5 -tzip  "%backupfolder%\B4RAPPS_S%ts%.zip" "C:\Users\Klaus\Documents\B4RApps\" -xr!objects -xr!files -xr!bin -xr!autobackups -xr!*.db -xr!*.jar  
%pathto7zip% a -p%pw% -mx5 -tzip  "%backupfolder%\HTDOCS_S%ts%.zip" "C:\xampp\htdocs" -xr!*.pdf -xr!*.db -xr!*.sql  
%pathto7zip% a -p%pw% -mx5 -tzip  "%backupfolder%\OUTLOOK_S%ts%.zip" "C:\Users\Klaus\Documents\Outlook-Dateien\"  
  
xcopy "%backupfolder%\B4AAPPS_S%ts%.zip" "C:\Users\Klaus\Google Drive\Sicherungen"  
xcopy "%backupfolder%\B4JAPPS_S%ts%.zip" "C:\Users\Klaus\Google Drive\Sicherungen"  
xcopy "%backupfolder%\B4RAPPS_S%ts%.zip" "C:\Users\Klaus\Google Drive\Sicherungen"  
xcopy "%backupfolder%\HTDOCS_S%ts%.zip" "C:\Users\Klaus\Google Drive\Sicherungen"  
xcopy "%backupfolder%\OUTLOOK_S%ts%.zip" "C:\Users\Klaus\Google Drive\Sicherungen"  
  
Pause
```
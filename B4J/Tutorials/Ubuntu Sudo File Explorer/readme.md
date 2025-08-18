### Ubuntu Sudo File Explorer by hatzisn
### 06/23/2022
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/141355/)

Here is a nice trick for those of you that develop with B4J for Ubuntu Linux which I found searching for my needs. This code runs a File explorer with priviledges of root. All you have to do is open Text Editor and paste in it this text. Then select filter 'All files' and save as f.e. sudo-files.desktop in the desktop folder. Be aware that the .desktop is needed. Running from this you can change the rights of files on the run without [ICODE]chmod[/ICODE] in terminal.  
  

```B4X
[Desktop Entry]  
Type=Application  
Name=sudo File Manager  
Icon=system-file-manager  
GenericName=File Manager  
Comment=Browse the file system using sudo  
Categories=FileManager;Utility;Core;GTK;  
Exec=sudo open .  
StartupNotify=true  
Terminal=true  
MimeType=x-directory/normal;inode/directory;
```
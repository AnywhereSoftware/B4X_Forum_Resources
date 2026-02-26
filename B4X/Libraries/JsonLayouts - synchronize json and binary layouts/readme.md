###  JsonLayouts - synchronize json and binary layouts by Erel
### 02/23/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/167398/)

The purpose of this tool is to automatically generate json layout files, and synchronize them as they are updated. This can be useful when working with a source control and especially when multiple developers work on the same project.  
  
Usage:  
1. Download jar and put in additional libraries folder: <https://www.b4x.com/b4j/files/JsonLayouts.jar>  
2. Add this code to Main module:  

```B4X
#Macro: After Save, Sync Layouts, ide://run?File=%ADDITIONAL%\JsonLayouts.jar&Args=%PROJECT%&Args=%PROJECT_NAME%  
#Macro: Title, JsonLayouts folder, ide://run?File=%WINDIR%\explorer.exe&Args=%PROJECT%\JsonLayouts
```

  
  
The tool will run whenever the project is saved, and that includes running the project if "auto save" is enabled.  
A folder named JsonLayouts will be created with the json layouts (Ctrl + 1 will open it). The files will be synchronized when the layouts are updated.  
  
Notes  
- The synchronization is at the file level, which means that if both the binary layout and the json layout are updated at the same time, then the tool will show a message about a conflict and will not make any change.  
- There is a notion of the layout owner which is the source of the last conversion. If the owner is deleted then the converted layout is also deleted (moved to recycle bin).  
- As this tool is compatible with B4A, B4J and B4i, it is recommended to put the jar in the B4X additional folder (<https://www.b4x.com/android/forum/threads/b4x-additional-libraries-folder.103165/#content>) and change the "After Save" macro to (thanks [USER=74499]@aeric[/USER] ):  

```B4X
#Macro: After Save, Sync Layouts, ide://run?File=%ADDITIONAL%\..\B4X\JsonLayouts.jar&Args=%PROJECT%&Args=%PROJECT_NAME%
```

  
  
The B4J code is attached.
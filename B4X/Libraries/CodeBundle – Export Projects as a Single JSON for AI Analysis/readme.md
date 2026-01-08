###  CodeBundle – Export Projects as a Single JSON for AI Analysis by Erel
### 01/06/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/169835/)

The purpose of this tool is to easily export the complete project as a single json file which can be then fed to ChatGPT or any other capable AI bot for further analysis. It exports the modules code, layouts and some additional meta information.  
  
This is an experimental tool. Please provide feedback if you find it useful or have any other suggestion.  
  
**Usage:**  
  
- Download the jar file and put it in the additional libraries folder, preferably under the B4X folder.  
- Add to Main or B4XMainPage:  

```B4X
#Macro: Title, Code bundle, ide://run?File=%ADDITIONAL%\..\B4X\CodeBundle.jar&Args=%PROJECT_NAME%
```

  
The path is set with the assumption that the additional libraries folder is set as recommended: <https://www.b4x.com/android/forum/threads/b4x-additional-libraries-folder.103165/#content>  
Change it as needed.  
  
- Click on Ctrl + 1 or the title bar button to export the project.  
  
**Notes:**  
  
- The following optional parameters are supported:  
  
vmargs=-DHandleLayouts%3DFalse - To omit the layout files.  
vmargs=-DCompactJson&3DFalse - To generate non-compact json.  
vmargs=-DDontShowExplorer%3DTrue - Prevent file explorer from opening.  
  
Source code is also attached.  
  
- Save the project before running if you made changes. The tool reads the code from the project files.  
  
**Updates:**  
  
v0.31 - Fixed bug where first character was missing. Thanks [USER=74499]@aeric[/USER] for reporting.  
v0.3 - #SignKeyPassword is removed from output.  
Most regular libraries are now also added to the output.  
v0.2 - API keys are replaced with all-zeros key. This is done heuristically based on several regex patterns. Replaced keys are logged. If you encounter a key that isn't replaced then please post an example.  
Information about referenced b4xlibs is added to the output.  
  
**Download link: <https://www.b4x.com/android/files/CodeBundle.jar>**
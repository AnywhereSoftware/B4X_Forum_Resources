###  Comment Links and #Macros by Erel
### 09/16/2025
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/119897/)

![](https://www.b4x.com/basic4android/images/qHTNrUJnPQ.gif)  
  
**Comment Links**  
  
Code comments can include clickable links. The following schemes are supported:  
  
http(s):// - Link will be opened with the browser.  
Example:  

```B4X
Dim key As String = OrderedMap.Keys.Get(0) 'based on https://www.b4x.com/android/forum/threads/b4x-b4xorderedmap-get-first-item-nth-item-and-last-item.118642/
```

  
  
file:// - Link will be opened with the default program.  

```B4X
'see the presentation: file://C:\Users\H\Documents\Presentation+With+Spaces.pptx
```

  
  
ide:// - Link will be handled by the IDE. There are currently two types of methods:  
goto:  
Clicking on link will move the cursor to the specified target.  

```B4X
'called from: ide://goto?Module=B4XMainPage&Sub=Button1_Click
```

  
Module is optional, the current module is set by default.  
Line can be used instead of Sub to jump to a specific line.  
  
run:  
Runs an external program. It can be a batch file, a B4J jar file (UI or non-UI) or an executable.  
You can pass arguments with the Args parameter, which can be used multiple times.  
For example the B4XPages templates includes this line:  

```B4X
'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip
```

  
It calls a B4J program from the internal installation folder named Zipper.jar. It is similar to the built-in 'export as zip' feature but works with cross platform projects.  
Note that the external program working directory will be the current project Objects folder.  
  
**Notes**  

- Spaces should be replaced with +.
- The parameters values are url decoded.
- The ide://run method supports these additional arguments:

- FilesSync=True - Causes the IDE to sync the Files folder after operation completes.
- CleanProject=True - Causes the IDE to clean the project after operation completes.
- VMArgs - Similar to Args but added as a JVM argument.
You can add: VMArgs=-DZeroSharedFiles%3DTrue to a zipper call to delete the content of the platform specific copies of shared files (the content will be added back when the program runs, because of the custom build action).
- The parameter values can include the following case sensitive aliases:

- %B4X% - installation folder.
- %PROJECT% - project folder (location of the project .B4? file).
- %PROJECT\_NAME% - project name.
- %JAVABIN% - configured java bin folder (not available in beta #1)
- %ADDITIONAL% - Platform specific additional libraries folder.
- Any other environment variable.

**Macros**  
  
Similar to comment links, but accessible through the window title buttons (with the shortcuts) or automated in some other way.  
Defined in B4XMainPage or Main modules. Format: <type>, <name>, <link>  
Currently supported types:  
- Title - adds a title button.  
- After Save - runs the command after the project is saved.  
  
![](https://www.b4x.com/android/forum/attachments/1748432922420-png.164397/)  
  
Examples:  

```B4X
#Macro: Title, B4XOrderedMap Doc, https://www.b4x.com/android/forum/threads/b4x-b4xorderedmap-get-first-item-nth-item-and-last-item.118642/  
#Macro: Title, B4XPages Export, ide://run?File=%B4X%\Zipper.jar&Args=Project.zip  
'open Objects folder after saving project:  
#Macro: After Save, open objects folder, ide://run?File=%WINDIR%\explorer.exe&Args=%PROJECT%\Objects
```

  
A tool based on "After Save" that synchronizes binary and json layouts: <https://www.b4x.com/android/forum/threads/b4x-jsonlayouts-synchronize-json-and-binary-layouts.167398/#content>  
  
#CustomBuildAction - similar tool for running commands during compilation: <https://www.b4x.com/android/forum/threads/b4x-custombuildaction.168654/#post-1033843>
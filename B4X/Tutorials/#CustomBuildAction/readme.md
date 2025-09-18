###  #CustomBuildAction by Erel
### 09/16/2025
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/168654/)

The #CustomBuildAction attribute allows running external programs during the compilation process.  
The syntax is:  

```B4X
#CustomBuildAction <compilation step>, command to run, zero or more arguments
```

  
  
It is related to the comment links and #Macro features <https://www.b4x.com/android/forum/threads/b4x-comment-links.119897/>. it uses a simpler syntax.  
  
Example from B4XPages template, that copies the updated "shared files" to the platform specific Files folder during compilation, after the project folders are created if needed:  

```B4X
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
```

  
  
The following compilation steps are available:  
  
**B4X**  
  
*1* - no reason to use. Before the cleaning step. Use "folders ready" instead.  
*folders ready* - after the code is parsed and the folders tree is ready.  
  
**B4A**  
  
*2* - before the "Compiling resources (aapt2)" step  
*3* - before the "Signing AAB file" step  
*after packager* - after the "Signing AAB file" step  
*4* - before the installation step  
*5*- after the installation step  
  
**B4J**  
  
*2* - before the compiled program is run  
*3* - after a library was compiled  
*before packager* - before the standalone package process starts  
*after packager* - after a standalone package was built  
  
**Command variables**  
  
The following variables can be used (same as with comment links and #Macro):  
Environment variables (%WINDIR%, etc.)  
%PROJECT% - project path, where the main project file is located.  
%B4X% - IDE folder  
%JAVABIN% - Java bin folder  
%PROJECT\_NAME% - project name based on the main project file.  
%ADDITIONAL% - additional libraries folder  
%B4J\_PYTHON% (B4J only) - global Python folder, as set under Tools - Configure Paths  
  
**Notes**  
  
- The commands root path is the project's Objects folder.  
- Multiple actions can be added during the same compilation step.  
- CustomBuildActions are not executed when building from the command line.
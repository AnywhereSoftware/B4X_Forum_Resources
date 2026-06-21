### [Script] Convert Class.bas to Class.b4x_excluded by aeric
### 05/27/2026
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/171127/)

This script converts file with \*.bas extension to \*.b4x\_excluded to be included into B4X library as class template.  
  
The following lines are not visible inside B4J Code Editor but are visible if you open the \*.bas file using a text editor.  

```B4X
B4J=true  
Group=Handlers  
ModulesStructureVersion=1  
Type=Class  
Version=10.5  
@EndOfDesignText@
```

  
In order to use as a class template, line of code as seen above need to be removed. This script will remove the lines for us so we don't need to edit the files one by one.  
[HEADING=1]How to use[/HEADING]  
1. Save the following code as create\_excluded.bat   
OR download the attached txt file then delete the .txt file extension.  
2. Put the file same path as .b4j project file.  

```B4X
@echo off  
setlocal  
  
if "%~1"=="" (  
    echo Usage:  
    echo    create_excluded.bat file1.bas file2.bas  
    pause  
    exit /b  
)  
  
:nextfile  
  
if "%~1"=="" goto done  
  
set "INPUT=%~1"  
set "OUTPUT=%~dpn1.b4x_excluded"  
  
echo.  
echo Processing:  
echo    %INPUT%  
echo Output:  
echo    %OUTPUT%  
  
powershell -NoProfile -ExecutionPolicy Bypass -Command "$found=$false; Get-Content '%INPUT%' | ForEach-Object { if($found){ $_ } elseif($_ -match '@EndOfDesignText@'){ $found=$true } } | Set-Content '%OUTPUT%'"  
  
shift  
goto nextfile  
  
:done  
  
echo.  
echo Finished.  
pause
```

  
  
The command is:  

```B4X
create_excluded.bat file1.bas file2.bas
```

  
3. We can use Macro to call this batch file.  
  
Example I used in Pakai Vest:  

```B4X
#Macro: Title, Class Templates, ide://run?File=%PROJECT%\create_excluded.bat&Args=..\CrudApiHandler.bas&Args=..\CrudHandler.bas&Args=..\CrudModel.bas&Args=..\CrudView.bas
```
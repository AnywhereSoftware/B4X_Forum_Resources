### easily compile and run B4J project with javaFx by spsp
### 05/18/2021
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/130856/)

Hi,  
  
after reading [this post](https://www.b4x.com/android/forum/threads/how-to-execute-jar-file-with-java-11-javafx-components-missing.109247/), i write this little batch script (compile\_and\_run\_jar.bat)  
  

```B4X
echo off  
cls  
echo ==========================================  
echo compile B4J project and run it with JavaFx  
echo ==========================================  
  
rem search for project file and store it in variable project (without extension)  
for /f "delims=" %%f in ('dir /B ".\*.b4j"') do set project=%%~nf  
echo Project : %project%  
  
rem set variables  
set BAJCOMPILER="C:\Program Files (x86)\Anywhere Software\B4J\b4jbuilder.exe"  
set JAVADIR="C:\java\jdk-11.0.1"  
set JARFILE="%cd%\Objects\%project%.jar"  
set STARTDIR="%cd%\Objects\"  
  
rem compile project  
%BAJCOMPILER% -task=build  
  
rem check compilation error (exit code 1)  
if %ERRORLEVEL% == 1 (  
    pause  
    exit 1  
)  
  
rem run jarfile with Javafx  
%JAVADIR%\bin\java.exe –module-path %JAVADIR%\javafx\lib –add-modules=javafx.controls,javafx.fxml,javafx.web -jar %JARFILE%  
  
rem remove Objects folder  
rd objects /s/q  
exit 0
```

  
  
Put it in the project folder and run it. It will :  
- compile the project  
- run the jar file with javaFx support  
- delete the objects folder when finished  
  
spsp
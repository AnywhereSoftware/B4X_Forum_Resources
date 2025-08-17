### How to create a StandAlone EXE without the OpenJAVA (OpenJDK)... an update for your app.. by Magma
### 11/18/2022
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/144239/)

Well "[USER=29101]@MrKim[/USER]" had a wish… and talking about this… then an idea came into my mind… not a "super-duper" but a trick…  
Wish:  
<https://www.b4x.com/android/forum/threads/b4j-executables-wish-es.140119/#post-914123>  
  
So I am here to share it with you guys…  
  
**How to Create StandAlone Updates that will no need to include all the OpenJava (OpenJDK) files again.**  
  
\* That mean, that first you must already had a Setup (for example created at Inno) extracting, copying the openjdk at the folder you want to call it afterwards, and ofcourse your basic app !  
  
Now the standalone update…  
  
First, make sure you already have IExpress.exe, by searching it (c:\windows\system32)… yes this tool exist for years… and is very old ! – But.. hey do not open it yet…  
  
**Create a folder in C:\, let’s say C:\myupdateproject**  
  
Into it create a batch file let’s say… **test.bat**  
  
Having this code:  

```B4X
@echo off  
  
setlocal  
SET CURDIR=%CD%  
rem %CD:~0,3%  –> that will get current drive, without 0,3 will get current directory… but may be you wanna have it standard at c:  
IF NOT EXIST "C:\java\bin\javaw.exe" GOTO DOESNOTEXIST  
  
set alias=Reg query "HKLM\Software\Microsoft\NET Framework Setup\NDP"  
FOR /F "TOKENS=6 DELIMS=\." %%A IN ('%alias%') DO set .NetVer=%%A  
REM ECHO The most current version of Net in use is %.NetVer%  
IF 4 GTR %.NetVer% GOTO NETVR  
  
echo Copy Files from temp extraction folder to specific directory  
md c:\test1  
copy /Y *.* c:\test1  
cd c:\test1  
  
echo Let's start our JAVA JAR app…  
REM i am having my openjava in c:\java … %CD%\ for app path.. may be need used  
START C:\java\bin\javaw.exe –module-path C:\java\javafx\lib –add-modules ALL-MODULE-PATH -jar "c:\test1\app.jar"  
  
GOTO END  
  
:NETVR  
echo .Net Framework is lower than 4  
powershell [Reflection.Assembly]::LoadWithPartialName("""System.Windows.Forms""");[Windows.Forms.MessageBox]::show(""".Net Framework is lower than 4""", """YourAPPName""",0)>nul  
REM here you can download if you want… or open url  
start https://support.microsoft.com/en-us/topic/microsoft-net-framework-4-8-offline-installer-for-windows-9d23f658-3b97-68ab-d013-aa3c3e7495e0  
  
GOTO END  
  
:DOESNOTEXIST  
echo OpenJDK not exists at folder C:\java\  
powershell [Reflection.Assembly]::LoadWithPartialName("""System.Windows.Forms""");[Windows.Forms.MessageBox]::show("""OpenJDK not exists at folder C:\java\""", """YourAPPName""",0)>nul  
REM here you can download if you want… or open url  
start https://b4xfiles-4c17.kxcdn.com/jdk-11.0.1.zip  
  
  
:END  
endlocal
```

  
  
  
In the same folder copy your built - release jar app…  
  
Okay now run “cmd.exe” with **Admin Rights**, an easy way is having it at taskbar settings (wind10) instead Powershell… so right click at Start Menu… has command line (Administrator)….  
  
**Get into C:\myupdateproject, typing cd c:\myupdateproject  
  
And run from here IExpress.exe** (have in mind running from anywhere else will not work right)  
  
  
![](https://www.b4x.com/android/forum/attachments/136131)  
Next.. is «Επόμενο» (in greek, sorry guys)  
  
  
![](https://www.b4x.com/android/forum/attachments/136132)  
Select first option and Next.. «Επόμενο»  
  
  
  
  
![](https://www.b4x.com/android/forum/attachments/136133)  
Name of package… let’s say test… and Next  
  
  
  
  
![](https://www.b4x.com/android/forum/attachments/136134)  
Next…  
  
  
  
  
![](https://www.b4x.com/android/forum/attachments/136135)  
Next…  
  
  
  
![](https://www.b4x.com/android/forum/attachments/136136)  
![](https://www.b4x.com/android/forum/attachments/136137)  
  
Add here your batch file and app.jar… Next  
  
  
  
  
![](https://www.b4x.com/android/forum/attachments/136138)  
At Install program “cmd /c test.bat”… next  
  
  
  
  
![](https://www.b4x.com/android/forum/attachments/136139)  
I prefer Hidden … to not show cmd shell.. but may be need to trick form to show from b4j code… next  
  
  
  
  
![](https://www.b4x.com/android/forum/attachments/136140)  
Next…  
  
  
![](https://www.b4x.com/android/forum/attachments/136141)  
Here you must give the **exe name** you wanna create… also check Hide and Store… and Next…  
  
  
![](https://www.b4x.com/android/forum/attachments/136142)  
I like no restart… and next…  
  
  
  
  
![](https://www.b4x.com/android/forum/attachments/136143)  
Save it for future editing… next…  
  
  
  
  
![](https://www.b4x.com/android/forum/attachments/136144)  
Next..  
  
  
![](https://www.b4x.com/android/forum/attachments/136145)  
And magic… creating the exe…  
  
  
![](https://www.b4x.com/android/forum/attachments/136146)  
Τέλος… is the END !  
an exe created that including batch inside of it, jar and any other file you want…  
  
ps: I love batch files !
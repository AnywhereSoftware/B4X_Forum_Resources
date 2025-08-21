### Better Windows Services (for B4J) by tchart
### 07/16/2020
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/120190/)

There are many threads on the fourm regarding Windows Services e.g. <https://www.b4x.com/android/forum/threads/java-as-windows-service.65741/#content>  
  
For many years Ive used "[JavaService](http://www.multiplan.co.uk/software/javaservice/docs/description.html)" but this is old, hasnt been updated for years and while robust isn't that friendly to set up.  
  
To be fair to JavaService Ive had no issues with it until recently…  
  
Regarding that I have a B4J app that runs as a windows service. It collects data on a server regarding infrastructure using a 3rd party library. The 3rd party library is rock solid on Linux but I found on Windows that after the service has been running for a few days I will get (randomly) a Java heap space error. Ive lifted the max heap space several times but all that happens is the error gets pushed out a few days more but ultimately ends up occuring.  
  
Rather than instructing my users to restart the service occasionally I started looking at self restarting services. Unfortunately this wasn't possible with JavaService - even though I could relaunch the app the service controller would lose "control" of the application and would no longer be able to stop the service. I looked at extending the JavaService code but decided against this due to the complexity of the code.  
  
So I started looking at other options for the service wrappers.  
  
[Tanuki](https://wrapper.tanukisoftware.com/doc/english/download.jsp) is by far the best and has the restart ability, however unless your project is open source you require a commerical license which is very very expensive.  
  
After doing some research on alternative Java service wrappers I came across WinSW - <https://github.com/winsw/winsw>  
  
WinSW is an open source service wrapper written in .Net. It has a liberal license and supports service restarting amongst many other features.  
  
The set up and config is even easier than JavaService as it is configured using an XML config file.  
  
A list of just some of the advantages;  
  
1. It's written in .Net which is usually on most Windows servers - I encountered issues on some Windows Servers with JavaService and missing older Visual C runtime dll's.  
2. WinSW config is in an XML file - instead of having a complex batch file to install a service.  
3. WinSW supports self-restarting services - it exposes a method which you can call from your B4J application.  
4. WinSW supports more advanced log file management (e.g. rolling log files, auto deleting of older logs) - plus theres no need to redirect stdout/stderr, this is done automatically.  
5. WinSW supports auto download of files allowing you to do inplace upgrades.  
6. If you need to alter the service definition (e.g. add in an argument) you just update the XML config - JavaService requires changes to the registry or uninstall/reinstall the service.  
  
Here is an example of a simple XML config file.  
  

```B4X
<service>  
  <id>some.agent</id>  
  <name>Some Agent</name>  
  <description>Some Agent</description>  
  <executable>%BASE%\runtime\java\bin\java.exe</executable>  
  <startarguments>-jar %BASE%\some_agent.jar -Xms32M</startarguments>  
  <workingdirectory>%BASE%</workingdirectory>  
  <logpath>%BASE%\logs</logpath>  
  <log mode="roll-by-size">  
    <sizeThreshold>10240</sizeThreshold>  
    <keepFiles>8</keepFiles>  
  </log>  
</service>
```

  
  
The WinSW executable can be renamed to anything you want but the XML file must have the same name. So if you rename it to Bob.exe then the config will be Bob.xml.  
  
Once your config is ready you simple run "Bob.exe install" to install the service and "Bob.exe uninstall" to remove the service.  
  
NOTE: Batch files need to be run as admin  
  
Example install batch file.  
  

```B4X
@echo off  
  
setlocal  
  
SET homedir=%~dp0  
IF %homedir:~-1%==\ SET homedir=%homedir:~0,-1%  
  
REM Needs full path as running as admin puts us in system32  
%homedir%\Bob.exe install  
  
REM Start the service  
net start "Bob Service"  
  
pause
```

  
  
And to uninstall the service (this will prompt for admin access)  
  

```B4X
@echo off  
  
setlocal  
  
REM Stop the service so we can remove it  
net stop "Bob Service"  
  
SET homedir=%~dp0  
IF %homedir:~-1%==\ SET homedir=%homedir:~0,-1%  
  
%homedir%\Bob.exe uninstall  
  
pause
```

  
  
Below is some B4J code to restart the service from B4J.  
  
NOTE: WINSW\_EXECUTABLE is an environment variable that is available to your B4J app that gives the complete path to the service wrapper.  
NOTE: The "restart!" argument tells the service to restart the app.  
  

```B4X
Sub RestartService()  
    Logger.Info("Attempting restart of service")  
  
    Dim Executable As String = GetEnvironmentVariable("WINSW_EXECUTABLE","Bob.exe") 'Set a default in case the env variable isnt there  
  
    Dim shl As Shell  
    Try  
        shl.Initialize("shl", Executable, Array As String("restart!"))  
        shl.WorkingDirectory = File.DirApp  
        shl.Run(-1)  
    Catch  
        Log(LastException.Message)  
    End Try  
End Sub
```
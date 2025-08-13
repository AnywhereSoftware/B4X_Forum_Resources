### Blue Stacks connection to B4X IDE. by 73Challenger
### 09/29/2023
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/154316/)

Blue Stacks 5 adb connection is now more difficult for Android developers. It now randomly chooses the ADB port number every time it starts up. For those of you using Blue Stacks to develop, here is some information and a work around. Note: This post could become quickly dated if BlueStacks or Android makes another change.  
  
I was facing 2 issues….  
1. The port that adb uses is (now) randomly chosen every time causing problems with the ADB server connection….screenshot below.  
2. When I try to open B4A bridge in Blue Stacks it immediately closes/disconnects.  
 Blue Stacks is now "blocking" the bridge…at least for me. So… not really a B4X issue… just Android and or Blue Stacks moving the goal post again.  
  
![](https://www.b4x.com/android/forum/attachments/146498)  
  
**\*\*\*\*The Work Around\*\*\*\*\***  
Connecting to Blue Stacks with IDE  
Since Blue Stacks has changed to randomly choose the ADB port number every time it starts up, they have made connecting with the IDE more annoying. Here is a work around  
  
![](https://www.b4x.com/android/forum/attachments/146497)  
\*\*\*With IDE already open\*\*\*  
- Go to Advanced Settings in Blue Stacks, get the port number (above).  
- Run the following on the command line (your path may be different).  
- **C:\Android\platform-tools\adb connect 127.0.0.1:{enterporthere}**  
  
\*\*\*The port number will change every time you start/re-start Blue Stacks\*\*\*  
\*\*\*You may need to open/close the IDE or restart the ADB server in IDE.\*\*\*  
  
Below is a handy (Windows) batch file you can that will prompt you for the port number and run the command.  
  
Run the command or batch file, then in the B4X IDE, try to debug/send a release to Blue Stacks……so far, this workaround has worked for me.  
  

```B4X
@echo off  
setlocal  
  
REM Prompt the user for a port number  
set /p PortNumber=Enter the port number:  
  
REM Check if the input is empty  
if "%PortNumber%"=="" (  
    echo Port number cannot be empty. Exiting…  
    exit /b 1  
)  
  
REM Run the adb connect command with the provided port number  
C:\Android\platform-tools\adb connect 127.0.0.1:%PortNumber%  
  
REM Exit the batch file  
exit /b 0
```

  
  
  
Edit: There is one additional source that could be used to retrieve the port number dynamically, should anyone wish to take that on. The Blue Stacks conf contains the current port number. Conceivably, a user could start Blue Stacks, the random port would then be saved to the conf file. A script could be started that reads the conf file, parses out the port, then runs the adb command above. I have not tried this, for me, not worth it, but for someone with complex scripting requirements, it might be. Either way, it's a "good to know."  
  
![](https://www.b4x.com/android/forum/attachments/146499)
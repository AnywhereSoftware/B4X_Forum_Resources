### Filter logs (intended for ABMaterial web apps but should be easy to adapt to other non-UI B4J projects) - created with assistance of Microsoft Copilot by JackKirk
### 05/30/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/167188/)

In the ABMaterial framework there is the ability to push all logs to a file by code like:  
  
Server.RedirectOutput(File.DirApp, "logs.txt")  
  
and if you dig up the code for this it looks like:  

```B4X
' redirects the logs  
public Sub RedirectOutput (Dir As String, FileName As String)  
#if RELEASE  
    If LogsOutput.IsInitialized Then LogsOutput.Close  
    LogsOutput = File.OpenOutput(Dir, FileName, False) 'Set to True to append the logs  
    Log("Redirecting logs to: " & FileName)  
    Dim ps As JavaObject  
    ps.InitializeNewInstance("java.io.PrintStream", Array(LogsOutput, True, "utf8"))  
    Dim jo As JavaObject  
    jo.InitializeStatic("java.lang.System")  
    jo.RunMethod("setOut", Array(ps))  
    jo.RunMethod("setErr", Array(ps))  
#end if  
End Sub
```

  
  
This is not very useful if you want real time logging.  
  
I have found that if I compile my B4J ABMaterial project as a jar (say D:\B4X\_WebServer01\WebServer01.jar) then I can run it with a .bat file like:  

```B4X
echo on  
  
taskkill /IM "WebServer01.exe" /F  
rem and just to make sure…  
Powershell.exe Stop-Process -Name "WebServer01" -Force  
  
call :queryisadmin  
if %errorlevel% == 0 (goto :runpayload) else (goto :getadmin)  
exit /b  
  
:queryisadmin  
fsutil dirty query %systemdrive% > nul  
exit /b  
  
:getadmin  
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin_WebServer01.vbs"  
echo UAC.ShellExecute "cmd.exe", "/c %~s0 %~1", "", "runas", 1 >> "%temp%\getadmin_WebServer01.vbs"  
"%temp%\getadmin_WebServer01.vbs"  
del "%temp%\getadmin_WebServer01.vbs"  
exit /b  
  
:runpayload  
set javadir=C:\java\jdk-19.0.2  
erase "%javadir%\bin\WebServer01.exe"  
copy "%javadir%\bin\java.exe" "%javadir%\bin\WebServer01.exe"  
cd /d D:\B4X_WebServer01  
C:\java\jdk-19.0.2\bin\WebServer01.exe -jar "D:\B4X_WebServer01\WebServer01.jar"
```

  
  
and I will then have a permanent command prompt window which will display any log messages.  
  
So I then have my real time logging capability - the only problem being it is terribly messy and has all sorts of stuff of no real interest.  
  
To filter the log messages I have come up with this code which is added to the Main procedure:  

```B4X
Sub Process_Globals  
…  
    Public Gen_jetty_log_filter As String  
    Public Gen_b4j_log_filter As Map  
    Public Gen_original_out As JavaObject  
…  
End Sub  
  
  
      Gen_jetty_log_filter = TRACE, DEBUG, INFO (default), WARN, ERROR or OFF  
      Gen_b4j_log_filter is a map with the keys being filters  
  
      'Set up log filters - just before Server.Initialize("", DonatorKey, "start")  
      Filter_logs  
   
'************************************************************************************  
'  
'This procedure sets up log filters  
'  
'Input parameters are:  
'  
'       None  
'  
'Returns:  
'  
'       -  
'  
'Notes on this procedure:  
'  
'       o Created with the assistance of Copilot  
'  
'************************************************************************************  
Private Sub Filter_logs  
   
    'Set jetty server log level - TRACE, DEBUG, INFO (default), WARN, ERROR or OFF  
    SetSystemProperty("org.eclipse.jetty.util.log.class", "org.eclipse.jetty.util.log.StdErrLog")  
    SetSystemProperty("org.eclipse.jetty.LEVEL", Gen_jetty_log_filter)  
   
    Private wrk_system As JavaObject  
    wrk_system.InitializeStatic("java.lang.System")  
  
    'Capture original System.out before redirection  
    Gen_original_out = wrk_system.GetField("out")  
  
    'Explicitly create an instance of current module instead of using Me  
    Private moduleInstance As JavaObject  
    moduleInstance.InitializeNewInstance("com.ab.template.main", Null)  
  
    'Pass instance to Java PrintStreamWrapper  
    Private wrk_filteredstream As JavaObject  
    wrk_filteredstream.InitializeNewInstance("com.ab.template.main$PrintStreamWrapper", Array(Gen_original_out, moduleInstance))  
  
    'Redirect standard output  
    wrk_system.RunMethod("setOut", Array(wrk_filteredstream))  
   
    'Redirect error output  
    wrk_system.RunMethod("setErr", Array(wrk_filteredstream))  
   
End Sub  
  
'************************************************************************************  
'  
'This procedure is called by java PrintStreamWrapper when a log message is found  
'  
'Input parameters are:  
'  
'       Mess_age = message  
'  
'Returns:  
'  
'       -  
'  
'Notes on this procedure:  
'  
'       o It has to be Public otherwise java PrintStreamWrapper can't see it  
'       o I don;t know why this procedure and ProcessLogMessageInternal have to be  
'         set up like this but it works  
'       o Created with the assistance of Copilot  
'  
'************************************************************************************  
Public Sub ProcessLogMessage(Mess_age As String)  
   
    CallSubDelayed2(Me, "ProcessLogMessageInternal", Mess_age)  
   
End Sub  
  
'************************************************************************************  
'  
'This procedure is called by ProcessLogMessage when a log message is found  
'  
'Input parameters are:  
'  
'       Mess_age = message  
'  
'Returns:  
'  
'       -  
'  
'Notes on this procedure:  
'  
'       o I don;t know why this procedure and ProcessLogMessage have to be  
'         set up like this but it works  
'       o Created with the assistance of Copilot  
'  
'************************************************************************************  
Private Sub ProcessLogMessageInternal(Mess_age As String)  
  
    'For each filter…  
    For Each wrk_key As String In Gen_b4j_log_filter.Keys  
   
        'Quit if mesage contains filter  
        If Mess_age.Contains(wrk_key) Then Return  
   
    Next  
  
    'If got to here mesage passed filters so print it to original System.out  
    Gen_original_out.RunMethod("println", Array(Mess_age))  
   
End Sub  
  
#If Java  
import java.io.PrintStream;  
import java.lang.reflect.Method;  
  
public static class PrintStreamWrapper extends PrintStream {  
    private Object b4jInstance;  
    public PrintStreamWrapper(PrintStream original, Object b4jInstance) {  
        super(original);  
        this.b4jInstance = b4jInstance;  
    }  
    public void println(String message) {  
        try {  
            //Use `_processlogmessage` instead of `ProcessLogMessage`  
            Method method = b4jInstance.getClass().getMethod("_processlogmessage", String.class);  
            method.invoke(b4jInstance, message);  
        } catch (Exception e) {  
            //System.out.println("Exception calling _processlogmessage: " + e.getMessage());  
            //e.printStackTrace();  
        }  
    }  
}  
#End If
```

  
  
com.ab.template is my B4J projects package name (Project > Build Configurations)  
  
And this all works - courtesy of a 2 day conversation with Copilot and a mid term correction by Erel - see:  
<https://www.b4x.com/android/forum/threads/error-using-if-java-in-non-ui-b4j-app-help-desperately-sought.167174/post-1024877>
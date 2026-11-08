ECHO

Rem YOU MUST RUN THIS AS ADMINSITRATOR!!!! (Right Cick-Run As Administrator
REM (Ctl-C to exit)
PAUSE
::Create the service
::Change to ourInstall Directory
CD C:\ProgramData\jRDC2\jRDC2
::Need Full Path to Java
nssm install jRDC2  C:\ProgramData\jRDC2\jRDC2\bin\javaw.exe
PAUSE
::Application - SET NEXT TWO LINES
nssm set jRDC2 Application C:\ProgramData\jRDC2\jRDC2\bin\javaw.exe
nssm set jRDC2 AppDirectory C:\ProgramData\jRDC2\jRDC2
nssm set jRDC2 AppParameters -jar jRDC2.jar
::Details
nssm set jRDC2 DisplayName jRDC2
nssm set jRDC2 Description Provides Database support for ShopKeeper wireless applications.
nssm set jRDC2 Start SERVICE_DELAYED_AUTO_START
::Log On
nssm set jRDC2 ObjectName LocalSystem
nssm set jRDC2 Type SERVICE_WIN32_OWN_PROCESS
::Dependencies - MODIFY THIS TO YOUR SQLSERVER SERVICE NAME
nssm set jRDC2 DependOnService MSSQL$ASUS14SQLSERVER
::Process
nssm set jRDC2 AppPriority NORMAL_PRIORITY_CLASS
nssm set jRDC2 AppNoConsole 0
nssm set jRDC2 AppAffinity All
::Shutdown
nssm set jRDC2 AppStopMethodSkip 0
nssm set jRDC2 AppStopMethodConsole 1500
nssm set jRDC2 AppStopMethodWindow 1500
nssm set jRDC2 AppStopMethodThreads 1500
::Exit action
nssm set jRDC2 AppThrottle 1500
nssm set jRDC2 AppExit Default Restart
nssm set jRDC2 AppRestartDelay 3000
::I/O - LEAVE BLANK
::nssm set jRDC2 AppStdout C:\games\ut2003\service.log
::nssm set jRDC2 AppStderr C:\games\ut2003\service.log
::File Rotation
::nssm set jRDC2 AppStdoutCreationDisposition 4
::nssm set jRDC2 AppStderrCreationDisposition 4
::nssm set jRDC2 AppRotateFiles 1
::nssm set jRDC2 AppRotateOnline 0
::nssm set jRDC2 AppRotateSeconds 86400
::nssm set jRDC2 AppRotateBytes 1048576
::Environment
::nssm set jRDC2 AppEnvironmentExtra JAVA_HOME=C:\java
PAUSE

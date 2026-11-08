B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private XUI As XUI

	Private Win As Win32
End Sub

Public Sub Initialize
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	TestWin32
End Sub

'AUTOMATIC TEST HARNESS FOR WIN32 LIBRARY
Private Sub TestWin32
	Log("===== WIN32 LIBRARY TEST START =====")

	'WINDOW MANAGEMENT
	Log("Active Window Title: " & Win.GetActiveWindowTitle)
	Log("Active Window Handle: " & Win.GetActiveWindowHandle)
	Log("Active Window Class: " & Win.GetActiveWindowClass)

	Dim titles() As String = Win.EnumWindowsTitles
	Log("Window Count: " & titles.Length)
	For Each t As String In titles
		Log("Window: " & t)
	Next

	'SCREEN / MONITORS / TASKBAR
	Log("Screen Width: " & Win.GetScreenWidth)
	Log("Screen Height: " & Win.GetScreenHeight)

	Dim desk() As Int = Win.GetDesktopRect
	Log($"Desktop Rect: ${desk(0)}, ${desk(1)}, ${desk(2)}, ${desk(3)}"$)

	Dim tb() As Int = Win.GetTaskbarRect
	Log($"Taskbar Rect: ${tb(0)}, ${tb(1)}, ${tb(2)}, ${tb(3)}"$)

	Log("Monitor Count: " & Win.GetMonitorCount)

	Dim mons() As Int = Win.GetMonitorRects
	Log($"Monitor: ${mons(0)}, ${mons(1)}, ${mons(2)}, ${mons(3)}"$)

	'CLIPBOARD
	Log("Clipboard Text: " & Win.GetClipboardText)

	'REGISTRY (READ-ONLY TESTS)
	Log("HKCU\Software Exists: " & Win.RegKeyExists("Software"))

	'INPUT (SAFE TESTS)
	Log("Sending test key (ENTER)")
	Win.SendKey(13)

	Log("Sending mouse move")
	Win.MouseMove(256, 256)

	Log("Sending mouse wheel")
	Win.MouseWheel(256)

	'PROCESS INFORMATION
	Log("Current PID: " & Win.GetCurrentPID)
	Log("System Uptime: " & Win.GetSystemUptime)

	Dim plist() As String = Win.GetProcessList
	Log("Process Count: " & plist.Length)
	For Each p As String In plist
		Log("Process: " & p)
	Next

	'SYSTEM INFORMATION (NEW EXTENSIONS)
	Log("CPU Count: " & Win.GetProcessorCount)
	Log("Total RAM MB: " & Win.GetTotalPhysicalMemoryMB)
	Log("Available RAM MB: " & Win.GetAvailablePhysicalMemoryMB)
	Log("Windows Directory: " & Win.GetWindowsDirectory)
	Log("System Directory: " & Win.GetSystemDirectory)

	Log("System CPU Usage (%): " & Win.GetSystemCPUUsage)
	Log("System Boot Time: " & Win.GetSystemBootTime)

	'TEST MEMORY USAGE OF CURRENT PROCESS
	Dim mypid As Int = Win.GetCurrentPID
	Log("Memory Usage of PID " & mypid & ": " & Win.GetProcessMemoryMB(mypid) & " MB")

	'TEST DISK SPACE
	Dim diskInfo As String = Win.GetDiskSpace("C:\")
	Log("Disk Space (free,total,usable MB): " & diskInfo)

	'FILE SYSTEM
	Log("Desktop Folder: " & Win.GetDesktopFolder)
	Log("Documents Folder: " & Win.GetDocumentsFolder)
	Log("AppData Folder: " & Win.GetAppDataFolder)

	'ENVIRONMENT
	Log("ENV PATH: " & Win.GetEnv("PATH"))

	'SHELL
	Log("ShellOpen test (not executed for safety)")

	'NETWORK
	Dim nets() As String = Win.GetNetworkInterfaces
	Log("Network Interfaces: " & nets.Length)
	For Each n As String In nets
		Log("Interface: " & n)
	Next

	If nets.Length > 0 Then
		Dim first As String = Regex.Split(";", nets(0))(0)
		Log("Testing addresses for: " & first)
		Dim addrs() As String = Win.GetInterfaceAddresses(first)
		For Each a As String In addrs
			Log("Address: " & a)
		Next
		Log("Interface Up: " & Win.IsInterfaceUp(first))
	End If

	Log("My IP: " & Win.GetIPAddress)

	Dim ips() As String = Win.GetIPAddresses
	For Each ip As String In ips
		Log("IP: " & ip)
	Next

	Log("MAC Address: " & Win.GetMACAddress)
	Log("Default Gateway: " & Win.GetDefaultGateway)

	'SERVICES (READ-ONLY TESTS)
	Log("Checking if 'Spooler' service exists: " & Win.ServiceExists("Spooler"))
	Log("Spooler Status: " & Win.ServiceGetStatus("Spooler"))

	'PROCESS / COMMAND EXECUTION
	Log("Testing RunCommand($notepad$)")
	Win.RunCommand("notepad")

	Log("Testing RunCommand($calculator$)")
	Win.RunCommand("calc")

	Log("Testing RunHidden(""ping 127.0.0.1 -n 1"")")
	Win.RunHidden("ping 127.0.0.1 -n 1")

	Log("Testing RunWait(""ping 127.0.0.1 -n 1"")")
	Dim exitCode As Int = Win.RunWait("ping 127.0.0.1 -n 1")
	Log("RunWait Exit Code: " & exitCode)

	Log("Testing RunWaitGetOutput(""ping 127.0.0.1 -n 1"")")
	Dim result As String = Win.RunWaitGetOutput("ping 127.0.0.1 -n 1")
	Log(result)

	Log("Testing RunWaitGetOutputFull(""ping 127.0.0.1 -n 1"")")
	Dim result2 As String = Win.RunWaitGetOutputFull("ping 127.0.0.1 -n 1")
	Log(result2)

	Log("Testing RunGetOutput(""ipconfig"")")
	Dim output As String = Win.RunGetOutput("ipconfig")
	Log("RunGetOutput Result (first 200 chars): " & output.SubString2(0, Min(200, output.Length)))

	Log("Testing RunAsAdmin(""notepad"") — will trigger UAC prompt")
	Win.RunAsAdmin("notepad")

	Log("===== WIN32 LIBRARY TEST COMPLETE =====")
End Sub

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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private Caller As JarCaller
	Private txtLogs As B4XView
	Private OpenDialog As FileChooser
	Private TextField1 As B4XView
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	B4XPages.SetTitle(Me, "JarCaller Example")
	Root.LoadLayout("MainPage")
	Caller.Initialize
	OpenDialog.Initialize
	OpenDialog.setExtensionFilter("JAR", Array As String("*.jar", "*.jar"))
End Sub

Private Sub Button1_Click
	Dim jar As String = OpenDialog.ShowOpen(B4XPages.GetNativeParent(Me))
	If jar = "" Then Return
	TextField1.Text = Caller.GetJarKillName(jar)
	Wait For (Caller.RunJar(jar, Null)) Complete (Result As ShellSyncResult)
	MyLog(Result.StdErr)
	MyLog(Result.StdOut)
	MyLog("Exit code: " & Result.ExitCode)
End Sub

Private Sub Button2_Click
	Wait For (Caller.KillJavaProcess(TextField1.Text)) Complete (Counter As Int)
	MyLog("Killed " & Counter & " process(es)")
End Sub

Private Sub MyLog(s As String)
	Log(s)
	txtLogs.Text = txtLogs.Text & CRLF & s
	txtLogs.SelectionStart = txtLogs.Text.Length
End Sub
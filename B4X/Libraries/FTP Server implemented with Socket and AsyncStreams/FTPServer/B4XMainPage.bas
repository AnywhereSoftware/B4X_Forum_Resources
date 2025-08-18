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
	Private xui As XUI
	Private server As FTPServer
	Private Label1 As B4XView
	Private Label2 As B4XView
End Sub


Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	server.Initialize(Me, "FTPServer")
	Label2.Text = $"My ip: ${server.ssocket.GetMyWifiIP}"$
	server.SetPorts(51041, 51042, 51142)
	server.AddUser("Test", "test")
	'server.AddUser("anonymous", "") 'anonymous access
	'server.ForcedServerIp = "127.0.0.1" 'local access
	server.BaseDir = IIf(xui.IsB4J, "c:\temp", xui.DefaultFolder)
	server.Start
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Sub FTPServer_StateChanged
	Label1.Text = $"Number of clients: ${server.NumberOfClients}"$
	Log(Label1.Text)
End Sub
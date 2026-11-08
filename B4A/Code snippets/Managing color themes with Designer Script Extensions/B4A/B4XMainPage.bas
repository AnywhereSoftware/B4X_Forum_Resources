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
	
	'declare other B4X-Pages here
	Public pgSecond As frmSecond
	Private SwiftButton1 As SwiftButton
	Private Label2 As B4XView
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	
	'only, if runtime changes are needed (Public MyDD As MyDDD in Main Process_Globals)
	Main.MyDD.Initialize 
	
	Root = Root1
	Root.LoadLayout("MainPage") 'all colors are already as defined in MyDDD class
	
	'also change colors at runtime
	Label2.TextColor = Main.MyDD.GetColor(0)
	SwiftButton1.SetColors(Main.MyDD.GetColor(4), Main.MyDD.GetColor(5))
	
	pgSecond.Initialize
	B4XPages.AddPage("pgSecond", pgSecond)
	
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub Button1_Click
	'xui.MsgboxAsync("Hello world!", "B4X")
	B4XPages.ShowPage("pgSecond")
End Sub
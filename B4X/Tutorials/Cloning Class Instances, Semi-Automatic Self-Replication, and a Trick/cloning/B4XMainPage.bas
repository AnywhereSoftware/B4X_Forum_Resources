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
End Sub

Public Sub Initialize
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	demonstrate
End Sub

Private Sub demonstrate
	Dim InstanceA As classA
	InstanceA.Initialize("Alpha", "Beta")
	InstanceA.Age = 45
	InstanceA.Height = 181
	InstanceA.MakeBox
	
	Dim InstanceB As classA = InstanceA.Clone		
	'If the class is a B4XPage then you need to register it with B4XPages.AddPage now.
	InstanceB.Age = 75
	InstanceB.AddChild("William")
	InstanceB.AddChild("Suzanna")
	
	Log(InstanceA.Names(0) & TAB & InstanceA.Names(1) & TAB & InstanceA.Age & TAB & InstanceA.Height & TAB & InstanceA.Children.Size)
	Log(InstanceB.Names(0) & TAB & InstanceB.Names(1) & TAB & InstanceB.Age & TAB & InstanceA.Height & TAB & InstanceB.Children.Size)
	Log(InstanceB.Box.Width)
	
'	Alpha	Beta	45	181	0
'	Alpha	Beta	75	181	2
'	300
End Sub
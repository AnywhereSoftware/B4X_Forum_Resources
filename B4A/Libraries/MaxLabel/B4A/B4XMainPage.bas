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

	Private MaxLabel1 As MaxLabel
	Private MaxLabel6 As MaxLabel
	Private MaxLabel8 As MaxLabel

End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	Dim cs As CSBuilder
	MaxLabel1.Text = cs.Initialize.Color(Colors.White).Append("Max ").Pop.BackgroundColor(Colors.Yellow).Color(Colors.Black).Append("Width").PopAll
	
	MaxLabel6.Base.Color = Colors.DarkGray
	MaxLabel6.Base.TextColor = Colors.White

	MaxLabel8.SingleLine = True
	MaxLabel8.Text = $"line one 
line two 	
line three 
SingleLine=ON"$

End Sub



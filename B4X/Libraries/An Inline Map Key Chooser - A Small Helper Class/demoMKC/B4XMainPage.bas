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
	Private MKC As MapKeyChooser
End Sub

Public Sub Initialize
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	MKC.Initialize(Root)
End Sub

Private Sub Button1_Click
	'Private MKC As MapKeyChooser in Globals
	Dim anyMap As Map = CreateMap()
	For i = 1 To 10
		anyMap.Put("Key" & i, "ABCDEFGHIJKLMNOP".CharAT(i -1))
	Next
	MKC.ChooseKey(anyMap, "anyMap")
	
	'After choice, find on Log: anyMap.Get("Key5")
End Sub
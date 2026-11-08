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

#Macro: Title, Export B4XPages, ide://run?File=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip

Sub Class_Globals
	Private Root As B4XView	'ignore
	Private xui As XUI
	Private convert As WiLConverter
	Private projectDir, inLayoutsDir, txtLayoutsDir, outLayoutsDir As String 'ignore
End Sub

Public Sub Initialize
	projectDir = File.GetFileParent(File.DirApp)
	'create these directories if and only if they do not yet exist
	File.makeDir(projectDir, "Layouts\inLayouts")		
	File.makeDir(projectDir, "Layouts\txtLayouts")
	File.makeDir(projectDir, "Layouts\outLayouts")
	
	inLayoutsDir = projectDir & "\Layouts\inLayouts"
	txtLayoutsDir = projectDir & "\Layouts\txtLayouts"
	outLayoutsDir = projectDir & "\Layouts\outLayouts"
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("complex")
	
	convert.Initialize(True)	'True will copy the input and output json files to the input and output folders respectively
	convert.toTextFile(inLayoutsDir, "complex.bjl", txtLayoutsDir)
	convert.toLayoutFile(txtLayoutsDir, "complex_bjl.txt", outLayoutsDir, "complex_bjl.bjl")
End Sub

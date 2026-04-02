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
	Private wLOA As wLOAExtras
End Sub

Public Sub Initialize
	wLOA.Initialize(Me)
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root
	RndSeed(42)
	'Create a 5 x 3 table of random number with default column names
	Dim LOA4 As ListOfArrays = wLOA.randomDouble(5, 3, 5)
	wLOA.evalReplace(LOA4, Array(), "xx(5) + 360 * ?")
	wLOA.display(LOA4, 0, 3)

'	'Create a new LOA with corresponding sine of degrees
	Dim LOA4b As ListOfArrays = wLOA.evalCreate(LOA4, "", "sin(?)")
	wLOA.display(LOA4b, 0, 5)
	
End Sub

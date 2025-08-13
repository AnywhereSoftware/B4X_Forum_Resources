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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=GoogleCodeScanner.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private Scanner As GoogleCodeScanner
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	Scanner.Initialize
End Sub

Private Sub Button1_Click
	Dim formats As List = Array(Scanner.FORMAT_ALL_FORMATS) 'For better performance pass the specific formats needed.
	Wait For (Scanner.Scan(formats)) Complete (Result As ScannerResult)
	If Result.Success Then
		Log(Result.Value)
	End If
End Sub
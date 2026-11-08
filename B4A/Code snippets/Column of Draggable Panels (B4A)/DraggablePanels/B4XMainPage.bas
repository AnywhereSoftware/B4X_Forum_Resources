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
	Private btnEditItems As Button
	
	'Declare the page
	Private pgEditItems As EditItems_Page	'Object of Module Class B4XPage created
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("lyMainPage")
	
	'Initialize the page
	pgEditItems.Initialize
	
	'Add tho B4XPages stack
	B4XPages.AddPage("idEditItems", pgEditItems)
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.


Private Sub btnEditItems_Click
	B4XPages.ShowPage("idEditItems")
End Sub
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
	
	Private Gallery As pgGallery
	
	' Image data variables
	Public lstFilenames As List
	Public ImagesFolder As String
	
	' View of the main layout
	Private btnOpen As B4XView
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("lyB4XMainPage")
	
	' Safely initialize the lists and folders exactly once
	lstFilenames.Initialize
	ImagesFolder = File.DirInternal
	
	' We copy the images immediately And silently
	LoadAndCopyImages
	
	' We register the second page (The Gallery) in the manager
	Gallery.Initialize
	B4XPages.AddPage("pgGallery", Gallery)
End Sub

Private Sub LoadAndCopyImages
	lstFilenames.Clear
	For Each name As String In File.ListFiles(File.DirAssets)
		Dim nameLower As String = name.ToLowerCase
		If nameLower.EndsWith(".jpg") Or nameLower.EndsWith(".jpeg") Or nameLower.EndsWith(".png") Then
			lstFilenames.Add(name)
			
			If Not(File.Exists(ImagesFolder, name)) Then
				File.Copy(File.DirAssets, name, ImagesFolder, name)
			End If
		End If
	Next
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.


' By pressing the button, we open the gallery using B4XPages
Sub btnOpen_Click
	B4XPages.ShowPage("pgGallery")
End Sub
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
	
	Private UM_searchView1 As UM_searchView
	Private UM_searchView2 As UM_searchView
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")

	
End Sub

Private Sub UM_searchView2_EnterPressed
	#if B4i
	If UM_searchView2.isActive = False Then
		UM_searchView2.Activate(True)
	End If
	
	If UM_searchView1.isActive Then UM_searchView1.Activate(False)
	#End If
End Sub

Private Sub UM_searchView1_EnterPressed
	#if B4i
	If UM_searchView1.isActive = False Then
		UM_searchView1.Activate(True)
	End If
	
	If UM_searchView2.isActive Then UM_searchView2.Activate(False)
	#End If
End Sub

Private Sub UM_searchView2_TextChanged (Old As String, New As String)
	Log(New)
End Sub

Private Sub UM_searchView2_ClickedIcon
	
End Sub

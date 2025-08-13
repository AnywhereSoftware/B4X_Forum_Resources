B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
'#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=B4XGoogleTranslate.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI

'	Private Translate As clsGoogleTranslate
	Private B4XFloatTextField1 As B4XFloatTextField
	Private B4XFloatTextField2 As B4XFloatTextField
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(Me, "B4XGoogleTranslate")
End Sub

Public Sub B4XPage_Resize (Width As Int, Height As Int)
'	Log(Width & " - " & Height)
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub Button1_Click
	Dim Translate As clsGoogleTranslate
	Translate.Initialize
	'Local to engles
	Wait For (Translate.Target("en").Text(B4XFloatTextField1.Text)) Complete (Result As String)
	'Engles to italian
	Wait For (Translate.Source("en").Target("it").Text(B4XFloatTextField1.Text)) Complete (Result As String)
	B4XFloatTextField2.Text = Result
End Sub

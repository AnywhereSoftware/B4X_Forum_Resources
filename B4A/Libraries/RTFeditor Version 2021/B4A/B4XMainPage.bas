B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
'###############################################
' Demo Project, B4xPage: MainPage
'-----------------------------------------------
' Name:			B4XMainPage
' Version:		3
' State:		()WIP (X)Release
' Depend Libs:	B4XPages, Core, XUI, RTFEditor
' Depend Mod.:	-
' Depend Class:	-
' Layout:		MainPage
' Files:		-
' Database:		-
' Other:		-
'-----------------------------------------------
' (C) TECHDOC G. Becker
'###############################################

#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	' Object from Designer Layout "MainPage"
	Private RTFeditor1 As RTFeditor
End Sub

Public Sub Initialize
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	B4XPages.GetManager.LogEvents=True
	
	SetCustomProperties
	
End Sub

' event every time editor html is changed
' use it to get current HTML string of the editor
private Sub RTFeditor1_HTMLchanged(New As String)
	' log current HTML string
	Log(New)
End Sub

' Example to get custom properties value
private Sub GetCustomProperties
	Dim str As String = RTFeditor1.CurrentEditorHTML
	Log(str)
End Sub

' Example to set custom poperties
private Sub SetCustomProperties
	' ## Public MAP LocalStrings
	' set localized strings, standard strings are in English
	' German
	RTFeditor1.LocalStrings.Put("TitelColorDlg","Farbe wählen:")
	RTFeditor1.LocalStrings.Put("TitelImageDlg","Bild wählen:")
	RTFeditor1.LocalStrings.Put("ButtonCancel","Abbruch")
	RTFeditor1.LocalStrings.Put("ErrorHeight","Editor höhe zu klein!")
	RTFeditor1.LocalStrings.put("InfoMsg","Schaltfläche nicht aktiv.")
	
	' ## Property EditorHTML
	' set html string to RTFeditor
	' use it to send HTML string to editor
	Dim str As String
	for x = 0 to 50: str = str & x & "ABC<br>":next
	RTFeditor1.EditorHTML = str
	
	Log(RTFeditor1.CurrentEditorRawText)
End Sub

'###############################################
'`(C) TECDOC G. Becker
'###############################################

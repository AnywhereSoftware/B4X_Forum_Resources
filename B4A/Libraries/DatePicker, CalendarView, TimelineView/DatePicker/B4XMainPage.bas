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
	Dim picker As DatePicker
	Private Panel1 As Panel
	Private Button1 As Button
	Private Button2 As Button
	Private EditText1 As EditText
	Private EditText2 As EditText
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	
	Root.LoadLayout("layout_app")
	
	picker.Initialize(Me, "picker", Root)
	
End Sub

Private Sub Button1_Click
	Dim dt As String = "2/1/2026"
	picker.Show(DateTime.DateParse(dt))
	
End Sub

Sub picker_DateChanged (NewDate As Long)
	Log($"New date $Date{NewDate}"$)
	EditText1.Text = DateTime.Date(NewDate)
End Sub

Private Sub Button2_Click
	Dim dt As String = "2/1/2026"
	picker.SetColor1(Colors.ARGB(255,240,121,84))
	picker.SetColor2(Colors.ARGB(255,252,221,214))
	picker.Show(DateTime.DateParse(dt))
End Sub
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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Sample1.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	
	Private Label1 As Label
	Private Label2 As Label
	Private Label3 As Label
	Private Label4 As Label
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
End Sub

Sub B4XRangeSeekBar1_ChangeValue (MinValue As Float, MaxValue As Float)
	Label1.Text=$"Min: $1.0{MinValue}"$
	Label2.Text=$"Max: $1.0{MaxValue}"$
End Sub

Sub B4XRangeSeekBar2_ChangeValue (MinValue As Float, MaxValue As Float)
	Label3.Text=$"Min: $1.0{MinValue}"$
	Label4.Text=$"Max: $1.0{MaxValue}"$
End Sub
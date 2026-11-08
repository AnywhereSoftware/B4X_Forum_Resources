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
	Private fp As AS_FloatingPanel
	Private xlbl_ClickMe As B4XView
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")

End Sub

#If B4J
Private Sub xlbl_ClickMe_MouseClicked (EventData As MouseEvent)
#Else
Private Sub xlbl_ClickMe_Click
#End If

	OpenPanel
	
End Sub

Private Sub OpenPanel
	
	fp.Initialize(Me,"fp",Root)
	fp.PreSize(200dip,200dip)
	fp.Panel.LoadLayout("frm_Content")
	fp.OpenOrientation = fp.OpenOrientation_RightBottom

	fp.ArrowVisible = True
	fp.ArrowProperties.Left = xlbl_ClickMe.Width/2
	fp.ArrowProperties.ArrowOrientation = fp.ArrowOrientation_Top
	fp.CloseOnTap = True

	'Under the Button
	Dim Top As Float = xlbl_ClickMe.Top + xlbl_ClickMe.Height + 10dip
	fp.Show(xlbl_ClickMe.Left,Top ,200dip,200dip)
	
	'Top of the Button
'	Dim Top As Float = xlbl_ClickMe.Top - 200dip - 10dip
'	fp.Show(xlbl_ClickMe.Left,Top ,200dip,200dip)
	
End Sub
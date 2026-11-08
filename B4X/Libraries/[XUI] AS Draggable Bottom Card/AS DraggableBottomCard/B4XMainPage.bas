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
	
	Private asdbc_main As ASDraggableBottomCard
	Private xlbl_body As B4XView
	
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	#If B4I
	Wait For B4XPage_Resize (Width As Int, Height As Int)
	#End If
	
	asdbc_main.Initialize(Me,"asdbc_main")
	asdbc_main.Create(Root,Root.Height/2,Root.Height - 60dip,50dip,Root.Width - 20dip,asdbc_main.Orientation_MIDDLE)
	
	asdbc_main.HeaderPanel.LoadLayout("frm_header")

	asdbc_main.BodyPanel.LoadLayout("frm_body")
	
	
	asdbc_main.CornerRadius_Header = asdbc_main.HeaderPanel.Height/2

End Sub

#IF B4J
Private Sub xlbl_show_MouseClicked (EventData As MouseEvent)
	asdbc_main.Show(False)
End Sub

Private Sub xlbl_hide_MouseClicked (EventData As MouseEvent)
	asdbc_main.Hide(False)
End Sub
#Else
Private Sub xlbl_show_Click
	asdbc_main.Show(False)
End Sub

Private Sub xlbl_hide_Click
	asdbc_main.Hide(False)
End Sub
#End If


Private Sub asdbc_main_VisibleBodyHeightChanged (height As Double)
	xlbl_body.Height = height
End Sub
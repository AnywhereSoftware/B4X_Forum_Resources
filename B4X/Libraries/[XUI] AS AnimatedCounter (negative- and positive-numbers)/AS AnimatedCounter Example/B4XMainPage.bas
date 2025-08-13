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
	Private AS_AnimatedCounter1 As AS_AnimatedCounter
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	B4XPages.SetTitle(Me,"AS_AnimatedCounter Example")
	
	Sleep(4000)
	AS_AnimatedCounter1.TextColor = xui.Color_Red
	AS_AnimatedCounter1.Font = xui.CreateDefaultBoldFont(30)
	AS_AnimatedCounter1.Refresh
	
End Sub

#If B4J
Private Sub lbl_add_MouseClicked (EventData As MouseEvent)
#Else
Sub lbl_add_Click
#End If
	AS_AnimatedCounter1.AddOne
End Sub

#If B4J
Private Sub lbl_remove_MouseClicked (EventData As MouseEvent)
#Else
Sub lbl_remove_Click
#End If
	AS_AnimatedCounter1.RemoveOne
End Sub

#If B4J
Private Sub lbl_add_55_MouseClicked (EventData As MouseEvent)
#Else
Sub lbl_add_55_Click
#End If
	AS_AnimatedCounter1.CountAnimatedTo(150,AS_AnimatedCounter1.Value + 55)
End Sub

#If B4J
Private Sub lbl_remove_55_MouseClicked (EventData As MouseEvent)
#Else
Sub lbl_remove_55_Click
#End If
	AS_AnimatedCounter1.CountAnimatedTo(150,AS_AnimatedCounter1.Value - 55)
End Sub

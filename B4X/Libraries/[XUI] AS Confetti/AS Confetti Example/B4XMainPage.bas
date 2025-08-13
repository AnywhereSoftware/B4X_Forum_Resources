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
	Private AS_Confetti1 As AS_Confetti
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	B4XPages.SetTitle(Me,"AS Confetti Example")
	
End Sub

#If B4J
Private Sub xlbl_DropConfetti_MouseClicked (EventData As MouseEvent)
#Else
Private Sub xlbl_DropConfetti_Click
#End If
	
	AS_Confetti1.DropConfetti
	
End Sub

#If B4J
Private Sub xlbl_ConfettiExplosion_MouseClicked (EventData As MouseEvent)
#Else
Private Sub xlbl_ConfettiExplosion_Click
#End If
	
	AS_Confetti1.ConfettiExplosion(Root.Width/2,Root.Height/2)
	
End Sub

#If B4J
Private Sub xlbl_SideBurst_MouseClicked (EventData As MouseEvent)
#Else
Private Sub xlbl_SideBurst_Click
#End If
	
	AS_Confetti1.SideBurst(False)
	
End Sub

#If B4J
Private Sub xlbl_PulseBurst_MouseClicked (EventData As MouseEvent)
#Else
Private Sub xlbl_PulseBurst_Click
#End If
	
	AS_Confetti1.PulseBurst(Root.Width/2,Root.Height/2,5,250)
	
End Sub

'Is triggered when all particles are on the ground or the animation has been stopped
Private Sub AS_Confetti1_Finished
	Log("Finished")
End Sub

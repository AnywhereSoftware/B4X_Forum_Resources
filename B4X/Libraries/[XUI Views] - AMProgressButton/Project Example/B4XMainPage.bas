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
	Private AMProgressButton1 As AMProgressButton
	Private AMProgressButton2 As AMProgressButton
	Private AMProgressButton3 As AMProgressButton
	
	Dim c1 As Int = 0
	Dim c2 As Int = 0
	Dim c3 As Int = 0
	
	Dim timer1 As Timer
	Dim timer2 As Timer
	Dim timer3 As Timer
	
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	timer1.Initialize("timer1",500)
	timer2.Initialize("timer2",500)
	timer3.Initialize("timer3",500)
	
End Sub


Private Sub AMProgressButton1_Click
	timer1.Enabled = True
End Sub

Private Sub AMProgressButton2_Click
	timer2.Enabled = True
End Sub

Private Sub AMProgressButton3_Click
	timer3.Enabled = True
End Sub


Sub timer1_tick
	
	If c1 =100 Then
		timer1.Enabled = False
	Else
		timer1.Enabled = True
		c1 = c1 + Rnd(1,15)
		AMProgressButton1.SetProgress(c1)
	End If
	
End Sub

Sub timer2_tick
	
	If c2 =100 Then
		timer2.Enabled = False
	Else
		timer2.Enabled = True
		c2 = c2 + Rnd(1,15)
		AMProgressButton2.SetProgress(c2)
	End If
	
End Sub

Sub timer3_tick
	
	If c3 =100 Then
		timer3.Enabled = False
	Else
		timer3.Enabled = True
		c3 = c3 + Rnd(1,15)
		AMProgressButton3.SetProgress(c3)
	End If
	
End Sub



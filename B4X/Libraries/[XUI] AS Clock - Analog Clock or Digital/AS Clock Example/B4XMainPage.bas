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
	Private ASClock1 As ASClock
	Private Timer1 As Timer
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	B4XPages.SetTitle(Me,"AS Clock Example")
	
	Timer1.Initialize("Timer1",1000)
	
	#If b4I
	Wait For B4XPage_Resize (Width As Int, Height As Int)
	#End If
	
	'ASClock1.MiddleText = "23:00"
	
	'Sleep(2000)
	'ASClock1.DrawPointer(DateTime.GetHour(DateTime.Now),DateTime.GetMinute(DateTime.Now),DateTime.GetSecond(DateTime.Now))
	
	ASClock1.MiddleTextProperties.TextColor = xui.Color_ARGB(152,255,255,255)
	ASClock1.Draw
	Timer1_Tick
	
	Timer1.Enabled = True
	
End Sub

Private Sub Timer1_Tick
	ASClock1.MiddleText = NumberFormat(DateTime.GetHour(DateTime.Now),2,0) & ":" & NumberFormat(DateTime.GetMinute(DateTime.Now),2,0)
	ASClock1.SetTime(DateTime.GetHour(DateTime.Now),DateTime.GetMinute(DateTime.Now),DateTime.GetSecond(DateTime.Now))
	ASClock1.CornerWidth = 2dip
End Sub

Private Sub B4XPage_Resize (Width As Int, Height As Int)
	
End Sub

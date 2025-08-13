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
	Private AS_WheelDateTimePicker1 As AS_WheelDateTimePicker
	Private AS_WheelDateTimePicker2 As AS_WheelDateTimePicker
	Private AS_WheelDateTimePicker3 As AS_WheelDateTimePicker
	Private AS_WheelDateTimePicker4 As AS_WheelDateTimePicker
	Private xlbl_DateTime As B4XView
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	#If B4I
	Wait For B4XPage_Resize (Width As Int, Height As Int)
	#End If
	
	DateTime.TimeFormat = DateTime.DeviceDefaultTimeFormat
	DateTime.DateFormat = DateTime.DeviceDefaultDateFormat
	
	AS_WheelDateTimePicker1.Create
	AS_WheelDateTimePicker2.Create
	AS_WheelDateTimePicker3.Create
	AS_WheelDateTimePicker4.Create
	
End Sub

Private Sub AS_WheelDateTimePicker1_SelectedTimeChanged(Hour As Int,Minute As Int)
	Log("SelectedTimeChanged: Hour:" & Hour & " Minute:" & Minute)
	xlbl_DateTime.Text = Hour & ":" & Minute
End Sub

Private Sub AS_WheelDateTimePicker2_SelectedTimeChanged(Hour As Int,Minute As Int)
	Log("SelectedTimeChanged: Hour:" & Hour & " Minute:" & Minute)
	xlbl_DateTime.Text = Hour & ":" & Minute
End Sub

Private Sub AS_WheelDateTimePicker3_SelectedTimeChanged(Hour As Int,Minute As Int)
	Log("SelectedTimeChanged: Hour:" & Hour & " Minute:" & Minute)
	xlbl_DateTime.Text = Hour & ":" & Minute
End Sub

Private Sub AS_WheelDateTimePicker4_SelectedTimeChanged(Hour As Int,Minute As Int)
	Log("SelectedTimeChanged: Hour:" & Hour & " Minute:" & Minute)
	xlbl_DateTime.Text = Hour & ":" & Minute
End Sub

Private Sub AS_WheelDateTimePicker1_SelectedDateChanged(Date As Long)
	Log("SelectedTimeChanged: " & DateUtils.TicksToString(Date))
	xlbl_DateTime.Text = DateUtils.TicksToString(Date)
End Sub

Private Sub AS_WheelDateTimePicker2_SelectedDateChanged(Date As Long)
	Log("SelectedTimeChanged: " & DateUtils.TicksToString(Date))
	xlbl_DateTime.Text = DateUtils.TicksToString(Date)
End Sub

Private Sub AS_WheelDateTimePicker3_SelectedDateChanged(Date As Long)
	Log("SelectedTimeChanged: " & DateUtils.TicksToString(Date))
	xlbl_DateTime.Text = DateUtils.TicksToString(Date)
End Sub

Private Sub AS_WheelDateTimePicker4_SelectedDateChanged(Date As Long)
	Log("SelectedTimeChanged: " & DateUtils.TicksToString(Date))
	xlbl_DateTime.Text = DateUtils.TicksToString(Date)
End Sub
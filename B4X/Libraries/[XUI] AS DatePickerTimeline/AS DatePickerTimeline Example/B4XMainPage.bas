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
	Private AS_DatePickerTimeline1 As AS_DatePickerTimeline
	Private AS_DatePickerTimeline2 As AS_DatePickerTimeline
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	B4XPages.SetTitle(Me,"AS DatePickerTimeline")

End Sub


Private Sub AS_DatePickerTimeline1_SelectedDateChanged (Date As Long)
	Log("SelectedDateChanged: " & DateUtils.TicksToString(Date))
End Sub

Private Sub AS_DatePickerTimeline1_CustomDrawDay (Date As Long, Views As ASDatePickerTimeline_CustomDrawDay)
	CustomDrawDay(Date,Views)
End Sub

Private Sub AS_DatePickerTimeline2_CustomDrawDay (Date As Long, Views As ASDatePickerTimeline_CustomDrawDay)
	CustomDrawDay(Date,Views)
End Sub

Private Sub CustomDrawDay (Date As Long, Views As ASDatePickerTimeline_CustomDrawDay)
	
	If DateTime.GetDayOfWeek(Date) = 1 Then '1=Sunday
		Views.xlbl_Date.TextColor = xui.Color_ARGB(255,221, 95, 96)
	End If
	
End Sub

Private Sub AS_DatePickerTimeline1_PageChanged (FirstDay As Long, LastDay As Long)
	Log("FirstDay: " & DateUtils.TicksToString(FirstDay))
	Log("LastDay: " & DateUtils.TicksToString(LastDay))
End Sub

Private Sub AS_DatePickerTimeline2_PageChanged (FirstDay As Long, LastDay As Long)
	Log("FirstDay: " & DateUtils.TicksToString(FirstDay))
	Log("LastDay: " & DateUtils.TicksToString(LastDay))
End Sub


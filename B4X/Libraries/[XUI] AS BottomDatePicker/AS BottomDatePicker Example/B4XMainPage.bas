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
	
	Private BottomDatePicker As AS_BottomDatePicker
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	B4XPages.SetTitle(Me,"AS BottomDatePicker Example")
	
End Sub

Private Sub OpenDarkDatePicker
	
	BottomDatePicker.Initialize(Me,"BottomDatePicker",Root)
	
	BottomDatePicker.ConfirmationMode = BottomDatePicker.ConfirmationMode_Button
	BottomDatePicker.ShowPicker
	
	BottomDatePicker.ConfirmationButton.Text = "Confirm Date"
	
	BottomDatePicker.Color = xui.Color_ARGB(255,32, 33, 37)
	BottomDatePicker.TextColor = xui.Color_White
	
End Sub

Private Sub OpenLightDatePicker
	
	BottomDatePicker.Initialize(Me,"BottomDatePicker",Root)
	
	BottomDatePicker.ConfirmationMode = BottomDatePicker.ConfirmationMode_Button
	BottomDatePicker.ShowPicker
	
	BottomDatePicker.ConfirmationButton.Text = "Confirm Date"
	
	BottomDatePicker.Color = xui.Color_White
	BottomDatePicker.TextColor = xui.Color_Black
	
	
End Sub

Private Sub OpenDatePickerRange
	
	BottomDatePicker.Initialize(Me,"BottomDatePicker",Root)
	
	BottomDatePicker.ConfirmationMode = BottomDatePicker.ConfirmationMode_SelectionChanged
	BottomDatePicker.SelectMode = BottomDatePicker.SelectMode_Range
	BottomDatePicker.ShowPicker
	
	BottomDatePicker.ConfirmationButton.Text = "Confirm Date"
	
	BottomDatePicker.Color = xui.Color_ARGB(255,32, 33, 37)
	BottomDatePicker.TextColor = xui.Color_White
	
End Sub

Private Sub OpenDatePickerRangeConfirmation
	
	BottomDatePicker.Initialize(Me,"BottomDatePicker",Root)
	
	BottomDatePicker.ConfirmationMode = BottomDatePicker.ConfirmationMode_Button
	BottomDatePicker.SelectMode = BottomDatePicker.SelectMode_Range
	
	BottomDatePicker.ShowPicker
	
	BottomDatePicker.ConfirmationButton.Text = "Confirm Date"
	
	BottomDatePicker.Color = xui.Color_ARGB(255,32, 33, 37)
	BottomDatePicker.TextColor = xui.Color_White
	
End Sub

Private Sub OpenDatePickerDay
	
	BottomDatePicker.Initialize(Me,"BottomDatePicker",Root)
	
	BottomDatePicker.ConfirmationMode = BottomDatePicker.ConfirmationMode_SelectionChanged
	BottomDatePicker.ShowPicker
	
	BottomDatePicker.Color = xui.Color_ARGB(255,32, 33, 37)
	BottomDatePicker.TextColor = xui.Color_White
	
End Sub

#Region BottomDatePickerEvents

Private Sub BottomDatePicker_ConfirmButtonClicked
	
	If BottomDatePicker.SelectMode = BottomDatePicker.SelectMode_Day Then
		Log("Confirmed Date: " & DateUtils.TicksToString(BottomDatePicker.SelectedDate))
	Else
		Log($"Confirmed Date Range: StartDate: ${DateUtils.TicksToString(BottomDatePicker.SelectedStartDate)} EndDate: ${DateUtils.TicksToString(BottomDatePicker.SelectedEndDate)}"$)
	End If
	
End Sub

Private Sub BottomDatePicker_SelectedDateChanged(Date As Long)
	Log("Date: " & DateUtils.TicksToString(BottomDatePicker.SelectedDate))
End Sub

Private Sub BottomDatePicker_SelectedDateRangeChanged(StartDate As Long, EndDate As Long)
	Log($"Date Range: StartDate: ${DateUtils.TicksToString(BottomDatePicker.SelectedStartDate)} EndDate: ${DateUtils.TicksToString(BottomDatePicker.SelectedEndDate)}"$)
End Sub

#End Region


#Region ButtonEvents

#If B4J
Private Sub xlbl_OpenDarkDatePicker_MouseClicked (EventData As MouseEvent)
	OpenDarkDatePicker
End Sub
#Else
Private Sub xlbl_OpenDarkDatePicker_Click
	OpenDarkDatePicker
End Sub
#End If

#If B4J
Private Sub xlbl_OpenLightDatePicker_MouseClicked (EventData As MouseEvent)
	OpenLightDatePicker
End Sub
#Else
Private Sub xlbl_OpenLightDatePicker_Click
	OpenLightDatePicker
End Sub
#End If

#If B4J
Private Sub xlbl_OpenDatePickerDay_MouseClicked (EventData As MouseEvent)
	OpenDatePickerDay
End Sub
#Else
Private Sub xlbl_OpenDatePickerDay_Click
	OpenDatePickerDay
End Sub
#End If

#If B4J
Private Sub xlbl_OpenDatePickerRange_MouseClicked (EventData As MouseEvent)
	OpenDatePickerRange
End Sub
#Else
Private Sub xlbl_OpenDatePickerRange_Click
	OpenDatePickerRange
End Sub
#End If

#If B4J
Private Sub xlbl_OpenDatePickerRangeConfirmation_MouseClicked (EventData As MouseEvent)
	OpenDatePickerRangeConfirmation
End Sub
#Else
Private Sub xlbl_OpenDatePickerRangeConfirmation_Click
	OpenDatePickerRangeConfirmation
End Sub
#End If

#End Region



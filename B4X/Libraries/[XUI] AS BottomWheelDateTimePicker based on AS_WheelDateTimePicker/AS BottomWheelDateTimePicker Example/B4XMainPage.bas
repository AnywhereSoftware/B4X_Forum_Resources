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
	
	Private BottomWheelDateTimePicker As AS_BottomWheelDateTimePicker
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	B4XPages.SetTitle(Me,"AS BottomWheelDateTimePicker Example")
	
End Sub

Private Sub OpenSheetTimePicker(DarkMode As Boolean)
	BottomWheelDateTimePicker.Initialize(Me,"BottomWheelDateTimePicker",Root)
	
	BottomWheelDateTimePicker.Theme = IIf(DarkMode,BottomWheelDateTimePicker.Theme_Dark,BottomWheelDateTimePicker.Theme_Light)
	BottomWheelDateTimePicker.ActionButtonVisible = True
	
	BottomWheelDateTimePicker.PickerType = BottomWheelDateTimePicker.PickerType_TimePicker
	BottomWheelDateTimePicker.TimePicker_TimeUnit = True 'Show TimePicker_HourShortText and TimePicker_MinuteShortText
	BottomWheelDateTimePicker.TimePicker_ShowAMPM = False
'	BottomWheelDateTimePicker.TimePicker_TimeDivider = True
'	BottomWheelDateTimePicker.TimePicker_ShowDate = True
'	BottomWheelDateTimePicker.TimePicker_HourShortText = "hour"
'	BottomWheelDateTimePicker.TimePicker_MinuteShortText = "min"
'	BottomWheelDateTimePicker.Hour = 13 'Only Works in Release mode
'	BottomWheelDateTimePicker.Minute = 46 'Only Works in Release mode
	BottomWheelDateTimePicker.ShowPicker
	
	BottomWheelDateTimePicker.ActionButton.Text = "Choose"
	
	Wait For BottomWheelDateTimePicker_ActionButtonClicked
	
	#If Debug
	Log($"Hour: ${BottomWheelDateTimePicker.Hour} Minute: ${BottomWheelDateTimePicker.Minute}"$)
	#Else
	xui.MsgboxAsync($"Hour: ${BottomWheelDateTimePicker.Hour} Minute: ${BottomWheelDateTimePicker.Minute}"$,"TimePicker")	
	#End If

	BottomWheelDateTimePicker.HidePicker
	
End Sub

Private Sub OpenSheetDatePicker(DarkMode As Boolean)
	BottomWheelDateTimePicker.Initialize(Me,"BottomWheelDateTimePicker",Root)
	
	BottomWheelDateTimePicker.Theme = IIf(DarkMode,BottomWheelDateTimePicker.Theme_Dark,BottomWheelDateTimePicker.Theme_Light)
	BottomWheelDateTimePicker.ActionButtonVisible = True
	
	BottomWheelDateTimePicker.PickerType = BottomWheelDateTimePicker.PickerType_DatePicker
'	BottomWheelDateTimePicker.DatePicker_MaxDate = DateTime.Now
'	BottomWheelDateTimePicker.Date = DateUtils.SetDate(2025,1,4)
	BottomWheelDateTimePicker.ShowPicker
	
	BottomWheelDateTimePicker.ActionButton.Text = "Choose"
	
	Wait For BottomWheelDateTimePicker_ActionButtonClicked
	
	#If Debug
	Log(DateUtils.TicksToString(BottomWheelDateTimePicker.Date))
	#Else
	xui.MsgboxAsync(DateUtils.TicksToString(BottomWheelDateTimePicker.Date),"DatePicker")	
	#End If

	BottomWheelDateTimePicker.HidePicker
End Sub

#Region BottomDatePickerEvents

Private Sub BottomWheelDateTimePicker_ActionButtonClicked
	Log("ActionButtonClicked")
End Sub

#End Region


#Region ButtonEvents

Private Sub xlbl_OpenDarkTimePicker_Click
	OpenSheetTimePicker(True)
End Sub

Private Sub xlbl_OpenLightTimePicker_Click
	OpenSheetTimePicker(False)
End Sub

Private Sub xlbl_OpenDarkDatePicker_Click
	OpenSheetDatePicker(True)
End Sub

Private Sub xlbl_OpenLightDatePicker_Click
	OpenSheetDatePicker(False)
End Sub

#End Region


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
	Private TimePickerDialog As AS_TimePickerDialog
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	B4XPages.SetTitle(Me,"AS TimePickerDialog Example")
	
End Sub

Private Sub ShowDialogDarkMode
	
	TimePickerDialog.Initialize(Root)
	
	TimePickerDialog.Theming.BackgroundColor = xui.Color_ARGB(255,19, 20, 22)
	TimePickerDialog.Theming.ClockTextColor = xui.Color_White
	TimePickerDialog.Theming.DialogButtonTextColor = xui.Color_ARGB(255,20,160,130)
	TimePickerDialog.Theming.EditTextColor = xui.Color_White
	TimePickerDialog.Theming.EditTextFocusColor = xui.Color_ARGB(255,20,160,130)
	TimePickerDialog.Theming.ThumbColor = xui.Color_ARGB(255,20,160,130)
	TimePickerDialog.Theming.TimePickerBackgroundColor = xui.Color_ARGB(255,32, 33, 37)
	
	TimePickerDialog.KeyboardEnabled = True
	TimePickerDialog.TimeFormat = TimePickerDialog.TimeFormat_24h
	
	Wait For (TimePickerDialog.ShowDialog) Complete (PickerDialogResponse As AS_TimePickerDialog_DialogResponse)
	If PickerDialogResponse.Result = xui.DialogResponse_Positive Then
		#If Debug
		Log("Hour: " & PickerDialogResponse.Hour & " Minute: " & PickerDialogResponse.Minute)
		#Else
		xui.MsgboxAsync("Hour: " & PickerDialogResponse.Hour & " Minute: " & PickerDialogResponse.Minute,"")
		#End If
	End If
	
End Sub


Private Sub ShowDialogLightMode
	
	TimePickerDialog.Initialize(Root)
	
	TimePickerDialog.Theming.BackgroundColor = xui.Color_White
	TimePickerDialog.Theming.ClockTextColor = xui.Color_Black
	TimePickerDialog.Theming.DialogButtonTextColor = xui.Color_ARGB(255,20,160,130)
	TimePickerDialog.Theming.EditTextColor = xui.Color_Black
	TimePickerDialog.Theming.EditTextFocusColor = xui.Color_ARGB(255,20,160,130)
	TimePickerDialog.Theming.ThumbColor = xui.Color_ARGB(255,20,160,130)
	TimePickerDialog.Theming.TimePickerBackgroundColor = xui.Color_ARGB(255,245,246,247)
	
	Wait For (TimePickerDialog.ShowDialog) Complete (PickerDialogResponse As AS_TimePickerDialog_DialogResponse)
	If PickerDialogResponse.Result = xui.DialogResponse_Positive Then
		#If Debug
		Log("Hour: " & PickerDialogResponse.Hour & " Minute: " & PickerDialogResponse.Minute)
		#Else
		xui.MsgboxAsync("Hour: " & PickerDialogResponse.Hour & " Minute: " & PickerDialogResponse.Minute,"")
		#End If
	End If
	
End Sub

#If B4J
Private Sub xlbl_ShowDialogDarkMode_MouseClicked (EventData As MouseEvent)
	ShowDialogDarkMode
End Sub

Private Sub xlbl_ShowDialogLightMode_MouseClicked (EventData As MouseEvent)
	ShowDialogLightMode
End Sub
#Else
Private Sub xlbl_ShowDialogDarkMode_Click
	ShowDialogDarkMode
End Sub

Private Sub xlbl_ShowDialogLightMode_Click
	ShowDialogLightMode
End Sub
#End If

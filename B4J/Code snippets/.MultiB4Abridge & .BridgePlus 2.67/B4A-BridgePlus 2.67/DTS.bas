B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13
@EndOfDesignText@
'Class module
'~1.7 seconds (the right time 0.71 seconds to display only one message!)
Private Sub Class_Globals
	Private Ti As Timer
	Private Timr As Timer
	Private I As Float
	Private TT As String
End Sub

'Initializes the Class
'ToastText = The text that will be displayed when the back button is clicked once
Public Sub Initialize (ToastText As String)
	I = 0
	Ti.Initialize ("Ti",1000)
	Ti.Enabled = True
	Timr.Initialize ("Timr",100)
	Timr.Enabled = True
	TT = ToastText
End Sub

Private Sub Ti_Tick
	If I > 0 Then
		I = I-0.49
	End If
End Sub

Private Sub Timr_Tick
	If I >= 2 Then
		If Service1.FTP.IsInitialized And Service1.FTP.Running = True Then
			CallSubDelayed(Service1, "Service_Destroy")
			Sleep(700)
			StopService(Service1)
			Sleep(700)
		End If
		ExitApplication
	End If
End Sub

'Add this to the Activity_Keypress method
Public Sub TapToClose
	If I < 0.71 Then ToastMessageShow(TT, False)
	I = I+1.3
End Sub

'Change message
Public Sub ToastChange(ToastText As String)
	TT = ToastText
End Sub

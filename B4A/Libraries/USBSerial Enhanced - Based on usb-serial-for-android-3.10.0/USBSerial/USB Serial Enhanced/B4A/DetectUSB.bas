B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Receiver
Version=13.4
@EndOfDesignText@
Sub Process_Globals
	
End Sub

'Called when an intent is received. 
'Do not assume that anything else, including the starter service, has run before this method.
Private Sub Receiver_Receive (FirstTime As Boolean, StartingIntent As Intent)
	If B4XPages.IsInitialized = False Then Return
	
	If StartingIntent.Action = "android.hardware.usb.action.USB_DEVICE_ATTACHED" Then
		Log("USB Attached via Intent...")
		'CallSubDelayed(B4XPages.MainPage, "UpdateDeviceList") 
		B4XPages.MainPage.UpdateDeviceList
	Else if	StartingIntent.Action = "android.hardware.usb.action.USB_DEVICE_DETACHED" Then
		Log("USB Detached via Intent...")
		'CallSubDelayed(B4XPages.MainPage, "UpdateDeviceList") 
		B4XPages.MainPage.UpdateDeviceList
	End If
End Sub

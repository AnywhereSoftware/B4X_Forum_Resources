B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Receiver
Version=12.2
@EndOfDesignText@
Sub Process_Globals
	
End Sub

'Called when an intent is received. 
'Do not assume that anything else, including the starter service, has run before this method.
Private Sub Receiver_Receive (FirstTime As Boolean, StartingIntent As Intent)
	ToastMessageShow("Insert USB device.",False)
	CallSub(Main,"Search")
	Dim B As Beeper
	
	B.Initialize(400,700)
	B.Beep
	Sleep(500)
	B.Release
	StartReceiverAt(Me, DateTime.Now + (1 * DateTime.TicksPerMinute), True)
End Sub


B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Receiver
Version=13
@EndOfDesignText@
Sub Process_Globals
End Sub

'Called when an intent is received. 
'Do not assume that anything else, including the starter service, has run before this method.
Private Sub Receiver_Receive (FirstTime As Boolean, StartingIntent As Intent)
	Log(StartingIntent)
	
	If StartingIntent.Action = "ACTION_BAR_SCAN" Then
		Log($"Barcode: ${StartingIntent.GetExtra("EXTRA_SCAN_DATA")}"$)
		B4XPages.MainPage.LblBarcode.Text = StartingIntent.GetExtra("EXTRA_SCAN_DATA")
	End If
End Sub

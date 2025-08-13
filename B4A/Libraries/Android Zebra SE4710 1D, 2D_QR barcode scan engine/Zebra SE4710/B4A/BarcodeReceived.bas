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
	If StartingIntent.Action = "scan.rcv.message" Then
		Dim Barcode As String = BytesToString(StartingIntent.GetExtra("barocode"), 0, StartingIntent.GetExtra("length"), "UTF8")
		Log($"Barcode: ${Barcode}"$)
	End If
End Sub


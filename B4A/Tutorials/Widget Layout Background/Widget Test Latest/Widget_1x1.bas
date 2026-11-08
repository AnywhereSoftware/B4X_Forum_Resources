B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Receiver
Version=12.8
@EndOfDesignText@
Sub Process_Globals
	Dim rv As RemoteViews
	Dim degree As Float = 0
End Sub

'Called when an intent is received. 
'Do not assume that anything else, including the starter service, has run before this method.
Private Sub Receiver_Receive (FirstTime As Boolean, StartingIntent As Intent)
	If FirstTime Then
		rv = ConfigureHomeWidget("1x1", "rv", 30, "My Own Image", True)
	End If
	rv.HandleWidgetEvents(StartingIntent)
	Scrivi
End Sub

Sub Scrivi
	rv.SetImage("ImageView1", LoadBitmap(File.DirAssets, "poker-chips.png").Rotate(degree))
	Sleep(100)
	rv.UpdateWidget
End Sub

Sub ImageView1_Click
	degree = degree + 90
	Scrivi
End Sub
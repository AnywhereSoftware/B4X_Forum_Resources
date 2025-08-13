B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Receiver
Version=12.15
@EndOfDesignText@
Sub Process_Globals
	Private rv As RemoteViews
	Private imageFiles() As String = Array As String("player_button_next.png", "player_button_pause.png", _
		"player_button_play.png", "player_button_stop.png")
	Private currentImage As Int
End Sub

'Called when an intent is received. 
'Do not assume that anything else, including the starter service, has run before this method.
Private Sub Receiver_Receive (FirstTime As Boolean, StartingIntent As Intent)
	If FirstTime Then
		rv = ConfigureHomeWidget("L1", "rv", 60, "Hello Widget")
	End If
	rv.HandleWidgetEvents(StartingIntent)
End Sub

Private Sub rv_RequestUpdate
	SetTime
	rv.UpdateWidget
End Sub

Private Sub SetTime
	rv.SetText("Label1", DateTime.Time(DateTime.Now))
End Sub

Private Sub ImageView1_Click
	currentImage = (currentImage + 1) Mod imageFiles.Length
	rv.SetImage("ImageView1", LoadBitmap(File.DirAssets, imageFiles(currentImage)))
	rv.SetProgress("ProgressBar1", 100 * (currentImage + 1) / imageFiles.Length)
	SetTime
	rv.UpdateWidget
End Sub

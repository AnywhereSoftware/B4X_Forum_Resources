B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Receiver
Version=12.8
@EndOfDesignText@
Sub Process_Globals
	Private rv As RemoteViews
End Sub

'Called when an intent is received. 
'Do not assume that anything else, including the starter service, has run before this method.
Private Sub Receiver_Receive (FirstTime As Boolean, StartingIntent As Intent)
	If FirstTime Then
		rv = ConfigureHomeWidget("Relative", "rv", 30, "Relative Layout", True)
	End If
	rv.HandleWidgetEvents(StartingIntent)
	rv.SetImage("ImageView2", LoadBitmap(File.DirAssets, "bg.png"))
End Sub

Private Sub rv_RequestUpdate
	rv.UpdateWidget
End Sub
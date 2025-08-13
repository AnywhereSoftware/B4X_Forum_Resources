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
		rv = ConfigureHomeWidget("4x1", "rv", 30, "Time in Letters", True)
	End If
	rv.HandleWidgetEvents(StartingIntent)
End Sub

Private Sub rv_RequestUpdate
	WriteinLetters
	rv.UpdateWidget
End Sub

Sub WriteinLetters
	Dim value() As String = Regex.Split(":", DateTime.Time(DateTime.Now))
	Select Case value(0)
		Case "01"
			rv.SetText("Label1", "ONE")
		Case "02"
			rv.SetText("Label1", "TWO")
		Case "03"
			rv.SetText("Label1", "THREE")
		Case "04"
			rv.SetText("Label1", "FOUR")
		Case "05"
			rv.SetText("Label1", "FIVE")
		Case "06"
			rv.SetText("Label1", "SIX")
		Case "07"
			rv.SetText("Label1", "SEVEN")
		Case "08"
			rv.SetText("Label1", "EIGHT")
		Case "09"
			rv.SetText("Label1", "NINE")
		Case "10"
			rv.SetText("Label1", "TEN")
		Case "11"
			rv.SetText("Label1", "ELEVEN")
		Case "12"
			rv.SetText("Label1", "TWELVE")
		Case "13"
			rv.SetText("Label1", "THIRTEEN")
		Case "14"
			rv.SetText("Label1", "FOURTEEN")
		Case "15"
			rv.SetText("Label1", "FIFTEEN")
		Case "16"
			rv.SetText("Label1", "SIXTEEN")
		Case "17"
			rv.SetText("Label1", "SEVENTEEN")
		Case "18"
			rv.SetText("Label1", "EIGHTEEN")
		Case "19"
			rv.SetText("Label1", "NINETEEN")
		Case "20"
			rv.SetText("Label1", "TWENTY")
		Case "21"
			rv.SetText("Label1", "TWENTYONE")
		Case "22"
			rv.SetText("Label1", "TWENTYTWO")
		Case "23"
			rv.SetText("Label1", "TWENTYTHREE")
		Case "00"
			rv.SetText("Label1", "ZERO")
	End Select
	Sleep(100)
	rv.UpdateWidget
End Sub

Sub Label1_Click
	rv.UpdateWidget
End Sub
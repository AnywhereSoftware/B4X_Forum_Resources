B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=11.5
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: true
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.

End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	Dim gbus As Gbus
	Dim label As Label
End Sub

Sub Activity_Create(FirstTime As Boolean)
	Activity.Title = "Now in different activity"
	label.Initialize("")
	Activity.AddView(label,5%x,40%y,90%x,10%y)
	label.Color = Colors.Green
	label.TextColor = Colors.White
	
	gbus.Initialize("gbus")

End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)
	gbus.unregister
End Sub

Sub gbus_msg (msg As String)
	Log("got: " & msg)
	label.text = msg
End Sub


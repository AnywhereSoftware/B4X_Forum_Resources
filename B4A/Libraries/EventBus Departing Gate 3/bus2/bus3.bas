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
	
	gbus.Initialize("gbus")

End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)
	gbus.unregister
End Sub

Sub gbus_msg (msg As Object)
	Dim bitmap As Bitmap = msg
	Dim iview As ImageView
	iview.Initialize("")
	Activity.AddView(iview,0%x,0%x,bitmap.Width,bitmap.Height)
	iview.Bitmap = bitmap
	iview.Gravity = Gravity.FILL
End Sub


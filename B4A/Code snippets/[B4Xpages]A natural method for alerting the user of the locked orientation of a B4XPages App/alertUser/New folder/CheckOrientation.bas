B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=10.6
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: True
	#IncludeTitle: False
#End Region

Sub Process_Globals
	Dim ph As Phone
	Public closed As Boolean
	Private passes As Int
End Sub

Sub Globals
	Dim sp As SmartPage
End Sub

Sub Activity_Create(FirstTime As Boolean)
	ph.SetScreenOrientation(2)
End Sub

Sub Activity_Resume
	passes = passes + 1
	Log("X " & passes & TAB & Activity.Width & TAB & Activity.Height)
	If passes > 1 Then
		If Activity.Width > Activity.Height Then
			closed = True
			Activity.finish
		Else
			sp. Initialize("fourthPage", Activity.Width, Activity.Height)
			sp.show(Activity)
		End If
	Else
		ph.SetScreenOrientation(1)
	End If
End Sub

Sub  Activity_Pause(UserClosed As Boolean)
End Sub

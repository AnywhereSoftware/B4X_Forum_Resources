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
	Private xui As XUI
	Public portraitMode As Boolean
	Private ph As Phone
	Private passes As Int	
End Sub

Sub Globals
End Sub

Sub Activity_Create(FirstTime As Boolean)
	portraitMode = True
	ph.SetScreenOrientation(2)
End Sub

Sub Activity_Resume
	passes = passes + 1
	If passes > 1 Then
		If Activity.Width > Activity.Height Then
			portraitMode = False
			Activity.finish
		Else
			centerTitle("This App runs best in landscape mode")
		End If
	Else
		ph.SetScreenOrientation(1)
	End If
End Sub

Sub  Activity_Pause(UserClosed As Boolean)
End Sub

Private Sub centerTitle(s As String)
	Dim lbl As Label: lbl.Initialize("")
	Dim lblx As B4XView = lbl
	lblx.Font = xui.CreateDefaultBoldFont(18)
	lblx.Text = s
	Dim w As Float = 400dip
	Dim h As Float = 30dip
	Activity.AddView(lblx, Activity.Width/2 - w/2, Activity.Height/2 - h/2, w, h)
End Sub
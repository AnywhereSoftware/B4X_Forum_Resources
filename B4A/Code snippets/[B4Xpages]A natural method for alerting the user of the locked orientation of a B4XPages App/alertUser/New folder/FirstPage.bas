B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.6
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
End Sub

Public Sub Initialize As Object
	Return Me
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	StartActivity(CheckOrientation)
End Sub

Private Sub B4XPage_Appear
	Do While CheckOrientation.portraitMode
		Sleep(200)
	Loop
	centerTitle("Welcome to this Awesome App")
End Sub

Private Sub centerTitle(s As String)
	Dim lbl As Label: lbl.Initialize("")
	Dim lblx As B4XView = lbl
	lblx.Font = xui.CreateDefaultBoldFont(18)
	lblx.Text = s
	Dim w As Float = 400dip
	Dim h As Float = 30dip
	Root.AddView(lblx, Root.Width/2 - w/2, Root.Height/2 - h/2, w, h)
End Sub
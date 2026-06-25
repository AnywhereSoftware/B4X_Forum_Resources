B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
' frmTestLayout - a small form built from the frmTestLayout layout.
' Holds a single button that pops a msgbox, used to test loading a designer layout.
Sub Class_Globals
	Private fx As JFX
	Private frm As Form
End Sub

Public Sub Initialize
End Sub

'Builds the form from the layout and shows it.
Public Sub Show
	frm.Initialize("frm", 360, 200)
	frm.Title = "Test Layout"
	frm.RootPane.LoadLayout("frmTestLayout")
	frm.Show
End Sub

Private Sub btnMsg_Click
	fx.Msgbox(frm, "Hello from the test layout!", "Test Layout")
End Sub

B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
' frmDialog - a simple modal dialog form used to test formHelpers.ShowDialog.
Sub Class_Globals
	Private frm As Form
	Private helper As formHelpers
End Sub

Public Sub Initialize
End Sub

'Builds the dialog, shows it modally via formHelpers, and resumes with the DialogResult.
'Caller uses: Wait For (dlg.ShowDialog("...")) Complete (Result As Int)
Public Sub ShowDialog (Title As String) As ResumableSub
	frm.Initialize("frmDialog", 320, 160)
	helper.Initialize(frm)
	helper.Text = Title

	Dim lbl As Label
	lbl.Initialize("")
	lbl.Text = "Choose an option:"
	frm.RootPane.AddNode(lbl, 20, 20, 280, 30)

	Dim ok As Button
	ok.Initialize("dlgOK")
	ok.Text = "OK"
	frm.RootPane.AddNode(ok, 40, 90, 100, 36)

	Dim cancel As Button
	cancel.Initialize("dlgCancel")
	cancel.Text = "Cancel"
	frm.RootPane.AddNode(cancel, 180, 90, 100, 36)

	Wait For (helper.ShowDialog) Complete (Result As Int)
	Return Result
End Sub

Private Sub dlgOK_Click
	helper.DialogResult = helper.RESULT_OK
	helper.Close
End Sub

Private Sub dlgCancel_Click
	helper.DialogResult = helper.RESULT_CANCEL
	helper.Close
End Sub

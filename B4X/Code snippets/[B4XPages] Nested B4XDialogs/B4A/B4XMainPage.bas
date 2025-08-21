B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	Private MainDialog, SecondDialog As B4XDialog
	Private CustomPanel As B4XView
End Sub

Public Sub Initialize

End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("1")
	MainDialog.Initialize(Root)
	SecondDialog.Initialize(Root)
	MainDialog.Title = "Example"
	CustomPanel = xui.CreatePanel("")
	CustomPanel.SetLayoutAnimated(0, 0, 0, 300dip, 300dip)
	CustomPanel.LoadLayout("CustomLayout")
End Sub

Sub btnShowDialog_Click
	Dim rs As Object = MainDialog.ShowCustom(CustomPanel, "Ok", "", "")
	MainDialog.Base.Parent.Tag = "" 'this will prevent the dialog from closing when the second dialog appears.
	Wait For (rs) Complete (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		
	End If
End Sub

Sub DialogButton_Click
	Dim Btn As B4XView = Sender
	Wait For (SecondDialog.Show("Delete button?", "Yes", "No", "")) Complete (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		Btn.RemoveViewFromParent
	End If
End Sub

Sub B4XPage_CloseRequest As ResumableSub
	For Each d As B4XDialog In Array(SecondDialog, MainDialog)
		If d.Visible Then
			d.Close(xui.DialogResponse_Cancel)
			Return False 'don't close the page
		End If
	Next
	Return True
	
End Sub

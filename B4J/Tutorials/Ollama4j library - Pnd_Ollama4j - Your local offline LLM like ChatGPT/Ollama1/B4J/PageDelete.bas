B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	Private cBox As ComboBox
	Private btnDelete As Button
End Sub


Public Sub Initialize As Object
	Return Me
End Sub


Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("layDelete")
	
	Sleep(100)
	GetModels	
End Sub


Public Sub GetModels
	Try 'ignore
		cBox.Items.Clear
		For Each Model As Pnd_Model In Main.Ollama.ListModels
			cBox.Items.Add(Model.Model)
		Next
		If cBox.Items.Size < 1 Then
			xui.MsgboxAsync("You don't have any model to Delete.", "Info")
			btnDelete.Enabled = False
		Else
			btnDelete.Enabled = True
		End If
	Catch
		'Log(LastException)
	End Try 'ignore
End Sub


Private Sub btnDelete_Click
	Main.Ollama.DeleteModel(cBox.Value)
	xui.MsgboxAsync(cBox.Value & " - Deleted successfuly", "Delete")
	Dim MainPage As B4XMainPage = B4XPages.GetPage("MainPage")
	MainPage.GetModels
	GetModels
End Sub
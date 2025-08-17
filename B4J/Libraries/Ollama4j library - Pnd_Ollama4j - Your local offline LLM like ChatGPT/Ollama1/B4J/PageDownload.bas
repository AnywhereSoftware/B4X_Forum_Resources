B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	Private btnDownload As Button
	Private cBox As ComboBox
	Private modelList As List
	Private tagsList As List
	Private cBoxTags As ComboBox
	Private lblDescription As Label
	Private lblPopularTags As Label
	Private lblPullCount As Label
	Private lblLastUpdate As Label
	Private lblSize As Label
End Sub


Public Sub Initialize As Object
	Return Me
End Sub


Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("layDownload")
	
	Main.Ollama.RequestTimeoutSeconds = 3600
	
	lblDescription.Text = CRLF & "Please wait... Please wait... Please wait... Please wait... Please wait... Please wait... "
	lblPopularTags.Text = ""
	lblPullCount.Text = ""
	lblLastUpdate.Text = ""
	lblSize.Text = ""

	modelList.Initialize
	tagsList.Initialize
	
	Sleep(100)
	GetList
End Sub


Private Sub GetList			
	modelList.Clear
	Dim comboList As List
	comboList.Initialize
		
	Dim ModelsFromLibrary As List = Main.Ollama.ListModelsFromLibrary
	For Each ModelFromLibrary As Pnd_LibraryModel In ModelsFromLibrary
		modelList.Add(ModelFromLibrary)
		comboList.Add(ModelFromLibrary.Name)
	Next
	
	cBox.Items.AddAll(comboList)
	lblDescription.Text = CRLF &  "Choose your model."
End Sub


Private Sub cBox_SelectedIndexChanged(Index As Int, Value As Object)	
	lblDescription.Text = ""
	lblPopularTags.Text = "Popular tags: " & CRLF
	lblPullCount.Text = ""
	lblLastUpdate.Text = ""
	lblSize.Text = ""
	
	cBoxTags.Items.Clear
	
	Dim lst As List
	lst.Initialize
	
	tagsList.Clear
		
	Dim ModelFromLibrary As Pnd_LibraryModel = modelList.Get(Index)
	lblDescription.Text = ModelFromLibrary.Description
	For Each mTag As String In ModelFromLibrary.PopularTags
		lblPopularTags.Text = lblPopularTags.Text & mTag & CRLF
	Next

	lblPullCount.Text = "Pull count: " & ModelFromLibrary.PullCount
		
	Dim lmd As Pnd_LibraryModelDetail
	lmd = Main.Ollama.LibraryModelDetails(ModelFromLibrary)
	For Each Tag As Pnd_LibraryModelTag In lmd.Tags
		tagsList.Add(Tag)
		lst.Add(Tag.Tag)
	Next
	
	cBoxTags.Items.AddAll(lst)
End Sub


Private Sub cBoxTags_SelectedIndexChanged(Index As Int, Value As Object)
	If Index >= 0 Then
		Dim lmt As Pnd_LibraryModelTag = tagsList.Get(Index)
		lblLastUpdate.Text = "Last update: " & lmt.LastUpdated
		lblSize.Text = "Download size: " & lmt.Size
	Else
		lblLastUpdate.Text = ""
		lblSize.Text = ""
	End If
End Sub


Private Sub btnDownload_Click
	If cBox.SelectedIndex < 0 Then
		xui.MsgboxAsync("Please choose your MODEL.", "Error")
		Return
	End If
	
	If cBoxTags.SelectedIndex < 0 Then
		xui.MsgboxAsync("Please choose your TAG.", "Error")
		Return
	End If
		
	Dim sf As Object = xui.Msgbox2Async("Please wait few minutes until you see 'Successful Download' msgbox.", "Info", "OK", "", "", Null)
	Wait For (sf) Msgbox_Result (Result As Int)
	Main.Ollama.PullModel(cBox.Value & ":" & cBoxTags.Value) ' When finish, event will rise on B4XMainPage in Sub Ollama_PullModelComplete
End Sub
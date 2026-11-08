B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private CustomListView1 As CustomListView
	Private TextArea1 As B4XView
	Private DragAndDrop1 As DragAndDrop
	Private Tik As Tika
	Private AnotherProgressBar1 As AnotherProgressBar
	Private txtPassword As B4XFloatTextField
	Private switchXHTML As B4XSwitch
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(Me, "Tika Example")
	DragAndDrop1.Initialize(Me)
	DragAndDrop1.MakeDragTarget(Root, "DropTarget")
	CustomListView1.DefaultTextBackgroundColor = xui.Color_White
	Tik.Initialize
End Sub

Sub DropTarget_DragEntered(e As DragEvent)
	Dim clr As Int
	If IsValidDropEvent(e) Then
		clr = xui.Color_Green
	Else
		clr = xui.Color_Red
	End If
	Root.Color = clr
End Sub

Sub DropTarget_DragExited(e As DragEvent)
	Root.Color = xui.Color_White
End Sub

Sub DropTarget_DragOver(e As DragEvent)
	If IsValidDropEvent(e) Then e.AcceptTransferModes(TransferMode.COPY)
End Sub

Sub IsValidDropEvent(e As DragEvent) As Boolean
	If e.GetDragboard.HasFiles Then
		Dim files As List = e.GetDragboard.GetFiles
		If files.Size = 1 Then
			Return True
		End If
	End If
	Return False
End Sub

Sub DropTarget_DragDropped(e As DragEvent)
	Log("drag dropped")
	Dim filename As String = e.GetDragboard.GetFiles.Get(0)
	e.SetDropCompleted(True)
	ParseFile(filename)
End Sub

Private Sub ParseFile (filename As String)
	TextArea1.Text = ""
	CustomListView1.Clear
	Tik.Password = txtPassword.Text
	Tik.OutputTextFormat = IIf(switchXHTML.Value, Tik.OUTPUT_XHTML, Tik.OUTPUT_PLAIN)
	AnotherProgressBar1.Visible = True
	Wait For (Tik.Parse(File.OpenInput(filename, ""))) Complete (Res As TikaParseResult)
	AnotherProgressBar1.Visible = False
	If Res.Success Then
		TextArea1.Text = Res.Text
		B4XPages.SetTitle(Me, $"${File.GetName(filename)} (${Res.Metadata.Get("Content-Type").As(List).Get(0)})"$)
		Log(Res.Metadata)
		If Res.Exception.IsInitialized Then
			CustomListView1.AddTextItem($"Error: ${Res.Exception}"$, "")
			CustomListView1.GetPanel(0).GetView(0).TextColor = xui.Color_Red
		End If
		For Each key In Res.Metadata.Keys
			'Each value in the res.Metadata map is a List with one or more items.
			Dim values As List = Res.Metadata.Get(key)
			CustomListView1.AddTextItem($"${key} -> ${IIf (values.Size = 1, values.Get(0), values)}"$, "")
		Next
	End If
End Sub


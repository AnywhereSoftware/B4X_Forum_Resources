B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@

#CustomBuildAction: after packager, %WINDIR%\System32\robocopy.exe, Python temp\build\bin\python /E /XD __pycache__ Doc pip setuptools tests

'Export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip
'Create a local Python runtime:   ide://run?File=%WINDIR%\System32\Robocopy.exe&args=%B4X%\libraries\Python&args=Python&args=/E
'Open local Python shell: ide://run?File=%PROJECT%\Objects\Python\WinPython+Command+Prompt.exe
'Open global Python shell - make sure to set the path under Tools - Configure Paths. Do not update the internal package.
'ide://run?File=%B4J_PYTHON%\..\WinPython+Command+Prompt.exe

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Public Py As PyBridge
	Private DocumentConverter As PyWrapper
	Private DragAndDrop1 As DragAndDrop
	Private WebView1 As WebView
	Type ConvertResult (Success As Boolean, Html As String)
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	B4XPages.SetTitle(Me, "Docling example")
	Root.LoadLayout("MainPage")
	ShowProgress
	Py.Initialize(Me, "Py")
	Dim opt As PyOptions = Py.CreateOptions("Python/python/python.exe")
	Py.Start(opt)
	Wait For Py_Connected (Success As Boolean)
	If Success = False Then
		LogError("Failed to start Python process.")
		Return
	End If
	DocumentConverter = Py.ImportModuleFrom("docling.document_converter", "DocumentConverter")
	DragAndDrop1.Initialize(Me)
	DragAndDrop1.MakeDragTarget(WebView1, "DropTarget")
	WebView1.LoadHtml("<h1>Drop file here</h1>")
End Sub

Private Sub ShowProgress
	WebView1.LoadHtml($"<progress style="width:100%"></progress>"$)
End Sub

Sub DropTarget_DragEntered(e As DragEvent)
	Log("DragEntered")
	Dim clr As Int = IIf(IsValidDropEvent(e), xui.Color_Green, xui.Color_Red)
	Root.SetColorAndBorder(xui.Color_White, 4dip, clr, 0)
End Sub

Sub DropTarget_DragExited(e As DragEvent)
	Root.SetColorAndBorder(xui.Color_White, 0, 0, 0)
End Sub

Sub DropTarget_DragOver(e As DragEvent)
	If IsValidDropEvent(e) Then e.AcceptTransferModes(TransferMode.COPY)
End Sub

Sub DropTarget_DragDropped(e As DragEvent)
	Log("drag dropped")
	Dim filename As String = e.GetDragboard.GetFiles.Get(0)
	ShowProgress
	Wait For (ConvertFileToHtml(filename)) Complete (Result As ConvertResult)
	WebView1.LoadHtml(Result.Html)
	e.SetDropCompleted(True)
End Sub

Private Sub ConvertFileToHtml(FilePath As String) As ResumableSub
	Dim Doc As PyWrapper = DocumentConverter.Call.Run("convert").Arg(FilePath).GetField("document")
	Dim html As PyWrapper = Doc.Run("export_to_html")
	Wait For (html.Fetch) Complete (html As PyWrapper)
	If html.IsSuccess Then
		Return CreateConvertResult(True, html.Value)
	Else
		Return CreateConvertResult(False, "Error: " & html.ErrorMessage)
	End If
End Sub

Sub IsValidDropEvent(e As DragEvent) As Boolean
	If e.GetDragboard.HasFiles Then
		Dim files As List = e.GetDragboard.GetFiles
		Return files.Size = 1
	End If
	Return False
End Sub

Private Sub B4XPage_Background
	Py.KillProcess
End Sub

Private Sub Py_Disconnected
	Log("PyBridge disconnected")
End Sub

Public Sub CreateConvertResult (Success As Boolean, Html As String) As ConvertResult
	Dim t1 As ConvertResult
	t1.Initialize
	t1.Success = Success
	t1.Html = Html
	Return t1
End Sub
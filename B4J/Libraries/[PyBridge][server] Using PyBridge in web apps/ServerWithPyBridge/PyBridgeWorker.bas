B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.13
@EndOfDesignText@
Sub Class_Globals
	Private py As PyBridge
End Sub

'dependency: pip install ascii_magic
Public Sub Initialize
	Main.PyWorker = Me
	Start
	StartMessageLoop
End Sub

Private Sub Start
	py.Initialize(Me, "py")
	Dim opt As PyOptions = py.CreateOptions("python") 'path to python (or global Python)
	py.Start(opt)
	Wait For py_Connected (Success As Boolean)
	If Success = False Then
		py_Disconnected
		Return
	End If
End Sub

'this is called from the websocket handler
Private Sub Image_Request(Callback As Object, FilePath As String)
	Dim AsciiArt As PyWrapper = py.ImportModuleFrom("ascii_magic", "AsciiArt")
	Dim MyArt As PyWrapper = AsciiArt.Run("from_image").Arg(FilePath)
	Dim html As PyWrapper = MyArt.Run("to_html").ArgNamed("columns", 200)
	Wait For (html.Fetch) Complete (html As PyWrapper)
	CallSubDelayed2(Callback, "Image_Response", html)
End Sub

Private Sub py_Disconnected
	Log("PyBridge disconnected!!!")
	Sleep(60000)
	Start
End Sub


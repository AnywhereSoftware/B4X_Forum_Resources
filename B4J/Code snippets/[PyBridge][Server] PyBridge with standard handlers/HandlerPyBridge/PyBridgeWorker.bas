B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
Sub Class_Globals
	Private py As PyBridge
End Sub

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
Private Sub Run_Eval(Callback As Object, EvalString As String)
	Log(EvalString)
	Dim res As PyWrapper = py.RunStatement(EvalString) 'only for secure andtrusted servers
	Wait For (res.Fetch) Complete (res As PyWrapper)
	CallSubDelayed2(Callback, "Run_Eval", res)
End Sub

Private Sub py_Disconnected
	Log("PyBridge disconnected!!!")
	Sleep(60000)
	Start
End Sub


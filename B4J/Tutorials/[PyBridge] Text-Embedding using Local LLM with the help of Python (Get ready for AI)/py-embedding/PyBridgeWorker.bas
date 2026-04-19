B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
Sub Class_Globals
	Private py As PyBridge
	Public AILogic As PyWrapper ' Python script
End Sub

Public Sub Initialize
	Main.PyWorker = Me
	Start
	StartMessageLoop
End Sub

Private Sub Start
	py.Initialize(Me, "py")
	Dim opt As PyOptions = py.CreateOptions("python")
	py.Start(opt)
    
	Wait For py_Connected (Success As Boolean)
	If Success = False Then
		py_Disconnected
		Return
	End If
    
	Log("PyBridge Connected! Loading LLM - please wait...")
    
	' Import script
	AILogic = py.ImportModule("text_embedding")
    
	' Call Python to load model (SentenceTransformer)
	Dim InitTask As PyWrapper = AILogic.Run("init_model")
	Wait For (InitTask.Fetch) Complete (Result As PyWrapper)
	Log("AI Status: " & Result.Value)
End Sub

' -------------------------------------------------------------------------
' Αυτή η ρουτίνα καλείται από τον Handler όταν ο πελάτης ζητήσει κάτι
' -------------------------------------------------------------------------
Public Sub Get_Embedding_Request(Callback As Object, TextToEmbed As String)
	' Sending text to Python
	Dim EmbedTask As PyWrapper = AILogic.Run("get_embedding").Arg(TextToEmbed)
    
	' wait for Base64 string
	Wait For (EmbedTask.Fetch) Complete (Base64Result As PyWrapper)
    
	' send back to handler..
	CallSubDelayed2(Callback, "Embedding_Response", Base64Result.Value)


End Sub

Private Sub py_Disconnected
	Log("PyBridge disconnected!!!")
	Sleep(5000)
	Start
End Sub
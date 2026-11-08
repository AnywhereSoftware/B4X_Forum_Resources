B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.801
@EndOfDesignText@
'ADD IN MAIN
'AÑADIR EN MAIN
'Sub Process_Globals
'	Type DBResult (Tag As Object, Columns As Map, Rows As List)
'	Type DBCommand (Name As String, Parameters() As Object)
'End Sub



Sub Class_Globals
	'CHANGE THE IP TO MATCH YOUR B4J SERVER
	Private const rdcLink As String = "http://192.168.1.54:8090/rdc"
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
End Sub

Private Sub CreateRequest As DBRequestManager
	Dim req As DBRequestManager
	req.Initialize(Me, rdcLink)
	Return req
End Sub

Private Sub CreateCommand(Name As String, Parameters() As Object) As DBCommand
	Dim cmd As DBCommand
	cmd.Initialize
	cmd.Name = Name
	If Parameters <> Null Then cmd.Parameters = Parameters
	Return cmd
End Sub

Public Sub GetRecord (Command As String, parameters() As String) As ResumableSub
	Dim Answer As Map
	Answer.Initialize
	Dim req As DBRequestManager = CreateRequest
	Dim cmd As DBCommand = CreateCommand(Command, parameters)
	Wait For (req.ExecuteQuery(cmd, 0, Null)) JobDone(j As HttpJob)
	Answer.Put("Success", j.Success)
	If j.Success Then
		req.HandleJobAsync(j, "req")
		Wait For (req) req_Result(Res As DBResult)
		'work with result
		req.PrintTable(Res)
		Answer.Put("Message","Data have been read successfully")
	Else
		Log("ERROR: " & j.ErrorMessage)
		Answer.Put("Error", j.ErrorMessage)
	End If
	j.Release
	Answer.Put("Data",Res)
	'req.PrintTable(Res)
	Return Answer
End Sub

Public Sub InsertUpdateRecord (Command As String, parameters() As String) As ResumableSub
	Dim Answer As Map
	Answer.Initialize
	Dim cmd As DBCommand = CreateCommand(Command, parameters)
	Dim j As HttpJob = CreateRequest.ExecuteBatch(Array(cmd), Null)
	Wait For(j) JobDone(j As HttpJob)
	If j.Success Then
		Log("successfully!")
	End If
	Answer.Put("Success",j.Success)
	Answer.Put("Error", j.ErrorMessage)
	j.Release
	Return Answer
End Sub
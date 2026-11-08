Type=StaticCode
Version=5.9
ModulesStructureVersion=1
B4J=true
@EndOfDesignText@
'******
'2017/10/29: V 0.01
''******
Sub Process_Globals
	Private rdcLink As String
End Sub

Public Sub Intitialize(rdcUri As String)
	rdcLink = rdcUri
End Sub

Sub CreateRequest As DBRequestManager
	Dim req As DBRequestManager
	req.Initialize(Me, rdcLink)
	Return req
End Sub

Public Sub CreateCommand(Name As String, Parameters() As Object) As DBCommand
	Dim cmd As DBCommand
	cmd.Initialize
	cmd.Name = Name
	cmd.Parameters = Parameters
	Return cmd
End Sub

Public Sub AddCommand(cmdLst As List, cmd As String, params() As Object)
	cmdLst.Add(CreateCommand(cmd, params))
End Sub

Public Sub ExecuteCommands(cmdLst As List) As ResumableSub
	Dim cmdCount As Int = -1
'	If cmdLst = Null Or cmdLst.IsInitialized = False Then Return cmdCount
	If cmdLst.Size > 0 Then
		Log($"${cmdLst.Size} commands to be executed"$)
		Dim j As HttpJob = CreateRequest.ExecuteBatch(cmdLst, Null)
		Wait For(j) JobDone(j As HttpJob)
		If j.Success Then
			Log($"${cmdLst.Size} commands executed successfully!"$)
			cmdCount = cmdLst.Size
		Else
			Log($"Error executing command: ${j.ErrorMessage}"$)
		End If
		j.Release
	End If
	Return cmdCount
End Sub

Public Sub ExecuteCommands2(mCaller As Object, mMethod As String, cmdLst As List)
	Wait For (ExecuteCommands(cmdLst)) complete (Result As Int)
	CallSubDelayed2(mCaller, mMethod, Result)
End Sub

Public Sub ExecuteQuery(cmd As DBCommand) As ResumableSub
	Dim req As DBRequestManager = CreateRequest
	'req.ExeucteQuery returns a HttpJob. The returned HttpJob is used as the sender filter.
	Wait For (req.ExecuteQuery(cmd, 0, Null)) JobDone(j As HttpJob)
	If j.Success Then
		req.HandleJobAsync(j, "req")
		Wait For (req) req_Result(res As DBResult)
	Else
		Dim res As DBResult = Null
		Log($"Error executing query: ${j.ErrorMessage}"$)
	End If
	j.Release
	Return res
End Sub

Public Sub ExecuteQuery2(mCaller As Object, mMethod As String, cmd As DBCommand)
	wait for (ExecuteQuery(cmd)) complete (res As DBResult)
	CallSubDelayed2(mCaller, mMethod, res)
End Sub

'DBResult columns map keys are case sensitive. Use this to allow for case insensitive match.
Public Sub GetColumnObject(res As DBResult, rowIdx As Int, colName As String) As Object
'	If res = Null Or res.IsInitialized = False Then Return Null
'	If rowIdx < 0 Or res.Rows.Size < rowIdx Then Return Null
	Dim colIdx As Int = -1
	Dim columns As Map = res.Columns
	For Each key As String In columns.Keys
		If key.EqualsIgnoreCase(colName) Then
			colIdx = columns.Get(key)
			Exit
		End If
	Next
	If colIdx = -1 Then Return Null
	Dim row() As Object = res.Rows.Get(rowIdx)
	Return row(colIdx)
End Sub

Public Sub GetColumnIndex(res As DBResult, colName As String) As Int
	Dim colIdx As Int = -1
'	If res = Null Or res.IsInitialized = False Then Return colIdx
	Dim columns As Map = res.Columns
	For Each key As String In columns.Keys
		If key.EqualsIgnoreCase(colName) Then
			colIdx = columns.Get(key)
			Exit
		End If
	Next
	Return colIdx
End Sub

'Executes the query and fills the list with the values in the first column.
Public Sub ExecuteList(cmd As DBCommand, List1 As List) As ResumableSub
	Dim Result As Int = -1
	List1.Clear
	Wait For (ExecuteQuery(cmd)) complete (res As DBResult)
	If res <> Null And res.IsInitialized Then
		For Each row() As Object In res.Rows
			List1.Add(row(0))
		Next
		Result = List1.Size
	End If
	Return Result
End Sub

Public Sub ExecuteTableView(cmd As DBCommand, TableView1 As TableView) As ResumableSub
	Dim Result As Int = -1
	TableView1.Items.Clear
	Wait For (ExecuteQuery(cmd)) complete (res As DBResult)
	If res <> Null And res.IsInitialized Then
		Dim cols As List
		cols.Initialize
		For i = 0 To res.Columns.Size -1
			cols.Add(res.Columns.GetKeyAt(i))
		Next
		TableView1.SetColumns(cols)
		For Each row() As Object In res.Rows
			Dim values(res.Columns.Size) As String
			Dim value As String
			For col = 0 To res.Columns.Size - 1
				value = row(col)
				values(col) = value
			Next
			TableView1.Items.Add(values)
		Next
		Result = res.Rows.Size
	End If
	Return Result
End Sub


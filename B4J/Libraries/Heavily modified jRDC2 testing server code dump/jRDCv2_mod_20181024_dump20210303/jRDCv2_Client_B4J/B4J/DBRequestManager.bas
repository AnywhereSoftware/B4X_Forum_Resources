B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=5.9
@EndOfDesignText@
'Requires support for resumable subs
'Class module

Sub Class_Globals
	Private mTarget As Object
	Private link As String
	Private VERSION As Float = 2

End Sub

'Target - The module that handles JobDone (usually Me).
'ConnectorLink - URL of the Java server.
Public Sub Initialize (Target As Object, ConnectorLink As String)
	mTarget = Target
	link = ConnectorLink
End Sub

'Sends a query request.
'Command - Query name and parameters.
'Limit - Maximum rows to return or 0 for no limit.
'Tag - An object that will be returned in the result.
Public Sub ExecuteQuery(Command As DBCommand, Limit As Int, Tag As Object) As HttpJob
	Dim ser As B4XSerializator
	Dim data() As Byte = ser.ConvertObjectToBytes(CreateMap("command": Command, "limit": Limit,  "version": VERSION))
	Return SendJob(CreateJob, data, Tag, "query2")
End Sub

Private Sub SendJob(j As HttpJob, Data() As Byte, Tag As Object, Method As String) As HttpJob
	j.Tag = Tag
	j.PostBytes(link & "?method=" & Method , Data)
	Return j
End Sub

Private Sub CreateJob As HttpJob
	Dim j As HttpJob
	j.Initialize("DBRequest", mTarget)
	Return j
End Sub

'Executes a batch of (non-select) commands.
'ListOfCommands - List of the commands that will be executes.
'Tag - An object that will be returned in the result.
Public Sub ExecuteBatch(ListOfCommands As List, Tag As Object) As HttpJob
	Dim j As HttpJob = CreateJob
	ExecuteBatchImpl(j, ListOfCommands, Tag)
	Return j
End Sub

Private Sub ExecuteBatchImpl(Job As HttpJob, ListOfCommands As List, Tag As Object)
	Dim ser As B4XSerializator
	ser.ConvertObjectToBytesAsync(CreateMap("commands": ListOfCommands,  "version": VERSION), "ser")
	Wait For (ser) ser_ObjectToBytes (Success As Boolean, Bytes() As Byte)
	If Success = False Then
		Log("Error building command: " & LastException)
		Return
	End If
	Dim ser As B4XSerializator = Sender
	SendJob(Job, Bytes, Tag, "batch2")
End Sub


'Similar to ExecuteBatch. Sends a single command.
Public Sub ExecuteCommand(Command As DBCommand, Tag As Object) As HttpJob
	Return ExecuteBatch(Array As DBCommand(Command), Tag)
End Sub

'Handles the Job result and returns a DBResult.
'It is recommended to use HandleJobAsync instead.
Public Sub HandleJob(Job As HttpJob) As DBResult
	Dim ser As B4XSerializator
	Dim data() As Byte = Bit.InputStreamToBytes(Job.GetInputStream)
	Dim res As DBResult = ser.ConvertBytesToObject(data)
	res.Tag = Job.Tag
	Return res
End Sub
'Handles the Job result and raises the Result event when the data is ready.

Public Sub HandleJobAsync(Job As HttpJob, EventName As String)
	Dim ser As B4XSerializator
	Dim data() As Byte = Bit.InputStreamToBytes(Job.GetInputStream)
	ser.ConvertBytesToObjectAsync(data, "ser")
	Wait For (ser) ser_BytesToObject (Success As Boolean, NewObject As Object)
	If Success = False Then
		Log("Error reading response: " & LastException)
		Return
	End If
	Dim res As DBResult = NewObject
	res.Tag = Job.Tag
	CallSubDelayed2(mTarget, EventName & "_result", res)
End Sub




'Reads a file and returns the file as a bytes array.
Public Sub FileToBytes(Dir As String, FileName As String) As Byte()
	Dim out As OutputStream
	out.InitializeToBytesArray(0)
	Dim In As InputStream = File.OpenInput(Dir, FileName)
	File.Copy2(In, out)
	out.Close
	Return out.ToBytesArray
End Sub
#if Not(B4J)
'Converts an image to a bytes array (for BLOB fields).
Public Sub ImageToBytes(Image As Bitmap) As Byte()
	Dim out As OutputStream
	out.InitializeToBytesArray(0)
	Image.WriteToStream(out, 100, "JPEG")
	out.Close
	Return out.ToBytesArray
End Sub
'Converts a bytes array to an image (for BLOB fields).
Public Sub BytesToImage(bytes() As Byte) As Bitmap
	Dim In As InputStream
	In.InitializeFromBytesArray(bytes, 0, bytes.Length)
	Dim bmp As Bitmap
	bmp.Initialize2(In)
	Return bmp
End Sub
#End If

'Prints the table to the logs.
Public Sub PrintTable(Table As DBResult)
	Log("Tag: " & Table.Tag & ", Columns: " & Table.Columns.Size & ", Rows: " & Table.Rows.Size)
	Dim sb As StringBuilder
	sb.Initialize
	For Each col In Table.Columns.Keys
		sb.Append(col).Append(TAB)
	Next
	Log(sb.ToString)
	For Each row() As Object In Table.Rows
		Dim sb As StringBuilder
		sb.Initialize
		For Each record As Object In row
			sb.Append(record).Append(TAB)
		Next
		Log(sb.ToString)
	Next
End Sub



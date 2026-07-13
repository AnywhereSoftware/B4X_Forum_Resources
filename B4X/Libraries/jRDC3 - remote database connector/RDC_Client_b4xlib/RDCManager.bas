B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
Sub Class_Globals
	Private const VERSION As Float = 3.0
	Private mLink As String
	Type RDCResult (Success As Boolean, ErrorMessage As String, Data As ListOfArrays)
	Type RDCCommand (Name As String, Parameters() As Object)
End Sub

Public Sub Initialize (ServerUrl As String)
	mLink = ServerUrl
End Sub

'Sends the query and asynchronously returns a RDCResult.
'Example: <code> Wait For (Manager.ExecuteQuery("select_item", Array(1234))) Complete (Result As RDCResult)</code>
Public Sub ExecuteQuery (QueryName As String, Parameters() As Object) As ResumableSub
	Dim ser As B4XSerializator
	Dim data() As Byte = ser.ConvertObjectToBytes(CreateMap("command": CreateMap("name": QueryName, "parameters": Parameters),  "version": VERSION))
	Dim j As HttpJob
	j.Initialize("", Me)
	j.PostBytes(mLink & "?method=query2", data)
	Wait For (j) JobDone(j As HttpJob)
	Dim res As RDCResult
	If j.Success Then
		Dim ser As B4XSerializator
		Dim data() As Byte = Bit.InputStreamToBytes(j.GetInputStream)
		ser.ConvertBytesToObjectAsync(data, "ser")
		Wait For (ser) ser_BytesToObject (Success As Boolean, NewObject As Object)
		If Success Then
			res = CreateRDCResult(True, "", LOAUtils.WrapWithHeader(NewObject))
		Else
			res = CreateRDCResult(False, "Error during serialization: " & LastException, Null)
		End If
	Else
		res = CreateRDCResult(False, j.ErrorMessage, Null)
	End If
	j.Release
	Return res
End Sub

'Sends the command and asynchronously returns a RDCResult.
'Example: <code>Wait For (Manager.ExecuteCommand("insert_item", Array("item 1", 10))) Complete (Result As RDCResult)</code>
Public Sub ExecuteCommand(CommandName As String, Parameters() As Object) As ResumableSub
	Dim rs As Object = ExecuteBatch(Array(CreateRDCCommand(CommandName, Parameters)))
	Wait For (rs) Complete (Result As RDCResult)
	Return Result
End Sub

'Executes multiple commands as a single batch.
'Commands - List of RDCComand items. Use Manager.CreateRDCCommand to create commands.
'Example: <code> Wait For (Manager.ExecuteBatch(Commands)) Complete (Result As RDCResult)</code>
Public Sub ExecuteBatch (Commands As List) As ResumableSub
	Dim CommandMaps As List = B4XCollections.CreateList(Null)
	For Each rc As RDCCommand In Commands
		CommandMaps.Add(CreateMap("name": rc.Name, "parameters": rc.Parameters))
	Next
	Dim ser As B4XSerializator
	ser.ConvertObjectToBytesAsync(CreateMap("commands": CommandMaps,  "version": VERSION), "ser")
	Wait For (ser) ser_ObjectToBytes (Success As Boolean, Bytes() As Byte)
	If Success = False Then
		Return CreateRDCResult(False, "Error building command: " & LastException, Null)
	End If
	Dim j As HttpJob
	j.Initialize("", Me)
	j.PostBytes(mLink & "?method=batch2", Bytes)
	Wait For (j) JobDone(j As HttpJob)
	Dim res As RDCResult
	If j.Success Then
		Dim data() As Byte = Bit.InputStreamToBytes(j.GetInputStream)
		res = CreateRDCResult(True, "", LOAUtils.WrapWithHeader(ser.ConvertBytesToObject(data)))
	Else
		res = CreateRDCResult(False, j.ErrorMessage, Null)
	End If
	j.Release
	Return res
End Sub

Private Sub CreateRDCResult (Success As Boolean, ErrorMessage As String, Result As ListOfArrays) As RDCResult
	Dim t1 As RDCResult
	t1.Initialize
	t1.Success = Success
	t1.ErrorMessage = ErrorMessage
	t1.Data = Result
	Return t1
End Sub

#if B4A or B4i or UI
'Utility method to convert a B4XBitmap to bytes (images are not serializable directly).
Public Sub ImageToBytes(Image As B4XBitmap) As Byte()
	Dim out As OutputStream
	out.InitializeToBytesArray(0)
	Image.WriteToStream(out, 100, "JPEG")
	out.Close
	Return out.ToBytesArray
End Sub

'Utility method to convert bytes to B4XBitmap.
Public Sub BytesToImage(bytes() As Byte) As B4XBitmap
	Dim In As InputStream
	In.InitializeFromBytesArray(bytes, 0, bytes.Length)
#if B4A or B4i
   Dim bmp As Bitmap
   bmp.Initialize2(In)
#else
	Dim bmp As Image
	bmp.Initialize2(In)
#end if
	Return bmp
End Sub
#End If

'Created a RDCCommand to be used with ExecuteBatch.
Public Sub CreateRDCCommand (Name As String, Parameters() As Object) As RDCCommand
	Dim t1 As RDCCommand
	t1.Initialize
	t1.Name = Name
	t1.Parameters = Parameters
	Return t1
End Sub
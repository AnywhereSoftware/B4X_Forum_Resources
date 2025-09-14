B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=10
@EndOfDesignText@
#ModuleVisibility: B4XLib

Sub Process_Globals

End Sub

Public Sub PatchMultipart(j As HttpJob,Link As String, NameValues As Map, Files As List)
	Dim boundary As String = "---------------------------1461124740692"
	Dim stream As OutputStream
	stream.InitializeToBytesArray(0)
	Dim b() As Byte
	Dim eol As String = Chr(13) & Chr(10)
	Dim empty As Boolean = True
	If NameValues <> Null And NameValues.IsInitialized Then
		For Each key As String In NameValues.Keys
			Dim value As String = NameValues.Get(key)
			empty = MultipartStartSection (stream, empty)
			Dim s As String = _
$"--${boundary}
Content-Disposition: form-data; name="${key}"

${value}"$
			b = s.Replace(CRLF, eol).GetBytes("UTF8")
			stream.WriteBytes(b, 0, b.Length)
		Next
	End If
	If Files <> Null And Files.IsInitialized Then
		For Each fd As MultipartFileData In Files
			empty = MultipartStartSection (stream, empty)
			Dim s As String = _
$"--${boundary}
Content-Disposition: form-data; name="${fd.KeyName}"; filename="${fd.FileName}"
Content-Type: ${fd.ContentType}

"$
			b = s.Replace(CRLF, eol).GetBytes("UTF8")
			stream.WriteBytes(b, 0, b.Length)
			Dim in As InputStream = File.OpenInput(fd.Dir, fd.FileName)
			File.Copy2(in, stream)
		Next
	End If
	empty = MultipartStartSection (stream, empty)
	s = _
$"--${boundary}--
"$
	b = s.Replace(CRLF, eol).GetBytes("UTF8")
	stream.WriteBytes(b, 0, b.Length)
	j.PatchBytes(Link, stream.ToBytesArray)
	j.GetRequest.SetContentType("multipart/form-data; boundary=" & boundary)
	j.GetRequest.SetContentEncoding("UTF8")
End Sub

Private Sub MultipartStartSection (stream As OutputStream, empty As Boolean) As Boolean
	If empty = False Then
		stream.WriteBytes(Array As Byte(13, 10), 0, 2)
	Else
		empty = False
	End If
	Return empty
End Sub

Public Sub SubExists2(Target As Object,TargetSub As String,NumbersOfParameters As Int) As Boolean
	#IF B4I
	Return SubExists(Target,TargetSub,NumbersOfParameters)
	#Else
	Return SubExists(Target,TargetSub)
	#End If
End Sub

'https://www.b4x.com/android/forum/threads/b4x-get-jwt-payload-javawebtoken.165158/post-1012667
Public Sub GetJWTPayload (Token As String) As Map
	Dim parts() As String = Regex.Split("\.", Token)
	Dim encoded As String = parts(1)
	Select encoded.Length Mod 4
		Case 2
			encoded = encoded & "=="
		Case 3
			encoded = encoded & "="
	End Select
	Dim su As StringUtils
	Dim b() As Byte = su.DecodeBase64(encoded)
	Dim payload As String = BytesToString(b, 0, b.Length, "UTF-8")
	Log(payload)
	Return payload.As(JSON).ToMap
End Sub

Public Sub GenerateResult(j As HttpJob) As Map
	Dim response As String = ""
	If j.Success Then
		response = j.GetString
		#If Debug
		Log("PocketbaseFunctions: " & j.GetString)
		#End If
	Else
		response = j.ErrorMessage
	End If
	
	Dim tmp_result As Map
	
	Try
		If response <> "" Then
			Dim parser As JSONParser
			parser.Initialize(response)
			tmp_result = UnReadOnlyMap(parser.NextObject)
		Else
			tmp_result.Initialize
		End If
		tmp_result.Put("success",j.Success)
	
	Catch
		Log("Pocketbase_Functions: " & LastException)
		tmp_result.Initialize
		tmp_result.Put("success",False)
	End Try
	
	j.Release
	Return tmp_result
End Sub

Public Sub CreateDatabaseResult(JsonString As String) As PocketbaseDatabaseResult

	Dim DatabaseResult As PocketbaseDatabaseResult
	DatabaseResult.Initialize
	DatabaseResult.Columns.Initialize
	DatabaseResult.Rows.Initialize

	If JsonString.StartsWith("[") = False Then
		JsonString = "[" & JsonString & "]"
	End If
	'Log(JsonString)
	Dim parser As JSONParser
	parser.Initialize(JsonString)
	Dim jRoot As List = parser.NextArray
			
	Dim FirstTime As Boolean = True
			
	If jRoot.Size > 0 Then
			
		Dim NewColjRoot As Map = jRoot.Get(0)
		If NewColjRoot.ContainsKey("items") Then
			jRoot = NewColjRoot.Get("items")
		End If
			
		For Each coljRoot As Map In jRoot
			
			Dim NewRow As Map
			NewRow.Initialize
			For Each k As String In coljRoot.Keys
				If coljRoot.Get(k) Is Map Then
					Dim JoinMap As Map = coljRoot.Get(k)
					For Each join As String In JoinMap.Keys
						If FirstTime = True Then DatabaseResult.Columns.Put(k & "." & join,"")
						NewRow.Put(k & "." & join,JoinMap.Get(join))
					Next
				else if  coljRoot.Get(k) Is List Then
					If FirstTime = True Then DatabaseResult.Columns.Put(k,"")
					Dim gen As JSONGenerator
					gen.Initialize2(coljRoot.Get(k))
					NewRow.Put(k,gen.ToString)
				Else
					If FirstTime = True Then DatabaseResult.Columns.Put(k,"")
					NewRow.Put(k,coljRoot.Get(k))
				End If
				
			Next

			DatabaseResult.Rows.Add(NewRow)
				
			FirstTime = False
		Next
	
	End If
	
	Return DatabaseResult
	
End Sub

PRivate Sub UnReadOnlyMap(sourceMap As Map) As Map
	' copy a map to a new map to make it IsReadOnly = False
	#If B4I
	If sourceMap.IsReadOnly = False Then Return sourceMap	
	' the map is readonly, convert it
	Dim newMap As Map
	newMap.Initialize
	' copy each map item
	For Each key As String In sourceMap.Keys
		Dim val As Object = sourceMap.Get(key)
		newMap.Put(key,val)
	Next
	Return newMap
	#Else
	Return sourceMap
	#End If
End Sub

#Region Errors
'code: 400
Public Sub getErrorCode(root As Map) As Int
	If root.ContainsKey("error") Then
		Dim error As Map = root.Get("error")
		Return error.Get("code")
	End If
	Return ""
End Sub

'message: EMAIL_NOT_FOUND
Public Sub getErrorMessage(root As Map) As String
	If root.ContainsKey("error") Then
		Dim error As Map = root.Get("error")
		Return error.Get("message")
	End If
	Return ""
End Sub

'reason: invalid
'domain: global
'message: EMAIL_NOT_FOUND
Public Sub getErrorMap(root As Map) As Map
	Dim error As Map = root.Get("error")
	Dim errors As List = error.Get("errors")
	Dim tmp_result As Map : tmp_result.Initialize
	
	For Each colerrors As Map In errors
		tmp_result = CreateMap("reason":colerrors.Get("reason"),"domain":colerrors.Get("domain"),"message":colerrors.Get("message"))
	Next
	Return tmp_result
End Sub

#End Region
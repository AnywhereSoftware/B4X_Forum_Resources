B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
' Class: QuickCurl
Sub Class_Globals
	Private xui As XUI
	Private DebugMode As Boolean
    
	Type CurlParsed (Method As String, URL As String, Headers As Map, Body As String, IsMultipart As Boolean, MultipartFields As Map, IsJsonPayload As Boolean)
End Sub

Public Sub Initialize
	DebugMode = False
End Sub

Public Sub SetDebug(OnOff As Boolean)
	DebugMode = OnOff
End Sub

Sub Execute(CurlRaw As String, TimeoutSeconds As Int) As ResumableSub
	Dim cp As CurlParsed = ParseCurl(CurlRaw)
	Dim FinalResult As Map = CreateMap("success": False, "type": cp.Method, "status": 0, "response": "", "is_json": False, "data": Null, "flat_json": Null, "error": "")

	' Usamos DebugMode para evitar el Warning y dar feedback
	If DebugMode Then
		Log("--- QuickCurl Request ---")
		Log("URL: " & cp.URL)
		Log("Method: " & cp.Method)
	End If

	If cp.URL = "" Then
		FinalResult.Put("error", "URL not found in curl")
		Return FinalResult
	End If

	Dim job As HttpJob
	job.Initialize("", Me)
	
	' Lógica de ejecución según el tipo de parseo
	If cp.IsMultipart Then
		job.PostMultipart(cp.URL, cp.MultipartFields, Null)
	Else
		Select cp.Method
			Case "POST"
				job.PostString(cp.URL, cp.Body)
			Case "PUT"
				job.PutString(cp.URL, cp.Body)
			Case "DELETE"
				job.Delete(cp.URL)
			Case Else
				job.Download(cp.URL)
		End Select
	End If

	' Aplicamos el Timeout (Convertido a milisegundos)
	job.GetRequest.Timeout = TimeoutSeconds * 1000

	' Aplicar Headers
	For Each k As String In cp.Headers.Keys
		job.GetRequest.SetHeader(k, cp.Headers.Get(k))
	Next
    
	If cp.IsJsonPayload Then
		job.GetRequest.SetContentType("application/json")
	End If

	Wait For (job) JobDone(j As HttpJob)

	FinalResult.Put("success", j.Success)
	If j.Success Then
		FinalResult.Put("status", j.Response.StatusCode)
		Dim res As String = j.GetString
		FinalResult.Put("response", res)
		
		Dim trimmed As String = res.Trim
		If trimmed.StartsWith("{") Or trimmed.StartsWith("[") Then
			Try
				Dim jp As JSONParser
				jp.Initialize(res)
				
				' Reemplazamos el IIf que daba error por un If estándar
				Dim jsonObj As Object
				If trimmed.StartsWith("{") Then
					jsonObj = jp.NextObject
				Else
					jsonObj = jp.NextArray
				End If
				
				FinalResult.Put("is_json", True)
				FinalResult.Put("data", jsonObj)
				FinalResult.Put("flat_json", FlattenJson(jsonObj, ""))
			Catch
				Log("Error parseando JSON: " & LastException.Message)
			End Try
		End If
	Else
		FinalResult.Put("error", j.ErrorMessage)
	End If
	
	job.Release
	Return FinalResult
End Sub

Public Sub ExportB4X(CurlRaw As String) As String
	Dim cp As CurlParsed = ParseCurl(CurlRaw)
	Dim sb As StringBuilder : sb.Initialize
	
	If cp.URL = "" Then Return "'ERROR: URL no encontrada"

	sb.Append("'==============================" & CRLF)
	sb.Append("' QuickCurl 3.3 – Código B4X Limpio" & CRLF)
	sb.Append("'==============================" & CRLF)
	sb.Append("Dim url As String = """ & cp.URL & """" & CRLF)
	
	' Si hay body y no es multipart, lo preparamos en un Smart String
	If cp.Method <> "GET" And cp.IsMultipart = False And cp.Body <> "" Then
		sb.Append("Dim payload As String = $""" & cp.Body & """$" & CRLF)
	End If

	sb.Append("Dim job As HttpJob" & CRLF)
	sb.Append("job.Initialize("""", Me)" & CRLF)

	If cp.IsMultipart Then
		sb.Append("Dim multipartData As Map : multipartData.Initialize" & CRLF)
		For Each k As String In cp.MultipartFields.Keys
			sb.Append("multipartData.Put(""" & k & """, """ & cp.MultipartFields.Get(k) & """)" & CRLF)
		Next
		sb.Append("job.PostMultipart(url, multipartData, Null)" & CRLF)
	Else
		Select cp.Method
			Case "POST" : sb.Append("job.PostString(url, payload)" & CRLF)
			Case "PUT"  : sb.Append("job.PutString(url, payload)" & CRLF)
			Case "DELETE": sb.Append("job.Delete(url)" & CRLF)
			Case Else   : sb.Append("job.Download(url)" & CRLF)
		End Select
	End If
	
	If cp.IsJsonPayload Then
		sb.Append("job.GetRequest.SetContentType(""application/json"")" & CRLF)
	End If
	
	For Each k As String In cp.Headers.Keys
		If k.ToLowerCase <> "content-type" Then
			sb.Append("job.GetRequest.SetHeader(""" & k & """, """ & cp.Headers.Get(k) & """)" & CRLF)
		End If
	Next
	
	sb.Append(CRLF & "Wait For (job) JobDone(j As HttpJob)" & CRLF)
	sb.Append("If j.Success Then" & CRLF)
	sb.Append("    Log(""✅ Éxito: "" & j.GetString)" & CRLF)
	sb.Append("Else" & CRLF)
	sb.Append("    Log(""❌ Error: "" & j.ErrorMessage)" & CRLF)
	sb.Append("End If" & CRLF)
	sb.Append("job.Release" & CRLF)
	sb.Append("'==============================" & CRLF)
	
	Return sb.ToString
End Sub

Private Sub ParseCurl(CurlRaw As String) As CurlParsed
	Dim cp As CurlParsed
	cp.Initialize
	cp.Headers.Initialize
	cp.MultipartFields.Initialize
	cp.Method = "GET" : cp.Body = "" : cp.URL = "" : cp.IsMultipart = False : cp.IsJsonPayload = False
	
	Dim clean As String = CurlRaw.Replace("\" & Chr(10), " ").Replace("\" & Chr(13), " ").Replace(Chr(10), " ").Replace(Chr(13), " ")
	
	' URL
	Dim mUrl As Matcher = Regex.Matcher("(?i)https?://[^'""\s]+", clean)
	If mUrl.Find Then cp.URL = mUrl.Group(0)
	
	' Method
	Dim mMethod As Matcher = Regex.Matcher("(?i)-X\s+(['""]?)([A-Z]+)\1", clean)
	If mMethod.Find Then cp.Method = mMethod.Group(2).ToUpperCase

	' Body
	Dim mData As Matcher = Regex.Matcher("(?i)(?:--data|--data-raw|-d)\s+(['""])(.*?)\1", clean)
	If mData.Find Then
		cp.Body = mData.Group(2)
		If cp.Method = "GET" Then cp.Method = "POST"
	End If

	' Multipart
	Dim mForm As Matcher = Regex.Matcher("(?i)--form\s+(['""]?)([^='""]+)=([^'""]+)\1", clean)
	Do While mForm.Find
		cp.IsMultipart = True
		cp.MultipartFields.Put(mForm.Group(2), mForm.Group(3))
		cp.Method = "POST"
	Loop

	' Headers
	Dim mHead As Matcher = Regex.Matcher("(?i)-H\s+(['""])(.*?)\1", clean)
	Do While mHead.Find
		Dim h As String = mHead.Group(2)
		If h.Contains(":") Then
			Dim k As String = h.SubString2(0, h.IndexOf(":")).Trim
			Dim v As String = h.SubString(h.IndexOf(":") + 1).Trim
			cp.Headers.Put(k, v)
			If k.ToLowerCase = "content-type" And v.ToLowerCase.Contains("application/json") Then cp.IsJsonPayload = True
		End If
	Loop
	
	Return cp
End Sub

Private Sub FlattenJson(JsonData As Object, Prefix As String) As List
	Dim result As List : result.Initialize
	If JsonData Is Map Then
		Dim m As Map = JsonData
		For Each k As String In m.Keys
			Dim v As Object = m.Get(k)
			If v Is Map Or v Is List Then
				Dim temp As List = FlattenJson(v, Prefix & k & ".")
				For Each t As Object In temp : result.Add(t) : Next
				Else
					result.Add(Prefix & k & ": " & v)
				End If
			Next
		Else If JsonData Is List Then
			Dim l As List = JsonData
			For i = 0 To l.Size - 1
				Dim v As Object = l.Get(i)
				If v Is Map Or v Is List Then
					Dim temp As List = FlattenJson(v, Prefix & i & ".")
					For Each t As Object In temp : result.Add(t) : Next
					Else
						result.Add(Prefix & i & ": " & v)
					End If
				Next
			End If
			Return result
		End Sub
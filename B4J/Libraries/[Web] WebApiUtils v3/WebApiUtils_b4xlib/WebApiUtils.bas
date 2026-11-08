B4J=true
Group=Classes
ModulesStructureVersion=1
Type=StaticCode
Version=10
@EndOfDesignText@
' Web API Utility
' Version 3.05
Sub Process_Globals
	Private Const CONTENT_TYPE_HTML As String = "text/html"
	Private Const CONTENT_TYPE_JSON As String = "application/json"
	'Private Const CONTENT_TYPE_XML As String = "application/xml"
	Type HttpResponseContent (ResponseBody As String)
	Type HttpResponseMessage (ResponseCode As Int, ResponseString As String, ResponseData As List, ResponseObject As Map, ResponseMessage As String, ResponseError As Object, ResponseType As String, ContentType As String, SimpleResponse As SimpleResponse)
	Type SimpleResponse (Enable As Boolean, Format As String, DataKey As String)
End Sub

Public Sub CheckMaxElements (Elements() As String, Max_Elements As Int) As Boolean
	If Elements.Length > Max_Elements Or Elements.Length = 0 Then
		Return False
	End If
	Return True
End Sub

Public Sub CheckAllowedVerb (SupportedMethods As List, Method As String) As Boolean
	'Methods: POST, GET, PUT, PATCH, DELETE
	If SupportedMethods.IndexOf(Method) = -1 Then
		Return False
	End If
	Return True
End Sub

Public Sub CheckInteger (Value As Object) As Boolean
	Try
		Return Value > -1
	Catch
		'Log(LastException.Message)
		Return False
	End Try
End Sub

Public Sub GetApiPathElements (Path As String) As String()
	Dim element() As String = Regex.Split("\/", Path)
	Return element
End Sub

Public Sub GetUriElements (Uri As String) As String()
	Dim element() As String = Regex.Split("\/", Uri)
	Return element
End Sub

' Use the following code sample if your API URL pattern looks like this:
' Web = /products
' Api = /api/products
' <code>Elements = WebApiUtils.CropElements(FullElements, 2) ' for Web handler</code>
' <code>Elements = WebApiUtils.CropElements(FullElements, 3) ' for Api handler</code>
Public Sub CropElements (FullElements() As String, StartingElementIndex As Int) As String()
	If StartingElementIndex > FullElements.Length Then
		StartingElementIndex = FullElements.Length
	End If
	Dim TempList As List
	TempList.Initialize
	For n = StartingElementIndex To FullElements.Length - 1
		TempList.Add(FullElements(n))
	Next
	Dim NewArray(TempList.Size) As String
	For n = 0 To NewArray.Length - 1
		NewArray(n) = TempList.Get(n)
	Next
	Return NewArray
End Sub

Public Sub BuildHtml (strHTML As String, Settings As Map) As String
	' Replace $KEY$ tag with new content from Map
	strHTML = ReplaceMap(strHTML, Settings)
	Return strHTML
End Sub

Public Sub BuildView (strHTML As String, View As String) As String
	' Replace @VIEW@ tag with new content
	strHTML = strHTML.Replace("@VIEW@", View)
	Return strHTML
End Sub

Public Sub BuildCsrfToken (strHTML As String, Content As String) As String
	' Replace meta name="csrf-token" tag with new content
	Dim strMetaTag As String = $"<meta name="csrf-token" content="${Content}">"$
	strHTML = strHTML.Replace($"<meta name="csrf-token" content="">"$, strMetaTag)
	Return strHTML
End Sub

Public Sub BuildTag (strHTML As String, Key As String, Value As String) As String
	' Replace @KEY@ keyword with new content
	strHTML = strHTML.Replace("@" & Key & "@", Value)
	Return strHTML
End Sub

Public Sub BuildDocView (strHTML As String, View As String) As String
	' Replace @DOCVIEW@ tag with new content
	strHTML = strHTML.Replace("@DOCVIEW@", View)
	Return strHTML
End Sub

Public Sub BuildScript (strHTML As String, Script As String) As String
	' Replace @SCRIPT@ tag with new content
	strHTML = strHTML.Replace("@SCRIPT@", Script)
	Return strHTML
End Sub

' Insert inline JavaScript
Public Sub BuildScript2 (strHTML As String, Script As String, Settings As Map) As String
	' Replace @SCRIPT@ tag with new content
	Dim strScript As String = $"	<script type="text/javascript">
		${Script}
	</script>"$
	strScript = BuildHtml(strScript, Settings)
	strHTML = strHTML.Replace("@SCRIPT@", strScript)
	Return strHTML
End Sub

Public Sub ReadMapFile (FileDir As String, FileName As String) As Map
	Dim strPath As String = File.Combine(FileDir, FileName)
	Log($"Reading file (${strPath})..."$)
	Return File.ReadMap(FileDir, FileName)
End Sub

Public Sub ReadTextFile (FileName As String) As String
	Return File.ReadString(File.DirAssets, FileName)
End Sub

Public Sub WriteTextFile (FileName As String, Contents As String)
	File.WriteString(File.DirApp, FileName, Contents)
End Sub

Public Sub WriteAssetFile (FileName As String, Contents As String)
	File.WriteString(File.Combine(File.DirApp, "www"), FileName, Contents)
End Sub

Public Sub DeleteAssetFile (FileName As String)
	File.Delete(File.Combine(File.DirApp, "www"), FileName)
End Sub

Public Sub AssetFileExist (FileName As String) As Boolean
	Return File.Exists(File.Combine(File.DirApp, "www"), FileName)
End Sub

Public Sub Map2Json (M As Map) As String
	Return M.As(JSON).ToString
End Sub

Public Sub List2Json (L As List) As String
	Return L.As(JSON).ToString
End Sub

Public Sub Object2Json (O As Object) As String
	Return O.As(JSON).ToString
End Sub

Public Sub GetCurrentTimezone As String
	Dim CurrentTimezone As Double = DateTime.GetTimeZoneOffsetAt(DateTime.Now)
	Return CurrentTimezone
End Sub

Public Sub CurrentDateTime As String
	Dim CurrentDateFormat As String = DateTime.DateFormat
	DateTime.DateFormat = "yyyy-MM-dd HH:mm:ss"
	DateTime.SetTimeZone(0)
	Dim Current As String = DateTime.Date(DateTime.Now)
	DateTime.DateFormat = CurrentDateFormat
	Return Current
End Sub

Public Sub FileNameByCurrentDateTime As String
	Dim CurrentDateFormat As String = DateTime.DateFormat
	DateTime.DateFormat = "yyyyMMddHHmmss"
	DateTime.SetTimeZone(0)
	Dim Current As String = DateTime.Date(DateTime.Now)
	DateTime.DateFormat = CurrentDateFormat
	Return Current
End Sub

' Read Request Cookie As Map
Public Sub RequestCookie (req As ServletRequest) As Map
	Dim Munchies() As Cookie = req.GetCookies
	Dim M As Map
	M.Initialize
	For Each bite As Cookie In Munchies
		M.Put(bite.Name, bite.Value)
	Next
	Return M
End Sub

' Tip about POST requests: if you want to get a URL parameter (req.GetParameter)
' then do it only after reading the payload, otherwise the payload will be searched
' for the parameter and will be lost.
Public Sub RequestData (Request As ServletRequest) As Map
	Dim data As Map
	Dim inp As InputStream = Request.InputStream
	If inp.BytesAvailable <= 0 Then
		Return data
	End If
	Dim buffer() As Byte = Bit.InputStreamToBytes(inp)
	Dim str As String = BytesToString(buffer, 0, buffer.Length, "UTF-8")
	data = str.As(JSON).ToMap
	Return data
End Sub

Public Sub RequestDataXml (Request As ServletRequest) As Map
	Dim data As Map
	Dim inp As InputStream = Request.InputStream
	If inp.BytesAvailable <= 0 Then
		Return data
	End If
	Dim buffer() As Byte = Bit.InputStreamToBytes(inp)
	Dim str As String = BytesToString(buffer, 0, buffer.Length, "UTF-8")
	str = LinearizeXML(str)
	
	Dim xm As Xml2Map
	xm.Initialize
	xm.StripNamespaces = True
	data = xm.Parse(str)
	Return data
End Sub

' Remove comments, line breaks, tabs and spaces
Public Sub LinearizeXML (Text As String) As String
	Text = Regex.Replace("<!--[\s\S]*?-->", Text, "")
	Return Regex.Replace("\s+", Text, " ").Trim
End Sub

Public Sub RequestMultiPart (Request As ServletRequest, Folder As String, MaxSize As Long) As Part
	Dim part As Part
	Dim config As JavaObject
	config.InitializeNewInstance("jakarta.servlet.MultipartConfigElement", Array(Folder, MaxSize, MaxSize, 81920))
	Dim f As JavaObject
	f.InitializeNewInstance("java.io.File", Array(Folder))
	Dim parser As JavaObject
	parser.InitializeNewInstance("org.eclipse.jetty.server.MultiPartFormInputStream", Array(Request.InputStream, Request.ContentType, config, f))
	Dim parts As JavaObject = parser.RunMethod("getParts", Null)
	Dim result() As Object = parts.RunMethod("toArray", Null)
	Dim list As List = result
	If list.Size > 0 Then
		part = list.Get(0)
	End If
	Return part
End Sub

Public Sub RequestMultipartList (Request As ServletRequest, Folder As String, MaxSize As Long) As List
	Dim config As JavaObject
	'config.InitializeNewInstance("javax.servlet.MultipartConfigElement", Array(Folder, MaxSize, MaxSize, 81920))
	config.InitializeNewInstance("jakarta.servlet.MultipartConfigElement", Array(Folder, MaxSize, MaxSize, 81920))
	Dim f As JavaObject
	f.InitializeNewInstance("java.io.File", Array(Folder))
	Dim parser As JavaObject
	'parser.InitializeNewInstance("org.eclipse.jetty.util.MultiPartInputStreamParser", Array(Request.InputStream, Request.ContentType, config, f))
	parser.InitializeNewInstance("org.eclipse.jetty.server.MultiPartFormInputStream", Array(Request.InputStream, Request.ContentType, config, f))
	Dim parts As JavaObject = parser.RunMethod("getParts", Null)
	Dim result() As Object = parts.RunMethod("toArray", Null)
	Return result
End Sub

Public Sub RequestMultipartData (Request As ServletRequest, Folder As String, MaxSize As Long) As Map
	Try
		Dim data As Map = Request.GetMultipartData(Folder, MaxSize)
		For Each key As String In data.Keys
			Dim part As Part = data.Get(key)
			Dim name As String = part.SubmittedFilename 'data.Get("fn")
			Dim temp As String = File.GetName(part.TempFile)
			If key.StartsWith("post-") Then
				If File.Exists(Folder, name) Then File.Delete(Folder, name)
				Dim inp As InputStream = File.OpenInput(Folder, temp)
				Dim out As OutputStream = File.OpenOutput(Folder, name, False)
				File.Copy2(inp, out)
				out.Close
			End If
			If key.StartsWith("json") Then
				Dim ins As InputStream = File.OpenInput(Folder, temp)
				Dim buffer() As Byte = Bit.InputStreamToBytes(ins)
				Dim str As String = BytesToString(buffer, 0, buffer.Length, "UTF-8")
				data = str.As(JSON).ToMap
			End If
			If File.Exists(Folder, name) Then File.Delete(Folder, temp) ' Delete temp file if new file generated
		Next
	Catch
		LogError(LastException.Message)
	End Try
	Return data
End Sub

Public Sub RequestBasicAuth (Auths As List) As Map
	Dim client As Map = CreateMap("CLIENT_ID": "", "CLIENT_SECRET": "")
	If Auths.Size > 0 Then
		Dim auth As String = Auths.Get(0)
		If auth.StartsWith("Basic") Then
			Dim b64 As String = auth.SubString("Basic ".Length)
			Dim su As StringUtils
			Dim ab() As Byte = su.DecodeBase64(b64)
			Dim str As String = BytesToString(ab, 0, ab.Length, "utf8")
			Dim UsernameAndPassword() As String = Regex.Split(":", str)
			If UsernameAndPassword.Length = 2 Then
				client.Put("CLIENT_ID", UsernameAndPassword(0))
				client.Put("CLIENT_SECRET", UsernameAndPassword(1))
			End If
		End If
	End If
	Return client
End Sub

Public Sub EncodeBase64 (data() As Byte) As String
	Dim su As StringUtils
	Return su.EncodeBase64(data)
End Sub

Public Sub DecodeBase64 (str As String) As Byte()
	Dim su As StringUtils
	Return su.DecodeBase64(str)
End Sub

Public Sub EncodeURL (str As String) As String
	Dim su As StringUtils
	Return su.EncodeUrl(str, "UTF8")
End Sub

Public Sub DecodeURL (str As String) As String
	Dim su As StringUtils
	Return su.DecodeUrl(str, "UTF8")
End Sub

' Get Access Token from Header
Public Sub RequestAccessToken (req As ServletRequest) As String
	Dim token As String
	Dim auths As List = req.GetHeaders("Authorization")
	If auths.Size > 0 Then
		token = auths.Get(0)
	End If
	Return token
End Sub

Public Sub RequestBearerToken (req As ServletRequest) As String
	Dim Auths As List = req.GetHeaders("Authorization")
	If Auths.Size > 0 Then
		Dim auth As String = Auths.Get(0)
		If auth.StartsWith("Bearer") And auth.Length > "Bearer ".Length Then
			Return auth.SubString("Bearer ".Length)
		End If
	End If
	Return ""
End Sub

Public Sub RequestApiKey (req As ServletRequest) As String
	Dim Auths As List = req.GetHeaders("X-API-Key")
	If Auths.Size > 0 Then
		Return Auths.Get(0)
	End If
	Return ""
End Sub

' max_age = number of seconds the cookie is valid, 0 to expire immediately
Public Sub ReturnCookie (key As String, value As String, max_age As Int, http_only As Boolean, resp As ServletResponse)
	Dim session_cookie As Cookie
	session_cookie.Initialize(key, value)
	session_cookie.HttpOnly = http_only
	session_cookie.MaxAge = max_age
	'resp.SetHeader(key, session_cookie.Value & "; SameSite=Lax")
	resp.AddCookie(session_cookie)
End Sub

Public Sub ReturnLocation (Location As String, resp As ServletResponse) ' Code = 302
	resp.SendRedirect(Location)
End Sub

Public Sub ReturnConnect (mess As HttpResponseMessage, resp As ServletResponse)
	Dim Data As List
	Data.Initialize
	mess.ResponseCode = 200
	mess.ResponseObject = CreateMap("connect": True)
	ReturnHttpResponse(mess, resp)
End Sub

Public Sub ReturnConnect2 (mess As HttpResponseMessage, resp As ServletResponse)
	Dim Data As List
	Data.Initialize
	Data.Add(CreateMap("connect": True))
	mess.ResponseCode = 200
	mess.ResponseData = Data
	ReturnHttpResponse(mess, resp)
End Sub

Public Sub ReturnError (mess As HttpResponseMessage, resp As ServletResponse, Code As Int, Error As String)
	If Code = 0 Then Code = 400
	If Error = "" Then Error = "Bad Request"
	mess.ResponseCode = Code
	mess.ResponseError = Error
	mess.ResponseString = "error"
	ReturnHttpResponse(mess, resp)
End Sub

Public Sub ReturnSuccess (mess As HttpResponseMessage, resp As ServletResponse, Code As Int, Data As Map)
	If Code = 0 Then Code = 200
	If Data.IsInitialized = False Then Data.Initialize
	mess.ResponseCode = Code
	mess.ResponseObject = Data
	mess.ResponseString = "ok"
	ReturnHttpResponse(mess, resp)
End Sub

Public Sub ReturnSuccess2 (mess As HttpResponseMessage, resp As ServletResponse, Code As Int, Data As List)
	If Code = 0 Then Code = 200
	If Data.IsInitialized = False Then Data.Initialize
	mess.ResponseCode = Code
	mess.ResponseData = Data
	mess.ResponseString = "ok"
	ReturnHttpResponse(mess, resp)
End Sub

Public Sub ReturnBadRequest (mess As HttpResponseMessage, resp As ServletResponse)
	mess.ResponseCode = 400
	ReturnHttpResponse(mess, resp)
End Sub

Public Sub ReturnAuthorizationRequired (mess As HttpResponseMessage, resp As ServletResponse)
	mess.ResponseCode = 401
	mess.ResponseError = "Authentication required"
	ReturnHttpResponse(mess, resp)
End Sub

Public Sub ReturnTokenExpired (mess As HttpResponseMessage, resp As ServletResponse)
	mess.ResponseCode = 401
	mess.ResponseError = "Token Expired"
	ReturnHttpResponse(mess, resp)
End Sub

Public Sub ReturnMethodNotAllow (mess As HttpResponseMessage, resp As ServletResponse)
	mess.ResponseCode = 405
	mess.ResponseError = "Method Not Allowed"
	ReturnHttpResponse(mess, resp)
End Sub

Public Sub ReturnErrorUnprocessableEntity (mess As HttpResponseMessage, resp As ServletResponse)
	mess.ResponseCode = 422
	mess.ResponseError = "Unprocessable Entity"
	ReturnHttpResponse(mess, resp)
End Sub

Public Sub ReturnErrorCredentialNotProvided (mess As HttpResponseMessage, resp As ServletResponse)
	mess.ResponseCode = 400
	mess.ResponseError = "Credential Not Provided"
	ReturnHttpResponse(mess, resp)
End Sub

Public Sub ReturnErrorExecuteQuery (mess As HttpResponseMessage, resp As ServletResponse)
	mess.ResponseCode = 422
	mess.ResponseError = "Execute Query"
	ReturnHttpResponse(mess, resp)
End Sub

' Remember to add the following code when initialize a Controller <code>
' HRM.Initialize
' HRM.SimpleResponse = Main.SimpleResponse</code>
Public Sub ReturnHttpResponse (mess As HttpResponseMessage, resp As ServletResponse)
	' ==============================
	' SimpleResponse.Enable = False
	' ==============================
	' {
	'  "m": "Success",
	'  "e": Null,
	'  "s": "ok",
	'  "r": [ { "connect": "true" } ]
	'  "a": 200
	' }
	' =============================
	' SimpleResponse.Enable = True
	' =============================
	' Format: Auto
	' {
	'  "connect": "true"
	' }
	'
	' Format = List
	' [
	'  {
	'   "connect": "true"
	'  }
	' ]
	'
	' Format = Map
	' {
	'  "data": [
	'    {
	'     "connect": "true"
	'    }
	'  ]
	' }
	If mess.ResponseCode >= 200 And mess.ResponseCode < 300 Then ' SUCCESS
		If mess.ResponseType = "" Then mess.ResponseType = "SUCCESS"
		If mess.ResponseString = "" Then mess.ResponseString = "ok"
		If mess.ResponseMessage = "" Then mess.ResponseMessage = "Success"
		mess.ResponseError = Null
	Else ' ERROR
		If mess.ResponseCode = 0 Then mess.ResponseCode = 400
		If mess.ResponseType = "" Then mess.ResponseType = "ERROR"
		If mess.ResponseString = "" Then mess.ResponseString = "error"
		'If mess.ResponseMessage = "" Then mess.ResponseMessage = "Bad Request"
		'mess.ResponseMessage = "" 'Null
		If mess.ResponseError.As(String).StartsWith("java.lang.Object") Then
			mess.ResponseError = "Bad Request"
			If mess.ResponseCode = 404 Then mess.ResponseError = "Not Found"
			If mess.ResponseCode = 405 Then mess.ResponseError = "Method Not Allowed"
			If mess.ResponseCode = 422 Then mess.ResponseError = "Unprocessable Entity"
			'If mess.ResponseError = "" Then mess.ResponseError = "Bad Request"
		End If
	End If
	If mess.ContentType = "" Then mess.ContentType = CONTENT_TYPE_JSON
	resp.ContentType = mess.ContentType
	
	If mess.SimpleResponse.Enable Then
		resp.Status = mess.ResponseCode
	Else
		' Override Status Code
		If mess.ResponseCode < 200 Or mess.ResponseCode > 299 Then
			resp.Status = 200
		Else
			resp.Status = mess.ResponseCode
		End If
	End If

	If mess.SimpleResponse.Enable Then
		Select mess.SimpleResponse.Format
			Case "List"
				' force List format
				If mess.ResponseData.IsInitialized = False Then
					' Initialize an empty list
					mess.ResponseData.Initialize
					If mess.ResponseObject.IsInitialized Then
						' Add object to List
						If mess.ResponseObject.Size > 0 Then mess.ResponseData.Add(mess.ResponseObject)
					Else
						mess.ResponseObject.Initialize
					End If
				End If
				resp.Write(mess.ResponseData.As(JSON).ToString)
			Case "Map"
				' force Map format with "data" as key
				If mess.ResponseObject.IsInitialized = False Then
					' Initialize an empty map
					mess.ResponseObject.Initialize
					If mess.ResponseData.IsInitialized = False Then
						' Initialize an empty list
						mess.ResponseData.Initialize
					End If
					' Add object to Map
					If mess.SimpleResponse.DataKey = Null Or mess.SimpleResponse.DataKey = "" Then
						mess.ResponseObject.Put("data", mess.ResponseData)
					Else
						mess.ResponseObject.Put(mess.SimpleResponse.DataKey, mess.ResponseData)
					End If
				End If
				resp.Write(mess.ResponseObject.As(JSON).ToString)
			Case Else ' "Auto" or other value
				' Depends on which object is initialized
				If mess.ResponseObject.IsInitialized Then
					resp.Write(mess.ResponseObject.As(JSON).ToString)
				Else If mess.ResponseData.IsInitialized Then
					resp.Write(mess.ResponseData.As(JSON).ToString)
				Else
					' Default to an initialized List
					'mess.ResponseData.Initialize
					'resp.Write(mess.ResponseData.As(JSON).ToString)
					' or
					' Default to an initialized Map
					mess.ResponseObject.Initialize
					Select mess.ResponseType.ToUpperCase
						Case "SUCCESS"
							mess.ResponseObject.Put("message", mess.ResponseMessage)
						Case "ERROR", "FAILED"
							mess.ResponseObject.Put("error", mess.ResponseError)
					End Select
					resp.Write(mess.ResponseObject.As(JSON).ToString)
				End If
		End Select
	Else
		If Not(mess.ResponseData.IsInitialized) Then
			mess.ResponseData.Initialize
			If mess.ResponseObject.IsInitialized Then
				' Do not add an empty map
				If mess.ResponseObject.Size > 0 Then mess.ResponseData.Add(mess.ResponseObject)
			End If
		End If
		Dim Map1 As Map = CreateMap("s": mess.ResponseString, "a": mess.ResponseCode, "r": mess.ResponseData, "m": mess.ResponseMessage, "e": mess.ResponseError)
		resp.Write(Map2Json(Map1))
	End If
End Sub

Public Sub ReturnHtml (str As String, resp As ServletResponse)
	resp.ContentType = CONTENT_TYPE_HTML
	resp.Write(str)
End Sub

Public Sub ReturnHtmlBody (cont As HttpResponseContent, resp As ServletResponse)
	resp.ContentType = CONTENT_TYPE_HTML
	resp.Write(cont.ResponseBody)
End Sub

Public Sub ReturnHtmlPageNotFound (resp As ServletResponse)
	Dim str As String = $"<h1>404 Page Not Found</h1>"$
	ReturnHtml(str, resp)
End Sub

Public Sub ReturnHtmlBadRequest (resp As ServletResponse)
	Dim str As String = $"<h1>400 Bad Request</h1>"$
	ReturnHtml(str, resp)
End Sub

Public Sub ReturnHtmlMethodNotAllowed (resp As ServletResponse)
	Dim str As String = $"<h1>405 Method Not Allowed</h1>"$
	ReturnHtml(str, resp)
End Sub

' // Source: http://www.b4x.com/android/forum/threads/validate-a-correctly-formatted-email-address.39803/
Public Sub Validate_Email (EmailAddress As String) As Boolean
	Dim MatchEmail As Matcher = Regex.Matcher("^(?i)[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])$", EmailAddress)
 
	If MatchEmail.Find = True Then
		'Log(MatchEmail.Match)
		Return True
	Else
		'Log("Oops, please double check your email address...")
		Return False
	End If
End Sub

' Check anti csrf-token variable sent from client in request header is same as variable stored in server session  
Public Sub ValidateCsrfToken (session_name As String, header_name As String, req As ServletRequest) As Boolean
	Dim headers As List = req.GetHeaders(header_name)
	If req.GetSession.GetAttribute2(session_name, "").As(String).EqualsIgnoreCase(headers.Get(0)) Then
		'Log("matched")
		Return True
	Else
		'Log("unmatched!")
		Return False
	End If
End Sub

Public Sub GUID As String
	Dim sb As StringBuilder
	sb.Initialize
	For Each stp As Int In Array(8, 4, 4, 4, 12)
		If sb.Length > 0 Then sb.Append("-")
		For n = 1 To stp
			Dim c As Int = Rnd(0, 16)
			If c < 10 Then c = c + 48 Else c = c + 55
			sb.Append(Chr(c))
		Next
	Next
	Return sb.ToString
End Sub

' It is not recommended to use this method
Public Sub Slugify (str As String) As String
	str = str.ToLowerCase.Trim
	'str = Regex.Replace("/[^\w\s-]/g", str, "")
	'str = Regex.Replace("/[\s_-]+/g", str, "-")
	'str = Regex.Replace("/^-+|-+$/g", str, "")
	str = str.Replace($"~"$, "")
	str = str.Replace($"`"$, "")
	str = str.Replace($"!"$, "")
	str = str.Replace($"@"$, "")
	str = str.Replace($"#"$, "")
	str = str.Replace($"$"$, "")
	str = str.Replace($"%"$, "")
	str = str.Replace($"^"$, "")
	str = str.Replace($"&"$, "")
	str = str.Replace($"*"$, "")
	str = str.Replace($"("$, "")
	str = str.Replace($")"$, "")
	str = str.Replace($"-"$, "")
	str = str.Replace($"+"$, "")
	str = str.Replace($"_"$, "")
	str = str.Replace($"="$, "")
	str = str.Replace($"{"$, "")
	str = str.Replace($"}"$, "")
	str = str.Replace($"["$, "")
	str = str.Replace($"]"$, "")
	str = str.Replace($"|"$, "")
	str = str.Replace($"\"$, "")
	str = str.Replace($":"$, "")
	str = str.Replace($";"$, "")
	str = str.Replace($"""$, "")
	str = str.Replace($"'"$, "")
	str = str.Replace($"<"$, "")
	str = str.Replace($">"$, "")
	str = str.Replace($","$, "")
	str = str.Replace($"."$, "")
	str = str.Replace($"?"$, "")
	str = str.Replace($"/"$, "")
	str = str.Replace(CRLF, "")
	str = str.Replace(TAB, "")
	str = str.Replace(" ", "-")
	Return str
End Sub

Public Sub ProperCase (Word As String) As String
	If Word.Length = 0 Then Return ""
	If Word.Length = 1 Then Return Word.ToUpperCase
	Return Word.CharAt(0).As(String).ToUpperCase & Word.SubString(1)
End Sub

' ===================================================================
' Taken from WebUtils
' ===================================================================
Public Sub ReplaceMap(Base As String, Replacements As Map) As String
	Dim pattern As StringBuilder
	pattern.Initialize
	For Each k As String In Replacements.Keys
		If pattern.Length > 0 Then pattern.Append("|")
		pattern.Append("\$").Append(k).Append("\$")
	Next
	Dim m As Matcher = Regex.Matcher(pattern.ToString, Base)
	Dim result As StringBuilder
	result.Initialize
	Dim lastIndex As Int
	Do While m.Find
		result.Append(Base.SubString2(lastIndex, m.GetStart(0)))
		Dim replace As String = Replacements.Get(m.Match.SubString2(1, m.Match.Length - 1))
		If m.Match.ToLowerCase.StartsWith("$h_") Then replace = EscapeHtml(replace)
		result.Append(replace)
		lastIndex = m.GetEnd(0)
	Loop
	If lastIndex < Base.Length Then result.Append(Base.SubString(lastIndex))
	Return result.ToString
End Sub

Public Sub EscapeHtml (Value As String) As String
	Dim sb As StringBuilder
	sb.Initialize
	For n = 0 To Value.Length - 1
		Dim c As Char = Value.CharAt(n)
		Select c
			Case QUOTE
				sb.Append("&quot;")
			Case "'"
				sb.Append("&#39;")
			Case "<"
				sb.Append("&lt;")
			Case ">"
				sb.Append("&gt;")
			Case "&"
				sb.Append("&amp;")
			Case Else
				sb.Append(c)
		End Select
	Next
	Return sb.ToString
End Sub
' ===================================================================
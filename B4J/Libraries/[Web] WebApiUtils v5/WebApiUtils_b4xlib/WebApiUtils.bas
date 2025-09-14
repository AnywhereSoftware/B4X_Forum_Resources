B4J=true
Group=App
ModulesStructureVersion=1
Type=StaticCode
Version=10
@EndOfDesignText@
' Web API Utility
' Version 5.00
Sub Process_Globals
	Public Const CONTENT_TYPE_HTML As String = "text/html"
	Public Const CONTENT_TYPE_JSON As String = "application/json"
	Public Const CONTENT_TYPE_XML As String = "application/xml"
	Public Const CONTENT_TYPE_PDF As String = "application/pdf"
	Public Const CONTENT_TYPE_PNG As String = "image/png"
	Public Const RESPONSE_ELEMENT_MESSAGE As String = "m"
	Public Const RESPONSE_ELEMENT_CODE As String 	= "a"
	Public Const RESPONSE_ELEMENT_STATUS As String 	= "s"
	Public Const RESPONSE_ELEMENT_TYPE As String 	= "t"
	Public Const RESPONSE_ELEMENT_ERROR As String 	= "e"
	Public Const RESPONSE_ELEMENT_RESULT As String 	= "r"
	Type HttpResponseContent (ResponseBody As String)
	Type HttpResponseMessage (ResponseMessage As String, ResponseCode As Int, ResponseStatus As String, ResponseType As String, ResponseError As Object, ResponseData As List, ResponseObject As Map, ResponseBody As Object, PayloadType As String, ContentType As String, XmlRoot As String, XmlElement As String, VerboseMode As Boolean, OrderedKeys As Boolean, ResponseKeys As List, ResponseKeysAlias As List)
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
Public Sub RequestCookie (Request As ServletRequest) As Map
	Dim Munchies() As Cookie = Request.GetCookies
	Dim M As Map
	M.Initialize
	For Each bite As Cookie In Munchies
		M.Put(bite.Name, bite.Value)
	Next
	Return M
End Sub

' Same as RequestDataJson (for backward compatibility)
' Next version may point to RequestDataText
' Tip about POST requests: if you want to get a URL parameter (req.GetParameter)
' then do it only after reading the payload, otherwise the payload will be searched
' for the parameter and will be lost.
Public Sub RequestData (Request As ServletRequest) As Map
	Return RequestDataJson(Request)
End Sub

Public Sub RequestDataText (Request As ServletRequest) As String
	Dim str As String
	Dim inp As InputStream = Request.InputStream
	If inp.BytesAvailable <= 0 Then
		Return Null
	End If
	Dim buffer() As Byte = Bit.InputStreamToBytes(inp)
	str = BytesToString(buffer, 0, buffer.Length, "UTF8")
	Return str
End Sub

Public Sub RequestDataJson (Request As ServletRequest) As Map
	Dim data As Map
	Dim inp As InputStream = Request.InputStream
	If inp.BytesAvailable <= 0 Then
		Return data
	End If
	Dim buffer() As Byte = Bit.InputStreamToBytes(inp)
	Dim str As String = BytesToString(buffer, 0, buffer.Length, "UTF8")
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
	Dim str As String = BytesToString(buffer, 0, buffer.Length, "UTF8")
	'str = LinearizeXML(str)
	'Dim xm As Xml2Map
	'xm.Initialize
	'xm.StripNamespaces = True
	'data = xm.Parse(str)
	'Return data
	Return ParseXML(str)
End Sub

' Remove comments, line breaks, tabs and spaces
Public Sub LinearizeXML (Text As String) As String
	Text = Regex.Replace("<!--[\s\S]*?-->", Text, "")
	Return Regex.Replace("\s+", Text, " ").Trim
End Sub

Public Sub ParseXML (Text As String) As Map
	Dim data As Map
	Dim xm As Xml2Map
	xm.Initialize
	xm.StripNamespaces = True
	data = xm.Parse(Text)
	Return data
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
	config.InitializeNewInstance("jakarta.servlet.MultipartConfigElement", Array(Folder, MaxSize, MaxSize, 81920))
	Dim f As JavaObject
	f.InitializeNewInstance("java.io.File", Array(Folder))
	Dim parser As JavaObject
	parser.InitializeNewInstance("org.eclipse.jetty.server.MultiPartFormInputStream", Array(Request.InputStream, Request.ContentType, config, f))
	Dim parts As JavaObject = parser.RunMethod("getParts", Null)
	Dim result() As Object = parts.RunMethod("toArray", Null)
	Return result
End Sub

Public Sub RequestMultipartData (Request As ServletRequest, Folder As String, MaxSize As Long) As Map
	Try
		Dim Data As Map = Request.GetMultipartData(Folder, MaxSize)
		For Each key As String In Data.Keys
			Dim part As Part = Data.Get(key)
			Dim name As String = part.SubmittedFilename
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
				Data = str.As(JSON).ToMap
			End If
			If File.Exists(Folder, name) Then File.Delete(Folder, temp) ' Delete temp file if new file generated
		Next
	Catch
		LogError(LastException.Message)
	End Try
	Return Data
End Sub

Public Sub RequestBasicAuth (Auths As List) As Map
	Dim Client As Map = CreateMap("CLIENT_ID": "", "CLIENT_SECRET": "")
	If Auths.Size > 0 Then
		Dim Auth As String = Auths.Get(0)
		If Auth.StartsWith("Basic") Then
			Dim b64 As String = Auth.SubString("Basic ".Length)
			Dim su As StringUtils
			Dim ab() As Byte = su.DecodeBase64(b64)
			Dim str As String = BytesToString(ab, 0, ab.Length, "UTF8")
			Dim UsernameAndPassword() As String = Regex.Split(":", str)
			If UsernameAndPassword.Length = 2 Then
				Client.Put("CLIENT_ID", UsernameAndPassword(0))
				Client.Put("CLIENT_SECRET", UsernameAndPassword(1))
			End If
		End If
	End If
	Return Client
End Sub

Public Sub EncodeBase64 (Data() As Byte) As String
	Dim SU As StringUtils
	Return SU.EncodeBase64(Data)
End Sub

Public Sub DecodeBase64 (Str As String) As Byte()
	Dim SU As StringUtils
	Return SU.DecodeBase64(Str)
End Sub

Public Sub EncodeURL (Str As String) As String
	Dim SU As StringUtils
	Return SU.EncodeUrl(Str, "UTF8")
End Sub

Public Sub DecodeURL (Str As String) As String
	Dim SU As StringUtils
	Return SU.DecodeUrl(Str, "UTF8")
End Sub

' Get Access Token from Header
Public Sub RequestAccessToken (Request As ServletRequest) As String
	Dim Token As String
	Dim Auths As List = Request.GetHeaders("Authorization")
	If Auths.Size > 0 Then
		Token = Auths.Get(0)
	End If
	Return Token
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
Public Sub ReturnCookie (Key As String, Value As String, MaxAge As Int, HttpOnly As Boolean, Response As ServletResponse)
	Dim session_cookie As Cookie
	session_cookie.Initialize(Key, Value)
	session_cookie.MaxAge = MaxAge
	session_cookie.HttpOnly = HttpOnly
	Response.AddCookie(session_cookie)
End Sub

Public Sub ReturnCookie2 (Key As String, Value As String, Path As String, SameSite As String, MaxAge As Int, HttpOnly As Boolean, Secure As Boolean, Response As ServletResponse)
	Dim CookieBuilder As StringBuilder
	CookieBuilder.Initialize
	CookieBuilder.Append(Key).Append("=").Append(Value).Append(";")
	If Path.Length > 0 Then CookieBuilder.Append(" Path=").Append(Path).Append(";")
	If SameSite.Length > 0 Then CookieBuilder.Append(" SameSite=").Append(SameSite).Append(";")	
	If HttpOnly Then CookieBuilder.Append(" HttpOnly;")
	If Secure Then CookieBuilder.Append(" Secure;")
	CookieBuilder.Append(" Max-Age=").Append(MaxAge)
	Response.SetHeader("Set-Cookie", CookieBuilder.ToString)
End Sub

Public Sub ReturnLocation (Location As String, Response As ServletResponse) ' Code = 302
	Response.SendRedirect(Location)
End Sub

Public Sub ReturnConnect (Message As HttpResponseMessage, Response As ServletResponse)
	Message.ResponseCode = 200
	Message.ResponseObject = CreateMap("connect": True)
	ReturnHttpResponse(Message, Response)
End Sub

Public Sub ReturnError (Message As HttpResponseMessage, Response As ServletResponse, Code As Int, Error As String)
	If Error = "" Then Error = "Bad Request"
	Message.ResponseCode = Code
	Message.ResponseError = Error
	Message.ResponseStatus = "error"
	ReturnHttpResponse(Message, Response)
End Sub

Public Sub ReturnSuccess (Message As HttpResponseMessage, Response As ServletResponse, Code As Int, Data As Map)
	If Code = 0 Then Code = 200
	Message.ResponseCode = Code
	Message.ResponseStatus = "ok"
	ReturnHttpResponse(Message, Response)
End Sub

Public Sub ReturnBadRequest (Message As HttpResponseMessage, Response As ServletResponse)
	Message.ResponseCode = 400
	ReturnHttpResponse(Message, Response)
End Sub

Public Sub ReturnAuthorizationRequired (Message As HttpResponseMessage, Response As ServletResponse)
	Message.ResponseCode = 401
	Message.ResponseError = "Authentication required"
	ReturnHttpResponse(Message, Response)
End Sub

Public Sub ReturnTokenExpired (Message As HttpResponseMessage, Response As ServletResponse)
	Message.ResponseCode = 401
	Message.ResponseError = "Token Expired"
	ReturnHttpResponse(Message, Response)
End Sub

Public Sub ReturnMethodNotAllow (Message As HttpResponseMessage, Response As ServletResponse)
	Message.ResponseCode = 405
	Message.ResponseError = "Method Not Allowed"
	ReturnHttpResponse(Message, Response)
End Sub

Public Sub ReturnErrorUnprocessableEntity (Message As HttpResponseMessage, Response As ServletResponse)
	Message.ResponseCode = 422
	Message.ResponseError = "Unprocessable Entity"
	ReturnHttpResponse(Message, Response)
End Sub

Public Sub ReturnErrorCredentialNotProvided (Message As HttpResponseMessage, Response As ServletResponse)
	Message.ResponseCode = 400
	Message.ResponseError = "Credential Not Provided"
	ReturnHttpResponse(Message, Response)
End Sub

Public Sub ReturnErrorExecuteQuery (Message As HttpResponseMessage, Response As ServletResponse)
	Message.ResponseCode = 422
	Message.ResponseError = "Execute Query"
	ReturnHttpResponse(Message, Response)
End Sub

Public Sub ProcessOrderedJsonFromList (L As List, Indent As String, Indentation As String) As String
	Dim SB As StringBuilder
	SB.Initialize
	SB.Append("[")
	Dim First As Boolean = True
	For Each value As Object In L
		If First = False Then
			SB.Append(",")
		Else
			First = False
		End If
		SB.Append(CRLF)
		Select True
			Case value Is List
				SB.Append(ProcessOrderedJsonFromList(value, Indent, Indentation))
			Case value Is Map
				SB.Append(ProcessOrderedJsonFromMap(value, Indent & Indentation, Indentation))
			Case value Is String
				SB.Append(Indent & QUOTE & value & QUOTE)
			Case Else
				SB.Append(Indent & value)
		End Select
	Next
	SB.Append(CRLF & Indent & "]")
	Return SB.ToString
End Sub

Public Sub ProcessOrderedJsonFromMap (M As Map, Indent As String, Indentation As String) As String
	If M.ContainsKey("__order") = False Then Return M.As(JSON).ToString
	Dim SB As StringBuilder
	SB.Initialize
	SB.Append(Indent & "{")
	Dim order As List = M.Get("__order")
	Dim First As Boolean = True
	For Each key As String In order
		If First = False Then
			SB.Append(",")
		Else
			First = False
		End If
		SB.Append(CRLF)
		Dim value As Object = m.Get(key)
		If key <> "__order" Then
			Select True
				Case value Is List
					SB.Append(Indent & Indentation & QUOTE & key & QUOTE & ": " & ProcessOrderedJsonFromList(value, Indent & Indentation, Indentation))
				Case value Is Map
					SB.Append(Indent & Indentation & QUOTE & key & QUOTE & ": " & ProcessOrderedJsonFromMap(value, Indent & Indentation & Indentation, Indentation))
				Case value Is String
					SB.Append(Indent & Indentation & QUOTE & key & QUOTE & ": " & QUOTE & value & QUOTE)
				Case Else
					SB.Append(Indent & Indentation & QUOTE & key & QUOTE & ": " & value)
			End Select
		End If
	Next
	SB.Append(CRLF & Indent & "}")
	Return SB.ToString
End Sub

Public Sub ProcessOrderedXmlFromList (Tag As String, L As List, Indent As String, Indentation As String) As String
	Dim SB As StringBuilder
	SB.Initialize
	Dim First As Boolean = True
	For Each value As Object In L
		Dim child As String
		Select True
			Case value Is Map
				child = CRLF & Indent & Indentation & ProcessOrderedXmlFromMap(Tag, value, Indent & Indentation, Indentation) & CRLF & Indent
			Case value Is List
				child = CRLF & Indentation & ProcessOrderedXmlFromList(Tag, value, Indent & Indentation, Indentation) & CRLF '& Indent
			Case value Is String
				child = EscapeXml(value)
			Case Else
				child = value
		End Select
		If First Then
			First = False
		Else
			SB.Append(CRLF)
		End If
		SB.Append(Indent).Append("<").Append(Tag).Append(">")
		SB.Append(child)
		SB.Append("</").Append(Tag).Append(">")
	Next
	Return SB.ToString
End Sub

Public Sub ProcessOrderedXmlFromMap (Tag As String, M As Map, Indent As String, Indentation As String) As String
	Dim SB As StringBuilder
	SB.Initialize
	If M.ContainsKey("__order") Then
		Dim order As List = M.Get("__order")
		Dim First As Boolean = True
		For Each key As String In order
			If key = "__order" Then Continue
			Dim value As Object = M.Get(key)
			Dim child As String
			Select True
				Case value Is Map
					child = CRLF & Indent & Indentation & ProcessOrderedXmlFromMap(Tag, value, Indent & Indentation, Indentation) & CRLF & Indent
				Case value Is List
					child = CRLF & ProcessOrderedXmlFromList(Tag, value, Indent & Indentation, Indentation) & CRLF & Indent
				Case value Is String
					child = EscapeXml(value)
				Case Else
					child = value
			End Select
			If First Then
				First = False
			Else
				SB.Append(CRLF)
			End If
			SB.Append(Indent)
			SB.Append("<").Append(key).Append(">")
			SB.Append(child)
			SB.Append("</").Append(key).Append(">")
		Next
	Else
		For Each key As String In M.Keys
			If key = "__order" Then Continue
			Dim value As Object = M.Get(key)
			Dim child As String
			Select True
				Case value Is Map
					Dim M2 As Map = value
					If M2.ContainsKey("__order") Then
						child = CRLF & Indent & Indentation & ProcessOrderedXmlFromMap(Tag, M2, Indent & Indentation, Indentation) & CRLF & Indent & Indentation
					Else
						Dim m2x As Map2Xml
						m2x.Initialize
						child = m2x.MapToXml(M2)
					End If
				Case value Is List
					child = CRLF & Indent & Indentation & ProcessOrderedXmlFromList(key, value, Indent & Indentation, Indentation) & CRLF & Indent & Indentation
				Case value Is String
					child = EscapeXml(value)
				Case Else
					child = value
			End Select
			SB.Append(Indent).Append("<").Append(key).Append(">")
			SB.Append(child)
			SB.Append("</").Append(key).Append(">")
		Next
	End If
	Return SB.ToString.Trim
End Sub

' To initialize: <code>
' HRM.Initialize
' HRM.VerboseMode = Main.conf.VerboseMode</code>
' ---------------------------------------------------------------
' <em>Output:</em> 
' {
'   "a": 200
'   "s": "ok",
'   "m": "Success",
'   "e": null,
'   "r": {
'     "connect": true
'   }
' }
Public Sub ReturnHttpResponse (Message As HttpResponseMessage, Response As ServletResponse)
	If Message.XmlRoot = "" Then Message.XmlRoot = "root"
	If Message.ContentType = "" Then Message.ContentType = CONTENT_TYPE_JSON
	If Message.PayloadType = "" Then Message.PayloadType = "json"
	If Message.ResponseCode >= 200 And Message.ResponseCode < 300 Then ' SUCCESS
		If Message.ResponseType = "" Then Message.ResponseType = "SUCCESS"
		If Message.ResponseStatus = "" Then Message.ResponseStatus = "ok"
		If Message.ResponseMessage = "" Then Message.ResponseMessage = "Success"
		Message.ResponseError = Null
	Else ' ERROR
		If Message.ResponseCode = 0 Then Message.ResponseCode = 400
		If Message.ResponseType = "" Then Message.ResponseType = "ERROR"
		If Message.ResponseStatus = "" Then Message.ResponseStatus = "error"
		If GetType(Message.ResponseError) = "java.lang.Object" Then
			Message.ResponseError = "Bad Request"
			If Message.ResponseCode = 404 Then Message.ResponseError = "Not Found"
			If Message.ResponseCode = 405 Then Message.ResponseError = "Method Not Allowed"
			If Message.ResponseCode = 422 Then Message.ResponseError = "Unprocessable Entity"
			If Message.ResponseCode = 429 Then Message.ResponseError = "Too Many Requests"
			If Message.ResponseCode = 500 Then Message.ResponseError = "Internal Server Error"
		End If
	End If
	Dim SB As StringBuilder
	SB.Initialize
	If Message.VerboseMode Then
		' Custom Keys
		If Message.ResponseKeys.IsInitialized = False Then
			Message.ResponseKeys.Initialize
		End If
		If Message.ResponseKeys.Size = 0 Then
			Message.ResponseKeys.Add("s")
			Message.ResponseKeys.Add("a")
			Message.ResponseKeys.Add("m")
			Message.ResponseKeys.Add("e")
			Message.ResponseKeys.Add("r")
			'Message.ResponseKeys.Add("t")
		End If
		Dim ResponseElements As Map
		ResponseElements.Initialize
		For Each Key As String In Message.ResponseKeys
			Select Key
				Case RESPONSE_ELEMENT_MESSAGE
					ResponseElements.Put(RESPONSE_ELEMENT_MESSAGE, Message.ResponseMessage)
				Case RESPONSE_ELEMENT_CODE
					ResponseElements.Put(RESPONSE_ELEMENT_CODE, Message.ResponseCode)
				Case RESPONSE_ELEMENT_STATUS
					ResponseElements.Put(RESPONSE_ELEMENT_STATUS, Message.ResponseStatus)
				Case RESPONSE_ELEMENT_TYPE
					ResponseElements.Put(RESPONSE_ELEMENT_TYPE, Message.ResponseType)
				Case RESPONSE_ELEMENT_ERROR
					ResponseElements.Put(RESPONSE_ELEMENT_ERROR, Message.ResponseError)
				Case RESPONSE_ELEMENT_RESULT
					If Message.ResponseData.IsInitialized Then
						ResponseElements.Put(RESPONSE_ELEMENT_RESULT, Message.ResponseData)
					Else If Message.ResponseObject.IsInitialized Then
						ResponseElements.Put(RESPONSE_ELEMENT_RESULT, Message.ResponseObject)
					Else If Message.ResponseBody Is String Then
						ResponseElements.Put(RESPONSE_ELEMENT_RESULT, Message.ResponseBody)
					Else
						ResponseElements.Put(RESPONSE_ELEMENT_RESULT, Null)
					End If
			End Select
		Next
		' Override Status Code
		If Message.ResponseCode < 200 Or Message.ResponseCode > 299 Then
			Response.Status = 200
		Else
			Response.Status = Message.ResponseCode
		End If
		
		If Message.ResponseKeysAlias.IsInitialized Then
			Dim ResponseElementsVerbose As Map
			ResponseElementsVerbose.Initialize
			For i = 0 To Message.ResponseKeysAlias.Size - 1
				Dim oldKey As String = Message.ResponseKeys.Get(i)
				Dim Value As Object = ResponseElements.Get(oldKey)
				Dim newKey As String = Message.ResponseKeysAlias.Get(i)
				ResponseElementsVerbose.Put(newKey, Value)
			Next
			If Message.OrderedKeys Then ResponseElementsVerbose.Put("__order", Message.ResponseKeysAlias)
		Else
			ResponseElementsVerbose = ResponseElements
			If Message.OrderedKeys Then ResponseElementsVerbose.Put("__order", Message.ResponseKeys)
		End If
		If Message.OrderedKeys Then
			Select Message.ContentType
				Case CONTENT_TYPE_XML
					SB.Append($"<${Message.XmlRoot}>"$)
					SB.Append(CRLF).Append("  ").Append(ProcessOrderedXmlFromMap(Message.XmlElement, ResponseElementsVerbose, "  ", "  "))
					SB.Append(CRLF).Append($"</${Message.XmlRoot}>"$)
				Case CONTENT_TYPE_JSON
					SB.Append(ProcessOrderedJsonFromMap(ResponseElementsVerbose, "", "  "))
			End Select
		Else
			' order not preserved
			Select Message.ContentType
				Case CONTENT_TYPE_XML
					Message.ResponseObject = CreateMap(Message.XmlRoot: ResponseElementsVerbose)
					Dim m2x As Map2Xml
					m2x.Initialize
					SB.Append(m2x.MapToXml(Message.ResponseObject))
				Case CONTENT_TYPE_JSON
					SB.Append(ResponseElementsVerbose.As(JSON).ToString)
			End Select
		End If
	Else ' VerboseMode = False
		Response.Status = Message.ResponseCode
		If Message.OrderedKeys Then
			Select True
				Case Message.ResponseObject.IsInitialized
					If Message.ContentType = CONTENT_TYPE_XML Then
						SB.Append($"<${Message.XmlRoot}>"$)
						SB.Append(CRLF).Append("  ").Append(ProcessOrderedXmlFromMap(Message.XmlElement, Message.ResponseObject, "  ", "  "))
						SB.Append(CRLF).Append($"</${Message.XmlRoot}>"$)
					Else
						SB.Append(ProcessOrderedJsonFromMap(Message.ResponseObject, "", "  "))
					End If
				Case Message.ResponseData.IsInitialized
					If Message.ContentType = CONTENT_TYPE_XML Then
						If Message.XmlElement = "" Then Message.XmlElement = "item"
						SB.Append($"<${Message.XmlRoot}>"$)
						SB.Append(CRLF).Append(ProcessOrderedXmlFromList(Message.XmlElement, Message.ResponseData, "  ", "  "))
						SB.Append(CRLF).Append($"</${Message.XmlRoot}>"$)
					Else
						SB.Append(ProcessOrderedJsonFromList(Message.ResponseData, "", "  "))
					End If
				Case Message.ResponseBody Is String
					SB.Append(Message.ResponseBody)
				Case Else
					If Message.ContentType = CONTENT_TYPE_XML Then
						Message.ResponseObject = CreateMap("error": Message.ResponseError)
						SB.Append($"<${Message.XmlRoot}>"$)
						SB.Append(CRLF).Append("  ").Append($"<error>${Message.ResponseError}</error>"$)
						SB.Append(CRLF).Append($"</${Message.XmlRoot}>"$)
					Else
						Message.ResponseObject = CreateMap("error": Message.ResponseError)
						SB.Append(Message.ResponseObject.As(JSON).ToString)
					End If
			End Select
		Else
			Select True
				Case Message.ResponseObject.IsInitialized
					If Message.ContentType = CONTENT_TYPE_XML Then
						If Message.XmlElement = "" Then Message.XmlElement = "item"
						Message.ResponseObject = CreateMap(Message.XmlRoot: CreateMap(Message.XmlElement: Message.ResponseObject))
						Dim m2x As Map2Xml
						m2x.Initialize
						SB.Append(m2x.MapToXml(Message.ResponseObject))
					Else
						SB.Append(Message.ResponseObject.As(JSON).ToString)
					End If
				Case Message.ResponseData.IsInitialized
					If Message.ContentType = CONTENT_TYPE_XML Then
						If Message.XmlElement = "" Then Message.XmlElement = "item"
						Message.ResponseObject = CreateMap(Message.XmlRoot: CreateMap(Message.XmlElement: Message.ResponseData))
						Dim m2x As Map2Xml
						m2x.Initialize
						SB.Append(m2x.MapToXml(Message.ResponseObject))
					Else
						SB.Append(Message.ResponseData.As(JSON).ToString)
					End If
				Case Message.ResponseBody Is String
					SB.Append(Message.ResponseBody)
				Case Else
					If Message.ContentType = CONTENT_TYPE_XML Then
						Message.ResponseObject = CreateMap("error": Message.ResponseError)
						SB.Append($"<${Message.XmlRoot}>"$)
						SB.Append(CRLF).Append("  ").Append($"<error>${Message.ResponseError}</error>"$)
						SB.Append(CRLF).Append($"</${Message.XmlRoot}>"$)
					Else
						Message.ResponseObject = CreateMap("error": Message.ResponseError)
						SB.Append(Message.ResponseObject.As(JSON).ToString)
					End If
			End Select
		End If
	End If
	ReturnContent(SB.ToString.Trim, Message.ContentType, Response)
End Sub

Public Sub ReturnContent (Content As Object, ContentType As String, Response As ServletResponse)
	Response.ContentType = ContentType
	Response.Write(Content)
End Sub

Public Sub ReturnHtml (Str As String, Response As ServletResponse)
	ReturnContent(Str, CONTENT_TYPE_HTML, Response)
End Sub

Public Sub ReturnHtmlBody (Cont As HttpResponseContent, Response As ServletResponse)
	ReturnContent(Cont.ResponseBody, CONTENT_TYPE_HTML, Response)
End Sub

Public Sub ReturnHtmlPageNotFound (Response As ServletResponse)
	Dim Str As String = $"<h1>404 Page Not Found</h1>"$
	ReturnHtml(Str, Response)
End Sub

Public Sub ReturnHtmlBadRequest (Response As ServletResponse)
	Dim Str As String = $"<h1>400 Bad Request</h1>"$
	ReturnHtml(Str, Response)
End Sub

Public Sub ReturnHtmlMethodNotAllowed (Response As ServletResponse)
	Dim Str As String = $"<h1>405 Method Not Allowed</h1>"$
	ReturnHtml(Str, Response)
End Sub

Public Sub ReturnOutputStream (Ins As InputStream, Response As ServletResponse)
	File.Copy2(Ins, Response.OutputStream)
	Response.OutputStream.Close
End Sub

' Response.ContentType = "application/pdf"
' Response.SetHeader("Content-Disposition", "inline;filename=temp.pdf")
Public Sub ReturnFileInline (Ins As InputStream, FileName As String, Response As ServletResponse)
	If FileName = "" Then FileName = "file"
	Response.SetHeader("Content-Disposition", "inline;filename=" & FileName)
	ReturnOutputStream(Ins, Response)
End Sub

' Response.ContentType = "application/pdf"
' Response.SetHeader("Content-Disposition", "attachment;filename=temp.pdf")
Public Sub ReturnFileAttachment (Ins As InputStream, FileName As String, Response As ServletResponse)
	If FileName = "" Then FileName = "file"
	Response.SetHeader("Content-Disposition", "inline;filename=" & FileName)
	ReturnOutputStream(Ins, Response)
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
Public Sub ValidateCsrfToken (SessionName As String, HeaderName As String, Request As ServletRequest) As Boolean
	Dim headers As List = Request.GetHeaders(HeaderName)
	If Request.GetSession.GetAttribute2(SessionName, "").As(String).EqualsIgnoreCase(headers.Get(0)) Then
		'Log("matched")
		Return True
	Else
		'Log("unmatched!")
		Return False
	End If
End Sub

' Format: xml, json 
Public Sub ValidateContent (Text As String, Format As String) As Boolean
	Text = Text.Trim
	Select Format.ToLowerCase
		Case "xml"
			Return Text.StartsWith("<")
		Case "json"
			Return Text.StartsWith("{") Or Text.StartsWith("[")
		Case Else
			Return True
	End Select
End Sub

Public Sub GUID As String
	Dim SB As StringBuilder
	SB.Initialize
	For Each stp As Int In Array(8, 4, 4, 4, 12)
		If SB.Length > 0 Then SB.Append("-")
		For n = 1 To stp
			Dim c As Int = Rnd(0, 16)
			If c < 10 Then c = c + 48 Else c = c + 55
			SB.Append(Chr(c))
		Next
	Next
	Return SB.ToString
End Sub

Public Sub ProperCase (Word As String) As String
	If Word.Length = 0 Then Return ""
	If Word.Length = 1 Then Return Word.ToUpperCase
	Return Word.CharAt(0).As(String).ToUpperCase & Word.SubString(1)
End Sub

' ===================================================================
' Taken from WebUtils
' ===================================================================
Public Sub ReplaceMap (Base As String, Replacements As Map) As String
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
	Dim SB As StringBuilder
	SB.Initialize
	For n = 0 To Value.Length - 1
		Dim c As Char = Value.CharAt(n)
		Select c
			Case QUOTE
				SB.Append("&quot;")
			Case "'"
				SB.Append("&#39;")
			Case "<"
				SB.Append("&lt;")
			Case ">"
				SB.Append("&gt;")
			Case "&"
				SB.Append("&amp;")
			Case Else
				SB.Append(c)
		End Select
	Next
	Return SB.ToString
End Sub
' ===================================================================

' Reference: https://www.b4x.com/android/forum/threads/escapexml-code-snippet.35720/
Public Sub EscapeXml (Raw As String) As String
	Dim SB As StringBuilder
	SB.Initialize
	For i = 0 To Raw.Length - 1
		Dim c As Char = Raw.CharAt(i)
		Select c
			Case QUOTE
				SB.Append("&quot;")
			Case "'"
				SB.Append("&apos;")
			Case "<"
				SB.Append("&lt;")
			Case ">"
				SB.Append("&gt;")
			Case "&"
				SB.Append("&amp;")
			Case Else
				SB.Append(c)
		End Select
	Next
	Return SB.ToString
End Sub
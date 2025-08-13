B4J=true
Group=Handlers
ModulesStructureVersion=1
Type=Class
Version=10.2
@EndOfDesignText@
'Help Handler class
'Version 4.00 beta 8
Sub Class_Globals
	Private Request As ServletRequest 'ignore
	Private Response As ServletResponse
	Private Handlers As List
	Private AllMethods As List
	Private AllGroups As Map
	Type VerbSection (Verb As String, Color As String, ElementId As String, Link As String, FileUpload As String, Authenticate As String, Description As String, Params As String, Format As String, Body As String, Expected As String, InputDisabled As Boolean, DisabledBackground As String, Raw As Boolean, Noapi As Boolean)
End Sub

Public Sub Initialize
	AllMethods.Initialize
	AllGroups.Initialize
	Handlers.Initialize
	Handlers.Add("CategoriesApiHandler")
	Handlers.Add("ProductsApiHandler")
	Handlers.Add("FindApiHandler")
End Sub

Sub Handle (req As ServletRequest, resp As ServletResponse)
	Request = req
	Response = resp
	ShowHelpPage
End Sub

Private Sub ShowHelpPage
	#If Debug
	'ReadHandlers ' Read from source (optional) - comment hashtags are required
	#End If
	BuildMethods ' Build page programatically
	Dim Contents As String = GenerateHtml
	Dim strMain As String = WebApiUtils.ReadTextFile("help.html")
	strMain = WebApiUtils.BuildDocView(strMain, Contents)
	strMain = WebApiUtils.BuildTag(strMain, "HELP", "") ' Hide API icon
	strMain = WebApiUtils.BuildHtml(strMain, Main.ctx)
	strMain = WebApiUtils.BuildScript(strMain, $"<script src="${Main.conf.ServerUrl}/assets/scripts/help.js"></script>"$)
	WebApiUtils.ReturnHtml(strMain, Response)
End Sub

Private Sub GenerateHtml As String
	For Each method As Map In AllMethods ' Avoid duplicate groups
		AllGroups.Put(method.Get("Group"), "unused")
	Next
	Dim Html As StringBuilder
	Html.Initialize
	For Each GroupName As String In AllGroups.Keys
		Html.Append(GenerateHeaderByGroup(GroupName))
		For Each method As Map In AllMethods
			If method.Get("Group") = GroupName Then
				If method.ContainsKey("Hide") = False Then ' Skip Hidden sub
					Html.Append(GenerateDocItem(method))
				End If
			End If
		Next
	Next
	Return Html.ToString
End Sub

Private Sub FindMethod (MethodName As String) As Int
	For i = 0 To AllMethods.Size - 1
		Dim Method As Map = AllMethods.Get(i)
		If Method.Get("Method") = MethodName Then
			'Log(Method.Get("Method"))
			Return i
		End If
	Next
	Return -1
End Sub

Private Sub RetrieveMethod (GroupName As String, MethodLine As String) As Map
	Dim index As Int = FindMethod(ExtractMethod(MethodLine))
	If index > -1 Then
		Return AllMethods.Get(index)
	Else
		Return CreateMethodProperties(GroupName, MethodLine)
	End If
End Sub

' Use this sub if you are calling BuildMethods after calling ReadHandlers in Debug to override method properties
' Order in list is preserved
Private Sub ReplaceMethod (Method As Map)
	' Replacement will failed if the Method name cannot be found
	Dim index As Int = FindMethod(Method.Get("Method"))
	If index > -1 Then
		AllMethods.RemoveAt(index)
		AllMethods.InsertAt(index, Method)
	Else
		AllMethods.Add(Method)
	End If
End Sub

Private Sub RemoveMethodAndReAdd (Method As Map)
	Dim index As Int = FindMethod(Method.Get("Method"))
	If index > -1 Then
		AllMethods.RemoveAt(index)
	End If
	AllMethods.Add(Method) ' Add at the end of list
End Sub

Private Sub BuildMethods
	Dim Method As Map = RetrieveMethod("Categories", "GetCategories")
	Method.Put("Desc", "Read all Categories")
	ReplaceMethod(Method)
	
	Dim Method As Map = RetrieveMethod("Categories", "GetCategoryById (id As Int)")
	Method.Put("Desc", "Read one Category by id")
	Method.Put("Elements", $"["{id}"]"$)
	ReplaceMethod(Method)
	
	Dim Method As Map = RetrieveMethod("Categories", "CreateNewCategory '#POST")
	Method.Put("Desc", "Add new Category")
	Dim FormatMap As Map = CreateMap("category_name": "category_name")
	Method.Put("Format", FormatMap.As(JSON).ToString)
	Method.Put("Body", FormatMap.As(JSON).ToString)
	'Dim BodyMap As Map = CreateMap("root": CreateMap("category_name": "category_name"))
	'Dim m2x As Map2Xml
	'm2x.Initialize
	'Dim xml As String = m2x.MapToXml(BodyMap)
	'Method.Put("Body", EscapeXml(xml))
	ReplaceMethod(Method)

	Dim Method As Map = RetrieveMethod("Categories", "UpdateCategoryById (id As Int) '#PUT")
	Method.Put("Desc", "Update Category by id")
	Method.Put("Elements", $"["{id}"]"$)
	Dim FormatMap As Map = CreateMap("category_name": "category_name")
	Method.Put("Format", FormatMap.As(JSON).ToString)
	Method.Put("Body", FormatMap.As(JSON).ToString)
	'Dim BodyMap As Map = CreateMap("root": CreateMap("category_name": "category_name"))
	'Dim m2x As Map2Xml
	'm2x.Initialize
	'Dim xml As String = m2x.MapToXml(BodyMap)
	'Method.Put("Body", EscapeXml(xml))
	ReplaceMethod(Method)
	
	Dim Method As Map = RetrieveMethod("Categories", "DeleteCategoryById (id As Int)")
	Method.Put("Desc", "Delete Category by id")
	Method.Put("Elements", $"["{id}"]"$)
	RemoveMethodAndReAdd(Method)
	
	Dim Method As Map = RetrieveMethod("Products", "GetProducts")
	Method.Put("Desc", "Read all Products")
	ReplaceMethod(Method)
	
	Dim Method As Map = RetrieveMethod("Products", "GetProductById (id As Int)")
	Method.Put("Desc", "Read one Product by id")
	Method.Put("Elements", $"["{id}"]"$)
	ReplaceMethod(Method)

	Dim Method As Map = CreateMethodProperties("Products", "PostProduct")
	Method.Put("Desc", "Add new Product")
	Dim Format As String = $"{
  "category_id": 1,
  "product_code": "CODE",
  "product_name": "ProductName",
  "product_price": 0
}"$
	Dim Body As String = $"{
  "category_id": 1,
  "product_code": "",
  "product_name": "",
  "product_price": 0
}"$
	Method.Put("Format", Format)
	Method.Put("Body", Body)

'	Dim xml As String = $"<root>
'  <category_id>1</category_id>
'  <product_code>CODE</product_code>
'  <product_name>ProductName</product_name>
'  <product_price>0</product_price>
'</root>"$
	'Method.Put("Body", EscapeXml(xml))
	ReplaceMethod(Method)
	
	Dim Method As Map = RetrieveMethod("Products", "PutProductById (id As Int)")
	Method.Put("Desc", "Update Product by id")
	Dim Format As String = $"{
  "category_id": 1,
  "product_code": "CODE",
  "product_name": "ProductName",
  "product_price": 10
}"$
	Dim Body As String = $"{
  "category_id": 1,
  "product_code": "",
  "product_name": "",
  "product_price": 0
}"$
	Method.Put("Format", Format)
	Method.Put("Body", Body)
	
	'Dim xml As String = $"<root>
'  <category_id>1</category_id>
'  <product_code>CODE</product_code>
'  <product_name>ProductName</product_name>
'  <product_price>10</product_price>
'</root>"$
	'Method.Put("Body", EscapeXml(xml))
	Method.Put("Elements", $"["{id}"]"$)
	ReplaceMethod(Method)
	
	Dim Method As Map = RetrieveMethod("Products", "DeleteProductById (id As Int)")
	Method.Put("Desc", "Delete Product by id")
	Method.Put("Elements", $"["{id}"]"$)
	ReplaceMethod(Method)
	
	Dim Method As Map = RetrieveMethod("Find", "GetAllProducts")
	Method.Put("Desc", "Get all Products (with Category name)")
	ReplaceMethod(Method)
	
	Dim Method As Map = RetrieveMethod("Find", "GetProductsByCategoryId (id As Int)")
	Method.Put("Desc", "Get all Products by Category Id (with Category name)")
	Method.Put("Elements", $"["products-by-category_id", "{id}"]"$)
	ReplaceMethod(Method)
	
	Dim Method As Map = RetrieveMethod("Find", "SearchByKeywords ' #POST")
	Dim FormatMap As Map = CreateMap("keyword": "text")
	Method.Put("Format", FormatMap.As(JSON).ToString)
	Dim BodytMap As Map = CreateMap("keyword": "")
	Method.Put("Body", BodytMap.As(JSON).ToString)
	'Dim BodyMap As Map = CreateMap("root": CreateMap("keyword": "text")) ' valid XML requires root element
	'Dim m2x As Map2Xml
	'm2x.Initialize
	'Dim xml As String = m2x.MapToXml(BodyMap)
	'Method.Put("Body", EscapeXml(xml))
	Method.Put("Desc", "Filter Products (with Category name)")
	Dim Expected As StringBuilder
	Expected.Initialize
	Expected.Append("200 Success")
	Expected.Append("<br/>400 Bad Request")
	Expected.Append("<br/>404 Not found")
	Expected.Append("<br/>422 Error execute query")
	Method.Put("Expected", Expected.ToString)
	ReplaceMethod(Method)
End Sub

Private Sub ReadHandlers 'ignore
	Dim verbs() As String = Array As String("GET", "POST", "PUT", "DELETE")
	For Each Handler As String In Handlers
		Dim Methods As List
		Methods.Initialize
		Dim Group As String = Handler.Replace("Handler", "").Replace("Api", "").Replace("Web", "")
		Dim lines As List = File.ReadList(File.DirApp.Replace("\Objects", ""), Handler & ".bas")
		For Each line As String In lines
			If line.StartsWith("'") Or line.StartsWith("#") Then Continue
			Dim index As Int = line.toLowerCase.IndexOf("sub ")
			If index > -1 Then
				Dim MethodLine As String = line.SubString(index).Replace("Sub ", "").Trim
				For Each verb As String In verbs
					If MethodLine.ToUpperCase.StartsWith(verb) Or MethodLine.ToUpperCase.Contains("#" & verb) Then
						'RemoveComment(MethodLine)
						Dim Method As Map = CreateMethodProperties(Group, MethodLine)
						Methods.Add(Method)
						AllMethods.Add(Method)
					End If
				Next
			Else
				If line.Contains("'") And line.Contains("#") Then
					' Detect commented hashtags inside Handler
					ParseHashtags(line, Methods)
				End If
			End If
		Next
		'' Retain this part for debugging purpose
		'#If DEBUG
		'For Each m As Map In Methods
		'	Log(" ")
		'	Log("[" & m.Get("Verb") & "]")
		'	Log("Method: " & m.Get("Method"))
		'	Log("Params: " & m.Get("Params"))
		'	Log("Hide: " & m.Get("Hide"))
		'	Log("Plural: " & m.Get("Plural"))
		'	Log("Elements: " & m.Get("Elements"))
		'	Log("Version: " & m.Get("Version"))
		'	Log("Format: " & m.Get("Format"))
		'	Log("Desc: " & m.Get("Desc"))
		'Next
		'#End If
	Next
End Sub

Private Sub ParseHashtags (lineContent As String, methodList As List)
	' =====================================================================
	' Detect commented hashtags inside Handler
	' =====================================================================
	' CAUTION: Do not use commented hashtag keyword inside non-verb subs!
	' =====================================================================
	' Supported hashtag keywords: (case-insensitive)
	' #name (formerly #plural)
	' #version
	' #desc
	' #body
	' #elements
	' #format  (formerly #defaultformat)
	' #upload
	' #authenticate
	'
	' Single keywords:
	' #hide
	' #noapi
	Dim HashTags1() As String = Array As String("Hide", "Noapi")
	Dim HashTags2() As String = Array As String("Version", "Desc", "Elements", "Body", "Group", "Upload", "Authenticate", "Format")
	
	For Each Tag As String In HashTags1
		If lineContent.ToLowerCase.IndexOf("#" & Tag.ToLowerCase) > -1 Then
			Dim lastMethod As Map = methodList.Get(methodList.Size - 1)
			lastMethod.Put(Tag, True)
		End If
	Next
	For Each Tag As String In HashTags2
		If lineContent.ToLowerCase.IndexOf("#" & Tag.ToLowerCase) > -1 Then
			Dim str() As String = Regex.Split("=", lineContent)
			If str.Length > 1 Then ' fixed bug Desc contains equal sign
				Dim lastMethod As Map = methodList.Get(methodList.Size - 1)
				lastMethod.Put(Tag, lineContent.SubString(lineContent.IndexOf("=") + 1).Trim)
			End If
		End If
	Next
End Sub

Private Sub RemoveComment (Line As String) As String
	' Clean up comment on the right of a sub
	If Line.Contains("'") Then
		Line = Line.SubString2(0, Line.IndexOf("'"))
	End If
	Return Line
End Sub

Private Sub RemoveReturnType (Line As String) As String
	' Clean up As type on the right of a sub
	If Line.ToLowerCase.Contains(" as ") Then
		Dim index As Int = Line.ToLowerCase.IndexOf(" as ")
		Line = Line.SubString2(0, index)
	End If
	Return Line
End Sub

Private Sub CreateMethodProperties (groupName As String, methodLine As String) As Map
	Dim methodProps As Map
	methodProps.Initialize
	methodProps.Put("Group", groupName)
	methodProps.Put("Method", ExtractMethod(methodLine))
	methodProps.Put("Desc", methodProps.Get("Method"))
	methodProps.Put("Verb", ExtractVerb(methodLine))
	methodProps.Put("Params", ExtractParams(methodLine))
	methodProps.Put("Format", "&nbsp;")
	methodProps.Put("Body", "")
	methodProps.Put("Noapi", False)
	methodProps.Put("Format", "")
	Return methodProps
End Sub

Private Sub ExtractMethod (methodLine As String) As String
	' Take the method name only without arguments
	methodLine = RemoveComment(methodLine)
	methodLine = RemoveReturnType(methodLine)
	Dim index As Int = methodLine.IndexOf("(")
	If index > -1 Then
		Return methodLine.SubString2(0, index).Trim
	Else
		Return methodLine.Trim
	End If
End Sub

Private Sub ExtractVerb (methodLine As String) As String
	' Determine the HTTP verb based on the method name
	Dim MethodVerb As String
	If methodLine.ToUpperCase.StartsWith("GET") Then
		MethodVerb = "GET"
	Else If methodLine.ToUpperCase.StartsWith("POST") Then
		MethodVerb = "POST"
	Else If methodLine.ToUpperCase.StartsWith("PUT") Then
		MethodVerb = "PUT"
	Else If methodLine.ToUpperCase.StartsWith("DELETE") Then
		MethodVerb = "DELETE"
	End If
	' Override if #hashtag comment exists
	Select True
		Case methodLine.ToUpperCase.Contains("#GET")
			MethodVerb = "GET"
		Case methodLine.ToUpperCase.Contains("#POST")
			MethodVerb = "POST"
		Case methodLine.ToUpperCase.Contains("#PUT")
			MethodVerb = "PUT"
		Case methodLine.ToUpperCase.Contains("#DELETE")
			MethodVerb = "DELETE"
	End Select
	Return MethodVerb
End Sub

Private Sub ExtractParams (methodLine As String) As String
	' Extract method parameters if any
	Dim indexBegin As Int = methodLine.IndexOf("(")
	'Dim indexEnd As Int = methodLine.LastIndexOf(")") ' comment can contains close parentheses
	Dim indexEnd As Int = methodLine.IndexOf(")")
	Dim params As StringBuilder
	params.Initialize
	If indexBegin > -1 Then
		Dim args As String = methodLine.SubString2(indexBegin + 1, indexEnd)
		Dim prm() As String = Regex.Split(",", args)
		For i = 0 To prm.Length - 1
			If i > 0 Then params.Append(CRLF)
			Dim pm() As String = Regex.Split(" As ", prm(i))
			params.Append(pm(0).Trim).Append(" [").Append(pm(1).Trim).Append("]")
		Next
	Else
		params.Append("Not required")
	End If
	Return params.ToString
End Sub

Private Sub GenerateLink (ApiVersion As String, Handler As String, Elements As List) As String
	Dim Link As String = "$SERVER_URL$/" & Main.conf.ApiName
	If Link.EndsWith("/") = False Then Link = Link & "/"
	If ApiVersion.EqualsIgnoreCase("null") = False Then
		If Main.conf.ApiVersioning Then Link = Link & ApiVersion
		If Link.EndsWith("/") = False Then Link = Link & "/"
	End If
	Link = Link & Handler.ToLowerCase
	If Elements.IsInitialized Then
		For i = 0 To Elements.Size - 1
			Link = Link & "/" & Elements.Get(i)
		Next
	End If
	Return Link
End Sub

Private Sub GenerateNoApiLink (Handler As String, Elements As List) As String
	Dim Link As String = "$SERVER_URL$/" & Handler.ToLowerCase
	For i = 0 To Elements.Size - 1
		Link = Link & "/" & Elements.Get(i)
	Next
	Return Link
End Sub

Private Sub GenerateVerbSection (section As VerbSection) As String
	Select section.FileUpload
		Case "Image", "PDF"
			Dim strBodyInput As String = $"<p><strong>File:</strong> <label for="file1${section.ElementId}">Choose a file:</label><input type="file" id="file1${section.ElementId}" class="pb-3" name="file1"></p>"$
		Case Else
			Dim strBodySample As String = $"<p><strong>Format:</strong> <span class="form-control" style="background-color: #636363; color: white; height: fit-content; vertical-align: text-top; font-size: small">${section.Format}</span></p>"$
			Dim strBodyInput As String = $"<p><strong>Body:</strong> <textarea id="body${section.ElementId}" rows="6" class="form-control data-body" style="background-color: #363636; color: white; font-size: small">${section.Body}</textarea></p>"$
	End Select
	Return $"
        <button class="collapsible collapsible-background-${section.Color}"><span style="width: 60px" class="badge badge-${section.Color} text-dark py-1 mr-1">${section.Verb}</span>
		${IIf(section.Authenticate.EqualsIgnoreCase("Basic") Or section.Authenticate.EqualsIgnoreCase("Token"), _
			$"<span style="width: 50px" class="badge rounded-pill pill-yellow pill-yellow-text px-2 py-1">${WebApiUtils.ProperCase(section.Authenticate)}</span>"$, "")}<span class="ml-1">${section.Description}</span>
		</button>
        <div class="details mb-1">
            <!--<div class="row">
                <div class="col-md-6 pt-3">
                    ${IIf(section.Authenticate.EqualsIgnoreCase("Basic") Or section.Authenticate.EqualsIgnoreCase("Token"), _
                    $"<span class="badge rounded-pill bg-info text-white px-2 py-1">${WebApiUtils.ProperCase(section.Authenticate)} Authentication</span><br>"$, "")}
                    ${section.Description}
                </div>
            </div>-->
            <div class="row">
                <div class="col-md-3 p-3">
                    <p><strong>Parameters</strong><br/>
                    <label class="col control-label border rounded" style="padding-top: 5px; padding-bottom: 5px; font-size: small; white-space: pre-wrap;">${section.Params}</label></p>
                    ${IIf(section.Verb.EqualsIgnoreCase("POST") Or section.Verb.EqualsIgnoreCase("PUT"), strBodySample, "")}
                    <div class="mt-3"><strong>Status Code</strong><br/>
                    ${section.Expected}</div>
                </div>
	            <div class="col-md-3 p-3">
					<form id="form1" method="${section.Verb}">
					<p><strong>Path</strong><br/>
	                <input${IIf(section.InputDisabled, " disabled", "")} id="path${section.ElementId}" class="form-control data-path text-light" style="background-color: ${section.DisabledBackground}; font-size: small" value="${section.Link & IIf(section.Raw, "?format=json", "")}"></p>
					${IIf(section.Verb.EqualsIgnoreCase("POST") Or section.Verb.EqualsIgnoreCase("PUT"), strBodyInput, $""$)}
					<button id="btn${section.ElementId}" class="${IIf(section.FileUpload.EqualsIgnoreCase("Image") Or section.FileUpload.EqualsIgnoreCase("PDF"), $"file"$, $"${section.Verb.ToLowerCase}"$)}${IIf(section.Authenticate.ToUpperCase = "BASIC" Or section.Authenticate.ToUpperCase = "TOKEN", " " & section.Authenticate.ToLowerCase, "")} button submit-button-${section.Color} text-white col-md-6 col-lg-4 p-2 float-right" style="cursor: pointer; padding-bottom: 60px"><strong>Submit</strong></button>
	            	</form>
				</div>
                <div class="col-md-6 p-3">
                    <p><strong>Response</strong><br/>
                    <textarea rows="10" id="response${section.ElementId}" class="form-control" style="background-color: #363636; color: white; font-size: small"></textarea></p>
                    <div id="alert${section.ElementId}" class="alert text-light" role="alert" style="display: block"></div>
                </div>
            </div>
        </div>"$
End Sub

Private Sub GenerateHeaderByGroup (Group As String) As String
	Return $"
		<div class="row mt-3">
            <div class="col-md-12">
                <h6 class="text-uppercase text-primary"><strong>${Group}</strong></h6>
            </div>
		</div>"$
End Sub

Private Sub GenerateDocItem (Props As Map) As String
	Dim section As VerbSection
	section.Initialize
	section.Verb = Props.Get("Verb")
	section.Color = GetColorForVerb(section.Verb)
	section.ElementId = Props.Get("Method")
	section.Noapi = Props.Get("Noapi")
	Dim Elements As List
	If Props.ContainsKey("Elements") Then
		Elements = Props.Get("Elements").As(JSON).ToList
	End If
	If section.Noapi Then
		section.Link = GenerateNoApiLink(Props.Get("Group"), Elements)
	Else
		section.Link = GenerateLink(Props.Get("Version"), Props.Get("Group"), Elements)
	End If
	section.Authenticate = Props.Get("Authenticate")
	section.Description = Props.Get("Desc")
	section.Params = Props.Get("Params")
	section.Format = Props.Get("Format")
	section.Format = section.Format.Replace(CRLF, "<br>")	' convert to html
	section.Format = section.Format.Replace("  ", "&nbsp;")	' convert to html
	section.Body = Props.Get("Body")
	'section.Body = section.Body.Replace(CRLF, "<br>")	' convert to html
	'section.Body = section.Body.Replace("  ", "&nbsp;")	' convert to html
	section.Expected = IIf(Props.ContainsKey("Expected"), Props.Get("Expected"), GetExpectedResponse(section.Verb))
	If section.Params.EqualsIgnoreCase("Not required") Then
		section.InputDisabled = True
		'section.DisabledBackground = "#F0F9FF"
		section.DisabledBackground = "#696969"
	Else
		'section.DisabledBackground = "#FFFFFF"
		section.DisabledBackground = "#363636"
	End If
	Return GenerateVerbSection(section)
End Sub

Private Sub GetColorForVerb (verb As String) As String
	' https://tailwindcss.com/docs/customizing-colors
	Select verb
		Case "GET"
			Return "green"
		Case "POST"
			Return "purple"
		Case "PUT"
			Return "blue"
		Case "DELETE"
			Return "red"
		Case Else
			Return ""
	End Select
End Sub

Private Sub GetExpectedResponse (verb As String) As String
	Dim Expected As StringBuilder
	Expected.Initialize
	Select verb
		Case "POST"
			Expected.Append("201 Created")
		Case Else
			Expected.Append("200 Success")
	End Select
	Expected.Append("<br/>400 Bad Request")
	Expected.Append("<br/>404 Not found")
	Expected.Append("<br/>405 Method not allowed")
	Expected.Append("<br/>422 Error execute query")
	Return Expected.ToString
End Sub

' Reference: https://www.b4x.com/android/forum/threads/escapexml-code-snippet.35720/
Public Sub EscapeXml (Raw As String) As String
	Dim sb As StringBuilder
	sb.Initialize
	For i = 0 To Raw.Length - 1
		Dim c As Char = Raw.CharAt(i)
		Select c
			Case QUOTE
				sb.Append("&quot;")
			Case "'"
				sb.Append("&apos;")
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
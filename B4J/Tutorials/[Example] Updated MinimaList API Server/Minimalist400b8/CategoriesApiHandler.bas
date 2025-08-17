B4J=true
Group=Handlers
ModulesStructureVersion=1
Type=Class
Version=10.2
@EndOfDesignText@
'Handler class
Sub Class_Globals
	Private Request As ServletRequest
	Private Response As ServletResponse
	Private HRM As HttpResponseMessage
	Private Method As String
	Private Elements() As String
	Private ElementId As Int
End Sub

Public Sub Initialize
	HRM.Initialize
	HRM.VerboseMode = Main.conf.VerboseMode
	HRM.ContentType = Main.conf.ContentType
	HRM.XmlElement = "item"
End Sub

Sub Handle (req As ServletRequest, resp As ServletResponse)
	Request = req
	Response = resp
	Method = Request.Method.ToUpperCase
	Dim FullElements() As String = WebApiUtils.GetUriElements(Request.RequestURI)
	Elements = WebApiUtils.CropElements(FullElements, 3) ' 3 For Api handler
	Select Method
		Case "GET"
			If ElementMatch("") Then
				GetCategories
				Return
			End If
			If ElementMatch("id") Then
				GetCategoryById(ElementId)
				Return
			End If
		Case "POST"
			If ElementMatch("") Then
				PostCategory
				Return
			End If
		Case "PUT"
			If ElementMatch("id") Then
				PutCategoryById(ElementId)
				Return
			End If
		Case "DELETE"
			If ElementMatch("id") Then
				DeleteCategoryById(ElementId)
				Return
			End If
		Case Else
			Log("Unsupported method: " & Method)
			ReturnMethodNotAllow
			Return
	End Select
	ReturnBadRequest
End Sub

Private Sub ElementMatch (Pattern As String) As Boolean
	Select Pattern
		Case ""
			If Elements.Length = 0 Then
				Return True
			End If
		Case "id"
			If Elements.Length = 1 Then
				If IsNumber(Elements(0)) Then
					ElementId = Elements(0)
					Return True
				End If
			End If
	End Select
	Return False
End Sub

Private Sub ReturnApiResponse
	WebApiUtils.ReturnHttpResponse(HRM, Response)
End Sub

Private Sub ReturnBadRequest
	WebApiUtils.ReturnBadRequest(HRM, Response)
End Sub

Private Sub ReturnMethodNotAllow
	WebApiUtils.ReturnMethodNotAllow(HRM, Response)
End Sub

Private Sub GetCategories
	HRM.ResponseCode = 200
	HRM.ResponseData = Main.CategoriesList.List
	ReturnApiResponse
End Sub

Private Sub GetCategoryById (Id As Int)
	Dim M1 As Map = Main.CategoriesList.Find(Id)
	If M1.Size > 0 Then
		HRM.ResponseCode = 200
	Else
		HRM.ResponseCode = 404
	End If
	HRM.ResponseObject = M1
	ReturnApiResponse
End Sub

Private Sub PostCategory
	Dim data As Map
	If HRM.ContentType = WebApiUtils.CONTENT_TYPE_XML Then
		data = WebApiUtils.RequestDataXml(Request)
		data = data.Get("root")
	Else
		data = WebApiUtils.RequestDataJson(Request)
	End If
	If Not(data.IsInitialized) Then
		HRM.ResponseCode = 400
		HRM.ResponseError = "Invalid json object"
		ReturnApiResponse
		Return
	End If

	' Check whether required keys are provided
	Dim RequiredKeys As List = Array As String("category_name")
	For Each requiredkey As String In RequiredKeys
		If data.ContainsKey(requiredkey) = False Then
			HRM.ResponseCode = 400
			HRM.ResponseError = $"Key '${requiredkey}' not found"$
			ReturnApiResponse
			Return
		End If
	Next
	
	' Check conflict Category name
	Dim M1 As Map = Main.CategoriesList.FindByKey("category_name", data.Get("category_name"))
	If M1.Size > 0 Then
		HRM.ResponseCode = 409
		HRM.ResponseError = "Category Name already exist"
		ReturnApiResponse
		Return
	End If
	
	' Add created_date
	If Not(data.ContainsKey("created_date")) Then
		data.Put("created_date", WebApiUtils.CurrentDateTime)
	End If
	
	' Insert new row
	Main.CategoriesList.Add(data)
	Main.WriteKVS("CategoriesList", Main.CategoriesList)
	
	' Retrieve new row
	HRM.ResponseCode = 201
	HRM.ResponseObject = Main.CategoriesList.Last
	HRM.ResponseMessage = "Category created successfully"
	ReturnApiResponse
End Sub

Private Sub PutCategoryById (Id As Int)
	Dim data As Map
	If HRM.ContentType = WebApiUtils.CONTENT_TYPE_XML Then
		data = WebApiUtils.RequestDataXml(Request)
		data = data.Get("root")
	Else
		data = WebApiUtils.RequestDataJson(Request)
	End If
	If Not(data.IsInitialized) Then
		HRM.ResponseCode = 400
		HRM.ResponseError = "Invalid json object"
		ReturnApiResponse
		Return
	End If
	
	' Check whether required keys are provided
	If data.ContainsKey("Category_name") = False Then
		HRM.ResponseCode = 400
		HRM.ResponseError = "Key 'category_name' not found"
		ReturnApiResponse
		Return
	End If
	
	Dim M1 As Map = Main.CategoriesList.Find(Id)
	If M1.Size = 0 Then
		HRM.ResponseCode = 404
		HRM.ResponseError = "Id not found"
		ReturnApiResponse
		Return
	End If
	
	' Check conflict Category name
	Dim L1 As List = Main.CategoriesList.FindAll(Array("category_name"), Array(data.Get("category_name")))
	For Each M As Map In L1
		If Id <> M.Get("id") Then
			HRM.ResponseCode = 409
			HRM.ResponseError = "Category Name already exist"
			ReturnApiResponse
			Return
		End If
	Next

	' Add modified_date
	If Not(data.ContainsKey("modified_date")) Then
		data.Put("modified_date", WebApiUtils.CurrentDateTime)
	End If
	
	For Each Key As String In data.Keys
		M1.Put(Key, data.Get(Key))
	Next
	Main.WriteKVS("CategoriesList", Main.CategoriesList)

	HRM.ResponseCode = 200
	HRM.ResponseMessage = "Category updated successfully"
	HRM.ResponseObject = M1
	ReturnApiResponse
End Sub

Private Sub DeleteCategoryById (Id As Int)
	Dim Index As Int = Main.CategoriesList.IndexFromId(Id)
	If Index < 0 Then
		HRM.ResponseCode = 404
		HRM.ResponseError = "Id not found"
		ReturnApiResponse
		Return
	End If
	
	Main.CategoriesList.Remove(Index)
	Main.WriteKVS("CategoriesList", Main.CategoriesList)
	
	HRM.ResponseCode = 200
	HRM.ResponseMessage = "Category Deleted"
	ReturnApiResponse
End Sub
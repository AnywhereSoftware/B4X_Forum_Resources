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
				GetProducts
				Return
			End If
			If ElementMatch("id") Then
				GetProductById(ElementId)
				Return
			End If
		Case "POST"
			If ElementMatch("") Then
				PostProduct
				Return
			End If
		Case "PUT"
			If ElementMatch("id") Then
				PutProductById(ElementId)
				Return
			End If
		Case "DELETE"
			If ElementMatch("id") Then
				DeleteProductById(ElementId)
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

Private Sub GetProducts
	HRM.ResponseCode = 200
	HRM.ResponseData = Main.ProductsList.List
	ReturnApiResponse
End Sub

Private Sub GetProductById (Id As Int)
	HRM.ResponseCode = 200
	HRM.ResponseObject = Main.ProductsList.Find(Id)
	ReturnApiResponse
End Sub

Private Sub PostProduct
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
	Dim RequiredKeys As List = Array As String("category_id", "product_code", "product_name")
	For Each requiredkey As String In RequiredKeys
		If data.ContainsKey(requiredkey) = False Then
			HRM.ResponseCode = 400
			HRM.ResponseError = $"Key '${requiredkey}' not found"$
			ReturnApiResponse
			Return
		End If
	Next
	
	' Check conflict Product Code
	Dim M1 As Map = Main.ProductsList.FindByKey("product_code", data.Get("product_code"))
	If M1.Size > 0 Then
		HRM.ResponseCode = 409
		HRM.ResponseError = "Product Code already exist"
		ReturnApiResponse
		Return
	End If
	
	' Insert new row
	If Not(data.ContainsKey("created_date")) Then
		data.Put("created_date", WebApiUtils.CurrentDateTime)
	End If

	Main.ProductsList.Add(data)
	Main.WriteKVS("ProductsList", Main.ProductsList)

	' Retrieve new row
	HRM.ResponseCode = 201
	HRM.ResponseMessage = "Product created successfully"
	HRM.ResponseObject = Main.ProductsList.Last
	ReturnApiResponse
End Sub

Private Sub PutProductById (Id As Int)
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
	
	Dim M1 As Map = Main.ProductsList.Find(Id)
	If M1.Size = 0 Then
		HRM.ResponseCode = 404
		HRM.ResponseError = "Id not found"
		ReturnApiResponse
		Return
	End If
	
	' Check whether required keys are provided
	Dim RequiredKeys As List = Array As String("category_id", "product_code", "product_name")
	For Each requiredkey As String In RequiredKeys
		If data.ContainsKey(requiredkey) = False Then
			HRM.ResponseCode = 400
			HRM.ResponseError = $"Key '${requiredkey}' not found"$
			ReturnApiResponse
			Return
		End If
	Next
	
	' Check conflict Product Code
	Dim L1 As List = Main.ProductsList.FindAll(Array("product_code"), Array(data.Get("product_code")))
	For Each M As Map In L1
		If Id <> M.Get("id") Then
			HRM.ResponseCode = 409
			HRM.ResponseError = "Product Code already exist"
			ReturnApiResponse
			Return
		End If
	Next

	If Not(data.ContainsKey("modified_date")) Then
		data.Put("modified_date", WebApiUtils.CurrentDateTime)
	End If
				
	For Each Key As String In data.Keys
		Select Key
			Case "id", "category_id"
				M1.Put(Key, data.Get(Key).As(Long))
			Case "product_price"
				M1.Put(Key, data.Get(Key).As(Double))
			Case Else
				M1.Put(Key, data.Get(Key))
		End Select
	Next
	Main.WriteKVS("ProductsList", Main.ProductsList)

	HRM.ResponseCode = 200
	HRM.ResponseMessage = "Product updated successfully"
	HRM.ResponseObject = M1
	ReturnApiResponse
End Sub

Private Sub DeleteProductById (Id As Int)
	Dim Index As Int = Main.ProductsList.IndexFromId(Id)
	If Index < 0 Then
		HRM.ResponseCode = 404
		HRM.ResponseError = "Id not found"
		ReturnApiResponse
		Return
	End If
	
	Main.ProductsList.Remove(Index)
	Main.WriteKVS("ProductsList", Main.ProductsList)
		
	HRM.ResponseCode = 200
	HRM.ResponseMessage = "Product Deleted"
	ReturnApiResponse
End Sub
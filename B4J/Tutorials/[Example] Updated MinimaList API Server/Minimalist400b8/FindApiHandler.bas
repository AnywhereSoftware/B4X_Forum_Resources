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
	Private ElementKey As String
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
				GetAllProducts
				Return
			End If
			If ElementMatch("key/id") Then
				If ElementKey = "products-by-category_id" Then
				GetProductsByCategoryId(ElementId)
				Return
				End If
			End If
		Case "POST"
			If ElementMatch("") Then
				SearchByKeywords
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
		Case "key/id"
			If Elements.Length = 2 Then
				ElementKey = Elements(0)
				If IsNumber(Elements(1)) Then
					ElementId = Elements(1)
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

Private Sub GetAllProducts
	Dim ProductsList As List = Main.ProductsList.Clone.List
	For Each M As Map In ProductsList
		Dim category_id As Int = M.Get("category_id")
		Dim category_name As String = Main.CategoriesList.Find(category_id).Get("category_name")
		M.Put("category", category_name)
		M.Put("catid", category_id)
		M.Remove("category_id")
		M.Put("code", M.Get("product_code"))
		M.Remove("product_code")
		M.Put("name", M.Get("product_name"))
		M.Remove("product_name")
		M.Put("price", M.Get("product_price"))
		M.Remove("product_price")
	Next
	HRM.ResponseCode = 200
	HRM.ResponseData = ProductsList
	ReturnApiResponse
End Sub

Private Sub GetProductsByCategoryId (id As Int)
	Dim ProductsList As List = Main.ProductsList.Clone.List
	For Each M As Map In ProductsList
		Dim category_name As String = Main.CategoriesList.Find(id).Get("category_name")
		M.Put("category", category_name)
		M.Put("catid", id)
		M.Remove("category_id")
		M.Put("code", M.Get("product_code"))
		M.Remove("product_code")
		M.Put("name", M.Get("product_name"))
		M.Remove("product_name")
		M.Put("price", M.Get("product_price"))
		M.Remove("product_price")
	Next
	Dim SortedList As MinimaList
	SortedList.Initialize
	SortedList.List = ProductsList
	SortedList.SortByKey("id", True)
	HRM.ResponseCode = 200
	HRM.ResponseData = SortedList.List
	ReturnApiResponse
End Sub

Private Sub SearchByKeywords
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
	If data.ContainsKey("keyword") = False Then
		HRM.ResponseCode = 400
		HRM.ResponseError = "Key 'keyword' not found"
		ReturnApiResponse
		Return
	End If
	Dim SearchForText As String = data.Get("keyword")
	Dim ProductsList As List = Main.ProductsList.Clone.List
	For Each M As Map In ProductsList
		Dim category_id As Int = M.Get("category_id")
		Dim category_name As String = Main.CategoriesList.Find(category_id).Get("category_name")
		M.Put("category", category_name)
		M.Put("catid", category_id)
		M.Remove("category_id")
		M.Put("code", M.Get("product_code"))
		M.Remove("product_code")
		M.Put("name", M.Get("product_name"))
		M.Remove("product_name")
		M.Put("price", M.Get("product_price"))
		M.Remove("product_price")
	Next
	Dim SortedList As MinimaList
	SortedList.Initialize
	SortedList.List = ProductsList
	SortedList.SortByKey("id", True)
	HRM.ResponseCode = 200
	HRM.ResponseData = SortedList.FindAnyLike(Array("code", "name", "category"), Array(SearchForText, SearchForText, SearchForText))
	ReturnApiResponse
End Sub
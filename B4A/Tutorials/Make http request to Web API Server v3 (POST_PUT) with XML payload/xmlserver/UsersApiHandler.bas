B4J=true
Group=Handlers
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
'Handler class
Sub Class_Globals
		Private Request As ServletRequest
		Private Response As ServletResponse
		Private HRM As HttpResponseMessage
		Private DB As MiniORM
		Private Method As String
		Private Elements() As String
		Private ElementId As Int
End Sub

Public Sub Initialize
	HRM.Initialize
	HRM.SimpleResponse = Main.Config.SimpleResponse
	DB.Initialize(Main.DBOpen, Main.DBEngine)
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
				GetUsers
				Return
			End If
			If ElementMatch("id") Then
				GetUserById(ElementId)
				Return
			End If
		Case "POST"
			If ElementMatch("") Then
				PostUser
				Return
			End If
		Case "PUT"
			If ElementMatch("id") Then
				PutUserById(ElementId)
				Return
			End If
		Case "DELETE"
			If ElementMatch("id") Then
				DeleteUserById(ElementId)
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

Private Sub GetUsers
	' #Desc = Read all Users
	DB.Table = "tbl_users"
	DB.Query
	HRM.ResponseCode = 200
	HRM.ResponseData = DB.Results
	ReturnApiResponse
	DB.Close
End Sub

Private Sub GetUserById (Id As Int)
	' #Desc = Read one User by id
	' #Elements = [":id"]
	DB.Table = "tbl_users"
	DB.Find(Id)
	If DB.Found Then
		HRM.ResponseCode = 200
		HRM.ResponseObject = DB.First
	Else
		HRM.ResponseCode = 404
		HRM.ResponseError = "User not found"
	End If
	ReturnApiResponse
	DB.Close
End Sub

Private Sub PostUser
	' #Desc = Add a new User
	' #Body = &lt;user&gt;<br>&nbsp; &nbsp; &lt;name&gt;<br>&nbsp; &nbsp; &nbsp; &nbsp; Aeric<br>&nbsp; &nbsp; &lt;/name&gt;<br>&nbsp; &nbsp; &lt;email&gt;<br>&nbsp; &nbsp; &nbsp; &nbsp; acme@email.com<br>&nbsp; &nbsp; &lt;/email&gt;<br>&nbsp; &nbsp; &lt;password&gt;<br>&nbsp; &nbsp; &nbsp; &nbsp; very_secure<br>&nbsp; &nbsp; &lt;/password&gt;<br>&lt;/user&gt;
	Dim data As Map = WebApiUtils.RequestDataXml(Request)
	'Log(data)
	If Not(data.IsInitialized) Then
		HRM.ResponseCode = 400
		HRM.ResponseError = "Invalid xml object"
		ReturnApiResponse
		Return
	End If
	
	' Check whether first level key 'user' exist
	If data.ContainsKey("user") = False Then
		HRM.ResponseCode = 400
		HRM.ResponseError = $"Key 'user' not found"$
		ReturnApiResponse
		Return
	End If

	' extract second level data from key 'user'
	Dim user As Map = data.Get("user")
	Log(user.IsInitialized)
	If Not(user.IsInitialized) Then
		HRM.ResponseCode = 400
		HRM.ResponseError = "Invalid xml object"
		ReturnApiResponse
		Return
	End If
	
	' Check whether required keys are provided
	Dim RequiredKeys As List = Array As String("name", "email", "password")
	For Each requiredkey As String In RequiredKeys
		If user.ContainsKey(requiredkey) = False Then
			HRM.ResponseCode = 400
			HRM.ResponseError = $"Key '${requiredkey}' not found"$
			ReturnApiResponse
			Return
		End If
	Next
	
	Dim user_name As String = user.Get("name")
	Dim user_email As String = user.Get("email")
	Dim user_password As String = user.Get("password")
	
	' Check conflict users email
	DB.Table = "tbl_users"
	DB.Where = Array("user_email = ?")
	DB.Parameters = Array As String(user_email.Trim)
	DB.Query
	If DB.Found Then
		HRM.ResponseCode = 409
		HRM.ResponseError = "User email already exist"
		ReturnApiResponse
		DB.Close
		Return
	End If
	
	' Insert new row
	DB.Reset
	DB.Columns = Array("user_name", "user_email", "user_password", "created_date")
	DB.Parameters = Array(user_name.Trim, user_email.Trim, user_password.Trim, user.GetDefault("created_date", WebApiUtils.CurrentDateTime).As(String).Trim)
	DB.Save
	
	' Retrieve new row
	HRM.ResponseCode = 201
	HRM.ResponseObject = DB.First
	HRM.ResponseMessage = "User created successfully"
	ReturnApiResponse
	DB.Close
End Sub

Private Sub PutUserById (Id As Int)
	' #Desc = Update User name by id
	' #Body = &lt;user&gt;<br>&nbsp; &nbsp; &lt;name&gt;<br>&nbsp; &nbsp; &nbsp; &nbsp; Aeric Poon<br>&nbsp; &nbsp; &lt;/name&gt;<br>&lt;/user&gt;
	' #Elements = [":id"]
	Dim data As Map = WebApiUtils.RequestDataXml(Request)
	Log(data)
	If Not(data.IsInitialized) Then
		HRM.ResponseCode = 400
		HRM.ResponseError = "Invalid xml object"
		ReturnApiResponse
		Return
	End If
	
	' Check whether first level key 'user' exist
	If data.ContainsKey("user") = False Then
		HRM.ResponseCode = 400
		HRM.ResponseError = $"Key 'user' not found"$
		ReturnApiResponse
		Return
	End If
	
	' extract second level data from key 'user'
	Dim user As Map = data.Get("user")
	Log(user.IsInitialized)
	If Not(user.IsInitialized) Then
		HRM.ResponseCode = 400
		HRM.ResponseError = "Invalid xml object"
		ReturnApiResponse
		Return
	End If
	
	' Check whether required keys are provided
	Dim RequiredKeys As List = Array As String("name")
	For Each requiredkey As String In RequiredKeys
		If user.ContainsKey(requiredkey) = False Then
			HRM.ResponseCode = 400
			HRM.ResponseError = $"Key '${requiredkey}' not found"$
			ReturnApiResponse
			Return
		End If
	Next
	
	DB.Table = "tbl_users"
	DB.Find(Id)
	If DB.Found = False Then
		HRM.ResponseCode = 404
		HRM.ResponseError = "User not found"
		ReturnApiResponse
		DB.Close
		Return
	End If

	Dim user_name As String = user.Get("name")
	
	DB.Reset
	DB.Columns = Array("user_name", "modified_date")
	DB.Parameters = Array(user_name.Trim, user.GetDefault("created_date", WebApiUtils.CurrentDateTime))
	DB.Id = Id
	DB.Save

	HRM.ResponseCode = 200
	HRM.ResponseMessage = "User name updated successfully"
	HRM.ResponseObject = DB.First
	ReturnApiResponse
	DB.Close
End Sub

Private Sub DeleteUserById (Id As Int)
	' #Desc = Delete User by id
	' #Elements = [":id"]
	DB.Table = "tbl_users"
	DB.Find(Id)
	If DB.Found = False Then
		HRM.ResponseCode = 404
		HRM.ResponseError = "User not found"
		ReturnApiResponse
		DB.Close
		Return
	End If
	
	DB.Reset
	DB.Id = Id
	DB.Delete
	HRM.ResponseCode = 200
	HRM.ResponseMessage = "User deleted successfully"
	ReturnApiResponse
	DB.Close
End Sub
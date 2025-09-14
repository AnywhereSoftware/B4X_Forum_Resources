B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
Private Sub Class_Globals
	Private xui As XUI
	Private m_Pocketbase As Pocketbase
	Private m_ApiEndpoint As String = "collections"
	
	Type PocketbaseTokenInformations (Id As String,AccessToken As String, AccessExpiry As Long, Valid As Boolean,TokenType As String,Email As String,Tag As Object)
	Private sti_Token As PocketbaseTokenInformations
	
	Private m_User As PocketbaseUser 'Ignore
	
	Private Const TokenFile As String = "Pocketbaseauthtoken.dat"
	Private m_UserCollectionName As String = "users"
	Private TokenFolder As String
	
	Private mEventName As String 'ignore
	
	'************OAuth*********
	
'	Private CurrentClientId As String
'	Private CurrentProvider As String
	Private packageName As String 'ignore
'	#if B4A
'	Private LastIntent As Intent
'	#end if
'	
'	#if B4J
'	Private server As ServerSocket
'	#If UI
'	Private fx As JFX
'	#End If
'	Private port As Int = 3000
'	Private astream As AsyncStreams
'	#Else If B4I
'	Private dele_gate As Object 'ignore
'	Public btn As B4XView
'	#End if
'	
'	Private m_ClientSecret As String
	
	'*********************
	
	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(ThisPocketbase As Pocketbase, EventName As String)
	m_Pocketbase = ThisPocketbase
	mEventName = EventName
	
	#If B4A
	packageName = Application.PackageName
	TokenFolder = File.DirInternal
	#Else If B4i
		TokenFolder = File.DirLibrary
		packageName = GetPackageName
	#Else If B4J
	TokenFolder = File.DirApp
	#End If
	
	If File.Exists(TokenFolder, TokenFile) Then
		Dim raf As RandomAccessFile
		raf.Initialize(TokenFolder, TokenFile, True)
		If raf.Size <> 0 Then
			sti_Token = raf.ReadB4XObject(raf.CurrentPosition)
		End If
		raf.Close
	End If
	
End Sub

#Region Properties

'Checks if the user is logged in, renews the access token if it has expired
'<code>Wait For (xPocketbase.Auth.isUserLoggedIn) Complete (isLoggedIn As Boolean)</code>
Public Sub isUserLoggedIn As ResumableSub
	Wait For (m_Pocketbase.Auth.GetAccessToken) Complete (AccessToken As String)
	Return AccessToken <> ""
End Sub

Public Sub getTokenInformations As PocketbaseTokenInformations
	Return sti_Token
End Sub

'Change it only if you change the default "users" table name
Public Sub setUserCollectionName(Name As String)
	m_UserCollectionName = Name
End Sub

Public Sub getUserCollectionName As String
	Return m_UserCollectionName
End Sub

#End Region

#Region Methods

'User tokens and infos are removed from the device
'<code>
'	Wait For (xPocketbase.Auth.Logout) Complete (Result As PocketbaseError)
'	If Result.Success Then
'		Log("successfully logged out")
'	Else
'		Log("Error: " & Result.ErrorMessage)
'	End If
'</code>
Public Sub Logout As ResumableSub
	
	Dim DatabaseError As PocketbaseError
	DatabaseError.Initialize
	
	If m_Pocketbase.LogEvents Then Log("PocketbaseAuth: Token reset!!!")
	sti_Token.Valid = False
	sti_Token.AccessExpiry = 0
	sti_Token.AccessToken = ""
	sti_Token.Email = ""
	sti_Token.Id = 0
	sti_Token.TokenType = ""
	SaveToken
	m_User.Initialize
	AuthStateChange("signedOut")
	Return DatabaseError
	
End Sub

'Allow your users to sign up and create a new account.
'Options - Optional fields
'A full list of values you find in the dashboard in the “API Preview” in the “users” collection
'<code>
'	Wait For (xPocketbase.Auth.SignUp("test@example.com","Test123!","Test123!",Null)) Complete (NewUser As PocketbaseUser)
'	If NewUser.Error.Success Then
'		Log("successfully registered with " & NewUser.Email)
'	Else
'		Log("Error: " & NewUser.Error.ErrorMessage)
'	End If
'</code>
Public Sub SignUp(Email As String,Password As String,PasswordConfirm As String,Options As Map) As ResumableSub
	
	Dim url As String = $"${m_Pocketbase.URL}/${m_ApiEndpoint}/${m_UserCollectionName}/records"$
	
	Dim m_Parameters As Map
	m_Parameters.Initialize
	If Email <> "" And Password <> "" Then
		m_Parameters.Put("email",Email)
		m_Parameters.Put("password",Password)
		m_Parameters.Put("passwordConfirm",PasswordConfirm)
	End If
	
	If Options <> Null And Options.IsInitialized Then
		
		For Each k As String In Options.Keys
			m_Parameters.Put(k,Options.Get(k))
		Next
		
	End If
	
	Dim json As JSONGenerator
	json.Initialize(m_Parameters)
	
	Dim j As HttpJob : j.Initialize("",Me)
	j.PostString(url,json.ToString)
	j.GetRequest.SetContentType("application/json")
	
	Wait For (j) JobDone(j As HttpJob)

	Dim m_ResultMap As Map = Pocketbase_InternFunctions.GenerateResult(j)


	Dim User As PocketbaseUser
	User.Initialize

	Dim DatabaseError As PocketbaseError
	DatabaseError.Initialize
	DatabaseError.Success = j.Success
	If DatabaseError.Success = False Then
		If m_ResultMap.ContainsKey("status") Then
			DatabaseError.StatusCode = m_ResultMap.Get("status")
			DatabaseError.ErrorMessage = m_ResultMap.Get("message")
			DatabaseError.Data = m_ResultMap.Get("data")
		End If
	End If
	User.Error = DatabaseError

	If DatabaseError.Success Then
		m_User = FillUserObject(User,m_ResultMap)
		m_User.Email = Email
		m_User.Error = DatabaseError
		AuthStateChange("registered")
	Else
		m_User.Error = DatabaseError
	End If

	Return m_User
	
		#IF Documentation

		#End If
	
End Sub

'Sends users account verification request
'<code>
'	Wait For (xPocketbase.Auth.RequestVerification("test@example.com")) Complete (Success As PocketbaseError)
'	If Success.Success Then
'		Log("verification code send to email")
'	Else
'		Log("Error: " & Success.ErrorMessage)
'	End If
'</code>
Public Sub RequestVerification(Email As String) As ResumableSub
	Dim url As String = $"${m_Pocketbase.URL}/${m_ApiEndpoint}/${m_UserCollectionName}/request-verification"$
	
	Dim m_Parameters As Map
	m_Parameters.Initialize
	If Email <> "" Then
		m_Parameters.Put("email",Email)
	End If
	
	Dim json As JSONGenerator
	json.Initialize(m_Parameters)
	
	Dim j As HttpJob : j.Initialize("",Me)
	j.PostString(url,json.ToString)
	j.GetRequest.SetContentType("application/json")
	
	Wait For (j) JobDone(j As HttpJob)

	Dim m_ResultMap As Map = Pocketbase_InternFunctions.GenerateResult(j)


	Dim DatabaseError As PocketbaseError
	DatabaseError.Initialize
	DatabaseError.Success = j.Success
	If DatabaseError.Success = False Then
		If m_ResultMap.ContainsKey("status") Then
			DatabaseError.StatusCode = m_ResultMap.Get("status")
			DatabaseError.ErrorMessage = m_ResultMap.Get("message")
			DatabaseError.Data = m_ResultMap.Get("data")
		End If
	End If

	Return DatabaseError
End Sub

'Confirms the user account with the verification token from the e-mail
'<code>
'	Wait For (xPocketbase.Auth.ConfirmVerification("xxx")) Complete (Success As PocketbaseError)
'	If Success.Success Then
'		Log("verification sucessfull")
'	Else
'		Log("Error: " & Success.ErrorMessage)
'	End If
'</code>
Public Sub ConfirmVerification(VerificationToken As String) As ResumableSub
	Dim url As String = $"${m_Pocketbase.URL}/${m_ApiEndpoint}/${m_UserCollectionName}/confirm-verification"$
	
	Dim m_Parameters As Map
	m_Parameters.Initialize
	If VerificationToken <> "" Then
		m_Parameters.Put("token",VerificationToken)
	End If
	
	Dim json As JSONGenerator
	json.Initialize(m_Parameters)
	
	Dim j As HttpJob : j.Initialize("",Me)
	j.PostString(url,json.ToString)
	j.GetRequest.SetContentType("application/json")
	
	Wait For (j) JobDone(j As HttpJob)

	Dim m_ResultMap As Map = Pocketbase_InternFunctions.GenerateResult(j)


	Dim DatabaseError As PocketbaseError
	DatabaseError.Initialize
	DatabaseError.Success = j.Success
	If DatabaseError.Success = False Then
		If m_ResultMap.ContainsKey("status") Then
			DatabaseError.StatusCode = m_ResultMap.Get("status")
			DatabaseError.ErrorMessage = m_ResultMap.Get("message")
			DatabaseError.Data = m_ResultMap.Get("data")
		End If
	End If

	Return DatabaseError
End Sub

'Authenticate with combination of email and password
'<code>
'	Wait For (xPocketbase.Auth.AuthWithPassword("test@example.com","Test123!")) Complete (User As PocketbaseUser)
'	If User.Error.Success Then
'		Log("successfully logged in with " & User.Email)
'	Else
'		Log("Error: " & User.Error.ErrorMessage)
'	End If
'</code>
Public Sub AuthWithPassword(Email As String,Password As String) As ResumableSub
	
	Dim url As String = $"${m_Pocketbase.URL}/${m_ApiEndpoint}/${m_UserCollectionName}/auth-with-password"$
	'Log(url)
	Dim json As JSONGenerator
	json.Initialize(CreateMap("identity":Email,"password":Password))
	
	Dim j As HttpJob : j.Initialize("",Me)
	j.PostString(url,json.ToString)
	j.GetRequest.SetContentType("application/json")
	
	Wait For (j) JobDone(j As HttpJob)

	Dim m_ResultMap As Map = Pocketbase_InternFunctions.GenerateResult(j)

	Dim User As PocketbaseUser
	User.Initialize

	Dim DatabaseError As PocketbaseError
	DatabaseError.Initialize
	DatabaseError.Success = j.Success
	If DatabaseError.Success = False Then
		If m_ResultMap.ContainsKey("status") Then
			DatabaseError.StatusCode = m_ResultMap.Get("status")
			DatabaseError.ErrorMessage = m_ResultMap.Get("message")
			DatabaseError.Data = m_ResultMap.Get("data")
		End If
	End If
	User.Error = DatabaseError

	User = FillUserObject(User,m_ResultMap)

	Return User
	
		#IF Documentation

		#End If
	
End Sub

'Allow your users to sign up without requiring users to enter an email address, password
'It is strongly recommended to enable invisible Captcha or Cloudflare Turnstile to prevent abuse for anonymous sign-ins, you can more read about in the forum thread.
'<code>
'	Wait For (xPocketbase.Auth.LogIn_Anonymously) Complete (AnonymousUser As PocketbaseUser)
'	If AnonymousUser.Error.Success Then
'		Log("Successfully created an anonymous user")
'	Else
'		Log("Error: " & AnonymousUser.Error.ErrorMessage)
'	End If
'</code>
'Public Sub LogIn_Anonymously As ResumableSub
'	
''	Wait For (isUserLoggedIn) Complete (isLoggedIn As Boolean)
''	
''	If isLoggedIn Then
''		Wait For (GetUser) Complete (User As PocketbaseUser)
''		
''		If User.isAnonymous = False Then
''			If m_Pocketbase.LogEvents Then LogColor("PocketbaseAuth: LogIn_Anonymously - User is logged in with a non-anonymous user, this user is now logged out",xui.Color_Red)
''			Wait For (Logout) Complete (Result As PocketbaseError)
''			
''			Wait for (SignUp("","",Null)) Complete (NewUser As PocketbaseUser)
''			Return NewUser
''			
''		End If
''		
''		Return User
''	Else
''		Wait for (SignUp("","",Null)) Complete (NewUser As PocketbaseUser)
''		Return NewUser
''	End If
'	
'End Sub

'Gets the user object
'<code>Wait For (xPocketbase.Auth.GetUser) Complete (User As PocketbaseUser)</code>
Public Sub GetUser As ResumableSub
	
	Dim User As PocketbaseUser
	User.Initialize

	Dim DatabaseError As PocketbaseError
	DatabaseError.Initialize
	User.Error = DatabaseError
	
	If m_User.IsInitialized = False Or m_User.Id = "" Then
	
		Wait For (m_Pocketbase.Auth.GetAccessToken) Complete (AccessToken As String)
	
		Dim url As String = $"${m_Pocketbase.URL}/${m_ApiEndpoint}/${m_UserCollectionName}/records/${sti_Token.id}"$
	
		Dim j As HttpJob : j.Initialize("",Me)
		j.Download(url)
		j.GetRequest.SetHeader("Authorization","Bearer " & AccessToken)
		
		Wait For (j) JobDone(j As HttpJob)

		DatabaseError.Success = j.Success

		If j.Success = False Then
			DatabaseError.StatusCode = j.Response.StatusCode
			DatabaseError.ErrorMessage = j.ErrorMessage
		End If

		Dim m_ResultMap As Map = Pocketbase_InternFunctions.GenerateResult(j)
	
		m_User = FillUserObject(User,m_ResultMap)
	
	End If
	
	m_User.Error = DatabaseError
	Return m_User
	
End Sub

'Sends users password reset email request
'On successful password reset all previously issued auth tokens for the specific record will be automatically invalidated
'<code>
'	Wait for (xPocketbase.Auth.RequestPasswordReset("test@example.com")) Complete (Response As PocketbaseError)
'	If Response.Success Then
'		Log("Recovery email sent successfully")
'	Else
'		Log("Error: " & Response.ErrorMessage)
'	End If
'</code>
Public Sub RequestPasswordReset(Email As String) As ResumableSub
	
	Dim DatabaseError As PocketbaseError
	DatabaseError.Initialize
	
	Dim url As String = $"${m_Pocketbase.URL}/${m_ApiEndpoint}/${m_UserCollectionName}/request-password-reset"$
	
	Dim json As JSONGenerator
	json.Initialize(CreateMap("email":Email))
	
	Dim j As HttpJob : j.Initialize("",Me)
	j.PostString(url,json.ToString)
	j.GetRequest.SetContentType("application/json")
	
	Wait For (j) JobDone(j As HttpJob)

	DatabaseError.Success = j.Success

	If j.Success = False Then
		DatabaseError.StatusCode = j.Response.StatusCode
		DatabaseError.ErrorMessage = j.ErrorMessage
	Else
		AuthStateChange("passwordResetRequested")
	End If

	'Dim m_ResultMap As Map = Pocketbase_InternFunctions.GenerateResult(j)
	
	Return DatabaseError
End Sub

'Confirms the password reset with the verification token from the e-mail
'<code>
'	Wait For (xPocketbase.Auth.ConfirmPasswordReset("xxx","Test123!","Test123!")) Complete (Response As PocketbaseError)
'	If Response.Success Then
'		Log("Password change successfully")
'	Else
'		Log("Error: " & Response.ErrorMessage)
'	End If
'</code>
Public Sub ConfirmPasswordReset(Token As String,NewPassword As String,NewPasswordConfirm As String) As ResumableSub
	
	Dim DatabaseError As PocketbaseError
	DatabaseError.Initialize
	
	Dim url As String = $"${m_Pocketbase.URL}/${m_ApiEndpoint}/${m_UserCollectionName}/confirm-password-reset"$
	
	Dim json As JSONGenerator
	json.Initialize(CreateMap("token":Token,"password":NewPassword,"passwordConfirm":NewPasswordConfirm))
	
	Dim j As HttpJob : j.Initialize("",Me)
	j.PostString(url,json.ToString)
	j.GetRequest.SetContentType("application/json")
	
	Wait For (j) JobDone(j As HttpJob)

	DatabaseError.Success = j.Success

	If j.Success = False Then
		DatabaseError.StatusCode = j.Response.StatusCode
		DatabaseError.ErrorMessage = j.ErrorMessage
	Else
		AuthStateChange("passwordResetConfirmed")
	End If

	'Dim m_ResultMap As Map = Pocketbase_InternFunctions.GenerateResult(j)
	
	Return DatabaseError
End Sub

'Update a single users record
'A full list of values you find in the dashboard in the “API Preview” in the “users” collection
'<code>Wait For (xPocketbase.Auth.UpdateUser(CreateMap("name":"Test Name"))) Complete (Success As PocketbaseError)</code>
Public Sub UpdateUser(Options As Map) As ResumableSub
	
	Dim DatabaseError As PocketbaseError
	DatabaseError.Initialize
	
	Wait For (m_Pocketbase.Auth.GetAccessToken) Complete (AccessToken As String)
	If AccessToken = "" Then
		DatabaseError.StatusCode = 401
		DatabaseError.ErrorMessage = "Unauthorized"
		Return DatabaseError
	End If
	
	Dim url As String = $"${m_Pocketbase.URL}/${m_ApiEndpoint}/${m_UserCollectionName}/records/${sti_Token.id}"$
	
	Dim json As JSONGenerator
	json.Initialize(Options)
	
	Dim j As HttpJob : j.Initialize("",Me)
	j.PatchString(url,json.ToString)
	j.GetRequest.SetContentType("application/json")
	j.GetRequest.SetHeader("Authorization","Bearer " & AccessToken)
	
	Wait For (j) JobDone(j As HttpJob)

	DatabaseError.Success = j.Success

	If j.Success = False Then
		DatabaseError.StatusCode = j.Response.StatusCode
		DatabaseError.ErrorMessage = j.ErrorMessage
	Else
		AuthStateChange("userUpdated")
	End If

'	Dim m_ResultMap As Map = Pocketbase_InternFunctions.GenerateResult(j)
'	Log(Pocketbase_InternFunctions.GenerateResult(j))
	
	Return DatabaseError
	
End Sub

'Delete a single users record
'<code>Wait For (xPocketbase.Auth.DeleteUser) Complete (Result As PocketbaseError)</code>
Public Sub DeleteUser As ResumableSub
	
	Dim User As PocketbaseUser
	User.Initialize

	Dim DatabaseError As PocketbaseError
	DatabaseError.Initialize
	User.Error = DatabaseError
	
	Wait For (m_Pocketbase.Auth.GetAccessToken) Complete (AccessToken As String)
	
	Dim url As String = $"${m_Pocketbase.URL}/${m_ApiEndpoint}/${m_UserCollectionName}/records/${sti_Token.id}"$
	
	Dim j As HttpJob : j.Initialize("",Me)
	j.Delete(url)
	j.GetRequest.SetHeader("Authorization","Bearer " & AccessToken)
	
	Wait For (j) JobDone(j As HttpJob)

	DatabaseError.Success = j.Success

	If j.Success = False Then
		DatabaseError.StatusCode = j.Response.StatusCode
		DatabaseError.ErrorMessage = j.ErrorMessage
	End If
	
	Return DatabaseError

End Sub

'Sends users email change request
'On successful email change all previously issued auth tokens for the specific record will be automatically invalidated
'<code>
'	Wait For (xPocketbase.Auth.RequestEmailChange("test@example.com")) Complete (Success As PocketbaseError)
'	If Success.Success Then
'		Log("E-Mail change request sent")
'	Else
'		Log("Error: " & Success.ErrorMessage)
'	End If
'</code>
Public Sub RequestEmailChange(NewEmail As String) As ResumableSub
	
	Dim DatabaseError As PocketbaseError
	DatabaseError.Initialize
	
	Dim url As String = $"${m_Pocketbase.URL}/${m_ApiEndpoint}/${m_UserCollectionName}/request-email-change"$
	
	Dim json As JSONGenerator
	json.Initialize(CreateMap("newEmail":NewEmail))
	
	Dim j As HttpJob : j.Initialize("",Me)
	j.PostString(url,json.ToString)
	j.GetRequest.SetContentType("application/json")
	
	Wait For (j) JobDone(j As HttpJob)

	DatabaseError.Success = j.Success

	If j.Success = False Then
		DatabaseError.StatusCode = j.Response.StatusCode
		DatabaseError.ErrorMessage = j.ErrorMessage
	Else
		AuthStateChange("emailChangeRequested")
	End If

	'Dim m_ResultMap As Map = Pocketbase_InternFunctions.GenerateResult(j)
	
	Return DatabaseError
End Sub

'Confirms the password reset with the verification token from the e-mail
'<code>
'	Wait For (xPocketbase.Auth.ConfirmEmailChange("xxx","Test123!")) Complete (Response As PocketbaseError)
'	If Response.Success Then
'		Log("E-Mail change successfully")
'	Else
'		Log("Error: " & Response.ErrorMessage)
'	End If
'</code>
Public Sub ConfirmEmailChange(Token As String,Password As String) As ResumableSub
	
	Dim DatabaseError As PocketbaseError
	DatabaseError.Initialize
	
	Dim url As String = $"${m_Pocketbase.URL}/${m_ApiEndpoint}/${m_UserCollectionName}/confirm-email-change"$
	
	Dim json As JSONGenerator
	json.Initialize(CreateMap("token":Token,"password":Password))
	
	Dim j As HttpJob : j.Initialize("",Me)
	j.PostString(url,json.ToString)
	j.GetRequest.SetContentType("application/json")
	
	Wait For (j) JobDone(j As HttpJob)

	DatabaseError.Success = j.Success

	If j.Success = False Then
		DatabaseError.StatusCode = j.Response.StatusCode
		DatabaseError.ErrorMessage = j.ErrorMessage
	Else
		AuthStateChange("emailChangeConfirmed")
	End If

	'Dim m_ResultMap As Map = Pocketbase_InternFunctions.GenerateResult(j)
	
	Return DatabaseError
End Sub

#End Region

#Region ExternFunctions

Public Sub SaveToken
	Dim raf As RandomAccessFile
	raf.Initialize(TokenFolder, TokenFile, False)
	raf.WriteB4XObject(sti_Token, raf.CurrentPosition)
	raf.Close
End Sub

Public Sub GetAccessToken As ResumableSub
	If sti_Token.Valid = False Then
		sti_Token.AccessToken = ""
		SaveToken
		If m_Pocketbase.LogEvents Then Log("PocketbaseAuth: User is logged out, this user must log in again")
		AuthStateChange("signedOut")
		'Authenticate
		'RaiseEvent_Authenticate
	Else If sti_Token.AccessExpiry < DateTime.Now Then
		'GetTokenFromRefresh
		'RaiseEvent_RefreshToken
		Wait For (RefreshToken) Complete (Success As Boolean)
		If Success = False Then
			sti_Token.AccessToken = ""
			SaveToken
			If m_Pocketbase.LogEvents Then Log("PocketbaseAuth: Access token could not be renewed")
			AuthStateChange("signedOut")
		End If
	Else
		'RaiseEvent_AccessTokenAvailable(True)
	End If
	Return sti_Token.AccessToken
End Sub

Public Sub RefreshToken As ResumableSub
	
	Dim url As String = $"${m_Pocketbase.URL}/${m_ApiEndpoint}/${m_UserCollectionName}/auth-refresh"$
	
	Dim j As HttpJob : j.Initialize("",Me)
	j.PostString(url,"")
	j.GetRequest.SetContentType("application/json")
	j.GetRequest.SetHeader("Authorization","Bearer " & sti_Token.AccessToken)
	
	Wait For (j) JobDone(j As HttpJob)
	
	'Dim m_ResultMap As Map = Pocketbase_InternFunctions.GenerateResult(j)
	If j.Success Then
		TokenInformationFromResponse(Pocketbase_InternFunctions.GenerateResult(j))
		AuthStateChange("tokenRefreshed")
		Return True
	Else
		Return False
	End If
	
End Sub

#End Region

#Region InternFunctions

Private Sub TokenInformationFromResponse (m As Map)
	
	Dim ThisMap As Map = m.Get("record")
	
	If ThisMap.ContainsKey("exp") Then sti_Token.AccessExpiry = DateTime.Now + ThisMap.Get("exp") * 1000 - 5 * 60 * 1000
	If m.ContainsKey("token") Then sti_Token.AccessToken = m.Get("token")
	If ThisMap.ContainsKey("email") Then
		sti_Token.Email = ThisMap.Get("email")
	End If
	If ThisMap.ContainsKey("id") Then
		sti_Token.Id = ThisMap.Get("id")
	End If
	sti_Token.Valid = True
	'If ThisMap.ContainsKey("tag") Then sti_Token.Tag = ThisMap.Get("tag")
	
	If m_Pocketbase.LogEvents Then Log($"PocketbaseAuth: Token received. Expires: ${DateUtils.TicksToString(sti_Token.AccessExpiry)}"$)
	SaveToken
	'RaiseEvent_AccessTokenAvailable(True)
End Sub

Private Sub FillUserObject(User As PocketbaseUser,ResultMap As Map) As PocketbaseUser
	If User.Error.Success Then
		Dim mUser As Map = ResultMap.Get("user")
		If mUser.IsInitialized = False And ResultMap.ContainsKey("record") Then mUser = ResultMap.Get("record")

		If mUser.IsInitialized = False Then mUser = ResultMap

		If mUser.ContainsKey("id") Then User.Id = mUser.Get("id")
		If mUser.ContainsKey("email") Then User.email = mUser.Get("email")
		If mUser.ContainsKey("verified") Then User.EmailConfirmed = mUser.Get("verified")
		If mUser.ContainsKey("created") Then User.createdat = Pocketbase_Functions.ParseDateTime(mUser.Get("created"))
		If mUser.ContainsKey("updated") Then User.createdat = Pocketbase_Functions.ParseDateTime(mUser.Get("updated"))
		
		'If mUser.ContainsKey("user_metadata") Then User.Metadata = mUser.Get("user_metadata")
		If mUser.ContainsKey("is_anonymous") Then User.isAnonymous = mUser.Get("is_anonymous")

		For Each k As String In mUser.Keys
			
			Select k
				Case "id","email","verified","created","updated"
					'Nothing to do
				Case Else
					If User.OptionalFields.IsInitialized = False Then User.OptionalFields.Initialize
					User.OptionalFields.Put(k,mUser.Get(k))
			End Select
		Next

	End If

	m_User = User

	If User.Error.Success And ResultMap.ContainsKey("token") Then
		Dim JWTMap As Map = Pocketbase_InternFunctions.GetJWTPayload(ResultMap.Get("token"))
		If ResultMap.ContainsKey("token") Then sti_Token.AccessToken = ResultMap.Get("token")
		If JWTMap.ContainsKey("type") Then sti_Token.tokentype = JWTMap.Get("type")
		If JWTMap.ContainsKey("exp") Then sti_Token.AccessExpiry = DateUtils.UnixTimeToTicks(JWTMap.Get("exp"))
		sti_Token.Valid = True
		sti_Token.Email = User.Email
		sti_Token.Id = User.Id
		If m_Pocketbase.LogEvents Then Log($"PocketbaseAuth: Token received. Expires: ${DateUtils.TicksToString(sti_Token.AccessExpiry)}"$)
		SaveToken
		AuthStateChange("signedIn")
	End If
	Return User
End Sub

#End Region

#Region SocialLogin

''https://pocketbase.io/docs/authentication/#authenticate-with-oauth2
'#IF B4J
''Signs the user in using third party OAuth providers.
''<code>
''	#If B4A
''	Wait For (xPocketbase.Auth.SignInWithOAuth("xxx.apps.googleusercontent.com","google","profile email https://www.googleapis.com/auth/userinfo.email")) Complete (User As PocketbaseUser)
''	#Else If B4I
''	Wait For (xPocketbase.Auth.SignInWithOAuth("xxx.apps.googleusercontent.com","google","profile email https://www.googleapis.com/auth/userinfo.email")) Complete (User As PocketbaseUser)
''	#Else If B4J
''	Wait For (xPocketbase.Auth.SignInWithOAuth("xxx.apps.googleusercontent.com","google","profile email https://www.googleapis.com/auth/userinfo.email","xxx")) Complete (User As PocketbaseUser)
''	#End If
''
''	If User.Error.Success Then
''		Log("successfully logged in with " & User.Email)
''	Else
''		Log("Error: " & User.Error.ErrorMessage)
''	End If
''</code>
'Public Sub SignInWithOAuth(ClientId As String,Provider As String,Scope As String,ClientSecret As String) As ResumableSub
'#Else
'	'Signs the user in using third party OAuth providers.
'	'<code>
''	#If B4A
''	Wait For (xPocketbase.Auth.SignInWithOAuth("xxx.apps.googleusercontent.com","google","profile email https://www.googleapis.com/auth/userinfo.email")) Complete (User As PocketbaseUser)
''	#Else If B4I
''	Wait For (xPocketbase.Auth.SignInWithOAuth("xxx.apps.googleusercontent.com","google","profile email https://www.googleapis.com/auth/userinfo.email")) Complete (User As PocketbaseUser)
''	#Else If B4J
''	Wait For (xPocketbase.Auth.SignInWithOAuth("xxx.apps.googleusercontent.com","google","profile email https://www.googleapis.com/auth/userinfo.email","xxx")) Complete (User As PocketbaseUser)
''	#End If
'	'
''	If User.Error.Success Then
''		Log("successfully logged in with " & User.Email)
''	Else
''		Log("Error: " & User.Error.ErrorMessage)
''	End If
'	'</code>
'Public Sub SignInWithOAuth(ClientId As String,Provider As String,Scope As String) As ResumableSub
'#End If
'	
'	#If B4J
'	m_ClientSecret = ClientSecret
'	#End If
'	
'	OAuth_Authenticate(ClientId,Provider,Scope)
'	
'	Wait For OAuthTokenReceived (Successful As Boolean)
'	
'	Dim DatabaseError As PocketbaseError
'	DatabaseError.Initialize
'	DatabaseError.Success = Successful
'	If DatabaseError.Success = False Then
'		DatabaseError.StatusCode = ""
'		DatabaseError.ErrorMessage = ""
'	End If
'	
'	If Successful Then
'		Wait For (GetUser) Complete (User As PocketbaseUser)
'		User.Error = DatabaseError
'		AuthStateChange("signedIn")
'		Return User
'	Else
'			
'		Dim User As PocketbaseUser
'		User.Initialize
'		User.Error = DatabaseError
'		Logout
'		Return User
'			
'			
'	End If
'	
'End Sub

#End Region

#Region Events

Private Sub AuthStateChange(StateType As String)
	If Pocketbase_InternFunctions.SubExists2(m_Pocketbase,mEventName & "_AuthStateChange",1) Then
		CallSub2(m_Pocketbase,mEventName & "_AuthStateChange",StateType)
	End If
End Sub

#End Region

#Region OAuth

Private Sub GetPackageName As String 'Ignore
	#If B4A
	Return Application.PackageName
	#Else If B4I
	Dim no As NativeObject
	no = no.Initialize("NSBundle").RunMethod("mainBundle", Null)
	Dim name As Object = no.RunMethod("objectForInfoDictionaryKey:", Array("CFBundleIdentifier"))
	Return name
	#Else If B4J
	Dim joBA As JavaObject
	joBA.InitializeStatic("anywheresoftware.b4a.BA")
	Return joBA.GetField("packageName")
	#End If
End Sub
'
'Private Sub OAuth_Authenticate(ClientId As String,Provider As String,Scope As String)
'	
'	CurrentClientId = ClientId
'	CurrentProvider = Provider
'
'	If Provider = "apple" Then
'		SignInWithApple
'	Else
'		
'			#if B4J
'		PrepareServer
'#End If
'		
'		If Provider = "google" Then
'			Dim link As String = BuildLink($"${m_Pocketbase.URL}/${m_ApiEndpoint}/${m_UserCollectionName}/auth-with-oauth2"$, _
'         CreateMap("client_id": ClientId, _
'        "redirectURL": GetRedirectUri, _
'        "code": "code", _
'        "provider": "google", _
'        "scope": Scope))
'		Else
'					
'			Dim link As String = BuildLink($"${m_Pocketbase.URL}/${m_ApiEndpoint}/${m_UserCollectionName}/auth-with-oauth2"$, _
'         CreateMap("client_id": ClientId, _
'        "redirectURL": $"${GetPackageName}://${m_Pocketbase.URL.Replace("https://","")}/${m_ApiEndpoint}/auth/v1/callback"$, _
'		 "code": "code", _
'        "scope": Scope))
'			'        '"redirectURL": $"com.stoltex.Pocketbase://${m_Pocketbase.URL.Replace("https://","")}/${m_ApiEndpoint}/auth/v1/callback"$, _
'	#if B4J
'			PrepareServer
'	#end if
'			'http://127.0.0.1:3000
'		End If
'		
'#if B4A
'		Dim pi As PhoneIntents
'		StartActivity(pi.OpenBrowser(link))
'#else if B4i
'		Main.App.OpenURL(link)
'#else if B4J and UI
'		fx.ShowExternalDocument(link)
'#end if
'		
'	End If
'	
'End Sub
'
'#if B4J
'Private Sub PrepareServer
'	If server.IsInitialized Then server.Close
'	If astream.IsInitialized Then astream.Close
'	Do While True
'		Try
'			server.Initialize(port, "server")
'			server.Listen
'			Exit
'		Catch
'			port = port + 1
'			Log("PocketbaseAuth: " & LastException)
'		End Try
'	Loop
'	Wait For server_NewConnection (Successful As Boolean, NewSocket As Socket)
'	If Successful Then
'		astream.Initialize(NewSocket.InputStream, NewSocket.OutputStream, "astream")
'		Dim Response As StringBuilder
'		Response.Initialize
'		Do While Response.ToString.Contains("Host:") = False
'			Wait For AStream_NewData (Buffer() As Byte)
'			Response.Append(BytesToString(Buffer, 0, Buffer.Length, "UTF8"))
'		Loop
'		astream.Write(("HTTP/1.0 200" & Chr(13) & Chr(10)).GetBytes("UTF8"))
'		Sleep(50)
'		astream.Close
'		server.Close
'		ParseBrowserUrl(Regex.Split2("$",Regex.MULTILINE, Response.ToString)(0))
'	End If
'	
'End Sub
'#else if B4A
'Public Sub CallFromResume(Intent As Intent)
'	If IsNewOAuth2Intent(Intent) Then
'		LastIntent = Intent
'		ParseBrowserUrl(Intent.GetData)
'	End If
'End Sub
'
'Private Sub IsNewOAuth2Intent(Intent As Intent) As Boolean
'	Return Intent.IsInitialized And Intent <> LastIntent And Intent.Action = Intent.ACTION_VIEW And _
'		Intent.GetData <> Null And Intent.GetData.StartsWith(Application.PackageName)
'End Sub
'#else if B4I
'Public Sub CallFromOpenUrl (url As String)
'	If url.StartsWith(packageName & ":/oath") Then
'		ParseBrowserUrl(url)
'	End If
'End Sub
'
'#end if
'
'Private Sub GetRedirectUri As String
'	#if B4J
'	Return "http://127.0.0.1:" & port
'	#Else
'	Return packageName & ":/oath"
'	#End If
'End Sub
'
'Private Sub BuildLink(Url As String, Params As Map) As String
'	Dim su As StringUtils
'	Dim sb As StringBuilder
'	sb.Initialize
'	sb.Append(Url)
'	If Params.Size > 0 Then
'		sb.Append("&")
'		For Each k As String In Params.Keys
'			sb.Append(su.EncodeUrl(k, "utf8")).Append("=").Append(su.EncodeUrl(Params.Get(k), "utf8"))
'			sb.Append("&")
'		Next
'		sb.Remove(sb.Length - 1, sb.Length)
'	End If
'	Return sb.ToString
'End Sub
'
'Private Sub ParseBrowserUrl(Response As String)
'	'Log(Response)
'	Dim m As Matcher = Regex.Matcher("code=([^&\s]+)", Response)
'	If m.Find Then
'		Dim code As String = m.Group(1)
'		If CurrentProvider = "google" Then
'			GetTokenFromGoogleAuthorizationCode(code)
'		Else
'			GetTokenFromPocketbase(code)
'		End If
'	Else
'		Log("PocketbaseAuth: Error parsing server response: " & Response)
'		Logout
'	End If
'End Sub
'
'Private Sub AddClientSecret (s As String) As String
'	If m_ClientSecret <> "" Then
'		s = s & "&client_secret=" & m_ClientSecret
'	End If
'	Return s
'End Sub
'
'Private Sub GetTokenFromPocketbase(IdToken As String)
'	
'	Dim j As HttpJob
'	j.Initialize("", Me)
'		
'	Dim json As JSONGenerator
'	json.Initialize(CreateMap("id_token":IdToken,"provider":CurrentProvider))
'		
'
'	j.PostString($"${m_Pocketbase.URL}/${m_ApiEndpoint}/auth/v1/token?grant_type=id_token"$, json.ToString)
'	j.GetRequest.SetContentType("application/json")
'		
'	Wait For (j) JobDone(j As HttpJob)
'	If j.Success Then
'		TokenInformationFromResponse(Pocketbase_InternFunctions.GenerateResult(j))
'		CallSubDelayed2(Me,"OAuthTokenReceived",True)
'	Else
'		Logout
'		CallSubDelayed2(Me,"OAuthTokenReceived",False)
'	End If
'	j.Release
'	
'End Sub
'
''********SignIn with Google****************
'
'Private Sub GetTokenFromGoogleAuthorizationCode (Code As String)
'	'Log("Getting access token from google authorization code...")
'	Dim j As HttpJob
'	j.Initialize("", Me)
'	Dim postString As String = $"code=${Code}&client_id=${CurrentClientId}&grant_type=authorization_code&redirect_uri=${GetRedirectUri}"$
'	postString = AddClientSecret(postString)
'	j.PostString("https://www.googleapis.com/oauth2/v4/token", postString)
'		
'	Wait For (j) JobDone(j As HttpJob)
'	If j.Success Then
'		
'		Dim tmp_result As Map = Pocketbase_InternFunctions.GenerateResult(j)
'		
'		GetTokenFromPocketbase(tmp_result.Get("id_token"))
'		
'	Else
'		Logout
'		CallSubDelayed2(Me,"OAuthTokenReceived",False)
'	End If
'	j.Release
'End Sub
'
''********SignIn with Apple*****************
'
'Private Sub SignInWithApple
'	#If B4I
'	Dim NativeButton As NativeObject
'	btn = NativeButton.Initialize("ASAuthorizationAppleIDButton").RunMethod("new", Null)
'	Dim no As NativeObject = Me
'	no.RunMethod("SetButton:", Array(btn))
'	'mBase.AddView(btn, 0, 0, mBase.Width, mBase.Height)
'	dele_gate = no.Initialize("AuthorizationDelegate").RunMethod("new", Null)
'	btn.As(NativeObject).RunMethod ("sendActionsForControlEvents:", Array (64)) ' UIControlEventTouchUpInside
'	#End If
'End Sub
'
'#If B4I
'
'Private Sub Auth_Result(Success As Boolean, Result As Object)
'	If Success Then
'		Dim no As NativeObject = Result
'		Dim credential As NativeObject = no.GetField("credential")
'		If GetType(credential) = "ASAuthorizationAppleIDCredential" Then
'			
'			Dim Token() As Byte = credential.NSDataToArray(credential.GetField("identityToken"))
'			
'			
'			GetTokenFromPocketbase(BytesToString(Token, 0, Token.Length, "UTF8"))
'			
'			Dim email, name As String
'			If credential.GetField("email").IsInitialized Then
'				Dim formatter As NativeObject
'				name = formatter.Initialize("NSPersonNameComponentsFormatter").RunMethod("localizedStringFromPersonNameComponents:style:options:", _
'					Array(credential.GetField("fullName"), 0, 0)).AsString
'				email = credential.GetField("email").AsString
'				'Log(email)
'				'Log(name)
'				'CallSub3(mCallBack, mEventName & "_AuthResult", name, email)
'			End If
'		Else
'			Log("Unexpected type: " & GetType(credential))
'		End If
'	End If
'End Sub
'
'#End If

#End Region

#Region Enums

'Public Sub getProvider_Google As String
'	Return "google"
'End Sub
'
''B4I Only
'Public Sub getProvider_Apple As String
'	Return "apple"
'End Sub

#End Region

'#if OBJC
'#import <AuthenticationServices/AuthenticationServices.h>
'- (void) SetButton:(ASAuthorizationAppleIDButton*)btn {
'	 [btn addTarget:self action:@selector(handleAuthorizationAppleIDButtonPress:) forControlEvents:UIControlEventTouchUpInside];
'}
'- (void) handleAuthorizationAppleIDButtonPress:(UIButton *) sender {
'	ASAuthorizationAppleIDProvider* provider = [ASAuthorizationAppleIDProvider new];
'	ASAuthorizationAppleIDRequest* req = [provider createRequest];
'	req.requestedScopes = @[ASAuthorizationScopeEmail, ASAuthorizationScopeFullName];
'	ASAuthorizationController* controller = [[ASAuthorizationController alloc] initWithAuthorizationRequests:
'		@[req]];
'	controller.delegate = self._dele_gate;
'	controller.presentationContextProvider = self._dele_gate;
'	[self._dele_gate setValue:self.bi forKey:@"bi"];
'	controller.performRequests;
'}
'@end
'@interface AuthorizationDelegate : NSObject<ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding>
'@property (nonatomic) B4I* bi;
'@end
'@implementation AuthorizationDelegate
'- (void)authorizationController:(ASAuthorizationController *)controller 
'   didCompleteWithAuthorization:(ASAuthorization *)authorization {
'   [self.bi raiseUIEvent:nil event:@"auth_result::" params:@[@(true), authorization]];
'  }
' - (void)authorizationController:(ASAuthorizationController *)controller 
'           didCompleteWithError:(NSError *)error {
'	 NSLog(@"error: %@", error);
'	 [self.bi raiseUIEvent:nil event:@"auth_result::" params:@[@(false), [NSNull null]]];
'}
'- (ASPresentationAnchor)presentationAnchorForAuthorizationController:(ASAuthorizationController *)controller  {
'	NSLog(@"presentationAnchorForAuthorizationController");
'	return UIApplication.sharedApplication.keyWindow;
'}
'#End If
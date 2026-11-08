B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=11.5
@EndOfDesignText@
Private Sub Class_Globals
	Private xui as XUI
	Private m_Supabase As Supabase
	
	Type SupabaseTokenInformations (AccessToken As String, RefreshToken As String, AccessExpiry As Long, Valid As Boolean,TokenType As String,Email As String,Tag As Object)
	Private sti_Token As SupabaseTokenInformations
	
	Private m_User As SupabaseUser 'Ignore
	
	Private Const TokenFile As String = "supabaseauthtoken.dat"
	Private TokenFolder As String
	
	Private mEventName As String 'ignore
	
	'************OAuth*********
	
	Private CurrentClientId As String
	Private CurrentProvider As String
	Private packageName As String 'ignore
	#if B4A
	Private LastIntent As Intent
	#end if
	
	#if B4J
	Private server As ServerSocket
	#If UI
	Private fx As JFX
	#End If
	Private port As Int = 3000
	Private astream As AsyncStreams
	#Else If B4I
	Private dele_gate As Object 'ignore
	Public btn As B4XView
	#End if
	
	Private m_ClientSecret As String
	
	'*********************
	
	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(ThisSupabase As Supabase, EventName As String)
	m_Supabase = ThisSupabase
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

'Checks if the user is logged in, renews the access token if it has expired
'<code>Wait For (xSupabase.Auth.isUserLoggedIn) Complete (isLoggedIn As Boolean)</code>
Public Sub isUserLoggedIn As ResumableSub
	Wait For (m_Supabase.Auth.GetAccessToken) Complete (AccessToken As String)
	Return AccessToken <> ""
End Sub

Public Sub TokenInformations As SupabaseTokenInformations
	Return sti_Token
End Sub

Private Sub TokenInformationFromResponse (m As Map)
	If m.ContainsKey("expires_in") Then sti_Token.AccessExpiry = DateTime.Now + m.Get("expires_in") * 1000 - 5 * 60 * 1000
	If m.ContainsKey("access_token") Then sti_Token.AccessToken = m.Get("access_token")
	If m.ContainsKey("email") Then 
		sti_Token.Email = m.Get("email")
		Else
		If m.ContainsKey("user") And m.Get("user").As(Map).ContainsKey("email") Then
			sti_Token.Email = m.Get("user").As(Map).Get("email")
		End If
	End If
	If m.ContainsKey("refresh_token") Then sti_Token.RefreshToken = m.Get("refresh_token")
	sti_Token.Valid = True
	'If m.ContainsKey("tag") Then sti_Token.Tag = m.Get("tag")
	
	If m_Supabase.LogEvents Then Log($"SupabaseAuth: Token received. Expires: ${DateUtils.TicksToString(sti_Token.AccessExpiry)}"$)
	SaveToken
	'RaiseEvent_AccessTokenAvailable(True)
End Sub

Public Sub SaveToken
	Dim raf As RandomAccessFile
	raf.Initialize(TokenFolder, TokenFile, False)
	raf.WriteB4XObject(sti_Token, raf.CurrentPosition)
	raf.Close
End Sub

'User tokens are removed from the device
'After calling log out, all interactions using the Supabase B4X client will be "anonymous".
'<code>
'	Wait For (xSupabase.Auth.Logout) Complete (Result As SupabaseError)
'	If Result.Success Then
'		Log("User successfully logged out")
'	Else
'		Log("Error: " & Result.ErrorMessage)
'	End If
'</code>
Public Sub Logout As ResumableSub
	
	Dim DatabaseError As SupabaseError
	DatabaseError.Initialize
	
	Wait For (m_Supabase.Auth.GetAccessToken) Complete (AccessToken As String)
	If AccessToken = "" Then
		DatabaseError.StatusCode = 401
		DatabaseError.ErrorMessage = "Unauthorized"
		Return DatabaseError
	End If
	
	Dim url As String = $"${m_Supabase.URL}/auth/v1/logout"$
	
	Dim json As JSONGenerator
	json.Initialize(CreateMap("refresh_token":sti_Token.RefreshToken))
	
	Dim j As HttpJob : j.Initialize("",Me)
	j.PostString(url,json.ToString)
	j.GetRequest.SetContentType("application/json")
	j.GetRequest.SetHeader("apikey",m_Supabase.ApiKey)
	j.GetRequest.SetHeader("Authorization","Bearer " & AccessToken)
	
	Wait For (j) JobDone(j As HttpJob)
	
	If j.Success Then
			
	Else
		DatabaseError.StatusCode = j.Response.StatusCode
		DatabaseError.ErrorMessage = j.ErrorMessage
	End If
	
	If m_Supabase.LogEvents Then Log("SupabaseAuth: Token reset!!!")
	sti_Token.Valid = False
	SaveToken
	AuthStateChange("signedOut")
	Return DatabaseError
	
End Sub

'Send a user a passwordless link which they can use to sign up and log in.
'Public Sub InviteUser As ResumableSub
'	
'	
'	
'End Sub

Public Sub GetAccessToken As ResumableSub
	If sti_Token.Valid = False Then
		sti_Token.AccessToken = ""
		SaveToken
		If m_Supabase.LogEvents Then Log("SupabaseAuth: User is logged out, this user must log in again")
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
			If m_Supabase.LogEvents Then Log("SupabaseAuth: Access token could not be renewed")
			AuthStateChange("signedOut")
		End If
	Else
		'RaiseEvent_AccessTokenAvailable(True)
	End If
	Return sti_Token.AccessToken
End Sub

Public Sub RefreshToken As ResumableSub
	
	Dim url As String = $"${m_Supabase.URL}/auth/v1/token?grant_type=refresh_token"$
	
	Dim json As JSONGenerator
	json.Initialize(CreateMap("refresh_token":sti_Token.RefreshToken))
	
	Dim j As HttpJob : j.Initialize("",Me)
	j.PostString(url,json.ToString)
	j.GetRequest.SetContentType("application/json")
	j.GetRequest.SetHeader("apikey",m_Supabase.ApiKey)
	
	Wait For (j) JobDone(j As HttpJob)
	
	'Dim m_ResultMap As Map = Supabase_Functions.GenerateResult(j)
	If j.Success Then
		TokenInformationFromResponse(Supabase_Functions.GenerateResult(j))
		AuthStateChange("tokenRefreshed")
		Return True
	Else
		Return False
	End If
	
End Sub

'Allow your users to sign up and create a new account.
'<code>
'	wait for (xSupabase.Auth.SignUp("test@example.com","Test123!",Null)) Complete (NewUser As SupabaseUser)
'	If NewUser.Error.Success Then
'		Log("successfully registered with " & NewUser.Email)
'	Else
'		Log("Error: " & NewUser.Error.ErrorMessage)
'	End If
'</code>
'Options - additional user metadata
'<code>
'	Dim AdditionalUserMetadata As Map = CreateMap("first_name":"Alexander","age":25)
'	Wait For (xSupabase.Auth.SignUp("test@gmail.com","Test123!",AdditionalUserMetadata)) Complete (NewUser As SupabaseUser)
'</code>
Public Sub SignUp(Email As String,Password As String,Options As Map) As ResumableSub
	
	Dim url As String = $"${m_Supabase.URL}/auth/v1/signup"$
	
	Dim m_Parameters As Map
	m_Parameters.Initialize
	If Email <> "" And Password <> "" Then
		m_Parameters.Put("email",Email)
		m_Parameters.Put("password",Password)
	End If
	
	If Options <> Null And Options.IsInitialized Then
		
		m_Parameters.Put("data",Options)
		
	End If
	
	Dim json As JSONGenerator
	json.Initialize(m_Parameters)
	
	Dim j As HttpJob : j.Initialize("",Me)
	j.PostString(url,json.ToString)
	j.GetRequest.SetContentType("application/json")
	j.GetRequest.SetHeader("apikey",m_Supabase.ApiKey)
	
	Wait For (j) JobDone(j As HttpJob)

	Dim m_ResultMap As Map = Supabase_Functions.GenerateResult(j)


	Dim User As SupabaseUser
	User.Initialize

	Dim DatabaseError As SupabaseError
	DatabaseError.Initialize
	DatabaseError.Success = m_ResultMap.Get("success")
	If DatabaseError.Success = False Then
		If m_ResultMap.ContainsKey("code") Then
			DatabaseError.StatusCode = m_ResultMap.Get("code")
			DatabaseError.ErrorMessage = m_ResultMap.Get("msg")
		Else If m_ResultMap.ContainsKey("error_description") Then
			DatabaseError.StatusCode = 401
			DatabaseError.ErrorMessage = m_ResultMap.Get("error_description")
		End If
	End If
	User.Error = DatabaseError

	If DatabaseError.Success Then
		m_User = FillUserObject(User,m_ResultMap)
		m_User.Error = DatabaseError
		AuthStateChange("signedIn")
	Else
		m_User.Error = DatabaseError
	End If

	Return m_User
	
		#IF Documentation
		idToken - A Firebase Auth ID token for the newly created user.
		email - The email for the newly created user.
		refreshToken - A Firebase Auth refresh token for the newly created user.
		expiresIn - The number of seconds in which the ID token expires.
		localId - The uid of the newly created user.
		#End If
	
End Sub

'If an account is created, users can login to your app.
'<code>
'	Wait For (xSupabase.Auth.LogIn_EmailPassword("test@example.com","Test123!!")) Complete (User As SupabaseUser)
'		If User.Error.Success Then
'			Log("successfully logged in with " & User.Email)
'		Else
'			Log("Error: " & User.Error.ErrorMessage)
'		End If
'</code>
Public Sub Login_EmailPassword(Email As String,Password As String) As ResumableSub
	
	Dim url As String = $"${m_Supabase.URL}/auth/v1/token?grant_type=password"$
	
	Dim json As JSONGenerator
	json.Initialize(CreateMap("email":Email,"password":Password))
	
	Dim j As HttpJob : j.Initialize("",Me)
	j.PostString(url,json.ToString)
	j.GetRequest.SetContentType("application/json")
	j.GetRequest.SetHeader("apikey",m_Supabase.ApiKey)
	
	Wait For (j) JobDone(j As HttpJob)

	Dim m_ResultMap As Map = Supabase_Functions.GenerateResult(j)

	Dim User As SupabaseUser
	User.Initialize

	Dim DatabaseError As SupabaseError
	DatabaseError.Initialize
	DatabaseError.Success = m_ResultMap.Get("success")
	If DatabaseError.Success = False Then
		If m_ResultMap.ContainsKey("code") Then
			DatabaseError.StatusCode = m_ResultMap.Get("code")
			DatabaseError.ErrorMessage = m_ResultMap.Get("msg")
		Else If m_ResultMap.ContainsKey("error_description") Then
			DatabaseError.StatusCode = 401
			DatabaseError.ErrorMessage = m_ResultMap.Get("error_description")
		End If
	End If
	User.Error = DatabaseError

	User = FillUserObject(User,m_ResultMap)

	Return User
	
		#IF Documentation
		idToken - A Firebase Auth ID token for the newly created user.
		email - The email for the newly created user.
		refreshToken - A Firebase Auth refresh token for the newly created user.
		expiresIn - The number of seconds in which the ID token expires.
		localId - The uid of the newly created user.
		#End If
	
End Sub

Private Sub FillUserObject(User As SupabaseUser,ResultMap As Map) As SupabaseUser
	If User.Error.Success Then
		Dim mUser As Map = ResultMap.Get("user")

		If mUser.IsInitialized = False Then mUser = ResultMap

		If mUser.ContainsKey("id") Then User.Id = mUser.Get("id")
		If mUser.ContainsKey("aud") Then User.Aud = mUser.Get("aud")
		If mUser.ContainsKey("role") Then User.role = mUser.Get("role")
		If mUser.ContainsKey("email") Then User.email = mUser.Get("email")
		If mUser.ContainsKey("phone") Then User.phone = mUser.Get("phone")
		If mUser.ContainsKey("email_confirmed_at") Then User.EmailConfirmedAt = Supabase_Functions.ParseDateTime(mUser.Get("email_confirmed_at"))
		If mUser.ContainsKey("confirmation_sent_at") Then User.confirmationsentat = Supabase_Functions.ParseDateTime(mUser.Get("confirmation_sent_at"))
		If mUser.ContainsKey("confirmed_at") Then User.ConfirmedAt = Supabase_Functions.ParseDateTime(mUser.Get("confirmed_at"))
		If mUser.ContainsKey("last_sign_in_at") Then User.LastSignInAt = Supabase_Functions.ParseDateTime(mUser.Get("last_sign_in_at"))
		If mUser.ContainsKey("created_at") Then User.createdat = Supabase_Functions.ParseDateTime(mUser.Get("created_at"))
		If mUser.ContainsKey("updated_at") Then User.updatedat = Supabase_Functions.ParseDateTime(mUser.Get("updated_at"))
		If mUser.ContainsKey("user_metadata") Then User.Metadata = mUser.Get("user_metadata")
		If mUser.ContainsKey("is_anonymous") Then User.isAnonymous = mUser.Get("is_anonymous")

	End If

	m_User = User

	If User.Error.Success Then
		If ResultMap.ContainsKey("access_token") Then sti_Token.AccessToken = ResultMap.Get("access_token")
		If ResultMap.ContainsKey("token_type") Then sti_Token.tokentype = ResultMap.Get("token_type")
		If ResultMap.ContainsKey("expires_at") Then sti_Token.AccessExpiry = DateUtils.UnixTimeToTicks(ResultMap.Get("expires_at"))
		If ResultMap.ContainsKey("refresh_token") Then sti_Token.refreshtoken = ResultMap.Get("refresh_token")
		sti_Token.Valid = True
		sti_Token.Email = User.Email
		If m_Supabase.LogEvents Then Log($"SupabaseAuth: Token received. Expires: ${DateUtils.TicksToString(sti_Token.AccessExpiry)}"$)
		SaveToken
		AuthStateChange("signedIn")
	End If
	Return User
End Sub


'Send a user a passwordless link which they can use to redeem an access_token.
'code>
'	Wait For (xSupabase.Auth.LogIn_MagicLink("test@example.com")) Complete (Result As SupabaseError)
'	If Result.Success Then
'		Log("magic link successfully sent")
'	Else
'		Log("Error: " & Result.ErrorMessage)
'	End If
'</code>
Public Sub LogIn_MagicLink(Email As String) As ResumableSub
	Dim url As String = $"${m_Supabase.URL}/auth/v1/magiclink"$
	
	Dim json As JSONGenerator
	json.Initialize(CreateMap("email":Email))
	
	Dim j As HttpJob : j.Initialize("",Me)
	j.PostString(url,json.ToString)
	j.GetRequest.SetContentType("application/json")
	j.GetRequest.SetHeader("apikey",m_Supabase.ApiKey)
	
	Wait For (j) JobDone(j As HttpJob)

	Dim m_ResultMap As Map = Supabase_Functions.GenerateResult(j)

	Dim DatabaseError As SupabaseError
	DatabaseError.Initialize
	DatabaseError.Success = m_ResultMap.Get("success")

	If m_ResultMap.Get("success") = False Then
		DatabaseError.StatusCode = m_ResultMap.Get("code")
		DatabaseError.ErrorMessage = m_ResultMap.Get("msg")
	End If

	Return DatabaseError
	
End Sub

'Allow your users to sign up without requiring users to enter an email address, password
'It is strongly recommended to enable invisible Captcha or Cloudflare Turnstile to prevent abuse for anonymous sign-ins, you can more read about in the forum thread.
'<code>
'	Wait For (xSupabase.Auth.LogIn_Anonymously) Complete (AnonymousUser As SupabaseUser)
'	If AnonymousUser.Error.Success Then
'		Log("Successfully created an anonymous user")
'	Else
'		Log("Error: " & AnonymousUser.Error.ErrorMessage)
'	End If
'</code>
Public Sub LogIn_Anonymously As ResumableSub
	
	Wait For (isUserLoggedIn) Complete (isLoggedIn As Boolean)
	
	If isLoggedIn Then
		Wait For (GetUser) Complete (User As SupabaseUser)
		
		If User.isAnonymous = False Then
			If m_Supabase.LogEvents Then LogColor("SupabaseAuth: LogIn_Anonymously - User is logged in with a non-anonymous user, this user is now logged out",xui.Color_Red)
			Wait For (Logout) Complete (Result As SupabaseError)
			
			Wait for (SignUp("","",Null)) Complete (NewUser As SupabaseUser)
			Return NewUser
			
		End If
		
		Return User
	Else
		Wait for (SignUp("","",Null)) Complete (NewUser As SupabaseUser)
		Return NewUser
	End If
	
End Sub

'Links an oauth identity to an existing user.
'Public Sub LinkIdentity As ResumableSub
'	
'	s
'	
'End Sub

'Todo: SMS
'Public Sub LogIn_SmsOtp(Phone As String)
'	Dim url As String = $"${m_Supabase.URL}/auth/v1/otp"$
'	
'	Dim json As JSONGenerator
'	json.Initialize(CreateMap("phone":Phone))
'	
'	Dim j As HttpJob : j.Initialize("",Me)
'	j.PostString(url,json.ToString)
'	j.GetRequest.SetContentType("application/json")
'	j.GetRequest.SetHeader("apikey",m_Supabase.ApiKey)
'	
'	Wait For (j) JobDone(j As HttpJob)
'
'	Dim m_ResultMap As Map = Supabase_Functions.GenerateResult(j)
'End Sub

'Public Sub LogIn_ThirdPartyOAuth(Provider As String)
'	
'End Sub

'Todo: SMS
'Public Sub Verify_SmsOtp(Phone As String,Token As String)
'	Dim url As String = $"${m_Supabase.URL}/auth/v1/verify"$
'	
'	Dim json As JSONGenerator
'	json.Initialize(CreateMap("type":"sms","phone":Phone,"token":Token))
'	
'	Dim j As HttpJob : j.Initialize("",Me)
'	j.PostString(url,json.ToString)
'	j.GetRequest.SetContentType("application/json")
'	j.GetRequest.SetHeader("apikey",m_Supabase.ApiKey)
'	
'	Wait For (j) JobDone(j As HttpJob)
'
'	Dim m_ResultMap As Map = Supabase_Functions.GenerateResult(j)
'End Sub

'Gets the user object
'<code>Wait For (xSupabase.Auth.GetUser) Complete (User As SupabaseUser)</code>
Public Sub GetUser As ResumableSub
	
	Dim User As SupabaseUser
	User.Initialize

	Dim DatabaseError As SupabaseError
	DatabaseError.Initialize
	User.Error = DatabaseError
	
	If m_User.IsInitialized = False Or m_User.Id = "" Then
	
		Wait For (m_Supabase.Auth.GetAccessToken) Complete (AccessToken As String)
	
		Dim url As String = $"${m_Supabase.URL}/auth/v1/user"$
	
	
		Dim j As HttpJob : j.Initialize("",Me)
		j.Download(url)
		j.GetRequest.SetHeader("apikey",m_Supabase.ApiKey)
		j.GetRequest.SetHeader("Authorization","Bearer " & AccessToken)
		
		Wait For (j) JobDone(j As HttpJob)

		DatabaseError.Success = j.Success

		If j.Success = False Then
			DatabaseError.StatusCode = j.Response.StatusCode
			DatabaseError.ErrorMessage = j.ErrorMessage
		End If

		Dim m_ResultMap As Map = Supabase_Functions.GenerateResult(j)
	
		m_User = FillUserObject(User,m_ResultMap)
	
	End If
	
	m_User.Error = DatabaseError
	Return m_User
	
End Sub

'<code>
'	wait for (xSupabase.Auth.PasswordRecovery("test@example.com")) Complete (Response As SupabaseError)
'	If Response.Success Then
'		Log("Recovery email sent successfully")
'	Else
'		Log("Error: " & Response.ErrorMessage)
'	End If
'</code>
Public Sub PasswordRecovery(Email As String) As ResumableSub
	
	Dim DatabaseError As SupabaseError
	DatabaseError.Initialize
	
	Dim url As String = $"${m_Supabase.URL}/auth/v1/recover"$
	
	Dim json As JSONGenerator
	json.Initialize(CreateMap("email":Email))
	
	Dim j As HttpJob : j.Initialize("",Me)
	j.PostString(url,json.ToString)
	j.GetRequest.SetContentType("application/json")
	j.GetRequest.SetHeader("apikey",m_Supabase.ApiKey)
	
	Wait For (j) JobDone(j As HttpJob)

	DatabaseError.Success = j.Success

	If j.Success = False Then
		DatabaseError.StatusCode = j.Response.StatusCode
		DatabaseError.ErrorMessage = j.ErrorMessage
	Else
		AuthStateChange("passwordRecovery")
	End If

	'Dim m_ResultMap As Map = Supabase_Functions.GenerateResult(j)
	
	Return DatabaseError
End Sub

'Update the user with a new email or password. Each key (email, password, and data) is optional
'If you don't want to change the password and only the email address, just leave the password blank
'If you don't want to change the email address and only the password, just leave the email blank
'<code>
'	Wait For (xSupabase.Auth.UpdateUser("test@example.com","")) Complete (Result As SupabaseError)
'	If Result.Success Then
'		Log("User data successfully changed")
'	Else
'		Log("Error: " & Result.ErrorMessage)
'	End If
'</code>
Public Sub UpdateUser(NewEmail As String,NewPassword As String) As ResumableSub
	
	Dim DatabaseError As SupabaseError
	DatabaseError.Initialize
	
	Wait For (m_Supabase.Auth.GetAccessToken) Complete (AccessToken As String)
	If AccessToken = "" Then
		DatabaseError.StatusCode = 401
		DatabaseError.ErrorMessage = "Unauthorized"
		Return DatabaseError
	End If
	
	Dim url As String = $"${m_Supabase.URL}/auth/v1/user"$
	
	Dim json As JSONGenerator
	If NewEmail <> "" Then json.Initialize(CreateMap("email":NewEmail))
	If NewPassword <> "" Then json.Initialize(CreateMap("password":NewPassword))
	
	Dim j As HttpJob : j.Initialize("",Me)
	j.PutString(url,json.ToString)
	j.GetRequest.SetContentType("application/json")
	j.GetRequest.SetHeader("apikey",m_Supabase.ApiKey)
	j.GetRequest.SetHeader("Authorization","Bearer " & AccessToken)
	
	Wait For (j) JobDone(j As HttpJob)

	DatabaseError.Success = j.Success

	If j.Success = False Then
		DatabaseError.StatusCode = j.Response.StatusCode
		DatabaseError.ErrorMessage = j.ErrorMessage
		Else
		AuthStateChange("userUpdated")
	End If

'	Dim m_ResultMap As Map = Supabase_Functions.GenerateResult(j)
'	Log(Supabase_Functions.GenerateResult(j))
	
	Return DatabaseError
	
End Sub

#Region SocialLogin

#IF B4J
'Signs the user in using third party OAuth providers.
'<code>
'	#If B4A
'	Wait For (xSupabase.Auth.SignInWithOAuth("xxx.apps.googleusercontent.com","google","profile email https://www.googleapis.com/auth/userinfo.email")) Complete (User As SupabaseUser)
'	#Else If B4I
'	Wait For (xSupabase.Auth.SignInWithOAuth("xxx.apps.googleusercontent.com","google","profile email https://www.googleapis.com/auth/userinfo.email")) Complete (User As SupabaseUser)
'	#Else If B4J
'	Wait For (xSupabase.Auth.SignInWithOAuth("xxx.apps.googleusercontent.com","google","profile email https://www.googleapis.com/auth/userinfo.email","xxx")) Complete (User As SupabaseUser)
'	#End If
'
'	If User.Error.Success Then
'		Log("successfully logged in with " & User.Email)
'	Else
'		Log("Error: " & User.Error.ErrorMessage)
'	End If
'</code>
Public Sub SignInWithOAuth(ClientId As String,Provider As String,Scope As String,ClientSecret As String) As ResumableSub
#Else
'Signs the user in using third party OAuth providers.
'<code>
'	#If B4A
'	Wait For (xSupabase.Auth.SignInWithOAuth("xxx.apps.googleusercontent.com","google","profile email https://www.googleapis.com/auth/userinfo.email")) Complete (User As SupabaseUser)
'	#Else If B4I
'	Wait For (xSupabase.Auth.SignInWithOAuth("xxx.apps.googleusercontent.com","google","profile email https://www.googleapis.com/auth/userinfo.email")) Complete (User As SupabaseUser)
'	#Else If B4J
'	Wait For (xSupabase.Auth.SignInWithOAuth("xxx.apps.googleusercontent.com","google","profile email https://www.googleapis.com/auth/userinfo.email","xxx")) Complete (User As SupabaseUser)
'	#End If
'
'	If User.Error.Success Then
'		Log("successfully logged in with " & User.Email)
'	Else
'		Log("Error: " & User.Error.ErrorMessage)
'	End If
'</code>
Public Sub SignInWithOAuth(ClientId As String,Provider As String,Scope As String) As ResumableSub
#End If
	
	#If B4J
	m_ClientSecret = ClientSecret
	#End If
	
	OAuth_Authenticate(ClientId,Provider,Scope)
	
	Wait For OAuthTokenReceived (Successful As Boolean)
	
	Dim DatabaseError As SupabaseError
	DatabaseError.Initialize
	DatabaseError.Success = Successful
	If DatabaseError.Success = False Then
		DatabaseError.StatusCode = ""
		DatabaseError.ErrorMessage = ""
	End If
	
	If Successful Then
		Wait For (GetUser) Complete (User As SupabaseUser)
		User.Error = DatabaseError
		AuthStateChange("signedIn")
		Return User
	Else
			
		Dim User As SupabaseUser
		User.Initialize
		User.Error = DatabaseError
		Logout
		Return User
			
			
	End If
	
End Sub

#End Region

#Region Events

Private Sub AuthStateChange(StateType As String)
	If Supabase_Functions.SubExists2(m_Supabase,mEventName & "_AuthStateChange",1) Then
		CallSub2(m_Supabase,mEventName & "_AuthStateChange",StateType)
	End If
End Sub

#End Region

#Region OAuth

Private Sub GetPackageName As String
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

Private Sub OAuth_Authenticate(ClientId As String,Provider As String,Scope As String)
	
	CurrentClientId = ClientId
	CurrentProvider = Provider

	If Provider = "apple" Then
		SignInWithApple
	Else
		
			#if B4J
	PrepareServer
#End If
		
		If Provider = "google" Then
			Dim link As String = BuildLink($"${m_Supabase.URL}/auth/v1/authorize?provider=${Provider}"$, _
         CreateMap("client_id": ClientId, _
        "redirect_uri": GetRedirectUri, _
        "response_type": "code", _
        "scope": Scope))
		Else
					
			Dim link As String = BuildLink($"${m_Supabase.URL}/auth/v1/authorize?provider=${Provider}"$, _
         CreateMap("client_id": ClientId, _
        "redirect_uri": $"${GetPackageName}://${m_Supabase.URL.Replace("https://","")}/auth/v1/callback"$, _
		 "response_type": "code", _
        "scope": Scope))
			'        '"redirect_uri": $"com.stoltex.supabase://${m_Supabase.URL.Replace("https://","")}/auth/v1/callback"$, _
	#if B4J
	PrepareServer
	#end if
			'http://127.0.0.1:3000
		End If
		
#if B4A
		Dim pi As PhoneIntents
		StartActivity(pi.OpenBrowser(link))
#else if B4i
		Main.App.OpenURL(link)
#else if B4J and UI
	fx.ShowExternalDocument(link)
#end if
		
	End If
	
End Sub

#if B4J
Private Sub PrepareServer
	If server.IsInitialized Then server.Close
	If astream.IsInitialized Then astream.Close
	Do While True
		Try
			server.Initialize(port, "server")
			server.Listen
			Exit
		Catch
			port = port + 1
			Log("SupabaseAuth: " & LastException)
		End Try
	Loop
	Wait For server_NewConnection (Successful As Boolean, NewSocket As Socket)
	If Successful Then
		astream.Initialize(NewSocket.InputStream, NewSocket.OutputStream, "astream")
		Dim Response As StringBuilder
		Response.Initialize
		Do While Response.ToString.Contains("Host:") = False
			Wait For AStream_NewData (Buffer() As Byte)
			Response.Append(BytesToString(Buffer, 0, Buffer.Length, "UTF8"))
		Loop
		astream.Write(("HTTP/1.0 200" & Chr(13) & Chr(10)).GetBytes("UTF8"))
		Sleep(50)
		astream.Close
		server.Close
		ParseBrowserUrl(Regex.Split2("$",Regex.MULTILINE, Response.ToString)(0))
	End If
	
End Sub
#else if B4A
Public Sub CallFromResume(Intent As Intent)
	If IsNewOAuth2Intent(Intent) Then
		LastIntent = Intent
		ParseBrowserUrl(Intent.GetData)
	End If
End Sub

Private Sub IsNewOAuth2Intent(Intent As Intent) As Boolean
	Return Intent.IsInitialized And Intent <> LastIntent And Intent.Action = Intent.ACTION_VIEW And _
		Intent.GetData <> Null And Intent.GetData.StartsWith(Application.PackageName)
End Sub
#else if B4I
Public Sub CallFromOpenUrl (url As String)
	If url.StartsWith(packageName & ":/oath") Then
		ParseBrowserUrl(url)
	End If
End Sub

#end if

Private Sub GetRedirectUri As String
	#if B4J
	Return "http://127.0.0.1:" & port
	#Else
	Return packageName & ":/oath"
	#End If
End Sub

Private Sub BuildLink(Url As String, Params As Map) As String
	Dim su As StringUtils
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append(Url)
	If Params.Size > 0 Then
		sb.Append("&")
		For Each k As String In Params.Keys
			sb.Append(su.EncodeUrl(k, "utf8")).Append("=").Append(su.EncodeUrl(Params.Get(k), "utf8"))
			sb.Append("&")
		Next
		sb.Remove(sb.Length - 1, sb.Length)
	End If
	Return sb.ToString
End Sub

Private Sub ParseBrowserUrl(Response As String)
	'Log(Response)
	Dim m As Matcher = Regex.Matcher("code=([^&\s]+)", Response)
	If m.Find Then
		Dim code As String = m.Group(1)
		If CurrentProvider = "google" Then
			GetTokenFromGoogleAuthorizationCode(code)
			Else
			GetTokenFromSupabase(code)
		End If
	Else
		Log("SupabaseAuth: Error parsing server response: " & Response)
		Logout
	End If
End Sub

Private Sub AddClientSecret (s As String) As String
	If m_ClientSecret <> "" Then
		s = s & "&client_secret=" & m_ClientSecret
	End If
	Return s
End Sub

Private Sub GetTokenFromSupabase(IdToken As String)
	
	Dim j As HttpJob
	j.Initialize("", Me)
		
	Dim json As JSONGenerator
	json.Initialize(CreateMap("id_token":IdToken,"provider":CurrentProvider))
		

	j.PostString($"${m_Supabase.URL}/auth/v1/token?grant_type=id_token"$, json.ToString)
	j.GetRequest.SetHeader("apikey",m_Supabase.ApiKey)
	j.GetRequest.SetContentType("application/json")
		
	Wait For (j) JobDone(j As HttpJob)
	If j.Success Then
		TokenInformationFromResponse(Supabase_Functions.GenerateResult(j))
		CallSubDelayed2(Me,"OAuthTokenReceived",True)
	Else
		Logout
		CallSubDelayed2(Me,"OAuthTokenReceived",False)
	End If
	j.Release
	
End Sub

'********SignIn with Google****************

Private Sub GetTokenFromGoogleAuthorizationCode (Code As String)
	'Log("Getting access token from google authorization code...")
	Dim j As HttpJob
	j.Initialize("", Me)
	Dim postString As String = $"code=${Code}&client_id=${CurrentClientId}&grant_type=authorization_code&redirect_uri=${GetRedirectUri}"$
	postString = AddClientSecret(postString)
	j.PostString("https://www.googleapis.com/oauth2/v4/token", postString)
		
	Wait For (j) JobDone(j As HttpJob)
	If j.Success Then
		
		Dim tmp_result As Map = Supabase_Functions.GenerateResult(j)
		
		GetTokenFromSupabase(tmp_result.Get("id_token"))
		
	Else
		Logout
		CallSubDelayed2(Me,"OAuthTokenReceived",False)
	End If
	j.Release
End Sub

'********SignIn with Apple*****************

Private Sub SignInWithApple
	#If B4I
	Dim NativeButton As NativeObject
	btn = NativeButton.Initialize("ASAuthorizationAppleIDButton").RunMethod("new", Null)
	Dim no As NativeObject = Me
	no.RunMethod("SetButton:", Array(btn))
	'mBase.AddView(btn, 0, 0, mBase.Width, mBase.Height)
	dele_gate = no.Initialize("AuthorizationDelegate").RunMethod("new", Null)
	btn.As(NativeObject).RunMethod ("sendActionsForControlEvents:", Array (64)) ' UIControlEventTouchUpInside
	#End If
End Sub

#If B4I

Private Sub Auth_Result(Success As Boolean, Result As Object)
	If Success Then
		Dim no As NativeObject = Result
		Dim credential As NativeObject = no.GetField("credential")
		If GetType(credential) = "ASAuthorizationAppleIDCredential" Then
			
			Dim Token() As Byte = credential.NSDataToArray(credential.GetField("identityToken"))
			
			
			GetTokenFromSupabase(BytesToString(Token, 0, Token.Length, "UTF8"))
			
			Dim email, name As String
			If credential.GetField("email").IsInitialized Then
				Dim formatter As NativeObject
				name = formatter.Initialize("NSPersonNameComponentsFormatter").RunMethod("localizedStringFromPersonNameComponents:style:options:", _
					Array(credential.GetField("fullName"), 0, 0)).AsString
				email = credential.GetField("email").AsString
				'Log(email)
				'Log(name)
				'CallSub3(mCallBack, mEventName & "_AuthResult", name, email)
			End If
		Else
			Log("Unexpected type: " & GetType(credential))
		End If
	End If
End Sub

#End If

#End Region

#Region Enums

Public Sub getProvider_Google As String
	Return "google"
End Sub

'B4I Only
Public Sub getProvider_Apple As String
	Return "apple"
End Sub

#End Region

#if OBJC
#import <AuthenticationServices/AuthenticationServices.h>
- (void) SetButton:(ASAuthorizationAppleIDButton*)btn {
	 [btn addTarget:self action:@selector(handleAuthorizationAppleIDButtonPress:) forControlEvents:UIControlEventTouchUpInside];
}
- (void) handleAuthorizationAppleIDButtonPress:(UIButton *) sender {
	ASAuthorizationAppleIDProvider* provider = [ASAuthorizationAppleIDProvider new];
	ASAuthorizationAppleIDRequest* req = [provider createRequest];
	req.requestedScopes = @[ASAuthorizationScopeEmail, ASAuthorizationScopeFullName];
	ASAuthorizationController* controller = [[ASAuthorizationController alloc] initWithAuthorizationRequests:
		@[req]];
	controller.delegate = self._dele_gate;
	controller.presentationContextProvider = self._dele_gate;
	[self._dele_gate setValue:self.bi forKey:@"bi"];
	controller.performRequests;
}
@end
@interface AuthorizationDelegate : NSObject<ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding>
@property (nonatomic) B4I* bi;
@end
@implementation AuthorizationDelegate
- (void)authorizationController:(ASAuthorizationController *)controller 
   didCompleteWithAuthorization:(ASAuthorization *)authorization {
   [self.bi raiseUIEvent:nil event:@"auth_result::" params:@[@(true), authorization]];
  }
 - (void)authorizationController:(ASAuthorizationController *)controller 
           didCompleteWithError:(NSError *)error {
	 NSLog(@"error: %@", error);
	 [self.bi raiseUIEvent:nil event:@"auth_result::" params:@[@(false), [NSNull null]]];
}
- (ASPresentationAnchor)presentationAnchorForAuthorizationController:(ASAuthorizationController *)controller  {
	NSLog(@"presentationAnchorForAuthorizationController");
	return UIApplication.sharedApplication.keyWindow;
}
#End If
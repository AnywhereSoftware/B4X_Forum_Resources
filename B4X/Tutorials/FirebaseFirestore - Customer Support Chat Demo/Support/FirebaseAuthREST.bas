B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.31
@EndOfDesignText@
#If Documentation
You can query the Firebase Auth backend through a REST API. 
This can be used for various operations such as creating new users, signing in existing ones and editing or deleting these users.

Throughout this document, API_KEY refers to the Web API Key, which can be obtained on the project settings page in your admin console.

Updates
V1.00
	-Release
V1.01
	-get Errors check if item in map exists
	-Add refreshToken - Exchange a refresh token for an ID token
#End If

Sub Class_Globals
	Private const API_KEY As String = ""
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
End Sub

Private Sub GenerateResult(j As HttpJob) As Map
	Try
		Dim response As String = ""
		If j.Success Then
			response = j.GetString
'			Log(j.GetString)
		Else
			response = j.ErrorMessage
		End If
	
		Dim parser As JSONParser
		parser.Initialize(response)
		Dim tmp_result As Map = parser.NextObject
		tmp_result.Put("success",j.Success)
	
		j.Release
		Return tmp_result
	Catch
		Log(LastException)
		Return CreateMap()
	End Try
End Sub

#Region Errors
'code: 400
Public Sub getErrorCode(root As Map) As Int
	If root.ContainsKey("error") Then
	Dim error As Map = root.Get("error")
	Return error.Get("code")	
	End If
	Return 200
End Sub

'message: EMAIL_NOT_FOUND
Public Sub getErrorMessage(root As Map) As String
	If root.ContainsKey("error") Then
		Dim error As Map = root.Get("error")
		Return error.Get("message")
	End If
	Return ""
End Sub

'reason: invalid
'domain: global
'message: EMAIL_NOT_FOUND
Public Sub getErrorMap(root As Map) As Map
	Dim tmp_result As Map : tmp_result.Initialize
	Try
		If root.ContainsKey("error") Then
			Dim error As Map = root.Get("error")
			Dim errors As List = error.Get("errors")
			For Each colerrors As Map In errors
				tmp_result = CreateMap("reason":colerrors.Get("reason"),"domain":colerrors.Get("domain"),"message":colerrors.Get("message"))
			Next
		End If
	Catch
		Log(LastException)
	End Try
	Return tmp_result
End Sub

#End Region

'Exchange custom token for an ID and refresh token
'https://firebase.google.com/docs/reference/rest/auth#section-verify-custom-token
'token - A Firebase Auth custom token from which to create an ID and refresh token pair.
'returnSecureToken - Whether or not to return an ID and refresh token. Should always be true.
'Public Sub signInWithCustomToken(token As String,returnSecureToke As Boolean)
'	
'	Dim url As String = $"https://identitytoolkit.googleapis.com/v1/accounts:signInWithCustomToken?key=${API_KEY}"$
'	
'	Dim json As JSONGenerator
'	json.Initialize(CreateMap("token":token,"returnSecureToken":returnSecureToke))
'	
'	Dim j As HttpJob : j.Initialize("",Me)
'	j.PostString(url,json.ToString)
'	j.GetRequest.SetContentType("application/json")
'	
'	Wait For (j) JobDone(j As HttpJob)
'	If j.Success Then
'	Log(j.GetString)
'	
'	End If
'	
'End Sub

'Exchange a refresh token for an ID token
'https://firebase.google.com/docs/reference/rest/auth#section-verify-custom-token
'grant_type	- The refresh token's grant type, always "refresh_token".
'refresh_token - A Firebase Auth refresh token.
Public Sub refreshToken(grant_type As String,refresh_token As String) As ResumableSub
	
	Dim url As String = $"https://securetoken.googleapis.com/v1/token?key=${API_KEY}"$
	
	Dim json As JSONGenerator
	json.Initialize(CreateMap("grant_type":grant_type,"refresh_token":refresh_token))
	
	Dim j As HttpJob : j.Initialize("",Me)
	j.PostString(url,json.ToString)
	j.GetRequest.SetContentType("application/json")
	
	Wait For (j) JobDone(j As HttpJob)

	Return GenerateResult(j)
	
	#IF Documentation	
	expires_in - The number of seconds in which the ID token expires.
	token_type - The type of the refresh token, always "Bearer".
	refresh_token - The Firebase Auth refresh token provided in the request or a new refresh token.
	id_token - A Firebase Auth ID token.
	user_id	- The uid corresponding to the provided ID token.
	project_id - Your Firebase project ID.	
	#End If
	
End Sub

'Sign up with email / password
'https://firebase.google.com/docs/reference/rest/auth#section-create-email-password
'email - The email for the user to create.
'password - The password for the user to create.
'returnSecureToken - Whether or not to return an ID and refresh token. Should always be true.
Public Sub signUpEmailPW(email As String, password As String,returnSecureToken As Boolean) As ResumableSub
	
	Dim url As String = $"https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=${API_KEY}"$
	
	Dim json As JSONGenerator
	json.Initialize(CreateMap("email":email,"password":password,"returnSecureToken":returnSecureToken))
	
	Dim j As HttpJob : j.Initialize("",Me)
	j.PostString(url,json.ToString)
	j.GetRequest.SetContentType("application/json")
	
	Wait For (j) JobDone(j As HttpJob)

	Return GenerateResult(j)
	
		#IF Documentation
		idToken - A Firebase Auth ID token for the newly created user.
		email - The email for the newly created user.
		refreshToken - A Firebase Auth refresh token for the newly created user.
		expiresIn - The number of seconds in which the ID token expires.
		localId - The uid of the newly created user.
		#End If
End Sub

'Sign in with email / password
'https://firebase.google.com/docs/reference/rest/auth#section-sign-in-email-password
'email - The email the user is signing in with.
'password - The password for the account.
'returnSecureToken - Whether or not to return an ID and refresh token. Should always be true.
Public Sub signInEmailPW(email As String, password As String,returnSecureToken As Boolean) As ResumableSub
	
	Dim url As String = $"https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=${API_KEY}"$
	
	Dim json As JSONGenerator
	json.Initialize(CreateMap("email":email,"password":password,"returnSecureToken":returnSecureToken))
	
	Dim j As HttpJob : j.Initialize("",Me)
	j.PostString(url,json.ToString)
	j.GetRequest.SetContentType("application/json")
	
	Wait For (j) JobDone(j As HttpJob)

	Return GenerateResult(j)
	
		#IF Documentation
		idToken - A Firebase Auth ID token for the newly created user.
		email - The email for the newly created user.
		refreshToken - A Firebase Auth refresh token for the newly created user.
		expiresIn - The number of seconds in which the ID token expires.
		localId - The uid of the newly created user.
		registered - Whether the email is for an existing account.
		#End If

End Sub

'Sign in anonymously
'https://firebase.google.com/docs/reference/rest/auth#section-sign-in-anonymously
'returnSecureToken - Whether or not to return an ID and refresh token. Should always be true.
Public Sub signInAnonymously(returnSecureToken As Boolean) As ResumableSub
	
	Dim url As String = $"https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=${API_KEY}"$
	
	Dim json As JSONGenerator
	json.Initialize(CreateMap("returnSecureToken":returnSecureToken))
	
	Dim j As HttpJob : j.Initialize("",Me)
	j.PostString(url,json.ToString)
	j.GetRequest.SetContentType("application/json")
	
	Wait For (j) JobDone(j As HttpJob)

	Return GenerateResult(j)
	
	#If Documentation
		idToken	- A Firebase Auth ID token for the newly created user.
		email - Since the user is anonymous, this should be empty.
		refreshToken - A Firebase Auth refresh token for the newly created user.
		expiresIn - The number of seconds in which the ID token expires.
		localId	- The uid of the newly created user.
		#End If
	
End Sub

'Fetch providers for email
'https://firebase.google.com/docs/reference/rest/auth#section-fetch-providers-for-email
'identifier - User's email address
'continueUri - The URI to which the IDP redirects the user back. For this use case, this is just the current URL.
Public Sub createAuthUri(identifier As String,continueUri As String) As ResumableSub
	
	Dim url As String = $"https://identitytoolkit.googleapis.com/v1/accounts:createAuthUri?key=${API_KEY}"$
	
	Dim json As JSONGenerator
	json.Initialize(CreateMap("identifier":identifier,"continueUri":continueUri))
	
	Dim j As HttpJob : j.Initialize("",Me)
	j.PostString(url,json.ToString)
	j.GetRequest.SetContentType("application/json")
	
	Wait For (j) JobDone(j As HttpJob)

	Return GenerateResult(j)
	
	#If Documentation
		allProviders - The list of providers that the user has previously signed in with.
		registered - Whether the email is for an existing account
		#End If
	
End Sub

'Send password reset email
'https://firebase.google.com/docs/reference/rest/auth#section-send-password-reset-email
'requestType - The kind of OOB code to return. Should be "PASSWORD_RESET" for password reset.
'email - User's email address.
Public Sub sendPasswordResetEmail(requestType As String,email As String) As ResumableSub
	
	Dim url As String = $"https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=${API_KEY}"$
	
	Dim json As JSONGenerator
	json.Initialize(CreateMap("requestType":requestType,"email":email))
	
	Dim j As HttpJob : j.Initialize("",Me)
	j.PostString(url,json.ToString)
	j.GetRequest.SetContentType("application/json")
	
	Wait For (j) JobDone(j As HttpJob)
	Return GenerateResult(j)
	
	#If Documentation
		email - User's email address.
		#End If
	
End Sub

'Verify password reset code
'https://firebase.google.com/docs/reference/rest/auth#section-verify-password-reset-code
'oobCode - The email action code sent to the user's email for resetting the password.
Public Sub verifyPasswordResetCode(oobCode As String) As ResumableSub
	
	Dim url As String = $"https://identitytoolkit.googleapis.com/v1/accounts:resetPassword?key=${API_KEY}"$
	
	Dim json As JSONGenerator
	json.Initialize(CreateMap("oobCode":oobCode))
	
	Dim j As HttpJob : j.Initialize("",Me)
	j.PostString(url,json.ToString)
	j.GetRequest.SetContentType("application/json")
	
	Wait For (j) JobDone(j As HttpJob)
	Return GenerateResult(j)
	
	#If Documentation
		email - User's email address.
		requestType	- Type of the email action code. Should be "PASSWORD_RESET".
		#End If

End Sub

'Confirm password reset
'https://firebase.google.com/docs/reference/rest/auth#section-confirm-reset-password
'oobCode - The email action code sent to the user's email for resetting the password.
'newPassword - The user's new password.
Public Sub confirmPasswordReset(oobCode As String,newPassword As String) As ResumableSub
	
	Dim url As String = $"https://identitytoolkit.googleapis.com/v1/accounts:resetPassword?key=${API_KEY}"$
	
	Dim json As JSONGenerator
	json.Initialize(CreateMap("oobCode":oobCode,"newPassword":newPassword))
	
	Dim j As HttpJob : j.Initialize("",Me)
	j.PostString(url,json.ToString)
	j.GetRequest.SetContentType("application/json")
	
	Wait For (j) JobDone(j As HttpJob)
	Return GenerateResult(j)
	
	#If Documentation
		email - User's email address.
		requestType	- Type of the email action code. Should be "PASSWORD_RESET".
		#End If
	

End Sub

'Change email
'https://firebase.google.com/docs/reference/rest/auth#section-change-email
'idToken - A Firebase Auth ID token for the user.
'email - The user's new email.
'returnSecureToken - Whether or not to return an ID and refresh token.
Public Sub changeEmail(idToken As String,email As String,returnSecureToken As Boolean) As ResumableSub
	
	Dim url As String = $"https://identitytoolkit.googleapis.com/v1/accounts:update?key=${API_KEY}"$
	
	Dim json As JSONGenerator
	json.Initialize(CreateMap("idToken":idToken,"email":email,"returnSecureToken":returnSecureToken))
	
	Dim j As HttpJob : j.Initialize("",Me)
	j.PostString(url,json.ToString)
	j.GetRequest.SetContentType("application/json")
	
	Wait For (j) JobDone(j As HttpJob)
	Return GenerateResult(j)
	
	#If Documentation
		localId	- The uid of the current user.
		email - User's email address.
		passwordHash - Hash version of the password.
		providerUserInfo - List of all linked provider objects which contain "providerId" and "federatedId".
		idToken	- New Firebase Auth ID token for user.
		refreshToken - A Firebase Auth refresh token.
		expiresIn - The number of seconds in which the ID token expires.
		#End If
	
End Sub

'Change password
'https://firebase.google.com/docs/reference/rest/auth#section-change-password
'idToken - A Firebase Auth ID token for the user.
'password - User's new password.
'returnSecureToken - Whether or not to return an ID and refresh token.
Public Sub changePassword(idToken As String,password As String,returnSecureToken As Boolean) As ResumableSub
	
	Dim url As String = $"https://identitytoolkit.googleapis.com/v1/accounts:update?key=${API_KEY}"$
	
	Dim json As JSONGenerator
	json.Initialize(CreateMap("idToken":idToken,"password":password,"returnSecureToken":returnSecureToken))
	
	Dim j As HttpJob : j.Initialize("",Me)
	j.PostString(url,json.ToString)
	j.GetRequest.SetContentType("application/json")
	
	Wait For (j) JobDone(j As HttpJob)
	Return GenerateResult(j)
	
	#If Documentation
		localId	- The uid of the current user.
		email - User's email address.
		passwordHash - Hash version of password.
		providerUserInfo - List of all linked provider objects which contain "providerId" and "federatedId".
		idToken	- New Firebase Auth ID token for user.
		refreshToken - A Firebase Auth refresh token.
		expiresIn - The number of seconds in which the ID token expires.
		#End If

End Sub

'Send email verification
'https://firebase.google.com/docs/reference/rest/auth#section-send-email-verification
'requestType - The type of confirmation code to send. Should always be "VERIFY_EMAIL".
'idToken - The Firebase ID token of the user to verify.
Public Sub sendEmailVerification(requestType As String,idToken As String) As ResumableSub
	
	Dim url As String = $"https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=${API_KEY}"$
	
	Dim json As JSONGenerator
	json.Initialize(CreateMap("requestType":requestType,"idToken":idToken))
	
	Dim j As HttpJob : j.Initialize("",Me)
	j.PostString(url,json.ToString)
	j.GetRequest.SetContentType("application/json")
	
	Wait For (j) JobDone(j As HttpJob)
	Return GenerateResult(j)
		#If Documentation
		requestType - The type of confirmation code to send. Should always be "VERIFY_EMAIL".
		idToken - The Firebase ID token of the user to verify.
		#End If
	
End Sub

'Confirm email verification
'https://firebase.google.com/docs/reference/rest/auth#section-confirm-email-verification
'oobCode - The action code sent to user's email for email verification.
Public Sub confirmEmailVerification(oobCode As String) As ResumableSub
	
	Dim url As String = $"https://identitytoolkit.googleapis.com/v1/accounts:update?key=${API_KEY}"$
	
	Dim json As JSONGenerator
	json.Initialize(CreateMap("oobCode":oobCode))
	
	Dim j As HttpJob : j.Initialize("",Me)
	j.PostString(url,json.ToString)
	j.GetRequest.SetContentType("application/json")
	
	Wait For (j) JobDone(j As HttpJob)
	Return GenerateResult(j)
	
		#If Documentation
		email - The email of the account.
		displayName	- The display name for the account.
		photoUrl - The photo Url for the account.
		passwordHash - The password hash.
		providerUserInfo - List of all linked provider objects which contain "providerId" and "federatedId".
		emailVerified - Whether or not the account's email has been verified.
		#End If

End Sub

'Delete account
'https://firebase.google.com/docs/reference/rest/auth#section-delete-account
'idToken - The Firebase ID token of the user to delete.
Public Sub deleteAccount(idToken As String) As ResumableSub
	
	Dim url As String = $"https://identitytoolkit.googleapis.com/v1/accounts:delete?key=${API_KEY}"$
	Dim result As Boolean = False
	
	Dim json As JSONGenerator
	json.Initialize(CreateMap("idToken":idToken))
	
	Dim j As HttpJob : j.Initialize("",Me)
	j.PostString(url,json.ToString)
	j.GetRequest.SetContentType("application/json")
	
	Wait For (j) JobDone(j As HttpJob)
	result = j.Success
	j.Release
	Return result
		#If Documentation
		Returns True or false
		#End If
End Sub
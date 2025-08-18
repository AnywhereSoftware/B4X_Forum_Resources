B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=2.18
@EndOfDesignText@
'Class module
Sub Class_Globals
	Private success As Boolean
	Private errorMessage As String
End Sub

Public Sub Initialize
	
End Sub

Sub Handle(req As ServletRequest, resp As ServletResponse)
	resp.ContentType = "application/json"
	Dim j As HttpJob
	j.Initialize("j", Me)
	Dim jg As JSONGenerator
	Dim responeMap As Map
	Dim userName As String = req.GetParameter("username").Trim
	Dim password As String = req.GetParameter("password")
	If password.Length < 6 Then
		errorMessage = "Password too short."
	Else If userName.Length < 3 Then
		errorMessage = "Name too short."
	Else
		
		If DB.CheckUserExist(userName) Then
			errorMessage = "Name already taken."
		Else
			'check recaptcha
			Dim sb As StringBuilder
			sb.Initialize
			sb.Append("privatekey=").Append(Main.settings.Get("RecaptchaPrivateKey")).Append("&remoteip=").Append(req.RemoteAddress)
			sb.Append("&challenge=").Append(req.GetParameter("recaptcha_challenge_field"))
			sb.Append("&response=").Append(req.GetParameter("recaptcha_response_field"))
			j.PostString("http://www.google.com/recaptcha/api/verify", sb.ToString)
			StartMessageLoop
		End If
	End If
	'(debugger will not stop in the following code)
	If success Then
		DB.AddUser(userName, password)
	End If
	responeMap.Initialize
	responeMap.Put("success", success)
	responeMap.Put("errorMessage", errorMessage)
	jg.Initialize(responeMap)
	resp.Write(jg.ToString)
	req.GetSession.SetAttribute("registered", success)
	req.GetSession.SetAttribute("name", userName)
	Log("registerHelper: " & jg.ToString)
End Sub

Sub JobDone(j As HttpJob)
	If j.success Then
		Dim lines() As String = Regex.Split(CRLF, j.GetString)
		If lines.Length > 0 Then
			If lines(0) = "true" Then
				success = True
			Else
				success = False
				If lines.Length > 1 Then
					errorMessage = lines(1)
				End If
			End If
		End If
	Else
		success = False
		errorMessage = j.errorMessage
	End If
	j.Release
	StopMessageLoop
End Sub	

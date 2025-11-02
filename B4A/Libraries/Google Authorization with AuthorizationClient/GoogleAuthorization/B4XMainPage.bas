B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Dim ga As GoogleAuthorization
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	ga.Initialize
End Sub

Private Sub Button1_Click
	Dim scopes As List = Array("profile", "https://www.googleapis.com/auth/user.birthday.read")
	Wait For (ga.AuthorizeMaybeAutomatic(scopes)) Complete (Result As AuthorizationResult)
	If Result.Success = False Then
		Log("Failed: " & Result.Error)
	Else if Result.ResolutionNeeded Then
		Log("resolution needed...")
		Wait For (ga.AuthorizeRequestAccess(Result)) Complete (Result As AuthorizationResult)
		If Result.Success = False Then
			Log("Failed: " & Result.Error)
		End If
	End If
	If Result.Token <> "" Then
		Dim j As HttpJob
		j.Initialize("", Me)
		j.Download2("https://people.googleapis.com/v1/people/me", _
	 		Array As String("access_token", Result.Token, "requestMask.includeField", "person.email_addresses,person.birthdays,person.names"))
		Wait For (j) JobDone(j As HttpJob)
		If j.Success Then
			ParsePersonData(j.GetString)
		Else
			Log(j.ErrorMessage)
			Log("Clearing token cache")
			Wait For (ga.ClearToken(Result.Token)) Complete (Success As Boolean) 'requires updating com.google.android.gms:play-services-auth
		End If
		j.Release
	End If
End Sub

Sub ParsePersonData (data As String)
	Dim map As Map = data.As(JSON).ToMap
	Dim names As List = map.Get("names")
	If names.Size > 0 Then
		Dim name As Map = names.Get(0)
		Log(name.Get("displayName"))
	End If
	Dim birthdays As List = map.Get("birthdays")
	If Initialized(birthdays) And birthdays.Size > 0 Then
		Dim b As Map = birthdays.Get(0)
		b = b.Get("date")
		Log($"$2{b.Get("day")}/$2{b.Get("month")}"$)
	End If
	Dim emails As List = map.Get("emailAddresses")
	If Initialized(emails) And emails.Size > 0 Then
		Dim email As Map = emails.Get(0)
		Log(email.Get("value"))
	End If
End Sub


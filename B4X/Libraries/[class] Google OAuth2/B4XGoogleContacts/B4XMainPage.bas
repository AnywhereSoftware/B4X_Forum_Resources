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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=B4XGoogleContacts.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	#if B4J
	Private ClientId As String = "248164679394-9mxxxxxxxel33ri8dm8e4f2.apps.googleusercontent.com"
	Private ClientSecret As String = "lsuyDOr_v9-O4P7o9BhJQ3qD"
	#else if B4A
	Private ClientId As String = "248164679394-kqxxxxxx9atbin08u4gaqqtk.apps.googleusercontent.com"
	Private ClientSecret As String = "" 'leave empty!
	#else if B4i
	Private ClientId As String = "248164679394-mmxxxxxxxxx0a51b6ie7llv6muk1r.apps.googleusercontent.com"
	Private ClientSecret As String = "" 'leave empty!
	#End If
	Public oauth2 As GoogleOAuth2
	Private lblBirthday As B4XView
	Private lblEmail As B4XView
	Private lblName As B4XView
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	xui.SetDataFolder("B4XGoogleContacts") 'only required for B4J
	oauth2.Initialize(Me, "oauth2", ClientId, "profile email https://www.googleapis.com/auth/user.birthday.read", _
		ClientSecret, xui.DefaultFolder)
	'oauth2.ResetToken 'uncomment if you changed the scope or want to reset the token
End Sub

Private Sub B4XPage_Foreground
	#if B4A
	oauth2.CallFromResume(B4XPages.GetNativeParent(Me).GetStartingIntent)
	#End If
End Sub

Sub btnGetData_Click
	oauth2.GetAccessToken
	Wait For OAuth2_AccessTokenAvailable (Success As Boolean, Token As String)
	If Success = False Then
		Log("Error accessing account.")
		Return
	End If
	Dim j As HttpJob
	j.Initialize("", Me)
	'full list of features available: person.addresses,person.age_ranges,person.biographies,person.birthdays,person.bragging_rights,person.cover_photos,person.email_addresses,person.events,person.genders,person.im_clients,person.interests,person.locales,person.memberships,person.metadata,person.names,person.nicknames,person.occupations,person.organizations,person.phone_numbers,person.photos,person.relations,person.relationship_interests,person.relationship_statuses,person.residences,person.skills,person.taglines,person.urls
	j.Download2("https://people.googleapis.com/v1/people/me", _
	 	Array As String("access_token", Token, "requestMask.includeField", "person.email_addresses,person.birthdays,person.names"))
	Wait For (j) JobDone(j As HttpJob)
	If j.Success Then
		ParsePersonData(j.GetString)
	Else
		oauth2.ResetToken
		Log("Online data not available.")
	End If
	j.Release
End Sub


Sub ParsePersonData (data As String)
	Dim jp As JSONParser
	jp.Initialize(data)
	Dim map As Map = jp.NextObject
	Dim names As List = map.Get("names")
	If names.IsInitialized And names.Size > 0 Then
		Dim name As Map = names.Get(0)
		lblName.Text = name.Get("displayName")
	End If
	Dim birthdays As List = map.Get("birthdays")
	If birthdays.IsInitialized And  birthdays.Size > 0 Then
		Dim b As Map = birthdays.Get(0)
		b = b.Get("date")
		lblBirthday.Text = $"$2{b.Get("day")}/$2{b.Get("month")}"$
	End If
	Dim emails As List = map.Get("emailAddresses")
	If emails.IsInitialized And emails.Size > 0 Then
		Dim email As Map = emails.Get(0)
		lblEmail.Text = email.Get("value")
	End If
End Sub


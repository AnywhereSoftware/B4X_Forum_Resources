B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.9
@EndOfDesignText@
#If Documentation
Updates
V1.00
	-Release
V1.01
	-Add GetEmail - gets the email-address from the user
V1.02
	-Add tag to TokenInformations
#End If

#Event: AccessTokenAvailable (Success As Boolean, Token As String)
'call TokenInformationFromResponse
#Event: RefreshToken (RefreshToken As String)
'call TokenInformationFromResponse
#Event: Authenticate
Sub Class_Globals
	Private mTarget As Object
	Private mEventName As String
	
	Type TokenInformations (AccessToken As String, RefreshToken As String, AccessExpiry As Long, Valid As Boolean,Email As String,Tag As Object)
	Private ti As TokenInformations
	
	Private Const TokenFile As String = "firebaseauth2token.dat"
	Private TokenFolder As String
	Private xui As XUI
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(Target As Object, EventName As String)
	mTarget = Target
	mEventName = EventName
	
	#if B4A
	TokenFolder = File.DirInternal
	#Else If B4i
		TokenFolder = File.DirLibrary
	#Else If B4J
		xui.SetDataFolder("ready-rent-support")
		TokenFolder = xui.DefaultFolder
	#End If
	
	If File.Exists(TokenFolder, TokenFile) Then
		Dim raf As RandomAccessFile
		raf.Initialize(TokenFolder, TokenFile, True)
		ti = raf.ReadB4XObject(raf.CurrentPosition)
		raf.Close
	End If
	
End Sub


Public Sub TokenInformationFromResponse (m As Map)
	ti.AccessExpiry = DateTime.Now + m.Get("expiresIn") * 1000 - 5 * 60 * 1000
	ti.AccessToken = m.Get("idToken")
	ti.Email = m.Get("email")
	If m.ContainsKey("refreshToken") Then ti.RefreshToken = m.Get("refreshToken")
	ti.Valid = True
	If m.ContainsKey("tag") Then ti.Tag = m.Get("tag")
	Log($"Token received. Expires: $DateTime{ti.AccessExpiry}"$)
	SaveToken
	RaiseEvent_AccessTokenAvailable(True)
End Sub


Private Sub SaveToken
	Dim raf As RandomAccessFile
	raf.Initialize(TokenFolder, TokenFile, False)
	raf.WriteB4XObject(ti, raf.CurrentPosition)
	raf.Close
End Sub

Public Sub ResetToken
	Log("Token reset!!!")
	ti.Valid = False
	SaveToken
End Sub

Public Sub GetAccessToken
	If ti.Valid = False Then
		'Authenticate
		RaiseEvent_Authenticate
	Else If ti.AccessExpiry < DateTime.Now Then
		'GetTokenFromRefresh
		RaiseEvent_RefreshToken
	Else
		RaiseEvent_AccessTokenAvailable(True)
	End If
End Sub

Public Sub GetEmail As String
	Return ti.Email
End Sub

Public Sub GetTag As Object
	Return ti.Tag
End Sub

Private Sub RaiseEvent_AccessTokenAvailable(Success As Boolean)
	If xui.SubExists(mTarget, mEventName & "_AccessTokenAvailable",2) Then
		CallSubDelayed3(mTarget, mEventName & "_AccessTokenAvailable", Success, ti.AccessToken)
	End If
End Sub

Private Sub RaiseEvent_RefreshToken
	If xui.SubExists(mTarget, mEventName & "_RefreshToken",1) Then
		CallSubDelayed2(mTarget, mEventName & "_RefreshToken", ti.RefreshToken)
	End If
End Sub

Private Sub RaiseEvent_Authenticate
	If xui.SubExists(mTarget, mEventName & "_Authenticate",0) Then
		CallSubDelayed(mTarget, mEventName & "_Authenticate")
	End If
End Sub
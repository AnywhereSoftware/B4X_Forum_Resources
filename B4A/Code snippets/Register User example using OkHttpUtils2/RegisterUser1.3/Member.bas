B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=7.3
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: False
#End Region

Sub Process_Globals

End Sub

Sub Globals
	Type TwoLines (First As String, Second As String)
	Private ListView1 As ListView
	Private btnLogout As Button
	Private lblMessage As Label
End Sub

Sub Activity_Create(FirstTime As Boolean)
	Activity.LoadLayout("frmMember")
	lblMessage.Text = "Welcome, " & Login.strUserName 
	LoadMemberList
End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

Sub LoadMemberList
	Dim Job3 As HttpJob
	Job3.Initialize("Member", Me)
	Job3.Download(Main.strURL & "member.php")
	ProgressDialogShow("Downloading list of registered members")
End Sub

Sub LogMeOut
	Dim Job4 As HttpJob
	Job4.Initialize("LogOut", Me)
	Job4.Download2(Main.strURL & "signout.php", _
	Array As String("user_id", Login.strUserID))	
	ProgressDialogShow("Logging out...")
End Sub

Sub JobDone (Job As HttpJob)
	ProgressDialogHide
	If Job.Success = True Then
		Dim strReturn As String = Job.GetString
		Dim parser As JSONParser
        parser.Initialize(strReturn)
		If Job.JobName = "Member" Then
			Dim Members As List
			Dim strOnline As String
			Members = parser.NextArray 'returns a list with maps
			For i = 0 To Members.Size - 1
				Dim m As Map
				m = Members.Get(i)
				Dim TL As TwoLines
				If m.Get("online") = "Y" Then
					strOnline = " (Online)"
				Else
					strOnline = ""
				End If
				TL.First = m.Get("user_id") & strOnline
				TL.Second = m.Get("location")
				ListView1.AddTwoLines2(TL.First, TL.Second, TL)
			Next
		Else If Job.JobName = "LogOut" Then
			Dim act As String = parser.NextValue
			If act = "LoggedOut" Then
				ToastMessageShow("Logout successful", True)				
				StartActivity(Main)
				Activity.Finish 
			End If				
		Else
			ToastMessageShow("Error: Invalid Value", True)
		End If
	Else
		'Log("Error: " & Job.ErrorMessage)
		ToastMessageShow("Error: " & Job.ErrorMessage, True)
	End If
	Job.Release
End Sub

Sub btnChangePassword_Click
	StartActivity("Change")
End Sub

Sub btnLogout_Click
	LogMeOut
End Sub
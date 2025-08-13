Type=Activity
Version=4
ModulesStructureVersion=1
B4A=true
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
	'StartActivity("Main")
	'Log("Load Main")
End Sub

Sub LoadMemberList
	Dim Member As HttpJob
	Member.Initialize("Member", Me)
	Member.Download("http://kbase.herobo.com/member.php")
	ProgressDialogShow("Downloading list of registered members")
End Sub

Sub LogMeOut
	Dim LogOut As HttpJob
	LogOut.Initialize("LogOut", Me)
	LogOut.Download2("http://kbase.herobo.com/signout.php", _
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

Sub btnLogout_Click
	LogMeOut
End Sub
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
	Dim strUserID As String
	Dim strUserName As String 
End Sub

Sub Globals
	Dim txtUserID As EditText
	Dim txtPassword As EditText
	Dim lblMessage As Label
End Sub

Sub Activity_Create(FirstTime As Boolean)
	Activity.LoadLayout("frmLogin")
End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)
	
End Sub

Sub btnLogin_Click
	'Dim strUserID As String = txtUserID.Text.Trim
	lblMessage.Text = ""
	strUserID = txtUserID.Text.Trim
	If strUserID = "" Then
		Msgbox("Please enter User ID", "Error")
		Return
	End If	
	Dim strPassword As String = txtPassword.Text.Trim 
	If strPassword = "" Then
		Msgbox("Please enter Password", "Error")
		Return
	End If	
	
	Dim Job2 As HttpJob
	Job2.Initialize("Login", Me)
	Job2.Download2(Main.strURL & "signin.php", _
	Array As String("user_id", strUserID, "password", strPassword))
	ProgressDialogShow("Connecting to server...")
End Sub

Sub JobDone (Job As HttpJob)
	ProgressDialogHide
	If Job.Success = True Then
		Dim ret As String
		Dim act As String		
		ret = Job.GetString 		
		Dim parser As JSONParser
        parser.Initialize(ret)		
		act = parser.NextValue
		If act = "Not Found" Then
			ToastMessageShow("Login failed", True)
			lblMessage.Text = "Wrong User ID or Password!"
			lblMessage.TextColor = Colors.Red
        Else If act = "Not Activated" Then
			ToastMessageShow("Login failed", True)
			lblMessage.Text = "Account is not activated!"
			lblMessage.TextColor = Colors.Blue			
		Else If act = "Error" Then
			ToastMessageShow("Login failed", True)
			lblMessage.Text = "An error has occured!"
			lblMessage.TextColor = Colors.Red
		Else
			strUserName = act
			StartActivity("Member")
			Activity.Finish 
		End If
	Else
		'Log("Error: " & Job.ErrorMessage)
		ToastMessageShow("Error: " & Job.ErrorMessage, True)
	End If
	Job.Release
End Sub

'Sub btnForgotMyPassword_Click
'	StartActivity("Forgot")
'End Sub

Sub btnResetMyPassword_Click
	StartActivity("Reset")
End Sub
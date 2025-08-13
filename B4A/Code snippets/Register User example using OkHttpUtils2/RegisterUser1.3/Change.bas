B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=8.8
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: False
#End Region

Sub Process_Globals

End Sub

Sub Globals
	Private txtEmail As EditText
	Private txtPassword1 As EditText
	Private txtPassword2 As EditText
	Private txtPassword3 As EditText
End Sub

Sub Activity_Create(FirstTime As Boolean)
	Activity.LoadLayout("frmChange")
End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

Sub btnSubmit_Click
	Dim strEmail As String = txtEmail.Text.Trim
	If strEmail = "" Then
		Msgbox("Please enter Your Email", "Error")
		Return
	End If
	Dim strPassword1 As String = txtPassword1.Text.Trim
	If strPassword1 = "" Then
		Msgbox("Please enter Current Password", "Error")
		Return
	End If
	Dim strPassword2 As String = txtPassword2.Text.Trim
	If strPassword2 = "" Then
		Msgbox("Please enter New Password", "Error")
		Return
	End If
	Dim strPassword3 As String = txtPassword3.Text.Trim
	If strPassword3 = "" Then
		Msgbox("Please reenter New Password", "Error")
		Return
	End If
	If strPassword2 <> strPassword3 Then
		Msgbox("New Password not match", "Error")
		Return
	End If
	
	Dim Job6 As HttpJob
	Job6.Initialize("Change", Me)
	Job6.Download2(Main.strURL & "change-password.php", _
	Array As String("Email", strEmail, _
	"Password1", strPassword1, _
	"Password2", strPassword2))
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
		If act = "Success" Then
			Msgbox("Password updated successfully!", "Change Password")
		Else If act = "Not Found" Then		
			Msgbox("Email or Password not correct!", "Change Password")
		Else If act = "Error" Or act = "Failed" Then
			Msgbox("An error occured!", "Change Password")
		Else ' Failed
			Msgbox("Uncaught error!", "Change Password")
		End If
	Else
		'Log("Error: " & Job.ErrorMessage)
		ToastMessageShow("Error: " & Job.ErrorMessage, True)
	End If
	Job.Release
End Sub
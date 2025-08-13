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
	Private txtEmail As EditText
	Dim strEmail As String
End Sub

Sub Activity_Create(FirstTime As Boolean)
	Activity.LoadLayout("frmReset")
End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

Sub btnSubmit_Click
	strEmail = txtEmail.Text.Trim
	If strEmail = "" Then
		Msgbox("Please enter Email", "Error")
		Return
	End If	
	If Validate_Email(strEmail) = False Then
		Msgbox("Email format is incorrect", "Error")
		Return
	End If
    Dim Job5 As HttpJob
	Job5.Initialize("ResetPassword", Me)
	Job5.Download2(Main.strURL & "reset-password.php", _
      Array As String("Action", "RequestPasswordReset", _
	  "Mail", strEmail))
	ProgressDialogShow("Connecting to server...")
End Sub

Sub JobDone (Job As HttpJob)
    ProgressDialogHide
    If Job.Success Then
	Dim res As String, action As String
    	res = Job.GetString        
		Dim parser As JSONParser
        parser.Initialize(res)
        Select Job.JobName
            Case "ResetPassword"
                action = parser.NextValue
                If action = "ValidEmail" Then
                    Msgbox("An email was sent to " & strEmail & " to reset your password.", "Reset Password")					
				Else If action = "InvalidEmail" Then
                    Msgbox("The email is not registered in our database.", "Reset Password")
                End If
		End Select
	Else
		'Log("Error: " & Job.ErrorMessage)
		ToastMessageShow("Error: " & Job.ErrorMessage, True)
	End If
	Job.Release	
End Sub

' // Source: http://www.b4x.com/android/forum/threads/validate-a-correctly-formatted-email-address.39803/
Sub Validate_Email(EmailAddress As String) As Boolean
    Dim MatchEmail As Matcher = Regex.Matcher("^(?i)[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])$", EmailAddress)
 
    If MatchEmail.Find = True Then
        'Log(MatchEmail.Match)
        Return True
    Else
        'Log("Oops, please double check your email address...") 
        Return False
    End If
End Sub
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
	Dim txtUserID As EditText
	Dim txtPassword As EditText
	Dim txtFullName As EditText
	Dim txtLocation As EditText 
	Dim txtEmail As EditText
End Sub

Sub Activity_Create(FirstTime As Boolean)
	Activity.LoadLayout("frmRegister")
End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

Sub btnRegister_Click
	Dim strUserID As String = txtUserID.Text.Trim
	If strUserID = "" Then
		Msgbox("Please enter User ID", "Error")
		Return
	End If	
	Dim strPassword As String = txtPassword.Text.Trim 
	If strPassword = "" Then
		Msgbox("Please enter Password", "Error")
		Return
	End If
	Dim strFullName As String = txtFullName.Text.Trim
	If strFullName = "" Then
		Msgbox("Please enter Full Name", "Error")
		Return
	End If
	Dim strLocation As String = txtLocation.Text.Trim
	If strLocation = "" Then
		Msgbox("Please enter Location", "Error")
		Return
	End If
	Dim strEmail As String = txtEmail.Text.Trim
	If strEmail = "" Then
		Msgbox("Please enter Email", "Error")
		Return
	End If	
	If Validate_Email(strEmail) = False Then
		Msgbox("Email format is incorrect", "Error")
		Return
	End If	
	
    Dim Job1 As HttpJob
	Job1.Initialize("Register", Me)
	Job1.Download2(Main.strURL & "signup.php", _
      Array As String("Action", "Register", _
	  "UserID", txtUserID.Text, _
	  "Password", txtPassword.Text, _
	  "FullName", txtFullName.Text, _
	  "Location", txtLocation.text, _
	  "Email", txtEmail.Text))
	ProgressDialogShow("Connecting to server...")
End Sub

Sub JobDone (Job As HttpJob)
    ProgressDialogHide
    If Job.Success Then
		Dim parser As JSONParser
    	Dim res As String
		Dim action As String
    	res = Job.GetString		
        parser.Initialize(res)                
        Select Job.JobName
            Case "Register"
                action = parser.NextValue
                If action = "Mail" Then
                    Msgbox("An email was sent to " & txtEmail.Text & ". Please click on the link to finish registration", "Registration")
					Activity.Finish
				Else If action = "MailInUse" Then
                    Msgbox("The user id '" & txtUserID.Text & "' or email (" & txtEmail.Text & ") is already in used", "Registration")
				Else
					Msgbox("Server does not return expected result.", "Registration")
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
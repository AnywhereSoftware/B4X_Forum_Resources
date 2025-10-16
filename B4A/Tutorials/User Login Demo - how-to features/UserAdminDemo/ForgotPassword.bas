B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=13.4
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: True
#End Region

Sub Process_Globals
	Private xui As XUI
End Sub

Sub Globals
	Private bar As StdActionBar
	Private ime As IME
	Private txtEmail As EditText
	Private btnContinue As Button
	Private lblUsername As Label
End Sub

Sub Activity_Create(FirstTime As Boolean)
	bar.Initialize("")
	bar.NavigationMode = bar.NAVIGATION_MODE_STANDARD
	bar.ShowUpIndicator = True
	
	ime.Initialize("IME")
	
	Activity.LoadLayout("ForgotPassword")
	Activity.Title = "Forgot Password"
	
	Utils.SetETHint(txtEmail)
	Utils.SetETStyle(txtEmail,xui.Color_Black)
	
	txtEmail.InputType = Utils.TYPE_EMAIL_ADDRESS
	btnContinue.Enabled = False
End Sub

Sub Activity_Resume
End Sub

Sub Activity_Pause (UserClosed As Boolean)
End Sub

Sub Activity_ActionBarHomeClick
	ime.HideKeyboard
	Activity.Finish
End Sub


Private Sub btnSend_Click
	Dim email As String = txtEmail.Text.Trim
	If email = "" Then
		txtEmail.RequestFocus
		ToastMessageShow("Email is required!", False)
		Return
	End If
	
	ime.HideKeyboard
    
	Dim user As Map = DBCalls.GetUserByEmail(email)
	If user.IsInitialized And user.ContainsKey("id") Then
		Dim id As Int = user.Get("id")
		Dim uname As String = user.Get("username")
		' Generate 6-digit verification code
		Dim code As String = Rnd(100000, 999999)
		DBCalls.SetResetCode(id, code, DateTime.Now)
        
		' Email intent
		Dim intent As Intent
		intent.Initialize(intent.ACTION_SEND, "")
		intent.SetType("message/rfc822")
		intent.PutExtra("android.intent.extra.EMAIL", Array As String(email))
		intent.PutExtra("android.intent.extra.SUBJECT", "Password Reset Code")
		intent.PutExtra("android.intent.extra.TEXT", "Hello " & uname & "," & CRLF & _
                        "Your reset code is: " & code & CRLF & "Valid for 10 minutes.")
		StartActivity(intent)
        
		btnContinue.Enabled = True
		ToastMessageShow("Check your email for the verification code", False)
	Else
		ToastMessageShow("Email not found", False)
	End If
End Sub

Private Sub btnContinue_Click
	ResetPassword.email = txtEmail.Text
	StartActivity(ResetPassword)
End Sub

Private Sub txtEmail_EnterPressed
	Dim email As String = txtEmail.Text
	If email = "" Then
		ToastMessageShow("Email address required!",False)
		Return
	End If
	
	Dim user As Map = DBCalls.GetUserByEmail(email)
	If user.IsInitialized And user.ContainsKey("id") Then
		Dim uname As String = user.Get("username")
		lblUsername.Text = " User: " & uname
	End If
End Sub

Private Sub txtEmail_FocusChanged (HasFocus As Boolean)
	If Not(HasFocus) Then
		Dim email As String = txtEmail.Text
		If email = "" Then
			ToastMessageShow("Email address required!",False)
			Return
		End If
	
		Dim user As Map = DBCalls.GetUserByEmail(email)
		If user.IsInitialized Then
			Dim uname As String = user.Get("username")
			lblUsername.Text = " User: " & uname
		End If
	End If
End Sub

Public Sub DisableContinueButton
	btnContinue.Enabled = False
End Sub
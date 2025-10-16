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
	Public email As String
	Private xui As XUI
End Sub

Sub Globals
	Private bar As StdActionBar
	Private ime As IME
	Private txtEmail As EditText
	Private txtNew As EditText
	Private txtConfirm As EditText
	Private pnlStrength As Panel
	Private lblStrength As Label
	Private txtDigit1 As EditText
	Private txtDigit2 As EditText
	Private txtDigit3 As EditText
	Private txtDigit4 As EditText
	Private txtDigit5 As EditText
	Private txtDigit6 As EditText	
	Private codeFields As List
	Private btnNewReveal As Button
	Private btnNewHide As Button
	Private btnConfirmReveal As Button
	Private btnConfirmHide As Button
	
	Private isClearing As Boolean = False
	Private lblUppercase As Label
	Private lblLowercase As Label
	Private lblNumber As Label
	Private lblSymbol As Label
	Private lblLength As Label
	Private pnlGroup As Panel
	Private pnlNew As Panel
	Private pnlConfirm As Panel
End Sub

Sub Activity_Create(FirstTime As Boolean)
	bar.Initialize("")
	bar.NavigationMode = bar.NAVIGATION_MODE_STANDARD
	bar.ShowUpIndicator = True
	
	ime.Initialize("IME")
	ime.AddHeightChangedEvent
	
	Activity.LoadLayout("ResetPassword")
	Activity.Title = "Reset Password"
	
	Utils.SetETHint(txtEmail)
	Utils.SetETHint(txtNew)
	Utils.SetETHint(txtConfirm)
	
	Utils.SetETStyle(txtEmail,xui.Color_Black)
	Utils.SetETStyle(txtDigit1,xui.Color_Black)
	Utils.SetETStyle(txtDigit2,xui.Color_Black)
	Utils.SetETStyle(txtDigit3,xui.Color_Black)
	Utils.SetETStyle(txtDigit4,xui.Color_Black)
	Utils.SetETStyle(txtDigit5,xui.Color_Black)
	Utils.SetETStyle(txtDigit6,xui.Color_Black)
	
	Utils.SetPasswordETStyle(txtNew)
	Utils.SetPasswordETStyle(txtConfirm)
	
	'Input Types
	txtEmail.InputType = Utils.TYPE_EMAIL_ADDRESS
	txtNew.InputType = Utils.TYPE_PASSWORD
	txtConfirm.InputType = Utils.TYPE_PASSWORD
	
	' Collect EditTexts into a List for easier looping
	codeFields.Initialize
	codeFields.AddAll(Array(txtDigit1,txtDigit2,txtDigit3,txtDigit4,txtDigit5,txtDigit6))
	
	' Set up all fields
	For Each txt As EditText In codeFields
		txt.Gravity = Gravity.CENTER
		txt.TextSize = 22
		txt.InputType = txt.INPUT_TYPE_NUMBERS
	Next
	
	pnlStrength.Width = 0
	txtEmail.Text = email
	
	btnNewReveal.Visible = True
	btnNewHide.Visible = False
	
	btnConfirmReveal.Visible = True
	btnConfirmHide.Visible = False
End Sub

Sub Activity_Resume
End Sub

Sub Activity_Pause (UserClosed As Boolean)
End Sub

Sub Activity_ActionBarHomeClick
	ime.HideKeyboard
	Activity.Finish
End Sub


' Each EditText has its own TextChanged event
Sub txtDigit1_TextChanged (Old As String, New As String)
	HandleDigitEntry(txtDigit1, New)
End Sub

Sub txtDigit2_TextChanged (Old As String, New As String)
	HandleDigitEntry(txtDigit2, New)
End Sub

Sub txtDigit3_TextChanged (Old As String, New As String)
	HandleDigitEntry(txtDigit3, New)
End Sub

Sub txtDigit4_TextChanged (Old As String, New As String)
	HandleDigitEntry(txtDigit4, New)
End Sub

Sub txtDigit5_TextChanged (Old As String, New As String)
	HandleDigitEntry(txtDigit5, New)
End Sub

Sub txtDigit6_TextChanged (Old As String, New As String)
	HandleDigitEntry(txtDigit6, New)
End Sub

' Shared logic for all six fields
Sub HandleDigitEntry(et As EditText, New As String)
	If isClearing Then Return  ' skip handling during clearing
	
	'only accept 1 character for each Digit field
	If New.Length = 1 Then
		' Move focus to next field
		Dim index As Int = codeFields.IndexOf(et)
		If index < codeFields.Size - 1 Then
			Dim nextField As EditText = codeFields.Get(index + 1)
			nextField.RequestFocus
		Else
			' All filled, then collect and validate
			Sleep(100)
			Dim code As String
			For Each t As EditText In codeFields
				code = code & t.Text
			Next
			ValidateResetCode(code)
		End If
	Else If New.Length = 0 Then
		' If backspace pressed, move to previous
		Dim index As Int = codeFields.IndexOf(et)
		If index > 0 Then
			Dim prevField As EditText = codeFields.Get(index - 1)
			prevField.RequestFocus
		End If
	End If
End Sub

Sub ValidateResetCode(code As String)
	email = txtEmail.Text
	Dim user As Map = DBCalls.GetUserByEmail(email)
	Dim resetcode As String
	If user.IsInitialized Then
		resetcode = user.Get("reset_code")
	End If	
	
	If code = resetcode Then
		txtNew.RequestFocus
		ToastMessageShow("Code accepted!", False)
	Else
		Dim vib As PhoneVibrate
		vib.Vibrate(1000)
		
		'Dim jo As JavaObject = txtDigit6
		'jo.RunMethod("performHapticFeedback", Array(1))
		
		ToastMessageShow("Invalid code", False)
		ClearAllDigits
	End If
End Sub

Sub ClearAllDigits
	isClearing = True

	' Animate each field fading out
	For i = 0 To codeFields.Size - 1
		Dim t As EditText = codeFields.Get(i)
		t.SetVisibleAnimated(40, False)
		Sleep(15)
	Next
	
	Sleep(50)
	
	' Clear the text first
	For Each t As EditText In codeFields
		t.Text = ""
	Next	
	
	' Sweep fade back in (right to left)
	For i = codeFields.Size - 1 To 0 Step -1
		Dim t As EditText = codeFields.Get(i)
		t.SetVisibleAnimated(40, True)
		Sleep(15)
	Next
	
	Sleep(50)
	isClearing = False
	txtDigit1.RequestFocus
End Sub

Sub btnReset_Click
	email = txtEmail.Text
	Dim code1 As String = txtDigit1.Text.Trim
	Dim code2 As String = txtDigit2.Text.Trim
	Dim code3 As String = txtDigit3.Text.Trim
	Dim code4 As String = txtDigit4.Text.Trim
	Dim code5 As String = txtDigit5.Text.Trim
	Dim code6 As String = txtDigit6.Text.Trim
	
	Dim newpass As String = txtNew.Text.Trim
	Dim confirm As String = txtConfirm.Text.Trim
	
	If email = "" Or code1 = "" Or code2 = "" Or code3 = "" Or code4 = "" Or code5 = "" Or code6 = "" Or newpass = "" Or confirm = "" Then
		ToastMessageShow("All fields are required", False)
		Return
	End If
    
	If newpass <> confirm Then
		ToastMessageShow("Passwords do not match", False)
		Return
	End If
	
	If Not(IsStrongPassword(newpass)) Then
		ToastMessageShow("Password must be >=6 chars and include letters, numbers, symbols", False)
		Return
	End If
    
	Dim user As Map = DBCalls.GetUserByEmail(email)
	If user.IsInitialized And user.ContainsKey("id") Then
		Dim resetCode As String = user.Get("reset_code")
		Dim resetTime As Long = user.Get("reset_time")
        
		' Check code and expiry (10 minutes)
		If resetCode = (code1 & code2 & code3 & code4 & code5 & code6) And DateTime.Now - resetTime <= 10 * 60 * 1000 Then
			DBCalls.UpdatePassword(user.Get("id"), newpass)
			ToastMessageShow("Password reset successful.", False)
			ime.HideKeyboard
			CallSubDelayed(ForgotPassword,"DisableContinueButton")
			Activity.Finish
		Else
			ToastMessageShow("Invalid or expired code", False)
		End If
	Else
		ToastMessageShow("Email not found", False)
	End If
End Sub

Sub txtNew_TextChanged(Old As String, New As String)
	If IsStrongPassword(New) Then
		'
	End If
End Sub

Sub txtConfirm_TextChanged(Old As String, New As String)
	If New == txtNew.Text And New <> "" Then
		txtConfirm.Color = 0xFFFCFFA9
		pnlConfirm.Color = 0xFFFCFFA9
		ime.HideKeyboard
	Else
		txtConfirm.Color = xui.Color_Transparent
		pnlConfirm.Color = xui.Color_White
	End If
End Sub


Sub IsStrongPassword(pw As String) As Boolean
	Dim score As Int = 0
	
	Dim hasUpperLetter As Boolean = False
	Dim hasLowerLetter As Boolean = False
	Dim hasNumber As Boolean = False
	Dim hasSymbol As Boolean = False
	Dim hasLength As Boolean = False
	
	txtNew.Color = xui.Color_Transparent
	pnlNew.color = xui.Color_White
	lblUppercase.Text = ""
	lblLowercase.Text = ""
	lblNumber.Text = ""
	lblSymbol.Text = ""
	lblLength.Text = ""
	lblStrength.Text = ""
	
	For i = 0 To pw.Length - 1
		Dim c As String = pw.CharAt(i)
		'Upper case
		If Regex.IsMatch("[A-Z]", c) Then
			hasUpperLetter = True
			lblUppercase.Text = Chr(0xE5CA)
		End If
		'Lower case
		If Regex.IsMatch("[a-z]", c) Then
			hasLowerLetter = True
			lblLowercase.Text = Chr(0xE5CA)
		End If
		'Number
		If Regex.IsMatch("[0-9]", c) Then
			hasNumber = True
			lblNumber.Text = Chr(0xE5CA)
		End If
		'Symbol
		If Regex.IsMatch("[_=!#$%&()*+,-.:'/?@]", c) Then
			hasSymbol = True
			lblSymbol.Text = Chr(0xE5CA)
		End If
	Next
	
	'Length
	If pw.Length >= 6 Then
		hasLength = True
		lblLength.Text = Chr(0xE5CA)
		txtNew.Color = 0xFFFCFFA9
		pnlNew.Color = 0xFFFCFFA9
	End If
	
	If hasUpperLetter Then score = score + 1
	If hasUpperLetter And hasLowerLetter Then score = score + 1
	If hasUpperLetter And hasLowerLetter And hasNumber Then score = score + 1
	If hasUpperLetter And hasLowerLetter And hasNumber And hasSymbol Then score = score + 1
	If hasLength Then score = score + 1
	
	Dim maxWidth As Int = pnlNew.Width
	Dim newWidth As Int = (maxWidth / 5) * score
	
	pnlStrength.SetLayoutAnimated(200, pnlStrength.Left, pnlStrength.Top, newWidth, pnlStrength.Height)
    
	Select score
		Case 0,1
			pnlStrength.Color = xui.Color_Red
			lblStrength.Text = "Weak"
		Case 2,3
			pnlStrength.Color = xui.Color_Yellow
			lblStrength.Text = "Medium"
		Case 4
			pnlStrength.Color = xui.Color_Green
			lblStrength.Text = "Strong!"
		Case 5
			pnlStrength.Color = xui.Color_Green
			lblStrength.Text = "Pass!"
	End Select
	
	Return hasLength And hasUpperLetter And hasLowerLetter And hasNumber And hasSymbol
End Sub


Sub btnNewReveal_Click
	txtNew.PasswordMode = False
	btnNewReveal.Visible = False
	btnNewHide.Visible = True
End Sub

Sub btnNewHide_Click
	txtNew.PasswordMode = True
	btnNewReveal.Visible = True
	btnNewHide.Visible = False
End Sub

Sub btnConfirmReveal_Click
	txtConfirm.PasswordMode = False
	btnConfirmReveal.Visible = False
	btnConfirmHide.Visible = True
End Sub

Sub btnConfirmHide_Click
	txtConfirm.PasswordMode = True
	btnConfirmReveal.Visible = True
	btnConfirmHide.Visible = False
End Sub

Sub IME_HeightChanged (NewHeight As Int, OldHeight As Int)
	'pnlGroup.Top = NewHeight - pnlGroup.Top
End Sub






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
	Private txtUsername As EditText
	Private txtPassword As EditText
	Private txtEmail As EditText
	Private btnReveal As Button
	Private btnHide As Button
End Sub

Sub Activity_Create(FirstTime As Boolean)
	bar.Initialize("")
	bar.NavigationMode = bar.NAVIGATION_MODE_STANDARD
	bar.ShowUpIndicator = True
	
	ime.Initialize("IME")
	
	Activity.AddMenuItem3("Save","Save",Utils.FontToBitmap(Chr(0xE5CA),28,0xFFD5E9FF),True)
	Activity.LoadLayout("User_Edit")
	
	Utils.SetETHint(txtUsername)
	Utils.SetETHint(txtPassword)
	Utils.SetETHint(txtEmail)
	Utils.SetETStyle(txtUsername,xui.Color_Black)
	Utils.SetPasswordETStyle(txtPassword)
	Utils.SetETStyle(txtEmail,xui.Color_Black)
	
	txtPassword.InputType = Utils.TYPE_PASSWORD
	txtEmail.InputType = Utils.TYPE_EMAIL_ADDRESS
	btnReveal.Visible = True
	btnHide.Visible = False
	
	If Starter.SelectedUserId <> -1 Then
		Dim user As List = DBCalls.GetUserById(Starter.SelectedUserId)
		If user.IsInitialized Then
			For Each u As Map In user
				txtUsername.Text = u.Get("username")
				txtPassword.Text = u.Get("password")
				txtEmail.Text = u.Get("email")				
			Next
			Activity.Title = "User Edit"
		End If
		If u.Get("username") <> "admin" Then
			Activity.AddMenuItem3("Delete","Delete",Utils.FontToBitmap(Chr(0xE92B),28,xui.Color_White),True)
		End If
	Else
		Activity.Title = "User Add"
	End If
End Sub

Sub Activity_Resume
End Sub

Sub Activity_Pause (UserClosed As Boolean)
End Sub

Sub Activity_ActionBarHomeClick
	ime.HideKeyboard
	Activity.Finish
End Sub


Sub Save_Click
	Dim uname As String = txtUsername.Text
	Dim pswd As String = txtPassword.Text
	Dim email As String = txtEmail.Text
	
	If Starter.SelectedUserId = -1 Then
		DBCalls.InsertUser(uname,pswd,email,False)
	Else
		DBCalls.UpdateUser(Starter.SelectedUserId,uname,pswd,email)
	End If
	ime.HideKeyboard
	Activity.Finish
End Sub

Sub Delete_Click
	If Starter.SelectedUserId <> -1 Then
		DBCalls.DeleteUser(Starter.SelectedUserId)
		Activity.Finish
	End If
End Sub

Private Sub btnReveal_Click
	txtPassword.PasswordMode = False
	btnReveal.Visible = False
	btnHide.Visible = True
End Sub

Private Sub btnHide_Click
	txtPassword.PasswordMode = True
	btnReveal.Visible = True
	btnHide.Visible = False
End Sub
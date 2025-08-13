B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=12.5
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	Private xtf_Username As AS_TextFieldAdvanced
	Private xlbl_Login As ASLabel
End Sub

'You can add more parameters here.
Public Sub Initialize As Object
	Return Me
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	'load the layout to Root
	Root.LoadLayout("frm_Login")
End Sub

Private Sub GenerateRandomPasswordString(Length As Int) As String
	Dim sb As StringBuilder
	sb.Initialize
	For i = 1 To Length
		Dim C As Int = Rnd(48, 122)
    
		Do While (C>= 58 And C<=64) Or (C>= 91 And C<=96)
			C = Rnd(48, 122)
		Loop
    
		sb.Append(Chr(C))
	Next
	Return sb.ToString
End Sub

Private Sub xlbl_Login_Click
	
	If xtf_Username.Text.Length <= 3 Then
		xtf_Username.ShowDisplayMissingField("At least 4 characters")
	Else
		xtf_Username.HideDisplayMissingField
		Dim AdditionalUserMetadata As Map = CreateMap("username":xtf_Username.Text)
	
		Dim tmpEmail As String = $"${GenerateRandomPasswordString(10)}@gmail.com"$
		Dim tmpPassword As String = GenerateRandomPasswordString(20)
	
		Wait For (B4XPages.MainPage.xSupabase.Auth.SignUp(tmpEmail,tmpPassword,AdditionalUserMetadata)) Complete (User As SupabaseUser)
		If User.Error.Success Then
			'Log("successfully logged in with " & User.Email)
		
			Wait For (B4XPages.MainPage.xSupabase.Auth.LogIn_EmailPassword(tmpEmail,tmpPassword)) Complete (User As SupabaseUser)
			If User.Error.Success Then
				B4XPages.ClosePage(Me)
			Else
				Log("Error: " & User.Error.ErrorMessage)
			End If
		
		
		Else
			Log("Error: " & User.Error.ErrorMessage)
		End If
	End If
	
End Sub

Private Sub xtf_Username_TextChanged(Text As String)
	If Text.Length > 3 Then
		xlbl_Login.xLabel.Color = xui.Color_ARGB(255,73, 98, 164)
	Else
		xlbl_Login.xLabel.Color = xui.Color_ARGB(100,73, 98, 164)
	End If
End Sub
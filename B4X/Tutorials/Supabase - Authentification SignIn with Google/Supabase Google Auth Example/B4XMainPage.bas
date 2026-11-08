B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Public xSupabase As Supabase

End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	B4XPages.SetTitle(Me,"Supabase Example")
	
	xSupabase.Initialize("https://xxx.supabase.co","xxx")
	xSupabase.InitializeEvents(Me,"Supabase")
	
End Sub

Private Sub B4XPage_Foreground
	#if B4A
	xSupabase.Auth.CallFromResume(B4XPages.GetNativeParent(Me).GetStartingIntent)
	#End If
End Sub


#IF B4J
Private Sub xlbl_SignInWithGoogle_MouseClicked (EventData As MouseEvent)
#Else
Private Sub xlbl_SignInWithGoogle_Click
#End If
	
	#If B4A
	Wait For (xSupabase.Auth.SignInWithOAuth("xxx.apps.googleusercontent.com","google","profile email https://www.googleapis.com/auth/userinfo.email")) Complete (User As SupabaseUser)
	#Else If B4I
	Wait For (xSupabase.Auth.SignInWithOAuth("xxx.apps.googleusercontent.com","google","profile email https://www.googleapis.com/auth/userinfo.email")) Complete (User As SupabaseUser)
	#Else If B4J
	Wait For (xSupabase.Auth.SignInWithOAuth("xxx.apps.googleusercontent.com","google","profile email https://www.googleapis.com/auth/userinfo.email","xxx")) Complete (User As SupabaseUser)
	#End If

	If User.Error.Success Then
		Log("successfully logged in with " & User.Email)
		xui.MsgboxAsync("successfully logged in with " & User.Email, "SignIn with Google")
	Else
		Log("Error: " & User.Error.ErrorMessage)
		xui.MsgboxAsync("Error: " & User.Error.ErrorMessage, "SignIn with Google")
	End If
	
End Sub
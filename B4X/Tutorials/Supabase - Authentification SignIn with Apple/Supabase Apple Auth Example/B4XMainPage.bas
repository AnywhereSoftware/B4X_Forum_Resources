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
	

	Wait For (xSupabase.Auth.SignInWithOAuth("","apple","")) Complete (User As SupabaseUser)

	If User.Error.Success Then
		Log("successfully logged in with " & User.Email)
		xui.MsgboxAsync("successfully logged in with " & User.Email, "SignIn with Apple")
	Else
		Log("Error: " & User.Error.ErrorMessage)
		xui.MsgboxAsync("Error: " & User.Error.ErrorMessage, "SignIn with Apple")
	End If
	
End Sub
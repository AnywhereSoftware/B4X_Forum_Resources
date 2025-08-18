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
	
	Private Fauth As FirebaseAuth
	
	Public Page2 As B4XPagePush
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("login")
	B4XPages.SetTitle(Me,"Login")
	
	Page2.Initialize
	B4XPages.AddPage("Message", Page2)
	
	Fauth.Initialize("Fauth")
End Sub


Sub btnSignIn_Click
	#IF B4A
	If Fauth.CurrentUser.IsInitialized Then 
		Fauth_SignedIn(Fauth.CurrentUser)
	Else
		Fauth.SignInWithGoogle
	End If
	#ELSE IF B4i

	Fauth.SignInWithGoogle( B4XPages.GetNativeParent(B4XPages.GetPage("MainPage")) )
	#END IF
End Sub

Sub btnSignOut_Click
	Fauth.SignOutFromGoogle
	Log("Goodbye!")
	xui.MsgboxAsync("Disconnect","Info")
End Sub

Sub Fauth_SignedIn (User As FirebaseUser)
	Log("SignedIn: " & User.DisplayName)
	B4XPages.ShowPage("Message")
	Page2.User=User
End Sub

#IF B4i
Public Sub Application_OpenUrl (Url As String, Data As Object, SourceApplication As String) As Boolean
	If Fauth.OpenUrl(Url, Data, SourceApplication) Then Return True
	Return False
End Sub
#END IF

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

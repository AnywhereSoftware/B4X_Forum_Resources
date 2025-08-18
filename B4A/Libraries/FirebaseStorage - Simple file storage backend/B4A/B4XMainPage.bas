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
	Private btnUploadAuth As B4XView
	Private btnDownloadPublic As B4XView
	Private btnUploadUser As B4XView
	Private btnSignIn As B4XView
	Private lblUser As B4XView
	Public auth As FirebaseAuth
	Private bucket As String = "gs://b4a-test1.appspot.com"
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("1")
	auth.Initialize("auth")
End Sub

Private Sub Auth_SignedIn (User As FirebaseUser)
	Log($"Signed in: ${User}"$)
	btnSignIn.Enabled = False
	btnUploadAuth.Enabled = True
	btnUploadUser.Enabled = True
	lblUser.Text = $"User: ${auth.CurrentUser.DisplayName}"$
End Sub

Sub btnSignIn_Click
	auth.SignInWithGoogle
End Sub

Sub btnDownloadPublic_Click
	'You need to first upload a file from Firebase console.
	Dim storage As FirebaseStorage = CreateFirebaseStorage
	storage.DownloadFile("/public/Untitled.png", File.DirInternal, "out.txt")
	Wait For (storage) Storage_DownloadCompleted (ServerPath As String, Success As Boolean)
	ToastMessageShow($"DownloadCompleted. Success = ${Success}"$, True)
	If Not(Success) Then Log(LastException)
End Sub


Sub btnUploadUser_Click
	Dim storage As FirebaseStorage = CreateFirebaseStorage
	File.WriteString(File.DirInternal, "1.txt", "Only I can access this resource.")
	storage.UploadFile(File.DirInternal, "1.txt", $"/user/${auth.CurrentUser.Uid}/1.txt"$)
	Wait For (storage) Storage_UploadCompleted (ServerPath As String, Success As Boolean)
	ToastMessageShow($"UploadCompleted. Success = ${Success}"$, True)
	If Not(Success) Then Log(LastException)
End Sub

Sub btnUploadAuth_Click
	Dim storage As FirebaseStorage = CreateFirebaseStorage
	File.WriteString(File.DirInternal, "1.txt", "Any authenticated user can access this resource.")
	storage.UploadFile(File.DirInternal, "1.txt", $"/auth/1.txt"$)
	Wait For (storage) Storage_UploadCompleted (ServerPath As String, Success As Boolean)
	ToastMessageShow($"UploadCompleted. Success = ${Success}"$, True)
	If Not(Success) Then Log(LastException)
End Sub

'By creating a new object each time, we can use the storage as a "sender filter" for the Wait For call.
'This is a lightweight object.
Sub CreateFirebaseStorage As FirebaseStorage
	Dim storage As FirebaseStorage
	storage.Initialize("storage", bucket)
	Return storage
End Sub



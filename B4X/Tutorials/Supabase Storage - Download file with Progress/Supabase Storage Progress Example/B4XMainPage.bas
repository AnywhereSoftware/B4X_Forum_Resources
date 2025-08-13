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

	Private AnotherProgressBar1 As AnotherProgressBar
	Private B4XImageView1 As B4XImageView
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
	
	Wait For (xSupabase.Auth.isUserLoggedIn) Complete (isLoggedIn As Boolean)
	
	If isLoggedIn = False Then
	
		Wait For (xSupabase.Auth.LogIn_EmailPassword("test@example.com","password")) Complete (User As SupabaseUser)
		If User.Error.Success Then
			Log("successfully logged in with " & User.Email)
		Else
			Log("Error: " & User.Error.ErrorMessage)
		End If
	
	End If
	
End Sub


#If B4J
Private Sub xlbl_DownloadFile_MouseClicked (EventData As MouseEvent)
#Else
Private Sub xlbl_DownloadFile_Click
#End If
	
	xui.SetDataFolder("supabase")
	Wait For (xSupabase.Storage.DownloadFileProgress("Avatar","test.png",Me,"DownloadProfileImage",xui.DefaultFolder).Execute) Complete (StorageFile As SupabaseStorageFile)
	If StorageFile.Error.Success Then
		Log($"File ${"test.jpg"} successfully downloaded "$)
		B4XImageView1.SetBitmap(xSupabase.Storage.BytesToImage(StorageFile.FileBody))
		If File.Exists(xui.DefaultFolder,"test.png") Then File.Delete(xui.DefaultFolder,"test.png") 'Clean the download path, or do what ever you want
	Else
		Log("Error: " & StorageFile.Error.ErrorMessage)
	End If
	
End Sub


Private Sub DownloadProfileImage_RangeDownloadTracker(Tracker As SupabaseRangeDownloadTracker)
	If Tracker.CurrentLength > 0 Then
		Log($"$1.2{Tracker.CurrentLength / 1024 / 1024}MB / $1.2{Tracker.TotalLength / 1024 / 1024}MB"$)
		AnotherProgressBar1.Value = Tracker.CurrentLength / Tracker.TotalLength * 100
	End If
End Sub

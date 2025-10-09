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
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	CallSubDelayed(Me, "TestDropbox")
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub Button1_Click
	xui.MsgboxAsync("Hello world!", "B4X")
End Sub

Sub TestDropbox

    Dim 	DropBox 								As cDropBox


	Dim		DropBoxAppKey 							As String  = "<your app key>"
	Dim 	DropBoxAppSecret 						As String  = "<your app secret>"
	Dim		DropBoxToken							As String  = "<temp access token>"
	Dim		DropBoxAuthCode							As String  = "<First time Authorization Code>"
	Dim		DropBoxRefresh							As String  = "<refresh code>"

		
    		DropBox.Initialize(DropBoxAppKey, DropBoxAppSecret, DropBoxRefresh)

'------------------------------------------------------------------------------------------------------------------------------
'			Need to only do the below once when you first get your AuthorizationCode (Must register app first)
'				open a web-browser with this URL
'
'			Make sure you replace APP_KEY with your AppKey
'
'			https://www.dropbox.com/oauth2/authorize?client_id=APP_KEY&response_type=code&token_access_type=offline
'
'			wait for (DropBox.GetTokens(DropBoxAppKey, DropBoxAppSecret, DropBoxAuthCode)) Complete(DBResult As Map)
'------------------------------------------------------------------------------------------------------------------------------
	
			wait for(DropBox.EnsureAccessToken) Complete(Success As Boolean)
	
    		' --- List root folder ---
			wait for (DropBox.CreateDirectory("/BBs")) Complete(Success As Boolean)
			
			If  Success Then
				wait for (DropBox.Exists("/BBs")) Complete(Exists As Boolean)
			
				Log(IIf(Exists, "Directory Exists or Created", "Does Not Exists"))				
			End If

			wait for (DropBox.CreateDirectory("/BBs/BBsViewer")) Complete(Success As Boolean)
			
			If  Success Then
				wait for (DropBox.Exists("/BBs/BBsViewer")) Complete(Exists As Boolean)
			
				Log(IIf(Exists, "Directory Exists or Created", "Does Not Exists"))				
			End If
	
	
    		Log("Listing folder... /BBs/BBsViewer")
	
    		Wait For (DropBox.ListFiles("/BBs/BBsViewer", False)) Complete (xFiles As List)			
			
			xFiles.SortTypeCaseInsensitive("Name", True)
			
        	For Each f As cDropBox_ListItemType In xFiles
            	Log($"Name: ${f.Name}  IsDir: ${f.IsDirectory}  LastModified: ${f.LastModified}"$)
        	Next

    		' --- Create folder ---
			wait for (DropBox.Exists("/TestFolder")) Complete(Exists As Boolean)	
	
			If  Exists = False Then
    			Wait For (DropBox.CreateDirectory("/TestFolder")) Complete (Success As Boolean)

				If  Success Then
					wait for (DropBox.Exists("/TestFolder")) Complete(Exists As Boolean)
			
					Log(IIf(Exists, "Directory Exists", "Does Not Exists"))				
				End If		
			End If
	
'
'    		' --- Upload file ---

'			Create Upload File
#if B4A 
			File.WriteString(File.DirInternal, "myfile.txt", "This myfile.txt for dropbox upload test")
#else if B4J
			File.WriteString(File.DirApp, "myfile.txt", "This myfile.txt for dropbox upload test")
#else if B4I
			File.WriteString(File.DirDocuments, "myfile.txt", "This myfile.txt for dropbox upload test")
#end if

#if B4A 
    		Wait For (DropBox.UploadFile(File.DirInternal, "myfile.txt", "/TestFolder/myfile.txt")) Complete (xUploaded As Boolean)	
#else if B4J
    		Wait For (DropBox.UploadFile(File.DirApp, "myfile.txt", "/TestFolder/myfile.txt")) Complete (xUploaded As Boolean)	
#else if B4i	
    		Wait For (DropBox.UploadFile(File.DirDocuments, "myfile.txt", "/TestFolder/myfile.txt")) Complete (xUploaded As Boolean)
#end if
    		Log("Uploaded file? " & xUploaded)


			Log("List All Files")
			
    		Wait For (DropBox.ListFiles("", True)) Complete (xFiles As List)
			
			xFiles.SortTypeCaseInsensitive("Name", True)
			
        	For Each f As cDropBox_ListItemType In xFiles
            	Log($"Name: ${f.Name}  IsDir: ${f.IsDirectory}  LastModified: ${f.LastModified}"$)
        	Next

		
#if B4A 
			File.Delete(File.DirInternal, "myfile.txt")
#else if B4J
			File.Delete(File.DirApp, "myfile.txt")
#else if B4i			
			File.Delete(File.DirDocuments, "myfile.txt")
#end if	

'    ' --- Download file ---
#if B4A 
    		Wait For (DropBox.DownloadFile("/TestFolder/myfile.txt", File.DirInternal, "myfile_copy.txt")) Complete (xDownloaded As Boolean)

    		Log($"Downloaded file? ${xDownloaded}"$)

			If  xDownloaded Then	
				Log($"File Contents:${File.ReadString(File.DirInternal, "myfile_copy.txt")}"$)

				File.Delete(File.DirInternal, "myfile_copy.txt")	
			End If
#else if B4J
    		Wait For (DropBox.DownloadFile("/TestFolder/myfile.txt", File.DirApp, "myfile_copy.txt")) Complete (xDownloaded As Boolean)

    		Log($"Downloaded file? ${xDownloaded}"$)

			If  xDownloaded Then	
				Log($"File Contents:${File.ReadString(File.DirApp, "myfile_copy.txt")}"$)

				File.Delete(File.DirApp, "myfile_copy.txt")	
			End If
	
#else if B4i	
    		Wait For (DropBox.DownloadFile("/TestFolder/myfile.txt", File.DirDocuments, "myfile_copy.txt")) Complete (xDownloaded As Boolean)
	
			if  xDownloaded then
				Log($"File Contents:${File.ReadString(File.DirDocuments, "myfile_copy.txt")}"$)

				File.Delete(File.DirDocuments, "myfile_copy.txt")	
			end if
#end if
'
' 		   ' --- Delete file ---
    		Wait For (DropBox.DeleteFile("/TestFolder/myfile.txt")) Complete (xDeleted As Boolean)
        	Log("Deleted file? " & xDeleted)
'
' 		   ' --- Delete folder ---
    		Wait For (DropBox.DeleteFile("/TestFolder")) Complete (xFolderDeleted As Boolean)
        	Log("Deleted folder? " & xFolderDeleted)
		
			ExitApplication
End Sub

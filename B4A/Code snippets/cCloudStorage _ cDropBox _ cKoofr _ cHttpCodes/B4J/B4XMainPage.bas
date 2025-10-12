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

#if _YourKeys
	Dim		DropBoxAppKey 							As String  = "<your app key>"
	Dim 	DropBoxAppSecret 						As String  = "<your app secret>"
	Dim		DropBoxToken							As String  = "<temp access token>"
	Dim		DropBoxAuthCode							As String  = "<First time Authorization Code>"
	Dim		DropBoxRefresh							As String  = "<refresh code>"
	
	Dim 	KoofrKey								As String =  "<your Koofr app key>"		
#end if	

			'--------------------------------------------------------------------------------------------------
			'  We are defining 2 of CloudStorage because we are going to put them in an Array and loop 
			'		testing DropBox Storage in one and Koofr in the other
			'--------------------------------------------------------------------------------------------------
			Dim 	CloudStorageUsingDB						As cCloudStorage
			Dim 	CloudStorageUsingKoofr					As cCloudStorage

		
			'--------------------------------------------------------------------------------------------------------
			'	Initialize the DropBox version with the propr parameters 
			'--------------------------------------------------------------------------------------------------------			
			CloudStorageUsingDB.Initialize
			CloudStorageUsingDB.SetAuthorization(Array As String(DropBoxAppKey, DropBoxAppSecret, DropBoxRefresh))

			'--------------------------------------------------------------------------------------------------------
			'	Initialize the Koofr version with my KoofrKey
			'--------------------------------------------------------------------------------------------------------
			CloudStorageUsingKoofr.Initialize
			CloudStorageUsingKoofr.SetAuthorization(Array As String(KoofrKey))
	
	
			'--------------------------------------------------------------------------------------------------------		
			'	Put the 2 CloudStorage types in an Array
			'--------------------------------------------------------------------------------------------------------		
			Dim TestCloudStorage()		As cCloudStorage = Array As cCloudStorage(CloudStorageUsingDB, CloudStorageUsingKoofr)

'------------------------------------------------------------------------------------------------------------------------------
'			Need to only do the below once when you first get your AuthorizationCode (Must register app first)
'				open a web-browser with this URL
'
'			Make sure you replace APP_KEY with your AppKey
'
'			https://www.dropbox.com/oauth2/authorize?client_id=APP_KEY&response_type=code&token_access_type=offline
'
'			Dropbox needs to create access token so we need to wait on it
'			wait for (DropBox.GetTokens(DropBoxAppKey, DropBoxAppSecret, DropBoxAuthCode)) Complete(DBResult As Map)
'
'			Koofr requires NO wait just setting variables
'			Koofr.SetAuthorization(xUserName As String, xUserPWD As String)
'			Koofr.SetAuthorizationCode(xAuthorizedCode As String)
'------------------------------------------------------------------------------------------------------------------------------
	
			'--------------------------------------------------------------------------------------------------------			
			'	Loop the 2 cloud storage types (DropBox / Koofr) Testing all functions
			'--------------------------------------------------------------------------------------------------------					
			For Each CloudStorage As cCloudStorage In TestCloudStorage
				Log($"Testing ${CloudStorage.WhatStorageAreWeUsing}"$)
				
				If  CloudStorage.IsReady = False Then
					Log("For some reason CloudStorage not initialized correctly")
					Continue
				End If
				
    			' --- List root folder ---
				wait for (CloudStorage.CreateDirectory("/BBs")) Complete(Success As Boolean)
			
				If  Success Then
					wait for (CloudStorage.Exists("/BBs")) Complete(Exists As Boolean)
			
					Log(IIf(Exists, "Directory Exists or Created", "Does Not Exists"))				
				End If

				wait for (CloudStorage.CreateDirectory("/BBs/BBsViewer")) Complete(Success As Boolean)
			
				If  Success Then
					wait for (CloudStorage.Exists("/BBs/BBsViewer")) Complete(Exists As Boolean)
			
					Log(IIf(Exists, "Directory Exists or Created", "Does Not Exists"))				
				End If
	
    			Log("Listing folder... /BBs/BBsViewer - Recursive")
	
    			Wait For (CloudStorage.ListFiles("/BBs/BBsViewer", True)) Complete (xFiles As List)			
			
				xFiles.SortTypeCaseInsensitive("Name", True)
			
        		For Each f As cCloudStorage_ListItemType In xFiles
            		Log($"Name: ${f.Name}  IsDir: ${f.IsDirectory}  LastModified: ${f.LastModified}"$)
        		Next

    			Log("End Listing folder")
				
    			Log("Listing folder... /BBs/BBsViewer - NOT Recursive")
	
    			Wait For (CloudStorage.ListFiles("/BBs/BBsViewer", False)) Complete (xFiles As List)			
			
				xFiles.SortTypeCaseInsensitive("Name", True)
			
        		For Each f As cCloudStorage_ListItemType In xFiles
            		Log($"Name: ${f.Name}  IsDir: ${f.IsDirectory}  LastModified: ${f.LastModified}"$)
        		Next

    			Log("End Listing folder")

    			' --- Create folder ---
				wait for (CloudStorage.Exists("/TestFolder")) Complete(Exists As Boolean)	
	
				If  Exists = False Then
	    			Wait For (CloudStorage.CreateDirectory("/TestFolder")) Complete (Success As Boolean)

					If  Success Then
						wait for (CloudStorage.Exists("/TestFolder")) Complete(Exists As Boolean)
			
						Log(IIf(Exists, "Directory Exists", "Does Not Exists"))				
					End If		
				End If						
'
'    			' --- Upload file ---

'				Create Upload File
#if B4A 
				File.WriteString(File.DirInternal, "myfile.txt", "This myfile.txt for dropbox upload test")
#else if B4J
				File.WriteString(File.DirApp, "myfile.txt", "This myfile.txt for dropbox upload test")
#else if B4I
				File.WriteString(File.DirDocuments, "myfile.txt", "This myfile.txt for dropbox upload test")
#end if

#if B4A 
	    		Wait For (CloudStorage.UploadFile(File.DirInternal, "myfile.txt", "/TestFolder/myfile.txt")) Complete (xUploaded As Boolean)	
#else if B4J
    			Wait For (CloudStorage.UploadFile(File.DirApp, "myfile.txt", "/TestFolder/myfile.txt")) Complete (xUploaded As Boolean)	
#else if B4i	
    			Wait For (CloudStorage.UploadFile(File.DirDocuments, "myfile.txt", "/TestFolder/myfile.txt")) Complete (xUploaded As Boolean)
#end if
    			Log("Uploaded file? " & xUploaded)


				Log("List All Files")
			
	    		Wait For (CloudStorage.ListFiles("/TestFolder", False)) Complete (xFiles As List)
			
				xFiles.SortTypeCaseInsensitive("Name", True)
			
        		For Each f As cCloudStorage_ListItemType In xFiles
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
	    		Wait For (CloudStorage.DownloadFile("/TestFolder/myfile.txt", File.DirInternal, "myfile_copy.txt")) Complete (xDownloaded As Boolean)

    			Log($"Downloaded file? ${xDownloaded}"$)

				If  xDownloaded Then	
					Log($"File Contents:${File.ReadString(File.DirInternal, "myfile_copy.txt")}"$)

					File.Delete(File.DirInternal, "myfile_copy.txt")	
				End If
#else if B4J
    			Wait For (CloudStorage.DownloadFile("/TestFolder/myfile.txt", File.DirApp, "myfile_copy.txt")) Complete (xDownloaded As Boolean)

    			Log($"Downloaded file? ${xDownloaded}"$)

				If  xDownloaded Then	
					Log($"File Contents:${File.ReadString(File.DirApp, "myfile_copy.txt")}"$)

					File.Delete(File.DirApp, "myfile_copy.txt")	
				End If

				Dim DownloadStream As OutputStream
				
				DownloadStream.InitializeToBytesArray(0)

    			Wait For (CloudStorage.DownloadStream("/TestFolder/myfile.txt", DownloadStream)) Complete (xDownloaded As Boolean)

    			Log($"Downloaded file? ${xDownloaded}"$)

				If  xDownloaded Then	
					Dim b() 		As Byte 	= DownloadStream.ToBytesArray
					Dim TempMessage	As String 	= BytesToString(b, 0, b.Length, "UTF-8")
					
					Log($"Download Stream File: ${TempMessage}"$)
				End If
	
#else if B4i	
    			Wait For (CloudStorage.DownloadFile("/TestFolder/myfile.txt", File.DirDocuments, "myfile_copy.txt")) Complete (xDownloaded As Boolean)
	
				if  xDownloaded then
					Log($"File Contents:${File.ReadString(File.DirDocuments, "myfile_copy.txt")}"$)

					File.Delete(File.DirDocuments, "myfile_copy.txt")	
				end if
#end if
'
' 			   ' --- Delete file ---
    			Wait For (CloudStorage.DeleteFile("/TestFolder/myfile.txt")) Complete (xDeleted As Boolean)
        		Log("Deleted file? " & xDeleted)
'
' 			   ' --- Delete folder ---
    			Wait For (CloudStorage.DeleteFile("/TestFolder")) Complete (xFolderDeleted As Boolean)
	        	Log("Deleted folder? " & xFolderDeleted)
				
				Log($"Test for ${CloudStorage.WhatStorageAreWeUsing} Completed${CRLF}${CRLF}"$)
			Next
			
			Log("All Tests Completed")
		
			ExitApplication
End Sub

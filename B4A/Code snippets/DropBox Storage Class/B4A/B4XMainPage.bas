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
	
	Private Panel1 As Panel
End Sub

Public Sub Initialize
			LogColor($"${TAB}B4XMainPage::Initialize"$, Colors.Blue)	
End Sub



Private Sub B4XPage_Appear
			LogColor($"${TAB}B4XMainPage::B4XPage_Appear"$, Colors.Blue)
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
			LogColor($"${TAB}B4XMainPage::B4XPage_Created"$, Colors.Blue)			
	
			Root = Root1
			Root.LoadLayout("MainPage")
			
			CallSubDelayed(Me, "TestDropbox")
End Sub

Public  Sub B4XPage_CloseRequest As ResumableSub
			LogColor($"${TAB}B4XMainPage::B4XPage_CloseRequest"$, Colors.Blue)	
			
			Return True		
End Sub

Private Sub B4XPage_Disappear
			LogColor($"${TAB}B4XMainPage::B4XPage_Disappear"$, Colors.Blue)
End Sub

Private Sub B4XPage_Resize(Width As Int, Height As Int)
			LogColor($"${TAB}B4XMainPage::B4XPage_Resize(Width=${Width}, Height=${Height})"$, Colors.Blue)
End Sub


Sub TestDropbox

    Dim 	DropBox 								As cDropBox
	
	Dim		DropBoxAppKey 							As String  = "<your app key>"
	Dim 	DropBoxAppSecret 						As String  = "<your app secret>"
'	Dim		DropBoxToken							As String  = "<temp access token>"
'	Dim		DropBoxAuthCode							As String  = "<First time Authorization Code>"
	Dim		DropBoxRefresh							As String  = "<refresh code>"

		
    DropBox.Initialize("", DropBoxRefresh, DropBoxAppKey, DropBoxAppSecret)
	
	wait for(DropBox.EnsureAccessToken) Complete(Success As Boolean)
	
    ' --- List root folder ---
			wait for (DropBox.ResourceExists("/BBs")) Complete(Exists As Boolean)

			Log(IIf(Exists, "Directory Exists", "Does Not Exists"))
			
			If  Exists = False Then
				wait for (DropBox.CreateDirectory("/BBs")) Complete(Success As Boolean)
			
				If  Success Then
					wait for (DropBox.ResourceExists("/BBs")) Complete(Exists As Boolean)
			
					Log(IIf(Exists, "Directory Exists", "Does Not Exists"))				
				End If
			End If

			wait for (DropBox.ResourceExists("/BBs/BBsViewer")) Complete(Exists As Boolean)
			
			Log(IIf(Exists, "Directory Exists", "Does Not Exists"))

			If  Exists = False Then
				wait for (DropBox.CreateDirectory("/BBs/BBsViewer")) Complete(Success As Boolean)
			
				If  Success Then
					wait for (DropBox.ResourceExists("/BBs/BBsViewer")) Complete(Exists As Boolean)
			
					Log(IIf(Exists, "Directory Exists", "Does Not Exists"))				
				End If
			End If
	
	
    Log("Listing root folder...")
    Wait For (DropBox.ListFiles("/BBs/BBsViewer")) Complete (xFiles As List)
        For Each f As Map In xFiles
            Log("Name: " & f.Get("Name") & " | IsDir: " & f.Get("IsDir") & " | LastModified: " & f.Get("LastModified"))
        Next

    ' --- Create folder ---
    Wait For (DropBox.CreateDirectory("/TestFolder")) Complete (xCreated As Boolean)
    Log("Created /TestFolder? " & xCreated)
'
'    ' --- Upload file ---

'	Create Upload File
#if B4A 
	File.WriteString(File.DirInternal, "myfile.txt", "This myfile.txt for dropbox upload test")
#else if B4I
	File.WriteString(File.DirDocuments, "myfile.txt", "This myfile.txt for dropbox upload test")
#end if

#if B4A 
    Wait For (DropBox.UploadFile(File.DirInternal, "myfile.txt", "/TestFolder/myfile.txt")) Complete (xUploaded As Boolean)	
#else if B4i	
    Wait For (DropBox.UploadFile(File.DirDocuments, "myfile.txt", "/TestFolder/myfile.txt")) Complete (xUploaded As Boolean)
#end if
    Log("Uploaded file? " & xUploaded)
		
#if B4A 
	File.Delete(File.DirInternal, "myfile.txt")
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
#else if B4i	
    Wait For (DropBox.DownloadFile("/TestFolder/myfile.txt", File.DirDocuments, "myfile_copy.txt")) Complete (xDownloaded As Boolean)
	
	if  xDownloaded then
		Log($"File Contents:${File.ReadString(File.DirDocuments, "myfile_copy.txt")}"$)

		File.Delete(File.DirDocuments, "myfile_copy.txt")	
	end if
#end if
'
'    ' --- Delete file ---
    Wait For (DropBox.DeleteFile("/TestFolder/myfile.txt")) Complete (xDeleted As Boolean)
        Log("Deleted file? " & xDeleted)
'
'    ' --- Delete folder ---
    Wait For (DropBox.DeleteFile("/TestFolder")) Complete (xFolderDeleted As Boolean)
        Log("Deleted folder? " & xFolderDeleted)
		
	ExitApplication
End Sub

'Public  Sub TestDropBox
'	
'			Public		DropBoxAppKey 							As String  = "pco6yu9xhibxzzu"
'			Public 		DropBoxAppSecret 						As String  = "rpfladbl9h0sw36"
'			Public		DropBoxToken							As String  = "sl.u.AGD2i1ukzcX0Ntrw_rvyn4-fno0kzS1WWgSClNBw0wE4CPEWzNzkUCfUDLoTPAI3MwN9ZXFD8yXMLuWu2PGe4MB7idNrERTofah8_t1zzV-WRg2hXvByCHapf2O5anbmRRd9X1PHEQ8iA9F1HEmja-02_n3dY0o4gAO8_SVRe_fTG_kAkdJ_UOeC0ueQVGZ16TPbkkISXVU5hNajV9AbcS0M9PXiQKxNhGN1SC3loi7YmfWkbmln8fLBz16DcyvgRtfodXxT0Q29dq4NTqSmgHdTZIMVSGMZsCh6LSJSzmMaJw8LxAS0Z3kd5BF6vnie0Kf4HmRJwW_T9FfMYzGFDht-ZtLJwgF9cMjT7SgQ3lMBFgz62UIQi1oIOI8Kckm3TkIOr3G7qAZ1F16xKw61i6TmCQvAmZL-EbLBjf6Hhm6UCt8VAIUJNPil-U8mjPhE7qrYdVhdmSmHsxk0_nJJ2qh-mbSZL-w00pa1J4_VbjphlP_wBO0OQFG4IlWiLwVBCmY-uCzEiZAChR6TSZTxqw3TwUrE4KpzqRWUDjOYsyS1UXYMHRaQd6s6UtAHlLjr0fUym9y4kIP33TzryMGyBdzT_2qsgiiNAd73gG2XFfQT_BKfdxCdzWa3hKXS6LS_BVHtDDGZ4zlJDncn5nmbmYQu5BvgvfgRGXZG1-cgpqGgwSBlgEkNFJhKi0wDZnUEgvBjXumip8nRTd4E5OtdmAS7u0hm8I9fspndzGanQEjzUeF1wKXypmUv_siFQgJU6c17lsU80rNhVVXyWPAQn2FoBnEkVe1BOeKG3pNlNYPOUeATPlWZfzLCJzoHMl7sHLP03fPx_yEuDshFeppNwhhRe17uG4iAFlPwa9pKqasC4GbxRjMjl4KmKcVKnyqiOxjF_lAtv7-kAEPrvDZc2-HnX-vUQiHVDMyoQtcqhwc0vau97bnMGW3Lb35wfn2iEHeuoJQZemdElzPQn04539N1bq6halxRG60L6Ku8XTRxhJJioCgd1CtbzKsaPYTgN-3tzmha8ck34dJnKIIsnEGv9bZccWofKbErCHemdO7aJs7jmHpJGVq1sQ7yJNF6PYBj5-Aqpyh3b8iBsl2PyJVfTRqUvw1zxBhgM_wYwd6oyNLfV3YnxdadfdtrzZc-dSgmd-u4dukHq8MotQcjZrc009U1vekxAwWhiQ_hPceD2JRLPINy0S4ejA_2ZS0WYudOnZ_SwlqEyfxPS8LW9qjS2_XBcwU3rPJqr3MM4DAE_EL6erw6Dkt-Bj-scdduC-HFLRiLmE4bQMgIL5aRf39x"
'
'
'    Dim dbx As cDropBox   ' your class
'	
''    dbx.Initialize("YOUR_APP_KEY", "YOUR_APP_SECRET", "YOUR_ACCESS_TOKEN", "YOUR_REFRESH_TOKEN")
'	
'    dbx.Initialize(DropBoxAppKey, DropBoxAppSecret, DropBoxToken, "YOUR_REFRESH_TOKEN")
'    
'    ' 1. List root folder
'    Log("Listing root folder...")
'    Dim files As List = Wait For(dbx.ListFiles("/")) As List
'    For Each f As Map In files
'        Log("Name: " & f.Get("Name") & " | IsDir: " & f.Get("IsDir") & " | LastModified: " & f.Get("LastModified"))
'    Next
'    
'    ' 2. Create a test folder
'    Dim created As Boolean = Wait For(dbx.CreateDirectory("/TestFolder"))
'    Log("Created /TestFolder? " & created)
'    
'    ' 3. Upload a test file
'    Dim uploaded As Boolean = Wait For(dbx.UploadFile(File.DirRootExternal, "myfile.txt", "/TestFolder/myfile.txt"))
'    Log("Uploaded file? " & uploaded)
'    
'    ' 4. Download the test file
'    Dim downloaded As Boolean = Wait For(dbx.DownloadFile("/TestFolder/myfile.txt", File.DirRootExternal, "myfile_copy.txt"))
'    Log("Downloaded file? " & downloaded)
'    
'    ' 5. Delete the file
'    Dim deleted As Boolean = Wait For(dbx.DeleteFile("/TestFolder/myfile.txt"))
'    Log("Deleted file? " & deleted)
'    
'    ' 6. Delete folder
'    Dim folderDeleted As Boolean = Wait For(dbx.DeleteFile("/TestFolder"))
'    Log("Deleted folder? " & folderDeleted)
'
'
'
'
'
'
'
'
'
'
'
'
'
'
'
'
'
'
'
'
'
'
'
'
'
'
'
'
'
'
'
'
'
'
'
'
'
'
''			Public		DropBoxToken	As String  = <your drop box DropBoxToken>
'			
'			Dim DropBox As cDropBox
'			
'			DropBox.Initialize(DropBoxToken) ' your token here
'
'			' Upload
'			'Dim ok As Boolean = Dropbox.UploadFile(File.DirRootExternal, "test.txt", "/test.txt")
'			'Log(ok)
'
'			' Download
'			'ok = Dropbox.DownloadFile("/test.txt", File.DirRootExternal, "downloaded.txt")
'			'Log(ok)
'
'			' List files
'			wait for (DropBox.ListFiles("/BBs/BBsViewer")) Complete(files As List)
'			
''			Dim files As List = Dropbox.ListFiles("")
'			
'			For Each DBFileMap As Map In files
'	   			Log($"DBFile: ${DBFileMap.Get("Name")}  ${IIf(DBFileMap.Get("IsDir").As(Boolean), "Is Directory", DBFileMap.Get("LastModified"))}"$)
'			Next
'			
'			wait for (DropBox.ResourceExists("/BBs")) Complete(Exists As Boolean)
'			
'			Log(IIf(Exists, "Directory Exists", "Does Not Exists"))
'			
'			If  Exists = False Then
'				wait for (DropBox.CreateDirectory("/BBs")) Complete(Success As Boolean)
'			
'				If  Success Then
'					wait for (DropBox.ResourceExists("/BBs")) Complete(Exists As Boolean)
'			
'					Log(IIf(Exists, "Directory Exists", "Does Not Exists"))				
'				End If
'			End If
'
'			wait for (DropBox.ResourceExists("/BBs/BBsViewer")) Complete(Exists As Boolean)
'			
'			Log(IIf(Exists, "Directory Exists", "Does Not Exists"))
'
'			If  Exists = False Then
'				wait for (DropBox.CreateDirectory("/BBs/BBsViewer")) Complete(Success As Boolean)
'			
'				If  Success Then
'					wait for (DropBox.ResourceExists("/BBs/BBsViewer")) Complete(Exists As Boolean)
'			
'					Log(IIf(Exists, "Directory Exists", "Does Not Exists"))				
'				End If
'			End If
'
'			' Delete
'			'ok = Dropbox.DeleteFile("/test.txt")
'			'Log(ok)
'	
'			ExitApplication
'End Sub
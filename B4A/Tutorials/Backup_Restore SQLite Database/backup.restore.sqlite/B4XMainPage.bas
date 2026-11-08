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
	Private FileHandler1 As FileHandler
	Dim SQL1 As SQL
	Dim DBName As String="db.db"
	
	Dim Fname() As String = Array As String("db.db", "db.db-shm","db.db-wal")
'	Fname = Array As String("db.db", "db.db-shm","db.db-wal")

End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(Me,Application.LabelName)
	FileHandler1.Initialize
	
    If File.Exists(xui.DefaultFolder,DBName) = False Then
		File.Copy(File.DirAssets, DBName,xui.DefaultFolder,DBName)
	End If
	
End Sub



Private Sub backup_Button_Click
	SQL1Initialize
	
	
	'Log("ButtonAdd_Click")
	
'	ShowLoading
	


	DateTime.DateFormat=("dd-MM-yyyy")
	DateTime.TimeFormat=("HH-mm-ss")
	Dim strFilenameInGdrive As String =( DateTime.Date(DateTime.Now) & "__" &  DateTime.Time(DateTime.Now))  &  ".zip"
	SQL1.Close

	
	Dim zip As Archiver
	


	zip.AsyncZipFiles (xui.DefaultFolder,Fname,xui.DefaultFolder,strFilenameInGdrive,"zip")
	Wait For zip_ZipDone(CompletedWithoutError As Boolean, NbOfFiles As Int)
	
'	Log(CompletedWithoutError)
'	Log(NbOfFiles)
'	Log(strFilenameInGdrive)
	If CompletedWithoutError =False Then
		'HideLoading
		SQL1Initialize
		Return
	End If
	'
	#if B4A
	Wait For (FileHandler1.SaveAs(File.OpenInput(xui.DefaultFolder, strFilenameInGdrive), _
	 "application/zip", strFilenameInGdrive)) Complete (Success As Boolean)
	#else if B4i
	Wait For (FileHandler1.SaveAs(Me, B4XPages.GetNativeParent(Me).TopRightButtons.Get(0), txtField.Text)) Complete (Success As Boolean)
	#end if
	
	
	SQL1Initialize
	
	
	'LoadCLV1
'	HideLoading
	
	If Success Then
		ToastMessageShow("تمت اضافة نسخة احتياطية بنجاح",True)
	Else
		ToastMessageShow("لم تتم العملية حاول مرة أخرى",True)
	End If
	
End Sub

Private Sub restore_Button_Click
	Dim title As String="استعادة نسخة احتياطية"
	Dim Yes As String="نعم"
	Dim No As String="لا"
	Dim messages As String="هل تريد استعادة نسخة احتياطية لقاعدة البيانات ؟؟"
	
	Dim sf As Object = xui.Msgbox2Async(messages, title, Yes,No, "", Null)
	Wait For (sf) Msgbox_Result (Result As Int)
	If Result <> xui.DialogResponse_Positive Then
		Return
	End If

	SQL1.Close

'	ShowLoading
	
	

	Wait For (FileHandler1.Load) Complete (Result2 As LoadResult)
	
	HandleLoadResult(Result2)
End Sub

Private Sub HandleLoadResult(Result As LoadResult)
	If Result.Success Then
		Dim zip As Archiver
	
		
		For Each n As String In File.ListFiles(xui.DefaultFolder)
			If 	n.Contains(".zip") Then
				If File.Exists(xui.DefaultFolder,n) Then
					File.Delete(xui.DefaultFolder,n)
				End If
			End If
		Next
		
		Wait For (File.CopyAsync(Result.Dir,Result.FileName,xui.DefaultFolder,Result.RealName)) Complete (Success As Boolean)
		If Success =False Then
			SQL1Initialize
			ToastMessageShow(" لم تتم عملية الاستعادة",True)
			Return
		End If
		
		zip.AsyncUnZipFiles (xui.DefaultFolder,Result.RealName,xui.DefaultFolder,Fname,"UnZip")
		Wait For UnZip_UnZipDone(CompletedWithoutError As Boolean, NbOfFiles As Int)

		If CompletedWithoutError =False Then
		'	HideLoading
			SQL1Initialize
			ToastMessageShow(" لم تتم عملية الاستعادة",True)
			Return
		End If
		

		
		'HideLoading
		ToastMessageShow("تمت الاستعادة بنجاح",True)
	Else
		ToastMessageShow("لم تتم عملية الاستعادة",True)
		'HideLoading
	End If

	SQL1Initialize
End Sub

Private   Sub SQL1Initialize
	If SQL1.IsInitialized = False Then
		SQL1.Initialize(xui.DefaultFolder, DBName, False)
	End If
	
End Sub
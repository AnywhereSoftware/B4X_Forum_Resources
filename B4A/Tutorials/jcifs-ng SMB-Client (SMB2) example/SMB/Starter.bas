B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=9
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
	#ExcludeFromLibrary: True
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Public rp As RuntimePermissions
	Public smbClient As SMBClient
	Public glRes, github As SMBResource
	Public OP As String
End Sub

Sub Service_Create
	'This is the program entry point.
	'This is a good place to load resources that are not specific to a single activity.
End Sub
Sub Service_Start (StartingIntent As Intent)
	Service.StopAutomaticForeground 'Starter service can start in the foreground state in some edge cases.
End Sub

#Region SMB
Sub SMBInit(cred As SMBCred)
	smbClient.Initialize("SMBClient", cred.Domain, cred.Username, cred.Password, cred.Share)
End Sub

Sub SMBClient_CopyProgress(totalBytes As Long, path As String, filename As String)
	Log($"SMBClient_CopyProgress(${totalBytes} : ${path}:${filename})"$)
End Sub

Sub SMBClient_Resource(success As Boolean, smbobjres As Object, smbobj As Object, info As String)
	Log($"SMBClient_Resource(${success},${info},${smbobjres},${smbobj})"$)
	If smbobjres <> Null And smbobj <> Null And info = "OK" Then
		Dim smbResource As SMBResource = smbobjres
		glRes = smbResource
		
		Dim smbfile As SMBFile = smbobj

		Log($"SMBClient_Resource(${smbResource}, ${smbfile})"$)
		Log($"CanonicalPath = ${smbfile.CanonicalPath}"$)
		Log($"CanonicalUncPath = ${smbfile.CanonicalUncPath}"$)
		

		'Dim flist As List = smbfile.listFiles
		'Log($"ListFiles2(res,"*.tif")"$)
		'jcifs.listFiles2(smbfile,"*.tif")
		



		
	'	cmbClient.GetResourcefromUrl("smb://192.168.192.168/SMBTest/")
	'	wait for SMBClient_Resource(smbobjres2 As Object,smbobj2 As Object)
	'	Log("GithubShare found...")
	'	github = smbobjres2
	'	Dim SMBTestOrdner As SMBFile = smbobj2
	'	Log($"${SMBTestOrdner.CanonicalPath}"$)
	'	Log($"ListFiles2(res)"$)
		If OP = "Dir" Then
			smbClient.listFiles(smbResource)
		Else If OP = "CopyHere" Then
			CopyHERE(smbResource)
			Dim InputStream1 As InputStream = smbResource.openInputStream
		    Dim Bmp As Bitmap
		    Bmp.Initialize2(InputStream1)
		    InputStream1.Close
			smbResource.close
			CallSub2(actSMBFiles, "SetImg", Bmp)
		Else If OP = "CopyThere" Then
		    Dim Bmp As Bitmap
			CopyTHERE(smbfile)
			
			
		End If
	End If

	
End Sub

Sub CopyTHERE(ToFile As SMBFile)
	smbClient.Copy2(actSMBFiles.XUI.DefaultFolder, "Test.png", ToFile, "Test2.png")
	
End Sub

Sub CopyHERE(FromFile As Object)
	
	smbClient.Copy(FromFile, actSMBFiles.ToDir, actSMBFiles.ToFile)
	
End Sub

Sub SMBClient_ListFiles(filelist As List)
	Log($"SMBClient_ListFiles(${filelist})"$)
'	Dim koeln As SMBFile
'	Dim dn As SMBFile
'	Dim tocopy As SMBFile
	If filelist.IsInitialized And filelist.Size > 0 Then
		For i = 0 To filelist.Size-1
			Dim f As SMBFile = filelist.Get(i)
			Log($"FILE CanonicalPath = ${f.CanonicalPath} (${f.length})"$)
				Log(f.Name)
			'FILE CanonicalPath = smb://192.168.192.168/GeoTIFs/koeln/ (0)
			If i = 0 Then
				'Log($"Device->Share CanonicalPath = ${f.CanonicalPath} (f.length)"$)
				'jcifs.Copy2(File.DirRootExternal,"Gesamtvh.tif",glRes,"GesamtSMB.tif")
			End If
			'Log($"ContentEncoding = ${f.ContentEncoding}"$)

			'Log($"Length = ${f.length}"$)
			If f.CanonicalPath = "smb://192.168.192.168/GeoTIFs/dn/" Then
				Log("Resourcefolder DN found...")
'				dn = f
			End If
			

			If f.CanonicalPath = "smb://192.168.192.168/GeoTIFs/koeln/" Then
				Log("Resourcefolder KOELN found...")
'				koeln = f
				
				'Log("To be sure. It is deleted if already copied for Test")
				'If File.Exists(File.DirRootExternal,"Gesamtvh.tif") Then
				'	Log("Delete File")
				'	File.Delete(File.DirRootExternal,"Gesamtvh.tif")
				'	Log("File deleted")
				'End If
				'Log($"Copy file = Gesamtvh.tif"$)
				'jcifs.Copy(f,File.DirRootExternal,"Gesamtvh.tif")
'				Dim os As OutputStream = File.OpenOutput(File.DirInternal,"Gesamt.jpg",False)
'				Dim Ins As InputStream = f.InputStream
'				File.Copy2(Ins,os)
'				os.Close
			End If
			
			
		Next
		'Dim dest As SMBFile = smbClient.CreateSmbFile(koeln,"kopieX")
		'dn.copyTo(dest)

		CallSubDelayed2(actSMBFiles,"LoadFiles",filelist)
	End If

	'smbClient.CopyTo(dn,dest) ' dn und dst sind jeweils SmbFile

'	cmbClient.GetResourcefromUrl("file://192.168.192.168/$d/")
'	wait for SMBClient_Resource(smbobjres2 As Object,smbobj2 As Object)
'	Log("GithubShare found...")
'	github = smbobjres2
'	Dim SMBTestOrdner As SMBFile = smbobj2
'	Log($"${SMBTestOrdner.CanonicalPath}"$)
'	Log($"ListFiles2(res)"$)
	'smbClient.delete(dn)
End Sub
Sub SMBClient_CopyTo(success As Boolean)
	
End Sub
Sub SMBClient_CopyResult(success As Boolean, path As String, filename As String)
	Log($"SMBClient_CopyResult(${success})"$)
End Sub
#End Region

Sub Service_TaskRemoved
	'This event will be raised when the user removes the app from the recent apps list.
End Sub
'Return true to allow the OS default exceptions handler to handle the uncaught exception.
Sub Application_Error (Error As Exception, StackTrace As String) As Boolean
	Return True
End Sub

Sub Service_Destroy

End Sub

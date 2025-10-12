B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.4
@EndOfDesignText@
'===============================================================================================================================
'	I'm Robert Valentino - been on B4X for some time.  
'		Getting ready to turn 75 so if my code isn't up to young guys specs show me a better way and I will convert
'		SORRY to those that don't like code lined up.  I cannot look at code and understand it unless it is.
'			Think it is something to do with my old days of BAL
'
'	To use this class you must register with Koofr (they give 10 gig free storage or the storage you paid for)
'
'	Once you are registered with them do the following to get a App Password
'		1) At you Koofr website Click on your Icon in top right corner and select Preferences
'		2) Your Email Address will be there you are going to need that as your UserName
'		3) Click Password and this will show you where you can change your password AND create App Passwords
'		4) Type in a App name (whatever you want to call it) and Generate
'		5) Koofr will create a password for you and show it to you.  
'			NOTE: 	This is the only time you will have to SEE the password otherwise you wil have to recreate one
'			
'		Your Email and Password are need to be authorized to use these functions
'
'	The DEFAULT Path for everyone is 	"https:/app.koofr.net/dav/Koofr/"		
'
'	Enjoy
'===============================================================================================================================
Sub Class_Globals	
	Private Const  Version			As String	= "2.2"		'Ignore

	Type	cKoofr_ListItemType(Name As String, IsDirectory As Boolean, HRef As String, LastModified As Long)		
	
    Private BasicAuthorized 					As String 
	
	Private StringUtils							As StringUtils
	
	Private ListFileItems		 				As List
	
	Private Const DEFINE_Koofr_DefaulPath		As String = "https:/app.koofr.net/dav/Koofr"		
	
	Private mLastHTTPCode						As Int
	
End Sub

#Region Intialization
'===============================================================================================================================
'   Initialization 
'===============================================================================================================================
Public 	Sub Initialize
			BasicAuthorized = ""
End Sub
#end Region

#Region CreateDirectory
'===============================================================================================================================
'	CreateDirectory 
'		DirUrl 		- is the complete directory path
'
'		Returns		- Boolean True = Success
'===============================================================================================================================
Public  Sub CreateDirectory(DirUrl As String) As ResumableSub
			
			Dim Success 		As Boolean
			Dim DownloadName 	As String
			Dim j 				As HttpJob
			
			'------------------------------------------------------------------------------------------------
			'	Need to check if Directory Already Exists
			'------------------------------------------------------------------------------------------------
			DownloadName = $"${DEFINE_Koofr_DefaulPath}${DirUrl}"$
			
			If  DownloadName.EndsWith("/") = False Then
				DownloadName = DownloadName &"/"				
			End If
			
			wait for (Exists(DirUrl)) Complete(Result As Boolean)			
			
			If  Result Then
				Return Result
			End If
			
			j.Initialize("", Me)
			
'			Log($"cKoofr::CreateDirectory[${DownloadName}]"$)
						
			j.Download(DownloadName)
			
			#if B4i
			j.GetRequest.As(NativeObject).GetField("builder").RunMethod("method", Array("MKCOL", Null))
			#else
			j.GetRequest.As(JavaObject).GetFieldJO("builder").RunMethod("method", Array("MKCOL", Null))
			#end if
			
			j.GetRequest.SetHeader("Authorization", BasicAuthorized)
		
			Wait For (j) JobDone(j As HttpJob)
			
			Success   		= j.Success
    		mLastHTTPCode 	= j.Response.StatusCode
			
			j.Release		
			
    		Return Success
End Sub
#end Region

#Region DeleteFile
'===============================================================================================================================
'	DeleteFile - File or Directory (Directory MUST be Empty)
'		DirFileUrl	- is the complete file path
'
'		Returns		- Boolean True = Success
'===============================================================================================================================
Public  Sub DeleteFile(DirFileUrl As String) As ResumableSub
    		' DirUrl = full WebDAV path (file or folder)
    		' Returns 0 if success, -1 if failed
			
			Dim Success As Boolean
			
    		Dim j 		As HttpJob
			
    		j.Initialize("", Me)

    		j.Download($"${DEFINE_Koofr_DefaulPath}${DirFileUrl}"$)
			
			#if B4i
			j.GetRequest.As(NativeObject).GetField("builder").RunMethod("method", Array("DELETE", Null))			
			#else
			j.GetRequest.As(JavaObject).GetFieldJO("builder").RunMethod("method", Array("DELETE", Null))			
			#end if
			
			j.GetRequest.SetHeader("Authorization", BasicAuthorized)

    		Wait For (j) JobDone(j As HttpJob)
			
    		mLastHTTPCode 	= j.Response.StatusCode
			Success   		= j.Success
			
        	j.Release
        	
			Return Success
End Sub
#end Region

#Region DownloadFile
'===============================================================================================================================
'	DownloadFile - download a file
'		FileToDownload 	- Complete url to file to retrieve
'		LocalPath		- Path Where to save file
'		LocalFile		- FileName to be saved
'
'		Returns			- Boolean True = Success
'===============================================================================================================================
Public  Sub DownloadFile(xFileToDownload As String, xLocalPath As String, xLocalFile As String) As ResumableSub
	
'			Log($"Downloadfile:${xFileToDownload}  to LocalFile:${xLocalFile}"$)

			Dim Success As Boolean			
	
    		Dim job 	As HttpJob
			
    		job.Initialize("download", Me)
			
    		' remoteHref is the full WebDAV path, e.g. "https://app.koofr.net/dav/Koofr/MyFolder/myfile.txt"
			
    		job.Download($"${DEFINE_Koofr_DefaulPath}${xFileToDownload}"$)
    		job.GetRequest.SetHeader("Authorization", BasicAuthorized)
    		job.Tag = xLocalFile
	
			Wait For (job) JobDone(job As HttpJob)
			
			Success	  		= job.Success
			mLastHTTPCode 	= job.Response.StatusCode
	
    		If  job.Success Then
        		If 	job.JobName = "download" Then
            		Dim out As OutputStream = File.OpenOutput(xLocalPath, job.Tag, False)
					
            		File.Copy2(job.GetInputStream, out)
					
            		out.Close
					
            		Log("Downloaded to: " & File.Combine(xLocalPath, job.Tag))
        		End If
    		End If
	
    		job.Release
	
			Return Success
End Sub
#end region

'===============================================================================================================================
'	DownloadStream - download a file
'		FileToDownload 	- Complete url to file to retrieve
'		DownloadStream	- Output stream
'
'		Returns			- Boolean True = Success
'===============================================================================================================================
#Region DownloadStream
Public  Sub DownloadStream(xFileToDownload As String, xDownloadStream As OutputStream) As ResumableSub
	
			Log($"DownloadStream:${xFileToDownload}"$)

			Dim Success As Boolean			
	
    		Dim job 	As HttpJob
			
    		job.Initialize("downloadstream", Me)
			
    		' remoteHref is the full WebDAV path, e.g. "https://app.koofr.net/dav/Koofr/MyFolder/myfile.txt"
			
    		job.Download($"${DEFINE_Koofr_DefaulPath}${xFileToDownload}"$)
    		job.GetRequest.SetHeader("Authorization", BasicAuthorized)
'    		job.Tag = xLocalFile
	
			Wait For (job) JobDone(job As HttpJob)
			
			Success	  		= job.Success
			mLastHTTPCode 	= job.Response.StatusCode
	
    		If  job.Success Then
        		If 	job.JobName = "downloadstream" Then
					File.Copy2(job.GetInputStream, xDownloadStream)
        		End If
    		Else
        		Log($"Error: DownloadStream File:${xFileToDownload}  ${job.ErrorMessage}  ${mLastHTTPCode}"$)
    		End If
	
    		job.Release
	
			Return Success
End Sub
#end Region

#Region Exists
'===============================================================================================================================
'  Exists	(B4A / B4J)
'		Checks if a resource (directory or file) exists on server
'===============================================================================================================================
Public 	Sub Exists(xPath As String) As ResumableSub
    		Dim j As HttpJob
			
		    j.Initialize("", Me)
    
    		Dim fullUrl As String = $"${DEFINE_Koofr_DefaulPath}${xPath}"$
    
    		Dim xmlBody As String = "<?xml version=""1.0"" encoding=""utf-8""?>" & _
            	    	            "<D:propfind xmlns:D=""DAV:"">" & _
                	    	        "<D:prop><D:resourcetype/></D:prop></D:propfind>"
    
    		#if B4i
        	Dim mt As NativeObject
        	Dim rb As NativeObject
        	mt.Initialize("okhttp3.MediaType")
    		#else
        	Dim mt As JavaObject
        	Dim rb As JavaObject
        	mt.InitializeStatic("okhttp3.MediaType")
    		#end if
    
    		Dim xmlType As Object = mt.RunMethod("parse", Array("application/xml; charset=utf-8"))
    
    		#if B4i
        	rb.Initialize("okhttp3.RequestBody")
    		#else
        	rb.InitializeStatic("okhttp3.RequestBody")
    		#end if
    
    		Dim body As Object = rb.RunMethod("create", Array(xmlType, xmlBody.GetBytes("UTF8")))
    
    		j.Download(fullUrl)
			
    		#if B4i
        	j.GetRequest.As(NativeObject).GetField("builder").RunMethod("method", Array("PROPFIND", body))
    		#else
        	j.GetRequest.As(JavaObject).GetFieldJO("builder").RunMethod("method", Array("PROPFIND", body))
    		#end if
    
    		j.GetRequest.SetHeader("Authorization", BasicAuthorized)
    		j.GetRequest.SetHeader("Depth", "0")
    
    		Wait For (j) JobDone(j As HttpJob)
    
    		mLastHTTPCode = j.Response.StatusCode

    		Dim xExists As Boolean = False
    
    		If 	j.Success Then
        		xExists = True
    		Else 
        		Select 	j.Response.StatusCode
            			Case 	200, 207
								xExists = True
        		End Select
        	End If

    		j.Release
    
		    Return xExists
End Sub

#end Region

#Region GetLastCode
'===============================================================================================================================
'	GetLastCode - returns the last HTTP Code
'===============================================================================================================================
Public  Sub GetLastHTTPCode As Int
			Return mLastHTTPCode
End Sub
#end region

#region GetAuthorization
'===============================================================================================================================
'   GetAuthorization Code
'===============================================================================================================================
Public  Sub GetAuthorization As String
			Return BasicAuthorized
End Sub
#end Region

#Region ListFiles and All the sub routines needed
'===============================================================================================================================
'   ListFiles in a Folder
'===============================================================================================================================
Public 	Sub ListFiles(xFolderPath As String, xRecursive As Boolean)  As ResumableSub
    		Dim ListFileItems As List
			
    		ListFileItems.Initialize

    		Dim DirUrl As String = $"${DEFINE_Koofr_DefaulPath}${xFolderPath}"$

    		Dim j As HttpJob
    		j.Initialize("", Me)

    		Dim xmlBody As String = $"<?xml version="1.0" encoding="utf-8"?>
        							<D:propfind xmlns:D="DAV:"><D:allprop/></D:propfind>"$

    		#if B4i
			    j.PostString(DirUrl, xmlBody)

				Dim no As NativeObject = j.GetRequest
				
				no.GetField("object").RunMethod("setHTTPMethod:", Array("PROPFIND"))
    		#Else
        		Dim mt As JavaObject
			
        		mt.InitializeStatic("okhttp3.MediaType")
			
        		Dim xmlType As Object = mt.RunMethod("parse", Array("application/xml; charset=utf-8"))

        		Dim rb As JavaObject
			
        		rb.InitializeStatic("okhttp3.RequestBody")
			
        		Dim body As Object = rb.RunMethod("create", Array(xmlType, xmlBody.GetBytes("UTF8")))

        		j.Download(DirUrl)
				
        		j.GetRequest.As(JavaObject).GetFieldJO("builder").RunMethod("method", Array("PROPFIND", body))				
    		#End If

				
   			' Headers
		    j.GetRequest.SetHeader("Authorization", BasicAuthorized)
			
		    If 	xRecursive Then
        		j.GetRequest.SetHeader("Depth", "infinity")
    		Else 
        		j.GetRequest.SetHeader("Depth", "1")
    		End If

   			j.GetRequest.SetHeader("Content-Type", "application/xml; charset=utf-8")				


    		Wait For (j) JobDone(j As HttpJob)
		
    		mLastHTTPCode = j.Response.StatusCode			
			
	    	If 	j.Success = False Then
    	    	Log("HTTP error: " & j.ErrorMessage)
				
        		j.Release
				
        		Return ListFileItems
    		End If

    		Dim res As String = j.GetString
		
    		j.Release

			' Strip DAV: namespace for Xml2Map
			res = res.Replace("D:", "")
			res = res.Replace("d:", "")
			res = res.Replace("xmlns:D=""DAV:""", "")
			res = res.Replace("xmlns:d=""DAV:""", "")

    		' --- Parse XML with XML2Map ---
    		Dim parser As Xml2Map
		
    		parser.Initialize
		
    		Dim xm As Map

    		Try
        		xm = parser.Parse(res)
	    	Catch
    	    	Log("XML Parse error: " &LastException)
				
        		Return ListFileItems
	    	End Try

    		' --- Navigate tree ---
    		Dim ms As Map = xm.Get("multistatus")
		
    		If 	ms.IsInitialized = False Then 
				Return ListFileItems
			End If

	    	Dim responses 	As Object = ms.Get("response")
    		Dim respList 	As List
		
    		respList.Initialize
		
	    	If 	responses Is List Then
    	    	respList = responses
    		Else If responses Is Map Then
        			respList.Add(responses)
    		End If

	    	' --- Process responses ---
    		For Each resp As Map In respList
        		Dim href As String = resp.Get("href")
        		Dim propstat As Map = resp.Get("propstat")
			
	        	If 	propstat.IsInitialized = False Then 
					Continue
				End If
			
        		Dim prop As Map = propstat.Get("prop")
			
	        	If 	prop.IsInitialized = False Then 
					Continue
				End If

        		Dim name 			As String = prop.GetDefault("displayname", "")
	        	Dim lastmod 		As String = prop.GetDefault("getlastmodified", "")
    	    	Dim resourcetype 	As Object = prop.Get("resourcetype")

        		Dim isDir As Boolean = False
			
        		If 	resourcetype <> Null Then
            		If 	resourcetype Is Map Then
                	Dim rtMap As Map = resourcetype
						
	                	isDir = rtMap.ContainsKey("collection")
    	        	End If
        		End If
			
            	ListFileItems.Add(ListFiles_CreateItemType(name, href, isDir, IIf(lastmod <> "", ListFiles_Parse_HttpDate(lastmod), 0)))

	        	#If DebugX
    	        	Log($"Name=${LFI.Name}, Dir=${LFI.IsDir}, Href=${LFI.Href}, LastModified:${DateTime.Date(LFI.LastModified)} ${DateTime.Time(LFI.LastModified)}"$)
        		#End If
    		Next

    		Return ListFileItems
End Sub

Private Sub ListFiles_CreateItemType(xName As String, xHRef As String, xIsDirectory As Boolean, xLastModified As Long) As cKoofr_ListItemType
			Dim ListItemType As cKoofr_ListItemType
			
			ListItemType.Initialize
			ListItemType.Name			= xName
			ListItemType.HRef			= xHRef
			ListItemType.IsDirectory	= xIsDirectory
			ListItemType.LastModified	= xLastModified
			
			Return ListItemType
End Sub

Private Sub ListFiles_Parse_HttpDate(httpDate As String) As Long
    		Dim OldFormat As String = DateTime.DateFormat
			
    		DateTime.DateFormat = "EEE, dd MMM yyyy HH:mm:ss Z"
			
    		Dim DT As Long = DateTime.DateParse(httpDate)
			
    		DateTime.DateFormat = OldFormat
			
    		Return DT
End Sub
#end Region

#Region SetAuthorization
'===============================================================================================================================
'	SetAuthorization (UserName, PWd)
'
'	UserName 	(is your Email Address that you registered with
'	UserPWD		(is the Password you got from Koofr App Passwords
'===============================================================================================================================
Public 	Sub SetAuthorization(xUserName As String, xUserPWD As String)
    		BasicAuthorized = $"Basic ${StringUtils.EncodeBase64($"${xUserName}:${xUserPWD}"$.As(String).GetBytes("UTF8")}"$)	
End Sub

'===============================================================================================================================
'	SetAuthorizationCode (AuthorizedCode)
'
'	AuthorizedCode 	(you pass the formated authorization code)
'===============================================================================================================================
Public 	Sub SetAuthorizationCode(xAuthorizedCode As String)
			
    		BasicAuthorized = xAuthorizedCode
End Sub
#end Region

#Region UseKoofr
'===============================================================================================================================
'   Use_Koofr
'===============================================================================================================================
Public  Sub Use_Koofr As Boolean
			If  BasicAuthorized.Length > 0 Then
				Return True
			End If
	
			Return False
End Sub
#end Region

#Region UploadFile
'===============================================================================================================================
'   UploadFile 
'===============================================================================================================================
Public	Sub UploadFile(xLocalPath As String, xLocalFile As String, xFileToUpload As String) As ResumableSub
    
'    		Log($"UploadFile: ${File.Combine(xLocalPath, xLocalFile)} to RemoteFile: ${xFileToUpload}"$)

    		Dim Success As Boolean
    
    		Dim job As HttpJob
    
    		job.Initialize("upload", Me)
    
    		' Read the file into a byte array
    		Dim fileBytes() As Byte = File.ReadBytes(xLocalPath, xLocalFile)
    
    		' Set the request method to PUT and post the byte array
    		job.PutBytes($"${DEFINE_Koofr_DefaulPath}${xFileToUpload}"$, fileBytes)

			'------------------------------------------------------------------------------------------
			'			Could not get PostFile to work, kept getting Not Found and I am not sure 
			'				What was Not Found
			'
			'			job.PostFile(xFileToUpload, xLocalPath, xLocalFile)
			'------------------------------------------------------------------------------------------

		    job.GetRequest.SetHeader("Content-Type", UploadFile_GetMimeType(xLocalFile))
			
		    ' Set the Authorization header
    		job.GetRequest.SetHeader("Authorization", BasicAuthorized)
			job.GetRequest.Timeout = 60000 ' 60 seconds    
			
    		Wait For (job) JobDone(job As HttpJob)
    
    		Success 		= job.Success
    		mLastHTTPCode 	= job.Response.StatusCode
    
    		job.Release
    
    		Return Success
End Sub

'===============================================================================================================================
'	UploadFile_GetMimeType - From passed file name
'		FileName	- A file name with extension
'
'		Returns		- the mime type if possible
'===============================================================================================================================
Private Sub UploadFile_GetMimeType(xLocalFile As String) As String
    		Dim ext As String = ""
    		Dim i As Int = xLocalFile.LastIndexOf(".")
			
    		If 	i > -1 Then 
				ext = xLocalFile.SubString(i + 1).ToLowerCase
			End If

    		#If B4A
        	Dim jo As JavaObject
			
        	jo.InitializeStatic("android.webkit.MimeTypeMap")
			
        	Dim singleton 	As JavaObject 	= jo.RunMethod("getSingleton", Null)
        	Dim mime 		As String 		= singleton.RunMethod("getMimeTypeFromExtension", Array(ext))
			
        	If 	mime = Null Then 
				mime = "application/octet-stream"
			End If
			
        	Return mime
    		#Else
        	' --- B4i / iOS version ---
        	Dim mime As String
			
        	Select ext
            	Case "txt"				: mime = "text/plain"
            	Case "html", "htm"		: mime = "text/html"
            	Case "jpg", "jpeg"		: mime = "image/jpeg"
            	Case "png"				: mime = "image/png"
            	Case "gif"				: mime = "image/gif"
            	Case "pdf"				: mime = "application/pdf"
            	Case "zip"				: mime = "application/zip"
            	Case "json"				: mime = "application/json"
            	Case "xml"				: mime = "application/xml"
				
            	Case Else				: mime = "application/octet-stream"
        	End Select
			
        	Return mime
	    #End If
End Sub
#end Region

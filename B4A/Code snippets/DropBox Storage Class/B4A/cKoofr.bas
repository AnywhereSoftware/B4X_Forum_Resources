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
	Private Const  Version			As String	= "1.1"		'Ignore
		
	Type cKoofrDownloadTracker(CurrentLength As Long, TotalLength As Long, Completed As Boolean, Cancel As Boolean)
	
    Private BasicAuthorized 					As String 
	
	Private StringUtils							As StringUtils
	
	Private ListFileItems		 				As List
	
	Private Const DEFINE_Koofr_DefaulPath		As String = "https:/app.koofr.net/dav/Koofr/"		
	
	Private mLastHTTPCode						As Int
	
	Private mDownloadCallBack					As Object	'Ignore
	Private mDownloadCallBackRoutine			As String	'Ignore
	
End Sub

'----------------------------------------------------------------------------------
'	Need to Pass the UserName 	(is your Email Address that you registered with
'					 UserPWD	(is the Password you got from Koofr App Passwords
'----------------------------------------------------------------------------------
Public 	Sub Initialize
			BasicAuthorized = ""
End Sub

#Region CreateCopy
'---------------------------------------------------------------------------------------
'	CreateCopy of List
'		ListToCopy	- A list to copy
'
'		Returns		- A new copy of the list
'---------------------------------------------------------------------------------------
Private Sub CreateCopy(xListToCopy As List) As List
			Dim NewList As List
			
			NewList.Initialize
			NewList.AddAll(xListToCopy)
			
			Return NewList
End Sub
#end region

#Region CreateDirectory
'-----------------------------------------------------------------------------------------------------------
'	CreateDirectory 
'		DirUrl 		- is the complete directory path
'
'		Returns		- Boolean True = Success
'-----------------------------------------------------------------------------------------------------------
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
			
			wait for (ResourceExists(DirUrl, "")) Complete(Result As Map)
			
			If 	Result.Get("Exists") Then
    			If 	Result.Get("IsDir") Then
        			Log("It's a directory.")
    			Else
        			Log("It's a file.")
    			End If
	
				Success   		= True
				mLastHTTPCode 	= Result.Get("RC")
				
				Return Success	
			End If
						
			j.Initialize("", Me)
			
			Log($"cKoofr::CreateDirectory[${DownloadName}]"$)
						
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
			
    		Log($"CreateDirectory RC: ${mLastHTTPCode} ${cHttpCodes.GetHttpDescription(mLastHTTPCode)}"$)
						
			If 	j.Success Then
			    Log(j.GetString)
			Else
    			Log(j.ErrorMessage)
			End If
			
			j.Release		
			
    		Return Success
End Sub
#end Region

#Region CreateTracker
Public  Sub CreateTracker As cKoofrDownloadTracker
			Dim Tracker As cKoofrDownloadTracker
			
			Tracker.Initialize
			
			Return Tracker
End Sub
#end Region

#Region GetCaseInsensitiveHeaderValue
Private Sub GetCaseInsensitiveHeaderValue(job As HttpJob, Key As String, DefaultValue As String) As String  'Ignore
			Dim headers As Map = job.Response.GetHeaders
			
			For Each k As String In headers.Keys
				If 	K.EqualsIgnoreCase(Key) Then
					Return headers.Get(k).As(String).Replace("[", "").Replace("]", "").Trim
				End If
			Next
			
			Return DefaultValue
End Sub
#end Region

#region GetAuthorization
Public  Sub GetAuthorization As String
			Return BasicAuthorized
End Sub
#end Region

#Region DeleteItem
'-----------------------------------------------------------------------------------------------------------
'	DeleteItem - File or Directory (Directory MUST be Empty)
'		DirFileUrl	- is the complete file path
'
'		Returns		- Boolean True = Success
'-----------------------------------------------------------------------------------------------------------
Public  Sub DeleteItem(DirFileUrl As String) As ResumableSub
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
			
    		Log("DeleteItem HTTP RC: " &mLastHTTPCode)
			
    		If 	j.Success Then
        		Log("Deleted OK: " & DirFileUrl)
    		Else
        		Log("Delete failed: " & DirFileUrl & " | " & j.ErrorMessage)
			End If
			
        	j.Release
        	
			Return Success
End Sub
#end Region

#Region DownloadFile
'-----------------------------------------------------------------------------------------------------------
'	DownloadFile - download a file
'		FileToDownload 	- Complete url to file to retrieve
'		LocalPath		- Path Where to save file
'		LocalFile		- FileName to be saved
'
'		Returns			- Boolean True = Success
'-----------------------------------------------------------------------------------------------------------
Public  Sub DownloadFile(xFileToDownload As String, xLocalPath As String, xLocalFile As String) As ResumableSub
	
			Log($"Downloadfile:${xFileToDownload}  to LocalFile:${xLocalFile}"$)

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
    		Else
'        		Log($"Error:${job.ErrorMessage}  ${mLastHTTPCode}"$)
        		Log($"Error: DownloadFile:${xFileToDownload} ${job.ErrorMessage}  ${mLastHTTPCode}"$)				
    		End If
	
    		job.Release
	
			Return Success
End Sub

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

#Region DownloadLargeFile
#if _LARGEFILE_
Public  Sub DownloadLargeFile(xFileToDownload As String, xLocalPath As String, xLocalFile As String, xCallBack As Object, xRoutine As String) As ResumableSub
		
    		Dim Tracker As DownloadTracker
	
			mDownloadCallBack 			= xCallBack
			mDownloadCallBackRoutine 	= xRoutine
	
			Log($"Downloadfile:${xFileToDownload}  to LocalFile:${xLocalFile}"$)

    		Tracker = CreateTracker
			
    		TrackDownload_Progress(Tracker)
			
			Dim JobHead As HttpJob
			
			JobHead.Initialize("", Me)
			JobHead.Head($"${Koofr_DefaulPath}${xFileToDownload}"$)
			JobHead.GetRequest.SetHeader("Authorization", BasicAuthorized)
			
    		JobHead.Tag = xLocalFile

			Wait For (JobHead) JobDone (head As HttpJob)
			
			mLastHTTPCode = JobHead.Response.StatusCode
			
			Log("DownloadLargeFile Status: " & cHttpCodes.GetHttpDescription(mLastHTTPCode))			
			
			JobHead.Release 'the actual content is not needed
			
			If 	JobHead.Success Then
				Tracker.TotalLength = JobHead.Response.ContentLength
				
				If 	Tracker.TotalLength = 0 Then 
					Tracker.TotalLength = GetCaseInsensitiveHeaderValue(head, "content-length", "0")
				End If
				
'				Log(JobHead.Response.GetHeaders.As(JSON).ToString)

				If  GetCaseInsensitiveHeaderValue(JobHead, "Accept-Ranges", "").As(String) <> "bytes" Then
					Log("accept ranges not supported")
					Tracker.Completed = True
					Return False
				End If
			Else
				Tracker.Completed = True
				Return False
			End If
			
			Log("Total length: " & NumberFormat(Tracker.TotalLength, 0, 0))
			
			If 	File.Exists(xLocalPath, xLocalFile) Then
				Tracker.CurrentLength = File.Size(xLocalPath, xLocalFile)
			End If
			
			Dim out As OutputStream = File.OpenOutput(xLocalPath, xLocalFile, True) 'append = true
			
			Do 	While Tracker.CurrentLength < Tracker.TotalLength
				Dim DownloadFileJob As HttpJob
				
				DownloadFileJob.Initialize("", Me)
				DownloadFileJob.Download($"${Koofr_DefaulPath}${xFileToDownload}"$)
				
				Dim range As String = $"bytes=${Tracker.CurrentLength}-${(Min(Tracker.TotalLength, Tracker.CurrentLength + 300 * 1024) - 1).As(Int)}"$
				Log(range)

				DownloadFileJob.GetRequest.SetHeader("Authorization", BasicAuthorized)								
				DownloadFileJob.GetRequest.SetHeader("Range", range)
				
				Wait For (DownloadFileJob) JobDone (DownloadFileJob As HttpJob)
				
				Dim good As Boolean = DownloadFileJob.Success
					
				mLastHTTPCode = DownloadFileJob.Response.StatusCode

				Log($"DownloadLargeFile Status: ${mLastHTTPCode} ${cHttpCodes.GetHttpDescription(mLastHTTPCode)}"$)			
				
				If  DownloadFileJob.Success Then
					Wait For (File.Copy2Async(DownloadFileJob.GetInputStream, out)) Complete (Success As Boolean)
				#if B4A or B4J
					out.Flush
				#end if
				
					good = good And Success
					
					If Success Then
						Tracker.CurrentLength = File.Size(xLocalPath, xLocalFile)
					End If
				End If
				
				DownloadFileJob.Release
				
				If 	good = False Or Tracker.Cancel = True Then
					Tracker.Completed = True
					Return False
				End If
			Loop
			
			Log($"DownloadLargeFile Status: ${mLastHTTPCode} ${cHttpCodes.GetHttpDescription(mLastHTTPCode)}"$)			
			
			out.Close
			Tracker.Completed = True
			Return True
End Sub

Private Sub TrackDownload_Progress(Tracker As DownloadTracker)
			Dim LastCurrent As Long = 0
			Dim LastTotal	As Long = 0
			
    		Do 	While Tracker.Completed = False
				If  LastCurrent <> Tracker.CurrentLength Or LastTotal <> Tracker.TotalLength Then
					LogColor($"TrackDownload_Progress - Count:$1.2{((Tracker.CurrentLength / 1024) / 1024)} of Download Count:$1.2{((Tracker.TotalLength / 1024) / 1024)}"$, 	Colors.Red)				
				
					LastCurrent = Tracker.CurrentLength
					LastTotal	= Tracker.TotalLength
					
					If  mDownloadCallBack <> Null And mDownloadCallBackRoutine.Length <> 0 Then
						#if B4i
						If  SubExists(mDownloadCallBack, mDownloadCallBackRoutine, 1)  Then
						#else
						If  SubExists(mDownloadCallBack, mDownloadCallBackRoutine)  Then
						#end if
							CallSubDelayed2(mDownloadCallBack, mDownloadCallBackRoutine, $"${NumberFormat2(((Tracker.CurrentLength / 1024) / 1024), 1, 1, 1, True)} of ${NumberFormat2(Tracker.TotalLength, 1, 0, 0, True)}"$)
						End If
					End If
				End If
				
     			Sleep(100)				
    		Loop
End Sub
#end if
#end Region
#end region


#Region ResourceExists
' Check if a file exists on Koofr WebDAV
' Check if a resource exists, and return type (file or folder)
Public 	Sub ResourceExists(xPrimaryPath As String, xFile As String) As ResumableSub
    		Dim j As HttpJob
			
		    j.Initialize("", Me)
    
    		Dim fullUrl As String = $"${DEFINE_Koofr_DefaulPath}${xPrimaryPath}/${xFile}"$
    
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
    
    		Dim result As Map
			
    		result.Initialize
    		result.Put("Exists", 	False)
    		result.Put("IsDir", 	False)
			
			result.Put("RC", 		j.Response.StatusCode)
    
    		If 	j.Success Then
				
        		Select 	j.Response.StatusCode
            			Case 	200, 207
                				result.Put("Exists", True)
                
                				' crude parse (small response, OK to use simple text check)
                				Dim s As String = j.GetString
								
                				If 	s.ToLowerCase.Contains("<d:collection") Then
                    				result.Put("IsDir", True)
                				End If
                
			            Case 	404
                				result.Put("Exists", False)
        		End Select
    		Else
        		Log("ResourceExists error: " & j.ErrorMessage)
    		End If
    
    		j.Release
			
    		Return result
End Sub

#end Region


#Region GetLastCode
'-----------------------------------------------------------------------------------------------------------
'	GetLastCode - returns the last HTTP Code
'-----------------------------------------------------------------------------------------------------------
Public  Sub GetLastHTTPCode As Int
			Return mLastHTTPCode
End Sub
#end region

#Region GetMimeType
'------------------------------------------------------------------------------
'	GetMimeType - From passed file name
'		FileName	- A file name with extension
'
'		Returns		- the mime type if possible
'------------------------------------------------------------------------------
Private Sub GetMimeType(xLocalFile As String) As String
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

#Region ListFiles and All the sub routines needed
'-----------------------------------------------------------------------------------------------------------
'	ListFiles - list the files in a directory
'		PrimaryPath 	- complete url for where all the files live
'		SearchFor		- directory to add on to PrimaryPath
'		DirectoriesOnly	- True if you just want the directories and not all the other files
'		FilesOnly		- True if you just want the files that are not directories
'
'		Returns	List of files found
'-----------------------------------------------------------------------------------------------------------
Public 	Sub ListFiles(xPrimaryPath As String, xSearchFor As String, xDirectoriesOnly As Boolean, xFilesOnly As Boolean) As ResumableSub
    		Dim ListFileItems As List
			
    		ListFileItems.Initialize

    		' --- Build full URL ---
    		Dim BaseUrl As String = ""
			
    		If 	xSearchFor.Length > 0 Then 
				BaseUrl = $"${xSearchFor}/"$
			End If
			

    		Dim DirUrl As String = $"${DEFINE_Koofr_DefaulPath}${xPrimaryPath}${BaseUrl}"$

			Log($"DirURL:${DirUrl}"$)
			
    		' --- Send PROPFIND request ---
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
   			j.GetRequest.SetHeader("Depth", "1")
   			j.GetRequest.SetHeader("Content-Type", "application/xml; charset=utf-8")				


    		Wait For (j) JobDone(j As HttpJob)
		
    		mLastHTTPCode = j.Response.StatusCode			
			
	    	If 	j.Success = False Then
    	    	Log("HTTP error: " & j.ErrorMessage)
				
        		j.Release
				
        		Return CreateCopy(ListFileItems)
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
				
        		Return CreateCopy(ListFileItems)
	    	End Try

    		' --- Navigate tree ---
    		Dim ms As Map = xm.Get("multistatus")
		
    		If 	ms.IsInitialized = False Then 
				Return CreateCopy(ListFileItems)
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
			
        		Dim LFI 			As Map = CreateMap("Name": name, "HRef" : href, "IsDir" : isDir, "LastModified" : IIf(lastmod <> "", Koofr_Parse_HttpDate(lastmod), 0))
				

	        	' --- Apply filters ---
    	    	If 	(xDirectoriesOnly And isDir)	 					Or _
        	   		(xFilesOnly And isDir = False) 						Or _
           			(xDirectoriesOnly = False And xFilesOnly = False) 	Then
            		' Skip the search folder itself
	            	If 	xSearchFor.Length = 0 Or href.EndsWith(xSearchFor & "/") = False Then
    	            	ListFileItems.Add(LFI)
        	    	End If
        		End If

	        	#If DebugX
    	        	Log($"Name=${LFI.Name}, Dir=${LFI.IsDir}, Href=${LFI.Href}, LastModified:${DateTime.Date(LFI.LastModified)} ${DateTime.Time(LFI.LastModified)}"$)
        		#End If
    		Next

    		Return CreateCopy(ListFileItems)
End Sub

Private Sub Koofr_Parse_HttpDate(httpDate As String) As Long
    		Dim OldFormat As String = DateTime.DateFormat
			
    		DateTime.DateFormat = "EEE, dd MMM yyyy HH:mm:ss Z"
			
    		Dim DT As Long = DateTime.DateParse(httpDate)
			
    		DateTime.DateFormat = OldFormat
			
    		Return DT
End Sub
#end Region

#Region SetAuthorization
'----------------------------------------------------------------------------------
'	SetAuthorization (UserName, PWd)
'
'	UserName 	(is your Email Address that you registered with
'	UserPWD		(is the Password you got from Koofr App Passwords
'----------------------------------------------------------------------------------
Public 	Sub SetAuthorization(xUserName As String, xUserPWD As String)
    		BasicAuthorized = $"Basic ${StringUtils.EncodeBase64($"${xUserName}:${xUserPWD}"$.As(String).GetBytes("UTF8")}"$)	
End Sub

'----------------------------------------------------------------------------------
'	SetAuthorizationCode (AuthorizedCode)
'
'	AuthorizedCode 	(you pass the formated authorization code)
'----------------------------------------------------------------------------------
Public 	Sub SetAuthorizationCode(xAuthorizedCode As String)
			
    		BasicAuthorized = xAuthorizedCode
End Sub
#end Region

#Region UseKoofr
Public  Sub UseKoofr As Boolean
			If  BasicAuthorized.Length > 0 Then
				Return True
			End If
	
			Return False
End Sub
#end Region

#Region UploadFile
Public	Sub UploadFile(xLocalPath As String, xLocalFile As String, xFileToUpload As String) As ResumableSub
    
    		Log($"UploadFile: ${File.Combine(xLocalPath, xLocalFile)} to RemoteFile: ${xFileToUpload}"$)

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

		    job.GetRequest.SetHeader("Content-Type", GetMimeType(xLocalFile))
			
		    ' Set the Authorization header
    		job.GetRequest.SetHeader("Authorization", BasicAuthorized)
			job.GetRequest.Timeout = 60000 ' 60 seconds    
			
    		Wait For (job) JobDone(job As HttpJob)
    
    		Success 		= job.Success
    		mLastHTTPCode 	= job.Response.StatusCode
    
    		If 	job.Success Then
        		Log("Uploaded successfully: " &xFileToUpload)
    		Else
        		Log("Error: " &job.ErrorMessage)
        		Log("Status Code: " &job.Response.StatusCode)
    		End If
    
    		job.Release
    
    		Return Success
End Sub
#end Region

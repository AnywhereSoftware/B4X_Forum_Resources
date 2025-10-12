B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.4
@EndOfDesignText@
'===============================================================================================================================
'   Robert Valentino - B4X Dropbox Storage Class with Auto Token Refresh
'   Version 2.0
'
'	To get a new authorization code:  https://www.dropbox.com/oauth2/authorize?client_id=APP_KEY&response_type=code&token_access_type=offline
'===============================================================================================================================

Sub Class_Globals
    Private Const Version                    				As String = "2.2"        'Ignore

	Type	cDropBox_ListItemType(Name As String, IsDirectory As Boolean, HRef As String, LastModified As Long)
	
    Private Const DEFINE_DropBox_Default_WebSite			As String = "https://api.dropboxapi.com"	
    Private Const DEFINE_DropBox_Default_Path  				As String = $"${DEFINE_DropBox_Default_WebSite}/2"$
    Private Const DEFINE_DropBox_Default_PathFiles			As String = $"${DEFINE_DropBox_Default_Path}/files"$

    Private Const DEFINE_DropBox_Default_Content_PathFiles	As String = $"https://content.dropboxapi.com/2/files"$
	

	Private Const DEFINE_DropBox_Token_FN	 				As String = "dropbox_token.txt"
    Private mLastHTTPCode                    				As Int    
    Private RefreshToken                     				As String
    Private AppKey                           				As String
    Private AppSecret                        				As String
	Private AccessToken										As String
End Sub

#Region Intialization
'===============================================================================================================================
'   Initialization 
'===============================================================================================================================
Public  Sub Initialize
End Sub
#end region

#Region CreateDirectory
'===============================================================================================================================
'   CreateDirectory
'===============================================================================================================================
Public 	Sub CreateDirectory(xFolderPath As String) As ResumableSub
    		Wait For (EnsureAccessToken) Complete (Success As Boolean)
			
    		If 	Success = False Then 
				Return False
			End If
    
			wait for (Exists(xFolderPath)) Complete(DoesExist As Boolean)
	
			If  DoesExist Then
				Return DoesExist
			End If	
	
    		Dim j As HttpJob
    		j.Initialize("CreateDirectory", Me)
    
    		Dim xUrl As String = $"${DEFINE_DropBox_Default_PathFiles}/create_folder_v2"$
    
    		If 	Not(xFolderPath.StartsWith("/")) Then
        		xFolderPath = "/" & xFolderPath
    		End If
    
    		Dim xBody As String = "{""path"": """ & xFolderPath & """,""autorename"": false}"
    
    		j.PostString(xUrl, xBody)
    		j.GetRequest.SetHeader("Authorization", "Bearer " & AccessToken)
    		j.GetRequest.SetContentType("application/json")
    
    		Wait For (j) JobDone(j As HttpJob)
    
    		mLastHTTPCode = j.Response.StatusCode
    
    		If 	j.Success Then
        		Log("Folder created: " & xFolderPath)				
    		Else If j.ErrorMessage.ToLowerCase.Contains("conflict/folder") Then
            		Log("Folder already exists: " & xFolderPath)
        	Else
            	Log("CreateDirectory Error: " & j.ErrorMessage)
        	End If
    
		    Return j.Success
End Sub
#end Region

#Region DeleteFile
'===============================================================================================================================
'	DeleteFile - File or Directory (Directory MUST be Empty)
'		DirFileUrl	- is the complete file path
'
'		Returns		- Boolean True = Success
'===============================================================================================================================
Public  Sub DeleteFile(xRemotePath As String) As ResumableSub
    		Wait For (EnsureAccessToken) Complete (Success As Boolean)
			
    		If  Success = False Then 
				Return False
			End If
    
    		Dim j As HttpJob
			
    		j.Initialize("Delete",  Me)
    
    		Dim xUrl As String = $"${DEFINE_DropBox_Default_PathFiles}/delete_v2"$
    		Dim xBody As String = "{""path"": """ & xRemotePath & """}"

			
    		j.PostString(xUrl, xBody)
    
    		j.GetRequest.SetHeader("Authorization", "Bearer " & AccessToken)
    		j.GetRequest.SetContentType("application/json")
    
    
    		Wait For (j) JobDone(j As HttpJob)
    
    		mLastHTTPCode = j.Response.StatusCode
    
			Dim WasDeleted As Boolean = False
			
    		If 	j.Success Then
        		WasDeleted = True
			else if j.Response.StatusCode = 409 Then
				WasDeleted = True
			Else
				Log("DeleteFile Error: " & j.ErrorMessage)
			End If			
			
			j.Release
				        
    	    Return WasDeleted
End Sub
#end Region

#Region DownloadFile
'===============================================================================================================================
'   DownloadFile
'===============================================================================================================================
Public 	Sub DownloadFile(xRemotePath As String, xLocalPath As String, xLocalFile As String) As ResumableSub
		    Wait For (EnsureAccessToken) Complete (Success As Boolean)
			
    		If  Success = False Then 
				Return False
			End If
    
    		Dim j As HttpJob
    		j.Initialize("Download",  Me)
    
    		Dim xUrl As String = $"${DEFINE_DropBox_Default_Content_PathFiles}/download"$

    		j.Download(xUrl)    
    		j.GetRequest.SetHeader("Authorization", "Bearer " & AccessToken)
    		j.GetRequest.SetHeader("Dropbox-API-Arg", "{""path"": """ & xRemotePath & """}")
    
    
    		Wait For (j) JobDone(j As HttpJob)
    
    		mLastHTTPCode = j.Response.StatusCode
    
    		If  j.Success Then
        		File.WriteBytes(xLocalPath, xLocalFile, j.GetString.GetBytes("UTF8"))
        		Return True
    		End If
			
        	Log("Download Error: " & j.ErrorMessage)
        	Return False
End Sub
#end Region

#Region DownloadStream
'===============================================================================================================================
'   DownloadFile
'===============================================================================================================================
Public 	Sub DownloadStream(xRemotePath As String, xDownloadStream As OutputStream) As ResumableSub
		    Wait For (EnsureAccessToken) Complete (Success As Boolean)
			
    		If  Success = False Then 
				Return False
			End If
    
    		Dim j As HttpJob
    		j.Initialize("Download",  Me)
    
    		Dim xUrl As String = $"${DEFINE_DropBox_Default_Content_PathFiles}/download"$

    		j.Download(xUrl)    
    		j.GetRequest.SetHeader("Authorization", "Bearer " & AccessToken)
    		j.GetRequest.SetHeader("Dropbox-API-Arg", "{""path"": """ & xRemotePath & """}")
    
    
    		Wait For (j) JobDone(j As HttpJob)
    
    		mLastHTTPCode = j.Response.StatusCode
    
    		If  j.Success Then
				File.Copy2(j.GetInputStream, xDownloadStream)				
        		Return True
    		End If
			
        	Log("Download Error: " & j.ErrorMessage)
        	Return False
End Sub
#end Region

#Region EnsureAccessToken
'===============================================================================================================================
'   Ensure Access Token is valid if not get a new one
'===============================================================================================================================
Private	Sub EnsureAccessToken() As ResumableSub
	
			Dim url As String = $"${DEFINE_DropBox_Default_Path}/users/get_current_account"$
			Dim j 	As HttpJob
			
			j.Initialize("CheckToken", Me)

			j.PostString(url, "null")  ' DropBox requires an empty JSON object

			j.GetRequest.SetHeader("Authorization", "Bearer " & AccessToken)
			j.GetRequest.SetContentType("application/json")

    
    		Wait For (j) JobDone(j As HttpJob)
    
    		mLastHTTPCode = j.Response.StatusCode
    
    		If 	j.Success Then
        		j.Release
				
        		Return True
    		End If
			
        	' Token expired or invalid, try refresh
        	j.Release
			
			
        	Dim xNewToken As String
			
        	Wait For (RefreshAccessToken(AppKey, AppSecret, RefreshToken)) Complete (xNewToken As String)
			
        	If 	xNewToken <> "" Then
            	AccessToken = xNewToken
				
				Log("New Access Token " &AccessToken)
				
				SaveAccessToken(xNewToken) ' <-- store it				
            	Return True
        	End If
			
            Log("Failed to refresh access token")

			#if B4A			
			File.Delete(File.DirInternal, DEFINE_DropBox_Token_FN) ' remove invalid token		
			#else if B4J	
			File.Delete(File.DirApp, DEFINE_DropBox_Token_FN) ' remove invalid token		
			#else if B4i
			File.Delete(File.DirDocuments, DEFINE_DropBox_Token_FN) ' remove invalid token			
			#end if
            Return False
End Sub
#end Region

#Region Exists
'===============================================================================================================================
'  Exists	(B4A / B4J)
'		Checks if a resource (directory or file) exists on server
'===============================================================================================================================
Public  Sub Exists(xPath As String) As ResumableSub
		    Wait For (EnsureAccessToken) Complete (Success As Boolean)
	
    		If 	Success = False Then 
				Return False
			End If
    
    		Dim j As HttpJob
			
    		j.Initialize("ResourceExists",  Me)
    
    		Dim xUrl As String = $"${DEFINE_DropBox_Default_PathFiles}/get_metadata"$
			
    		Dim xBody As String = "{""path"": """ & xPath & """,""include_deleted"": false}"
    
    		j.PostString(xUrl, xBody)
    		j.GetRequest.SetHeader("Authorization", "Bearer " & AccessToken)
    		j.GetRequest.SetContentType("application/json")
    
    		Wait For (j) JobDone(j As HttpJob)
    
    		mLastHTTPCode = j.Response.StatusCode
    		
    		Dim xExists As Boolean = False
    
    		If 	j.Success Then
        		xExists = True
    		Else If j.ErrorMessage.ToLowerCase.Contains("not_found")  Then
            		xExists = False
			else If j.Response.StatusCode <> 409 Then
					xExists = False					
        	Else
            	Log("ResourceExists Error: " & j.ErrorMessage)
        	End If
    
			j.Release
			
		    Return xExists
End Sub
#end Region

#Region GetLastHTTPCode
Public 	Sub GetLastHTTPCode As Int
    		Return mLastHTTPCode
End Sub
#end Region

#Region GetTokens
'===================================================================================================================
'  GetTokens
'  Exchange Authorization Code for Access + Refresh Tokens
'  Works in B4A, B4J
'
'	NOTE:  This is normally done just once.  But if you get a new AuthorizationCode then it needs to be done again
'===================================================================================================================
Public  Sub GetTokens(xAppKey As String, xAppSecret As String, xAuthCode As String) As ResumableSub
    		Dim j As HttpJob
			
    		j.Initialize("GetTokens", Me)

    		Dim postData As String = _
        			"code=" & xAuthCode & _
        			"&grant_type=authorization_code" & _
        			"&client_id=" & xAppKey & _
        			"&client_secret=" & xAppSecret

		    ' Optional: only include redirect_uri if app requires it
    		' postData = postData & "&redirect_uri=https://localhost"
			

    		j.PostString($"${DEFINE_DropBox_Default_WebSite}/oauth2/token"$, postData)
    		j.GetRequest.SetHeader("Content-Type", "application/x-www-form-urlencoded")

    		Wait For (j) JobDone(j As HttpJob)
			
        	Dim m As Map
			
			m.Initialize
			
    		If 	j.Success Then
        		Dim parser As JSONParser
				
        		parser.Initialize(j.GetString)
				
        		Dim m As Map = parser.NextObject
				
        		Log("Access Token: " 	& m.Get("access_token"))
        		Log("Refresh Token: " 	& m.Get("refresh_token"))
        		Log("Token Type: " 		& m.Get("token_type"))
				
        		j.Release
        		Return m
    		End If
			
        	Log("ResponseError. Reason: " & j.ErrorMessage & ", Response: " & j.GetString)
			
        	j.Release
			
        	Return m
End Sub
#end Region

#Region ListFiles
'===============================================================================================================================
'   ListFiles in a Folder
'===============================================================================================================================
Public  Sub ListFiles(xFolderPath As String, xRecursive As Boolean) As ResumableSub
    		Wait For (EnsureAccessToken) Complete (Success As Boolean)
	
    		Dim ListFileItems As List
			
    		ListFileItems.Initialize
	
    		If 	Success = False Then 
				Return ListFileItems
			End If
    
    
    		Dim j As HttpJob
			
    		j.Initialize("ListFiles",  Me)
    
    		Dim xUrl As String = $"${DEFINE_DropBox_Default_PathFiles}/list_folder"$
			
			Dim MapBody As Map
			
			MapBody = CreateMap("path" : xFolderPath, "recursive" : xRecursive)
			
			Dim JsonGenerator 	As JSONGenerator
			
			JsonGenerator.Initialize(MapBody)
    
    		j.PostString(xUrl, JsonGenerator.ToString)
			
    		j.GetRequest.SetHeader("Authorization", "Bearer " & AccessToken)
    		j.GetRequest.SetContentType("application/json")
    
    		Wait For (j) JobDone(j As HttpJob)
    
    		mLastHTTPCode = j.Response.StatusCode
    
    		If  j.Success = False Then
        		j.Release
				
        		Return ListFileItems
    		End If
    
    		Dim parser As JSONParser
			
    		parser.Initialize(j.GetString)
    
    		Dim ParserMap	As Map 	= parser.NextObject
    		Dim Entries 	As List = ParserMap.Get("entries")
			
    		For Each Entry As Map In Entries
        		Dim Modified As String = ""
        		Dim FileType As String = Entry.Get(".tag")
        
        		If 	Entry.ContainsKey("client_modified") Then
            		Modified = Entry.Get("client_modified")
        		End If
        
        		ListFileItems.Add(ListFiles_CreateItemType(Entry.Get("path_display"), Entry.Get("path_display"), IIf(FileType = "folder", True, False), IIf(Modified <> "", ListFiles_Parse_HttpDate(Modified), 0)))
    		Next
			
    		Return ListFileItems
End Sub

Private Sub ListFiles_CreateItemType(xName As String, xHRef As String, xIsDirectory As Boolean, xLastModified As Long) As cDropBox_ListItemType
			Dim ListItemType As cDropBox_ListItemType
			
			ListItemType.Initialize
			ListItemType.Name			= xName
			ListItemType.HRef			= xHRef
			ListItemType.IsDirectory	= xIsDirectory
			ListItemType.LastModified	= xLastModified
			
			Return ListItemType
End Sub

'===============================================================================================================================
'  DropBox_Parse_HttpDate - 
'		DropDox File Dates are a little weird they are in format yyyy-MM-ddTHH:mm:ssZ
'		So if you don't replace the T with a Space and remove the Z the DateTime parser fails (rather crashes)
'===============================================================================================================================
Private Sub ListFiles_Parse_HttpDate(xHttpDate As String) As Long
    		Dim xOldFormat 	As String 	= DateTime.DateFormat
    		Dim xDT 		As Long		= 0
			
    		xHttpDate = xHttpDate.Replace("T", " ")
    		xHttpDate = xHttpDate.Replace("Z", "")
    
    		DateTime.DateFormat = "yyyy-MM-dd HH:mm:ss"
			
			Try 
    			xDT = DateTime.DateParse(xHttpDate)
			Catch
				Log(LastException.Message)
			End Try
			
    		DateTime.DateFormat = xOldFormat
    
    		Return xDT
End Sub

#end Region

#region RefressAccessToken
'===============================================================================================================================
'   Refresh Tokens - If the current access token is expired - this routine will get a new one
'===============================================================================================================================
Private  Sub RefreshAccessToken(xAppKey As String, xAppSecret As String, xRefreshToken As String) As ResumableSub
    		Dim j As HttpJob
			
    		j.Initialize("RefreshAccessToken", Me)

    		Dim postData As String = _
        			"grant_type=refresh_token" 			& _
        			"&refresh_token=" 	&xRefreshToken 	& _
        			"&client_id=" 		&xAppKey 		& _
        			"&client_secret=" 	&xAppSecret


    		j.PostString($"${DEFINE_DropBox_Default_WebSite}/oauth2/token"$, postData)
			
    		j.GetRequest.SetHeader("Content-Type", "application/x-www-form-urlencoded")

    		Wait For (j) JobDone(j As HttpJob)
			
    		If 	j.Success Then
        		Dim parser As JSONParser
				
        		parser.Initialize(j.GetString)
				
        		Dim m As Map = parser.NextObject
				
        		AccessToken = m.Get("access_token")
				
        		j.Release
				
        		Return AccessToken
    		End If
			
        	Log("Error refreshing token: " & j.GetString)
        	j.Release
        	Return ""
End Sub
#end Region

#Region SetAuthorization
Public  Sub SetAuthorization(xAppKey As String, xAppSecret As String, xRefreshToken As String)
    		RefreshToken    = xRefreshToken
    		AppKey  	    = xAppKey
    		AppSecret   	= xAppSecret
			
  			' Load stored access token if available
			#if B4A			
    		If 	File.Exists(File.DirInternal, DEFINE_DropBox_Token_FN) Then
        		AccessToken = File.ReadString(File.DirInternal, DEFINE_DropBox_Token_FN)
			#else if B4J
    		If 	File.Exists(File.DirApp, DEFINE_DropBox_Token_FN) Then
        		AccessToken = File.ReadString(File.DirApp, DEFINE_DropBox_Token_FN)			
			#else if B4I
    		If 	File.Exists(File.DirDocuments, DEFINE_DropBox_Token_FN) Then
        		AccessToken = File.ReadString(File.DirDocuments, DEFINE_DropBox_Token_FN)			
			#end if				
    		Else
        		AccessToken = ""
    		End If			
End Sub
#end Region

#Region UploadFile
'===============================================================================================================================
'   UploadFile 
'===============================================================================================================================
Public  Sub UploadFile(xLocalPath As String, xLocalFile As String, xRemotePath As String) As ResumableSub
    		Wait For (EnsureAccessToken) Complete (Success As Boolean)
			
    		If  Success = False Then 
				Return False
			End If
    
    		Dim j As HttpJob
			
    		j.Initialize("Upload",  Me)
    
    		Dim xUrl As String = $"${DEFINE_DropBox_Default_Content_PathFiles}/upload"$			
    		Dim xArgs As String = "{""path"": """ & xRemotePath & """,""mode"": ""overwrite""}"
			
'			Log($"xUrl:${xUrl}"$)
'			Log($"xArgs:${xArgs}"$)
			
    		Dim xBytes() As Byte = File.ReadBytes(xLocalPath, xLocalFile)
			
    		j.PostBytes(xUrl, xBytes)    
    		j.GetRequest.SetHeader("Authorization", "Bearer " & AccessToken)
    		j.GetRequest.SetHeader("Dropbox-API-Arg", xArgs)
    		j.GetRequest.SetContentType("application/octet-stream")
    
    
    		Wait For (j) JobDone(j As HttpJob)
    
    		mLastHTTPCode = j.Response.StatusCode
    
    		If j.Success Then
        		Return True
    		End If
			
        	Log("Upload Error: " & j.ErrorMessage)
        	Return False
End Sub
#end Region

Private Sub SaveAccessToken(xToken As String)
    		Try
				#if B4A
				LogColor("Saving New Token", Colors.Red)
				#end if
				
				#if B4A 
        		File.WriteString(File.DirInternal, DEFINE_DropBox_Token_FN, xToken)
				#else if B4J
				File.WriteString(File.DirApp, DEFINE_DropBox_Token_FN, xToken)
				#else if B4I
				File.WriteString(File.DirDocuments, DEFINE_DropBox_Token_FN, xToken)
				#end if
    		Catch
        		Log("Error saving token")
    		End Try
End Sub

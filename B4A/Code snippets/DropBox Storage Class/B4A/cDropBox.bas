B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.4
@EndOfDesignText@
'===============================================================================================================================
'   Robert Valentino - B4X Dropbox Storage Class with Auto Token Refresh
'   Version 2.0
'===============================================================================================================================

Sub Class_Globals
    Private Const Version                    				As String = "2.1"        'Ignore


    Private Const DEFINE_DropBox_Default_WebSite			As String = "https://api.dropboxapi.com"	
    Private Const DEFINE_DropBox_Default_Path  				As String = $"${DEFINE_DropBox_Default_WebSite}/2"$
    Private Const DEFINE_DropBox_Default_PathFiles			As String = $"${DEFINE_DropBox_Default_Path}/files"$

    Private Const DEFINE_DropBox_Default_Content_PathFiles	As String = $"https://content.dropboxapi.com/2/files"$
	

	Private Const DEFINE_DropBox_Token_FN	 				As String = "dropbox_token.txt"
    Private mLastHTTPCode                    				As Int    
    Private AuthorizedToken                  				As String
    Private RefreshToken                     				As String
    Private AppKey                           				As String
    Private AppSecret                        				As String
End Sub

'===============================================================================================================================
'   Initialization
'===============================================================================================================================

Public  Sub Initialize(xAccessToken As String, xRefreshToken As String, xAppKey As String, xAppSecret As String)
		    AuthorizedToken = xAccessToken
    		RefreshToken    = xRefreshToken
    		AppKey  	     = xAppKey
    		AppSecret   	 = xAppSecret
			
  			' Load stored access token if available
			#if B4A
    		If 	File.Exists(File.DirInternal, DEFINE_DropBox_Token_FN) Then
        		AuthorizedToken = File.ReadString(File.DirInternal, DEFINE_DropBox_Token_FN)
			#else if B4I
    		If 	File.Exists(File.DirDocuments, DEFINE_DropBox_Token_FN) Then
        		AuthorizedToken = File.ReadString(File.DirDocuments, DEFINE_DropBox_Token_FN)			
			#end if				
    		Else
        		AuthorizedToken = xAccessToken
    		End If			
End Sub

'===============================================================================================================================
'   Ensure Access Token is valid
'===============================================================================================================================
Public  Sub GetDropboxTokens(xAppKey As String, xAppSecret As String, xAuthCode As String) As ResumableSub
    		Dim j As HttpJob

		    j.Initialize("",  Me)
    
			Dim xMap	As Map
    		Dim xData 	As String = $"code=${xAuthCode}&grant_type=authorization_code&client_id=${xAppKey}&client_secret=${xAppSecret}"$
    
    		j.PostString($"${DEFINE_DropBox_Default_Path}/oauth2/token"$, xData)
    		j.GetRequest.SetContentType("application/x-www-form-urlencoded")
    
    		Wait For (j) JobDone(j As HttpJob)
	
    		If 	j.Success Then
        		Dim parser As JSONParser
				
        		parser.Initialize(j.GetString)
				
        		Dim xMap As Map = parser.NextObject
				
        		Log("Access Token: " 	&xMap.Get("access_token"))
        		Log("Refresh Token: " 	&xMap.Get("refresh_token"))
        		Log("Expires In: " 		&xMap.Get("expires_in"))
				
        		j.Release
				
        		Return xMap
    		End If
			
        	Log("Error: " & j.ErrorMessage)
        	j.Release
	
			xMap.Initialize
					
        	Return xMap
End Sub

public 	Sub EnsureAccessToken() As ResumableSub
	
			Dim url As String = $"${DEFINE_DropBox_Default_Path}/users/get_current_account"$
			Dim j 	As HttpJob
			
			j.Initialize("CheckToken", Me)

			j.PostString(url, "null")  ' DropBox requires an empty JSON object

			j.GetRequest.SetHeader("Authorization", "Bearer " & AuthorizedToken)
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
			
        	Wait For (GetNewDropboxAccessToken(AppKey, AppSecret, RefreshToken)) Complete (xNewToken As String)
			
        	If 	xNewToken <> "" Then
            	AuthorizedToken = xNewToken
				
				SaveAccessToken(xNewToken) ' <-- store it				
            	Return True
        	End If
			
            Log("Failed to refresh access token")

			#if B4A			
			File.Delete(File.DirInternal, DEFINE_DropBox_Token_FN) ' remove invalid token			
			#else if B4i
			File.Delete(File.DirDocuments, DEFINE_DropBox_Token_FN) ' remove invalid token			
			#end if
            Return False
End Sub

'===============================================================================================================================
'   Access / Refresh Tokens
'===============================================================================================================================
Public  Sub GetNewDropboxAccessToken(xAppKey As String, xAppSecret As String, xRefreshToken As String) As ResumableSub
		    Dim j As HttpJob
			
    		j.Initialize("", Me)
    
    		Dim xData As String = $"grant_type=refresh_token&refresh_token=${xRefreshToken}&client_id=${xAppKey}&client_secret=${xAppSecret}"$
    
    		j.PostString($"${DEFINE_DropBox_Default_WebSite}/oauth2/token"$, xData)
    		j.GetRequest.SetContentType("application/x-www-form-urlencoded")
    
    		Wait For (j) JobDone(j As HttpJob)
    
    		If 	j.Success Then
        		Dim parser As JSONParser
				
		        parser.Initialize(j.GetString)
        
        		Dim xMap As Map = parser.NextObject
        		Dim xAccessToken As String = xMap.Get("access_token")
        
        		Log("New Access Token: " & xAccessToken)
				
		        j.Release
				
        		Return xAccessToken
			End If
			
	        Log("Error refreshing token: " & j.ErrorMessage)
    	    j.Release
        	Return ""
End Sub

Public 	Sub GetLastHTTPCode As Int
    		Return mLastHTTPCode
End Sub

'===============================================================================================================================
'   Utilities
'===============================================================================================================================
Private Sub CreateCopy(xListToCopy As List) As List
    		Dim xNewList As List
			
    		xNewList.Initialize
    		xNewList.AddAll(xListToCopy)
			
    		Return xNewList
End Sub

Private Sub DropBox_Parse_HttpDate(xHttpDate As String) As Long
    		Dim xOldFormat As String = DateTime.DateFormat
    
    		xHttpDate = xHttpDate.Replace("T", " ")
    		xHttpDate = xHttpDate.Replace("Z", "")
    
    		DateTime.DateFormat = "yyyy-MM-dd HH:mm:ss"
			
    		Dim xDT As Long = DateTime.DateParse(xHttpDate)
			
    		DateTime.DateFormat = xOldFormat
    
    		Return xDT
End Sub

'===============================================================================================================================
'   Folder / File Operations
'===============================================================================================================================
Public 	Sub CreateDirectory(xFolderPath As String) As ResumableSub
    		Wait For (EnsureAccessToken) Complete (ok As Boolean)
			
    		If 	ok = False Then 
				Return False
			End If
    
    		Dim j As HttpJob
    		j.Initialize("CreateDirectory", Me)
    
    		Dim xUrl As String = $"${DEFINE_DropBox_Default_PathFiles}/create_folder_v2"$
    
    		If 	Not(xFolderPath.StartsWith("/")) Then
        		xFolderPath = "/" & xFolderPath
    		End If
    
    		Dim xBody As String = "{""path"": """ & xFolderPath & """,""autorename"": false}"
    
    		j.PostString(xUrl, xBody)
    		j.GetRequest.SetHeader("Authorization", "Bearer " & AuthorizedToken)
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

Public  Sub UploadFile(xLocalPath As String, xLocalFile As String, xRemotePath As String) As ResumableSub
    		Wait For (EnsureAccessToken) Complete (ok As Boolean)
			
    		If  ok = False Then 
				Return False
			End If
    
    		Dim j As HttpJob
			
    		j.Initialize("Upload",  Me)
    
    		Dim xUrl As String = $"${DEFINE_DropBox_Default_Content_PathFiles}/upload"$			
    		Dim xArgs As String = "{""path"": """ & xRemotePath & """,""mode"": ""overwrite""}"
			
			Log($"xUrl:${xUrl}"$)
			Log($"xArgs:${xArgs}"$)
			
    		Dim xBytes() As Byte = File.ReadBytes(xLocalPath, xLocalFile)
			
    		j.PostBytes(xUrl, xBytes)    
    		j.GetRequest.SetHeader("Authorization", "Bearer " & AuthorizedToken)
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

Public 	Sub DownloadFile(xRemotePath As String, xLocalPath As String, xLocalFile As String) As ResumableSub
		    Wait For (EnsureAccessToken) Complete (ok As Boolean)
			
    		If  ok = False Then 
				Return False
			End If
    
    		Dim j As HttpJob
    		j.Initialize("Download",  Me)
    
    		Dim xUrl As String = $"${DEFINE_DropBox_Default_Content_PathFiles}/download"$

    		j.Download(xUrl)    
    		j.GetRequest.SetHeader("Authorization", "Bearer " & AuthorizedToken)
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

Public  Sub ListFiles(xFolderPath As String) As ResumableSub
    		Wait For (EnsureAccessToken) Complete (ok As Boolean)
	
    		Dim xListFileItems As List
			
    		xListFileItems.Initialize
	
    		If 	ok = False Then 
				Return CreateCopy(xListFileItems)
			End If
    
    
    		Dim j As HttpJob
			
    		j.Initialize("List",  Me)
    
    		Dim xUrl As String = $"${DEFINE_DropBox_Default_PathFiles}/list_folder"$
    		Dim xBody As String = "{""path"": """ & xFolderPath & """}"
    
    		j.PostString(xUrl, xBody)
    		j.GetRequest.SetHeader("Authorization", "Bearer " & AuthorizedToken)
    		j.GetRequest.SetContentType("application/json")
    
    		Wait For (j) JobDone(j As HttpJob)
    
    		mLastHTTPCode = j.Response.StatusCode
    
    		If  j.Success = False Then
        		j.Release
				
        		Return CreateCopy(xListFileItems)
    		End If
    
    		Dim parser As JSONParser
    		parser.Initialize(j.GetString)
    
    		Dim xRoot As Map = parser.NextObject
    		Dim xEntries As List = xRoot.Get("entries")
    
    		For Each xE As Map In xEntries
        		Dim xModified As String = ""
        		Dim xFileType As String = xE.Get(".tag")
        
        		If 	xE.ContainsKey("client_modified") Then
            		xModified = xE.Get("client_modified")
        		End If
        
        		xListFileItems.Add(CreateMap("Name": xE.Get("path_display"), _
                		                     "HRef": xE.Get("path_display"), _
                        		             "IsDir": IIf(xFileType = "folder", True, False), _
                                		     "LastModified": IIf(xModified <> "", DropBox_Parse_HttpDate(xModified), 0)))
    		Next
    
    		Return CreateCopy(xListFileItems)
End Sub

Public  Sub DeleteFile(xRemotePath As String) As ResumableSub
    		Wait For (EnsureAccessToken) Complete (ok As Boolean)
			
    		If  ok = False Then 
				Return False
			End If
    
    		Dim j As HttpJob
			
    		j.Initialize("Delete",  Me)
    
    		Dim xUrl As String = $"${DEFINE_DropBox_Default_PathFiles}/delete_v2"$
    		Dim xBody As String = "{""path"": """ & xRemotePath & """}"

			
    		j.PostString(xUrl, xBody)
    
    		j.GetRequest.SetHeader("Authorization", "Bearer " & AuthorizedToken)
    		j.GetRequest.SetContentType("application/json")
    
    
    		Wait For (j) JobDone(j As HttpJob)
    
    		mLastHTTPCode = j.Response.StatusCode
    
    		If 	j.Success Then
        		Return True
			End If
			
	        Log("DeleteFile Error: " & j.ErrorMessage)
    	    Return False
End Sub

Public Sub ResourceExists(xPath As String) As ResumableSub
		    Wait For (EnsureAccessToken) Complete (ok As Boolean)
	
    		If 	ok = False Then 
				Return False
			End If
    
    		Dim j As HttpJob
			
    		j.Initialize("ResourceExists",  Me)
    
    		Dim xUrl As String = $"${DEFINE_DropBox_Default_PathFiles}/get_metadata"$
    		Dim xBody As String = "{""path"": """ & xPath & """,""include_deleted"": false}"
    
    		j.PostString(xUrl, xBody)
    		j.GetRequest.SetHeader("Authorization", "Bearer " & AuthorizedToken)
    		j.GetRequest.SetContentType("application/json")
    
    		Wait For (j) JobDone(j As HttpJob)
    
    		mLastHTTPCode = j.Response.StatusCode
    
    		Dim xExists As Boolean = False
    
    		If 	j.Success Then
        		xExists = True
    		Else If j.ErrorMessage.ToLowerCase.Contains("path/not_found") Then
            		xExists = False
        	Else
            	Log("ResourceExists Error: " & j.ErrorMessage)
        	End If
    
		    Return xExists
End Sub


Private Sub SaveAccessToken(xToken As String)
    		Try
				LogColor("Saving New Token", Colors.Red)
				#if B4A 
        		File.WriteString(File.DirInternal, DEFINE_DropBox_Token_FN, xToken)
				#else if B4I
				File.WriteString(File.DirDocuments, DEFINE_DropBox_Token_FN, xToken)
				#end if
    		Catch
        		Log("Error saving token")
    		End Try
End Sub

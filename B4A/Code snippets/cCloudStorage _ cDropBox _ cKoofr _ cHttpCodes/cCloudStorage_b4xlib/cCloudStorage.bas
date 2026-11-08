B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
'===============================================================================================================================
'   Robert Valentino - 	This class uses 2 classes cDropBox and cKoofr
'						So I can call one class and have it work with either
'   Version 1.0
'
'	To get a new authorization code:  https://www.dropbox.com/oauth2/authorize?client_id=APP_KEY&response_type=code&token_access_type=offline
'===============================================================================================================================

Sub Class_Globals
	Private Const  Version			As String	= "1.0"		'Ignore
		
	Type	cCloudStorage_ListItemType(Name As String, IsDirectory As Boolean, HRef As String, LastModified As Long)		

	Private mKoofr				As cKoofr
	Private mDropBox			As cDropBox

	Private mUsingKoofr			As Boolean	= False	
	Private mUsingDB			As Boolean	= False
	Private mWhichClassSet		As Boolean	= False		
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public  Sub Initialize
			mKoofr.Initialize
			mDropBox.Initialize
End Sub

Public  Sub WhatStorageAreWeUsing As String
			If  mWhichClassSet Then
				If  mUsingDB Then
					Return "DropBox"
				End If
				
				If  mUsingKoofr Then
					Return "Koofr"
				End If
				
				Return "Unknown - NONE Set"
			End If
			
			Return "SetAuthorization - NOT Called"
End Sub

Public  Sub AreWeUsingDropBox As Boolean
			If  mWhichClassSet Then
				Return mUsingDB
			End If

			Return False	
End Sub

Public  Sub AreWeUsingKoofr As Boolean
			If  mWhichClassSet Then
				Return mUsingKoofr
			End If

			Return False	
End Sub

'-----------------------------------------------------------------------------------------------------------
'	SetAuthorization - 	If you pass 3 Parameters (AppKey, AppSecret & RefreshToken) you are using cDropBox	
'						If you pass 1 or 2 Parmeters (AuthorizatonCode) or (Email, PWD) you are using cKoofr
'-----------------------------------------------------------------------------------------------------------
Public  Sub SetAuthorization(xParms() As String)  As Boolean
			
			mUsingDB 		= False
			mUsingKoofr		= False
			mWhichClassSet 	= False
			
			Select	xParms.Length
					Case 	1				'  If Passing 1 then using Koofr
							'-------------------------------------------------------------------------------
							'	1st Parm (Authorization) needs to given	
							'-------------------------------------------------------------------------------							
							If  xParms(0).Length > 0 Then
								mKoofr.SetAuthorizationCode(xParms(0))				

								mUsingDB 		= False
								mUsingKoofr		= True
								mWhichClassSet 	= True
								
								Return True
							End If
							
							Log($"Invalid setup for Koofr - 1 Parameter and Length is Zero"$)									
							Return False
							
					Case 	2				'  If Passing 1 or 2 Parms then using Koofr
							'-------------------------------------------------------------------------------							
							'	Both Parms (Email, Password) need to given	
							'-------------------------------------------------------------------------------															
							If  (xParms(0).Length > 0 And xParms(1).Length > 0) Then
								mKoofr.SetAuthorization(xParms(0), xParms(1))
									
								mUsingDB 		= False
								mUsingKoofr		= True
								mWhichClassSet 	= True
									
								Return True
							End If
							
							Log($"Invalid setup for Koofr - 2 Parameters and one or both are length Zero"$)																										
							Return False							
				
					Case	3					'  If Passing 3 Parms then using DropBox
							'-------------------------------------------------------------------------------
							'	1st 2 Parms (AppKey & AppSecret) need to given 3rd parameter is needed 
							'									 but can have a length of zero
							'-------------------------------------------------------------------------------
							If  xParms(0).Length > 0 And xParms(1).Length > 0 Then
								mDropBox.SetAuthorization(xParms(0), xParms(1), xParms(2))
								
								mUsingDB 		= True
								mUsingKoofr		= False
								mWhichClassSet 	= True
									
								Return True
							End If
							
							Log($"Invalid setup for DropBox either AppKey ${xParms(0).Length} or AppSecret ${xParms(1).Length} is Zero"$)								
							Return False
			End Select
				
			Log($"Invalid amount of Parameters for DropBox (3) or Koofr(1, or 2)  - Number of Parms Passed:${xParms.Length}"$)
				
			Return False
End Sub

Public 	Sub GetLastHTTPCode As Int
	
			If  mWhichClassSet Then
				If  mUsingDB Then 
					Return mDropBox.GetLastHTTPCode
				End If
				
				If  mUsingKoofr Then
					Return mKoofr.GetLastHTTPCode
				End If
			End If
			
			Return -1
End Sub

Public 	Sub CreateDirectory(xFolderPath As String) As ResumableSub
	
			If  mWhichClassSet Then
				If  mUsingDB Then 
					wait for (mDropBox.CreateDirectory(xFolderPath)) Complete(Result As Object)
					
					Return Result
				End If
				
				If  mUsingKoofr Then
					wait for (mKoofr.CreateDirectory(xFolderPath)) Complete(Result As Object)
					
					Return Result
				End If
			End If
			
			Return False
End Sub

Public  Sub DeleteFile(xRemotePath As String) As ResumableSub
	
			If  mWhichClassSet Then
				If  mUsingDB Then 
					wait for (mDropBox.DeleteFile(xRemotePath)) Complete(Result As Object)
					
					Return Result
				End If
				
				If  mUsingKoofr Then
					wait for (mKoofr.DeleteFile(xRemotePath)) Complete(Result As Object)
					
					Return Result
				End If
			End If	
			
			Return False
End Sub

Public 	Sub DownloadFile(xRemotePath As String, xLocalPath As String, xLocalFile As String) As ResumableSub
	
			If  mWhichClassSet Then
				If  mUsingDB Then 
					wait for (mDropBox.DownloadFile(xRemotePath, xLocalPath, xLocalFile)) Complete(Result As Object)
					
					Return Result
				End If
				
				If  mUsingKoofr Then
					wait for (mKoofr.DownloadFile(xRemotePath, xLocalPath, xLocalFile)) Complete(Result As Object)
					
					Return Result
				End If
			End If	
			
			Return False	
End Sub

Public 	Sub DownloadStream(xRemotePath As String, xDownloadStream As OutputStream) As ResumableSub
	
			If  mWhichClassSet Then
				If  mUsingDB Then 
					wait for (mDropBox.DownloadStream(xRemotePath, xDownloadStream)) Complete(Result As Object)
					
					Return Result
				End If
				
				If  mUsingKoofr Then
					wait for (mKoofr.DownloadStream(xRemotePath, xDownloadStream)) Complete(Result As Object)
					
					Return Result
				End If
			End If	
			
			Return False	
End Sub

Public  Sub Exists(xPath As String) As ResumableSub
			If  mWhichClassSet Then
				If  mUsingDB Then 
					wait for (mDropBox.Exists(xPath)) Complete(Result As Object)
					
					Return Result
				End If
				
				If  mUsingKoofr Then
					wait for (mKoofr.Exists(xPath)) Complete(Result As Object)
					
					Return Result
				End If
			End If
			
			Return False
	
End Sub

Public  Sub IsReady As Boolean
			Return (mWhichClassSet Or mUsingDB Or mUsingKoofr)
End Sub

Public  Sub ListFiles(xFolderPath As String, xRecursive As Boolean) As ResumableSub
			If  mWhichClassSet Then
				If  mUsingDB Then 
					wait for (mDropBox.ListFiles(xFolderPath, xRecursive)) Complete(Result As List)
					
					Return ConvertToCloudStorageItems(Result)
				End If
				
				If  mUsingKoofr Then
					wait for (mKoofr.ListFiles(xFolderPath, xRecursive)) Complete(Result As List)
					
					Return ConvertToCloudStorageItems(Result)
				End If
			End If

			Dim  ListItems As List
			
			ListItems.Initialize
						
			Return ListItems	
End Sub

Private Sub ConvertToCloudStorageItems(xListItems As List) As List
	
			Dim NewListItems As List
			
			NewListItems.Initialize
			
			For Each ListItem As Object In xListItems
				Dim NewListItem As cCloudStorage_ListItemType
				
				NewListItem.Initialize
				
				If  ListItem Is cDropBox_ListItemType Then
					NewListItem.HRef			= ListItem.As(cDropBox_ListItemType).HRef
					NewListItem.Name			= ListItem.As(cDropBox_ListItemType).Name
					NewListItem.IsDirectory		= ListItem.As(cDropBox_ListItemType).IsDirectory
					NewListItem.LastModified	= ListItem.As(cDropBox_ListItemType).LastModified
					
					NewListItems.Add(NewListItem)
				else if ListItem Is cKoofr_ListItemType Then
						NewListItem.HRef			= ListItem.As(cKoofr_ListItemType).HRef
						NewListItem.Name			= ListItem.As(cKoofr_ListItemType).Name
						NewListItem.IsDirectory		= ListItem.As(cKoofr_ListItemType).IsDirectory
						NewListItem.LastModified	= ListItem.As(cKoofr_ListItemType).LastModified
					
						NewListItems.Add(NewListItem)
				End If
			Next
			
			Return NewListItems
End Sub

Public  Sub UploadFile(xLocalPath As String, xLocalFile As String, xRemotePath As String) As ResumableSub	
			If  mWhichClassSet Then
				If  mUsingDB Then 
					wait for (mDropBox.UploadFile(xLocalPath, xLocalFile, xRemotePath)) Complete(Result As Object)
					
					Return Result
				End If
				
				If  mUsingKoofr Then
					wait for (mKoofr.UploadFile(xLocalPath, xLocalFile, xRemotePath)) Complete(Result As Object)
					
					Return Result
				End If
			End If	
			
			Return False
End Sub

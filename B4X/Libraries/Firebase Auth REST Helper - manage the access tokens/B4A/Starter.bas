B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=9.9
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
	#ExcludeFromLibrary: True
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Public farh As FirebaseAuthRESTHelper
	Public far As FirebaseAuthREST
End Sub

Sub Service_Create
	'This is the program entry point.
	'This is a good place to load resources that are not specific to a single activity.
	farh.Initialize(Me,"farh")
	far.Initialize
End Sub

Sub Service_Start (StartingIntent As Intent)
	Service.StopAutomaticForeground 'Starter service can start in the foreground state in some edge cases.
End Sub

Sub Service_TaskRemoved
	'This event will be raised when the user removes the app from the recent apps list.
End Sub

'Return true to allow the OS default exceptions handler to handle the uncaught exception.
Sub Application_Error (Error As Exception, StackTrace As String) As Boolean
	Return True
End Sub

Sub Service_Destroy

End Sub

Private Sub farh_AccessTokenAvailable (Success As Boolean, Token As String)
	
	Log("farh_AccessTokenAvailable")
	Log("Success: " & Success)
	Log("Token: " & Token)
	
End Sub

Private Sub farh_Authenticate
	
	Log("farh_Authenticate")
	
	Wait For (far.signInEmailPW("alex.98.stolte@gmx.de","Test123",True)) complete (root As Map)
	If root.Get("success") = True Then
		
		farh.TokenInformationFromResponse(root)
		
	End If
	
End Sub

Private Sub farh_RefreshToken (RefreshToken As String)
	
	Log("farh_RefreshToken")
	Log("RefreshToken: " & RefreshToken)
	
	Wait For (far.refreshToken("refresh_token",RefreshToken)) complete (root As Map)
	If root.Get("success") = True Then
		
		farh.TokenInformationFromResponse(root)
		
	End If
	
End Sub
B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=5.95
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
	#ExcludeFromLibrary: True
#End Region

Sub Process_Globals
	Public auth As FirebaseAuth
	Public facebook As FacebookSdk
End Sub

Sub Service_Create
	auth.Initialize("auth")
	facebook.Initialize
End Sub

Sub Auth_SignedIn (User As FirebaseUser)
	Log("SignedIn: " & User.DisplayName)
	CallSub(Main, "SetState")
	Log(User.Uid)
	Log(User.Email)
End Sub

Sub Service_Start (StartingIntent As Intent)

End Sub

'Return true to allow the OS default exceptions handler to handle the uncaught exception.
Sub Application_Error (Error As Exception, StackTrace As String) As Boolean
	Return True
End Sub

Sub Service_Destroy

End Sub

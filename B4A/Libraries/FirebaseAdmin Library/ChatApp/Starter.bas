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
	Dim rp As RuntimePermissions
	Dim Firebase As Firebase
	Dim Firestore As Firestore
	Dim ChatsListener,UsersListerner As ListenerRegistration
	Dim UserName As String
	Dim PendingMessages,TotalMessages As List
End Sub

Sub Service_Create
	'This is the program entry point.
	'This is a good place to load resources that are not specific to a single activity.
	Firebase.Initialize("Firebase","fir-tests-582fc")
	PendingMessages.Initialize
	TotalMessages.Initialize
End Sub

Sub Service_Start (StartingIntent As Intent)
	Service.StopAutomaticForeground 'Starter service can start in the foreground state in some edge cases.
End Sub

Sub Service_TaskRemoved
	'This event will be raised when the user removes the app from the recent apps list.
	UsersListerner.Remove
	ChatsListener.Remove
End Sub

'Return true to allow the OS default exceptions handler to handle the uncaught exception.
Sub Application_Error (Error As Exception, StackTrace As String) As Boolean
	Return True
End Sub

Sub Service_Destroy

End Sub

Private Sub Firebase_Ready(Success As Boolean)
	If Success Then
		Firestore.Initialize("Firestore","")
		UsersListerner.Get(Firestore.CollectionListen("users"))
		ChatsListener.Get(Firestore.CollectionListen("chats"))
	End If
End Sub

Private Sub Firestore_CollectionChanged(Data As Map)
	If Data.IsInitialized Then
		Select Data.Get("collection")
			Case "users"
				CallSub2(Main,"UpdateUsers",Data)
			Case "chats"
				TotalMessages.Add(TotalMessages.Size+1)
				CallSub2(Main,"UpdateChat",Data)
				If Main.ActivityClosed Then
					PendingMessages.Add(Data)
					Dim Params As Map = Data.Get("data")
					If Params.Get("sender_id") <> Main.DeviceId Then
						Dim n As Notification
						n.Initialize
						n.Icon = "icon"
						n.SetInfo("New message",Params.Get("text"),Main)
						n.Notify(1)
					End If
				End If
		End Select
	End If
End Sub

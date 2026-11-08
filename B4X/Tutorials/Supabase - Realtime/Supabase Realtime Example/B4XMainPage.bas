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
	Public xSupabase As Supabase
	Private Realtime As SupabaseRealtime
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	B4XPages.SetTitle(Me,"Supabase Example")
	
	xSupabase.Initialize("https://xxx.supabase.co","xxx")
	xSupabase.InitializeEvents(Me,"Supabase")
	
End Sub

Private Sub B4XPage_Foreground

End Sub


#IF B4J
Private Sub xlbl_Connect2Realtime_MouseClicked (EventData As MouseEvent)
#Else
Private Sub xlbl_Connect2Realtime_Click
#End If
	
	Wait For (xSupabase.Auth.isUserLoggedIn) Complete (isLoggedIn As Boolean)
	
	If isLoggedIn = False Then
	
		Wait For (xSupabase.Auth.LogIn_EmailPassword("test@gmail.com","Test123!!")) Complete (User As SupabaseUser)
		If User.Error.Success Then
			Log("successfully logged in with " & User.Email)
		Else
			Log("Error: " & User.Error.ErrorMessage)
			Return
		End If
	
	End If
	
	Realtime.Initialize(Me,"Realtime",xSupabase) 'Initializes the realtime class
	Realtime.Connect 'Connect to the supabase realtime server
	
	Wait For Realtime_Connected 'Client is connected
	Log("Realtime_Connected")

	'Subscribe to all database changes on dt_Chat with room_id = 3
	Realtime _
	.Channel("public","dt_Chat",Realtime.BuildFilter("room_id",Realtime.Filter_Equal,"3")) _ 
	.On(Realtime.SubscribeType_PostgresChanges) _
	.Event(Realtime.Event_ALL) _
	.Subscribe

	Wait For Realtime_Subscribed 'Successfully subscribed
	Log("Subscribed to topic")
	

End Sub

Private Sub Realtime_DataReceived(Data As SupabaseRealtime_Data)
	
	If Data.EventType = Realtime.Event_UPDATE Then 'A record in the database was changed
		
		For Each k As String In Data.Records.Keys
			Log($"Column: "${k}" Value: "${Data.Records.Get(k)}""$)
		Next
		
	End If
	
End Sub
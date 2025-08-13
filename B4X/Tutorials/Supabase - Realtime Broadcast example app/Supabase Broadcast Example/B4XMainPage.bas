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
	Private ThisChannel As SupabaseRealtime_Channel
	Private ThisUser As SupabaseUser
	
	Private xpnl_RealtimeOnlineIndicator As B4XView
	Private MySessionColor As Int
	Private p_Login As b4xp_Login
	Private xpnl_Background As B4XView
	Private LastX,LastY As Int
	Private LastLastX,LastLastY As Int
	Private TimeSinceLastSendSameValues As Long
	Private Timer1 As Timer
End Sub

Public Sub Initialize

End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	B4XPages.AddPage("b4xp_Login",p_Login.Initialize)
	
	B4XPages.SetTitle(Me,"Supabase Broadcast Example")
	
	xSupabase.Initialize("https://xxx.supabase.co","xxx")
	xSupabase.InitializeEvents(Me,"Supabase")
	
	MySessionColor = xui.Color_ARGB(255,Rnd(0,256),Rnd(0,256),Rnd(0,256)) 'Random Session Avatar Color
	
	xpnl_RealtimeOnlineIndicator = xui.CreatePanel("")
	Root.AddView(xpnl_RealtimeOnlineIndicator,10dip,10dip,10dip,10dip)
	xpnl_RealtimeOnlineIndicator.SetColorAndBorder(xui.Color_Red,0,0,10dip/2)
	
	'Spawn the new connected client in the middle of the screen
	LastX = Root.Width/2
	LastY = Root.Height/2
	
'	Wait For (xSupabase.Auth.Logout) Complete (Result As SupabaseError)
'	If Result.Success Then
'		Log("User successfully logged out")
'	Else
'		Log("Error: " & Result.ErrorMessage)
'	End If
'	
	Wait For (xSupabase.Auth.isUserLoggedIn) Complete (isLoggedIn As Boolean)
	
	If isLoggedIn = False Then
		B4XPages.ShowPage("b4xp_Login")
	Else
		ConnectRealtime
	End If
	
	#If B4A or B4J
	B4XPage_Resize(Root.Width,Root.Height)
	#End If
	
End Sub

Private Sub B4XPage_Appear
	
	Wait For (xSupabase.Auth.isUserLoggedIn) Complete (isLoggedIn As Boolean)
	If isLoggedIn Then ConnectRealtime
	
End Sub

Private Sub ConnectRealtime
	
	Wait For (xSupabase.Auth.GetUser) Complete (User As SupabaseUser) 'I need this, because i want to send my username with broadcast
	ThisUser = User
		
	Realtime.Initialize(Me,"Realtime",xSupabase) 'Initializes the realtime class
	Realtime.Connect 'Connect to the supabase realtime server
 
	Wait For Realtime_Connected 'Client is connected
	Log("Realtime_Connected")
	xpnl_RealtimeOnlineIndicator.SetColorAndBorder(xui.Color_Green,0,0,10dip/2)
	
	ThisChannel = Realtime _
    .Channel("Room1","","") _
    .On(Realtime.SubscribeType_Broadcast) _
    .ReceiveOwnBroadcasts(False) _
    .AcknowledgeBroadcasts(False) _
    .Subscribe
	
	Wait For Realtime_Subscribed
	Log("Subscribed to Broadcast")
	
	'The timer sends every 50 milliseconds with broadcast
	Timer1.Initialize("Timer1",50)
	Timer1.Enabled = True
	
End Sub

Private Sub Realtime_Disconnected
	xpnl_RealtimeOnlineIndicator.SetColorAndBorder(xui.Color_Red,0,0,10dip/2)
End Sub

Private Sub B4XPage_Resize (Width As Int, Height As Int)
	
	
End Sub

#If B4J
Private Sub xpnl_Background_MouseMoved (EventData As MouseEvent)
	MouseMoved(EventData.X,EventData.Y)
End Sub
#Else
Private Sub xpnl_Background_Touch(Action As Int, X As Float, Y As Float)
	MouseMoved(X,Y)
End Sub
#End If


Private Sub MouseMoved(x As Int,y As Int)
	LastX = x 'global variables
	LastY = y
End Sub

Private Sub Timer1_Tick
	Dim m As Map = CreateMap("x":LastX.As(String),"y":LastY.As(String),"clr":MySessionColor.As(String),"usr_id":ThisUser.Id,"username":ThisUser.Metadata.Get("username"))
	
	'Since I do not receive my own broadcast, I move my avatar with local data
	Dim BroadcastData As SupabaseRealtime_BroadcastData
	BroadcastData.Initialize
	BroadcastData.Payload = m
	Realtime_BroadcastDataReceived(BroadcastData)
	
	If ThisChannel.IsInitialized = False Then Return
	
	If LastLastX <> LastX Or LastLastY <> LastY Then 'If the mouse pointer does not move, I do not want to send a broadcast every 50 milliseconds, only when the mouse moves again
		LastLastX = LastX
		LastLastY = LastY
		TimeSinceLastSendSameValues = DateTime.Now
		ThisChannel.SendBroadcast("cursor-pos",m)
		'Log("Send")
		Else
		'But for new clients, i send every 10 seconds my broadcast, so that they know where my current position is
		If (DateTime.Now - TimeSinceLastSendSameValues) > DateTime.TicksPerSecond*10 Then
			TimeSinceLastSendSameValues = DateTime.Now
			ThisChannel.SendBroadcast("cursor-pos",m)
			'Log("Send")
		End If
	End If
End Sub

Private Sub Realtime_BroadcastDataReceived(BroadcastData As SupabaseRealtime_BroadcastData)
    
	Dim Created As Boolean = False
	For i = 0 To xpnl_Background.NumberOfViews -1
		
		If xpnl_Background.GetView(i).Tag = BroadcastData.Payload.Get("usr_id") Then 'if avatar still exists
			Created = True
			'Move the avatar to the new position
			xpnl_Background.GetView(i).SetLayoutAnimated(0,Max(0,BroadcastData.Payload.Get("x") - xpnl_Background.GetView(i).Width/2),Max(0,BroadcastData.Payload.Get("y") - xpnl_Background.GetView(i).Height/2),xpnl_Background.GetView(i).Width,xpnl_Background.GetView(i).Height)
			xpnl_Background.GetView(i).GetView(0).Text = BroadcastData.Payload.Get("username")
			If xpnl_Background.GetView(i).GetView(1).Color <> BroadcastData.Payload.Get("clr") Then xpnl_Background.GetView(i).GetView(1).SetColorAndBorder(BroadcastData.Payload.Get("clr"),0,0,xpnl_Background.GetView(i).Height/2)
			Exit
		End If
		
	Next
    
	'Create the avatar
	If Created = False Then
		
		Dim xpnl_User As B4XView = xui.CreatePanel("")
		xpnl_User.Tag = BroadcastData.Payload.Get("usr_id")
		xpnl_Background.AddView(xpnl_User,BroadcastData.Payload.Get("x") - 100dip/2,BroadcastData.Payload.Get("y") - 50dip/2,100dip,50dip)
		
		Dim xlbl_Username As B4XView = CreateLabel
		xlbl_Username.Text = BroadcastData.Payload.Get("username")
		xlbl_Username.TextColor = xui.Color_White
		xlbl_Username.Font = xui.CreateDefaultBoldFont(15)
		xlbl_Username.SetTextAlignment("CENTER","CENTER")
		xpnl_User.AddView(xlbl_Username,0,0,xpnl_User.Width,xpnl_User.Height/2)
		
		Dim xpnl_UserCircle As B4XView = xui.CreatePanel("")
		xpnl_User.AddView(xpnl_UserCircle,xpnl_User.Width/2 - (xpnl_User.Height/2)/2,xpnl_User.Height/2,xpnl_User.Height/2,xpnl_User.Height/2)
		xpnl_UserCircle.SetColorAndBorder(BroadcastData.Payload.Get("clr"),0,0,xpnl_User.Height/2)
		
	End If
	
End Sub

Private Sub CreateLabel As B4XView
	Dim lbl As Label
	lbl.Initialize("")
	Return lbl
End Sub

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
	Public Key As KeyValueStore
	Dim Store As Firestore
	Dim ChatsListener,UsersListerner As ListenerRegistration
	Dim UserName As String = ""
	Private Chat1 As Chat
	#if b4a
	Private ime As IME
	#End If
	Public authREST As FirebaseAuthREST
	Public authHELPER As FirebaseAuthRESTHelper
	Public projectID As String = "fir-tests-582fc"
	Dim dialog As B4XDialog
	Dim ChatDocID As String = "Group1"
	Dim ChatDocCollection As String = ""
	Dim Auth As Boolean = False
End Sub

Public Sub Initialize
	B4XPages.GetManager.LogEvents = True
	xui.SetDataFolder("chat")
	Key.Initialize(xui.DefaultFolder,"Chat1_demo")
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	B4XPages.SetTitle(Me,$"Chat Demo ${UserName}"$)
	authREST.Initialize
	authHELPER.Initialize(Me,"authHelper")
'	Root.SetLayoutAnimated(0,0,0,100%x,100%y)
'	Root.LoadLayout("chat")
	dialog.Initialize(Root)
	Dim path As PathBuilder
	path.Initialize
	path.Collection("chats").Document(ChatDocID).Collection("messages")
	ChatDocCollection = path.complete
	Chat1.Initialize(Root,Store,Me,ChatDocID)
	#if b4a	
	ime.Initialize("ime")
	ime.AddHeightChangedEvent
	CallSub2(FirebaseMessaging,"SubscribeToTopics",Array As String("general"))
	#End If
End Sub

Sub IME_HeightChanged (NewHeight As Int, OldHeight As Int)
	Chat1.HeightChanged(NewHeight)
End Sub
Private Sub B4XPage_KeyboardStateChanged (Height As Float)
'	If Height = 0 Then
'		Chat1.HeightChanged(Root.Height)
'	Else
'		Chat1.HeightChanged(Root.Height - Height) 'can ignore safe area
'	End If
End Sub
#if b4i
Private Sub B4XPage_Resize (Width As Int, Height As Int)
	Dim r As Rect = B4XPages.GetNativeParent(Me).SafeAreaInsets
	Root.SetLayoutAnimated(0, r.Left, r.Top, Width - r.Right - r.Left, Height - r.Bottom - r.Top)
End Sub
#End If

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.
Private Sub Store_Ready
	GetUser
End Sub

Private Sub B4XPage_Background
	
End Sub

Private Sub B4XPage_Appear
	If Auth Then
		If Store.IsInitialized Then
			StartListen
		Else
			Store.Initialize("Store",Me,Key.Get("token"),"(default)",projectID)
		End If
	Else
		LogIn
	End If
End Sub

Private Sub B4XPage_Disappear
'	EndListen
End Sub

#Region AUTH
Sub LogIn
	Log("Login")
	authHELPER.GetAccessToken
End Sub

Private Sub authHelper_Authenticate
	Log("authHelper_Authenticate")
	Wait For (authREST.signInAnonymously(True)) complete (Data As Map)
	If Data.ContainsKey("idToken") Then
		Log(Data)
		Key.Put("token",Data.Get("idToken"))
		Key.Put("uid",Data.Get("localId"))
		Key.Put("refreshToken",Data.Get("refreshToken"))
		Store.Initialize("Store",Me,Data.Get("idToken"),"(default)",projectID)
		GetUser
		Auth = True
		authHelper_RefreshToken(Data.Get("refreshToken"))
	Else
		Log("ErrorCode: " & authREST.getErrorCode(Data))
		Log("ErrorMessage: " & authREST.getErrorMessage(Data))
		Log("Reason: " & authREST.getErrorMap(Data).Get("reason"))
		Log("Domain: " & authREST.getErrorMap(Data).Get("domain"))
		Log("Message: " & authREST.getErrorMap(Data).Get("message"))
	End If
End Sub

Private Sub authHelper_AccessTokenAvailable (Success As Boolean, Token As String)
	Log("farh_AccessTokenAvailable")
	Log("Success: " & Success)
	Log("Token: " & Token)
	If Success Then
		Key.Put("token",Token)
		Store.Initialize("Store",Me,Token,"(default)",projectID)
		Log("farh_AccessTokenAvailable")
		Auth = True
	End If
End Sub

Private Sub authHelper_RefreshToken(RefreshToken As String)
	Log("farh_RefreshToken not empty")
	Wait For (authREST.refreshToken("refresh_token",RefreshToken)) complete (Data As Map)
	If Data.Size > 0 Then
		Key.Put("token",Data.Get("id_token"))
		Key.Put("refreshToken",Data.Get("refresh_token"))
		Key.Put("uid",Data.Get("user_id"))
		Store.Initialize("Store",Me,Data.Get("id_token"),"(default)",projectID)
		Log("farh_RefreshToken")
		Auth = True
	End If
End Sub
#End Region

Sub GetUser
	Wait For(Store.GetDocument("users",Key.Get("uid"))) Complete(User As Map)
	Log(User)
	If User.IsInitialized And User.Size > 0 Then
		UserName = User.Get("user_name")
		StartListen
	Else
		SetupUser
	End If
End Sub

Sub SetupUser
	dialog.BackgroundColor = xui.Color_White
	dialog.ButtonsColor = xui.Color_White
	dialog.BorderColor = xui.Color_DarkGray
	dialog.ButtonsTextColor = 0xFF007DC3
	dialog.Title = "Enter your name"
	Dim input As B4XInputTemplate
	input.Initialize
	Dim TextColor As Int = 0xFF5B5B5B
	input.TextField1.TextColor = TextColor
	input.lblTitle.TextColor = TextColor
	input.SetBorderColor(TextColor, xui.Color_Red)
	Wait For(dialog.ShowTemplate(input,"DONE","","CANCEL")) Complete(Result As Int)
	If Result = xui.DialogResponse_Positive Then
		Dim UserData As Map
		UserData.Initialize
		UserData.Put("user_id",Key.Get("uid"))
'		UserData.Put("user_name","Claude")
		UserData.Put("user_name",input.Text)
		Wait For(Store.CreateDocument("users",Key.Get("uid"),UserData)) Complete(Data As Map)
		UserName = UserData.Get("user_name")
		Key.Put("user_name",UserName)
		StartListen
	End If
End Sub

Public Sub StartListen
	UsersListerner = Store.CollectionListen("users")
	ChatsListener = Store.CollectionListen(ChatDocCollection)
End Sub

Public Sub EndListen
	If UsersListerner.IsInitialized Then UsersListerner.Remove
	If ChatsListener.IsInitialized Then ChatsListener.Remove
End Sub

Private Sub Store_CollectionChanged(Data As Map)
	Log(Data)
	If Data.IsInitialized Then
		Select Data.Get("collection")
			Case "users"
				UpdateUsers(Data)
			Case ChatDocCollection
				UpdateChat(Data)
		End Select
	End If
End Sub
Sub UpdateChat(Data As Map)
'	Log("Collection changed: " & Data)
	If Data.IsInitialized Then
		Dim Params As Map = Data.Get("data")
'		Log(Params)
		Select Data.Get("type")
			Case "ADDED"
				Dim Right As Boolean = False
				If Params.Get("sender") == UserName Then
					Right = True
				End If
				Chat1.AddItem(Params.Get("message"),Params.Get("sender"), Right)
		End Select
	End If
End Sub

Sub UpdateUsers(Data As Map)
	Log(Data)
End Sub
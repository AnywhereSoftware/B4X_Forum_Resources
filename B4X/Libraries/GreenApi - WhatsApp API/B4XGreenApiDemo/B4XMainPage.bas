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


'B4A ide://run?file=%WINDIR%\System32\cmd.exe&Args=/c&Args=start&Args=..\..\B4A\B4XGreenApiDemo.b4a
'B4i ide://run?file=%WINDIR%\System32\cmd.exe&Args=/c&Args=start&Args=..\..\B4i\B4XGreenApiDemo.b4i
'B4J ide://run?file=%WINDIR%\System32\cmd.exe&Args=/c&Args=start&Args=..\..\B4J\B4XGreenApiDemo.b4j

'open project objects folder: ide://run?File=%WINDIR%\explorer.exe&Args=%PROJECT%\AutoBackups

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=B4XGreenApiDemov1.4.zip
#IgnoreWarnings: 9

'V1.0 Release
Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private toast As BCToast
	
	#region MenuDrawer
	Private Drawer As B4XDrawer
	Private HamburgerIcon As B4XBitmap
	Private xCLV As CustomListView
	Private Tree As CLVTree
	Private B4XImageView1 As B4XImageView
	#end region
	
	#If VersionFull
	Public greenApi As B4XGreenApi
	#Else
	Public greenApi As B4XGreenApiFree
	#End If
	
	Private greenApiUtils As B4XGreenApiUtils
	Private txtLog As B4XFloatTextField
	
	'****************** ID Tests ***********
'	Private groupId As String = "120363174694589173@g.us"
	Private groupId As String = "120363327869457378@g.us"
	Private participantChatId As String = "50582906083@c.us"
	
	Private idInstance As String = "7103XXXX1"
	Private apiTokenInstance As String= "6807c081dce14e3XXXXXXX973efd496e9e"
				
	Private dialog As B4XDialog
	Private preferenceDialog As PreferencesDialog
	
	Private Version As Double =  1.66
	Private Theme As String = "Light Theme"
	
	Private B4XImagePopup As B4XImageView
	Private lblTittle As B4XView
	Private thisCodeCountry As String
End Sub

Public Sub Initialize
	B4XPages.GetManager.LogEvents = True
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	#If B4j
	Drawer.Initialize(Me, "Drawer", Root, Root.Width * 0.45)
	#Else If B4A
	Drawer.Initialize(Me, "Drawer", Root, Root.Width * 0.75)
	#Else
	Drawer.Initialize(Me, "Drawer", Root, 300dip)
	#End If
	Drawer.CenterPanel.LoadLayout("MainPage")
	Drawer.LeftPanel.LoadLayout("layoutDrawer")
	
	HamburgerIcon = xui.LoadBitmapResize(File.DirAssets, "hamburger.png", 32dip, 32dip, True)
	B4XImageView1.Load(File.DirAssets, "logo.png")
		
	#if B4i
	Dim bb As BarButton
	bb.InitializeBitmap(HamburgerIcon, "hamburger")
	B4XPages.GetNativeParent(Me).TopLeftButtons = Array(bb)
	#Else If B4J
	Dim iv As ImageView
	iv.Initialize("imgHamburger")
	iv.SetImage(HamburgerIcon)
	Drawer.CenterPanel.AddView(iv, 2dip, 2dip, 32dip, 32dip)
	iv.PickOnBounds = True
	#end if
	
	Tree.Initialize(xCLV)
	Tree.DefaultHeight = 40dip
	
	CreateMenu
	SetFree
	B4XPages.SetTitle(Me, "B4XGreenApiDemo")
	
	xui.SetDataFolder("B4XGreenApiDemo")
	greenApi.Initialize(Me, "GreenApi", idInstance, apiTokenInstance, xui.DefaultFolder)
	greenApi.RequestTimeoutSeconds = 10
	greenApiUtils.Initialize
	LoadCountries
	dialog.Initialize(Root)
	dialog.Title = "B4XGreen Api"
	toast.Initialize(Root)
End Sub

Private Sub SetFree
	Dim frees As List = Array As String("Send Message", "Send File by Upload", "Forward Message", "QR", _
	 "Create Group", "Add Group Participant", "Check Whatsapp", "Get Avatar", "Logout", "Show Messages Queue", _
	 "Get WaSettings", "Archive Chat", "Get State lnstance", "Download File")
	Dim dats As List
	dats.Initialize
	
	For Each  MenuTree As CLVTreeItem In Tree.Root.Children
		Dim group As String = MenuTree.Text
		For Each  subMenu As CLVTreeItem In MenuTree.Children
			If frees.IndexOf(subMenu.Text) <> -1 Then
				subMenu.Image = xui.LoadBitmap(File.DirAssets, "trial.png")
			End If
		Next
	Next
End Sub

Private Sub LoadCountries
	Dim parser As CSVParser
	parser.Initialize
'	https://en.wikipedia.org/wiki/List_of_country_calling_codes#Alphabetical_order
	Dim table As List = parser.Parse(File.ReadString(File.DirAssets, "countries.csv"), ";", False)
	Dim countries As Map
	countries.Initialize
	For Each row() As String In table
		countries.Put(row(0), row(1))
	Next
	
	Try
		Dim country As String = FindCountry
		thisCodeCountry = countries.GetDefault(country, "505") '505 => Nicaragua code
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub GreenApi_Response(response As QueryResult)
	If response.Success Then
		txtLog.Text = $"
StatusCode = ${response.StatusCode}
GetString = ${response.GetString}
"$
	Else
		txtLog.Text = response.ErrorMessage
		xui.MsgboxAsync(response.ErrorMessage, "Error")
	End If
End Sub

#Region Drawer
#if B4J
Sub imgHamburger_MouseClicked (EventData As MouseEvent)
	Drawer.LeftOpen = True
End Sub
#else if B4i
Private Sub B4XPage_MenuClick (Tag As String)
	If Tag = "hamburger" Then
		Drawer.LeftOpen = Not(Drawer.LeftOpen)
	End If
End Sub
#end if

Private Sub CreateMenu
	Dim Menus As List= Array As String("Account", "Sending","Receiving","Journals", "Queue", "Groups", "Read mark", "Service method", "Statuses")
	For Each row As String In Menus
		Dim MenuTree As CLVTreeItem=Tree.AddItem(Tree.Root, row, Null,"")
		Select row
			Case "Account"
				Dim SubMenus As List = Array As String("Get Settings","Set Settings", "Get State lnstance", _
				 "Reboot", "Logout", "QR", "GetAuthorizationCode", "Set Profile Picture", "Get WaSettings")
				For Each row1 As String In SubMenus
					Tree.AddItem(MenuTree, row1, Null, Null)
				Next
				
			Case "Sending"
				Dim SubMenus As List = Array As String("Send Poll","Send Message","Send File by Upload", _
				 "Send File by URL", "Send Location", "Send Contact",  "Forward Message")
				For Each row1 As String In SubMenus
					Tree.AddItem(MenuTree, row1, Null, Null)
				Next
			Case "Receiving"
				Dim SubMenus As List = Array As String("Receive Incoming Notifications","Receive Notification", _
				 "Delete Notification", "Download File")
				For Each row1 As String In SubMenus
					Tree.AddItem(MenuTree, row1, Null, Null)
				Next
			Case "Journals"
				Dim SubMenus As List = Array As String("Get Chat History","Get Message", _
				 "Last Incoming Messages", "Last Outgoing Messages")
				For Each row1 As String In SubMenus
					Tree.AddItem(MenuTree, row1, Null, Null)
				Next
			Case "Queue"
				Dim SubMenus As List = Array As String("Show Messages Queue","Clear Messages Queue")
				For Each row1 As String In SubMenus
					Tree.AddItem(MenuTree, row1, Null, Null)
				Next
			Case "Groups"
				Dim SubMenus As List = Array As String("Create Group","Update GroupName", "Get GroupData", _
				"Add GroupParticipant", "Remove GroupParticipant", "Set GroupAdmin", "Remove Admin", "Set GroupPicture", "Leave Group")
				For Each row1 As String In SubMenus
					Tree.AddItem(MenuTree, row1, Null, Null)
				Next
			Case "Read mark"
				Dim SubMenus As List = Array As String("Read chat")
				For Each row1 As String In SubMenus
					Tree.AddItem(MenuTree, row1, Null, Null)
				Next
			Case "Service method"
				Dim SubMenus As List = Array As String("Check Whatsapp","Get Avatar", "Get Contacts", _
				"Get Contact Info", "Delete Message", "Archive Chat", "Unarchive Chat", "Set Disappearing Chat")
				For Each row1 As String In SubMenus
					Tree.AddItem(MenuTree, row1, Null, Null)
				Next
				
			Case "Statuses"
				Dim SubMenus As List = Array As String("Send Text Status","Send Voice Status", "Send Media Status", _
				"Get Outgoing Statuses ", "Get Incoming Statuses", "Get Status Statistic", "Delete Status")
				For Each row1 As String In SubMenus
					Tree.AddItem(MenuTree, row1, Null, Null)
				Next
				
			Case Else
				Log("**")
		End Select
	Next
	Tree.CollapseAll
	Tree.Refresh
End Sub

Private Sub B4XPage_CloseRequest As ResumableSub
	#if B4A
	'home button
    If Main.ActionBarHomeClicked Then
        Drawer.LeftOpen = Not(Drawer.LeftOpen)
        Return False
    End If
	'back key
    If Drawer.LeftOpen Then
        Drawer.LeftOpen = False
        Return False
    End If
    #end if
	Return True
End Sub

Private Sub B4XPage_Appear
	#if B4A
	Sleep(0)
	B4XPages.GetManager.ActionBar.RunMethod("setDisplayHomeAsUpEnabled", Array(True))
	Dim bd As BitmapDrawable
	bd.Initialize(HamburgerIcon)
	B4XPages.GetManager.ActionBar.RunMethod("setHomeAsUpIndicator", Array(bd))
	#End If
	
	Dim prefWidth As Int = IIf(xui.IsB4J, Root.Width * 0.4, Root.Width * 0.8)
	Dim prefHeight As Int = IIf(xui.IsB4J, Root.Height * 0.7, Root.Height * 0.9)
	preferenceDialog.Initialize(Root, "B4XGreenApiDemo", prefWidth, prefHeight)
	Sleep(1000)
	Drawer.LeftOpen = True
End Sub

Private Sub B4XPage_Disappear
	#if b4a
	B4XPages.GetManager.ActionBar.RunMethod("setHomeAsUpIndicator", Array(0))
	#end if
End Sub

Private Sub B4XPage_Resize (Width As Int, Height As Int)
	Drawer.Resize(Width, Height)
End Sub

Private Sub xCLV_ItemClick (Index As Int, Value As Object) 'Menu Clic
	txtLog.Text=""
	Dim item As CLVTreeItem = Value
	Dim parentItem As String= item.Parent.Text
	Dim childrenItem As String= item.Text
	Select	parentItem
		Case "Account"
			Select childrenItem
				Case "Get Settings"
					Wait For(GetSettings) Complete(res As Boolean)
					Log("GetSettings: "&res)
					If res Then	Drawer.LeftOpen = False
					
				Case "Set Settings"
					Wait For(SetSettings) Complete(res As Boolean)
					Log("SetSettings: "&res)
					If res Then	Drawer.LeftOpen = False
					
				Case "Get State lnstance"
					Wait For(GetStatelnstance) Complete(res As Boolean)
					Log("GetStatelnstance: "&res)
					If res Then	Drawer.LeftOpen = False
					
				Case "Reboot"
					Wait For(Reboot) Complete(res As Boolean)
					Log("Reboot: "&res)
					If res Then Drawer.LeftOpen = False
					
				Case "Logout"
					Wait For(Logout) Complete(res As Boolean)
					Log("Logout: "&res)
					If res Then Drawer.LeftOpen = False
					
				Case "QR"
					Wait For(GetQR) Complete(res As Boolean)
					Log("GetQR: "&res)
					If res Then Drawer.LeftOpen = False
					
				Case "GetAuthorizationCode"
					Wait For(GetAuthorizationCode) Complete(res As Boolean)
					Log("GetAuthorizationCode: "&res)
					If res Then	Drawer.LeftOpen = False
					
				Case "Set Profile Picture"
					Wait For(SetProfilePicture) Complete(res As Boolean)
					Log("SetProfilePicture: "&res)
					If res Then	Drawer.LeftOpen = False
					 
				Case "Get WaSettings"
					Wait For(GetWaSettings) Complete(res As Boolean)
					Log("GetWaSettings: "&res)
					If res Then Drawer.LeftOpen = False
			End Select
			
		Case "Sending"
			Select childrenItem
				Case "Send Poll"
					Wait For(SendPoll) Complete(res As Boolean)
					Log("SendPoll: "&res)
					If res Then	Drawer.LeftOpen = False
					
				Case "Send Message"
					Wait For(SendMessage) Complete(res As Boolean)
					Log("SendMessage: "&res)
					If res Then	Drawer.LeftOpen = False
											
				Case "Send File by Upload"
					Wait For(SendFilebyUpload) Complete(res As Boolean)
					Log("SendFilebyUpload: "&res)
					If res Then	Drawer.LeftOpen = False
					
				Case "Send File by URL"
					Wait For(SendFilebyURL) Complete(res As Boolean)
					Log("SendFilebyURL: "&res)
					If res Then	Drawer.LeftOpen = False
					
				Case "Send Location"
					Wait For(SendLocation) Complete(res As Boolean)
					Log("SendLocation: "&res)
					If res Then	Drawer.LeftOpen = False
					
				Case "Send Contact"
					Wait For(SendContact) Complete(res As Boolean)
					Log("SendContact: "&res)
					If res Then	Drawer.LeftOpen = False
					
				Case "Forward Message"
					Wait For(ForwardMessage) Complete(res As Boolean)
					Log("ForwardMessage: "&res)
					If res Then	Drawer.LeftOpen = False
			End Select
			
		Case "Receiving"
			Select childrenItem
				Case "Receive Incoming Notifications"
					Wait For(ReceiveIncomingNotifications) Complete(res As Boolean)
					Log("ReceiveIncomingNotifications: "&res)
					If res Then	Drawer.LeftOpen = False
					
				Case "Receive Notification"
					Wait For(ReceiveNotification) Complete(res As Boolean)
					Log("ReceiveNotification: "&res)
					If res Then	Drawer.LeftOpen = False
					
				Case "Delete Notification"
					Wait For(DeleteNotification) Complete(res As Boolean)
					Log("DeleteNotification: "&res)
					If res Then	Drawer.LeftOpen = False
					
				Case "Download File"
					Wait For(DownloadFile) Complete(res As Boolean)
					Log("DownloadFile: "&res)
					If res Then	Drawer.LeftOpen = False
			End Select
			
		Case "Journals"
			Select childrenItem
				Case "Get Chat History"
					Wait For(GetChatHistory) Complete(res As Boolean)
					Log("GetChatHistory: "&res)
					If res Then	Drawer.LeftOpen = False
					
				Case "Get Message"
					Wait For(GetMessage) Complete(res As Boolean)
					Log("GetMessage: "&res)
					If res Then	Drawer.LeftOpen = False
										
				Case "Last Incoming Messages"
					Wait For(LastIncomingMessages) Complete(res As Boolean)
					Log("LastIncomingMessages: "&res)
					If res Then	Drawer.LeftOpen = False
					
				Case "Last Outgoing Messages"
					Wait For( LastOutgoingMessages) Complete(res As Boolean)
					Log("LastOutgoingMessages: "&res)
					If res Then	Drawer.LeftOpen = False
			End Select
			
		Case "Queue"
			Select childrenItem
				Case "Show Messages Queue"
					Wait For(ShowMessagesQueue) Complete(res As Boolean)
					Log("ShowMessagesQueue: "&res)
					If res Then	Drawer.LeftOpen = False
				
				Case "Clear Messages Queue"
					Wait For(ClearMessagesQueue) Complete(res As Boolean)
					Log("ClearMessagesQueue: "&res)
					If res Then	Drawer.LeftOpen = False
					
			End Select
		Case "Groups"
			Select childrenItem
				Case "Create Group"
					Wait For(CreateGroup) Complete(res As Boolean)
					Log("CreateGroup: "&res)
					If res Then	Drawer.LeftOpen = False
				
				Case "Update GroupName"
					Wait For(UpdateGroupName) Complete(res As Boolean)
					Log("UpdateGroupName: "&res)
					If res Then	Drawer.LeftOpen = False
				
				Case "Get GroupData"
					Wait For(GetGroupData) Complete(res As Boolean)
					Log("GetGroupData: "&res)
					If res Then	Drawer.LeftOpen = False
				
				Case "Add GroupParticipant"
					Wait For(AddGroupParticipant) Complete(res As Boolean)
					Log("AddGroupParticipant: "&res)
					If res Then	Drawer.LeftOpen = False
					
				Case "Remove GroupParticipant"
					Wait For(RemoveGroupParticipant) Complete(res As Boolean)
					Log("RemoveGroupParticipant: "&res)
					If res Then	Drawer.LeftOpen = False
				
				Case "Set GroupAdmin"
					Wait For(SetGroupAdmin) Complete(res As Boolean)
					Log("SetGroupAdmin: "&res)
					If res Then	Drawer.LeftOpen = False
				
				Case "Remove Admin"
					Wait For(RemoveAdmin) Complete(res As Boolean)
					Log("RemoveAdmin: "&res)
					If res Then	Drawer.LeftOpen = False
				
				Case "Set GroupPicture"
					Wait For(SetGroupPicture) Complete(res As Boolean)
					Log("SetGroupPicture: "&res)
					If res Then	Drawer.LeftOpen = False
				
				Case "Leave Group"
					Wait For(LeaveGroup) Complete(res As Boolean)
					Log("LeaveGroup: "&res)
					If res Then	Drawer.LeftOpen = False
			End Select
			
		Case "Read mark"
			Select childrenItem
				Case "Read chat"
					Readchat
			End Select
			
		Case "Service method"
			Select childrenItem
				Case "Check Whatsapp"
					Wait For(CheckWhatsApp) Complete(res As Boolean)
					Log("CheckWhatsApp: "&res)
					If res Then	Drawer.LeftOpen = False
					
				Case "Get Avatar"
					Wait For(GetAvatar) Complete(res As Boolean)
					Log("GetAvatar: "&res)
					If res Then	Drawer.LeftOpen = False
					
				Case "Get Contacts"
					Wait For(GetContacts) Complete(res As Boolean)
					Log("GetContacts: "&res)
					If res Then	Drawer.LeftOpen = False
					
				Case "Get Contact Info"
					Wait For(GetContactInfo) Complete(res As Boolean)
					Log("GetContactInfo: "&res)
					If res Then	Drawer.LeftOpen = False
					
				Case "Delete Message"
					Wait For(DeleteMessage) Complete(res As Boolean)
					Log("DeleteMessage: "&res)
					If res Then	Drawer.LeftOpen = False
					
				Case "Archive Chat"
					Wait For(ArchiveChat) Complete(res As Boolean)
					Log("ArchiveChat: "&res)
					If res Then	Drawer.LeftOpen = False
					
				Case "Unarchive Chat"
					Wait For(UnarchiveChat) Complete(res As Boolean)
					Log("UnarchiveChat: "&res)
					If res Then	Drawer.LeftOpen = False
					
				Case "Set Disappearing Chat"
					Wait For(SetDisappearingChat) Complete(res As Boolean)
					Log("Set Disappearing Chat: "&res)
					If res Then	Drawer.LeftOpen = False
			End Select
			
		Case "Statuses"
			preferenceDialog.Title = childrenItem
			Select childrenItem
				Case "Send Text Status"
					Wait For(SendTextStatus) Complete(res As Boolean)
					Log("Send Text Status: "&res)
					If res Then	Drawer.LeftOpen = False
					
				Case "Send Voice Status"
					Wait For(SendVoiceStatus) Complete(res As Boolean)
					Log("Send Voice Status: "&res)
					If res Then	Drawer.LeftOpen = False
					
					
				Case "Send Media Status"
					Wait For(SendMediaStatus) Complete(res As Boolean)
					Log("Send Media Status: "&res)
					If res Then	Drawer.LeftOpen = False
					
					
				Case "Get Outgoing Statuses"
					Wait For(GetOutgoingStatuses) Complete(res As Boolean)
					Log("Get Outgoing Statuses: "&res)
					If res Then	Drawer.LeftOpen = False
					
				Case "Get Incoming Statuses"
					Wait For(GetIncomingStatuses) Complete(res As Boolean)
					Log("Get Incoming Statuses: "&res)
					If res Then	Drawer.LeftOpen = False
					
				Case "Get Status Statistic"
					Wait For(GetStatusStatistic) Complete(res As Boolean)
					Log("Get Status Statistic: "&res)
					If res Then	Drawer.LeftOpen = False
					
				Case "Delete Status"
					Wait For(DeleteStatus) Complete(res As Boolean)
					Log("Delete Status: "&res)
					If res Then	Drawer.LeftOpen = False
				
			End Select
	End Select
	
	'Parents (Account	Sending	Receiving Journals	Queue	Groups	Read mark	Service method)
'	Dim isParent As Boolean = parentItem.StartsWith("java.lang.Object") 
'	If Not(isParent) Then
'		xui.MsgboxAsync("Please wait...", "B4XGreenApi")
'		Drawer.LeftOpen = False
'	End If	
End Sub

#End Region

'Start Functions API
#Region API
#Region Account
Private Sub GetSettings As ResumableSub
	#If VersionFull
	
	ShowMessage("Get Settings", 1000)
	Wait For(greenApi.GetSettings) Complete(res As Map)
	If res.IsInitialized Then
		Dim markIncomingMessagesReadedOnReply As String = res.Get("markIncomingMessagesReadedOnReply")
		Dim keepOnlineStatus As String = res.Get("keepOnlineStatus")
		Dim outgoingWebhook As String = res.Get("outgoingWebhook")
		Dim outgoingMessageWebhook As String = res.Get("outgoingMessageWebhook")
		Dim deviceWebhook As String = res.Get("deviceWebhook")
		Dim pollMessageWebhook As String = res.Get("pollMessageWebhook")
		Dim proxyInstance As String = res.Get("proxyInstance")
		Dim webhookUrl As String = res.Get("webhookUrl")
		Dim stateWebhook As String = res.Get("stateWebhook")
		Dim sharedSession As String = res.Get("sharedSession")
		Dim countryInstance As String = res.Get("countryInstance")
		Dim delaySendMessagesMilliseconds As Int = res.Get("delaySendMessagesMilliseconds")
		Dim wid As String = res.Get("wid")
		Dim statusInstanceWebhook As String = res.Get("statusInstanceWebhook")
		Dim enableMessagesHistory As String = res.Get("enableMessagesHistory")
		Dim typeAccount As String = res.Get("typeAccount")
		Dim webhookUrlToken As String = res.Get("webhookUrlToken")
		Dim markIncomingMessagesReaded As String = res.Get("markIncomingMessagesReaded")
		Dim outgoingAPIMessageWebhook As String = res.Get("outgoingAPIMessageWebhook")
		Dim incomingWebhook As String = res.Get("incomingWebhook")
		Log("wid: " &wid)
	End If
	Return res.IsInitialized
	#Else
	Return False 'Only version free
	#End If
	
End Sub
Private Sub SetSettings As ResumableSub
	Dim res As Boolean = False
	#If VersionFull
	Dim webhookUrl As String = "https://mysite.ru" 'URL for sending notifications
	Dim webhookUrlToken As String = "mytoken" 'Access token to server notifications
	Dim delaySendMessagesMilliseconds As Int = 1000 'Message sending delay
	
'	**************** possible variants: yes,no ************
	Dim markIncomingMessagesReaded As String = "no" ' Mark incoming messages as read
	Dim markIncomingMessagesReadedOnReply As String = "no"   'Mark incoming messages as read when posting a message to the chat via API
	Dim outgoingWebhook As String="yes"  'Get notifications about outgoing messages sending/delivering/reading statuses
	Dim outgoingAPIMessageWebhook As String = "no" 'Get notifications about messages sent from API
	Dim stateWebhook As String = "no" 'Get notifications about the account authorization state change
	Dim incomingWebhook As String = "no" 'Get notifications about incoming messages and files
	Dim deviceWebhook As String ="no" 'Get notifications about the device (phone) And battery level
	Dim outgoingMessageWebhook As String = "no" 'Get notifications about messages sent from the phone
	Dim keepOnlineStatus As String = "no" 'Sets the 'Online' status for your account
	Dim pollMessageWebhook As String = "no" 'Get notifications about the creation of a poll and voting in the poll
	Dim incomingBlockWebhook As String = "no" 'Get notifications about adding a chat to the list of blocked contacts
'	*************** end ******************

	ShowMessage("Set Settings", 1000)
	Wait For(greenApi.SetSettings(webhookUrl, webhookUrlToken,delaySendMessagesMilliseconds,markIncomingMessagesReaded, _
	 markIncomingMessagesReadedOnReply,outgoingWebhook,outgoingMessageWebhook,outgoingAPIMessageWebhook, _
	 stateWebhook,incomingWebhook, deviceWebhook, keepOnlineStatus, pollMessageWebhook, incomingBlockWebhook)) Complete(Result As Boolean)
	Log("Set >"&Result)
	res = Result
	#End If
	Return res
End Sub

Private Sub GetStatelnstance As ResumableSub
	#If VersionFree or VersionFull
	ShowMessage("Get State lnstance", 1000)
	Wait For(greenApi.GetStateInstance) Complete(stateInstance As String)
'	************** Instances ***********
	'1) notAuthorized - Account Is Not authorized. For account authorization refer To Before you start section
	'2) authorized - Account Is authorized
	'3) blocked - Account banned
	'4) sleepMode - Account Is in Sleep mode. The state Is possible when the phone Is switched off. After the phone Is switched on, it may take up To 5 minutes For the account state To be changed To authorized.
	'5)	starting - The account Is in the process of starting up (service mode). An instance, server, Or instance in maintenance mode Is rebooting. It may take up To 5 minutes For the account state To be set To authorized.
	'6) yellowCard - Sending messages has been partially Or completely suspended on the account due To spamming activity
	Log("Instances: "&stateInstance)
	Return True
	#End If
	
End Sub

Private Sub Reboot As ResumableSub
	Dim res As Boolean = False
	#If VersionFull
	ShowMessage("Reboot account", 1000)
	Wait For(greenApi.Reboot) Complete(result As Boolean)
	Log(result)
	res = result
	#End If
	Return res
End Sub

Private Sub Logout As ResumableSub
	#If VersionFree or VersionFull
	ShowMessage("Logout.....", 1000)
	Wait For(greenApi.Logout) Complete(result As Boolean)
	Return result
	#End If

End Sub

Private Sub GetQR As ResumableSub
	#If VersionFree or VersionFull
	ShowMessage("Get QR Code", 1000)
	Wait For(greenApi.QR) Complete(Res As Map)
	If Res.IsInitialized Then
		'type, possible variants qrCode, error, alreadyLogged
		Dim resultType As String = Res.Get("type")
		If resultType="qrCode" Then
			Dim strBase64 As String = Res.Get("message")
			'required Base64EncodeDecodeImage library
'			https://www.b4x.com/android/forum/threads/b4x-library-base64-encode-decode-image-and-file-library.115033/			
			Dim image As B4XBitmap =	Base64EncodeDecodeImage.Base64StringToImage(strBase64)
			Wait For(ShowImageInB4XDialog("Authorize your Account", image)) Complete(Result As Boolean)
		End If
	End If
	Return Res.IsInitialized
	#End If
	
End Sub

Private Sub GetAuthorizationCode As ResumableSub
	#If VersionFull
	Dim itemCode As Map = CreateItem("Country Code", "Code", "Number", True)
	Dim itemPhoneNumber As Map = CreateItem("Phone number", "PhoneNumber", "Number", True)
	
	Dim	jsonString As String = GenerateStringJson(Array(itemCode, itemPhoneNumber))
	Dim Data As Map = CreateMap("Code": thisCodeCountry, "PhoneNumber": 87247837)
	preferenceDialog.Title = "Get Authorization Code"
	Wait For (ShowPopup(jsonString, Root.Height * 0.24, Data)) Complete(enterData As Map)
	If enterData.Size > 0 Then
		Dim code As String = enterData.GetDefault("Code","")
		Dim phoneNumber As String = enterData.GetDefault("PhoneNumber","")
		ShowMessage("Get Authorization Code by Phone Number", 1000)
		Wait For(greenApi.GetAuthorizationCode(code & phoneNumber)) Complete(Res As Map)
		If Res.IsInitialized Then
'		status	boolean	Status of code receipt, possible values are True, False.
			'True - code received successfully
			'False - an error occurred While receiving the code (Try again To receive the code)
			'code	string	Authorization cod
			Dim status As Boolean = Res.Get("status")
			If status Then
				Dim code As String = Res.Get("code")
				Log(code)
			End If
			
		End If
		Return Res.IsInitialized
	End If
	#End If
	Return False
End Sub

Private Sub SetProfilePicture As ResumableSub
	Dim setPicture As Boolean = False
	#If VersionFull
	Dim fileName As String = "avatarPrueba.jpeg"
	If File.Exists(xui.DefaultFolder, fileName) = False Then
		File.Copy(File.DirAssets, fileName, xui.DefaultFolder, fileName)
	End If
	Dim mime As String = greenApiUtils.GetMimeTypeByExtension("jpeg")
	ShowMessage("Set Profile Picture", 1000)
	Wait For(greenApi.SetProfilePicture(xui.DefaultFolder, fileName, mime)) Complete(res As Map)
	If res.IsInitialized Then
		setPicture = res.Get("setProfilePicture")
		Log("Result ? "& setPicture)
		Log(res.Get("urlAvatar"))
	End If
	#End If
	Return setPicture
End Sub

Private Sub GetWaSettings As ResumableSub
	#If VersionFree or VersionFull
	ShowMessage("Get WhatsApp Settings", 1000)
	Wait For(greenApi.GetWaSettings) Complete(result As Map)
	If result.IsInitialized Then
		Dim phone As String = result.Get("phone")
		Dim avatar As String = result.Get("avatar")
		Dim stateInstance As String = result.Get("stateInstance")
		Dim deviceId As String = result.Get("deviceId")
	
		Log("Device ID: "&deviceId)
		Log("Phone: "&phone)
		Log("Avatar: "&avatar)
	
'	 ************** Instances ***********
		'1) notAuthorized - Account Is Not authorized. For account authorization refer To Before you start section
		'2) authorized - Account Is authorized
		'3) blocked - Account banned
		'4) sleepMode - Account Is in Sleep mode. The state Is possible when the phone Is switched off. After the phone Is switched on, it may take up To 5 minutes For the account state To be changed To authorized.
		'5)	starting - The account Is in the process of starting up (service mode). An instance, server, Or instance in maintenance mode Is rebooting. It may take up To 5 minutes For the account state To be set To authorized.
		'6) yellowCard - Sending messages has been partially Or completely suspended on the account due To spamming activity
		Log("Instances: "&stateInstance)
	End If
	Return result.IsInitialized
	#End If	
End Sub
#End Region
#Region Sending
Private Sub SendMessage As ResumableSub
	#If VersionFree or VersionFull	
	Dim itemCode As Map = CreateItem("Country Code", "Code", "Number", True)
	Dim itemPhoneNumber As Map = CreateItem("Phone number", "PhoneNumber", "Number", True)
	Dim textMessage As Map = CreateItem("Message", "Message", "Multiline Text", True)
	Dim	jsonString As String = GenerateStringJson(Array(itemCode, itemPhoneNumber, textMessage))
	Dim Data As Map = CreateMap("Code": thisCodeCountry)
	preferenceDialog.Title = "Send Message"
	Wait For (ShowPopup(jsonString, Root.Height * 0.44, Data)) Complete(enterData As Map)
	If enterData.Size > 0 Then
		Dim code As String = enterData.GetDefault("Code","")
		Dim phoneNumber As String = enterData.GetDefault("PhoneNumber","")
		Dim Message As String = enterData.GetDefault("Message","")
		Dim chatId As String = code & phoneNumber & "@c.us" 'g.us for group
'		LogColor(code & phoneNumber, xui.Color_Blue)
		
		Dim quoteMessageId As String = ""
		Dim linkPreview As Boolean = False
		
		ShowMessage("Please wait, sending message, ...", 2000)
		Wait For(greenApi.SendMessage(chatId, Message, quoteMessageId, linkPreview)) Complete(idMessage As String)
		Log("Id Message Send >"& idMessage)
		Return True
	End If
	#End If
	Return False
End Sub


Private Sub SendPoll As ResumableSub
	#If VersionFull
	Dim quoteMessageId As String = ""
		
	Dim itemCode As Map = CreateItem("Country Code", "Code", "Number", True)
	Dim itemPhoneNumber As Map = CreateItem("Phone number", "PhoneNumber", "Number", True)
	Dim textMessage As Map = CreateItem("Message", "Message", "Multiline Text", True)
	Dim	jsonString As String = GenerateStringJson(Array(itemCode, itemPhoneNumber, textMessage))
	preferenceDialog.Title = "Send Poll"
	
	Dim Data As Map = CreateMap("Code": thisCodeCountry)
	preferenceDialog.Title = "Send Poll"
	Wait For (ShowPopup(jsonString, Root.Height * 0.44, Data)) Complete(enterData As Map)
	If enterData.Size > 0 Then
		Dim code As String = enterData.GetDefault("Code","")
		Dim phoneNumber As String = enterData.GetDefault("PhoneNumber","")
		Dim caption As String = enterData.GetDefault("Message","")
		Dim chatId As String = code & phoneNumber & "@c.us" 'g.us for group
'		LogColor(code & phoneNumber, xui.Color_Blue)

		dialog.Title = "Select colors to send"
		Dim optionShow As B4XListTemplate
		optionShow.Initialize
		optionShow.Options = Array("Green", "Red", "Blue", "Black", "Yellow")
		optionShow.AllowMultiSelection = True
	
		Wait For (dialog.ShowTemplate(optionShow, "OK", "", "CANCEL")) Complete (Result As Int)
		If Result = xui.DialogResponse_Cancel Then Return False
		If optionShow.SelectedItems.Size = 0 Then
			ShowMessage("Choose color, please...", 4000)
			Return False
		End If
		
		Dim ColorsList As List
		ColorsList.Initialize
		For Each opt As String In optionShow.SelectedItems
			ColorsList.Add(CreateMap("optionName": opt))
		Next
		
		dialog.Title = "Do you want to allow multiple responses?"
		optionShow.Options = Array("True", "False")
		optionShow.AllowMultiSelection = False
	
		Wait For (dialog.ShowTemplate(optionShow, "OK", "", "CANCEL")) Complete (Result As Int)
		If Result = xui.DialogResponse_Cancel Then Return False

		Dim multipleAnswers As Boolean = IIf(optionShow.SelectedItem = "True", True, False)
	
		ShowMessage("Please wait, sending poll, ...", 2000)
		Wait For(greenApi.SendPoll(chatId, caption, ColorsList, multipleAnswers, quoteMessageId)) Complete(idMessage As String)
		Log("Id Message Send >"& idMessage)
		Return True
	End If
	#End If
	Return False
End Sub

Private Sub SendFilebyUpload As ResumableSub
	#If VersionFree or VersionFull	
	Dim itemCode As Map = CreateItem("Country Code", "Code", "Number", True)
	Dim itemPhoneNumber As Map = CreateItem("Phone number", "PhoneNumber", "Number", True)
	Dim textMessage As Map = CreateItem("Message", "Message", "Multiline Text", True)
	Dim	jsonString As String = GenerateStringJson(Array(itemCode, itemPhoneNumber, textMessage))
	Dim Data As Map = CreateMap("Code": thisCodeCountry)
	preferenceDialog.Title = "Send File by Upload"
	
	Wait For (ShowPopup(jsonString, Root.Height * 0.44, Data)) Complete(enterData As Map)
	If enterData.Size > 0 Then
		Dim code As String = enterData.GetDefault("Code","")
		Dim phoneNumber As String = enterData.GetDefault("PhoneNumber","")
		Dim caption As String = enterData.GetDefault("Message","")
		Dim chatId As String = code & phoneNumber & "@c.us" 'g.us for group
		Dim quoteMessageId As String = ""
	
		Dim fileName As String = "image_test.jpeg"
		If File.Exists(xui.DefaultFolder, fileName) = False Then
			Wait For (File.CopyAsync(File.DirAssets, fileName, xui.DefaultFolder, fileName)) Complete (Success As Boolean)
		End If
		
		Dim fileNameChat As String =  "image_test.jpeg"
		ShowMessage("Please wait, sending file, ...", 2000)
		Wait For(greenApi.SendFileByUpload(chatId, caption, xui.DefaultFolder, fileName, fileNameChat, quoteMessageId)) Complete(res As Map)
		If res.IsInitialized Then
			Log(res.Get("idMessage"))
			Log(res.Get("urlFile"))
		End If
		Return res.IsInitialized
	End If
	#End If
	Return False
End Sub

Private Sub SendFilebyURL As ResumableSub
	#If VersionFull
	Dim itemCode As Map = CreateItem("Country Code", "Code", "Number", True)
	Dim itemPhoneNumber As Map = CreateItem("Phone number", "PhoneNumber", "Number", True)
	
	Dim	jsonString As String = GenerateStringJson(Array(itemCode, itemPhoneNumber))
	Dim Data As Map = CreateMap("Code": thisCodeCountry)
	preferenceDialog.Title = "Send File By URL"
	Wait For (ShowPopup(jsonString, Root.Height * 0.24, Data)) Complete(enterData As Map)
	If enterData.Size > 0 Then
		Dim code As String = enterData.GetDefault("Code","")
		Dim phoneNumber As String = enterData.GetDefault("PhoneNumber","")
		Dim chatId As String = code & phoneNumber & "@c.us" 'g.us for group
		
		Dim itemUrlFile As Map = CreateItem("File url", "urlFile", "Text", True)
		Dim itemPhoneNumber As Map = CreateItem("File name with extension", "fileNameChat", "Text", True)
		Dim itemMessage As Map = CreateItem("Message", "Message", "Multiline Text", True)
		
		Dim	jsonString As String = GenerateStringJson(Array(itemUrlFile, itemPhoneNumber, itemMessage))
		Dim Data2 As Map =CreateMap("urlFile" : "https://i.imgur.com/WPlYHR8", "fileNameChat": "image.png")
		preferenceDialog.Title = "File URL Information"
		
		Wait For (ShowPopup(jsonString, Root.Height * 0.4, Data2)) Complete(enterData2 As Map)
		If enterData2.Size > 0 Then
			Dim caption As String = enterData2.GetDefault("Message","")
			Dim urlFile As String = enterData2.GetDefault("urlFile","")
			Dim fileNameChat As String = enterData2.GetDefault("fileNameChat","")
			Dim quoteMessageId As String = ""
						
			ShowMessage("Please wait, sending file, ...", 2000)
			Wait For(greenApi.SendFileByUrl(chatId, urlFile, fileNameChat, caption, quoteMessageId)) Complete(idMessage As String)
			Log("Id Message Send >"& idMessage)
			Return True
		End If
		
	End If
	
	#End If
	Return False
End Sub

Private Sub SendLocation As ResumableSub
	#If VersionFull
	Dim itemCode As Map = CreateItem("Country Code", "Code", "Number", True)
	Dim itemPhoneNumber As Map = CreateItem("Phone number", "PhoneNumber", "Number", True)
	Dim	jsonString As String = GenerateStringJson(Array(itemCode, itemPhoneNumber))
	
	Dim Data As Map = CreateMap("Code": thisCodeCountry)
	preferenceDialog.Title = "Send Location"
	Wait For (ShowPopup(jsonString, Root.Height * 0.24, Data)) Complete(enterData As Map)
	If enterData.Size > 0 Then
		Dim code As String = enterData.GetDefault("Code","")
		Dim phoneNumber As String = enterData.GetDefault("PhoneNumber","")
		Dim chatId As String = code & phoneNumber & "@c.us" 'g.us for group
				
		Dim itemLatitude As Map = CreateItem("Location latitude", "Latitude", "Text", True)
		Dim itemLongitude As Map = CreateItem("Location longitude", "Longitude", "Text", True)
		Dim itemLocationName As Map = CreateItem("Location name", "LocationName", "Text", False)
		Dim itemAddress As Map = CreateItem("Address", "Address", "Text", False)
		
		Dim	jsonString As String = GenerateStringJson(Array(itemLocationName, itemAddress, itemLatitude, _
		 itemLongitude))
		 
		Dim Data2 As Map = CreateMap()
		
		preferenceDialog.Title = "Address Information"
		Wait For (ShowPopup(jsonString, Root.Height * 0.5, Data2)) Complete(enterData2 As Map)
		If enterData2.Size > 0 Then'
			Dim Latitude As String =  enterData2.GetDefault("Latitude","")
			Dim Longitude As String =  enterData2.GetDefault("Longitude","")
			Dim nameLocation As String =  enterData2.GetDefault("LocationName","")
			Dim Address As String =  enterData2.GetDefault("Address","")
		
			Dim quoteMessageId As String = ""
			
			ShowMessage("Please wait, sending location, ...", 2000)
			Wait For(greenApi.SendLocation(chatId, Latitude, Longitude, nameLocation, Address, quoteMessageId)) Complete(idMessage As String)
			Log("Id Message Send >"& idMessage)
			Return True
		End If
		
	End If
	
	#End If
	Return False
End Sub
Private Sub SendContact As ResumableSub
	#If VersionFull
	Dim itemCode As Map = CreateItem("Country Code", "Code", "Number", True)
	Dim itemPhoneNumber As Map = CreateItem("Phone number", "PhoneNumber", "Number", True)
	Dim	jsonString As String = GenerateStringJson(Array(itemCode, itemPhoneNumber))
	Dim Data As Map = CreateMap("Code": thisCodeCountry)
	preferenceDialog.Title = "Send Contact"
	
	preferenceDialog.Title = "Send Contact"
	Wait For (ShowPopup(jsonString, Root.Height * 0.24, Data)) Complete(enterData As Map)
	If enterData.Size > 0 Then
		Dim code As String = enterData.GetDefault("Code","")
		Dim phoneNumber As String = enterData.GetDefault("PhoneNumber","")
		Dim chatId As String = code & phoneNumber & "@c.us" 'g.us for group
	
		Dim itemPhoneContactNumber As Map = CreateItem("Phone Contact Number", "PhoneContactNumber", "Text", True)
		Dim itemCompany As Map = CreateItem("Company", "Company", "Text", False)
		Dim itemFirstName As Map = CreateItem("First Name", "FirstName", "Text", True)
		Dim itemMiddleName As Map = CreateItem("Middle Name", "MiddleName", "Text", False)
		Dim itemLastName As Map = CreateItem("Last Name", "LastName", "Text", True)
		
		Dim	jsonString As String = GenerateStringJson(Array(itemPhoneContactNumber, itemCompany, itemFirstName, _
		 itemMiddleName, itemLastName ))
		 
		Dim Data2 As Map = CreateMap("PhoneContactNumber": thisCodeCountry & "87247837") 'Format internacional number
		preferenceDialog.Title = "Contact Information"
		Wait For (ShowPopup(jsonString, Root.Height * 0.6, Data2)) Complete(enterData2 As Map)
		If enterData2.Size > 0 Then'
			Dim phoneContactNumber As String =  enterData2.GetDefault("PhoneContactNumber","")
			Dim name As String =  enterData2.GetDefault("FirstName","")
			Dim lastName As String =  enterData2.GetDefault("LastName","")
			Dim middleName As String =  enterData2.GetDefault("MiddleName","")
			Dim company As String =  enterData2.GetDefault("Company","")
	
			Dim contact As Map = CreateMap("phoneContact": phoneContactNumber, "firstName": name, _
	 "middleName" : middleName, "lastName": lastName, "company": company)
	
			Dim quotedMessageId As String = ""
			ShowMessage("Please wait, sending contact, ...", 2000)
			Wait For(greenApi.SendContact(chatId, contact, quotedMessageId)) Complete(idMessage As String)
			Log("Id Message Send >"& idMessage)
			Return True
		End If
	End If
	#End If
	Return False
End Sub

Private Sub ForwardMessage As ResumableSub
	#If VersionFree or VersionFull
	Dim itemCode As Map = CreateItem("Country Code", "Code", "Number", True)
	Dim itemPhoneNumber As Map = CreateItem("Phone number", "PhoneNumber", "Number", True)
	Dim	jsonString As String = GenerateStringJson(Array(itemCode, itemPhoneNumber))
	Dim Data As Map = CreateMap("Code": thisCodeCountry)
	preferenceDialog.Title = "Forward Message"
	Wait For (ShowPopup(jsonString, Root.Height * 0.24, Data)) Complete(enterData As Map)
	If enterData.Size > 0 Then
		Dim code As String = enterData.GetDefault("Code","")
		Dim phoneNumber As String = enterData.GetDefault("PhoneNumber","")
			
		Dim chatId As String = code & phoneNumber & "@c.us" 'g.us for group

		Dim input As B4XInputTemplate
		input.Initialize
		input.lblTitle = "Phone number or chat which the message is being forwarded"
		Wait For (dialog.ShowTemplate(input, "OK", "", "CANCEL")) Complete (Result As Int)
		If Result = xui.DialogResponse_Cancel Then Return False
		Dim chatIdFrom As String = input.Text& "@c.us" 'g.us for group
	
		input.lblTitle = "Input Message ID"
		Wait For (dialog.ShowTemplate(input, "OK", "", "CANCEL")) Complete (Result As Int)
		If Result = xui.DialogResponse_Cancel Then Return False
	
'	Dim messagesId As List = Array As String("BAE5BB6A0F89CA53","BAE592F2215B06AE")
		Dim messagesId As List = Array As String(input.Text)
	
		ShowMessage("Forward Message", 1000)
		Wait For(greenApi.ForwardMessages(chatId, chatIdFrom, messagesId)) Complete(Result2  As Map)
		Dim messages As List = Result2.Get("messages")
		For Each idMessage As String In messages
			Log("ID Message" & idMessage)
		Next
	End If
	Return True
	#End If
	
End Sub
#End Region
#Region Receiving
Private Sub ReceiveIncomingNotifications As ResumableSub
	#If VersionFull
	ShowMessage("Receive Incoming Notifications", 1000)
	Wait For(greenApi.ReceiveIncomingNotifications) Complete(result  As Boolean)'
	Log(result)
	Return result
	#Else
	Return False 'Only version free
	#End If
End Sub

Private Sub ReceiveNotification  As ResumableSub
	#If VersionFull
	ShowMessage("Receive Notification", 1000)
	Wait For(greenApi.ReceiveNotification) Complete(result  As Map)'
	If result.IsInitialized Then
		Dim receiptId As Int = result.Get("receiptId")
		Log(receiptId)
		Dim body As Map = result.Get("body")
		Dim idMessage As String = body.Get("idMessage")
		Dim timestamp As Int = body.Get("timestamp")
		Dim typeWebhook As String = body.Get("typeWebhook")
		
		Dim senderData As Map = body.Get("senderData")
		Dim senderName As String = senderData.Get("senderName")
		Dim chatId As String = senderData.Get("chatId")
		Dim mySender As String = senderData.Get("sender")
		
		Dim instanceData As Map = body.Get("instanceData")
		Dim wid As String = instanceData.Get("wid")
		Dim typeInstance As String = instanceData.Get("typeInstance")
		Dim mYidInstance As Int = instanceData.Get("idInstance")
		
		Dim messageData As Map = body.Get("messageData")
		Dim typeMessage As String = messageData.Get("typeMessage")
			
		Dim textMessageData As Map = messageData.Get("textMessageData")
		Dim textMessage As String = textMessageData.Get("textMessage")
	End If
	Return result.IsInitialized
	#Else
	Return False 'Only version free
	#End If	
End Sub

Private Sub DeleteNotification As ResumableSub
	#If VersionFull	
	Dim itemReceiptId As Map = CreateItem("Receipt id", "receiptId", "Number", True)
	Dim	jsonString As String = GenerateStringJson(Array(itemReceiptId))
	Dim Data As Map = CreateMap("receiptId": 1456)
	preferenceDialog.Title = "Delete Notification"
	Wait For (ShowPopup(jsonString, Root.Height * 0.24, Data)) Complete(enterData As Map)
	If enterData.Size > 0 Then
		Dim receiptId As Int = enterData.GetDefault("receiptId", 1456)
		ShowMessage("Delete Notification -> " &receiptId, 1000)
		Wait For(greenApi.DeleteNotification(receiptId)) Complete(result  As Boolean)
		Return result
	End If
	#End If
	Return False
End Sub
Private Sub DownloadFile As ResumableSub
	#If VersionFree or VersionFull
	Dim itemCode As Map = CreateItem("Country Code", "Code", "Number", True)
	Dim itemPhoneNumber As Map = CreateItem("Phone number", "PhoneNumber", "Number", True)
	Dim	jsonString As String = GenerateStringJson(Array(itemCode, itemPhoneNumber))
	Dim Data As Map = CreateMap("Code": thisCodeCountry)
	preferenceDialog.Title = "Download File"
	Wait For (ShowPopup(jsonString, Root.Height * 0.24, Data)) Complete(enterData As Map)
	If enterData.Size > 0 Then
		Dim code As String = enterData.GetDefault("Code","")
		Dim phoneNumber As String = enterData.GetDefault("PhoneNumber","")
			
		Dim chatId As String = code & phoneNumber & "@c.us" 'g.us for group
		Dim idMessage As String = "BAE553E8A8C2A3BD"
		ShowMessage("Download File, please wait...", 2000)
		Wait For(greenApi.DownloadFile(chatId, idMessage)) Complete(url As String)
		Log(url)
	End If
	Return True
	#End If
	
End Sub
#End Region
#Region Journals
Private Sub GetChatHistory As ResumableSub
	#If VersionFull
	Dim itemCode As Map = CreateItem("Country Code", "Code", "Number", True)
	Dim itemPhoneNumber As Map = CreateItem("Phone number", "PhoneNumber", "Number", True)
	Dim	jsonString As String = GenerateStringJson(Array(itemCode, itemPhoneNumber))
	Dim Data As Map = CreateMap("Code": thisCodeCountry)
	preferenceDialog.Title = "Get Chat History"
	Wait For (ShowPopup(jsonString, Root.Height * 0.24, Data)) Complete(enterData As Map)
	If enterData.Size > 0 Then
		Dim code As String = enterData.GetDefault("Code","")
		Dim phoneNumber As String = enterData.GetDefault("PhoneNumber","")
		Dim chatId As String = code & phoneNumber & "@c.us" 'g.us for group
		
		Dim itemCount As Map = CreateItem("Quantity of messages", "Count", "Number", True)
		Dim	jsonString As String = GenerateStringJson(Array(itemCount))
		Dim Data2 As Map = CreateMap("Count": 10)
	
		Wait For (ShowPopup(jsonString, Root.Height * 0.12, Data2)) Complete(enterData2 As Map)
		If enterData2.Size > 0 Then
			Dim count As Int = enterData2.GetDefault("Count", 10)
			ShowMessage("Reading Chat History", 1000)
			Wait For(greenApi.GetChatHistory(chatId, count)) Complete(result As List)
			If result.IsInitialized Then
				For Each item As Map In result
					Log(item)
				Next
				Return True
			End If
		End If
	End If
	#End If
	Return False
End Sub
Private Sub GetMessage As ResumableSub
	#If VersionFull
	Dim itemCode As Map = CreateItem("Country Code", "Code", "Number", True)
	Dim itemPhoneNumber As Map = CreateItem("Phone number", "PhoneNumber", "Number", True)
	Dim	jsonString As String = GenerateStringJson(Array(itemCode, itemPhoneNumber))
	
	Dim Data As Map = CreateMap("Code": thisCodeCountry)
	preferenceDialog.Title = "Get Message"
	Wait For (ShowPopup(jsonString, Root.Height * 0.24, Data)) Complete(enterData As Map)
	If enterData.Size > 0 Then
		Dim code As String = enterData.GetDefault("Code","")
		Dim phoneNumber As String = enterData.GetDefault("PhoneNumber","")
		Dim chatId As String = code & phoneNumber & "@c.us" 'g.us for group
		
		Dim idMessage As String = "D0BA8275777C40591F11ABC456D9E4CF"
		ShowMessage("Get Message from "&phoneNumber, 1000)
		Wait For(greenApi.GetMessage(chatId, idMessage)) Complete(res As Map)
		If res.IsInitialized Then
			Dim typeMessage As String = res.Get("typeMessage")
			Log(res)
			Return True
		End If
	End If
	
	#End If
	Return False
End Sub
Private Sub LastIncomingMessages As ResumableSub
	#If VersionFull
	Dim itemMinutes As Map = CreateItem("Minutes", "Minutes", "Number", True)
	Dim	jsonString As String = GenerateStringJson(Array(itemMinutes))
	Dim Data As Map = CreateMap("Minutes": 20)
	preferenceDialog.Title = "Last Incoming Messages"
	Wait For (ShowPopup(jsonString, Root.Height * 0.12, Data)) Complete(enterData As Map)
	If enterData.Size > 0 Then
		Dim minutes As String = enterData.GetDefault("Minutes", 20)
		ShowMessage("last incoming messages of the account", 1000)
		Wait For(greenApi.LastIncomingMessages(minutes)) Complete(res As List)
		If res.IsInitialized And res.Size > 0 Then
			For Each item As Map In res
				Log(item)
			Next
			Return True
		End If
	End If
	
	#End If
	Return False
End Sub
Private Sub LastOutgoingMessages As ResumableSub
	#If VersionFull
	Dim itemMinutes As Map = CreateItem("Minutes", "Minutes", "Number", True)
	Dim	jsonString As String = GenerateStringJson(Array(itemMinutes))
	Dim Data As Map = CreateMap("Minutes": 20)
	preferenceDialog.Title = "Last Outgoing Messages"
	Wait For (ShowPopup(jsonString, Root.Height * 0.12, Data)) Complete(enterData As Map)
	If enterData.Size > 0 Then
		Dim minutes As String = enterData.GetDefault("Minutes", 20)
		ShowMessage("last outgoing messages of the account", 1000)
		Wait For(greenApi.LastOutgoingMessages(minutes)) Complete(res As List)
		If res.IsInitialized And res.Size > 0 Then
			For Each item As Map In res
				Log(item)
			Next
			Return True
		End If
	End If
	#End If
	Return False
End Sub
#End Region
#Region Queue 
Private Sub ShowMessagesQueue As ResumableSub
	#If VersionFree or VersionFull
	ShowMessage("Show Messages Queue", 1000)
	Wait For(greenApi.ShowMessagesQueue) Complete(res As List)
	If res.IsInitialized And res.Size > 0 Then
		For Each item As Map In res
			Log(item)
		Next
	End If
	Return res.IsInitialized
#End If
	
End Sub
Private Sub ClearMessagesQueue As ResumableSub
	#If VersionFull
	ShowMessage("Clear Messages Queue", 1000)
	Wait For(greenApi.ClearMessagesQueue) Complete(res As Boolean)
	Return res
	#Else
	Return False 'Only version free
	#End If
End Sub
#End Region

#Region Groups
Private Sub CreateGroup  As ResumableSub
	#If VersionFree or VersionFull
	Dim chatIds As List = Array As String("50587247837@c.us","50582918908@c.us") 'Change
	Dim itemGroupName As Map = CreateItem("Group Name", "GroupName", "Text", True)
	Dim	jsonString As String = GenerateStringJson(Array(itemGroupName))
	Dim Data As Map = CreateMap("GroupName": "Group Test 1")
	preferenceDialog.Title = "Create Group"
	Wait For (ShowPopup(jsonString, Root.Height * 0.44, Data)) Complete(enterData As Map)
	If enterData.Size > 0 Then
		Dim groupName As String = enterData.Get("GroupName")
		ShowMessage("Create Group "&groupName, 1000)
		Wait For(greenApi.CreateGroup(groupName, chatIds)) Complete(result As Map)
		If result.IsInitialized Then
			Log(result.Get("created"))
			Log(result.Get("chatId")) 'groupID
			Log(result.Get("groupInviteLink"))
			
		End If
		Return result.IsInitialized
	End If
	#End If
	Return False
End Sub
Private Sub UpdateGroupName As ResumableSub
	#If VersionFull	
	Dim itemGroupName As Map = CreateItem("New Group Name", "GroupName", "Text", True)
	Dim	jsonString As String = GenerateStringJson(Array(itemGroupName))
	Dim Data As Map = CreateMap("GroupName": "Group Updated 2")
	preferenceDialog.Title = "Update Group Name"
	Wait For (ShowPopup(jsonString, Root.Height * 0.44, Data)) Complete(enterData As Map)
	If enterData.Size > 0 Then
		Dim groupName As String = enterData.Get("GroupName")
		ShowMessage("Update Group Name", 1000)
		Wait For(greenApi.UpdateGroupName(groupId, groupName)) Complete(result As Boolean)
		Return result
	End If
'	Return False
	#End If
	Return False
End Sub
Private Sub GetGroupData  As ResumableSub
	#If VersionFull
	ShowMessage("Get Group Data", 1000)
	Wait For(greenApi.GetGroupData(groupId)) Complete(result As Map)
	If result.IsInitialized Then
		Dim owner As String = result.Get("owner")
		Dim subjectTime As String = result.Get("subjectTime")
		Dim groupInviteLink As String = result.Get("groupInviteLink")
		Dim subject As String = result.Get("subject")
		Dim groupId As String = result.Get("groupId")
		Dim creation As Int = result.Get("creation")
		Dim participants As List = result.Get("participants")
		For Each colparticipants As Map In participants
			Dim isSuperAdmin As String = colparticipants.Get("isSuperAdmin")
			Dim id As String = colparticipants.Get("id")
			Log(id)
			Dim isAdmin As String = colparticipants.Get("isAdmin")
		Next
		Return True
	End If
	#End If
	Return False
End Sub
'*************** groupId, participantChatId are globals var ******
Private Sub AddGroupParticipant  As ResumableSub
	#If VersionFull
	ShowMessage("Add Group Participant", 1000)
	Wait For(greenApi.AddGroupParticipant(groupId, participantChatId)) Complete(result As Boolean)
	Return result
	#Else
	Return False 'Only version free
	#End If
End Sub
Private Sub RemoveGroupParticipant As ResumableSub
	#If VersionFull
	ShowMessage("Remove Group Participant", 1000)
	Wait For(greenApi.RemoveGroupParticipant(groupId, participantChatId)) Complete(result As Boolean)
	Return result
#Else
	Return False 'Only version free
	#End If
End Sub
Private Sub SetGroupAdmin As ResumableSub
	#If VersionFull
	ShowMessage("Set Group Admin", 1000)
	Wait For(greenApi.SetGroupAdmin(groupId, participantChatId)) Complete(result As Boolean)
	Return result
#Else
	Return False 'Only version free
	#End If
End Sub
Private Sub RemoveAdmin As ResumableSub
	#If VersionFull
	ShowMessage("Remove Admin", 1000)
	Wait For(greenApi.RemoveAdmin(groupId, participantChatId)) Complete(result As Boolean)
	Return result
#Else
	Return False 'Only version free
	#End If
End Sub
Private Sub SetGroupPicture As ResumableSub
	#If VersionFull	
	Dim fileName As String = "avatarPrueba.jpeg"
	If File.Exists(xui.DefaultFolder, fileName) = False Then
		File.Copy(File.DirAssets, fileName, xui.DefaultFolder, fileName)
	End If
	
	Dim mime As String = greenApiUtils.GetMimeTypeByExtension("jpeg")
	ShowMessage("Set Group Picture", 1000)
	Wait For(greenApi.SetGroupPicture(groupId, xui.DefaultFolder, fileName, mime)) Complete(result As Map)
	If result.IsInitialized Then
		Log(result.Get("setGroupPicture"))
		Log(result.Get("urlAvatar"))
		Log(result.Get("reason"))
	End If
	Return result.IsInitialized
#Else
	Return False 'Only version free
	#End If
End Sub

Private Sub LeaveGroup  As ResumableSub
	#If VersionFull
	ShowMessage("Leave Group", 1000)
	Wait For(greenApi.LeaveGroup(groupId)) Complete(result As Boolean)
	Return result
	#Else
	Return False 'Only version free
	#End If
	
End Sub
#End Region
#Region Read mark 
Private Sub Readchat As ResumableSub
	#If VersionFull
	Dim itemCode As Map = CreateItem("Country Code", "Code", "Number", True)
	Dim itemPhoneNumber As Map = CreateItem("Phone number", "PhoneNumber", "Number", True)
	Dim	jsonString As String = GenerateStringJson(Array(itemCode, itemPhoneNumber))
	Dim Data As Map = CreateMap("Code": thisCodeCountry)
	preferenceDialog.Title = "Read chat"
	Wait For (ShowPopup(jsonString, Root.Height * 0.24, Data)) Complete(enterData As Map)
	If enterData.Size > 0 Then
		Dim code As String = enterData.GetDefault("Code","")
		Dim phoneNumber As String = enterData.GetDefault("PhoneNumber","")
		Dim chatId As String = code & phoneNumber & "@c.us" 'g.us for group
		Dim idMessage As String = ""	 '	Id Message Send >BAE592F2215B06AE
		
		ShowMessage("Read chat", 1000)
		Wait For(greenApi.ReadChat(chatId, idMessage)) Complete(result As Boolean) 'Bug
		Log(result)
		Return True
	End If
	#End If
	Return False
End Sub
#End Region

#Region Service method 
Private Sub CheckWhatsApp As ResumableSub
	#If VersionFree or VersionFull
	Dim itemCode As Map = CreateItem("Country Code", "Code", "Number", True)
	Dim itemPhoneNumber As Map = CreateItem("Phone number", "PhoneNumber", "Number", True)
	Dim	jsonString As String = GenerateStringJson(Array(itemCode, itemPhoneNumber))
	Dim Data As Map = CreateMap("Code": thisCodeCountry)
	preferenceDialog.Title = "Check WhatsApp"
	Wait For (ShowPopup(jsonString, Root.Height * 0.24, Data)) Complete(enterData As Map)
	If enterData.Size > 0 Then
		Dim code As String = enterData.GetDefault("Code","")
		Dim phoneNumber As String = enterData.GetDefault("PhoneNumber","")
		Dim chatId As String = code & phoneNumber
		ShowMessage("Checking WhatsApp Account", 1500)
		Wait For(greenApi.checkWhatsApp(chatId)) Complete(res As Boolean)
		Return res
	End If
	#End If
	Return False
End Sub
Private Sub GetAvatar As ResumableSub
	#If VersionFree or VersionFull
	Dim itemCode As Map = CreateItem("Country Code", "Code", "Number", True)
	Dim itemPhoneNumber As Map = CreateItem("Phone number", "PhoneNumber", "Number", True)
	Dim	jsonString As String = GenerateStringJson(Array(itemCode, itemPhoneNumber))
	Dim Data As Map = CreateMap("Code": thisCodeCountry)
	preferenceDialog.Title = "Get Avatar"
	Wait For (ShowPopup(jsonString, Root.Height * 0.24, Data)) Complete(enterData As Map)
	If enterData.Size > 0 Then
		Dim code As String = enterData.GetDefault("Code","")
		Dim phoneNumber As String = enterData.GetDefault("PhoneNumber","")
		Dim chatId As String = code & phoneNumber & "@c.us" 'g.us for group
		
		ShowMessage("Reading avatar", 1500)
		Wait For(greenApi.GetAvatar(chatId)) Complete(Result As Map)
		If Result.IsInitialized Then
			Dim url As String = Result.Get("urlAvatar")
			Dim existsWhatsapp As String = Result.Get("existsWhatsapp")
			If existsWhatsapp= False Then Return False
'		Log("url: " & url )
			If url.Length > 0 Then

				Dim FileName As String = code & phoneNumber & ".jpg"
				Dim folder As String = xui.DefaultFolder
				Wait For(greenApiUtils.DownloadAndSaveFile(url, folder, FileName , 4)) Complete(Res As Boolean)
				If Res And File.Exists(folder, FileName) Then
					
					Dim image As B4XBitmap = xui.LoadBitmap(folder, FileName)
					Wait For(ShowImageInB4XDialog($"Avatar from ${phoneNumber}"$, image)) Complete(Res As Boolean)
					
					
				End If
				
			End If
		End If
		Return Result.IsInitialized
	End If
	#End If
	Return False
End Sub
Private Sub GetContacts As ResumableSub
	#If VersionFull
	ShowMessage("Reading contacts", 2000)
	Wait For(greenApi.GetContacts) Complete(Res As List)
	If Res.IsInitialized Then
		For Each item As Map In Res
'			 *************** name ***********
			'1) If the account Is recorded in the phonebook, Then we get the name from the book
			'2) If the account Is Not recorded in the phonebook, Then we get the name from WhatsApp account
			'3) If the account Is Not recorded in the phone book And WhatsApp account name Is Not assigned, Then we get an empty field

			' *************** type ***********
'			user - contact belongs to a user
'			group - contact is a group chat

			Dim value As Map = CreateMap("id": item.Get("id"), "type": item.Get("type"), "name": item.Get("name"))
			Log(value)
		Next
	End If
	Return Res.IsInitialized
	#Else
	Return False 'Only version free
	#End If
End Sub
Private Sub GetContactInfo As ResumableSub
	#If VersionFull
	Dim itemCode As Map = CreateItem("Country Code", "Code", "Number", True)
	Dim itemPhoneNumber As Map = CreateItem("Phone number", "PhoneNumber", "Number", True)
	Dim	jsonString As String = GenerateStringJson(Array(itemCode, itemPhoneNumber))
	
	Dim Data As Map = CreateMap("Code": thisCodeCountry)
	preferenceDialog.Title = "Get Contact Info"
	Wait For (ShowPopup(jsonString, Root.Height * 0.24, Data)) Complete(enterData As Map)
	If enterData.Size > 0 Then
		Dim code As String = enterData.GetDefault("Code","")
		Dim phoneNumber As String = enterData.GetDefault("PhoneNumber","")
		Dim chatId As String = code & phoneNumber & "@c.us" 'g.us for group
		
		ShowMessage("Reading contact information", 2000)
		Wait For(greenApi.GetContactInfo(chatId)) Complete(result As Map)
		If result.IsInitialized Then
			Log(result)
			Dim isArchive As String = result.Get("isArchive")
			Dim chatId As String = result.Get("chatId")
			Dim isMute As String = result.Get("isMute")
			Dim messageExpiration As Int = result.Get("messageExpiration")
			Dim description As String = result.Get("description")
			Log(description)
			Dim isDisappearing As String = result.Get("isDisappearing")
			Dim avatar As String = result.Get("avatar")
			Dim products As List = result.Get("products") 'WhatsApp Bussines
	
				
			For Each colproducts As Map In products
				Dim price As String = colproducts.Get("price")
				Dim imageUrls As Map = colproducts.Get("imageUrls")
				Dim requested As String = imageUrls.Get("requested")
				Dim original As String = imageUrls.Get("original")
			
				Dim nameProduct As String = colproducts.Get("name")
				Log(nameProduct)
				Dim descriptionProduct As String = colproducts.Get("description")
				Dim reviewStatus As Map = colproducts.Get("reviewStatus")
				Dim whatsapp As String = reviewStatus.Get("whatsapp")
				Dim id As String = colproducts.Get("id")
				Dim availability As String = colproducts.Get("availability")
				Dim isHidden As String = colproducts.Get("isHidden")
			Next
			
			Dim lastSeen As String = result.Get("lastSeen")
			Dim name As String = result.Get("name")
'		Log(name)
			Dim muteExpiration As String = result.Get("muteExpiration")
			Dim category As String = result.Get("category")
			Dim email As String = result.Get("email")
		End If
		Return result.IsInitialized
	End If
	#End If	
	Return False
End Sub
Private Sub DeleteMessage As ResumableSub
#If VersionFull
	Dim itemCode As Map = CreateItem("Country Code", "Code", "Number", True)
	Dim itemPhoneNumber As Map = CreateItem("Phone number", "PhoneNumber", "Number", True)
	Dim	jsonString As String = GenerateStringJson(Array(itemCode, itemPhoneNumber))
	Dim Data As Map = CreateMap("Code": thisCodeCountry)
	preferenceDialog.Title = "Delete Message"
	Wait For (ShowPopup(jsonString, Root.Height * 0.24, Data)) Complete(enterData As Map)
	If enterData.Size > 0 Then
		Dim code As String = enterData.GetDefault("Code","")
		Dim phoneNumber As String = enterData.GetDefault("PhoneNumber","")
		Dim chatId As String = code & phoneNumber & "@c.us" 'g.us for group
	
		Dim idMessage As String = "BAE5BB6A0F89CA53" 'Test ID
		ShowMessage("Delete message "&idMessage, 1000)
		Wait For(greenApi.DeleteMessage(chatId, idMessage)) Complete(result As Boolean)
		Return result
	End If
	#End If
	Return False
End Sub
Private Sub ArchiveChat As ResumableSub
	#If VersionFree or VersionFull	
	Dim itemCode As Map = CreateItem("Country Code", "Code", "Number", True)
	Dim itemPhoneNumber As Map = CreateItem("Phone number", "PhoneNumber", "Number", True)
	Dim	jsonString As String = GenerateStringJson(Array(itemCode, itemPhoneNumber))
	Dim Data As Map = CreateMap("Code": thisCodeCountry)
	preferenceDialog.Title = "Archive Chat"
	Wait For (ShowPopup(jsonString, Root.Height * 0.24, Data)) Complete(enterData As Map)
	If enterData.Size > 0 Then
		Dim code As String = enterData.GetDefault("Code","")
		Dim phoneNumber As String = enterData.GetDefault("PhoneNumber","")
		Dim chatId As String = code & phoneNumber & "@c.us" 'g.us for group
		ShowMessage("Archive chat from "&phoneNumber, 1000)
		Wait For(greenApi.ArchiveChat(chatId)) Complete(result  As Boolean)
		Log("Archived >"& result)
	End If
	Return True
	#End If
	
End Sub
Private Sub UnarchiveChat As ResumableSub
	Dim res As Boolean = False
	#If VersionFull	
	Dim itemCode As Map = CreateItem("Country Code", "Code", "Number", True)
	Dim itemPhoneNumber As Map = CreateItem("Phone number", "PhoneNumber", "Number", True)
	Dim	jsonString As String = GenerateStringJson(Array(itemCode, itemPhoneNumber))
	Dim Data As Map = CreateMap("Code": thisCodeCountry)
	preferenceDialog.Title = "Unarchive Chat"
	Wait For (ShowPopup(jsonString, Root.Height * 0.24, Data)) Complete(enterData As Map)
	If enterData.Size > 0 Then
		Dim code As String = enterData.GetDefault("Code","")
		Dim phoneNumber As String = enterData.GetDefault("PhoneNumber","")
		Dim chatId As String = code & phoneNumber & "@c.us" 'g.us for group
		ShowMessage("Unarchive Chat from "&phoneNumber, 1000)
		Wait For(greenApi.UnarchiveChat(chatId)) Complete(result  As Boolean)
		Log("Unarchived >"& result)
		res = result
	End If
	#End If
	Return res
End Sub
Private Sub SetDisappearingChat As ResumableSub
	#If VersionFull
	Dim itemCode As Map = CreateItem("Country Code", "Code", "Number", True)
	Dim itemPhoneNumber As Map = CreateItem("Phone number", "PhoneNumber", "Number", True)
	Dim	jsonString As String = GenerateStringJson(Array(itemCode, itemPhoneNumber))
	Dim Data As Map = CreateMap("Code": thisCodeCountry)
	preferenceDialog.Title = "Set Disappearing Chat"
	Wait For (ShowPopup(jsonString, Root.Height * 0.24, Data)) Complete(enterData As Map)
	If enterData.Size > 0 Then
		Dim code As String = enterData.GetDefault("Code","")
		Dim phoneNumber As String = enterData.GetDefault("PhoneNumber","")
			
		Dim chatId As String = code & phoneNumber & "@c.us" 'g.us for group
		LogColor(chatId, xui.Color_Blue)
		
		Dim ephemeralExpiration As String = "0"
		ShowMessage("Set Disappearing Chat", 1000)
		Wait For(greenApi.SetDisappearingChat(chatId,ephemeralExpiration)) Complete(result As Map)
		If result.IsInitialized Then
			Dim response_chatId As String = result.Get("chatId")
			Dim response_disappearingMessagesInChat As String = result.Get("disappearingMessagesInChat")
			Log(response_disappearingMessagesInChat)
			Dim response_ephemeralExpiration As Int = result.Get("ephemeralExpiration")
		End If
		Return True
	End If
	#End If
	Return False	
End Sub
#End Region
#Region Statuses
Private Sub SendTextStatus As ResumableSub
	#If VersionFull	
	Dim itemMessage As Map = CreateItem("Message", "Message", "Multiline Text", True)
	Dim itemBGColor As Map = CreateItem("Background color", "BGColor", "Color", False)
	
	Dim opcionesSFont As List = Array As String("SERIF","SANS_SERIF","NORICAN_REGULAR","BRYNDAN_WRITE",	"OSWALD_HEAVY")
	Dim itemSFont As Map = CreateItem2("Story font", "SFont", "Short Options", opcionesSFont, False)
	
	Dim itemContacts As Map = CreateItem("Contacts", "Contacts", "Multiline Text", False)
	
	Dim	jsonString As String = GenerateStringJson(Array(itemMessage, itemBGColor, itemSFont, itemContacts))
	Dim Data As Map = CreateMap("Contacts": thisCodeCountry&"87247837")
	preferenceDialog.Title ="Send Text Status"
	Wait For (ShowPopup(jsonString, Root.Height * 0.6, Data)) Complete(enterData As Map)
	If enterData.Size > 0 Then 'Si no cancelo
		Log(enterData)
		Dim	Message As String= enterData.GetDefault("Message","")
		Dim	BGColorHex As String= enterData.GetDefault("BGColor","#000000")
		BGColorHex = "#"&ColorToHex(BGColorHex)
		Log(BGColorHex)
		Dim	SFont As String= enterData.GetDefault("SFont","")
		Dim inputValues As String = enterData.GetDefault("Contacts","")
		Dim Contacts As List = GenerateContactList(inputValues)
		ShowMessage("Send Text Status", 2000)
		Wait For(greenApi.SendTextStatus(Message, BGColorHex, SFont, Contacts)) Complete(idMessage As String)
		Log(idMessage)
		Return True
	End If
	#End If
	Return False
End Sub
Private Sub SendVoiceStatus As ResumableSub
	#If VersionFull
	Dim itemFileUrl As Map = CreateItem("File url", "FileUrl", "Text", True)
	Dim itemFileExtension As Map = CreateItem("File name with extension", "FileExtension", "Text", True)
	Dim itemBGColor As Map = CreateItem("Background color", "BGColor", "Color", False)
	Dim itemContacts As Map = CreateItem("Contacts", "Contacts", "Multiline Text", False)
	
	Dim	jsonString As String = GenerateStringJson(Array(itemFileUrl, itemFileExtension, itemBGColor, itemContacts))
	Dim Data As Map = CreateMap("Contacts": thisCodeCountry&"87247837")
	
	preferenceDialog.Title = "Send Voice Status"
	Wait For (ShowPopup(jsonString, Root.Height * 0.6, Data)) Complete(enterData As Map)
	If enterData.Size > 0 Then 'Si no cancelo
		Log(enterData)
		Dim	FileUrl As String= enterData.GetDefault("FileUrl","")
		Dim	FileName As String= enterData.GetDefault("FileExtension","")
		Dim	BGColorHex As String= enterData.GetDefault("BGColor","#000000")
		BGColorHex = "#"&ColorToHex(BGColorHex)
		
		Dim inputValues As String = enterData.GetDefault("Contacts","")
		Dim Contacts As List = GenerateContactList(inputValues)
		ShowMessage("Send Voice Status", 2000)
		Wait For(greenApi.SendVoiceStatus(FileUrl, FileName, BGColorHex, Contacts)) Complete(idMessage As String)
		Log(idMessage)
		Return True
	End If
	
	#End If
	Return False
End Sub

Private Sub SendMediaStatus As ResumableSub
	#If VersionFull
	Dim itemFileUrl As Map = CreateItem("File url", "FileUrl", "Text", True)
	Dim itemFileExtension As Map = CreateItem("File name with extension", "FileExtension", "Text", True)
	Dim itemDescription As Map = CreateItem("Description", "Description", "Multiline Text", False)
	Dim itemContacts As Map = CreateItem("Contacts", "Contacts", "Multiline Text", False)
	
	Dim	jsonString As String = GenerateStringJson(Array(itemFileUrl, itemFileExtension, itemDescription, itemContacts))
	Dim Data As Map = CreateMap("Contacts": thisCodeCountry&"87247837")
	
	preferenceDialog.Title = "Send Media Status"
	Wait For (ShowPopup(jsonString, Root.Height * 0.6, Data)) Complete(enterData As Map)
	If enterData.Size > 0 Then 'Si no cancelo
		Log(enterData)
		Dim	FileUrl As String= enterData.GetDefault("FileUrl","")
		Dim	FileName As String= enterData.GetDefault("FileExtension","")
		Dim	Description As String= enterData.GetDefault("Description","")
		
		Dim inputValues As String = enterData.GetDefault("Contacts","")
		Dim Contacts As List = GenerateContactList(inputValues)
		ShowMessage("Send Media Status", 2000)
		Wait For(greenApi.SendMediaStatus(FileUrl, FileName, Description, Contacts)) Complete(idMessage As String)
		Log(idMessage)
		Return True
	End If
	#End If
	Return False
End Sub

Private Sub DeleteStatus As ResumableSub
	#If VersionFull
	Dim	jsonString As String = GenerateStringJson(Array(CreateItem("Message id", "MessageID", "Text", True)))
	Dim Data As Map = CreateMap()
	preferenceDialog.Title = "Delete Status"
	Wait For (ShowPopup(jsonString, Root.Height * 0.14, Data)) Complete(enterData As Map)
	If enterData.Size > 0 Then
		Dim	MessageID As String= enterData.GetDefault("MessageID","")
		ShowMessage("Delete Status", 1000)
		Wait For(greenApi.DeleteStatus(MessageID)) Complete(response As String)
		Log(response) 'Empty
		Return True
	End If
	#End If
	Return False
End Sub

Private Sub GetStatusStatistic As ResumableSub
	#If VersionFull
	Dim	jsonString As String = GenerateStringJson(Array(CreateItem("Message id", "MessageID", "Text", True)))
	Dim Data As Map = CreateMap()
	preferenceDialog.Title = "Get Status Statistic"
	Wait For (ShowPopup(jsonString, Root.Height * 0.14, Data)) Complete(enterData As Map)
	If enterData.Size > 0 Then
		Dim	MessageID As String= enterData.GetDefault("MessageID","")
		ShowMessage("Get Status Statistic", 1000)
		Wait For(greenApi.GetStatusStatistic(MessageID)) Complete(response As List)
		Log(response) 'List of maps
		Return True
	End If
	#End If
	Return False
End Sub

Private Sub GetIncomingStatuses As ResumableSub
	#If VersionFull
	Dim	jsonString As String = GenerateStringJson(Array(CreateItem("Minutes", "Minutes", "Number", True)))
	Dim Data As Map = CreateMap()
	preferenceDialog.Title = "Get Incoming Statuses"
	Wait For (ShowPopup(jsonString, Root.Height * 0.14, Data)) Complete(enterData As Map)
	If enterData.Size > 0 Then
		Dim	Minutes As String= enterData.GetDefault("Minutes","")
		ShowMessage("Get Incoming Statuses", 1000)
		Wait For(greenApi.GetIncomingStatuses(Minutes)) Complete(response As List)
		Log(response) 'List of maps
		Return True
	End If
	#End If
	Return False
End Sub
Private Sub GetOutgoingStatuses As ResumableSub
	#If VersionFull
	Dim	jsonString As String = GenerateStringJson(Array(CreateItem("Minutes", "Minutes", "Number", True)))
	Dim Data As Map = CreateMap()
	preferenceDialog.Title = "Get Outgoing Statuses"
	Wait For (ShowPopup(jsonString, Root.Height * 0.14, Data)) Complete(enterData As Map)
	If enterData.Size > 0 Then
		ShowMessage("Get Outgoing Statuses", 1000)
		Dim	Minutes As String= enterData.GetDefault("Minutes","")
		Wait For(greenApi.GetOutgoingStatuses(Minutes)) Complete(response As List)
		Log(response) 'List of maps
		Return True
	End If
	#End If
	Return False
End Sub
#End Region

#End Region
'End Functions API
'#End If
Private Sub xCLV_VisibleRangeChanged (FirstIndex As Int, LastIndex As Int)
	Tree.CLV_VisibleRangeChanged(FirstIndex, LastIndex)
End Sub

Private Sub btnClearLog_Click
	txtLog.Text=""
End Sub

Public Sub ShowMessage(message As String, DurationMs As Int)
	toast.pnl.RemoveViewFromParent
	Root.AddView(toast.pnl,0,0,0,0)
	toast.DurationMs = DurationMs
	toast.Show(message)
End Sub

Private Sub FindCountry As String
	#if B4A or B4J
	Dim jo As JavaObject
	jo = jo.InitializeStatic("java.util.Locale").RunMethod("getDefault", Null)
'	Return jo.RunMethod("getLanguage", Null)

'	Return jo.RunMethod("getCountry", Null) 'Code country
	Return jo.RunMethod("getDisplayCountry", Null) 'Name country
	#else if B4i
    Dim no As NativeObject
    Dim lang As String = no.Initialize("NSLocale") _
        .RunMethod("preferredLanguages", Null).RunMethod("objectAtIndex:", Array(0)).AsString
	If lang.Length > 2 Then lang = lang.SubString2(0, 2)
	Return lang
	#end if
End Sub
#Region AdditinalFunctions
Private Sub ColorToHex(clr As Int) As String
	Dim bc As ByteConverter
	Return bc.HexFromBytes(bc.IntsToBytes(Array As Int(clr)))
End Sub

Private Sub GenerateContactList(inputValuesList As String) As List
	Dim newList As List
	newList.Initialize
	Dim Contacts As List = Regex.Split(Chr(10), inputValuesList) 'Separed by Enter
	For Each item As String In Contacts
		Dim newItem As String = item.Trim&"@c.us"
		If item.Trim.Length>0 Then
			newList.Add(newItem)
		End If
	Next
	Return newList
End Sub

Private Sub ShowPopup(jsonString As String, height As Int, Data As Map) As ResumableSub
	preferenceDialog.Clear
	preferenceDialog.mBase.Height = height
	preferenceDialog.LoadFromJson(jsonString)
'	Dim Data As Map = CreateMap()
	Wait For (preferenceDialog.ShowDialog(Data, "OK", "CANCEL")) Complete (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		Return Data
	Else
		Return CreateMap ()
	End If
	
End Sub

Private Sub GenerateStringJson(listOfMaps As List) As String
	Dim m As Map
	m.Initialize
	m.Put("Version",Version)
	m.Put("Theme",Theme)
	m.Put("Items",listOfMaps)
	Return m.As(JSON).ToString
End Sub

Private Sub CreateItem(title As String,key As String,  mType As String, required As Boolean) As Map
	Dim m As Map
	m.Initialize
	m.Put("title",title)
	m.Put("type",mType)
	m.Put("key", key)
	m.Put("required",required)
	Return m
End Sub

Private Sub CreateItem2(title As String,key As String,  mType As String, options As List, required As Boolean) As Map
	Dim m As Map
	m.Initialize
	m.Put("title",title)
	m.Put("type",mType)
	m.Put("key", key)
	m.Put("options", options)
	m.Put("required",required)
	Return m
End Sub

Private Sub ShowImageInB4XDialog(Title As String, Image As B4XBitmap) As ResumableSub
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, 350dip, 350dip)
	p.LoadLayout("CustomDialogImage")
	
	lblTittle.Text = Title
	B4XImagePopup.Bitmap = Image
	
	dialog.PutAtTop = True 'put the dialog at the top of the screen
	Wait For (dialog.ShowCustom(p, "OK", "", "CANCEL")) Complete (Result As Int)
	Return True
End Sub
#End Region
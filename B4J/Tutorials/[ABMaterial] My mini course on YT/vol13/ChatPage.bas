B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.5
@EndOfDesignText@
'Class module
Sub Class_Globals
	Private ws As WebSocket 'ignore
	' will hold our page information
	Public page As ABMPage
	' page theme
	Private theme As ABMTheme
	' to access the constants
	Private ABM As ABMaterial 'ignore	
	' name of the page, must be the same as the class name (case sensitive!)
	Public Name As String = "ChatPage"  '<-------------------------------------------------------- IMPORTANT
	' will hold the unique browsers window id
	Private ABMPageId As String = ""
	' your own variables	
	Private ChatName As String
	Private userchat As String
	Private idchat As String
	Private client As MqttClient
	Private serializator As B4XSerializator
	Private currentName As String
	Private jestchat As Boolean
	Private connected as Boolean
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	' build the local structure IMPORTANT!
	BuildPage		
End Sub

#Region ABM
Private Sub WebSocket_Connected (WebSocket1 As WebSocket)	
	Log("Connected")
		
	ws = WebSocket1		
	Dim params As Map = ws.UpgradeRequest.ParameterMap
	If params.IsInitialized And params.Size>1 Then
		Dim p(0) As String = params.Get("chat")
		Dim s(0) As String = params.Get("user")
		idchat = p(0)
		userchat = s(0)
		jestchat = True
	Else
		jestchat = False
	End If
	
	
	
	ABMPageId = ABM.GetPageID(page, Name,ws)
	
	Dim session As HttpSession = ABM.GetSession(ws, ABMShared.SessionMaxInactiveIntervalSeconds)
	If session.IsNew Then
		session.Invalidate
		ABMShared.NavigateToPage(ws, "", "./")
		Return
	End If
		
	If ABMShared.NeedsAuthorization Then
		If session.GetAttribute2("IsAuthorized", "") = "" Then
			ABMShared.NavigateToPage(ws, ABMPageId, "../")
			Return
		End If
	End If		
	ABM.UpdateFromCache(Me, ABMShared.CachedPages, ABMPageId, ws)		
	If page.ComesFromPageCache Then
    	' when we have a page that is cached it doesn't matter if it comes or not from a new connection we serve the cached version.
		Log("Comes from cache")		
    	page.Refresh		
    	page.FinishedLoading		
	Else
    	If page.WebsocketReconnected Then
			Log("Websocket reconnected")
        	' when we have a client that doesn't have the page in cache and it's websocket reconnected and also it's session is new - basically when the client had internet problems and it's session (and also cache) expired before he reconnected so the user has content in the browser but we don't have any on the server. So we need to reload the page.
        	' when a client that doesn't have the page in cache and it's websocket reconnected but it's session is not new - when the client had internet problems and when he reconnected it's session was valid but he had no cache for this page we need to reload the page as the user browser has content, reconnected but we have no content in cache
        	ABMShared.NavigateToPage (ws, ABMPageId, "./" & page.PageHTMLName)
    	Else
        	' when the client did not reconnected it doesn't matter if the session was new or not because this is the websockets first connection so no dynamic content in the browser ... we are going to serve the dynamic content...
        	Log("Websocket first connection")
			page.Prepare
			ConnectPage			
    	End If
	End If
	Log(ABMPageId)		
End Sub

Private Sub WebSocket_Disconnected
	Log("Disconnected")
	SendMessage(userchat & " is offline")
	client.Close	
End Sub

Sub Page_ParseEvent(Params As Map)
	Dim eventName As String = Params.Get("eventname")
	Dim eventParams() As String = Regex.Split(",",Params.Get("eventparams"))
	
	'log(eventName)
	
	If eventName = "beforeunload" Then
		Log("preparing for url refresh")
		ABM.RemoveMeFromCache(ABMShared.CachedPages, ABMPageId)
		Return
	End If
	Dim caller As Object = page.GetEventHandler(Me, eventName)
	If caller = Me Then
		If SubExists(Me, eventName) Then
			Params.Remove("eventname")
			Params.Remove("eventparams")
			If eventName = "page_dropped" Then
				page.ProcessDroppedEvent(Params)
			End If
			Select Case Params.Size
				Case 0
					CallSub(Me, eventName)
				Case 1
					CallSub2(Me, eventName, Params.Get(eventParams(0)))
				Case 2
					If Params.get(eventParams(0)) = "abmistable" Then
						Dim PassedTables As List = ABM.ProcessTablesFromTargetName(Params.get(eventParams(1)))
						CallSub2(Me, eventName, PassedTables)
					Else
						CallSub3(Me, eventName, Params.Get(eventParams(0)), Params.Get(eventParams(1)))
					End If
				Case Else
					' cannot be called directly, to many param
					CallSub2(Me, eventName, Params)
			End Select
		End If
	Else
		CallSubDelayed2(caller, "ParseEvent", Params) 'ignore
	End If
End Sub

public Sub BuildTheme()
	' start with the base theme defined in ABMShared
	theme.Initialize("pagetheme")
	theme.AddABMTheme(ABMShared.MyTheme)

	' add your specific page themes
	theme.AddLabelTheme("tyt")
	theme.Label("tyt").BackColor = ABM.COLOR_TRANSPARENT
	theme.Label("tyt").ForeColor = ABM.COLOR_YELLOW
	theme.Label("tyt").Align = ABM.ICONALIGN_CENTER
	
	theme.AddContainerTheme("pan1")
	theme.Container("pan1").ZDepth = ABM.ZDEPTH_3
	theme.Container("pan1").BackColor = ABM.COLOR_BLACK
	
	theme.AddInputTheme("inp")
	theme.Input("inp").Bold = True
	theme.Input("inp").ForeColor = ABM.COLOR_WHITE
	theme.Input("inp").InputColor = ABM.COLOR_WHITE
	
End Sub

public Sub BuildPage()
	' initialize the theme
	BuildTheme
	
	' initialize this page using our theme
	page.InitializeWithTheme(Name, "/ws/" & ABMShared.AppName & "/" & Name, False, ABMShared.SessionMaxInactiveIntervalSeconds, theme)
	page.ShowLoader=True
	page.PageHTMLName = "index.html"
	page.PageTitle = "Chat"
	page.PageDescription = "Chat"
	page.PageKeywords = ""
	page.PageSiteMapPriority = ""
	page.PageSiteMapFrequency = ABM.SITEMAP_FREQ_YEARLY
		
	page.ShowConnectedIndicator = True
				
	' adding a navigation bar
	' ABMShared.BuildNavigationBar(page, "My Page","../images/logo.png", "", "", "")	
			
	' create the page grid
'	page.AddRowsM(2,True,20,0, "").AddCells12MP(1,0,0,0,0,"")
	page.AddRows(1, True, "").AddCellsOS(1,0,0,3,12,12,6,"")
	
	page.BuildGrid 'IMPORTANT once you loaded the complete grid AND before you start adding components		
	page.Cell(1,1).SetFixedHeightFromBottom(120,False)
	page.DisablePageReloadOnSwipeDown = True
End Sub

public Sub ConnectPage()
	'	connecting the navigation bar
	' ABMShared.ConnectNavigationBar(page)
	
	If jestchat Then
		page.Cell(1,1).AddComponent(oknoChat)
		ConnectToMQTT("127.0.0.1","1313",userchat)
	Else
		page.Msgbox("er","Sorry :(","","ok", False, ABM.MSGBOX_POS_CENTER_CENTER,"")
	End If
	
	' refresh the page
	page.Refresh
	
	' Tell the browser we finished loading
	page.FinishedLoading
	' restoring the navigation bar position
	page.RestoreNavigationBarPosition
End Sub
#end region

Sub oknoChat As ABMContainer
	Dim p As ABMContainer
	p.Initialize(page, "oknochat","pan1")
	p.AddRowsM(3, True, 0,0,"").AddCells12(1,"")
	p.BuildGrid
	p.MarginTop = "30px"
	Dim la As ABMLabel
	la.Initialize(page, "la", "Welcome", ABM.SIZE_H5, True, "tyt")
	p.Cell(1,1).AddComponent(la)
	
	Dim Chat As ABMChat
	Chat.Initialize(page, "conversation", 400, 440, 400, "")
	Chat.SetMyFrom(userchat)
	Chat.AddBubble("Server", "Welcome", "Server", "","")
	Chat.IsTextSelectable = False
	p.Cell(2,1).AddComponent(Chat)
	
	Dim ChatInput As ABMInput
	ChatInput.Initialize(page, "ChatInput", ABM.INPUT_TEXT, "",False,"inp")
	ChatInput.PlaceHolderText = "... (Enter)"
	ChatInput.RaiseChangedEvent = True
	p.Cell(2,1).AddComponent(ChatInput)
	
	Dim opis As ABMLabel
	opis.Initialize(page, "opis", "Sepport Chat", ABM.SIZE_H6, True, "tyt")
	p.Cell(3,1).AddComponent(opis)
	
	Return p
End Sub

Sub ConnectToMQTT(host As String, port As String, MQTTuser As String)
	Disconnect
	currentName = MQTTuser
	client.Initialize("client", $"tcp://${host}:${port}"$,MQTTuser)
	Dim mo As MqttConnectOptions
	mo.Initialize("asdfgh","12345")
	client.Connect2(mo)
End Sub


Sub client_MessageArrived (Topic As String, Payload() As Byte)
	Dim receivedObject As Object = serializator.ConvertBytesToObject(Payload)
	If Topic = idchat Then
		Log("Message chat-> "&receivedObject)
		Dim json As JSONParser
		json.Initialize(receivedObject)
		Dim data As Map = json.NextObject
		If data.Get("user") <> currentName Then
			Dim p As ABMContainer = page.Component("oknochat")
			Dim chat As ABMChat = p.Component("conversation")
			chat.AddBubble(data.Get("user"), data.Get("message"), data.Get("user")&" " & DateTime.Time(DateTime.Now), "" ,"")
			chat.Refresh
			chat.ScrollToBottom
		End If
		
	End If
End Sub

Sub Disconnect
	If connected Then
		connected= False
		client.Close
	End If
End Sub


Sub client_Connected(Success As Boolean)
	Log("Connect: "&Success)
	If Success Then
		connected= True
		client.Subscribe(idchat,0)
		'send message
		SendMessage(userchat & " is online")
		Log("Connect:"&currentName& " Chat:"&idchat)
	Else
		Log("Error connecting: "&LastException)
	End If
End Sub

Sub SendMessage(BodyMessage As String)
	If connected Then
		Dim out As Map = CreateMap("user":userchat, "message":BodyMessage)
		Dim j As JSONGenerator
		j.Initialize(out)
		Try
			client.Publish2(idchat, serializator.ConvertObjectToBytes(j.ToString), 0, False)
		Catch
			Log(LastException)
			page.ShowToast("er", "","Connection lost", 2000, False)
		End Try
	End If
End Sub

Sub ChatInput_EnterPressed(value As String)
	Dim p As ABMContainer = page.Component("oknochat")
	Dim chat As ABMChat = p.Component("conversation")
	
	DateTime.TimeFormat ="HH:mm"
	Dim bubble As ABMChatBubble
	bubble.Initialize(ChatName, value, ChatName&" " & DateTime.Time(DateTime.Now), "","")
	chat.AddBubble2(bubble)
	chat.Refresh
	chat.ScrollToBottom
	
	SendMessage(value)
	
	Dim input As ABMInput = p.Component("ChatInput")
	input.Text = ""
	input.Refresh
End Sub

#Region ABMPage
' clicked on the navigation bar
Sub Page_NavigationbarClicked(Action As String, Value As String)
	' saving the navigation bar position
	page.SaveNavigationBarPosition
	If Action = "LogOff" Then
		ABMShared.LogOff(page)
		Return
	End If

	ABMShared.NavigateToPage(ws, ABMPageId, Value)
End Sub

Sub Page_DebugConsole(message As String)
	Log("---> " & message)
End Sub
#end region


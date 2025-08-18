B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=5.9
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
	Public Name As String = "ABMPageTemplateAlternative"  '<-------------------------------------------------------- IMPORTANT
	' will hold the unique browsers window id
	Private ABMPageId As String = ""
	' your own variables
	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	' build the local structure IMPORTANT!
	' start with the base theme defined in ABMShared
	theme.Initialize("pagetheme")
	theme.AddABMTheme(ABMShared.MyTheme)
	
	' add additional themes specific for this page
	
	' initialize this page using our theme
	page.InitializeWithTheme(Name, "/ws/" & ABMShared.AppName & "/" & Name, False, ABMShared.SessionMaxInactiveIntervalSeconds, theme)
	page.ShowLoader=True
	page.PageHTMLName = "index.html"
	page.PageTitle = ""
	page.PageDescription = ""
	page.PageKeywords = ""
	page.PageSiteMapPriority = ""
	page.PageSiteMapFrequency = ABM.SITEMAP_FREQ_YEARLY
	
	page.ShowConnectedIndicator = True
		
	' adding a navigation bar
	ABMShared.BuildNavigationBar(page, "Title","./images/logo.png", "", "", "")
			
	' create the page grid
	page.AddRows(1,True, "").AddCells12(1,"")
	page.BuildGrid 'IMPORTANT once you loaded the complete grid AND before you start adding components
End Sub

Private Sub WebSocket_Connected (WebSocket1 As WebSocket)	
	Log("Connected")
	ws = WebSocket1		
	ABMPageId = ABM.GetPageID(page, Name,ws)
	Dim session As HttpSession = ABM.GetSession(ws, ABMShared.SessionMaxInactiveIntervalSeconds)
	'----------------------START MODIFICATION 4.00-------------------------------
	If session.IsNew Then
		session.Invalidate
		ABMShared.NavigateToPage(ws, "", "./")
		Return
	End If
	'----------------------END MODIFICATION 4.00-------------------------------
	
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
			' Prepare the page 
			page.Prepare
			' load the dynamic content
		
			' connecting the navigation bar
			ABMShared.ConnectNavigationBar(page)
		
			' init all your own variables (like a List, Map) and add your components
			'	page.Cell(1,1).AddComponent(ABMShared.BuildParagraph(page, "lbl", "This is a test"))
			'	
			'	Dim btn As ABMButton
			'	btn.InitializeRaised(page, "btn", "", "", "Press me", "")
			'	page.Cell(2,1).AddComponent(btn)
		
			' refresh the page
			page.Refresh
			' Tell the browser we finished loading
			page.FinishedLoading
			' restoring the navigation bar position
			page.RestoreNavigationBarPosition
    	End If
	End If
	Log(ABMPageId)		
End Sub

Private Sub WebSocket_Disconnected
	Log("Disconnected")
End Sub

Sub Page_ParseEvent(Params As Map)
	Dim eventName As String = Params.Get("eventname")
	Dim eventParams() As String = Regex.Split(",",Params.Get("eventparams"))
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
			' BEGIN NEW DRAGDROP
			If eventName = "page_dropped" Then
				page.ProcessDroppedEvent(Params)
			End If
			' END NEW DRAGDROP
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

Sub Page_MsgboxResult(returnName As String, result As String)
	
End Sub

Sub Page_InputboxResult(returnName As String, result As String)
	
End Sub

Sub Page_DebugConsole(message As String)
	Log("---> " & message)
End Sub

Sub Page_FileUploaded(FileName As String, success As Boolean)
	
End Sub

Sub Page_ToastClicked(ToastId As String, Action As String)
		
End Sub

Sub Page_ToastDismissed(ToastId As String)
	
End Sub

Sub Page_Authenticated(Params As Map)
	
End Sub

Sub Page_FirebaseAuthError(extra As String)
	
End Sub

Sub Page_FirebaseAuthStateChanged(IsLoggedIn As Boolean)
	
End Sub

Sub Page_FirebaseStorageError(jobID As String, extra As String)
	
End Sub

Sub Page_FirebaseStorageResult(jobID As String, extra As String)
	
End Sub

Sub Page_ModalSheetDismissed(ModalSheetName As String)
	
End Sub

Sub Page_NextContent(TriggerComponent As String)
	
End Sub

Sub Page_SignedOffSocialNetwork(Network As String, Extra As String)
	
End Sub

Sub page_CellClicked(Target As String, RowCell As String)
	
End Sub

Sub page_RowClicked(Target As String, Row As String)
	
End Sub

Sub Page_NativeResponse(jsonMessage As String)
	
End Sub

Sub Page_NavigationbarSearch(search As String)
	
End Sub


B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.3
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
	Public Name As String = "Page6"  '<-------------------------------------------------------- IMPORTANT
	' will hold the unique browsers window id
	Private ABMPageId As String = ""
	' your own variables	
	
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
	theme.AddTabsTheme("tab")
	theme.Tabs("tab"). ZDepth = ABM.ZDEPTH_REMOVE
End Sub

public Sub BuildPage()
	' initialize the theme
	BuildTheme
	
	' initialize this page using our theme
	page.InitializeWithTheme(Name, "/ws/" & ABMShared.AppName & "/" & Name, False, ABMShared.SessionMaxInactiveIntervalSeconds, theme)
	page.ShowLoader=True
	page.PageHTMLName = "index.html"
	page.PageTitle = "Page Tabs"
	page.PageDescription = "Page Tabs"
	page.PageKeywords = ""
	page.PageSiteMapPriority = ""
	page.PageSiteMapFrequency = ABM.SITEMAP_FREQ_YEARLY
		
	page.ShowConnectedIndicator = True
				
	' adding a navigation bar
	ABMShared.BuildNavigationBar(page, "My Page Tabs","../images/logo.png", "", "", "")
	page.AddImageIcon("abm-metal-gear", "../images/metal-gear.png", 30,30,"","")
	page.AddImageIcon("abm-files-and-folders", "../images/files-and-folders.png", 30,30, "","")
	page.AddImageIcon("abm-boxes", "../images/boxes.png", 30,30, "","")
	page.AddImageIcon("abm-renewable-energy.png", "../images/renewable-energy.png",30,30,"","")
			
	' create the page grid
	page.AddRowsM(2,True,20,0, "").AddCells12MP(1,0,0,0,0,"")	
	
	page.BuildGrid 'IMPORTANT once you loaded the complete grid AND before you start adding components		
End Sub

public Sub ConnectPage()			
	'	connecting the navigation bar
	ABMShared.ConnectNavigationBar(page)
	
	Dim tabs As ABMTabs
	tabs.Initialize(page, "tabs", "tab")
	tabs.AddTab("tab1","ONE", AllContainers.leftW(page),3,3,3,12,12,12, True, True, "abm-renewable-energy.png","")
	tabs.AddTab("tab2","TWO", AllContainers.rightW(page), 3,3,3,12,12,12, True, False, "abm-boxes", "")
	tabs.AddTab("tab3","THREE", AllContainers.lista(page), 3,3,3,12,12,12, True, False, "abm-files-and-folders", "")
	tabs.AddTab("tab4","FOUR", AllContainers.rightW(page), 3,3,3,12,12,12, False, False, "abm-metal-gear", "")
	
	page.Cell(1,1).AddComponent(tabs)

	' refresh the page
	page.Refresh
	
	' Tell the browser we finished loading
	page.FinishedLoading
	' restoring the navigation bar position
	page.RestoreNavigationBarPosition	
End Sub
#end region

Sub input2_EnterPressed(value As String)
	Dim tabs As ABMTabs = page.Component("tabs")
	Dim p1 As ABMContainer = tabs.GetTabPage("tab1")
	Dim p2 As ABMContainer = tabs.GetTabPage("tab2")
	
	Dim label As ABMLabel = p1.Component("l2")
	label.Text = value
	label.Refresh
	Dim i As ABMInput = p2.Component("input2")
	i.Text = ""
	i.Refresh
	tabs.SetActive("tab1")
End Sub

Sub tabs_Clicked(TabReturnName As String)
	Dim tabs As ABMTabs = page.Component("tabs")
	Dim p1 As ABMContainer = tabs.GetTabPage("tab1")
	Dim label As ABMLabel = p1.Component("l2")
	If TabReturnName <> "tab4" Then Return
	If TabReturnName = "tab4" And label.Text="access" Then
		page.Msgbox("error", "Access to TAB4", "OK", "ok", False, ABM.MSGBOX_POS_CENTER_CENTER,"")
	Else
		
		page.Msgbox("error", "Not authorized", "Error", "ok", False, ABM.MSGBOX_POS_CENTER_CENTER,"")
	End If
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


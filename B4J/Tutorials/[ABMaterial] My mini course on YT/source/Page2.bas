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
	Public Name As String = "Page2"  '<-------------------------------------------------------- IMPORTANT
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
	theme.AddContainerTheme("left")
	theme.Container("left").ZDepth = ABM.ZDEPTH_1
	theme.Container("left").BackColor = ABM.COLOR_BLUEGREY
	
	theme.AddContainerTheme("right")
	theme.Container("right").ZDepth = ABM.ZDEPTH_1
	theme.Container("right").BackColor = ABM.COLOR_BLUE
	
	theme.AddInputTheme("inp")
	theme.Input("inp").Bold =True
	theme.Input("inp").PlaceholderColor = ABM.COLOR_BLACK
	theme.Input("inp").FocusForeColor = ABM.COLOR_BLACK
	
	theme.AddContainerTheme("window")
	theme.Container("window").ZDepth = ABM.ZDEPTH_2
End Sub

public Sub BuildPage()
	' initialize the theme
	BuildTheme
	
	' initialize this page using our theme
	page.InitializeWithTheme(Name, "/ws/" & ABMShared.AppName & "/" & Name, False, ABMShared.SessionMaxInactiveIntervalSeconds, theme)
	page.ShowLoader=True
	page.PageHTMLName = "index.html"
	page.PageTitle = "Template"
	page.PageDescription = "Template"
	page.PageKeywords = ""
	page.PageSiteMapPriority = ""
	page.PageSiteMapFrequency = ABM.SITEMAP_FREQ_YEARLY
		
	page.ShowConnectedIndicator = True
				
	' adding a navigation bar
	ABMShared.BuildNavigationBar(page, "My Page 2","../images/logo.png", "", "", "")
			


#Region NOT SAVED: 2020-05-29T12:56:59

	page.AddRowsM(1,True,20,0,"").AddCells12(1,"")
	page.AddRowsM(1,True,20,0,"").AddCellsOS(2,0,0,0,12,12,6,"")
	page.AddRowsM(1,True,20,0,"").AddCells12MP(1,100,0,0,0,"")
	page.BuildGrid ' IMPORTANT!
#End Region

#End Region

	
End Sub

public Sub ConnectPage()			
	'	connecting the navigation bar
	ABMShared.ConnectNavigationBar(page)
	

	Dim l As ABMLabel
	l.Initialize(page, "page2", "This is page 2", ABM.SIZE_H5, True, "")
	page.Cell(1,1).AddComponent(l)
	

	
	page.Cell(2,1).AddComponent(leftW)
	page.Cell(2,2).AddComponent(rightW)
	page.Cell(3,1).AddComponent(firstwindow)	
	
	' refresh the page
	page.Refresh
	
	' Tell the browser we finished loading
	page.FinishedLoading
	' restoring the navigation bar position
	page.RestoreNavigationBarPosition
End Sub
#end region

Sub leftW As ABMContainer

	
	Dim p As ABMContainer
'	p.PaddingRight = "5px"
	p.Initialize(page, "leftw", "left")
	#Region NOT SAVED: 2020-05-29T12:39:46
	'PHONE
	'╔═══════════════════════════════════════════════════════════════════════════════════╗
	'║ 1,1                                                                               ║
	'╠═══════════════════════════════════════════════════════════════════════════════════╣
	'║ 2,1                                                                               ║
	'╠═══════════════════════════════════════════════════════════════════════════════════╣
	'║ 3,1                                                                               ║
	'╚═══════════════════════════════════════════════════════════════════════════════════╝

	'TABLET
	'╔═══════════════════════════════════════════════════════════════════════════════════════════════════════════╗
	'║ 1,1                                                                                                       ║
	'╠═══════════════════════════════════════════════════════════════════════════════════════════════════════════╣
	'║ 2,1                                                                                                       ║
	'╠═══════════════════════════════════════════════════════════════════════════════════════════════════════════╣
	'║ 3,1                                                                                                       ║
	'╚═══════════════════════════════════════════════════════════════════════════════════════════════════════════╝

	'DESKTOP
	'╔═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗
	'║ 1,1                                                                                                                               ║
	'╠═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╣
	'║ 2,1                                                                                                                               ║
	'╠═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╣
	'║ 3,1                                                                                                                               ║
	'╚═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝

	p.AddRowsM(3,True,0,0,"").AddCells12(1,"")
	p.BuildGrid ' IMPORTANT!
#End Region

	Dim l2 As ABMLabel
	l2.Initialize(page, "l2", "Left window", ABM.SIZE_H3, True, "")
	p.Cell(1,1).AddComponent(l2)
	
	Return p
End Sub


Sub rightW As ABMContainer
	

	Dim p As ABMContainer
	p.Initialize(page, "rightw", "right")
	p.AddRowsM(3,True,0,0,"").AddCells12(1,"")
	p.BuildGrid ' IMPORTANT!
	Dim l3 As ABMLabel
	l3.Initialize(page, "l3", "Right window", ABM.SIZE_H3, True, "")
	

	Dim l3a As ABMInput
	l3a.Initialize(page, "input2", ABM.INPUT_TEXT, "Text", False, "inp")
	p.Cell(1,1).AddComponent(l3)
	p.Cell(2,1).AddComponent(l3a)
	
	Return p
End Sub

Sub input2_EnterPressed(value As String)
	Dim p1 As ABMContainer = page.Component("leftw")
	Dim p2 As ABMContainer = page.Component("rightw")
	Dim label As ABMLabel = p1.Component("l2")
	label.Text = value
	label.Refresh
	
	Dim i As ABMInput = p2.Component("input2")
	i.Text = ""
	i.Refresh
End Sub


Sub firstwindow As ABMContainer
	Dim p As ABMContainer
	p.Initialize(page,"w1", "window")
	#Region NOT SAVED: 2020-05-29T12:58:15

	p.AddRows(3,True,"").AddCells12(1,"")
	p.BuildGrid ' IMPORTANT!
#End Region
	Dim l1 As ABMLabel
	l1.Initialize(page, "lw1", "Window 1 ", ABM.SIZE_H5, True, "")
	Dim b1 As ABMButton
	b1.InitializeFlat(page,"b1", "","","Jump to 2","")
	b1.RightToLeft = True
	
	p.Cell(1,1).AddComponent(l1)
	p.Cell(2,1).AddComponent(leftW)
	p.Cell(3,1).AddComponent(b1)
	p.Cell(3,1).MarginBottom = "20px"

	Return p
End Sub

Sub b1_Clicked(Target As String)
	page.Cell(3,1).RemoveAllComponents
	page.Cell(3,1).AddComponent(twowindow)
	page.Cell(3,1).Refresh
End Sub


Sub twowindow As ABMContainer
	Dim p As ABMContainer
	p.Initialize(page,"w2", "window")
	#Region NOT SAVED: 2020-05-29T12:58:15

	p.AddRows(3,True,"").AddCells12(1,"window")
	p.BuildGrid ' IMPORTANT!
#End Region
	Dim l1 As ABMLabel
	l1.Initialize(page, "lw1", "Window 2 ", ABM.SIZE_H5, True, "")
	Dim b1 As ABMButton
	b1.InitializeFlat(page,"b2", "","","Jump to 1","")
	b1.RightToLeft = True
	
	
	p.Cell(1,1).AddComponent(l1)
	p.Cell(2,1).AddComponent(rightW)
	p.Cell(3,1).AddComponent(b1)
	p.Cell(3,1).MarginBottom = "20px"
	Return p
End Sub


Sub b2_Clicked(Target As String)
	page.Cell(3,1).RemoveAllComponents
	page.Cell(3,1).AddComponent(firstwindow)
	page.Cell(3,1).Refresh
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
		
	If Action = "menu_page2" Then
		Return
	End If
	
	If Action = "exit" Then
		page.Msgbox("exit", "Exit program","","ok", False, ABM.MSGBOX_POS_CENTER_CENTER,"")
		Return
	End If

	ABMShared.NavigateToPage(ws, ABMPageId, Value)
End Sub

Sub Page_DebugConsole(message As String)
	Log("---> " & message)
End Sub
#end region


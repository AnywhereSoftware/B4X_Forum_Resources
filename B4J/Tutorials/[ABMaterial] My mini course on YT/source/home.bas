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
	Public Name As String = "home"  '<-------------------------------------------------------- IMPORTANT
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
	
	Log(eventName)
	
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
	theme.AddLabelTheme("title")
	theme.Label("title").Align = ABM.ICONALIGN_CENTER
	theme.Label("title").ForeColor = ABM.COLOR_TEAL
End Sub

public Sub BuildPage()
	' initialize the theme
	BuildTheme
	
	' initialize this page using our theme
	page.InitializeWithTheme(Name, "/ws/" & ABMShared.AppName & "/" & Name, False, ABMShared.SessionMaxInactiveIntervalSeconds, theme)
	page.ShowLoader=True
	page.PageHTMLName = "index.html"
	page.PageTitle = "Page1"
	page.PageDescription = "Page1"
	page.PageKeywords = ""
	page.PageSiteMapPriority = ""
	page.PageSiteMapFrequency = ABM.SITEMAP_FREQ_YEARLY
		
	page.ShowConnectedIndicator = True
				
	' adding a navigation bar
	ABMShared.BuildNavigationBar(page, "Page 1","../images/logo.png", "", "", "")
	
			
	' create the page grid
	page.AddRowsM(3,True,20,0, "").AddCells12MP(1,0,0,0,0,"")	
	
	page.BuildGrid 'IMPORTANT once you loaded the complete grid AND before you start adding components		
End Sub

public Sub ConnectPage()
	'	connecting the navigation bar
	ABMShared.ConnectNavigationBar(page)
	

	
	Dim title As ABMLabel
	title.Initialize(page,"title", "My tytul", ABM.SIZE_H5, True, "title")
	title.Clickable = True
	page.Cell(1,1).AddComponent(title)
	
	
	Dim textInput As ABMInput
	textInput.Initialize(page, "input", ABM.INPUT_TEXT, "Nowy tytul", False,"")
	page.Cell(2,1).AddComponent(textInput)
	
	Dim button As ABMButton
	button.InitializeFlat(page, "btnNew", "mdi-editor-mode-edit","", "New title","")
'	button.UseFullCellWidth = True
	button.RightToLeft = True
	button.SetTooltip("Edit title", ABM.TOOLTIP_BOTTOM, 200)
	button.SetBorderEx(ABM.COLOR_BLACK, ABM.INTENSITY_ACCENT1,2, ABM.BORDER_DOUBLE, 10)
	page.Cell(3,1).AddComponent(button)
	
	' refresh the page
	page.Refresh
	
	' Tell the browser we finished loading
	page.FinishedLoading
	' restoring the navigation bar position
	page.RestoreNavigationBarPosition
End Sub
#end region

Sub btnNew_Clicked(Target As String)
	Dim l As ABMLabel = page.Component("title")
	page.InputBox("newtitle", "Nowy tytul","OK","Anuluj", False, ABM.MSGBOX_TYPE_QUESTION, ABM.INPUT_TEXT, l.Text, "", "", "", False, ABM.MSGBOX_POS_CENTER_CENTER, "")
	
End Sub

Sub input_EnterPressed(value As String)
	Dim l As ABMLabel = page.Component("title")
	l.Text = value
	l.Refresh
	Dim i As ABMInput = page.Component("input")
	i.Text = ""
	i.Refresh
End Sub


Sub title_Clicked(Target As String)
	Dim l As ABMLabel = page.Component("title")
'	Dim i As ABMInput
'	i.Initialize(page, "input2", ABM.INPUT_TEXT, "Nowy tytul", False,"")
'	i.Text = l.Text
'	page.Cell(1,1).RemoveAllComponents
'	page.Cell(1,1).AddComponent(i)
'	page.Cell(1,1).Refresh
	page.InputBox("newtitle", "Nowy tytul","OK","Anuluj", False, ABM.MSGBOX_TYPE_QUESTION, ABM.INPUT_TEXT, l.Text, "", "", "", False, ABM.MSGBOX_POS_CENTER_CENTER, "")
End Sub

Sub input2_EnterPressed(value As String)
	Dim title As ABMLabel
	title.Initialize(page,"title", "My tytul", ABM.SIZE_H5, True, "title")
	title.Clickable = True
	title.Text = value
	page.Cell(1,1).RemoveAllComponents
	page.Cell(1,1).AddComponent(title)
	page.Refresh
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
	
	If Action = "menu_page1" Then
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


Sub page_InputboxResult(returnName As String, result As String)
If returnName = "newtitle" And result.Length > 0 And result <> "abmcancel" Then
		Dim l As ABMLabel = page.Component("title")
		l.Text = result
		l.Refresh
	End If
End Sub
#end region


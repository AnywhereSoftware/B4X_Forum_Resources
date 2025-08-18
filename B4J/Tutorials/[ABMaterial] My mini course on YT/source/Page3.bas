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
	Public Name As String = "Page3"  '<-------------------------------------------------------- IMPORTANT
	' will hold the unique browsers window id
	Private ABMPageId As String = ""
	' your own variables	
	Private mapList As Map
	Private chDelete As Boolean = False
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	' build the local structure IMPORTANT!
	BuildPage		
End Sub

#Region ABM
Private Sub WebSocket_Connected (WebSocket1 As WebSocket)	
	Log("Connected")
	mapList.Initialize	
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
	ABMShared.BuildNavigationBar(page, "My Page 3 - LIST","../images/logo.png", "", "", "")
			
	' create the page grid
	page.AddRowsM(3,True,20,0, "").AddCells12MP(1,0,0,0,0,"")	
	
	page.BuildGrid 'IMPORTANT once you loaded the complete grid AND before you start adding components		
End Sub

public Sub ConnectPage()
	'	connecting the navigation bar
	ABMShared.ConnectNavigationBar(page)
	
	Dim list As ABMList
	list.InitializeWithMaxHeight(page, "list2", ABM.COLLAPSE_ACCORDION, 300, "")
'	list.Initialize(page,"list1", ABM.COLLAPSE_NONE, "")

	Dim li As List = DBM.SQLSelect(DBM.GetSQL, "select * from customers", Null)
	For Each m As Map In li
		Dim unique As String = m.Get("customerid")
		list.AddItem(unique, CreateLineList(unique, m.Get("lastname") &" " & m.Get("firstname")))
		list.AddSubItem(unique, "sub1_"&unique, CreateLineList("sub1_"&unique, m.Get("country")&", "&m.Get("city")&", "&m.Get("address")))
		list.AddSubItem(unique, "sub2_"&unique, CreateLineList("sub2_"&unique, m.Get("email")&", "&m.Get("phone")))
		mapList.Put(unique,  m.Get("lastname") &" " & m.Get("firstname"))
	Next
	
	

'	li.Initialize
'	li.AddAll(Array As String("Position1", "Position 2", "Position 3", "Position4", "Position5"))
'	For Each line As String In li
'		Dim unique As String = line&Rnd(1,10000)
'		list.AddItem(unique, CreateLineList(line, line))
'		mapList.Put(unique, line)
'	Next

	page.Cell(1,1).AddComponent(list)
	
	Dim new As ABMInput
	new.Initialize(page, "newpos", ABM.INPUT_TEXT, "New to list", False, "")
	page.Cell(2,1).AddComponent(new)
	Dim check1 As ABMCheckbox
	check1.Initialize(page, "delete", "Delete?", False, "")
	page.Cell(2,1).AddComponent(check1)

	Dim search As ABMInput
	search.Initialize(page, "search", ABM.INPUT_text, "Find in list", False, "")
	page.Cell(3,1).AddComponent(search)
	
	' refresh the page
	page.Refresh
	
	' Tell the browser we finished loading
	page.FinishedLoading
	' restoring the navigation bar position
	page.RestoreNavigationBarPosition
End Sub
#end region

Sub find(value As String) As String
	For i =0 To mapList.Size-1
		Dim s As String = mapList.GetValueAt(i)
		s=s.ToLowerCase
		If s.Contains(value) Then
			Return mapList.GetKeyAt(i)
		End If
	Next
	Return "Null"
End Sub

Sub search_EnterPressed(value As String)
	Dim li As ABMList = page.Component("list2")
	Dim s As String = find(value.ToLowerCase)
	li.ScrollTo(s, True)
	Dim input As ABMInput = page.Component("search")
	input.Text = ""
	input.Refresh
End Sub

Sub newpos_EnterPressed(value As String)
	Dim list As ABMList = page.Component("list2")
	Dim unique As String = value&Rnd(1,10000)
	list.AddItem(unique, CreateLineList(value, value))
	list.Refresh
	list.ScrollTo(unique, True)
	mapList.Put(unique, value)
End Sub

Sub CreateLineList(id As String, text As String) As ABMLabel
	Dim l As ABMLabel
	l.Initialize(page, id, text, ABM.SIZE_H5, True, "")
	Return l
End Sub

Sub delete_Clicked(Target As String)
	Dim ch As ABMCheckbox = page.Component("delete")
	chDelete = ch.State
End Sub

Sub list2_Clicked(ItemId As String)
	If chDelete Then
		Dim li As ABMList = page.Component("list2")
		li.Remove(ItemId)
		li.Refresh
	Else
		page.ShowToast("1", "", "Clicked: "&ItemId, 500, False)
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


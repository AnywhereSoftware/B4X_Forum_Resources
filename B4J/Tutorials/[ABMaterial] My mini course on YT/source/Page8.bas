B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.31
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
	Public Name As String = "Page8"  '<-------------------------------------------------------- IMPORTANT
	' will hold the unique browsers window id
	Private ABMPageId As String = ""
	' your own variables	
	Private RootFolder As String= File.DirApp & "\www\" & ABMShared.AppName & "\images\my"
	Private RootFolder2 As String= File.DirApp & "\www\" & ABMShared.AppName & "\images\wallpaper"
	Private pictureName As String
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
	
	Log("event: "&eventName)
	'event: cardguinea-pig-5287749_1920.jpg_linkclicked
	'guinea-pig-5287749_1920.jpg - name file picture
	
	If eventName.Contains("_linkclicked") Then
		pictureName = eventName.SubString2(4, eventName.IndexOf("_link"))
		eventName = eventName.SubString2(0,4) & eventName.SubString2(eventName.IndexOf("_link"), eventName.Length)
	End If
	
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
	page.PageTitle = "Images"
	page.PageDescription = "Images"
	page.PageKeywords = ""
	page.PageSiteMapPriority = ""
	page.PageSiteMapFrequency = ABM.SITEMAP_FREQ_YEARLY
		
	page.ShowConnectedIndicator = True
				
	' adding a navigation bar
	ABMShared.BuildNavigationBar(page, "Image","../images/logo.png", "", "", "")
			
	' create the page grid
	page.AddRowsM(2,True,20,0, "").AddCells12MP(1,0,0,0,0,"")	
	
	page.BuildGrid 'IMPORTANT once you loaded the complete grid AND before you start adding components		
End Sub

public Sub ConnectPage()
	'	connecting the navigation bar
	ABMShared.ConnectNavigationBar(page)
	
	Dim  lista As List = File.ListFiles(RootFolder2) 'folder with wallpaper
	Dim slider As ABMImageSlider
	slider.Initialize(page, "slider", "")
'	For i=0 To lista.Size-1
	For Each  plik As String In lista
		Dim ran As Int = Rnd(1,3)
		Dim anim As String
		Select ran
			Case 1:
				anim = ABM.IMAGESLIDER_CENTER
			Case 2:
				anim = ABM.IMAGESLIDER_LEFT
			Case 3:
				anim = ABM.IMAGESLIDER_RIGHT
		End Select
'		slider.AddSlideImage("../images/wallpaper/"& lista.Get(i), "Title "&i, "SubTitle "&i, anim)
		slider.AddSlideImage("../images/wallpaper/"& plik, "Title "&plik, "SubTitle "&plik, anim)
	Next
	page.Cell(1,1).AddComponent(slider)
	
	Dim div1 As ABMDivider
	div1.Initialize(page, "div", "")
	page.Cell(1,1).AddComponent(div1)
	
	'######################### flexwall ##############
	Dim flex As ABMFlexWall
	flex.Initialize(page, "flex", 450)
	Dim lista As List = File.ListFiles(RootFolder)
	For Each filename As String In lista
		Dim image As ABMImage
		image.Initialize(page, "image"&Rnd(1,20000), "../images/my/"& filename, 1.0)
		image.SetFixedSize(320,320)
		image.IsMaterialBoxed = True
		image.IsCircular = True
		image.SetTooltip(filename, ABM.TOOLTIP_BOTTOM, 300)
		flex.AddImage(image, 400,400)	
	Next
	page.Cell(2,1).AddComponent(flex)
	page.Cell(2,1).AddComponent(div1)
	
	'######## card and dynamic add row ####################
	Dim AllRow As Int = lista.Size /3
	Dim reszta As Int = lista.Size-(3*AllRow)
	If reszta > 0  Then
		AllRow = AllRow + 1
	End If

	page.AddRows(AllRow,True,"").AddCellsOSMP(3,0,0,0,12,12,4,0,0,5,5,"")
	page.BuildGrid ' IMPORTANT!

	Dim column As Int = 1
	Dim row As Int = 3
	Dim count As Int=1
	theme.AddCardTheme("card")
	theme.Card("card").ActionForeColor = ABM.COLOR_BLACK
	theme.Card("card").TitleForeColor = ABM.COLOR_YELLOW
	theme.Card("card").BackColor = ABM.COLOR_LIGHTBLUE
	For Each filePicture As String In lista
		Dim card As ABMCard
		card.InitializeAsCard(page, "card" & filePicture, "Picture " & count, filePicture, ABM.CARD_NOTSPECIFIED, "card")
		card.Image = "../images/my/" & filePicture
		card.AddAction("Click " & count)
		If column < 4 Then
			page.Cell(row, column).AddComponent(card)
			If column = 3 Then
				column = 1
				row = row +1
			Else
				column = column + 1
			End If
		End If
		count = count+1
	Next
	
	row = row+1
	page.AddRowsM(5,True,20,0, "").AddCells12MP(1,0,0,0,0,"")	
	page.BuildGrid
	page.Cell(row,1).AddComponent(div1)
	
	'################# picture in table ###################3
	Dim table As ABMTable 
	table.Initialize(page, "tbl1", False,False,False,"")
	table.SetHeaders(Array As String("Picture", "Size", "Time"))
	table.SetColumnWidths(Array As Int(300,200,200))
	writeTable(table)
	row = row+1
	page.Cell(row,1).AddComponent(table)
	row = row+1
	page.Cell(row,1).AddComponent(div1)
		
	' refresh the page
	page.Refresh
	
	' Tell the browser we finished loading
	page.FinishedLoading
	' restoring the navigation bar position
	page.RestoreNavigationBarPosition
End Sub
#end region

Sub writeTable(table As ABMTable)
	Dim lista As List = File.ListFiles(RootFolder)
	For petla = 0 To lista.Size-1
		Dim r As List
		r.Initialize
		Dim image As ABMImage
		image.Initialize(page, "picture"&petla, "../images/my/"& lista.Get(petla), 1.0)
		image.IsResponsive = True
		image.ResponsiveMaxWidth = "200px"
		r.Add(image)
		Dim size As String = File.Size(RootFolder, lista.Get(petla))
		r.Add(size)
		Dim d As Long = File.LastModified(RootFolder, lista.Get(petla))
		Dim dd As String = DateTime.Date(d) & " " & DateTime.Time(d)
		r.Add(dd)

		table.AddRow(lista.Get(petla), r)
	Next
End Sub

Sub card_LinkClicked(Card As String, Action As String)
	page.Msgbox("ok", pictureName, "Picture name", "OK", False, ABM.MSGBOX_POS_TOP_CENTER,"")
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


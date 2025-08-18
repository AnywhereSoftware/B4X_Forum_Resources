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
	Public Name As String = "Page4"  '<-------------------------------------------------------- IMPORTANT
	' will hold the unique browsers window id
	Private ABMPageId As String = ""
	' your own variables	
	Private posPag As Int = 1
	Private maxPag As Int
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
	ABMShared.BuildNavigationBar(page, "Table","../images/logo.png", "", "", "")
			
	' create the page grid
	page.AddRowsM(2,True,20,0, "").AddCells12MP(1,0,0,0,0,"")	
	
	page.BuildGrid 'IMPORTANT once you loaded the complete grid AND before you start adding components	
	page.AddModalSheetTemplate(modalNewUser)
End Sub

public Sub ConnectPage()
	'	connecting the navigation bar
	ABMShared.ConnectNavigationBar(page)
	

	Dim li As List = DBM.SQLSelect(DBM.GetSQL, "Select * from customers limit 0,10", Null)
	Dim table As ABMTable
	table.Initialize(page, "table", False, False, True,"")
	table.SetHeaders(Array As String("Name", "Address", "E-mial", "Phone"))
	table.SetColumnWidths(Array As Int(150,300,100,150))
	table.IsBordered=True
	writeTable(li, table)

	
	Dim sizeLi As Int = DBM.SQLSelectSingleResult(DBM.GetSQL, "select count(*) from customers")
	Dim pag As ABMPagination
	pag.Initialize(page, "pag", 10, True,True,"")
	pag.SetTotalNumberOfPages(sizeLi/10)
	maxPag = sizeLi/10
	pag.SetActivePage(1)
	
	Dim acb1 As ABMActionButton
	acb1.Initialize(page, "acb1", "mdi-content-add", "","")
	acb1.MainButton.Size = ABM.BUTTONSIZE_NORMAL
	
	page.Cell(1,1).AddComponent(pag)
	page.Cell(2,1).AddComponent(table)
	page.Cell(2,1).AddComponent(acb1)
'	page.Cell(1,1).SetFixedHeight(400,True)
	
	' refresh the page
	page.Refresh
	
	' Tell the browser we finished loading
	page.FinishedLoading
	' restoring the navigation bar position
	page.RestoreNavigationBarPosition
End Sub
#end region

Sub acb1_Clicked(Target As String, SubTarget As String)
'	page.ShowToast("a","", "Click", 300, False)
	page.ShowModalSheet("modalNewuser")
	Dim modal As ABMModalSheet = page.ModalSheet("modalNewuser")
	Dim inp1 As ABMInput = modal.Content.Component("inpFirstName")
	Dim inp2 As ABMInput = modal.Content.Component("inpLastName")
	Dim inp3 As ABMInput = modal.Content.Component("inpCompany")
	Dim inp4 As ABMInput = modal.Content.Component("inpAddress")
	Dim inp5 As ABMInput = modal.Content.Component("inpCity")
	Dim inp6 As ABMInput = modal.Content.Component("inpCountry")
	Dim inp7 As ABMInput = modal.Content.Component("inpPostCode")
	Dim inp8 As ABMInput = modal.Content.Component("inpPhone")
	Dim inp9 As ABMInput = modal.Content.Component("inpFax")
	Dim inp10 As ABMInput = modal.Content.Component("inpEmail")
	inp1.Text= ""
	inp2.Text= ""
	inp3.Text= ""
	inp4.Text= ""
	inp5.Text= ""
	inp6.Text= ""
	inp7.Text= ""
	inp8.Text= ""
	inp9.Text= ""
	inp10.Text= ""
	
	modal.Content.Refresh
End Sub

Sub modalNewUser As ABMModalSheet
	Dim newuser As ABMModalSheet
	newuser.Initialize(page, "modalNewUser", True, ABM.MODALSHEET_TYPE_NORMAL,"")
	#Region NOT SAVED: 2020-06-04T10:44:47

	newuser.Content.AddRowsM(10,True,0,0,"").AddCells12(1,"")
	newuser.Content.BuildGrid ' IMPORTANT!
#End Region

	Dim inp1 As ABMInput
	inp1.Initialize(page, "inpFirstName", ABM.INPUT_TEXT, "First Name", False, "")
	Dim inp2 As ABMInput
	inp2.Initialize(page, "inpLastName", ABM.INPUT_TEXT, "Last Name", False, "")
	Dim inp3 As ABMInput
	inp3.Initialize(page, "inpCompany", ABM.INPUT_TEXT, "Company", False, "")
	Dim inp4 As ABMInput
	inp4.Initialize(page, "inpAddress", ABM.INPUT_TEXT, "Address", False, "")
	Dim inp5 As ABMInput
	inp5.Initialize(page, "inpCity", ABM.INPUT_TEXT, "City", False, "")
	Dim inp6 As ABMInput
	inp6.Initialize(page, "inpCountry", ABM.INPUT_TEXT, "Country", False, "")
	Dim inp7 As ABMInput
	inp7.Initialize(page, "inpPostCode", ABM.INPUT_TEXT, "Postal Code", False, "")
	Dim inp8 As ABMInput
	inp8.Initialize(page, "inpPhone", ABM.INPUT_TEXT, "Phone", False, "")
	Dim inp9 As ABMInput
	inp9.Initialize(page, "inpFax", ABM.INPUT_TEXT, "FAX", False, "")
	Dim inp10 As ABMInput
	inp10.Initialize(page, "inpEmail", ABM.INPUT_TEXT, "E-Mail", False, "")
	
	
	newuser.Content.Cell(1,1).AddComponent(inp1)
	newuser.Content.Cell(2,1).AddComponent(inp2)
	newuser.Content.Cell(3,1).AddComponent(inp3)
	newuser.Content.Cell(4,1).AddComponent(inp4)
	newuser.Content.Cell(5,1).AddComponent(inp5)
	newuser.Content.Cell(6,1).AddComponent(inp6)
	newuser.Content.Cell(7,1).AddComponent(inp7)
	newuser.Content.Cell(8,1).AddComponent(inp8)
	newuser.Content.Cell(9,1).AddComponent(inp9)
	newuser.Content.Cell(10,1).AddComponent(inp10)

	#Region NOT SAVED: 2020-06-04T10:56:52

	newuser.Footer.AddRowsM(1,True,0,0,"").AddCellsOS(1,0,0,8,12,12,2,"").AddCellsOS(1,0,0,0,12,12,2,"")
	newuser.Footer.BuildGrid ' IMPORTANT!
#End Region
	Dim b1 As ABMButton
	b1.InitializeFlat(page, "btnNewSave", "","", "Save", "")
	Dim b2 As ABMButton
	b2.InitializeFlat(page, "btnNewCancel", "","", "Cancel", "")
	newuser.Footer.Cell(1,1).AddComponent(b1)
	newuser.Footer.Cell(1,2).AddComponent(b2)

	#Region NOT SAVED: 2020-06-04T10:58:56

	newuser.Header.AddRows(1,True,"").AddCells12(1,"")
	newuser.Header.BuildGrid ' IMPORTANT!
#End Region
	Dim header As ABMLabel
	header.Initialize(page, "titleHeader", "New user", ABM.SIZE_H5, True ,"")
	newuser.Header.Cell(1,1).AddComponent(header)
	
	Return newuser
End Sub

Sub btnNewCancel_Clicked(Target As String)
	page.CloseModalSheet("modalNewuser")
End Sub

Sub btnNewSave_Clicked(Target As String)
	Dim modal As ABMModalSheet = page.ModalSheet("modalNewuser")
	Dim inp1 As ABMInput = modal.Content.Component("inpFirstName")
	Dim inp2 As ABMInput = modal.Content.Component("inpLastName")
	Dim inp3 As ABMInput = modal.Content.Component("inpCompany")
	Dim inp4 As ABMInput = modal.Content.Component("inpAddress")
	Dim inp5 As ABMInput = modal.Content.Component("inpCity")
	Dim inp6 As ABMInput = modal.Content.Component("inpCountry")
	Dim inp7 As ABMInput = modal.Content.Component("inpPostCode")
	Dim inp8 As ABMInput = modal.Content.Component("inpPhone")
	Dim inp9 As ABMInput = modal.Content.Component("inpFax")
	Dim inp10 As ABMInput = modal.Content.Component("inpEmail")
	
	Dim data As Map
	data.Initialize
	data.Put("FirstName", inp1.Text)
	data.Put("Lastname", inp2.Text)
	data.Put("Company", inp3.Text)
	data.Put("Address", inp4.Text)
	data.Put("City", inp5.Text)
	data.Put("Country", inp6.Text)
	data.Put("PostalCode", inp7.Text)
	data.Put("Phone", inp8.Text)
	data.Put("Fax", inp9.Text)
	data.Put("Email", inp10.Text)
	
	Dim sqlinsert As String = DBM.BuildInsertQuery("customers", data)
	LogDebug(sqlinsert)
	'INSERT INTO customers(FirstName, Lastname, Company, Address, City, Country, PostalCode, Phone, Fax, Email) VALUES ('kfsdfsdf', jklj, lkj, lkj, lkj, lkj, lkj, lkj, klj, lkj)
	Dim res As Int = DBM.SQLInsert(DBM.GetSQL, sqlinsert)
	
	page.CloseModalSheet("modalNewuser")
	
	Dim li As List = DBM.SQLSelect(DBM.GetSQL, "Select * from customers limit ?,10", Array As Int(posPag*10))
	Dim t As ABMTable = page.Component("table")
	t.Clear
	writeTable(li,t)
	t.Refresh
	
	
End Sub


Sub writeTable(li As List, table As ABMTable)
	For Each m As Map In li
		Dim row As List
		row.Initialize
		row.Add( m.Get("lastname") &" " & m.Get("firstname"))
		row.Add( m.Get("country")&", "&m.Get("city")&", "&m.Get("address"))
		If m.Get("email") <> Null Then
			row.Add( m.Get("email"))
		Else
			row.Add("-")
		End If
		If m.Get("phone") <> Null Then
			row.Add( m.Get("phone"))
		Else
			row.Add("-")
		End If
		table.AddRowFixedHeight(m.Get("customerid"), row, 50)
		
	Next
End Sub

Sub pag_PageChanged(OldPage As Int, NewPage As Int)
	Dim m As Int
	If NewPage = 1 Then
		m = 0
		posPag = 1
	Else If NewPage = maxPag Then
		m = maxPag * 10
		posPag = maxPag
	Else
		If NewPage > OldPage Then
			posPag = posPag + (NewPage-OldPage)
		Else
			posPag = posPag - (OldPage-NewPage)
		End If
		m = posPag*10
	End If
	
	Dim li As List = DBM.SQLSelect(DBM.GetSQL, "Select * from customers limit ?,10", Array As Int(m))
	Dim t As ABMTable = page.Component("table")
	t.Clear
	writeTable(li, t)
	t.Refresh
	Dim pag As ABMPagination = page.Component("pag")
	pag.SetActivePage(posPag)
	pag.Refresh
End Sub


Sub table_Clicked(PassedRowsAndColumns As List)
	Dim value As ABMTableCell = PassedRowsAndColumns.Get("0")
	Dim t As ABMTable = page.Component("table")
	LogDebug(value.Column)
	LogDebug(value.Row)
	LogDebug(t.GetActiveRow)
	
	Dim phone As String = t.GetString(value.Row, 3)
	page.Msgbox("phone", "Number phone: "&phone, "","OK", True, ABM.MSGBOX_POS_CENTER_CENTER, "")
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


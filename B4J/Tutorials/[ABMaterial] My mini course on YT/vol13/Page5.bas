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
	Public Name As String = "Page5"  '<-------------------------------------------------------- IMPORTANT
	' will hold the unique browsers window id
	Private ABMPageId As String = ""
	' your own variables	
	Private dataTemp As String
	Type editRow(idxuser As Int, row As Int, column As Int)
	private tempRow as editRow
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
	page.PageTitle = "Datetime"
	page.PageDescription = "datetime"
	page.PageKeywords = ""
	page.PageSiteMapPriority = ""
	page.PageSiteMapFrequency = ABM.SITEMAP_FREQ_YEARLY
		
	page.ShowConnectedIndicator = True
				
	' adding a navigation bar
	ABMShared.BuildNavigationBar(page, "Datetime","../images/logo.png", "", "", "")
			
	' create the page grid
#Region NOT SAVED: 2020-06-09T01:09:12
	'PHONE
	'╔═══════════════════════════════════════════════════════════════════════════════════╗
	'║ 1,1                                                                               ║
	'╠═══════════════════════════════════════════════════════════════════════════════════╣
	'║ 2,1                                                                               ║
	'║-----------------------------------------------------------------------------------║
	'║ 2,2                                                                               ║
	'╚═══════════════════════════════════════════════════════════════════════════════════╝

	'TABLET
	'╔═══════════════════════════════════════════════════════════════════════════════════════════════════════════╗
	'║ 1,1                                                                                                       ║
	'╠═══════════════════════════════════════════════════════════════════════════════════════════════════════════╣
	'║ 2,1                                                                                                       ║
	'║-----------------------------------------------------------------------------------------------------------║
	'║ 2,2                                                                                                       ║
	'╚═══════════════════════════════════════════════════════════════════════════════════════════════════════════╝

	'DESKTOP
	'╔═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗
	'║ 1,1                                                                                                                               ║
	'╠═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╣
	'║ 2,1                                                             | 2,2                                                             ║
	'╚═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝

	page.AddRows(1,True,"").AddCells12(1,"")
	page.AddRows(1,True,"").AddCellsOS(2,0,0,0,12,12,6,"")
	page.BuildGrid ' IMPORTANT!
#End Region
	
End Sub

public Sub ConnectPage()			
	'	connecting the navigation bar
	ABMShared.ConnectNavigationBar(page)
	

	
	Dim li As List = DBM.SQLSelect(DBM.GetSQL, "Select * from employees", Null)
	Dim table As ABMTable
	table.Initialize(page, "table", False, False, True,"")
	table.SetHeaders(Array As String("Name", "Address", "E-mial", "Phone", "HireDate"))
	table.SetColumnWidths(Array As Int(150,300,100,150,150))
	table.IsBordered=True
	writeTable(li, table)
	
	Dim labdate As ABMLabel
	labdate.Initialize(page, "labDate", "", ABM.SIZE_PARAGRAPH, True, "")
	labdate.Clickable = True
	
	page.Cell(1,1).AddComponent(table)
	page.Cell(2,1).AddComponent(labdate)
	' refresh the page
	page.Refresh
	
	' Tell the browser we finished loading
	page.FinishedLoading
	' restoring the navigation bar position
	page.RestoreNavigationBarPosition	
End Sub
#end region

Sub table_Clicked(PassedRowsAndColumns As List)
	Dim value As ABMTableCell = PassedRowsAndColumns.Get(0)
	Dim t As ABMTable = page.Component("table")
	Dim hiredate As String = t.GetString(value.Row,4)
	Dim labdate As ABMLabel = page.Component("labDate")
	
	Dim temp As String = _
	$"{B}Now date: {C:#FF0000}{now_date}{/C}{/B}
	{B}Date of employment: {C:#004AFF}{hire_date}{/C}{/B}
	{B}Working period: {period}{/B}"$
	
	DateTime.DateFormat = "yyyy-MM-dd"
	Dim nowd As String = DateTime.Date(DateTime.Now)
	Dim period As Period
	period = DateUtils.PeriodBetween(DateTime.DateParse(hiredate), DateTime.Now)
	Dim perioduser As String = "Years: "&period.Years& " Mounths: "&period.Months& " Days: "&period.Days
	
	temp = temp.Replace("{now_date}", nowd)
	temp = temp.Replace("{hire_date}", hiredate)
	temp = temp.Replace("{period}", perioduser)
	
	labdate.Text = temp
	labdate.Refresh
	
	
	dataTemp = hiredate
	tempRow.idxuser = t.GetActiveRow
	tempRow.row = value.Row
	tempRow.column = value.Column
End Sub


Sub labDate_Clicked(Target As String)
	page.Cell(2,2).RemoveAllComponents
	Dim radio As ABMRadioGroup
	radio.Initialize(page, "radio", "")
	radio.AddRadioButton("Data Picker", True)
	radio.AddRadioButton("Data Scroller", True)
	radio.AddRadioButtonNoLineBreak("No visible", False)
	radio.Title = "Select options"
	page.Cell(2,2).AddComponent(radio)
	page.Refresh
End Sub

Sub radio_Clicked(Target As String)
	Dim r As ABMRadioGroup = page.Component("radio")
	Select r.GetActive
		Case 0:
			Dim d1 As ABMDateTimePicker
			d1.Initialize(page, "d1", ABM.DATETIMEPICKER_TYPE_DATE, DateTime.DateParse(dataTemp), "Set date","")
			d1.Language = "se"
			d1.ReturnDateFormat = "YYYY-MM-DD"
			d1.Title = "Ustaw date"
			d1.TodayText = "Dzisiaj"
			d1.ClearText = "Puste"
			d1.ClickThrough = True
			page.Cell(2,2).RemoveAllComponents
			page.Cell(2,2).AddComponent(d1)
		Case 1:
			Dim d2 As ABMDateTimeScroller
			d2.Initialize(page, "d2", ABM.DATETIMEPICKER_TYPE_DATE, ABM.DATETIMESCROLLER_MODE_SCROLLER, DateTime.DateParse(dataTemp), "Set date", "")
			d2.ReturnDateFormat = "yyyy-MM-dd"
			page.Cell(2,2).RemoveAllComponents
			page.Cell(2,2).AddComponent(d2)
	End Select
	page.Cell(2,2).Refresh
End Sub

Sub d1_Changed(Target As String, dateMilliseconds As String)
	LogDebug(DateTime.Date(dateMilliseconds))
	Dim s1 As String = """"& DateTime.Date(dateMilliseconds) & " 00:00:00"& """" 'string in "value" to database
	Dim query As String = DBM.BuildUpdateQuery("employees", CreateMap("hiredate":s1), CreateMap("EmployeeId": tempRow.idxuser))
	LogDebug(query)
	DBM.SQLUpdate(DBM.GetSQL, query)
	page.Cell(2,2).RemoveAllComponents
	Dim t As ABMTable = page.Component("table")
	t.SetString(tempRow.row, 4, DateTime.Date(dateMilliseconds))
	t.Refresh 
End Sub

Sub d2_Changed(dateMilliseconds As String)
	LogDebug(DateTime.Date(dateMilliseconds))
	Dim s1 As String = """"& DateTime.Date(dateMilliseconds) & " 00:00:00"& """" 'string in "value" to database
	Dim query As String = DBM.BuildUpdateQuery("employees", CreateMap("hiredate":s1), CreateMap("EmployeeId": tempRow.idxuser))
	LogDebug(query)
	DBM.SQLUpdate(DBM.GetSQL, query)
	page.Cell(2,2).RemoveAllComponents
	Dim t As ABMTable = page.Component("table")
	t.SetString(tempRow.row, 4, DateTime.Date(dateMilliseconds))
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
		Dim hiredate As String = m.Get("hiredate")
		If hiredate.Contains("00:00") Then
			hiredate = hiredate.SubString2(0, hiredate.IndexOf("00:00"))
		End If
		row.Add(hiredate)
		table.AddRowFixedHeight(m.Get("employeeid"), row, 50)
		
	Next
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


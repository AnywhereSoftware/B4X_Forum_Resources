B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.8
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
	Public Name As String = "Settings"  '<-------------------------------------------------------- IMPORTANT
	' will hold the unique browsers window id
	Private ABMPageId As String = ""
	' your own variables
	Private objekt As String
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
	Log(Params)
	
	If (eventName.StartsWith("inptext") Or eventName.StartsWith("inpcheck")) And (eventName.Contains("enterpressed") Or eventName.Contains("lostfocus"))Then
		objekt=""
		Dim split() As String = Regex.Split("_", eventName)
		If split.Length > 2 Then
			For i=1 To split.Length-2
				objekt=objekt&"_"& split(i)
			Next
			objekt = objekt.SubString2(1,objekt.Length)
			eventName = split(0)&"_"&split(split.Length-1)
		Else
			objekt = split(1)
			eventName = split(0)&"_"&split(2)
		End If
	End If
	
	
	If eventName.StartsWith("inpcheck") And eventName.Contains("clicked") Then
		objekt=""
		Dim split() As String = Regex.Split("_", eventName)
		If split.Length > 2 Then
			For i=1 To split.Length-2
				objekt=objekt&"_"& split(i)
			Next
			objekt = objekt.SubString2(1,objekt.Length)
			eventName = split(0)&"_"&split(split.Length-1)
		Else
			objekt = split(1)
			eventName = split(0)&"_"&split(2)
		End If
	End If
	
	If eventName.StartsWith("combo") And eventName.Contains("clicked") Then
		objekt=""
		Dim split() As String = Regex.Split("_", eventName)
		If split.Length > 2 Then
			For i=1 To split.Length-2
				objekt=objekt&"_"& split(i)
			Next
			objekt = objekt.SubString2(1,objekt.Length)
			eventName = split(0)&"_"&split(split.Length-1)
		Else
			objekt = split(1)
			eventName = split(0)&"_"&split(2)
		End If
	End If
	
	If eventName.StartsWith("date") And eventName.Contains("changed") Then
		objekt=""
		Dim split() As String = Regex.Split("_", eventName)
		If split.Length > 2 Then
			For i=1 To split.Length-2
				objekt=objekt&"_"& split(i)
			Next
			objekt = objekt.SubString2(1,objekt.Length)
			eventName = split(0)&"_"&split(split.Length-1)
		Else
			objekt = split(1)
			eventName = split(0)&"_"&split(2)
		End If
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
	theme.Page.BackColor=ABM.COLOR_GREY
	theme.Page.BackColorIntensity = ABM.INTENSITY_LIGHTEN2
End Sub

public Sub BuildPage()
	' initialize the theme
	BuildTheme
	
	' initialize this page using our theme
	page.InitializeWithTheme(Name, "/ws/" & ABMShared.AppName & "/" & Name, False, ABMShared.SessionMaxInactiveIntervalSeconds, theme)
	page.ShowLoader=True
	page.PageHTMLName = "index.html"
	page.PageTitle = "Ustawienia"
	page.PageDescription = "Ustawienia"
	page.PageKeywords = ""
	page.PageSiteMapPriority = ""
	page.PageSiteMapFrequency = ABM.SITEMAP_FREQ_YEARLY
	page.NeedsCombo=True
			
	' create the page grid
	page.AddRowsM(2,True,0,0, "").AddCells12MP(1,0,0,0,0,"")
	
	page.BuildGrid 'IMPORTANT once you loaded the complete grid AND before you start adding components
End Sub

public Sub ConnectPage()

	Dim linie As List = File.ReadList(File.DirApp, Main.FileConfig)
	Dim row As Int = 2 'inicjalize start row for settings
	For i=0 To linie.Size-1
		Dim s As String = linie.Get(i)
		LogDebug("linia "&s)
		If s <> Null Then
			If s.StartsWith("##") Then
				Dim s0 As String = s.SubString2(2, s.Length)
				s0 = s0.ToUpperCase
				Dim titile As ABMLabel
				titile.Initialize(page, "t"&i, "{B}{C:#DC143C}"&s0&"{/B}{/C}", ABM.SIZE_H6, True,"")
				page.Cell(row,1).AddComponent(titile)
			Else
				If s.StartsWith("#") Then
					Dim s0 As String = s.SubString2(1, s.IndexOf(";"))
					If s.EndsWith(";text") Then
						Dim input As ABMInput
						Dim split() As String = Regex.Split("=",linie.Get(i+1))
						input.Text = split(1)
						input.Initialize(page,  "inpText_"&split(0), ABM.INPUT_TEXT, s0&" <enter>", False, "")
						page.Cell(row,1).AddComponent(input)
					End If
					
					If s.EndsWith(";password") Then
						Dim input As ABMInput
						Dim split() As String = Regex.Split("=",linie.Get(i+1))
						input.Text = split(1)
						input.Initialize(page,  "inpText_"&split(0), ABM.INPUT_PASSWORD, s0&" <enter>", False, "")
						page.Cell(row,1).AddComponent(input)
					End If
					
					If s.EndsWith(";email") Then
						Dim input As ABMInput
						Dim split() As String = Regex.Split("=",linie.Get(i+1))
						input.Text = split(1)
						input.Initialize(page,  "inpText_"&split(0), ABM.INPUT_email, s0&" <enter>", False, "")
						page.Cell(row,1).AddComponent(input)
					End If
					
					If s.Contains("combo") Then
						Dim split() As String = Regex.Split("=",linie.Get(i+1))
						Dim val() As String = Regex.Split(",", s.SubString2(s.IndexOf("(")+1,s.IndexOf(")")))
						Dim ll As List= val
						Dim combo As ABMCombo
						combo.Initialize(page, "combo_"&split(0), s0, 200, "")
						For i1=0 To ll.Size-1
							combo.AddItem(val(i1), val(i1), ABMShared.BuildParagraph(page,"a",val(i1)))
						Next
						combo.SetActiveItemId(split(1))
						page.Cell(row,1).AddComponent(combo)
					End If
				
				
				
					If s.EndsWith(";int") Then
						Dim input3 As ABMInput
						Dim split() As String = Regex.Split("=",linie.Get(i+1))
						input3.Initialize(page,  "inpText_"&split(0), ABM.INPUT_NUMBER, s0&" <enter>", False, "")
						input3.Text = split(1)
						page.Cell(row,1).AddComponent(input3)
					End If
				
					If s.EndsWith(";bool") Then
						Dim input2 As ABMCheckbox
						Dim split() As String = Regex.Split("=",linie.Get(i+1))
						input2.Initialize(page, "inpCheck_"&split(0), s0, False,"")
						If split(1)="1" Then
							input2.State=True
						Else
							input2.State = False
						End If
						page.Cell(row,1).AddComponent(input2)
					End If
					
					If s.EndsWith(";date") Then
						Dim d As ABMDateTimePicker
						Dim split() As String = Regex.Split("=",linie.Get(i+1))
						d.Language="pl"
						d.Initialize(page,"date_"&split(0), ABM.DATETIMEPICKER_TYPE_DATE ,DateTime.Now,s0,"")
						d.SetDateISO(split(1))
						page.Cell(row,1).AddComponent(d)
					End If

				End If
			End If
		End If
	Next
	' refresh the page
	page.Refresh
	
	' Tell the browser we finished loading
	page.FinishedLoading
	' restoring the navigation bar position
	page.RestoreNavigationBarPosition
End Sub

Sub BuildSimpleItem(id As String, icon As String, Title As String) As ABMLabel
	Dim lbl As ABMLabel
	If icon <> "" Then
		lbl.Initialize(page, id, Title, ABM.SIZE_H6, True, "header")
	Else
		lbl.Initialize(page, id, Title, ABM.SIZE_H6, True, "")
	End If
	lbl.VerticalAlign = True
	lbl.IconName = icon
	Return lbl
End Sub


Sub date_Changed(Target As String, dateMilliseconds As String)
	DateTime.DateFormat="yyyy-MM-dd"
	ChangeConfig(objekt, DateTime.Date(dateMilliseconds))
End Sub

Sub combo_Clicked(itemId As String)
	ChangeConfig(objekt, itemId)
	LogDebug("combo - "&objekt&" "&itemId)
End Sub


Sub ChangeConfig(key As String, value As String) As Boolean
	Dim linia As List = File.ReadList(File.DirApp, Main.FileConfig)
	Dim newconfig As List
	newconfig.Initialize
	For Each  value0 As String In linia
		If value0.StartsWith(key.ToLowerCase&"=") Or value0.StartsWith(key.ToUpperCase&"=") Then
			newconfig.Add(value0.SubString2(0,value0.IndexOf("="))&"="&value)
			LogDebug("jest value config")
			page.ShowToast("ok","","Save change",300,False)
		Else
			newconfig.Add(value0)
		End If
	Next
	File.WriteList(File.DirApp, Main.FileConfig,newconfig)
	Main.config= File.ReadMap(File.DirApp,Main.FileConfig)

	
	Return False
End Sub


Sub inptext_LostFocus()
	Dim input As ABMInput = page.Component("inptext_"&objekt)
	ChangeConfig(objekt, input.Text)
	LogDebug("text - "&objekt&" "&input.Text)
End Sub



Sub inpcheck_Clicked(Target As String)
	Dim check As ABMCheckbox = page.Component("inpcheck_"&objekt)
	If check.State Then
		ChangeConfig(objekt, "1")
	Else
		ChangeConfig(objekt, "0")
	End If
	LogDebug("check - "&objekt&" "&check.State)
End Sub





#Region ABMPage
' clicked on the navigation bar
Sub Page_NavigationbarClicked(Action As String, Value As String)

	If Action = "Logout" Then
		ws.Session.SetAttribute("IsAuthorized","")
		ABMShared.LogOff(page)
	End If

	ABMShared.NavigateToPage(ws, ABMPageId, Value)
End Sub

Sub Page_DebugConsole(message As String)
	Log("---> " & message)
End Sub
#end region


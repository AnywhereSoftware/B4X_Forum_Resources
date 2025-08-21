B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8
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
	Public Name As String = "convert"  '<-------------------------------------------------------- IMPORTANT
	' will hold the unique browsers window id
	Private ABMPageId As String = ""
	' your own variables
	Private licznik As Int = 0
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
	
	theme.AddRowTheme("out")
	theme.Row("out").BackColor = ABM.COLOR_blue
	theme.Row("out").BackColorIntensity = ABM.INTENSITY_ACCENT1
	theme.Row("out").BorderColor = ABM.COLOR_BLACK
	theme.Row("out").BorderRadiusPx = 15
	theme.Row("out").BorderStyle = ABM.BORDER_INSET
	
	
	theme.AddLabelTheme("opis")
	theme.Label("opis").Align = ABM.ICONALIGN_CENTER
'	theme.Label("opis").ZDepth = ABM.ZDEPTH_1
	
	theme.AddRowTheme("center")
	theme.Row("center").VerticalAlign = True
End Sub

public Sub BuildPage()
	' initialize the theme
	BuildTheme
	
	' initialize this page using our theme
	page.InitializeWithTheme(Name, "/ws/" & ABMShared.AppName & "/" & Name, False, ABMShared.SessionMaxInactiveIntervalSeconds, theme)
	page.ShowLoader=True
	page.PageHTMLName = "index.html"
	page.PageTitle = "Konwersja adresu na wspolrzedne"
	page.PageDescription = "Adresy"
	page.PageKeywords = ""
	page.PageSiteMapPriority = ""
	page.PageSiteMapFrequency = ABM.SITEMAP_FREQ_YEARLY
		
	page.ShowConnectedIndicator = True
				
	' adding a navigation bar
	ABMShared.BuildNavigationBar(page, "Konwersja danych","", "", "", "")
			
#Region NOT SAVED: 2020-03-15T08:48:52
	'PHONE
	'╔═══════════════════════════════════════════════════════════════════════════════════╗
	'║ 1,1                                                                               ║
	'╠═══════════════════════════════════════════════════════════════════════════════════╣
	'║ 2,1                                                                               ║
	'╠═══════════════════════════════════════════════════════════════════════════════════╣
	'║ 3,1                                                                               ║
	'║-----------------------------------------------------------------------------------║
	'║ 3,2                                                                               ║
	'║-----------------------------------------------------------------------------------║
	'║ 3,3                                                                               ║
	'║-----------------------------------------------------------------------------------║
	'║ 3,4                                                                               ║
	'╠═══════════════════════════════════════════════════════════════════════════════════╣
	'║ 4,1                                                                               ║
	'╚═══════════════════════════════════════════════════════════════════════════════════╝

	'TABLET
	'╔═══════════════════════════════════════════════════════════════════════════════════════════════════════════╗
	'║ 1,1                                                                                                       ║
	'╠═══════════════════════════════════════════════════════════════════════════════════════════════════════════╣
	'║ 2,1                                                                                                       ║
	'╠═══════════════════════════════════════════════════════════════════════════════════════════════════════════╣
	'║ 3,1                                                                                                       ║
	'║-----------------------------------------------------------------------------------------------------------║
	'║ 3,2                                                                                                       ║
	'║-----------------------------------------------------------------------------------------------------------║
	'║ 3,3                                                                                                       ║
	'║-----------------------------------------------------------------------------------------------------------║
	'║ 3,4                                                                                                       ║
	'╠═══════════════════════════════════════════════════════════════════════════════════════════════════════════╣
	'║ 4,1                                                                                                       ║
	'╚═══════════════════════════════════════════════════════════════════════════════════════════════════════════╝

	'DESKTOP
	'╔═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗
	'║ 1,1                                                                                                                               ║
	'╠═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╣
	'║ 2,1                                                                                                                               ║
	'╠═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╣
	'║ 3,1                            | 3,2                            | 3,3                            | 3,4                            ║
	'╠═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╣
	'║ 4,1                                                                                                                               ║
	'╚═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝

	page.AddRows(2,True,"").AddCells12(1,"")
	page.AddRows(1,True,"").AddCellsOS(4,0,0,0,12,12,3,"")
	page.AddRows(1,True,"").AddCells12(1,"")
	page.BuildGrid ' IMPORTANT!
#End Region

End Sub

public Sub ConnectPage()
	'	connecting the navigation bar
	ABMShared.ConnectNavigationBar(page)
	
	If File.Exists(File.DirApp, "licznik2.txt") Then
		readlicznik
	Else
		licznik = 1
		writelicznik
	End If
	
	Dim opis As ABMLabel
	opis.Initialize(page, "opis","Konwersja  pomiędzy ukłądami współrzędnych PL (stat: "&licznik&")", ABM.SIZE_H5, False, "opis")
'	opis.VerticalAlign = True

	Dim inp As ABMInput
	inp.Initialize(page, "inputDane", ABM.INPUT_TEXT, "Dane wejeściowe", True , "")
	inp.SetTooltip("np. nr pozycji,posx,posy, wysokosc", ABM.TOOLTIP_BOTTOM, 300)
	
	Dim input As ABMCombo
	input.Initialize(page,"inputWsp", "Układ współrzędny wejściowy", 300, "")
	input.AddItem("WGS", "WGS84", ABMShared.BuildParagraph(page,"WGS84", "WGS84"))
	input.AddItem("2000/5", "2000/5", ABMShared.BuildParagraph(page,"2000/5", "2000/5"))
	input.AddItem("2000/6", "2000/6", ABMShared.BuildParagraph(page,"2000/6", "2000/6"))
	input.AddItem("2000/7", "2000/7", ABMShared.BuildParagraph(page,"2000/7", "2000/7"))
	input.AddItem("2000/8", "2000/7", ABMShared.BuildParagraph(page,"2000/8", "2000/8"))
	input.AddItem("65/1", "65/1", ABMShared.BuildParagraph(page,"65/1", "65/1"))
	input.AddItem("65/2", "65/2", ABMShared.BuildParagraph(page,"65/2", "65/2"))
	input.AddItem("65/3", "65/3", ABMShared.BuildParagraph(page,"65/3", "65/3"))
	input.AddItem("65/4", "65/4", ABMShared.BuildParagraph(page,"65/4", "65/4"))
	input.AddItem("65/5", "65/5", ABMShared.BuildParagraph(page,"65/5", "65/5"))
	input.AddItem("1992", "1992", ABMShared.BuildParagraph(page,"1992", "1992"))
	
	Dim output As ABMCombo
	output.Initialize(page,"outputWsp", "Układ współrzędny wejściowy", 300, "")
	output.AddItem("WGS", "WGS84", ABMShared.BuildParagraph(page,"WGS84", "WGS84"))
	output.AddItem("2000/5", "2000/5", ABMShared.BuildParagraph(page,"2000/5", "2000/5"))
	output.AddItem("2000/6", "2000/6", ABMShared.BuildParagraph(page,"2000/6", "2000/6"))
	output.AddItem("2000/7", "2000/7", ABMShared.BuildParagraph(page,"2000/7", "2000/7"))
	output.AddItem("2000/8", "2000/7", ABMShared.BuildParagraph(page,"2000/8", "2000/8"))
	output.AddItem("65/1", "65/1", ABMShared.BuildParagraph(page,"65/1", "65/1"))
	output.AddItem("65/2", "65/2", ABMShared.BuildParagraph(page,"65/2", "65/2"))
	output.AddItem("65/3", "65/3", ABMShared.BuildParagraph(page,"65/3", "65/3"))
	output.AddItem("65/4", "65/4", ABMShared.BuildParagraph(page,"65/4", "65/4"))
	output.AddItem("65/5", "65/5", ABMShared.BuildParagraph(page,"65/5", "65/5"))
	output.AddItem("1992", "1992", ABMShared.BuildParagraph(page,"1992", "1992"))
	
	Dim zmiana As ABMCheckbox
	zmiana.Initialize(page, "zmiana", "Zamiana X <-> Y", False , "")
	
	Dim ok As ABMButton
	ok.InitializeFlat(page,"btnok", "","", "Konwertuj", "")

	Dim out As ABMLabel
	out.Initialize(page,"out", CRLF&"Wynik ..." & CRLF,ABM.SIZE_H5,True, "")
	out.IsFlowText=False
	out.MarginLeft = "20px"

	page.Cell(1,1).AddComponent(opis)
	page.Cell(2,1).AddComponent(inp)
	page.Cell(3,1).AddComponent(input)
	page.Cell(3,2).AddComponent(output)
	page.Cell(3,3).AddComponent(zmiana)
	page.Cell(3,4).AddComponent(ok)
	page.Cell(4,1).AddComponent(out)
	page.Row(4).UseTheme("out")
	page.Cell(1,1).UseTheme("center")

	' refresh the page
	page.Refresh
	
	' Tell the browser we finished loading
	page.FinishedLoading
	' restoring the navigation bar position
	page.RestoreNavigationBarPosition
End Sub
#end region

Sub btnok_Clicked(Target As String)
	Dim inp As ABMCombo = page.Component("inputWsp")
	Dim out As ABMCombo = page.Component("outputWsp")
	Dim dane As ABMInput = page.Component("inputDane")
	Dim zamiana As ABMCheckbox = page.Component("zmiana")
	
	page.ShowToast("ok","","Licze ..", 1000, False)
'	Dim value As String
	Dim z As String
	If zamiana.State Then
		z="true"
	Else
		z="false"
	End If
	Dim rs As ResumableSub = ap.convertData(dane.Text, inp.GetActiveItemId, out.GetActiveItemId, z)
	Wait For(rs) Complete (Result As String)
	Dim lab As ABMLabel = page.Component("out")
	lab.Text = Result
	lab.Refresh
	licznik = licznik+1
	writelicznik
	Dim o As ABMLabel = page.Component("Opis")
	o.Text = "Konwersja adresu na układy współrzędne PL (stat: "&licznik&")"
	o.Refresh
	page.ShowToast("a","","OK mam",2000,False)
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


Sub readlicznik
	licznik = File.ReadString(File.DirApp,"licznik2.txt")
End Sub

Sub writelicznik
	File.WriteString(File.DirApp , "licznik2.txt", licznik)
End Sub
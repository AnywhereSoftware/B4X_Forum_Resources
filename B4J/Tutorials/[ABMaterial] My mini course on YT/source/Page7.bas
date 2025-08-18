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
	Public Name As String = "Page7"  '<-------------------------------------------------------- IMPORTANT
	' will hold the unique browsers window id
	Private ABMPageId As String = ""
	' your own variables
	Private RootFolder As String = File.DirApp & "/www/" & ABMShared.AppName & "/images/my"
	Public DownloadFolder As String ="/www/" & ABMShared.AppName & "/images/my"
	Public DownloadmaxSize As Int = 1024 * 10000 '10MB File size
	Private oldname As String
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
	ws.Session.SetAttribute("abmcallback", Me)
	ws.Session.SetAttribute("abmdownloadfolder", DownloadFolder)
	ws.Session.SetAttribute("abmmaxsize", DownloadmaxSize)
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
	page.PageTitle = "Upload"
	page.PageDescription = "Upload"
	page.PageKeywords = ""
	page.PageSiteMapPriority = ""
	page.PageSiteMapFrequency = ABM.SITEMAP_FREQ_YEARLY
		
	page.ShowConnectedIndicator = True
	' adding a navigation bar
	ABMShared.BuildNavigationBar(page, "Upload ","../images/logo.png", "", "", "")
	page.AddModalSheetTemplate(modalPicture)	
	' create the page grid
	page.AddRowsM(2,True,20,0, "").AddCells12MP(1,0,0,0,0,"")	
	
	page.BuildGrid 'IMPORTANT once you loaded the complete grid AND before you start adding components		
End Sub

public Sub ConnectPage()			
	'	connecting the navigation bar
	ABMShared.ConnectNavigationBar(page)
	
	'example picture  from https://pixabay.com
	
	Dim table As ABMTable
	table.Initialize(page, "tbl1", True, True, True,"")
	table.SetHeaders(Array As String("File name", "Size", "Time", "","",""))
	table.SetColumnWidths(Array As Int(100,100,200,10,10,10))
	table.IsBordered = True
	writeTable(table)
	
	Dim up1 As ABMFileInput
	up1.Initialize(page, "upload", "upload new file", "Down", True,"","")
	Dim up2 As ABMUpload
	up2.Initialize(page, "upload2", "Upload", "","")
	
	page.Cell(1,1).AddComponent(up1)
	page.Cell(1,1).AddComponent(up2)
	page.Cell(2,1).AddComponent(table)

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
		r.Add(lista.Get(petla))
		Dim size As String = File.Size(RootFolder, lista.Get(petla))
		r.Add(size)
		Dim d As Long = File.LastModified(RootFolder, lista.Get(petla))
		Dim dd As String = DateTime.Date(d) & " " & DateTime.Time(d)
		r.Add(dd)
		Dim btn1 As ABMLabel
		btn1.Initialize(page, "del", "Delete", ABM.SIZE_A, False, "")
		btn1.SetTooltip("Delete file", ABM.TOOLTIP_BOTTOM, 300)
		r.Add(btn1)
		
		Dim btn2 As ABMLabel
		btn2.Initialize(page, "down", "Download", ABM.SIZE_A, False, "")
		btn2.SetTooltip("Dowload file", ABM.TOOLTIP_BOTTOM, 300)
		r.Add(btn2)
		
		Dim btn3 As ABMLabel
		btn3.Initialize(page, "view", "View", ABM.SIZE_A, False, "")
		btn3.SetTooltip("View image", ABM.TOOLTIP_BOTTOM, 300)
		r.Add(btn3)
		table.AddRow(lista.Get(petla), r)
	Next
End Sub

Sub tbl1_Clicked(PassedRowsAndColumns As List)
	Dim tbl1 As ABMTable = page.Component("tbl1")
	Dim tblcellinfo As ABMTableCell = PassedRowsAndColumns.Get(0)
	Dim namefile As String = tbl1.GetActiveRow
	
	'delete file
	If tblcellinfo.Column = 3 Then
		Try
			File.Delete(RootFolder, namefile)
		Catch
			page.ShowToast("error", "", "Error delete file", 500, False)
			Log(LastException)
		End Try
			page.ShowToast("error ok ", "", "Delete file", 500, False)
		tbl1.Clear
		writeTable(tbl1)
		tbl1.Refresh
	End If
	
	'change name
	If tblcellinfo.Column = 0 Then
		oldname = namefile
		page.InputBox("rename", "New file name", "Change", "Cancel", True, ABM.MSGBOX_TYPE_QUESTION, ABM.INPUT_TEXT, namefile, "","",True, True,ABM.MSGBOX_POS_CENTER_CENTER,"")
	End If
	
	'download file
	If tblcellinfo.Column = 4 Then
		ABMShared.NavigateToPageNewTab2(ws, "", "http://localhost/get?id="&namefile, False)
	End If
	
	If tblcellinfo.Column = 5 Then
		page.ShowModalSheet("modalPicture")
		Dim modal As ABMModalSheet = page.ModalSheet("modalPicture")
		Dim img As ABMImage= modal.Content.Component("img")
		img.Source = "../images/my/" & namefile
		img.Refresh
	End If
End Sub

Sub modalPicture As ABMModalSheet
	Dim modal As ABMModalSheet
	modal.Initialize(page, "modalPicture", False, ABM.MODALSHEET_SIZE_FULL, "")
	#Region NOT SAVED: 2020-06-19T11:24:12
	'PHONE
	'╔═══════════════════════════════════════════════════════════════════════════════════╗
	'║ 1,1                                                                               ║
	'╚═══════════════════════════════════════════════════════════════════════════════════╝

	'TABLET
	'╔═══════════════════════════════════════════════════════════════════════════════════════════════════════════╗
	'║ 1,1                                                                                                       ║
	'╚═══════════════════════════════════════════════════════════════════════════════════════════════════════════╝

	'DESKTOP
	'╔═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗
	'║ 1,1                                                                                                                               ║
	'╚═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝

	modal.Content.AddRowsM(2,True,60,60,"").AddCells12(1,"")
	modal.Content.BuildGrid ' IMPORTANT!
#End Region
	Dim img As ABMImage
	img.Initialize(page, "img", "", 1.0)
	img.IsResponsive = True
	Dim  btn As ABMButton
	btn.InitializeFlat(page, "CloseImg", "","","Close Imge","")
	btn.UseFullCellWidth = True
	modal.Content.Cell(1,1).AddComponent(img)
	modal.Content.Cell(2,1).AddComponent(btn)
	
	Return modal

End Sub

Sub CloseImg_Clicked(Target As String)
	page.CloseModalSheet("modalPicture")
End Sub

Sub upload_Changed(value As String)
	LogDebug("file name: "& value)
	Dim inp1 As ABMFileInput = page.Component("upload")
	inp1.UploadToServer
End Sub


Sub page_FileUploaded(FileName As String, success As Boolean)
	Dim inp1 As ABMFileInput = page.Component("upload")
	inp1.Clear
	inp1.Refresh
	
	LogDebug(FileName & " = " & success)
	page.ShowToast("up", "","Uploading "&FileName & " : Status = "& success, 1000, False)
	page.ws.Flush
	Dim t As ABMTable = page.Component("tbl1")
	t.Clear
	writeTable(t)
	t.Refresh
End Sub

#Region ABMPage
Sub page_InputboxResult(returnName As String, result As String)
	If returnName = "rename" And result <> "abmcancel" Then
		If oldname <> result Then
			File.Copy(RootFolder, oldname, RootFolder, result)
			File.Delete(RootFolder, oldname)
			Dim t As ABMTable = page.Component("tbl1")
			t.Clear
			writeTable(t)
			t.Refresh
		Else
			page.ShowToast("er","","No name change", 500, False)
		End If
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

Sub Page_DebugConsole(message As String)
	Log("---> " & message)
End Sub
#end region


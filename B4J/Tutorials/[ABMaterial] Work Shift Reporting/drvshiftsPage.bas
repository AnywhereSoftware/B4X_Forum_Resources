B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=5.9
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
	Public Name As String = "drvshiftsPage"
	' name of the app, same as in ABMApplication
	Public AppName As String = "tripinspect"
	
	' your own variables
	Dim myToastId As Int
    Private iRecs As Int = 5	
	Dim ActiveCaseId As Int
	Dim ActiveCaseNumber, sinsp, sgroup,sitem As String
	Dim ActiveCaseUserID,CurrPage As Int
	Dim SelectedRowId As Long
	
	Dim ActiveCaseNoteID As Int
'	Dim Filter As String
	'Dim FilterCount As String
	'Dim LastSort As String = " ORDER BY CaseCreationDate DESC "
'	Dim MyPoints As Map
	'Dim MyNotAvailablePoints As Map
	Dim UserType As String
	Dim UserID, UserRows As Int
	Dim UserName As String
	Dim Attachments As Map
	Dim RemoveAttachments As Map
	Dim TypeDelete As String
		
	Public DownloadFolder As String = "\www\" & AppName & "\uploads\"
	Public DownloadMaxSize As String = 500*1024
	
	Private pagination As ABMPagination
    Private veh_type As Int = 1
	'Private tblCases As ABMTable
    Dim gen As ABMGenerator
    
	'Dim ActivetiZones As Int
    'Dim IsNewtiZones As Boolean
	
    Dim ActivetiInsp_deT As Int
    Dim IsNewtiInsp_deT As Boolean
	
	
	Dim ActivetiInsp_masT As Int
	Dim IsNewtiInsp_masT As Boolean
	
	
	Dim ActivetiInsp_Type As Int
	Dim rqry As Int = 1
	Dim IsNewtiInsp_Type As Boolean
	Private Page_name As String = ""
	Private qtrl, qtrk, qsd, qed As String
	
	Private SQL_str, SQL_Str2, SQL_EXPORT, SQL_Loadsqry, SQL_Logsqry As String
    Private daychk As Boolean = False
	Private nightchk As Boolean = False
	Private incchk As Boolean = False
	
	Private  comqry As String = " AND completed = 0 "
    Private isdetnote As Boolean = False
	Private detmast As String = 0
	
	Dim ActivetiShift As Long
	Dim IsNewtiShift As Boolean
'	Dim export As Boolean = False
    Dim shiftfilename As String = ""
	Dim xlsfolder, xlssavepath As String
	Private ssd, sed, scdrv As String
	Private sdet As Int = 0
	
	
	Private ABMPageId As String = ""
		
	
End Sub


'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
	InitPublicVars
	' build the local structure IMPORTANT!
	BuildPage

End Sub


Sub InitPublicVars
	
	Log("shifts page inited..")
	DateTime.DateFormat = "yyyy-MM-dd"
	
    If Main.isdemo Then
		qsd = DateTime.DateParse(Main.startdate)
	Else	
		qsd = DateTime.Now - (DateTime.TicksPerDay * 2)
	End If
	qsd = DateTime.DateParse( DateTime.Date(qsd)) 
	
	qtrl = "0"
	qtrk = "0"
	
	qed = DateTime.Now
	If File.Exists(File.DirApp,"pathmap.map") Then
		Dim pt As Map
		pt.Initialize
		pt = File.ReadMap(File.DirApp, "pathmap.map" )
		xlsfolder   = pt.GetDefault("xlspath","/shiftrpts")
		xlssavepath = pt.GetDefault("xlssave","")
		Log("What is xlsfolder: "&xlsfolder)
	Else
	   xlsfolder = 	"/shiftrpts"	
		Log(" could not find map What is xlsfolder: "&xlsfolder)

	End If
	

End Sub


Private Sub WebSocket_Connected (WebSocket1 As WebSocket)
    Log("  ----"&Name&" view ws Connected")
	
	ws = WebSocket1	
	ABMPageId = ABM.GetPageID( page,  Name, ws)
	Dim session As HttpSession = ABM.GetSession(ws, ABMShared.SessionMaxInactiveIntervalSeconds)
	If session.IsNew Then
		session.Invalidate
		ABMShared.NavigateToPage(ws, "", "./")
		Return
	End If
'	Dim session As HttpSession = ABM.GetSession(ws, ABMShared.SessionMaxInactiveIntervalSeconds)
	
	If ABMShared.NeedsAuthorization Then
		If session.GetAttribute2("IsAuthorized", "") = "" Then
			ABMShared.NavigateToPage(ws, ABMPageId, "../")
			Return
		End If
	End If		
	
	ABM.UpdateFromCache(Me, ABMShared.CachedPages, ABMPageId, ws)
	If page.ComesFromPageCache Then
		' refresh the page
		page.Refresh
		' because we use ShowLoaderType=ABM.LOADER_TYPE_MANUAL
		page.FinishedLoading
	Else
    	   If page.WebsocketReconnected Then
	      Log("Websocket reconnected")
             ' when we have a client that doesn't have the page in cache and it's websocket reconnected and also it's session is new - basically when the client 
	      ' had internet problems and it's session (and also cache) expired before he reconnected so the user has content in the browser but we don't have 
             ' any on the server. So we need to reload the page.
             ' when a client that doesn't have the page in cache and it's websocket reconnected but it's session is not new - when the client had internet 
	      ' problems and when he reconnected it's session was valid but he had no cache for this page we need to reload the page as the user browser has 
             ' content, reconnected but we have no content in cache
             ABMShared.NavigateToPage (ws, ABMPageId, "./" & page.PageHTMLName)
    	   Else
             ' when the client did not reconnected it doesn't matter if the session was new or not because this is the websockets first connection so no dynamic 
             ' content in the browser ... we are going to serve the dynamic content...
             Log("Websocket first connection")
	         page.Prepare
             ConnectPage
    	   End If
				
	End If

	page.RestoreNavigationBarPosition
	page.NavigationBar.Refresh

	Log(Name &ABMPageId)
End Sub


'
Private Sub WebSocket_Disconnected
	Log(" zone Disconnected")
End Sub


Sub Page_ParseEvent(Params As Map) 
    Dim eventName As String = Params.Get("eventname")
    Dim eventParams() As String = Regex.Split(",",Params.Get("eventparams"))
    If eventName = "beforeunload" Then
        Log("preparing for shifts url refresh")
'        ws.session.SetAttribute("ABMNewSession", True)
		ABM.RemoveMeFromCache(ABMShared.CachedPages, ABMPageId)	

        Return
    End If
    If SubExists(Me, eventName) Then
        Params.Remove("eventname")
        Params.Remove("eventparams")
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
                ' cannot be called diretly, to many param
                CallSub2(Me, eventName, Params)                
        End Select
    End If
End Sub




Sub btntruck_Clicked(Target As String)
	veh_type = 1
   Dim cmb As ABMCombo =    page.Component("combtrk")  '  .GetActiveItemId
   Dim combtrl As ABMCombo =    page.Component("combtrl")  '  .GetActiveItemId
   qtrk = "0"
   qtrl = "0"
   combtrl.SetActiveItemId("0")
   cmb.SetActiveItemId("0")
   combtrl.Refresh
   cmb.Refresh
   
  '  combtrk_clicked("ALL")	
	
	LoadCases(1)
End Sub

Sub btntrailer_Clicked(Target As String)
	veh_type = 2
   Dim cmb As ABMCombo =    page.Component("combtrk")  '  .GetActiveItemId
   Dim combtrl As ABMCombo =    page.Component("combtrl")  '  .GetActiveItemId
   qtrk = "0"
   qtrl = "0"
   combtrl.SetActiveItemId("0")
   cmb.SetActiveItemId("0")
   combtrl.Refresh
   cmb.Refresh

    'combtrl_clicked("ALL")	
	LoadCases(1)
End Sub



Sub combtrk_clicked(Target As String)

   Dim cmb As ABMCombo =    page.Component("combtrk")  '  .GetActiveItemId
   If Target = "ALL" Then
     qtrk = "0"
   Else
      qtrk = cmb.GetActiveItemId
   End If
   
   LoadCases(1)
 	
End Sub


public Sub BuildPage()
	
	Private pagination As ABMPagination

	' initialize the theme
	BuildTheme
	
	' initialize this page using our theme
'	page.InitializeWithTheme(Name,   "/ws/" & AppName & "/" & Name,  False,  theme)
	page.InitializeWithTheme(Name, "/ws/" & ABMShared.AppName & "/" & Name, False, ABMShared.SessionMaxInactiveIntervalSeconds, theme)
	
	page.ShowLoader=True
	page.ShowLoaderType=ABM.LOADER_TYPE_MANUAL ' NEW
	
	page.NeedsCheckbox = True

	ABMShared.BuildNavigationBar(page, Page_name  , "../images/logo.png",  "",  "Apps",   Page_name)
	' create the page grid
    page.AddRowsM( 1,True,  15,  0, "rowtheme").AddCellsOSMP(1,0,0,0, 3,3,3,  15 , 5, 10,0,"cnter").AddCellsOSMP(1,0,0,0,3,3,3, 15,5, 30,10,"cnter").AddCellsOSMP(1,0,0,0,3,3,3, 15,5,30,10,"cnter").AddCellsOSMP(1,0,0,0,3,3,3,15,5,30,10,"cnter")
    page.AddRowsM( 1,True,  -3,   0, "rowtheme1").AddCellsOSMP(1,0,0,0, 3,3,3,  25 , 5, 0,0,"cnter").AddCellsOSMP(1,0,0,0,3,3,3,25,5,30,10,"cnter").AddCellsOSMP(1,0,0,0,3,3,3, 25,5, 30,10,"cnter").AddCellsOSMP(1,0,0,0,3,3,3,5,5,30,10,"cnter")
		
	page.AddRowsM( 1,True,  15,  5, "").AddCellsOSMP( 1,0,0,0,12,12,12,  0,  0, 0,  15,"") '.AddCellsOSMP( 1,0,0,0,6,6,6,0,0,3,3,"")
	page.AddRowsM( 1,True,  5,   5, "").AddCellsOSMP( 1,0,0,0,12,12,12,  0,  0, 0,  15,"") '.AddCellsOSMP( 1,0,0,0,6,6,6,0,0,3,3,"")
	
	page.AddRowsM( 1,True,  15,  5, "").AddCellsOSMP( 1,0,0,0,6,6,6,0,0 , 15,0,"").AddCellsOSMP( 1,0,0,0,6,6,6,0,0,3,3,"")

	page.AddRows(  1,True,"").AddCells12( 1,"")	
	
	' add button
	page.AddRowsM( 1,True,  10,  5, "").AddCells12(  1,"modalfooter")	
	

	page.BuildGrid 'IMPORTANT once you loaded the complete grid AND before you start adding components
	
	
    BuildMsgBox	
	BuildFooterFixed

	
End Sub

Sub btnincshifts_clicked(target As String)
	Dim incomp As ABMCheckbox = page.Component("btnincshifts")

	If incomp.State Then
		incchk = True
	Else
		incchk = False	
	End If
	
	LoadCases(1)
	
End Sub

Sub ConnectPage()
	
	ABMShared.ConnectNavigationBar(page)

	
	Dim combtrk As ABMCombo
	combtrk.Initialize(page, "combtrk","SELECT A DRIVER",500, "")
	
    combtrk.AddItem(  "0", "ALL", BuildSimpleItem(""&"0", "mdi-action-star-rate", "{NBSP}{NBSP}"&"ALL"))

	Dim sql As SQL = DBM.GetSQL
	Dim users As List = DBM.SQLSelect(sql, "SELECT * FROM emp where comp_id = "&Main.comp_id&" AND emptype > 0 Order by Last_name") ' WHERE userId=" & SelectedRowId)
	
'	Dim users As List = DBM.SQLSelect(sql, "SELECT * FROM emp where comp_id = "&Main.comp_id&" Order by Last_name") ' WHERE userId=" & SelectedRowId)
	If users.Size > 0 Then
		For i = 0 To users.Size -1
		   Dim user As Map = users.Get(i)
		   Dim id As String = user.Get("pk")
		   Dim val As String = user.Get("last_name")&", "&user.Get("first_name")
	       combtrk.AddItem(  id, val, BuildSimpleItem(""&id, "mdi-action-star-rate", "{NBSP}{NBSP}"&val))
		Next    
	End If
	DBM.CloseSQL(sql)
	combtrk.SetActiveItemId("0")

	page.Cell(2,1).AddComponent(combtrk)
'
'	Dim btnout As ABMButton
'	btnout.InitializeFlat( page , "btnout", "mdi-action-open-with", ABM.ICONALIGN_LEFT, "Export TO Excel","amber")
'	btnout.InitializeFlat( page , "btnout", "mdi-action-open-with", ABM.ICONALIGN_LEFT, "Show Incompleted","amber")

	Dim btnincshifts As ABMCheckbox
	btnincshifts.Initialize( page ,  "btnincshifts", "Not Completed", False,"")
	btnincshifts.IsFilled = True
	page.Cell(1,1).AddComponent(btnincshifts)


'    page.Cell(1,1).AddComponent(btnout)
	
	Dim btnallshifts As ABMCheckbox
	btnallshifts.Initialize( page ,  "btnallshifts", "ALL Shifts", True,"")
	btnallshifts.IsFilled = True
	page.Cell(1,2).AddComponent(btnallshifts)


	Dim btnalldef As ABMCheckbox
	btnalldef.Initialize( page ,  "btnalldef", "DAY Shifts Only", False,"")
	btnalldef.IsFilled = True
	page.Cell(1,3).AddComponent(btnalldef)
	
	Dim btnallveh As ABMCheckbox
	btnallveh.Initialize( page ,  "btnallveh", "NIGHT Shifts Only", False,"")
	btnallveh.IsFilled = True
	page.Cell(1,4).AddComponent(btnallveh)
	
'    Dim lblxls As ABMLabel
'    lblxls.Initialize(page,"lblxls","  XLS LINK: ",ABM.SIZE_H6,True,"")
'	page.Cell(2,4).AddComponent(lblxls)

'	Dim btnout As ABMButton
'	btnout.InitializeFlat( page , "btnout", "mdi-action-open-with", ABM.ICONALIGN_LEFT, "Fleet Avg","amber")
'	page.Cell(2,4).AddComponent(btnout)
'


	
	Dim startdate As ABMDateTimePicker
	startdate.Initialize(page, "startdate",ABM.DATETIMEPICKER_TYPE_DATETIME ,qsd,"START DATE","") ' ABM.INPUT_TEXT, "Plate #", False, "lightblue")
	startdate.ClearText = ""
	page.Cell(2,2).AddComponent(startdate)


	Dim enddate As ABMDateTimePicker
	enddate.Initialize(page, "enddate",ABM.DATETIMEPICKER_TYPE_DATETIME , qed," END DATE","") ' ABM.INPUT_TEXT, "Plate #", False, "lightblue")
	enddate.ClearText = ""
	page.Cell(2,3).AddComponent(enddate)

	page.AddModalSheetTemplate(BuildMsgBox)
	page.AddModalSheetTemplate(BuildImageBox)

	page.AddModalSheetTemplate(ABMGenBuildtiShift)
	page.AddModalSheetTemplate(ABMGenBuildtiShiftDelete)
	page.AddModalSheetTemplate(ABMGenBuildtiShiftBadInput)
	
	page.AddModalSheetTemplate(BuildShiftDetail)
	

	' create  tables
	Dim tblCases As ABMTable
	tblCases.Initialize(page, "tblCases",    False,  True, True, "tbltheme")
	tblCases.SetHeaders(         Array As String("PK","Shift ID", "Driver" ,"Vehicle","Start Date","End Date","Actual","PAID","Shift","Printed","Edit","Details" ))
	tblCases.SetHeaderThemes(    Array As String( "bgb","bgb", "bgc","bgc" , "bgc", "bgc" ,"bgc","bgc","bgc","bgc","bgc","bgc"    ))
    tblCases.SetColumnVisible(    Array As Boolean(False, True, True,True,  True    , True,  True, True, True, True,True,True))
	tblCases.SetColumnWidths(     Array As Int(70,70, 180,70,150,150,90,90,85,50,50,50))

    page.Cell(3,1).AddComponent(tblCases)

    page.FinishedLoading 'IMPORTANT	
    Page_name = page.ws.Session.GetAttribute2( "UserAction", "")

	page.RestoreNavigationBarPosition

	page.Footer.Refresh
	
	LoadCases(1)
 
    page.NavigationBar.Title = "Driver Work Shifts" 'page.ws.Session.GetAttribute2( "UserAction", "")
 
    page.Refresh
	
	

End Sub


Sub SetQuery(fromPage As Int )

	
	If incchk Then
		SQL_str = "SELECT Count(pk) as IDS FROM shiftmast WHERE comp_id = "&Main.comp_id&" AND sdate >= "&qsd&" AND edate = 0 " '"&qsd&" AND sdate < "&qed
		SQL_Str2 = "SELECT pk, shftid, drvid,trknum, sdate, edate, edate as ttime, edate as adjust, sdate as stype, printed FROM shiftmast WHERE comp_id = "&Main.comp_id&" AND sdate >= "&qsd&" AND edate = 0" ' &qsd&" AND sdate < "&qed
		
	Else
		SQL_str = "SELECT Count(pk) as IDS FROM shiftmast WHERE comp_id = "&Main.comp_id&" AND sdate >= "&qsd&" AND sdate < "&qed
		SQL_Str2 = "SELECT pk, shftid,drvid,trknum, sdate, edate, edate as ttime, edate as adjust, sdate as stype, printed FROM shiftmast WHERE comp_id = "&Main.comp_id&" AND sdate >= "&qsd&" AND sdate < "&qed
			
	End If
	
'	SQL_str = "SELECT Count(pk) as IDS FROM shiftmast WHERE comp_id = "&Main.comp_id&" AND sdate >= "&qsd&" AND sdate < "&qed
'	SQL_Str2 = "SELECT pk, drvid, sdate, edate, edate as ttime, edate as adjust, sdate as stype, printed FROM shiftmast WHERE comp_id = "&Main.comp_id&" AND sdate >= "&qsd&" AND sdate < "&qed
	
	
	SQL_EXPORT = "SELECT pk, shftid, drvid as pin, drvid, sdate, edate, edate as ttime, edate as adjust, sdate as stype, printed FROM shiftmast WHERE comp_id = "&Main.comp_id&" AND sdate >= "&qsd&" AND sdate < "&qed
		
	If qtrk <> "0" Then
	   SQL_str = SQL_str&" AND drvid = "&qtrk&" "
	   SQL_Str2 = SQL_Str2&" AND drvid = "&qtrk&" "
	   SQL_EXPORT = SQL_EXPORT&" AND drvid = "&qtrk&" "	
	End If
'
	If daychk Then
	   SQL_str = SQL_str&" AND  HOUR(FROM_UNIXTIME(sdate / 1000))  < 12"
	   SQL_Str2 = SQL_Str2&" AND HOUR(FROM_UNIXTIME(sdate / 1000)) < 12"	
	   SQL_EXPORT = SQL_EXPORT&" AND HOUR(FROM_UNIXTIME(sdate / 1000)) < 12"
	End If

	If nightchk Then
		SQL_str = SQL_str&" AND  HOUR(FROM_UNIXTIME(sdate / 1000))  >= 12"
		SQL_Str2 = SQL_Str2&" AND HOUR(FROM_UNIXTIME(sdate / 1000)) >= 12"
		SQL_EXPORT = SQL_EXPORT&" AND HOUR(FROM_UNIXTIME(sdate / 1000)) >= 12"
	End If

	SQL_EXPORT = SQL_EXPORT&" ORDER BY drvid ASC, sdate ASC " '&" LIMIT "& ((fromPage - 1) * iRecs) & ", "&iRecs
	SQL_Str2 = SQL_Str2&" ORDER BY drvid ASC, sdate ASC "&" LIMIT "& ((fromPage - 1) * iRecs) & ", "&iRecs
		
	Log(" Query 1: "&SQL_str)	
	Log(" Query 2: "&SQL_Str2)	
	
End Sub



private Sub LoadCases(fromPage As Int)	

	Dim tblCases As ABMTable = page.Component("tblCases")	
	
	Dim SQL As SQL = DBM.GetSQL
	Dim SQL_str, SQL_Str2 As String

    Log(" Current Page: "&Page_name)
    CurrPage = fromPage

    SetQuery(fromPage)
    DateTime.DateFormat = "yyyy/MM/dd"

    Dim numcases As Int = DBM.SQLSelectSingleResult(SQL, SQL_str)
 
	Dim cases As List = DBM.SQLSelect(SQL, SQL_Str2)
	If cases.Size = 0 And fromPage > 1 Then
		' we are on a page without any lines (maybe removed by other user?) 
		DBM.CloseSQL(SQL)
		fromPage = fromPage - 1
		LoadCases(fromPage)
		Log(" ---something amiss here")
		Return
	End If

	tblCases.SetFooter("Total number of records: " & numcases, 12,"bg")
	tblCases.Clear
    Dim firstvar As String = "0"

	For i = 0 To cases.Size - 1
		Dim tblFields As Map = cases.Get(i)

		If i = 0 Then
		   firstvar = tblFields.GetValueAt(i+1)
'		   Log("first var:"&firstvar)
		End If

		Dim rCellValues As List
		Dim rCellThemes As List
		rCellValues.Initialize
		rCellThemes.Initialize
		
		For j = 0 To tblFields.Size - 1	
			Dim var As String
			var = 	tblFields.GetValueAt(j) ' init as string to avoid null_pointer error
			If var = "null" Then
				var = ""
			End If
			If tblFields.GetKeyAt(j) = "pk" Then
				rCellValues.Add(var)
				rCellThemes.Add("nocolor")
				Continue
			End If

			If tblFields.GetKeyAt(j) = "shftid" Then
				rCellValues.Add(var)
				rCellThemes.Add("nocolor")
				Continue
			End If
			
			   
            If tblFields.GetKeyAt(j) = "drvid" Then
                    Dim pd As ABMLabel
					pd.Initialize(page,"drv"&j,"",ABM.SIZE_PARAGRAPH,False,"")
					pd.Text =  ABMShared.GetDriverNamePIN(var) ' &" - "&DateTime.Time(tblFields.GetValueAt(j)) 
				    rCellValues.Add(pd)
				    rCellThemes.Add("nocolor")
					'Log("  What is driver: "&pd.Text)
					Continue
		    End If
			   

			If tblFields.GetKeyAt(j) = "trknum" Then
				rCellValues.Add(var)
				rCellThemes.Add("nocolor")
				Continue
			End If



			If tblFields.GetKeyAt(j) = "sdate" Then
				  Dim l As Long
				  l = var
				  Dim str As String
				  DateTime.TimeFormat = "HH:mm"
				  str = DateTime.Date(l)&" - "&DateTime.Time(l)
				  Dim lb As ABMLabel
				  lb.Initialize(page,"lb"&j,str,ABM.SIZE_PARAGRAPH,False,"lbbold")
			      rCellValues.Add(lb)
			      rCellThemes.Add("nocolor")
                  Continue
			   End If	 


			   If tblFields.GetKeyAt(j) = "edate" Then
				  Dim l As Long
				  l = var
				  Dim str As String
				  DateTime.TimeFormat = "HH:mm"
				  If l = 0 Then
				  	str = "Not Completed"
				  Else	
				    str = DateTime.Date(l)&" - "&DateTime.Time(l)
				  End If
				  Dim lb As ABMLabel
				  lb.Initialize(page,"lb"&j,str,ABM.SIZE_PARAGRAPH,False,"lbbold")
			      rCellValues.Add(lb)
			      rCellThemes.Add("nocolor")
                  Continue
			   End If	 


			   If tblFields.GetKeyAt(j) = "ttime" Then
				  Dim l, ss, tt As Long
				  l = tblFields.GetValueAt(5)
				  ss = tblFields.GetValueAt(4)
				  Dim str As String
				  DateTime.TimeFormat = "HH:mm"
				  If l = 0 Then
				  	str = "N/A"
				  Else	
				  	tt = l - ss
				    str = ABMShared.ShowTimeFormat(tt) ' DateTime.Date(l)&" - "&DateTime.Time(l)
				  End If
				  Dim lb As ABMLabel
				  lb.Initialize(page,"lb"&j,str,ABM.SIZE_H5,False,"lbbold")
			      rCellValues.Add(lb)
			      rCellThemes.Add("nocolor")
                  Continue
			   End If	 

			   If tblFields.GetKeyAt(j) = "adjust" Then
				  Dim l, ss, tt As Long
				  l = tblFields.GetValueAt(5)
				  ss = tblFields.GetValueAt(4)
				  Dim str As String
				  DateTime.TimeFormat = "HH:mm"
				  If l = 0 Then
				  	str = "N/A"
				  Else	
				  	tt = l - ss
				    str = ABMShared.ShowTimeRound(tt) ' DateTime.Date(l)&" - "&DateTime.Time(l)
				  End If
				  Dim lb As ABMLabel
				  lb.Initialize(page,"lb"&j,str,ABM.SIZE_H5,False,"lbboldblue")
			      rCellValues.Add(lb)
			      rCellThemes.Add("nocolor")
				Continue
			End If
				
			If tblFields.GetKeyAt(j) = "stype" Then
				Dim l As Long
				l = var
				Dim str As String
				DateTime.TimeFormat = "HH:mm"
				If DateTime.GetHour(l) >= 12 Then
					str = "NIGHT"
				Else
					str = "DAY"
				End If
				  	 	 				  	
				Dim lb As ABMLabel
				lb.Initialize(page,"lb"&j,str,ABM.SIZE_H5,False,"lbbold")
				rCellValues.Add(lb)
				rCellThemes.Add("nocolor")
				Continue
			End If
				
			If tblFields.GetKeyAt(j) = "printed" Then
				Dim val As Int
				val = var
				  
				Dim btndone As ABMButton
				If val > 0 Then
					btndone.InitializeFloating(page, "btndone", "mdi-action-done", "")
				Else
					btndone.InitializeFloating(page, "btndone", "mdi-content-clear", "")
				End If
				rCellValues.Add(btndone)
				rCellThemes.Add("nocolor")
				  
				Continue
			End If


				
		Next		
		Dim btnedit As ABMButton
	    btnedit.InitializeFloating(page, "btnedit", "mdi-action-visibility", "")
		rCellValues.Add(btnedit)
		rCellThemes.Add("nocolor")	

		Dim btndetail As ABMButton
	    btndetail.InitializeFloating(page, "btndetail", "mdi-editor-format-list-numbered", "")
		rCellValues.Add(btndetail)
		rCellThemes.Add("nocolor")	


	
		tblCases.AddRow(  "uid" & i, rCellValues) 
		tblCases.SetRowThemes(rCellThemes) ' make sure you have as many items in rCellThemes as in rCellValues!  Must follow IMMEDIATELY AFTER AddRow!
	Next
	tblCases.Refresh
	
	DBM.CloseSQL(SQL)
	
	If (numcases Mod iRecs > 0) Or (numcases = 0) Then
		numcases = numcases/iRecs + 1
	Else
		numcases = numcases/iRecs
	End If

	pagination.SetTotalNumberOfPages(numcases)
	pagination.SetActivePage(fromPage)
	pagination.Refresh


End Sub

Sub page_MsgboxResult(returnName As String, result As String)

	If result = ABM.MSGBOX_RESULT_OK Then
		Log(" OK was pressed   Return name "&returnName&"  result: "&result)
	End If

	Select Case returnName
		Case "reprint"
			Select Case result
			
				Case  "abmok" '  ABM.INPUTBOX_RESULT_CANCEL, ABM.INPUTBOX_RESULT_CLOSE, ABM.INPUTBOX_RESULT_ESC, ABM.INPUTBOX_RESULT_OVERLAY, ABM.INPUTBOX_RESULT_INVALID
					Dim SQL As SQL = DBM.GetSQL
					SQL.ExecNonQuery("UPDATE shiftmast SET printed =  0  WHERE pk = "&SelectedRowId)
					DBM.CloseSQL(SQL)
					LoadCases(CurrPage)
					Log(" set printed to 0: "&SelectedRowId)

					page.ShowToast("toast" & myToastId, "toastred", " Re-Printing Shift Report", 4000, False)
			End Select
	End Select
     
End Sub


Sub tblCases_Clicked(PassedRowsAndColumns As List)
	' fill with the active values
	Dim tblCellInfo As ABMTableCell = PassedRowsAndColumns.Get(0)
	Dim tblCases As ABMTable = page.Component(tblCellInfo.TableName)

	SelectedRowId = tblCases.GetString(tblCellInfo.Row, 0)
	Log(" what is sel: "&SelectedRowId)

	If tblCellInfo.Column = 9 Then ' set not printed
		page.Msgbox2("reprint", "",  "Re-Print This Shift Report?","PRINT","Cancel", False, ABM.MSGBOX_TYPE_QUESTION,  False,   ABM.MSGBOX_POS_CENTER_CENTER,   "")
    End If
	
  
	If tblCellInfo.Column = 10 Then ' set completed
	  Log(" what is sel: "&SelectedRowId)
      ABMGentiShiftEdit(SelectedRowId)		
    End If
	 
	 If  tblCellInfo.Column = 11 Then 
        ABMGentiShiftDetailShow(SelectedRowId)	
        page.ShowModalSheet("tiShiftDetail")
	End If
End Sub


 Sub tbldetl_clicked(PassedRowsAndColumns As List)
 	
	Dim tblCellInfo As ABMTableCell = PassedRowsAndColumns.Get(0)
	Dim tblCases As ABMTable = page.Component(tblCellInfo.TableName)
	SelectedRowId = tblCases.GetString(tblCellInfo.Row,  0)
	'Dim zonenum = tblCases.GetString(tblCellInfo.Row,  1)
'	SQL_Str3 =	"SELECT id, pk, item_name, defect,note as detnote, completed, note, completed as detcomp  FROM ti_c_det WHERE pk = "&fvar

	If tblCellInfo.Column = 5 Then
'		ABMGentiInsp_deTEdit(SelectedRowId)
'		Toast("edit this item: "&SelectedRowId,3000)
		tblCases.PrepareTableForRetrieval
       Dim gv As Int
	   gv = tblCases.GetString(tblCellInfo.Row, 7)
	   Log(" what was gv: "&gv)

       If gv = 1 Then
	   	 Toast(" Already Completed!",2000)
		 Return
	   End If	

	   If gv = 0 Then
	   	  gv = 1
	   Else
	   	  gv = 0
	   End If
	   Log(" what is detail gv now: "&gv&"  what  id: "&tblCases.GetString(tblCellInfo.Row, 0)&"  mast rec: "&tblCases.GetString(tblCellInfo.Row, 1))
	   
	   	Dim SQL As SQL = DBM.GetSQL
'		SQL.ExecNonQuery("UPDATE ti_c_mast SET completed = "&gv&" WHERE id = "&tblCases.GetString(tblCellInfo.Row, 0))
		SQL.ExecNonQuery("UPDATE ti_c_det SET completed = "&gv&" WHERE id = "&tblCases.GetString(tblCellInfo.Row, 0))
		
        DBM.CloseSQL(SQL)
	   
	   tblCases.SetString(tblCellInfo.Row, 7, gv)
	'   tblCases.SetString(tblCellInfo.Row, 8, gv)
	   
	   LoadItems(1,tblCases.GetString(tblCellInfo.Row, 1),1)


	End If
	
	
	If tblCellInfo.Column = 6 Then 
		CreateDetNote(PassedRowsAndColumns)
    End If   

	
End Sub



private Sub LoadItems(fromPage As Int,fvar As String, detid As String)	
	Dim tblitems As ABMTable = page.Component("tbldetl")	
	
	Dim SQL As SQL = DBM.GetSQL
	Dim  SQL_Str3 As String

'   SQL_Str3 =	"SELECT id, pk, item_name, defect, note, completed, completed as detcomp, note as detnote  FROM ti_c_det WHERE pk = "&fvar
	SQL_Str3 =	"SELECT id, pk, item_name, defect,note as detnote, completed, note, completed as detcomp  FROM ti_c_det WHERE pk = "&fvar

    Log(" what is detail qry: "&SQL_Str3)
'	tbldetl.SetHeaders(         Array As String( "ITEM ID"  ,"Item Name", "Defect Type" , "Notes", "Done " ,"val"  ))


 
	Dim cases As List = DBM.SQLSelect(SQL, SQL_Str3)
	tblitems.Clear
	For i = 0 To cases.Size - 1
		Dim tblFields As Map = cases.Get(i)

		Dim rCellValues As List
		Dim rCellThemes As List
		rCellValues.Initialize
		rCellThemes.Initialize
		
		For j = 0 To tblFields.Size - 1	
			Dim var As String
			var = 	tblFields.GetValueAt(j) ' init as string to avoid null_pointer error
			If var = "null" Then
			    var = ""
			End If
			   

			   If tblFields.GetKeyAt(j) = "detnote" Then
				  Dim lb As ABMLabel
				  lb.Initialize(page,"lb"&j,var,ABM.SIZE_PARAGRAPH, True,"")
			      rCellValues.Add(lb)
			      rCellThemes.Add("nocolor")
                  Continue
						
			   End If


			   If tblFields.GetKeyAt(j) = "note" Then
					Dim btnnotes As ABMButton
				    btnnotes.InitializeFloating(page, "btnnotes1", "mdi-action-assignment", "")
					rCellValues.Add(btnnotes)
					rCellThemes.Add("nocolor")	
                    Continue
						
			   End If

			   If tblFields.GetKeyAt(j) = "completed" Then
			      Dim val As Int
				  val = var
				  
					Dim btndone As ABMButton
					If val > 0 Then
					   btndone.InitializeFloating(page, "btndone1", "mdi-toggle-check-box", "")
					Else
					   btndone.InitializeFloating(page, "btndone1", "mdi-toggle-check-box-outline-blank", "")
					End If			
					rCellValues.Add(btndone)
					rCellThemes.Add("nocolor")	
				    Continue
			   End If	 

			rCellValues.Add(var)
			rCellThemes.Add("nocolor")	

		Next		
		tblitems.AddRow(  "uid" & i, rCellValues) 
		tblitems.SetRowThemes(rCellThemes) ' make sure you have as many items in rCellThemes as in rCellValues!  Must follow IMMEDIATELY AFTER AddRow!
	Next
	tblitems.Refresh
	
	DBM.CloseSQL(SQL)
	
	Log(" finished in loaditems")
	
End Sub


Sub BuildImageBox() As ABMModalSheet
	Dim msgbox As ABMModalSheet
	msgbox.Initialize(page, "imgbox",  True, False,"")
	msgbox.IsDismissible = False
	'msgbox.Size = ABM.MODALSHEET_SIZE_LARGE
	msgbox.Content.AddRowsM(1, True,0,0, "").AddCells12(1, "")
	msgbox.Content.AddRowsM(1, True,0,0, "").AddCells12(1, "")
	msgbox.Content.AddRowsM(1, True,0,0, "").AddCells12(1, "")
	msgbox.Content.AddRowsM(1, True,0,0, "").AddCells12(1, "")
	
'	msgbox.Content.AddRows(1 , True, "") .AddCellsOSMP(1,0,0,0,6, 6,6, 0, 0,0,0,  "").AddCellsOSMP(1,0,0,0,6,6,6,0,0,0,0,  "")
	
	msgbox.Content.BuildGrid
	
	' add paragraph	
	'msgbox.Content.CellR(0,1).AddComponent(ABMShared.BuildParagraph(page,"par1"," Set Date Range") )
	msgbox.Content.CellR(0,1).AddComponent(ABMShared.BuildParagraphBQWithZDepth(page,"par1","  Set XLS Export File Name and Path") )
	
		
	
		Dim fname As ABMInput
        fname.Initialize(page,"fname",ABM.INPUT_TEXT,"File Name", False,"")
		msgbox.Content.Cell(2,1).AddComponent(fname)
				

		Dim pname As ABMInput
        pname.Initialize(page,"pname",ABM.INPUT_TEXT,"HTTP Get From Path",False,"")
		msgbox.Content.Cell(3,1).AddComponent(pname)

		Dim savepath As ABMInput
        savepath.Initialize(page,"savepath",ABM.INPUT_TEXT,"File Save To Path",False,"")
		msgbox.Content.Cell(4,1).AddComponent(savepath)

	
	msgbox.Footer.AddRowsM (1,True,0, 0, "").AddCells12(1,"")
	msgbox.Footer.BuildGrid 'IMPORTANT once you loaded the complete grid AND before you start adding components
	
	' create the buttons for the footer

	Dim msgcan As ABMButton
	msgcan.InitializeFlat(page, "imgbxcan", "mdi-content-clear",  ABM.ICONALIGN_LEFT, "  Cancel  ", "transparent")
	msgbox.Footer.Cell(1,1).AddComponent(msgcan)

	Dim msgok As ABMButton
	msgok.InitializeFlat(page, "imgbxok", "mdi-navigation-check",  ABM.ICONALIGN_LEFT, "  Export  ", "transparent")
	msgbox.Footer.Cell(1,1).AddComponent(msgok)
	
	Return msgbox
End Sub

Sub imgbxcan_Clicked(Target As String)	
	page.CloseModalSheet("imgbox")
End Sub



Sub imgbxok_Clicked(Target As String)	

	'Toast(" Creating XLS File",2000)
	
	Dim inp As ABMModalSheet = page.ModalSheet("imgbox")
	Dim fname As ABMInput = inp.Content.Component("fname")
	Dim pname As ABMInput = inp.Content.Component("pname")
	Dim sname As ABMInput = inp.Content.Component("savepath")

    shiftfilename = fname.Text
    xlsfolder = pname.Text
	xlssavepath = sname.Text
	
    Dim pathmap As Map
	pathmap.Initialize
	pathmap.Put("xlspath",xlsfolder)
	pathmap.Put("xlssave",xlssavepath)
	
	File.WriteMap(File.DirApp, "pathmap.map", pathmap) 
  	
	page.CloseModalSheet("imgbox")

'	SaveXLSExport
	
End Sub

Sub SetExport
	' fill with the active values
	
		Dim inp As ABMModalSheet = page.ModalSheet("imgbox")
		Dim fname As ABMInput = inp.Content.Component("fname")
	    
		DateTime.DateFormat = "yyyy_MM_dd"
	    DateTime.TimeFormat = "HH_mm"
        fname.Text = "shifts_"&DateTime.Date(DateTime.Now)&"_"&DateTime.Time(DateTime.Now)&".xls"

		Dim pname As ABMInput = inp.Content.Component("pname")
        pname.Text = xlsfolder '  "/shiftrpts" ' "Shifts_"&DateTime.Date(DateTime.Now)&"_"&DateTime.Time(DateTime.Now)&".xls"

		Dim sname As ABMInput = inp.Content.Component("savepath")
        sname.Text = xlssavepath
				
	    page.ShowModalSheetAbsolute("imgbox","25%", "15%", "50%", "60%")
		
End Sub


Sub CreateDetNote(PassedRowsAndColumns As List)
	' fill with the active values
	Dim tblCellInfo As ABMTableCell = PassedRowsAndColumns.Get(0)
	Dim tblUsers As ABMTable = page.Component(tblCellInfo.TableName)
	Dim cbc As String = ""
	isdetnote = True
		Dim inp As ABMModalSheet = page.ModalSheet("imgbox")
		SelectedRowId = tblUsers.GetString(tblCellInfo.Row, 0)
		detmast = tblUsers.GetString(tblCellInfo.Row, 1)
		cbc = tblUsers.GetString(tblCellInfo.Row, 6)
			
		Dim notes As ABMInput
        notes.Initialize(page,"note1",ABM.INPUT_TEXT, "Notes",True,"")
        notes.Text = cbc			
		inp.Content.Cell(2,1).RemoveAllComponents
		inp.Content.Cell(2,1).AddComponent(notes)
		inp.Content.Cell(2,1).UseTheme("cnter")
			
		page.ShowModalSheet("imgbox")
		
End Sub





Sub btnalldef_clicked(target As String)
	Dim chk1 As ABMCheckbox = page.Component("btnalldef")
	Dim chk2 As ABMCheckbox = page.Component("btnallveh")
	Dim chk3 As ABMCheckbox = page.Component("btnallshifts")
	
	
	If chk1.State Then
        chk2.State =  False
        chk3.State =  False
		daychk = True
		nightchk = False
	End If	

	chk2.Refresh
	chk3.Refresh
	
    LoadCases(1)

End Sub


Sub btnallveh_Clicked(target As String )
	Dim chk1 As ABMCheckbox = page.Component("btnalldef")
	Dim chk2 As ABMCheckbox = page.Component("btnallveh")
	Dim chk3 As ABMCheckbox = page.Component("btnallshifts")
	
	If chk2.State Then
        chk1.State =  False
        chk3.State =  False
		daychk = False
		nightchk = True
		
	End If	

	chk1.Refresh
	chk3.Refresh
    LoadCases(1)

End Sub


Sub cbfl_Clicked()

	ABMGentiShiftDetailShow(SelectedRowId)
	
End Sub


Sub cbbuff_Clicked()

	ABMGentiShiftDetailShow(SelectedRowId)
	
End Sub



Sub btnallshifts_Clicked(target As String)
	Dim chk1 As ABMCheckbox = page.Component("btnalldef")
	Dim chk2 As ABMCheckbox = page.Component("btnallveh")
	Dim chk3 As ABMCheckbox = page.Component("btnallshifts")
	
	If chk3.State Then
        chk1.State =  False
        chk2.State =  False
		daychk = False
		nightchk = False
		
	End If	

	chk1.Refresh
	chk2.Refresh
    LoadCases(1)

End Sub




Sub BuildMsgBox() As ABMModalSheet
	Dim msgbox As ABMModalSheet
	msgbox.Initialize(page, "msgbox", False, False,"")
	msgbox.IsDismissible = False
	
	msgbox.Content.AddRowsM(1, True,0,0, "").AddCells12(1, "")
	msgbox.Content.AddRows(1 , True, "") .AddCellsOSMP(1,0,0,0,6, 6,6, 0, 0,0,0,  "").AddCellsOSMP(1,0,0,0,6,6,6,0,0,0,0,  "")
	
	msgbox.Content.BuildGrid
	
	' add paragraph	
	'msgbox.Content.CellR(0,1).AddComponent(ABMShared.BuildParagraph(page,"par1"," Set Date Range") )
	msgbox.Content.CellR(0,1).AddComponent(ABMShared.BuildParagraphBQWithZDepth(page,"par1","  Set Date Range") )
	
		
	msgbox.Footer.AddRowsM ( 1,False,0,0, "").AddCellsOS(1,0,0,0,6,6,6,"").AddCellsOS(1,0 ,0,0,6,6,6, "")
	msgbox.Footer.BuildGrid 'IMPORTANT once you loaded the complete grid AND before you start adding components
	
	
	Dim startdate As ABMDateTimePicker
	startdate.Initialize(page, "startdate",ABM.DATETIMEPICKER_TYPE_DATE ,qsd,"START DATE", "") ' ABM.INPUT_TEXT, "Plate #", False, "lightblue")
'    startdate.SetDate(qsd)
	'startdate.Refresh
	
    msgbox.Content.CellR(1,1).AddComponent(startdate)

	Dim enddate As ABMDateTimePicker
	enddate.Initialize(page, "enddate",ABM.DATETIMEPICKER_TYPE_DATE , qed," END DATE","") ' ABM.INPUT_TEXT, "Plate #", False, "lightblue")
'	enddate.SetDate(qed)
    msgbox.Content.CellR(0,2).AddComponent(enddate)

	
	' create the buttons for the footer
	Dim msgok As ABMButton
	msgok.InitializeFlat(page, "msgok", "mdi-navigation-check",  ABM.ICONALIGN_LEFT, "OK", "transparent")
	msgbox.Footer.Cell(1,1).AddComponent(msgok)
	
	Return msgbox
End Sub



Sub startdate_changed(target As String, dateMilliseconds As String)
	Dim tempd As Long = dateMilliseconds
	qsd = tempd
	LoadCases(1)
End Sub

Sub enddate_changed(target As String, dateMilliseconds As String)
	Dim tempd As Long = dateMilliseconds
	qed = tempd
	LoadCases(1)
End Sub



Sub msgok_Clicked(Target As String)	
    Dim msgbox As ABMModalSheet = page.ModalSheet("msgbox")
	Dim sd As ABMDateTimePicker =  msgbox.Content.Component("startdate")

	Dim ed As ABMDateTimePicker =  msgbox.Content.Component("enddate")
    
	qsd = sd.GetDate
	qed = ed.GetDate
		
	
	page.CloseModalSheet("msgbox")
	
 '  Dim cn As ABMContainer = page.Component("cnt1")
   Dim d1 As ABMLabel =    page.Component("lblsd")  '  .GetActiveItemId
   Dim d2 As ABMLabel =    page.Component("lbled")  '  .GetActiveItemId
	
	d1.Text = "START DATE: "&DateTime.Date(qsd)
	d2.Text = " END DATE: "&DateTime.Date(qed)
	qed = ed.GetDate + DateTime.TicksPerDay
	
	d1.Refresh
	d2.Refresh
	
	LoadCases(1)
 '  LoadInspects(1)	
	
End Sub


Sub btndaterng_Clicked(Target As String)

    Dim msgbox As ABMModalSheet = page.ModalSheet("msgbox")

	Dim sd As ABMDateTimePicker =  msgbox.Content.Component("startdate")
	qsd = DateTime.DateParse(DateTime.Date(qsd))
	sd.SetDate(qsd)

	Dim ed As ABMDateTimePicker =  msgbox.Content.Component("enddate")
	qed = DateTime.DateParse(DateTime.Date(qed)) 
	ed.SetDate(qed)

	page.ShowModalSheet("msgbox")
	
End Sub



public Sub BuildTheme()
	' start with the base theme defined in ABMShared
	theme.Initialize("pagetheme")
	theme.AddABMTheme(ABMShared.MyTheme)
	
    theme.AddCellTheme("cnter")
	theme.Cell("cnter").Align = ABM.CELL_ALIGN_CENTER
	


	' add additional themes specific for this page
	theme.AddTableTheme("tbltheme")
	theme.Table("tbltheme").ZDepth = ABM.ZDEPTH_1
	
	theme.Table("tbltheme").AddCellTheme("bg")
	theme.Table("tbltheme").Cell("bg").BackColor = ABM.COLOR_BLUEGREY
	theme.Table("tbltheme").Cell("bg").ForeColor = ABM.COLOR_WHITE	
    theme.Table("tbltheme").Cell("bg").Align = ABM.TABLECELL_HORIZONTALALIGN_LEFT	
	
	theme.Table("tbltheme").AddCellTheme("bgr")
	theme.Table("tbltheme").Cell("bgr").BackColor = ABM.COLOR_BLUEGREY
	theme.Table("tbltheme").Cell("bgr").ForeColor = ABM.COLOR_WHITE
	theme.Table("tbltheme").Cell("bgr").Align = ABM.TABLECELL_HORIZONTALALIGN_RIGHT	
	
	theme.Table("tbltheme").AddCellTheme("bgc")
	theme.Table("tbltheme").Cell("bgc").BackColor = ABM.COLOR_BLUEGREY
	theme.Table("tbltheme").Cell("bgc").BackColorIntensity = ABM.INTENSITY_LIGHTEN1

	theme.Table("tbltheme").Cell("bgc").ForeColor = ABM.COLOR_YELLOW
	theme.Table("tbltheme").Cell("bgc").Align = ABM.TABLECELL_HORIZONTALALIGN_CENTER
	theme.Table("tbltheme").Cell("bgc").BorderWidth = 2
	theme.Table("tbltheme").Cell("bgc").BorderColor = ABM.COLOR_BLACK

	theme.Table("tbltheme").AddCellTheme("bgb")
	theme.Table("tbltheme").Cell("bgb").BackColor = ABM.COLOR_BLUEGREY
	theme.Table("tbltheme").Cell("bgb").BackColorIntensity = ABM.INTENSITY_LIGHTEN1

	theme.Table("tbltheme").Cell("bgb").ForeColor = ABM.COLOR_AMBER
	theme.Table("tbltheme").Cell("bgb").Align = ABM.TABLECELL_HORIZONTALALIGN_CENTER
	theme.Table("tbltheme").Cell("bgb").BorderWidth = 2
	theme.Table("tbltheme").Cell("bgb").BorderColor = ABM.COLOR_BLACK


	theme.Table("tbltheme").AddCellTheme("nocolor")
	theme.Table("tbltheme").Cell("nocolor").ActiveBackColor = ABM.COLOR_LIGHTGREEN
	theme.Table("tbltheme").Cell("nocolor").ActiveBackColorIntensity = ABM.INTENSITY_LIGHTEN2
	theme.Table("tbltheme").Cell("nocolor").Align = ABM.TABLECELL_HORIZONTALALIGN_CENTER
'	theme.Table("tbltheme").Cell("nocolor").FontSize = 35
'	theme.Table("tbltheme").Cell("nocolor").Align = ABM.TABLECELL_VERTICALALIGN_TOP
	


	theme.Table("tbltheme").AddCellTheme("positive")
	theme.Table("tbltheme").Cell("positive").BackColor = ABM.COLOR_GREEN
	theme.Table("tbltheme").Cell("positive").BackColorIntensity = ABM.INTENSITY_LIGHTEN3
	theme.Table("tbltheme").Cell("positive").ActiveBackColor = ABM.COLOR_GREEN
	theme.Table("tbltheme").Cell("positive").ActiveBackColorIntensity = ABM.INTENSITY_LIGHTEN1
	'theme.Table("tbltheme").Cell("positive").Align = ABM.TABLECELL_HORIZONTALALIGN_RIGHT
	
	theme.Table("tbltheme").AddCellTheme("negative")
	theme.Table("tbltheme").Cell("negative").BackColor = ABM.COLOR_RED
	theme.Table("tbltheme").Cell("negative").BackColorIntensity = ABM.INTENSITY_LIGHTEN3
	theme.Table("tbltheme").Cell("negative").ActiveBackColor = ABM.COLOR_RED
	theme.Table("tbltheme").Cell("negative").ActiveBackColorIntensity = ABM.INTENSITY_LIGHTEN1
	'theme.Table("tbltheme").Cell("negative").Align = ABM.TABLECELL_HORIZONTALALIGN_RIGHT
	
	theme.Table("tbltheme").AddCellTheme("points")	
	theme.Table("tbltheme").Cell("points").ActiveBackColor = ABM.COLOR_BLUEGREY
	theme.Table("tbltheme").Cell("points").ActiveBackColorIntensity = ABM.INTENSITY_LIGHTEN2
	theme.Table("tbltheme").Cell("points").Align = ABM.TABLECELL_HORIZONTALALIGN_RIGHT
	
	theme.Table("tbltheme").AddCellTheme("openedit")	
	theme.Table("tbltheme").Cell("openedit").ActiveBackColor = ABM.COLOR_BLUEGREY
	theme.Table("tbltheme").Cell("openedit").ActiveBackColorIntensity = ABM.INTENSITY_LIGHTEN2
	theme.Table("tbltheme").Cell("openedit").Align = ABM.TABLECELL_HORIZONTALALIGN_CENTER


	theme.AddRowTheme("rowtheme1")
'    theme.Row("rowtheme1").BackColor = ABM.COLOR_BLUEGREY
'	theme.Row("rowtheme1").BackColorIntensity = ABM.INTENSITY_LIGHTEN3
	theme.Row("rowtheme1").BorderColor = ABM.COLOR_GREY
	theme.Row("rowtheme1").BorderColorIntensity = ABM.INTENSITY_DARKEN4
	theme.Row("rowtheme1").BorderWidth = 3


	theme.AddRowTheme("rowtheme")
    theme.Row("rowtheme").BackColor = ABM.COLOR_BLUEGREY
	theme.Row("rowtheme").BackColorIntensity = ABM.INTENSITY_LIGHTEN3
	theme.Row("rowtheme").BorderColor = ABM.COLOR_GREY
	theme.Row("rowtheme").BorderColorIntensity = ABM.INTENSITY_DARKEN4
	theme.Row("rowtheme").BorderWidth = 3

	' add additional themes specific for this page
	theme.AddButtonTheme("bigblue")
	theme.Button("bigblue").BackColor = ABM.COLOR_LIGHTBLUE

	theme.AddButtonTheme("bigred")
	theme.Button("bigred").BackColor = ABM.COLOR_RED

    theme.AddModalSheetTheme("modsht")
	theme.ModalSheet("modsht").ContentBackColor = ABM.COLOR_GREY
	theme.ModalSheet("modsht").ContentBackColorIntensity = ABM.INTENSITY_LIGHTEN2
'	theme.ModalSheet("modsht").
	
	theme.AddButtonTheme("flatgreen")
	theme.Button("flatgreen").BackColor = ABM.COLOR_GREEN
	theme.Button("flatgreen").ForeColor = ABM.COLOR_BLACK
	theme.Button("flatgreen").ForeColorIntensity = ABM.INTENSITY_DARKEN4


	theme.AddLabelTheme("lbbold")
	theme.Label("lbbold").ForeColor = ABM.COLOR_BLACK
	theme.Label("lbbold").ForeColorIntensity = ABM.INTENSITY_DARKEN1
    theme.Label("lbbold").Align = ABM.CELL_ALIGN_CENTER
	
	theme.AddLabelTheme("lbboldblue")
	theme.Label("lbboldblue").ForeColor = ABM.COLOR_RED
	theme.Label("lbboldblue").ForeColorIntensity = ABM.INTENSITY_DARKEN4
    theme.Label("lbboldblue").Align = ABM.CELL_ALIGN_CENTER


	theme.AddButtonTheme("amber")
	theme.Button("amber").BackColor = ABM.COLOR_AMBER
	theme.Button("amber").ForeColor = ABM.COLOR_BLACK
	theme.Button("amber").ForeColorIntensity = ABM.INTENSITY_DARKEN1
'    theme.Button("amber").BackColorIntensity = ABM.INTENSITY_DARKEN1

	theme.AddButtonTheme("disable")
	theme.Button("disable").BackColor = ABM.COLOR_GREY
	theme.Button("disable").ForeColor = ABM.COLOR_BLACK
	theme.Button("disable").ForeColorIntensity = ABM.INTENSITY_LIGHTEN2
    
	theme.AddCheckboxTheme("cbox")
	theme.Checkbox("cbox").ZDepth = ABM.ZDEPTH_3
	
	theme.AddPaginationTheme("pgn1")
	theme.Pagination("pgn1").NavigationButtonsBackColor = ABM.COLOR_AMBER
	'theme.Pagination("pgn1").ZDepth = ABM.ZDEPTH_3
	
	'theme.Pagination("pgn1"). = ABM.COLOR_BLUEGREY
	
	' modal sheet
	theme.AddContainerTheme("modalcontent")
	theme.Container("modalcontent").BackColor = ABM.COLOR_WHITE	
	
	' modal sheet
	theme.AddContainerTheme("modalfooter")
	theme.Container("modalfooter").BackColor = ABM.COLOR_LIGHTBLUE
	
	' chip
	theme.AddChipTheme("chip")
	theme.Chip("chip").BackColorIntensity = ABM.INTENSITY_LIGHTEN4
	
	' note container theme
	theme.AddContainerTheme("notetheme")
	theme.Container("notetheme").BackColor = ABM.COLOR_BLUEGREY
	theme.Container("notetheme").BackColorIntensity = ABM.INTENSITY_LIGHTEN5
	theme.Container("notetheme").ZDepth = ABM.ZDEPTH_1
		
End Sub

Sub btnout_clicked(target As String)

	shiftCM.RunAVGReport(qsd , qed)

	'SetExport
	
End Sub



'Sub SaveXLSExport 'ignore
'	
'	'first we create a writable workbook.
'	'the target file should be a NEW file.
'	Dim newWorkbook As WritableWorkbook
'	newWorkbook.Initialize(File.DirApp, "Shifts.xls")
'	Dim sheet1 As WritableSheet
'	sheet1 = newWorkbook.AddSheet("Shifts", 0)
'	'add the headers to the sheet
'	'we create a special format for the headers
'	Dim cellFormat As WritableCellFormat
'	cellFormat.Initialize2(cellFormat.FONT_ARIAL, 14 ,  True,  False,  False, cellFormat.COLOR_GREEN)
'	cellFormat.HorizontalAlignment = cellFormat.HALIGN_CENTRE
'	cellFormat.SetBorder(cellFormat.BORDER_ALL, cellFormat.BORDER_STYLE_MEDIUM, cellFormat.COLOR_BLACK)
'	cellFormat.SetBorder(cellFormat.BORDER_BOTTOM, cellFormat.BORDER_STYLE_THICK, cellFormat.COLOR_BLUE)
'	cellFormat.VertivalAlignment = cellFormat.VALIGN_CENTRE
'	cellFormat.BackgroundColor = cellFormat.COLOR_GREY_25_PERCENT
'	
'	Dim wc As WritableCell
'	Dim col As Int = 0
'	
'	Dim headers() As String = Array As String("Shift ID", "PIN", "Driver", "Start Date","End Date","Actual","Paid","Shift")
'	For i = 0 To headers.Length - 1
'		wc.InitializeText(i,  1, headers(i))
'		wc.SetCellFormat(cellFormat)
'		sheet1.AddCell(wc)
'		If i = 2 Then
'		   sheet1.SetColumnWidth(col, 30)
'		Else
'		   sheet1.SetColumnWidth(col, 25)
'		End If	   
'		col = col + 1
'	Next
'
''	sheet1.SetColumnWidth(1, 30)
'	sheet1.SetRowHeight(0, 15)
'	
'	'add the data
'	Dim rowsFormat As WritableCellFormat
'	rowsFormat.Initialize2(cellFormat.FONT_ARIAL, 13 ,  False,  False,  False,  cellFormat.COLOR_BLACK)
'	rowsFormat.HorizontalAlignment = rowsFormat.HALIGN_CENTRE
'	
'	Dim SQL As SQL = DBM.GetSQL
' 	Dim cases As List = DBM.SQLSelect(SQL, SQL_EXPORT)
'	For i = 0 To cases.Size - 1
'		Dim tblFields As Map = cases.Get(i)
''        Log(" what is export map: "&tblFields)
'		For j = 0 To tblFields.Size - 1	
'				Dim var As String
'				var = 	tblFields.GetValueAt(j) ' init as string to avoid null_pointer error
'				If var = "null" Then
'				    var = ""
'				End If
'	   			Dim cell As WritableCell
'				   
'	            If tblFields.GetKeyAt(j) = "pk" Then
'					cell.InitializeText( 0, i+2, var)
'					cell.SetCellFormat( rowsFormat)
'				    sheet1.SetColumnWidth(0, 18)
'
'					sheet1.AddCell(cell)
'	            End If
'
'	            If tblFields.GetKeyAt(j) = "pin" Then
'					Dim str As String
'					str = ABMShared.getDriverPIN(var)
'					cell.InitializeText( 1, i+2, str)
'					cell.SetCellFormat(rowsFormat)
'				    sheet1.SetColumnWidth(1, 18)
'					
'					sheet1.AddCell(cell)
'	            End If
'				   
'	            If tblFields.GetKeyAt(j) = "drvid" Then
'					Dim str As String
'					str = ABMShared.GetDriverName(var)
'					cell.InitializeText( 2, i+2, str)
'					cell.SetCellFormat(rowsFormat)
'					sheet1.AddCell(cell)
'	            End If
'
'			   If tblFields.GetKeyAt(j) = "sdate" Then
'				  Dim l As Long
'				  l = var
'				  Dim str As String
'				  DateTime.TimeFormat = "HH:mm"
'				  str = DateTime.Date(l)&" - "&DateTime.Time(l)
'				  cell.InitializeText( 3, i+2, str)
'				  cell.SetCellFormat(rowsFormat)
'				  sheet1.AddCell(cell)
'
'			   End If	 
'			
'			   If tblFields.GetKeyAt(j) = "edate" Then
'				  Dim l As Long
'				  l = var
'				  Dim str As String
'				  DateTime.TimeFormat = "HH:mm"
'				  str = DateTime.Date(l)&" - "&DateTime.Time(l)
'				  cell.InitializeText( 4, i+2, str)
'				  cell.SetCellFormat(rowsFormat)
'				  sheet1.AddCell(cell)
'
'			   End If	 
'			   
'			   If tblFields.GetKeyAt(j) = "ttime" Then
'				  Dim l, ss, tt As Long
'				  l = tblFields.GetValueAt(4)
'				  ss = tblFields.GetValueAt(3)
'				  Dim str As String
'				  DateTime.TimeFormat = "HH:mm"
'				  If l = 0 Then
'				  	str = "N/A"
'				  Else	
'				  	tt = l - ss
'				    str = ABMShared.ShowTimeFormat(tt) ' DateTime.Date(l)&" - "&DateTime.Time(l)
'				  End If
'				  cell.InitializeText( 5, i+2, str)
''				  Log(" what is ttime: "&str)
'				  cell.SetCellFormat(rowsFormat)
'			      sheet1.SetColumnWidth(5, 18)
'				  
'				  sheet1.AddCell(cell)
'			   End If	 
'
'
'			   If tblFields.GetKeyAt(j) = "adjust" Then
'				  Dim l, ss, tt As Long
'				  l = tblFields.GetValueAt(4)
'				  ss = tblFields.GetValueAt(3)
'				  Dim str As String
'				  DateTime.TimeFormat = "HH:mm"
'				  If l = 0 Then
'				  	str = "N/A"
'				  Else	
'				  	tt = l - ss
'				    str = ABMShared.ShowTimeRound(tt) ' DateTime.Date(l)&" - "&DateTime.Time(l)
'				  End If
'				  cell.InitializeText( 6, i+2, str)
'				  cell.SetCellFormat(rowsFormat)
'			      sheet1.SetColumnWidth(6, 18)
'				  
'				  sheet1.AddCell(cell)
'
'			   End If	 
'
'			   If tblFields.GetKeyAt(j) = "stype" Then
'				  Dim l As Long
'				  l = var
'				  Dim str As String
'				  DateTime.TimeFormat = "HH:mm"
'				  If DateTime.GetHour(l) >= 12 Then
'                     str = "NIGHT"
'				  Else
'				  	 str = "DAY"
'				  End If
'				 cell.InitializeText( 7, i+2, str)
'				 cell.SetCellFormat(rowsFormat)
'			     sheet1.SetColumnWidth(7, 20)
'				 sheet1.AddCell(cell)
'			   End If	 
'		Next
'    Next
'	DBM.CloseSQL(SQL)
'	
'	
'	Try
'	  newWorkbook.Write
'	  newWorkbook.Close
'	 ' File.MakeDir(File.DirApp,xlsfolder)
'	  File.Copy(File.DirApp,"Shifts.xls", xlssavepath, shiftfilename)
'Log(" save folder: "&xlsfolder)
''	  File.Copy(File.DirApp,"Shifts.xls", xlsfolder, shiftfilename)
'	  
'	  Toast("XLS File Was Created: "&shiftfilename,2000)
'	  Log(" write file: "&shiftfilename)	
'    
'	Dim lblxl As ABMLabel = page.Component("lblxls")
''    lblxl.Text = "{AL}http://localhost:8080"&xlsfolder&"/"&shiftfilename&"{AT}Download "& shiftfilename&"{/AL}"
'    lblxl.Text = "{AL}http://"&Main.linkaddress&":8080"&xlsfolder&"/"&shiftfilename&"{AT}Download "& shiftfilename&"{/AL}"
'
''    lblxl.Text = "{AL}http://localhost:8080/shiftfinal.xls{AT}Download "& shiftfilename&"{/AL}"
'	
'	page.Cell(2,4).Refresh
'
'	Catch
'	  Log(" could not write xls file to: "&xlssavepath)	
'	  Toast("Error Saving File: "&shiftfilename,3000)
'	  
'	End Try	
'End Sub


Sub BuildFooterFixed()	
	page.isFixedFooter= True
	'// because we have a fixed footer at the bottom, we have To adjust the padding of the body in pixels
	page.PaddingBottom = 50
	
	page.Footer.AddRows(2,   True, "").AddCellsOS(1,   0,0,0,2,2,3, "").AddCellsOS(1, 0,0,0,2,2,3, "").AddCellsOS(1, 0,0,0,8,8,6, "") 
	page.Footer.BuildGrid '//IMPORTANT once you loaded the complete grid And before you start adding components	
	
	page.Footer.UseTheme("modalfooter")




 '   If ABMShared.pgActionName = "Inspections" Or ABMShared.pgActionName = "Company" Then
		Dim AddCaseBtn As ABMButton
		AddCaseBtn.InitializeFlat(page, "AddShiftBtn",  "mdi-content-add-circle",  ABM.ICONALIGN_LEFT,"Add New SHIFT","amber")
		page.Footer.Cell(  2,1).AddComponent(AddCaseBtn)	
	    AddCaseBtn.Enabled = True
'		Log(" what is action name1: "&Page_name)
'    Else
'		Dim AddCaseBtn As ABMButton
'		AddCaseBtn.InitializeFlat(page, "AddCaseBtn",  "mdi-content-add-circle",  ABM.ICONALIGN_LEFT,"ADD NEW VEHICLE","amber")
'		page.Footer.Cell(  2,1).AddComponent(AddCaseBtn)	
'	    AddCaseBtn.Enabled = True
'		Log(" what is action name2: "&ABMShared.pgActionName)
'
'	End If


	Dim MoreBtn As ABMButton
	MoreBtn.InitializeFloating(page,  "MoreBtn",  "mdi-file-file-download", "flatgreen")
	page.Footer.Cell(2,2).AddComponent(MoreBtn)	

	Dim lbl1 As ABMLabel
	lbl1.Initialize(page, "footlbl1", "{NBSP}"&" - "&"{NBSP}",ABM.SIZE_SPAN, False, "")
	page.Footer.Cell(2,2).AddComponent(lbl1)


	Dim LessBtn As ABMButton
	LessBtn.InitializeFloating(page, "LessBtn",   "mdi-file-file-upload","flatgreen")
	page.Footer.Cell(2,2).AddComponent(LessBtn)	


	
	pagination.Initialize(page, "pagination",  3, True, True, "pgn1")
	pagination.SetTotalNumberOfPages(3)
'
	page.footer.Cell(2,3).AddComponent(pagination)	
	'page.Footer.Refresh
	
	Log("added Insp fixed footer")
End Sub

' clicked on the navigation bar
Sub Page_NavigationbarClicked(Action As String, Value As String)
	page.SaveNavigationBarPosition	
	If Action = "Cases" Then Return	
	
	If Action = "LogOff" Then
		ABMShared.LogOff(page)
		Return
	End If

    page.ws.Session.SetAttribute("UserAction", Action)

    Page_name = page.ws.Session.GetAttribute2( "UserAction", "")

'	ABMShared.pgActionName = Action

	ABMShared.NavigateToPage(ws,ABMPageId, Value)
   
'    Log(" Set Action: "& Action)
	
End Sub


'Sub Page_Ready()
'	Log("Insp ready!")
'    Page_name = page.ws.Session.GetAttribute2( "UserAction", "")
'
'    ConnectPage	
'	
'	page.RestoreNavigationBarPosition
'
'	page.Footer.Refresh
'	
'	LoadCases(1)
' 
'    page.NavigationBar.Title = "Driver Work Shifts" 'page.ws.Session.GetAttribute2( "UserAction", "")
' 
'    page.Refresh
' 
'
'End Sub


Sub page_footer_pagination_PageChanged(OldPage As Int, NewPage As Int)
	' do your stuff
	LoadCases(NewPage)
End Sub


Sub pagination_PageChanged(OldPage As Int, NewPage As Int)
	' do your stuff
	LoadCases(NewPage)
	Log(" What is new Page: "&NewPage)
End Sub



Sub UpdateUserRows()

	Dim sql As SQL = DBM.GetSQL
	DBM.SQLUpdate(sql,"Update Users Set UserRows = "&iRecs&" Where UserID = "&UserID)
	DBM.CloseSQL(sql)
	
End Sub

Sub MoreBtn_Clicked(Target As String)
  iRecs = iRecs + 1
  LoadCases(1)
  Log(" Irecs: "&iRecs)
  UpdateUserRows
End Sub


Sub LessBtn_Clicked(Target As String)
  iRecs = iRecs - 1
  If iRecs < 2 Then
  	iRecs = 2
  End If
  LoadCases(1)
  UpdateUserRows
  Log(" Irecs: "&iRecs)
End Sub

Sub Toast(message As String, duration As Int)
	myToastId=myToastId+1
	page.ShowToast("toast" & myToastId, "toastred", message , duration, False)
End Sub


Sub AddCaseBtn_Clicked(Target As String)
	' reset all the values on the form
	ActiveCaseId = 0
    ActivetiInsp_deT = 0	
	'GenCrudSheet
	Return
	
'	Dim casebtn As ABMButton = page.Component("AddCaseBtn")
'	If ABMShared.pgActionName = "Inspections" Or ABMShared.pgActionName = "Company" Then
'		Toast("Add Button is Disabled For "&ABMShared.pgActionName&"!", 4000)
'		Return
'	End If
	
	    Select Case ABMShared.pgActionName


		  Case "Inspections"	 
			
			 
	    End Select

	
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

Sub ShiftDetailCancel_Clicked(Target As String)
	ActivetiShift = 0
	page.CloseModalSheet("tiShiftDetail")
End Sub


Sub ABMGentiShiftDetailShow(openId As Long)
	Dim ABMGentiShiftModal As ABMModalSheet = page.ModalSheet("tiShiftDetail")
	Dim chk1 As ABMCheckbox = ABMGentiShiftModal.Content.Component("cbfl")
	Dim chk2 As ABMCheckbox = ABMGentiShiftModal.Content.Component("cbbuff")

	ActivetiShift = openId
	Dim SQL As SQL = DBM.GetSQL
	Dim SQL_res As String

    SQL_res = "Select * from shiftmast where pk = "&ActivetiShift
	Dim cases As List = DBM.SQLSelect(SQL, SQL_res)

	For i = 0 To cases.Size - 1
		Dim tblFields As Map = cases.Get(i)
		
		For j = 0 To tblFields.Size - 1	
				Dim var As String
				var = 	tblFields.GetValueAt(j) ' init as string to avoid null_pointer error
				If var = "null" Then
				    var = ""
				End If
	   			Dim cell As WritableCell
				   
	            If tblFields.GetKeyAt(j) = "drvid" Then
                   scdrv = var
	            End If
				
	            If tblFields.GetKeyAt(j) = "sdate" Then
					Dim l As Long
					l = var
					If chk2.State Then
					  l = l - (DateTime.TicksPerHour )
					End If  
                    ssd = l
	            End If
				
	            If tblFields.GetKeyAt(j) = "edate" Then
					Dim l As Long
					l = var
					If chk2.State Then
					   l = l + (DateTime.TicksPerHour)
					End If   
                    sed = l
	            End If
        Next
	Next
    DBM.CloseSQL(SQL)
	
	If sed < ssd Then
	   Toast(" End Date Less Than Start Date! "&CRLF&" Adding 16 Hours To Start Date Instead... ",4000)
	   'Toast(" Adding 16 Hours To Start Date Instead... ",4000)
	   sed = ssd + (DateTime.TicksPerHour * 16)
	End If
	
    ShowLoadsDtl

'    page.ShowModalSheet("tiShiftDetail")
'	page.ShowModalSheetAbsolute("tiShiftDetail", "2%", "2%",  "96%",  "95%")
	
End Sub

 Sub btnloads_clicked(target As String)
 	
	sdet = 0
	ABMGentiShiftDetailShow(SelectedRowId)
	
End Sub

Sub btnlogs_clicked(target As String)
 	
	sdet = 1
	ABMGentiShiftDetailShow(SelectedRowId)
	
End Sub



Sub ShowLoadsDtl

	Dim ABMGentiShiftModal As ABMModalSheet = page.ModalSheet("tiShiftDetail")
	Dim tblCases As ABMTable =  ABMGentiShiftModal.Content.Component("tblCases1")
	ABMGentiShiftModal.Content.Cell(3,1).RemoveComponent("tblCases1")
	Dim tblCases1 As ABMTable
'	SQL_Str2 = "SELECT pk, drvid, start, end, printed FROM shifthist WHERE comp_id = "&Main.comp_id&" AND start >= "&qsd&" AND start < "&qed
	If sdet = 0 Then
		tblCases1.Initialize(page,  "tblCases1",   False,   False,  True, "tbltheme")
		tblCases1.SetHeaders(         Array As String("Shift ID", " Date","Type","Activity","Truck","Trailer","Location" ))
		tblCases1.SetHeaderThemes(    Array As String(  "bgb",     "bgc" , "bgc",    "bgc" ,"bgc",   "bgc",    "bgc"))
		tblCases1.SetColumnVisible(    Array As Boolean(True, True,  True    , True,  True, True, True))
		tblCases1.SetColumnWidths(     Array As Int(70, 160,120,150,90,120,250))
'		tblCases1.
	    SQL_Loadsqry = "SELECT shiftid, recdate, loadtype, acttype, trkid, trl1id, trl2id, place FROM loadmast WHERE drvid = "&scdrv&" AND recdate >= "&ssd&" AND recdate <= "&sed&" Order by recdate"
		
    End If
	
	If sdet = 1 Then
		tblCases1.Initialize(page,  "tblCases1",   False,   False,  True, "tbltheme")
		tblCases1.SetHeaders(         Array As String("LOG ID", " Date","Status","Reason","Truck","Trailer","Location" ))
		tblCases1.SetHeaderThemes(    Array As String(  "bgb",     "bgc" , "bgc",    "bgc" ,"bgc",   "bgc",    "bgc"))
		tblCases1.SetColumnVisible(    Array As Boolean(True, True,  True    , True,  True, True, True))
		tblCases1.SetColumnWidths(     Array As Int(70, 160,120,150,90,120,250))
		SQL_Loadsqry = "SELECT LogID, LogDate, Statname, LogReason, LogTruck, LogTrailer, Location FROM log_rec WHERE LogDriver = "&scdrv&" AND LogDate >= "&ssd&" AND LogDate <= "&sed&" Order by LogDate"

    End If

	
    ABMGentiShiftModal.Content.Cell(3,1).AddComponent(tblCases1)
	
	Dim tblCases As ABMTable =  ABMGentiShiftModal.Content.Component("tblCases1")
	
	Dim chk1 As ABMCheckbox = ABMGentiShiftModal.Content.Component("cbfl")
'	Dim chk2 As ABMCheckbox = ABMGentiShiftModal.Content.Component("cbbuff")

    Dim str, str1,str2, str3,disp As String
	Dim sd, ed As Long
	sd = ssd
	ed = sed
	If sdet = 0 Then
	   disp = "	LOAD RECORDS"
	End If
	If sdet = 1 Then
	   disp = "	DRIVER LOGS"
	End If


	str = ABMShared.GetDriverName(scdrv)
	str1 = ABMShared.Showdatetime(sd)
	str2 = ABMShared.Showdatetime(ed)
	str3 = str&"  - From: "&str1&"  to  "&str2&"  <----------> "&disp
	
	ABMGentiShiftModal.Content.Cell(1,1).RemoveComponent("par10")
	ABMGentiShiftModal.Content.Cell(1,1).AddComponent(ABMShared.BuildParagraphBQWithZDepth(page,"par10",str3) )
	
	Dim SQL As SQL = DBM.GetSQL
    DateTime.DateFormat = "yyyy/MM/dd"

	Dim cases As List = DBM.SQLSelect(SQL, SQL_Loadsqry)
	tblCases.Clear

	For i = 0 To cases.Size - 1
		Dim tblFields As Map = cases.Get(i)
	    If chk1.State Then
		   If (i = 0) Or (i = cases.Size -1) Then
		   	' do nothing
		   Else
		   	 Continue
		   End If	
	    End If

		Dim rCellValues As List
		Dim rCellThemes As List
		rCellValues.Initialize
		rCellThemes.Initialize
		
		For j = 0 To tblFields.Size - 1	
			Dim var As String
			var = 	tblFields.GetValueAt(j) ' init as string to avoid null_pointer error
			If var = "null" Then
			    var = ""
			End If
			If sdet = 0 Then   
	            If tblFields.GetKeyAt(j) = "sourceid" Then
	                    Dim pd As ABMLabel
						pd.Initialize(page,"drv"&j,"",ABM.SIZE_H6, False,"")
						pd.Text = var ' ABMShared.GetDriverNamePIN(var) ' &" - "&DateTime.Time(tblFields.GetValueAt(j)) 
					    rCellValues.Add(pd)
					    rCellThemes.Add("nocolor")
						'Log("  What is driver: "&pd.Text)
						Continue
			    End If
				   

				   If tblFields.GetKeyAt(j) = "recdate" Then
					  Dim l As Long
					  l = var
					  Dim str As String
					  DateTime.TimeFormat = "HH:mm"
					  str = DateTime.Date(l)&" - "&DateTime.Time(l)
					  Dim lb As ABMLabel
					  lb.Initialize(page,"lb"&j,str,ABM.SIZE_H6,False,"lbbold")
				      rCellValues.Add(lb)
				      rCellThemes.Add("nocolor")
	                  Continue
				   End If	 
	'	SQL_Loadsqry = "SELECT shiftid, recdate, loadtype, acttype, trkid, trl1id, trl2id, place FROM loadmast WHERE drvid = "&scdrv&" AND recdate >= "&ssd&" AND recdate <= "&sed

	            If tblFields.GetKeyAt(j) = "trkid" Then
	                    Dim pd As ABMLabel
						pd.Initialize(page,"drv"&j,"",ABM.SIZE_H6,False,"")
						pd.Text = var ' ABMShared.GetDriverNamePIN(var) ' &" - "&DateTime.Time(tblFields.GetValueAt(j)) 
					    rCellValues.Add(pd)
					    rCellThemes.Add("nocolor")
						'Log("  What is driver: "&pd.Text)
						Continue
			    End If

	            If tblFields.GetKeyAt(j) = "trl1id" Then
	                    Dim pd As ABMLabel
						Dim tr As String
						tr = tblFields.Get("trl2id")
						pd.Initialize(page,"drv"&j,"",ABM.SIZE_H6,False,"")
						pd.Text = var &" "&tr
						
					    rCellValues.Add(pd)
					    rCellThemes.Add("nocolor")
						'Log("  What is driver: "&pd.Text)
						Continue
			    End If

	            If tblFields.GetKeyAt(j) = "loadtype" Then
	                    Dim pd As ABMLabel
						Dim stat As String
						stat = tblFields.Get("acttype")
						pd.Initialize(page,"drv"&j,"",ABM.SIZE_H6,False,"")
						If stat = "10" Or stat = "11" Then
							pd.Text = ABMShared.GetLoadType(var)
						Else
							pd.Text = "- - -"
						End If		
					    rCellValues.Add(pd)
					    rCellThemes.Add("nocolor")
						Continue
			    End If

	            If tblFields.GetKeyAt(j) = "acttype" Then
	                    Dim pd As ABMLabel
						pd.Initialize(page,"drv"&j,"",ABM.SIZE_H6,False,"")
						pd.Text = ABMShared.GetActType(var)
					    rCellValues.Add(pd)
					    rCellThemes.Add("nocolor")
						Continue
			    End If


	            If tblFields.GetKeyAt(j) = "trl2id" Then
						Continue
			    End If
				
	            If tblFields.GetKeyAt(j) = "place" Then
	                    Dim pd As ABMLabel
						pd.Initialize(page,"drv"&j,"",ABM.SIZE_H6,False,"")
						pd.Text = var ' ABMShared.GetDriverNamePIN(var) ' &" - "&DateTime.Time(tblFields.GetValueAt(j)) 
					    rCellValues.Add(pd)
					    rCellThemes.Add("nocolor")
						'Log("  What is driver: "&pd.Text)
						Continue
			    End If
            End If
            If sdet = 1 Then
	            If tblFields.GetKeyAt(j) = "logid" Then
	                    Dim pd As ABMLabel
						pd.Initialize(page,"drv"&j,"",ABM.SIZE_H6,False,"")
						pd.Text = var ' ABMShared.GetDriverNamePIN(var) ' &" - "&DateTime.Time(tblFields.GetValueAt(j)) 
					    rCellValues.Add(pd)
					    rCellThemes.Add("nocolor")
						'Log("  What is driver: "&pd.Text)
						Continue
			    End If
				   

				   If tblFields.GetKeyAt(j) = "logdate" Then
					  Dim l As Long
					  l = var
					  Dim str As String
					  DateTime.TimeFormat = "HH:mm"
					  str = DateTime.Date(l)&" - "&DateTime.Time(l)
					  Dim lb As ABMLabel
					  lb.Initialize(page,"lb"&j,str,ABM.SIZE_H6,False,"lbbold")
				      rCellValues.Add(lb)
				      rCellThemes.Add("nocolor")
	                  Continue
				   End If	 

	            If tblFields.GetKeyAt(j) = "logtruck" Then
	                    Dim pd As ABMLabel
						pd.Initialize(page,"drv"&j,"",ABM.SIZE_H6,False,"")
						pd.Text = var ' ABMShared.GetDriverNamePIN(var) ' &" - "&DateTime.Time(tblFields.GetValueAt(j)) 
					    rCellValues.Add(pd)
					    rCellThemes.Add("nocolor")
						'Log("  What is driver: "&pd.Text)
						Continue
			    End If

	            If tblFields.GetKeyAt(j) = "logtrailer" Then
	                    Dim pd As ABMLabel
						pd.Initialize(page,"drv"&j,"",ABM.SIZE_H6,False,"")
						pd.Text = var 
						
					    rCellValues.Add(pd)
					    rCellThemes.Add("nocolor")
						'Log("  What is driver: "&pd.Text)
						Continue
			    End If

	            If tblFields.GetKeyAt(j) = "statname" Then
	                    Dim pd As ABMLabel
						pd.Initialize(page,"drv"&j,"",ABM.SIZE_H6,False,"")
						pd.Text = var
					    rCellValues.Add(pd)
					    rCellThemes.Add("nocolor")
						Continue
			    End If

	            If tblFields.GetKeyAt(j) = "location" Then
	                    Dim pd As ABMLabel
						pd.Initialize(page,"drv"&j,"",ABM.SIZE_H6,False,"")
						pd.Text = var 'ABMShared.GetActType(var)
					    rCellValues.Add(pd)
					    rCellThemes.Add("nocolor")
						Continue
			    End If

	            If tblFields.GetKeyAt(j) = "logreason" Then
	                    Dim pd As ABMLabel
						pd.Initialize(page,"drv"&j,"",ABM.SIZE_H6,False,"")
						pd.Text = var ' ABMShared.GetDriverNamePIN(var) ' &" - "&DateTime.Time(tblFields.GetValueAt(j)) 
					    rCellValues.Add(pd)
					    rCellThemes.Add("nocolor")
						
						Continue
			    End If
            End If

			rCellValues.Add(var)
			rCellThemes.Add("nocolor")
		Next		

	
		tblCases.AddRow(  "uid" & i, rCellValues) 
'		tblCases.AddRowFixedHeight(  "uid" & i, rCellValues, 10) 
		
		tblCases.SetRowThemes(rCellThemes) ' make sure you have as many items in rCellThemes as in rCellValues!  Must follow IMMEDIATELY AFTER AddRow!
	Next
'	ABMGentiShiftModal.Content.Cell(3,1).RemoveComponent("tblCases1")
'    ABMGentiShiftModal.Content.Cell(3,1).SetFixedHeight(10)
    ABMGentiShiftModal.Content.Cell(3,1).AddComponent(tblCases )
'	tblCases.Refresh

    ABMGentiShiftModal.Refresh

	DBM.CloseSQL(SQL)
	

'	pagination.SetTotalNumberOfPages(numcases)
'	pagination.SetActivePage(fromPage)
'	pagination.Refresh


End Sub



Sub BuildShiftDetail() As ABMModalSheet
	Dim ABMGentiShiftModal As ABMModalSheet
	ABMGentiShiftModal.Initialize(page, "tiShiftDetail",  True,  False, "modsht")
	ABMGentiShiftModal.IsDismissible = False
	ABMGentiShiftModal.Size = ABM.MODALSHEET_SIZE_FULL

	ABMGentiShiftModal.Content.AddRowsM(1, True,-30,0, "").AddCells12(1,"")

    ABMGentiShiftModal.Content.AddRowsM( 1,True,  5,  0, "rowtheme").AddCellsOSMP(1,0,0,0,3,3,3,5,5,10,10,"cnter").AddCellsOSMP(1,0,0,0,3,3,3 ,  15,5,10,10,"cnter").AddCellsOSMP(1,0,0,0,3,3,3,15,5,10, 10,"cnter").AddCellsOSMP(1,0,0,0,3,3,3,5,5,10, 10,"cnter")
	
	ABMGentiShiftModal.Content.AddRowsM(3, True,5,0, "").AddCells12(1,"")

'	ABMGentiShiftModal.Content.AddRowsM(4, True, 10 , 0, "").AddCellsOS(1, 0, 0, 0, 12, 12, 12, "")
	ABMGentiShiftModal.Content.BuildGrid 'IMPORTANT once you loaded the complete grid AND before you start adding components

	ABMGentiShiftModal.Content.Cell(1,1).AddComponent(ABMShared.BuildParagraphBQWithZDepth(page,"par10","Show Details ") )
	
	
	Dim btnloads As ABMButton
	btnloads.InitializeFlat( page , "btnloads", "mdi-image-portrait", ABM.ICONALIGN_LEFT, "LOAD RECORDS","amber")
	ABMGentiShiftModal.Content.Cell(2,1).AddComponent(btnloads)
'	
	Dim btnlogs As ABMButton
	btnlogs.InitializeFlat( page , "btnlogs", "mdi-image-tune", ABM.ICONALIGN_LEFT, "Driver Logs","amber")
	ABMGentiShiftModal.Content.Cell(2,4).AddComponent(btnlogs)
	
	Dim cbfl As ABMCheckbox
	cbfl.Initialize( page ,  "cbfl", "First and Last Only", False,"")
	cbfl.IsFilled = True
	ABMGentiShiftModal.Content.Cell(2,2).AddComponent(cbfl)
	
	Dim cbbuff As ABMCheckbox
	cbbuff.Initialize( page ,  "cbbuff", "Buffer One Hour", False,"")
	cbbuff.IsFilled = True
	ABMGentiShiftModal.Content.Cell(2,3).AddComponent(cbbuff)


'
	Dim tblCases1 As ABMTable
''	SQL_Str2 = "SELECT pk, drvid, start, end, printed FROM shifthist WHERE comp_id = "&Main.comp_id&" AND start >= "&qsd&" AND start < "&qed
'	
'	tblCases1.Initialize(page,  "tblCases1",   False,   False,  True, "tbltheme")
'	tblCases1.SetHeaders(         Array As String("Shift ID", " Date","Type","Activity","Truck","Trailer","Location" ))
'	tblCases1.SetHeaderThemes(    Array As String(  "bgb",     "bgc" , "bgc",    "bgc" ,"bgc",   "bgc",    "bgc"))
'    tblCases1.SetColumnVisible(    Array As Boolean(True, True,  True    , True,  True, True, True))
'	tblCases1.SetColumnWidths(     Array As Int(70, 160,120,150,90,120,250))
'
    ABMGentiShiftModal.Content.Cell(3,1).AddComponent(tblCases1)
'	
	
	ABMGentiShiftModal.Footer.AddRowsM(1,True,0, 0, "").AddCells12(1,"")
	ABMGentiShiftModal.Footer.BuildGrid 'IMPORTANT once you loaded the complete grid AND before you start adding components

	' create the buttons for the footer, create in opposite order as aligned right in a footer
	Dim ABMGentiShiftCancel As ABMButton
	ABMGentiShiftCancel.InitializeFlat(page, "ShiftDetailCancel",  "mdi-navigation-close", ABM.ICONALIGN_LEFT, "CLOSE", "transparent")
	ABMGentiShiftModal.Footer.Cell(1,1).AddComponent(ABMGentiShiftCancel)
	
'	Dim ABMGentiShiftSave As ABMButton
'	ABMGentiShiftSave.InitializeFlat(page, "ABMGentiShiftSave", "mdi-navigation-check", ABM.ICONALIGN_LEFT, "Save", "transparent")
'	ABMGentiShiftModal.Footer.Cell(1,1).AddComponent(ABMGentiShiftSave)
	
	Return ABMGentiShiftModal

End Sub




#Region tiShift
Sub ABMGenBuildtiShift() As ABMModalSheet
	Dim ABMGentiShiftModal As ABMModalSheet
	ABMGentiShiftModal.Initialize(page, "tiShift",  True,  False, "")
	ABMGentiShiftModal.IsDismissible = False
	ABMGentiShiftModal.Size = ABM.MODALSHEET_SIZE_NORMAL
	ABMGentiShiftModal.Content.AddRowsM(1, True,0,0, "").AddCells12(1,"")

	ABMGentiShiftModal.Content.AddRowsM(4, True, 0, 0, "").AddCellsOS(1, 0, 0, 0, 6, 6, 6, "").AddCellsOS(1, 0, 0, 0, 6, 6, 6, "")
	ABMGentiShiftModal.Content.BuildGrid 'IMPORTANT once you loaded the complete grid AND before you start adding components

	ABMGentiShiftModal.Content.Cell(1,1).AddComponent(ABMShared.BuildParagraphBQWithZDepth(page,"par1","Enter Shift Information.") )


	Dim ABMGentiShiftPK As ABMInput
	ABMGentiShiftPK.Initialize(page, "ABMGentiShiftPK", ABM.INPUT_TEXT, "Shift ID", False, "")
	ABMGentiShiftModal.Content.CellR(1,1).AddComponent(ABMGentiShiftPK)
	ABMGentiShiftPK.Text = ""

	Dim ABMGentiShiftdrvid As ABMCombo
	ABMGentiShiftdrvid.Initialize(page, "ABMGentiShiftdrvid","DRIVER NAME",200, "")
	ABMGentiShiftModal.Content.CellR(0,2).AddComponent(ABMGentiShiftdrvid)



	Dim ABMGentiShiftstart As ABMDateTimePicker
	Dim NewDate As Long = DateTime.Now 'ignore
	ABMGentiShiftstart.Initialize(page, "ABMGentiShiftstart", ABM.DATETIMEPICKER_TYPE_DATETIME, NewDate, "Start Date", "")
	'ABMGentiShiftstart.ReturnDateFormat = "YYYY-MM-DD"
	ABMGentiShiftstart.ReturnTimeFormat = "HH:mm"
	ABMGentiShiftstart.MinimumDate = 0
	ABMGentiShiftstart.MaximumDate = 0
	ABMGentiShiftstart.Language = "en"
	ABMGentiShiftstart.FirstDayOfWeek = 0
	ABMGentiShiftstart.ShortTime = False
	ABMGentiShiftstart.PickText = "OK"
	ABMGentiShiftstart.CancelText = "Cancel"
	ABMGentiShiftstart.TodayText = "Today"
	ABMGentiShiftstart.ClearText = ""

	ABMGentiShiftModal.Content.CellR(1,1).AddComponent(ABMGentiShiftstart)

	Dim ABMGentiShiftend As ABMDateTimePicker
	Dim NewDate As Long = DateTime.Now 'ignore
	ABMGentiShiftend.Initialize(page, "ABMGentiShiftend", ABM.DATETIMEPICKER_TYPE_DATETIME, NewDate, "End Date", "")
'	ABMGentiShiftend.ReturnDateFormat = "YYYY-MM-DD"
	ABMGentiShiftend.ReturnTimeFormat = "HH:mm"
	ABMGentiShiftend.MinimumDate = 0
	ABMGentiShiftend.MaximumDate = 0
	ABMGentiShiftend.Language = "en"
	ABMGentiShiftend.FirstDayOfWeek = 0
	ABMGentiShiftend.ShortTime = False
	ABMGentiShiftend.PickText = "OK"
	ABMGentiShiftend.CancelText = "Cancel"
	ABMGentiShiftend.TodayText = "Today"
	ABMGentiShiftend.ClearText = ""
	
	ABMGentiShiftModal.Content.CellR(0,2).AddComponent(ABMGentiShiftend)

	Dim ABMGentiShiftunit As ABMInput
	ABMGentiShiftunit.Initialize(page, "ABMGentiShiftunit", ABM.INPUT_TEXT, "Unit Number", False, "")
	ABMGentiShiftModal.Content.CellR(1,1).AddComponent(ABMGentiShiftunit)
	ABMGentiShiftunit.Text = ""
	ABMGentiShiftunit.Enabled = True

	Dim ABMGentiShiftprinted As ABMCheckbox
	ABMGentiShiftprinted.Initialize(page, "ABMGentiShiftprinted", "Printed", True , "")
	ABMGentiShiftModal.Content.CellR(1,2).AddComponent(ABMGentiShiftprinted)
	ABMGentiShiftprinted.State = False
    ABMGentiShiftprinted.IsFilled = True
	ABMGentiShiftprinted.Enabled = False
	
	ABMGentiShiftModal.Footer.AddRowsM(1,True,0,0, "").AddCells12(1,"")
	ABMGentiShiftModal.Footer.BuildGrid 'IMPORTANT once you loaded the complete grid AND before you start adding components

	' create the buttons for the footer, create in opposite order as aligned right in a footer
	Dim ABMGentiShiftCancel As ABMButton
	ABMGentiShiftCancel.InitializeFlat(page, "ABMGentiShiftCancel",  "mdi-navigation-close", ABM.ICONALIGN_LEFT, "Cancel", "transparent")
	ABMGentiShiftModal.Footer.Cell(1,1).AddComponent(ABMGentiShiftCancel)
	
	Dim ABMGentiShiftSave As ABMButton
	ABMGentiShiftSave.InitializeFlat(page, "ABMGentiShiftSave", "mdi-navigation-check", ABM.ICONALIGN_LEFT, "Save", "transparent")
	ABMGentiShiftModal.Footer.Cell(1,1).AddComponent(ABMGentiShiftSave)

	Return ABMGentiShiftModal
End Sub

' method you can call when the user wants to add a new record
Sub ABMGentiShiftNew()
	Dim ABMGentiShiftModal As ABMModalSheet = page.ModalSheet("tiShift")
	ActivetiShift = 0

	Dim NewDate As Long = DateTime.Now 'ignore
	Dim ABMGentiShiftPK As ABMInput = ABMGentiShiftModal.Content.Component("ABMGentiShiftPK")
	Dim ABMGentiShiftunit As ABMInput = ABMGentiShiftModal.Content.Component("ABMGentiShiftunit")
	
	Dim ABMGentiShiftstart As ABMDateTimePicker = ABMGentiShiftModal.Content.Component("ABMGentiShiftstart")
	Dim ABMGentiShiftend As ABMDateTimePicker = ABMGentiShiftModal.Content.Component("ABMGentiShiftend")
	Dim ABMGentiShiftprinted As ABMCheckbox = ABMGentiShiftModal.Content.Component("ABMGentiShiftprinted")
	Dim ABMGentiShiftdrvid As ABMCombo = ABMGentiShiftModal.Content.Component("ABMGentiShiftdrvid")

		Dim SQL As SQL = DBM.GetSQL
		Dim users As List = DBM.SQLSelect(SQL, "SELECT * FROM emp where comp_id = "&Main.comp_id&" AND emptype > 0  Order by Last_name") ' WHERE userId=" & SelectedRowId)
		If users.Size > 0 Then
			For i = 0 To users.Size -1
			   Dim user As Map = users.Get(i)
			   Dim id As String = user.Get("pk")
			   Dim val As String = user.Get("last_name")&", "&user.Get("first_name")
		       ABMGentiShiftdrvid.AddItem(  id, val, BuildSimpleItem(""&id, "mdi-action-star-rate", "{NBSP}{NBSP}"&val))
			Next    
		End If
		DBM.CloseSQL(SQL)



	ABMGentiShiftPK.Text = ""
'	ABMGentiShiftstart.SetDate(ABM.ConvertFromDateTimeString(DateTime.Date(DateTime.Now)  , "YYYY-MM-DD HH:mm"))
	ABMGentiShiftend.SetDate( 0 ) 'ABM.ConvertFromDateTimeString(DateTime.Date(DateTime.Now)  , "YYYY-MM-DD HH:mm"))
	ABMGentiShiftprinted.State = True
	ABMGentiShiftdrvid.Enabled = True
	
	IsNewtiShift=True
	page.ShowModalSheet("tiShift")
'	page.ShowModalSheetAbsolute("tiShift","25%", "15%", "50%", "60%")
	
End Sub




' method you can call when the user wants to edit an existing record
Sub ABMGentiShiftEdit(openId As Long)
	Dim ABMGentiShiftModal As ABMModalSheet = page.ModalSheet("tiShift")
	ActivetiShift = openId
	Log(" What is shift ID: "&ActivetiShift)
	Dim NewDate As Long = DateTime.Now 'ignore
	Dim SQL As SQL = DBM.GetSQL
	Dim SQL_str As String = "SELECT pk, shftid, drvid, sdate, edate, comp_id, printed, trknum FROM shiftmast WHERE pk = ? "
	Dim results As List = DBM.ABMGenSQLSelect(SQL, SQL_str, Array As String(ActivetiShift))
	If results.Size>0 Then
		Dim m As Map = results.Get(0)
		Dim ABMGentiShiftPK As ABMInput = ABMGentiShiftModal.Content.Component("ABMGentiShiftPK")
		
		Dim ABMGentiShiftunit As ABMInput = ABMGentiShiftModal.Content.Component("ABMGentiShiftunit")
		
		Dim ABMGentiShiftstart As ABMDateTimePicker = ABMGentiShiftModal.Content.Component("ABMGentiShiftstart")
		Dim ABMGentiShiftend As ABMDateTimePicker = ABMGentiShiftModal.Content.Component("ABMGentiShiftend")
		Dim ABMGentiShiftprinted As ABMCheckbox = ABMGentiShiftModal.Content.Component("ABMGentiShiftprinted")
		Dim ABMGentiShiftdrvid As ABMCombo = ABMGentiShiftModal.Content.Component("ABMGentiShiftdrvid")


 '   ABMGentiShiftdrvid.AddItem(  "0", "ALL", BuildSimpleItem(""&"0", "mdi-action-star-rate", "{NBSP}{NBSP}"&"ALL"))

		Dim SQL As SQL = DBM.GetSQL
		Dim users As List = DBM.SQLSelect(SQL, "SELECT * FROM emp where comp_id = "&Main.comp_id&" AND emptype > 0  Order by Last_name") ' WHERE userId=" & SelectedRowId)
		If users.Size > 0 Then
			For i = 0 To users.Size -1
			   Dim user As Map = users.Get(i)
			   Dim id As String = user.Get("pk")
			   Dim val As String = user.Get("last_name")&", "&user.Get("first_name")
		       ABMGentiShiftdrvid.AddItem(  id, val, BuildSimpleItem(""&id, "mdi-action-star-rate", "{NBSP}{NBSP}"&val))
			Next    
		End If
		DBM.CloseSQL(SQL)

		If m.GetDefault("pk", Null) = Null Then 
			ABMGentiShiftPK.Text = ""
		Else
			ABMGentiShiftPK.Text = m.Get("shftid")
		End If
		ABMGentiShiftPK.Enabled = False


		If m.GetDefault("trknum", Null) = Null Then
			ABMGentiShiftunit.Text = ""
		Else
			ABMGentiShiftunit.Text = m.Get("trknum")
		End If

		If m.GetDefault("drvid", Null) = Null Then 
	        ABMGentiShiftdrvid.SetActiveItemId("0")
		    ABMGentiShiftdrvid.Enabled = True
			
		Else
		   Log(" what is edit driver: "	&m.Get("drvid"))
           Dim drvi As Int
		   drvi = m.Get("drvid") 
		   If drvi < 1 Then
		      ABMGentiShiftdrvid.Enabled = True
			  Log(" setting combo enabled")
			Else
		      ABMGentiShiftdrvid.Enabled = True
		   End If 

	       ABMGentiShiftdrvid.SetActiveItemId(m.Get("drvid"))

		End If
		
		

		If m.GetDefault("sdate", Null) = Null Then 
			ABMGentiShiftstart.SetDate( DateTime.Now)
		Else
			ABMGentiShiftstart.SetDate(m.Get("sdate"))
		End If

		If m.GetDefault("edate", Null) = Null Then 
			ABMGentiShiftend.SetDate(DateTime.Now)
'			ABMGentiShiftend.SetDate( 0 ) ' m.Get("sdate"))
			Log("today end shift: "&ABMGentiShiftend.GetDate)
		Else
			ABMGentiShiftend.SetDate( m.Get("edate"))
			Log("the end shift: "&ABMGentiShiftend.GetDate)

		End If



		If m.GetDefault("printed", Null) = Null Then 
			ABMGentiShiftprinted.State = False
		Else
			ABMGentiShiftprinted.State = m.Get("printed") > 0
		End If

		IsNewtiShift=False
		'page.ShowModalSheetAbsolute("tiShift","25%", "10%", "50%", "70%")
		page.ShowModalSheet("tiShift")
	Else
		Log("No record found")
	End If
	DBM.CloseSQL(SQL)
End Sub

' the user clicked save the form
Sub ABMGentiShiftSave_Clicked(Target As String)
	Dim ABMGentiShiftModal As ABMModalSheet = page.ModalSheet("tiShift")
'	Dim ABMGentiShiftBadInput As ABMModalSheet = page.ModalSheet("ABMGenBuildtiShiftBadInput")

	Dim Variables As List
	Variables.Initialize
	Dim NewDate As Long = DateTime.Now 'ignore

	Dim SQL As SQL = DBM.GetSQL
	Dim valueDouble As Double 'ignore
	Dim valueString As String 'ignore
	Dim valueInt As Int 'ignore
	Dim valueBoolean As Boolean 'ignore
	Dim valueLong As Long 'ignore
	Dim ret As Int 'ignore
'
'	If IsNewtiShift = False Then ' check if still exists
'		Dim SQL_chk As String = "SELECT  FROM  WHERE  = ? "
'		IsNewtiShift = (DBM.ABMGenSQLSelectSingleResult(SQL, SQL_chk, Array As Int(ActivetiShift))<=DBM.DBOK)
'	End If

	If IsNewtiShift Then
		Log(" determined new shift: "&IsNewtiShift)
		Dim ABMGentiShiftPK As ABMInput = ABMGentiShiftModal.Content.Component("ABMGentiShiftPK")
		Dim ABMGentiShiftunit As ABMInput = ABMGentiShiftModal.Content.Component("ABMGentiShiftunit")
		
		Dim ABMGentiShiftstart As ABMDateTimePicker = ABMGentiShiftModal.Content.Component("ABMGentiShiftstart")
		Dim ABMGentiShiftend As ABMDateTimePicker = ABMGentiShiftModal.Content.Component("ABMGentiShiftend")
		Dim ABMGentiShiftprinted As ABMCheckbox = ABMGentiShiftModal.Content.Component("ABMGentiShiftprinted")
		Dim ABMGentiShiftdrvid As ABMCombo = ABMGentiShiftModal.Content.Component("ABMGentiShiftdrvid")

		valueInt = ABMGentiShiftdrvid.GetActiveItemId
		Variables.Add(valueInt)

		valueLong = ABMGentiShiftstart.GetDate
		Variables.Add(valueLong)

		valueLong = ABMGentiShiftstart.GetDate
		Variables.Add(valueLong)

		valueString = ABMGentiShiftunit.Text
		Variables.Add(valueString)

		valueLong = ABMGentiShiftstart.GetDate
		Variables.Add(valueLong)

		valueLong = ABMGentiShiftend.GetDate
		Variables.Add(valueLong)

		valueInt = Main.comp_id
		Variables.Add(valueInt)

		valueBoolean = ABMGentiShiftprinted.State
		Variables.Add(1)
		
		valueString = "0"
		Variables.Add(valueString)
		
		valueString = "0"
		Variables.Add(valueString)
		
		valueString = ""
		Variables.Add(valueString)
		
		valueString = ""
		Variables.Add(valueString)

		ret = DBM.ABMGenSQLInsert(SQL, "INSERT INTO shiftmast (drvid, pk, shftid, trknum,  sdate, edate, comp_id, printed, sent, sparei, spare1t, spare2t ) VALUES(?, ?, ?, ?, ?, ?, ?, ?,?,?,?,?)", Variables)
	Else
		Dim ABMGentiShiftPK As ABMInput = ABMGentiShiftModal.Content.Component("ABMGentiShiftPK")
		Dim ABMGentiShiftunit As ABMInput = ABMGentiShiftModal.Content.Component("ABMGentiShiftunit")
		
		Dim ABMGentiShiftstart As ABMDateTimePicker = ABMGentiShiftModal.Content.Component("ABMGentiShiftstart")
		Dim ABMGentiShiftend As ABMDateTimePicker = ABMGentiShiftModal.Content.Component("ABMGentiShiftend")
		Dim ABMGentiShiftprinted As ABMCheckbox = ABMGentiShiftModal.Content.Component("ABMGentiShiftprinted")
		Dim ABMGentiShiftdrvid As ABMCombo = ABMGentiShiftModal.Content.Component("ABMGentiShiftdrvid")

		valueInt = ABMGentiShiftdrvid.GetActiveItemId
		Variables.Add(valueInt)

		valueString = ABMGentiShiftunit.Text
		Variables.Add(valueString)

		valueLong = ABMGentiShiftstart.GetDate
		Variables.Add(valueLong)

		valueLong = ABMGentiShiftend.GetDate
		Variables.Add(valueLong)

		valueInt = Main.comp_id
		Variables.Add(valueInt)

		valueBoolean = ABMGentiShiftprinted.State
		If valueBoolean Then
		   Variables.Add(1)
		Else
		   Variables.Add(0)
		End If



		ret = DBM.ABMGenSQLUpdate(SQL, "UPDATE shiftmast SET drvid=?, trknum=?, sdate=?, edate=?, comp_id=?, printed=? WHERE pk =" & ActivetiShift, Variables)
	End If
	DBM.CloseSQL(SQL)
	page.CloseModalSheet("tiShift")

	ActivetiShift = 0

    LoadCases(CurrPage)
End Sub


Sub addshiftbtn_clicked(target As String)
	
  ActivetiShift = 0	
  ABMGentiShiftNew	

	
End Sub

' the user clicked on cancel on the save form
Sub ABMGentiShiftCancel_Clicked(Target As String)
	ActivetiShift = 0
	page.CloseModalSheet("tiShift")
End Sub

Sub ABMGenBuildtiShiftDelete() As ABMModalSheet
	Dim ABMGentiShiftDeleteModal As ABMModalSheet
	ABMGentiShiftDeleteModal.Initialize(page, "tiShiftDelete", False, False, "")
	ABMGentiShiftDeleteModal.IsDismissible = False

	' Build the content grid 
	ABMGentiShiftDeleteModal.Content.AddRowsM(1, True,0,0, "").AddCells12(1, "")
	ABMGentiShiftDeleteModal.Content.BuildGrid  'IMPORTANT once you loaded the complete grid AND before you start adding components

	' add message label
	Dim ABMGentiShiftDeleteMessage As ABMLabel
	ABMGentiShiftDeleteMessage.Initialize(page, "ABMGentiShiftDeleteMessage", "" , ABM.SIZE_PARAGRAPH, False, "")
	ABMGentiShiftDeleteModal.Content.CellR(0,1).AddComponent(ABMGentiShiftDeleteMessage)

	' Build the footer grid 
	ABMGentiShiftDeleteModal.Footer.AddRowsM(1,True,0,0, "").AddCellsOS(1,6,6,6,3,3,3,"").AddCellsOS(1,0,0,0,3,3,3, "")
	ABMGentiShiftDeleteModal.Footer.BuildGrid 'IMPORTANT once you loaded the complete grid AND before you start adding components

	' create the buttons for the footer
	Dim ABMGentiShiftDeleteYes As ABMButton
	ABMGentiShiftDeleteYes.InitializeFlat(page, "ABMGentiShiftDeleteYes", "", "", "Yes", "transparent")
	ABMGentiShiftDeleteModal.Footer.Cell(1,1).AddComponent(ABMGentiShiftDeleteYes)

	Dim ABMGentiShiftDeleteNo As ABMButton
	ABMGentiShiftDeleteNo.InitializeFlat(page, "ABMGentiShiftDeleteNo", "", "", "No", "transparent")
	ABMGentiShiftDeleteModal.Footer.Cell(1,2).AddComponent(ABMGentiShiftDeleteNo)

	Return ABMGentiShiftDeleteModal
End Sub

' method you can call when the user wants to delete a record
Sub ABMGentiShiftDelete(deleteId As Int)
	ActivetiShift = deleteId
	page.ShowModalSheet("tiShiftDelete")
End Sub

' the user clicked yes on the delete messagebox
Sub ABMGentiShiftDeleteYes_Clicked(Target As String)
	Dim SQL As SQL = DBM.GetSQL
	DBM.ABMGenSQLDelete(SQL, "DELETE FROM  WHERE  = ? ", Array As Int(ActivetiShift))
	DBM.CloseSQL(SQL)
	page.CloseModalSheet("tiShiftDelete")
	ActivetiShift = 0

'	LoadABMGenTabletiShift(1)
End Sub

Sub ABMGentiShiftDeleteNo_Clicked(Target As String)
	page.CloseModalSheet("tiShiftDelete")
End Sub

Sub ABMGenBuildtiShiftBadInput() As ABMModalSheet
	Dim ABMGentiShiftBadInputModal As ABMModalSheet
	ABMGentiShiftBadInputModal.Initialize(page, "tiShiftBadInput", False, False, "")
	ABMGentiShiftBadInputModal.IsDismissible = False

	' Build the content grid 
	ABMGentiShiftBadInputModal.Content.AddRowsM(1, True,0,0, "").AddCells12(1, "")
	ABMGentiShiftBadInputModal.Content.BuildGrid  'IMPORTANT once you loaded the complete grid AND before you start adding components

	' add message label
	Dim ABMGentiShiftBadInputMessage As ABMLabel
	ABMGentiShiftBadInputMessage.Initialize(page, "ABMGentiShiftBadInputMessage", "" , ABM.SIZE_PARAGRAPH, False, "")
	ABMGentiShiftBadInputModal.Content.CellR(0,1).AddComponent(ABMGentiShiftBadInputMessage)

	' Build the footer grid 
	ABMGentiShiftBadInputModal.Footer.AddRowsM(1,True,0,0, "").AddCellsOS(1,6,6,6,3,3,3,"").AddCellsOS(1,0,0,0,3,3,3, "")
	ABMGentiShiftBadInputModal.Footer.BuildGrid 'IMPORTANT once you loaded the complete grid AND before you start adding components

	' create the buttons for the footer
	Dim ABMGentiShiftBadInputCancel As ABMButton
	ABMGentiShiftBadInputCancel.InitializeFlat(page, "ABMGentiShiftBadInputCancel", "", "", "Close", "transparent")
	ABMGentiShiftBadInputModal.Footer.Cell(1,2).AddComponent(ABMGentiShiftBadInputCancel)

	Return ABMGentiShiftBadInputModal
End Sub

' the user clicked ok on the Bad Input messagebox
Sub ABMGentiShiftBadInputCancel_Clicked(Target As String)
	page.CloseModalSheet("tiShiftBadInput")
End Sub

Sub ABMGenBuildtiShiftComboItem(id As String, title As String) As ABMLabel 'ignore
	Dim ABMGenLabel As ABMLabel
	ABMGenLabel.Initialize(page, id, "{NBSP}" & title, ABM.SIZE_H6, True, "")
	ABMGenLabel.VerticalAlign = True
	Return ABMGenLabel
End Sub
#End Region


B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=5.9
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Public MyTheme As ABMTheme	
	Private ABM As ABMaterial 'ignore	
	Public NeedsAuthorization As Boolean = False	
	Public pgActionName As String = "Company"
	Public AppVersion As String = DateTime.Now
	Public AppPublishedStartURL As String = ""
	Public AppName As String = "tripinspect"  
	Public TrackingID As String = ""
	Public Origin As String = "http://localhost:51049" '<--- IMPORTANT for youtube videos.  Set here your website address

	Public CachedPages As Map
	Public CacheScavengePeriodSeconds As Int = 15*60 ' 15 minutes ' 10 minutes
	Public SessionMaxInactiveIntervalSeconds As Int = 30*60 ' 30 minutes '1*60*24 ' one hour ' -1 = immortal but beware! This means the cache is NEVER emptied!
	
End Sub

public Sub CurrDT As String
	DateTime.TimeFormat = "HH:mm:ss"
	Return "   *** - ***  "&DateTime.Date(DateTime.Now)&" - "&DateTime.Time(DateTime.Now)
	
End Sub

public Sub BuildParagraphBQledgend(page As ABMPage, id As String, Text As String) As ABMLabel
	Dim lbl As ABMLabel	
    lbl.Initialize(page, id, Text , ABM.SIZE_PARAGRAPH,  False, "lightbluezdepth")
	lbl.IsFlowText = True
	lbl.FontSize("16px")
	lbl.IsBlockQuote = True
	Return lbl
End Sub


Public Sub FindHelp(ws As WebSocket,  pagename As String) As Boolean
	Dim ret As Boolean = False
	Dim SQL As SQL = DBM.GetSQL
	Log(" Find help name: "&pagename)
   	Dim hlpf As List = DBM.SQLSelect2(SQL, "Select * From helpfile where pagename = '"&pagename&"'", Null)
    If hlpf.Size > 0 Then
	   	Dim tbl As Map = hlpf.Get(0)
		Dim fname As String = tbl.Get("helpname")
		If ws.Open Then
'			If File.Exists(File.DirApp,fname) Then
				ws.Eval( "window.open( '../"&fname&"')", Null) 
				ws.Flush
				ret = True
			
	'		End If
		End If	
    End If
    DBM.CloseSQL(SQL)
	Return ret
End Sub


Public Sub GetDeviceWidth( page As ABMPage ) As Int
	
	Dim NowWH  As String = ABM.GetBrowserWidthHeight(page)
	
    If NowWH <> "" And NowWH <> ";" Then ' check if we got something useful back
        Dim split() As String = Regex.Split(";", NowWH) ' split the string
        Dim NewH As Int = split(0) 
	Else
		Dim NewH As Int = -1
    End If
    
	Return NewH
	
End Sub

Public Sub NavigateToPage(ws As WebSocket, PageId As String, TargetUrl As String) 'ignore
	Dim testTargetUrl As String = TargetUrl
	If Not(testTargetUrl.EndsWith(".htm") Or testTargetUrl.EndsWith(".html") Or testTargetUrl.EndsWith("/")) Then
		TargetUrl = TargetUrl & "/"
	End If
	If PageId.Length > 0 Then ABM.RemoveMeFromCache(CachedPages, PageId)
	If ws.Open Then
		ws.Eval("window.location = arguments[0]", Array As Object(TargetUrl))
		ws.Flush
		ws.Close
	End If
End Sub


Public Sub NavigateToPage_old(ws As WebSocket, PageId As String, TargetUrl As String)
	If AppVersion <> "" Then
		TargetUrl = TargetUrl & "?" & AppVersion
	End If
	ABM.RemoveMeFromCache(CachedPages, PageId)
	If ws.Open Then
		ws.Eval("window.location = arguments[0]", Array As Object(TargetUrl))
		ws.Flush
	End If	
	
End Sub



'Public Sub NavigateToPage(ws As WebSocket, TargetUrl As String)	
'
'' new 2.01	
'
'    If AppVersion <> "" Then
'        TargetUrl = TargetUrl & "?" & AppVersion
'    End If
'    If ws.Open Then
'        ws.session.SetAttribute("ABMNewSession", True)    ' NEW 2.01
'        ws.Eval("window.location = arguments[0]", Array As Object(TargetUrl))            
'    End If
'
'' old 2.00
''  If ws.Open Then        
''      If AppVersion <> "" Then
''         TargetUrl = TargetUrl & "?" & AppVersion
''		 Log(" WS open - Target URL: "&TargetUrl)
''      End If    
''
''      ws.Eval("window.location = arguments[0]", Array As Object(TargetUrl))   
''  	  Log(" Web Socket was open in NavigateToPage - went to: "&TargetUrl)	       
''
''  Else
''  	Log(" Web Socket not open in NavigateToPage")	       
''  End If  
'    	
'End Sub

' build methods for ABM objects
Sub BuildTheme(themeName As String)
	MyTheme.Initialize(themeName)
	
	' the page theme
	MyTheme.Page.BackColor = ABM.COLOR_BLUEGREY
	MyTheme.Page.BackColorIntensity = ABM.INTENSITY_LIGHTEN4
	
	MyTheme.AddButtonTheme("btngreen")
	MyTheme.Button("btngreen").BackColor = ABM.COLOR_GREEN
	
	
	MyTheme.AddNavigationBarTheme("nav1theme")
	MyTheme.NavigationBar("nav1theme").TopBarBackColor = ABM.COLOR_BLUE  'ABM.COLOR_RED
	MyTheme.NavigationBar("nav1theme").TopBarBackColorIntensity = ABM.INTENSITY_DARKEN1
	MyTheme.NavigationBar("nav1theme").TopBarBold = True
	MyTheme.NavigationBar("nav1theme").TopBarForeColor = ABM.COLOR_GREY
	MyTheme.NavigationBar("nav1theme").TopBarForeColorIntensity = ABM.INTENSITY_LIGHTEN2
	MyTheme.NavigationBar("nav1theme").TopBarActiveForeColor = ABM.COLOR_WHITE
	MyTheme.NavigationBar("nav1theme").TopBarFontSize = "1.4rem"
	MyTheme.NavigationBar("nav1theme").SideBarFontSize = "1.4rem"
	
	' the navbar theme
'	MyTheme.AddNavigationBarTheme("nav1theme")
'	MyTheme.NavigationBar("nav1theme").TopBarBackColor = ABM.COLOR_LIGHTBLUE
'	MyTheme.NavigationBar("nav1theme").SideBarSubBackColor = ABM.COLOR_BLUEGREY
'    MyTheme.NavigationBar("nav1theme").SideBarSubBackColorIntensity = ABM.INTENSITY_LIGHTEN4
'    MyTheme.NavigationBar("nav1theme").SideBarBold  = True
	
	
	MyTheme.AddImageSliderTheme("sliderthm")
	MyTheme.ImageSlider("sliderthm").Height = 500 
	MyTheme.ImageSlider("sliderthm").TitleForeColor = ABM.COLOR_BLACK
	MyTheme.ImageSlider("sliderthm").SubTitleForeColor = ABM.COLOR_BLACK
	

		
	' a label header theme
	MyTheme.AddLabelTheme("lightblue")
	MyTheme.Label("lightblue").ForeColor = ABM.COLOR_LIGHTBLUE	
	MyTheme.Label("lightblue").ForeColorIntensity = ABM.INTENSITY_DARKEN2
		
	' another toast theme
	MyTheme.AddToastTheme("toastred")
	MyTheme.Toast("toastred").Rounded = True
	MyTheme.Toast("toastred").ActionForeColor = ABM.COLOR_BLACK
	MyTheme.Toast("toastred").BackColor = ABM.COLOR_RED
	
	MyTheme.AddToastTheme("toastgreen")
	MyTheme.Toast("toastgreen").Rounded = True
	MyTheme.Toast("toastgreen").ActionForeColor = ABM.COLOR_BLACK
	MyTheme.Toast("toastgreen").BackColor = ABM.COLOR_GREEN
	
	' input
	MyTheme.AddInputTheme("lightblue")
	MyTheme.Input("lightblue").FocusForeColor = ABM.COLOR_LIGHTBLUE
	MyTheme.Input("lightblue").FocusForeColorIntensity = ABM.INTENSITY_NORMAL
	
	' combo
	MyTheme.AddComboTheme("lightblue")
	MyTheme.Combo("lightblue").FocusForeColor = ABM.COLOR_LIGHTBLUE
	MyTheme.Combo("lightblue").FocusforeColorIntensity = ABM.INTENSITY_NORMAL
	
	' label	
	MyTheme.AddLabelTheme("lightblue")
	MyTheme.Label("lightblue").ForeColor = ABM.COLOR_LIGHTBLUE
	MyTheme.Label("lightblue").ForeColorIntensity = ABM.INTENSITY_DARKEN2
	
	
	' label zdepth	
'	MyTheme.AddLabelTheme("lightbluezdepth")
'	MyTheme.Label("lightbluezdepth").ForeColor = ABM.COLOR_LIGHTBLUE
'	MyTheme.Label("lightbluezdepth").ZDepth = ABM.ZDEPTH_2
	
	MyTheme.AddLabelTheme("lightbluezdepth")
	MyTheme.Label("lightbluezdepth").ForeColor = ABM.COLOR_BLACK
    MyTheme.Label("lightbluezdepth").FontWeight = "BOLD"
'    MyTheme.Label("lightbluezdepth").ForeColorIntensity = ABM.INTENSITY_DARKEN3
	MyTheme.Label("lightbluezdepth").ZDepth = ABM.ZDEPTH_1
	
	MyTheme.AddContainerTheme("footertheme")
	MyTheme.Container("footertheme").BackColor = ABM.COLOR_LIGHTBLUE
	'MyTheme.Container("footertheme").BackColorIntensity = 
	
	' footer label theme
	MyTheme.AddLabelTheme("whitefc")
	MyTheme.Label("whitefc").ForeColor = ABM.COLOR_YELLOW
	MyTheme.Label("whitefc").FontWeight = 300
	
End Sub

Sub BuildNavigationBarextra(page As ABMPage, Title As String, logo As String, ActiveTopReturnName As String, ActiveSideReturnName As String, ActiveSideSubReturnName As String) 
	page.SetFontStack("arial,sans-serif")	
	
	' we have to make an ABMImage from our logo url
	Dim sbtopimg As ABMImage
	sbtopimg.Initialize(page, "sbtopimg", logo, 1)
'	sbtopimg.SetFixedSize(149, 85)	
    sbtopimg.SetFixedSize(236, 49)

	page.NavigationBar.Initialize(page, "nav1", ABM.SIDEBAR_AUTO, Title, True, True, 330, 54, sbtopimg, ABM.COLLAPSE_ACCORDION, "nav1theme")	
'	If ActiveTopReturnName = "Blog" Then
'		page.NavigationBar.SetFadeEffect(0.75)
'	End If
	page.NavigationBar.SideBarLogoHeight = 55
	page.NavigationBar.ActiveTopReturnName = ActiveTopReturnName
	page.NavigationBar.ActiveSideReturnName = ActiveSideReturnName
	page.NavigationBar.ActiveSideSubReturnName = ActiveSideSubReturnName
	
	' you must add at least ONE dummy item if you want to add items to the topbar	in ConnectNaviagationBar
	page.NavigationBar.AddTopItem("DUMMY", " ", "", "", True) ' must be true to allow connect top items
	
	' you must add at least ONE dummy item if you want to add items to the sidebar	
	'page.NavigationBar.AddSideBarItem("DUMMY", "DUMMY", "", "")		
End Sub



Sub BuildNavigationBar(page As ABMPage, Title As String, logo As String, ActiveTopReturnName As String, ActiveSideReturnName As String, ActiveSideSubReturnName As String) 
	page.SetFontStack("arial,sans-serif")
	
'	Log(" Shared call: Title set to: "&pgActionName)
	'page.NavigationBar.Initialize(page, "nav1", Title, ABM.TEXTALIGN_LEFT,  False, True,  False,True,  250,  48, logo,  ABM.COLLAPSE_EXPANDABLE, "nav1theme")
	
	
    
    ' we have to make an ABMImage from our logo url
    Dim sbtopimg As ABMImage
    sbtopimg.Initialize(page, "sbtopimg", logo,  1)
    sbtopimg.SetFixedSize(236, 49)
'	sbtopimg.SetFixedSize(149, 85)	
	
    
    ' our top component can be a more complex component than an image
    ' Dim sbtopimg As ABMContainer = BuildSideBarTopComponent(page, "sbtopimg", "../images/me.jpg", "Me", "Simply the best")
    ' ' we have to adjust the 'logo' height
    ' page.NavigationBar.SideBarLogoHeight = 245
    
    
    ' behaviour as the old declaration    
    'page.NavigationBar.Initialize(page, "nav1", ABM.SIDEBAR_MANUAL_HIDEMEDIUMSMALL, Title, True, True, 330, 48, sbtopimg, ABM.COLLAPSE_ACCORDION, "nav1theme")    
    
    ' new behaviour, the sidebar is ALWAYS hidden
	page.NavigationBar.Initialize(page, "nav1", ABM.SIDEBAR_MANUAL_ALWAYSHIDE, Title, True, True,  430,  54, sbtopimg, ABM.COLLAPSE_ACCORDION, "nav1theme")	
	page.NavigationBar.SideBarLogoHeight = 55
	
    ' new behaviour, the sidebar is created automatically from the top items if the device size is tablet or mobile
    ' note in this case, ALL AddSideBarItem(), AddSideBarSubItem(), AddSideBarDivider() and AddSideBarSubDivider() calls will be IGNORED, as the sidebar will be build dynamically from the top items!
    ' page.NavigationBar.Initialize(page, "nav1", ABM.SIDEBAR_AUTO, Title, True, True, 330, 48, sbtopimg, ABM.COLLAPSE_ACCORDION, "nav1theme")    

    ' new behaviour: on each top item you can set if it should hide of not on a medium or small device.
   ' page.NavigationBar.AddTopItem("Contact", "", "mdi-action-account-circle", "", False)
	
	page.PaddingBottom = 100
	
	page.NavigationBar.ActiveTopReturnName = ActiveTopReturnName
	page.NavigationBar.ActiveSideReturnName = ActiveSideReturnName
	page.NavigationBar.ActiveSideSubReturnName = ActiveSideSubReturnName


' you must add at least ONE dummy item if you want to add items to the topbar   in ConnectNaviagationBar
   page.NavigationBar.AddTopItem("DUMMY",  " ", "", "", False)
  'If Title <> "TripInspect" Then
   ' you must add at least ONE dummy item if you want to add items to the sidebar
    page.NavigationBar.AddSideBarItem("DUMMY",  " ", "", "")
  'End If
	
End Sub

Sub ConnectNavigationBar2(page As ABMPage, ActiveTopReturnName As String, ActiveSideReturnName As String, ActiveSideSubReturnName As String, IsMember As Boolean)
	' Clear the dummies we created in BuildNavigationBar
	page.NavigationBar.Clear
	
	' new behaviour: on each top item you can set if it should hide of not on a medium or small device.
	page.NavigationBar.AddTopItem("Blog",       " Home ", "",       "../HomePage", True)
	page.NavigationBar.AddTopItem("Works",     "How It Works", "", "../WorksPage", True)
	page.NavigationBar.AddTopItem("Products",  "Products / Services", "",   "../ProdPage", True)
'	page.NavigationBar.AddTopItem("Support",  " Support ", "",    "../SupPage", True)
	page.NavigationBar.AddTopItem("Contact",    "Contact Us", "",   "../ContactPage", True)
'	If IsMember Then
'		page.NavigationBar.AddTopItem("Partituren", "Partituren", "", "../PartituurPage/amicanti-partituur.html", True)
'		page.NavigationBar.AddTopItem("Muziek", "Muziek", "", "../BlogPage/amicanti-muziek.html", True)
'		page.NavigationBar.AddTopItem("Logout", "Logout", "mdi-action-exit-to-app", "",  False)

'	Else
		page.NavigationBar.AddTopItem("Login",  "Login", "mdi-action-account-circle", "",  False)
'	End If	
	
	page.NavigationBar.ActiveTopReturnName = ActiveTopReturnName
	page.NavigationBar.ActiveSideReturnName = ActiveSideReturnName
	page.NavigationBar.ActiveSideSubReturnName = ActiveSideSubReturnName
	
	page.NavigationBar.Refresh ' IMPORTANT	
End Sub



Sub ConnectNavigationBar(page As ABMPage)
	' Clear the dummies we created in BuildNavigationBar
	page.NavigationBar.Clear


	page.NavigationBar.AddSideBarItem( "About",   "About / Help", "mdi-action-dashboard",  "../AboutPage")
	page.NavigationBar.AddSideBarDivider '("")

	page.NavigationBar.AddSideBarItem( "Reports",   "System Reports", "mdi-file-folder-open",  "../reportsPage")
	page.NavigationBar.AddSideBarDivider '("")

	page.NavigationBar.AddSideBarItem(   "Config", "Configure App", "mdi-action-settings-applications",  "")	
	page.NavigationBar.AddSideBarSubItem("Config", "Company",  "Company", "mdi-action-home", "../Employees")	
	page.NavigationBar.AddSideBarSubItem("Config", "Users",  "Users", "mdi-action-account-circle", "../Employees")	
	page.NavigationBar.AddSideBarSubItem("Config", "Terminals",  "Terminals", "mdi-action-store", "../Employees")	
	page.NavigationBar.AddSideBarSubItem("Config", "HOS",   "HOS Rules", "mdi-communication-vpn-key", "../Employees")	
	page.NavigationBar.AddSideBarSubItem("Config", "Inspections",  "Inspections", "mdi-action-assignment-turned-in", "../Inspection")	
	page.NavigationBar.AddSideBarSubItem("Config", "Employees",  "Employees", "mdi-action-perm-contact-cal", "../Employees")	
	page.NavigationBar.AddSideBarSubItem("Config", "Vehicles", "Vehicles", "mdi-maps-local-shipping", "../Employees")	
	page.NavigationBar.AddSideBarSubItem("Config", "Devices", "Devices", "mdi-hardware-tablet-android", "../Employees")	
'	page.NavigationBar.AddSideBarSubItem("Config", "Zones"  , "Geo-Zones", "mdi-device-gps-fixed", "../Employees")	
	page.NavigationBar.AddSideBarSubItem("Config", "Pick Lists"  , "Delay Lists", "mdi-action-settings-applications", "../Employees")
		
	page.NavigationBar.AddSideBarDivider '("")
	page.NavigationBar.AddSideBarItem(   "Setup", "Setup App", "mdi-action-settings-applications",  "")
	page.NavigationBar.AddSideBarSubItem("Setup",  "GEOZone", "Geo Zones", "mdi-action-explore", "../zonePage")
	page.NavigationBar.AddSideBarSubItem("Setup",  "GEOviol", "Real Time Events", "mdi-action-alarm-add", "../obcviolsPage")
	page.NavigationBar.AddSideBarSubItem("Setup",  "Reportset", "Setup Reports", "mdi-action-alarm-add", "../setupReports")


	page.NavigationBar.AddSideBarDivider '("")
	page.NavigationBar.AddSideBarItem(   "Apps", "Applications", "mdi-navigation-apps",  "")	
'	page.NavigationBar.AddSideBarSubItem("Apps",  "Map", "Location/Message"   , "mdi-maps-place","../locationPage")
	page.NavigationBar.AddSideBarSubItem("Apps",  "Tickets", "Scale Tickets"   , "mdi-action-receipt","../scale1Page")
	page.NavigationBar.AddSideBarSubItem("Apps", "drvshift",  "Driver Work Shifts", "mdi-image-tune", "../drvshiftsPage")
	page.NavigationBar.AddSideBarSubItem("Apps",  "rtime", "Real Time Events", "mdi-maps-traffic", "../realtimePage")
	
	page.NavigationBar.AddSideBarSubItem("Apps",  "Insp", "DVIR Inspections", "mdi-content-backspace", "../DVIRPage")
	page.NavigationBar.AddSideBarSubItem("Apps",  "Photo", "Driver Photos", "mdi-social-person", "../drvPhoto")
	page.NavigationBar.AddSideBarSubItem("Apps",  "Defects", "Equipment Defects", "mdi-editor-format-list-bulleted", "../defectsPage")
	page.NavigationBar.AddSideBarSubItem("Apps",  "ECMview", "ECM Data", "mdi-editor-insert-chart", "../ecmviewPage")
	page.NavigationBar.AddSideBarSubItem("Apps",  "ECMviol", "Exception Report", "mdi-action-trending-down", "../dataview")
	page.NavigationBar.AddSideBarSubItem("Apps",  "DLogs", "Driver Logs", "mdi-action-view-list", "../drvLogsPage")
	
'	page.NavigationBar.AddTopItem("Blog",       " Home ", "",       "../HomePage", True)
	page.NavigationBar.AddTopItem("LogOff", "Logout", "mdi-action-exit-to-app",   "", False)	
	
	
	'defectsPage
		
	page.NavigationBar.AddSideBarDivider '("")

	
End Sub


Sub LogOff2(page As ABMPage, myAppName As String)
	Dim Network As String = page.ws.Session.GetAttribute("authType")
'	Log(" log off network: "&Network)
	
	Dim Name As String = page.ws.Session.GetAttribute("authName")

	Log(" log off network: "&Network&"  Name: "&Name&" page id: "&page.GetPageID)

	NeedsAuthorization = False

'	Select Case Network
	'	Case "local"
			' do whatever you have to do to log off your user
			
			page.ws.Session.SetAttribute("authType", "")
			page.ws.Session.SetAttribute("authName", "")
'			page.ws.Session.SetAttribute("IsAuthorized", "")	
			page.ws.Session.SetAttribute("UserType", "" )				
			page.ws.Session.SetAttribute("UserRows", "" ) 	
			
			page.ws.Session.SetAttribute("IsAuthorized", "")
	'		NavigateToPage(page.ws, page.GetPageID, "../")			
							
			ABM.DeleteLogin(page, myAppName)
			NavigateToPage(page.ws, page.GetPageID, "../")
	'	Case ABM.SOCIALOAUTH_FACEBOOK
			' the event SignedOffSocialNetwork will be raised on the page, do the rest there
			page.SignOffSocialNetwork(Network, "", Name)						
'	End Select	
End Sub



public Sub LogOff(page As ABMPage)
	Dim Network As String = page.ws.Session.GetAttribute("authType")
	Dim Name As String = page.ws.Session.GetAttribute("authName")
	Select Case Network
		Case "local"
			' do whatever you have to do to log off your user
			
			page.ws.Session.SetAttribute("authType", "")
			page.ws.Session.SetAttribute("authName", "")
			page.ws.Session.SetAttribute("IsAuthorized", "")	
			page.ws.Session.SetAttribute("UserType", "" )				
			page.ws.Session.SetAttribute("UserID", "" ) 	
            page.ws.Session.SetAttribute("UserAction", "")
			
			ABM.DeleteLogin(page, AppName)
			NavigateToPage(page.ws, page.GetPageID,  "../")
		Case ABM.SOCIALOAUTH_FACEBOOK
			' the event SignedOffSocialNetwork will be raised on the page, do the rest there
			page.SignOffSocialNetwork(Network, "", Name)						
	End Select	
	
    If Main.isReddog = False Then
	   NavigateToPage(page.ws, page.GetPageID, "../")
    End If
	
End Sub

Public Sub ShowTimeFormat(ms As Long) As String
 
	Dim seconds, minutes, hours As Double 
	seconds = Round(ms / 1000)
	minutes = Floor(seconds / 60) Mod 60
	hours = Floor(seconds / 3600) 
	' Log(" Hours: "& Floor(seconds / 3600))
	seconds = seconds Mod 60
	Return NumberFormat(hours, 2, 0) & ":" & NumberFormat(minutes, 2, 0) '& ":" & NumberFormat(seconds, 2, 0) 
 
End Sub


Public Sub GetNumMins(ms As Long) As Long
    Dim Mins As Int
	Dim seconds, minutes, hours As Double 
	seconds = Round( ms / 1000)
	minutes = Round2( seconds / 60,0) ' Mod 60
	hours = Floor(seconds / 3600) 
	' Log(" Hours: "& Floor(seconds / 3600))
	seconds = seconds Mod 60
    
'	If hours > 0 Then
'		minutes = minutes + (hours / 60)
'	End If

   Mins = Abs(minutes)
   Return Mins

'	Return NumberFormat(hours, 2, 0) & ":" & NumberFormat(minutes, 2, 0) & ":" & NumberFormat(seconds, 2, 0) 
 
End Sub


Public Sub ShowTimeFormatMins(ms As Int) As String
 
 ms = (ms * 1000) * 60
	Dim seconds, minutes, hours As Double 
	seconds = Round(ms / 1000)
	minutes = Floor(seconds / 60) Mod 60
	hours = Floor(seconds / 3600) 
	' Log(" Hours: "& Floor(seconds / 3600))
	seconds = seconds Mod 60
	Return NumberFormat(hours, 2, 0) & ":" & NumberFormat(minutes, 2, 0) ' & ":" & NumberFormat(seconds, 2, 0) 
 
End Sub



Public Sub ShowTimeFormatMinSec(ms As Long) As String
 
	Dim seconds, minutes, hours As Double
	seconds = Round(ms / 1000)
	minutes = Floor(seconds / 60) Mod 60
	hours = Floor(seconds / 3600)
	' Log(" Hours: "& Floor(seconds / 3600))
	seconds = seconds Mod 60
	Return NumberFormat(minutes, 2, 0) & ":" & NumberFormat(seconds, 2, 0)
 
End Sub



Public Sub ShowTimeFormatSec(ms As Long) As String
 
	Dim seconds, minutes, hours As Double 
	seconds = Round(ms / 1000)
	minutes = Floor(seconds / 60) Mod 60
	hours = Floor(seconds / 3600) 
	' Log(" Hours: "& Floor(seconds / 3600))
	seconds = seconds Mod 60
	Return NumberFormat(hours, 2, 0) & ":" & NumberFormat(minutes, 2, 0) & ":" & NumberFormat(seconds, 2, 0) 
 
End Sub



Public Sub ShowTimeRound(ms As Long) As String
 
	Dim seconds, minutes, minute, hours As Double 
	
	seconds = Round(ms / 1000)
	minute = (seconds / 60) Mod 60
	
	minutes = Floor(seconds / 60) Mod 60
	hours = Floor(seconds / 3600) 
	' Log(" Hours: "& Floor(seconds / 3600))
	seconds = seconds Mod 60
'Log	("Before time: "&  NumberFormat(hours, 2, 0) & ":" & NumberFormat(minutes, 2, 0)&" min: "&minute )

	
	Select True
		Case minute >= 1 And minute < 7.49 
			 minutes = 0
			 
		Case minute >= 7.5 And minute < 15.0 
			 minutes = 15.0
			
		Case minute >= 15.0 And minute < 22.5 
			 minutes = 15.0

		Case minute >= 22.5 And minute < 30.0 
			 minutes = 30.0

		Case minute >= 30.0 And minute < 37.5 
			 minutes = 30.0
			 
		Case minute >= 37.5 And minute < 45.0 
			 minutes = 45.0
			 
		Case minute >= 45.0 And minute < 52.5 
			 minutes = 45.0
			 
		Case minute >= 52.5 And minute < 59.9999 
			 minutes = 0.0
			 hours = hours + 1
	End Select

'Log	("After time:"&  NumberFormat(hours, 2, 0) & ":" & NumberFormat(minutes, 2, 0) )
	Return NumberFormat(hours, 2, 0) & ":" & NumberFormat(minutes, 2, 0) '& ":" & NumberFormat(seconds, 2, 0) 
 
End Sub


Sub BuildFooterFixed(page As ABMPage)
	If page.PageTitle <> "Pub Page" Then	
	  page.isFixedFooter= True
	' because we have a fixed footer at the bottom, we have to adjust the padding of the body in pixels
	  page.PaddingBottom = 0
	  
	End If
	  
	
	page.Footer.AddRows(1, True, "").AddCellsOS(2,0,0,0,6,6,6, "") 
	page.Footer.BuildGrid 'IMPORTANT once you loaded the complete grid AND before you start adding components	
	
	page.Footer.UseTheme("footertheme")
'	Log("Page name: "&page.PageTitle)
	
End Sub


Sub ConnectFooterFixed(page As ABMPage)   

	Dim lbl1 As ABMLabel
	lbl1.Initialize(page, "footlbl1", "TripInspect Website{BR}Built with B4J by Anywhere Software{BR} Using ABMaterial Framework",ABM.SIZE_PARAGRAPH, False, "")
	lbl1.Margins("5" ,"0","0","0")
	lbl1.FontSize("18px")
	lbl1.UseTheme("whitefc")

	page.Footer.Cell(1,1).AddComponent(lbl1)
	
	Dim dt As Long
	dt = DateTime.Now
	Dim str As Int
	str = DateTime.GetYear(dt)
	
	Dim lbl2 As ABMLabel
	lbl2.Initialize(page, "footlbl2", "TripInspect Copyright @"&str&"{BR}By Modern Mobile Solutions{BR}Email: modmobsol@gmail.com",ABM.SIZE_PARAGRAPH, False, "")
	lbl2.FontSize("18px")

	lbl2.Margins("5","0","0","0")
	lbl2.UseTheme("whitefc")

	page.Footer.Cell(1,2).AddComponent(lbl2)	
	
	
End Sub



public Sub BuildHeader(page As ABMPage, id As String, Text As String) As ABMLabel
	Dim hdr As ABMLabel
	hdr.Initialize(page, id, Text, ABM.SIZE_H5, False, "lightblue")
	Return hdr
End Sub


Sub Showdatetime(dt As Long) As String
	
    DateTime.DateFormat = "yyyy/MM/dd"
    DateTime.TimeFormat = "HH:mm"
	Dim sd, tm As String
	sd = DateTime.Date(dt)
	tm = DateTime.Time(dt)
	
	Return sd&" "&tm
	
End Sub

public Sub CreateTheme(ColorName As String) As ABMTheme
	Dim tmpTheme As ABMTheme
	tmpTheme.Initialize(ColorName)	
	tmpTheme.Colorize(ColorName)
	
	' the page theme
	tmpTheme.Page.BackColor = ABM.COLOR_BLUEGREY'COLOR_WHITE
	tmpTheme.Page.BackColorIntensity = ABM.INTENSITY_LIGHTEN4
	
	tmpTheme.Page.AddColorDefinition("myredop7",   ABM.INTENSITY_LIGHTEN4, "#B71C1C", 0.18)
	
	' the navbar theme
	tmpTheme.AddNavigationBarTheme("nav1theme")		
	tmpTheme.NavigationBar("nav1theme").TopBarBackColor = ColorName 'ABM.COLOR_RED
	tmpTheme.NavigationBar("nav1theme").TopBarBackColorIntensity = ABM.INTENSITY_DARKEN1	
	tmpTheme.NavigationBar("nav1theme").TopBarBold = True
	tmpTheme.NavigationBar("nav1theme").TopBarForeColor = ABM.COLOR_GREY
	tmpTheme.NavigationBar("nav1theme").TopBarForeColorIntensity = ABM.INTENSITY_LIGHTEN2
	tmpTheme.NavigationBar("nav1theme").TopBarActiveForeColor = ABM.COLOR_WHITE
	tmpTheme.NavigationBar("nav1theme").TopBarFontSize = "1.4rem"
	tmpTheme.NavigationBar("nav1theme").SideBarFontSize = "1.4rem"
	
	tmpTheme.AddLabelTheme("swhite")
	tmpTheme.Label("swhite").ForeColor = ABM.COLOR_WHITE	
	tmpTheme.Label("swhite").FontWeight = 300

	tmpTheme.AddLabelTheme("syellow")
	tmpTheme.Label("syellow").ForeColor = ABM.COLOR_YELLOW	
	tmpTheme.Label("syellow").FontWeight = 300
	

	tmpTheme.AddLabelTheme("sblue")
	tmpTheme.Label("sblue").ForeColor = ABM.COLOR_BLUE	
	tmpTheme.Label("sblue").FontWeight = 300
	tmpTheme.Label("sblue").ForeColorIntensity = ABM.INTENSITY_DARKEN2'   BackColor = ABM.COLOR_BLUEGREY '   ZDepth = ABM.ZDEPTH_3
'	tmpTheme.Label("sblue").BackColorIntensity = ABM.INTENSITY_LIGHTEN3
	
	
	tmpTheme.AddLabelTheme("sblack")
	tmpTheme.Label("sblack").ForeColor = ABM.COLOR_BLACK	
	tmpTheme.Label("sblack").FontWeight = 300
	
	tmpTheme.AddLabelTheme("sred")
	tmpTheme.Label("sred").ForeColor = ABM.COLOR_RED	
	tmpTheme.Label("sred").FontWeight = 700


	tmpTheme.AddLabelTheme("samber")
	tmpTheme.Label("samber").ForeColor = ABM.COLOR_AMBER	
    tmpTheme.Label("samber").ForeColorIntensity = ABM.INTENSITY_DARKEN3
	tmpTheme.Label("samber").FontWeight = 700

	tmpTheme.AddLabelTheme("splat")
	tmpTheme.Label("splat").ForeColor = ABM.COLOR_GREY
    tmpTheme.Label("splat").ForeColorIntensity = ABM.INTENSITY_DARKEN1
	tmpTheme.Label("splat").FontWeight = 700



	tmpTheme.AddLabelTheme("salert")
	tmpTheme.Label("salert").ForeColor = ABM.COLOR_DEEPORANGE
    tmpTheme.Label("salert").ForeColorIntensity = ABM.INTENSITY_DARKEN4
	tmpTheme.Label("salert").FontWeight = 700


	
	tmpTheme.AddLabelTheme("sgrey")
	tmpTheme.Label("sgrey").ForeColor = ABM.COLOR_GREY
	tmpTheme.Label("sgrey").ForeColorIntensity = ABM.INTENSITY_DARKEN3
	
	
	' the footer theme
	tmpTheme.AddContainerTheme("footertheme")
	tmpTheme.Container("footertheme").BackColor = ColorName
	tmpTheme.Container("footertheme").BackColorIntensity = ABM.INTENSITY_DARKEN3
	
	tmpTheme.AddTableTheme("tbltheme")
	tmpTheme.Table("tbltheme").ZDepth = ABM.ZDEPTH_1
	tmpTheme.Table("tbltheme").AddCellTheme("bgc")	
	tmpTheme.Table("tbltheme").Cell("bgc").Align = ABM.TABLECELL_HORIZONTALALIGN_CENTER
	
	' it is for the header so we have to set all color properties too!
	tmpTheme.Table("tbltheme").AddCellTheme("hc")	
	tmpTheme.Table("tbltheme").Cell("hc").BackColor = ColorName
	tmpTheme.Table("tbltheme").Cell("hc").ForeColor = ABM.COLOR_WHITE	
	tmpTheme.Table("tbltheme").Cell("hc").Align = ABM.TABLECELL_HORIZONTALALIGN_CENTER
	
	tmpTheme.Table("tbltheme").AddCellTheme("deleted")
	tmpTheme.Table("tbltheme").Cell("deleted").UseStrikethrough = True
	
	tmpTheme.AddTableTheme("tbltheme2")
	tmpTheme.Table("tbltheme2").ZDepth = ABM.ZDEPTH_1
	tmpTheme.Table("tbltheme2").AddCellTheme("bgc2")	
	tmpTheme.Table("tbltheme2").Cell("bgc2").Align = ABM.TABLECELL_HORIZONTALALIGN_CENTER
	tmpTheme.Table("tbltheme2").Cell("bgc2").ActiveBackColor = ABM.COLOR_WHITE
	tmpTheme.Table("tbltheme2").Cell("bgc2").BackColor = ABM.COLOR_WHITE
	
	tmpTheme.Table("tbltheme2").AddCellTheme("bg2")	
	tmpTheme.Table("tbltheme2").Cell("bg2").ActiveBackColor = ABM.COLOR_WHITE
	tmpTheme.Table("tbltheme2").Cell("bg2").BackColor = ABM.COLOR_WHITE
	
	' it is for the header so we have to set all color properties too!
	tmpTheme.Table("tbltheme2").AddCellTheme("hc")	
	tmpTheme.Table("tbltheme2").Cell("hc").BackColor = ColorName
	tmpTheme.Table("tbltheme2").Cell("hc").ForeColor = ABM.COLOR_WHITE	
	tmpTheme.Table("tbltheme2").Cell("hc").Align = ABM.TABLECELL_HORIZONTALALIGN_CENTER
	
	tmpTheme.AddContainerTheme("zdepth")
	tmpTheme.Container("zdepth").ZDepth = ABM.ZDEPTH_1
	
	tmpTheme.AddContainerTheme("zdepthred")
	tmpTheme.Container("zdepthred").ZDepth = ABM.ZDEPTH_1
	tmpTheme.Container("zdepthred").BackColor = "myredop7"
	tmpTheme.Container("zdepthred").BackColorIntensity = ABM.INTENSITY_DARKEN4
	
	tmpTheme.AddCellTheme("zdepth")
	tmpTheme.Cell("zdepth").ZDepth = ABM.ZDEPTH_1
	
	tmpTheme.AddCellTheme("center")
	tmpTheme.Cell("center").Align = ABM.CELL_ALIGN_CENTER
	
	tmpTheme.AddCellTheme("border")
	tmpTheme.Cell("border").BorderColor = ABM.COLOR_GREY
	tmpTheme.Cell("border").BorderWidth = 1
	
	tmpTheme.AddCellTheme("grey")
	tmpTheme.Cell("grey").BackColor = ABM.COLOR_GREY
	tmpTheme.Cell("grey").BackColorIntensity = ABM.INTENSITY_DARKEN2
		
	tmpTheme.AddLabelTheme("datenumber")
	tmpTheme.Label("datenumber").ForeColor = ABM.COLOR_RED
	tmpTheme.Label("datenumber").Align = ABM.TEXTALIGN_CENTER
	
	tmpTheme.AddLabelTheme("datemonth")
	tmpTheme.Label("datemonth").ForeColor = ABM.COLOR_BLACK
	tmpTheme.Label("datemonth").Align = ABM.TEXTALIGN_CENTER
	
	tmpTheme.AddLabelTheme("grey")
	tmpTheme.Label("grey").ForeColor = ABM.COLOR_GREY
	
	tmpTheme.AddLabelTheme("center")
	'tmpTheme.Label("center").ForeColor = ABM.COLOR_ORANGE
	tmpTheme.Label("center").Align = ABM.TEXTALIGN_CENTER
	
	tmpTheme.AddLabelTheme("centerwhite")
	tmpTheme.Label("centerwhite").ForeColor = ABM.COLOR_WHITE
	tmpTheme.Label("centerwhite").Align = ABM.TEXTALIGN_CENTER
	
	tmpTheme.AddLabelTheme("centergrey")
	tmpTheme.Label("centergrey").ForeColor = ABM.COLOR_GREY
	tmpTheme.Label("centergrey").ForeColorIntensity = ABM.INTENSITY_LIGHTEN3
	tmpTheme.Label("centergrey").Align = ABM.TEXTALIGN_CENTER
	
	tmpTheme.AddButtonTheme("transparent")
	tmpTheme.Button("transparent").BackColor = ABM.COLOR_TRANSPARENT
	
	tmpTheme.AddModalSheetTheme("modal")
	tmpTheme.ModalSheet("modal").FooterBackColor = ABM.COLOR_RED
	tmpTheme.ModalSheet("modal").FooterBackColorIntensity = ABM.INTENSITY_DARKEN4
	
	Return tmpTheme
End Sub

public Sub BuildLabel(page As ABMPage, id As String, Text As String, size As String, theme As String, margins As Int, fontSize As String) As ABMLabel
	Dim lbl As ABMLabel	
	lbl.Initialize(page, id, Text , size, False, theme)	
	If margins = 0 Then
		lbl.Margins("0", "0", "0", "0")
	End If
	If fontSize <> "" Then
		lbl.FontSize(fontSize)
	End If
	Return lbl
End Sub


Sub GetDriverName2(drv As Int) As String
	
	Dim SQL As SQL = DBM.GetSQL
	Dim res As ResultSet
	Dim nam As String = "Not Found"
	res = SQL.ExecQuery("Select * from emp where PK = "&drv)
	Do While res.NextRow
		nam = res.GetString("Last_name")&", "&res.GetString("First_name").SubString2(0,1)
	Loop
	res.Close
	DBM.CloseSQL(SQL)
	Return nam
End Sub


Sub GetDriverName(drv As Int) As String
	
	Dim SQL As SQL = DBM.GetSQL
	Dim res As ResultSet
    Dim nam As String = "Not Found"
	res = SQL.ExecQuery("Select * from emp where PK = "&drv)
   	Do While res.NextRow
	  nam = res.GetString("Last_name")&", "&res.GetString("First_name")
	Loop	
	res.Close
	DBM.CloseSQL(SQL)
	Return nam
End Sub


Sub GetLoadType(typ As Int) As String
	
	Dim SQL As SQL = DBM.GetSQL
	Dim res As ResultSet
    Dim nam As String = "Not Found"
	res = SQL.ExecQuery("Select * from loadtype where pid = "&typ)
   	Do While res.NextRow
	  nam = res.GetString("name")
	Loop  
	res.Close
	DBM.CloseSQL(SQL)
	Return nam
End Sub


Sub GetActType(typ As Int) As String
	
	Dim SQL As SQL = DBM.GetSQL
	Dim res As ResultSet
    Dim nam As String = "Not Found"
	res = SQL.ExecQuery("Select * from acttype where pid = "&typ)
   	Do While res.NextRow
	  nam = res.GetString("name")
	Loop  
	res.Close
	DBM.CloseSQL(SQL)
	Return nam
End Sub



Sub GetDriverNamePIN(drv As Int) As String
	
	Dim SQL As SQL = DBM.GetSQL
	Dim res As ResultSet
    Dim nam As String = "Not Found"
	res = SQL.ExecQuery("Select * from emp where PK = "&drv)
   	Do While res.NextRow
	  nam = res.GetString("Last_name")&", "&res.GetString("First_name") '&"  [ "&res.GetString("Pin")&" ]"
	Loop  
	res.Close
	DBM.CloseSQL(SQL)
	Return nam
End Sub


Sub GetMilesorKm(trk As String) As Boolean
	
	Dim SQL As SQL = DBM.GetSQL
	Dim res As ResultSet
    Dim nam As Int = 0
	res = SQL.ExecQuery("Select disp_type from vehicle where unit_number = "&trk&" and comp_id = "&Main.comp_id)
   	Do While res.NextRow
	  nam = res.GetString("disp_type")
	Loop	
	res.Close
	DBM.CloseSQL(SQL)
	If nam = 1 Then
	   Return True
	Else
	   Return False
	End If	
	
End Sub


Sub GetDriverPIN(drv As Int) As String
	
	Dim SQL As SQL = DBM.GetSQL
	Dim res As ResultSet
    Dim nam As String = "Not Found"
	res = SQL.ExecQuery("Select * from emp where PK = "&drv)
   	Do While res.NextRow
	  nam = res.GetString("Pin")
	Loop	
	res.Close
	DBM.CloseSQL(SQL)
	Return nam
	
	
End Sub


Sub Mid(Text As String, Start As Int, Length As Int) As String
   Return Text.SubString2(Start-1,Start+Length-1)
End Sub

Sub Mid2(Text As String, Start As Int) As String
   Return Text.SubString(Start-1)
End Sub

Sub ReplaceAll(Text As String, Pattern As String, Replacement As String) As String
  Dim jo As JavaObject = Regex.Matcher(Pattern, Text)
  Return jo.RunMethod("replaceAll", Array(Replacement))
End Sub

public Sub BuildParagraph(page As ABMPage, id As String, Text As String) As ABMLabel
	Dim lbl As ABMLabel	
	lbl.Initialize(page, id, Text , ABM.SIZE_PARAGRAPH, False, "")
	Return lbl
End Sub

public Sub BuildParagraphBQ(page As ABMPage, id As String, Text As String) As ABMLabel
	Dim lbl As ABMLabel	
	lbl.Initialize(page, id, Text , ABM.SIZE_PARAGRAPH, False, "lightblue")
'	lbl.IsBlockQuote = True
	Return lbl
End Sub

public Sub BuildParagraphBQWithZDepth(page As ABMPage, id As String, Text As String) As ABMLabel
	Dim lbl As ABMLabel	
	lbl.Initialize(page, id, Text , ABM.SIZE_H5 , False,"") ' "lightbluezdepth")
	lbl.Margins("0",  "0", "0",  "0")
	lbl.UseTheme("lightbluezdepth")
	lbl.IsBlockQuote = True
	Return lbl
End Sub


public Sub BuildImagefixed(page As ABMPage, id As String, image As String, opacity As Double, Caption As String) As ABMImage
	Dim img As ABMImage
	img.Initialize(page, id, image,opacity)
	img.IsMaterialBoxed = False
	img.IsResponsive = True
	img.Caption = Caption
	img.SetFixedSize(160,120)
	
	Return img
End Sub


public Sub BuildImage(page As ABMPage, id As String, image As String, opacity As Double, Caption As String) As ABMImage
	Dim img As ABMImage
	img.Initialize(page, id, image,opacity)
	'img.IsMaterialBoxed = True
	img.IsResponsive = True
	img.Caption = Caption
	'img.SetFixedSize(160,120)
	
	Return img
End Sub

public Sub BuildImage64(page As ABMPage, id As String, image As String, opacity As Double, Caption As String) As ABMImage
	Dim img As ABMImage
	img.Initialize(page, id, image,opacity)
	img.IsMaterialBoxed = True
	img.IsResponsive = True
	img.Caption = Caption
	
'	img.SetFixedSize( 500,300)
	
	Return img
End Sub


public Sub BuildImage1(page As ABMPage, id As String, image As String, opacity As Double, Caption As String) As ABMImage
	Dim img As ABMImage
	img.Initialize(page, id, image,opacity)
	img.IsMaterialBoxed = True
	img.IsResponsive = True
	img.Caption = Caption
	img.SetFixedSize(160,120)
	
	Return img
End Sub

public Sub BuildParagraphBlQ(page As ABMPage, id As String, Text As StringBuilder) As ABMLabel
	Dim lbl As ABMLabel	
	lbl.Initialize(page, id, Text.ToString , ABM.SIZE_PARAGRAPH,  True, "")
	'lbl.IsBlockQuote = True
	'lbl.IsFlowText = True
	Return lbl
End Sub

Sub BuildFooter(page As ABMPage) 'ignore		
	page.Footer.AddRows(1, True, "").AddCellsOS(2,0,0,0,6,6,6, "") 
	page.Footer.BuildGrid 'IMPORTANT once you loaded the complete grid AND before you start adding components	
	
	page.Footer.UseTheme("footertheme")		
End Sub

public Sub BuildCodeBlock(page As ABMPage, id As String, code As StringBuilder) As ABMCodeLabel
	Dim codelab As ABMCodeLabel	
	codelab.Initialize(page, id, code.ToString, "vb")
	Return codelab
End Sub


public Sub BuildCodeBlockFromSmartString(page As ABMPage, id As String, code As String) As ABMCodeLabel
	Dim codelab As  ABMCodeLabel	
	codelab.Initialize(page, id, code, "en")
	Return codelab
End Sub

Sub RedirectOutput (Dir As String, FileName As String) 'ignore
   #if RELEASE
   Dim out As OutputStream = File.OpenOutput(Dir, FileName, False) 'Set to True to append the logs
   Dim ps As JavaObject
   ps.InitializeNewInstance("java.io.PrintStream", Array(out, True, "utf8"))
   Dim jo As JavaObject
   jo.InitializeStatic("java.lang.System")
   jo.RunMethod("setOut", Array(ps))
   jo.RunMethod("setErr", Array(ps))
   #end if
End Sub



B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=5.9
@EndOfDesignText@
'Main application
Sub Class_Globals
	' change to match you app
	Private Title As String = "TripInspect"
	Private Description As String = "TripInspect Web App"	
	Private AppName As String = "tripinspect"
	Private InitialPage As String = "HomePage"
'	Private hPage As String = "HomePage"

	' other variables needed
	Public AppPage As ABMPage
	Private theme As ABMTheme
	Private ws As WebSocket 'ignore
	Private ABM As ABMaterial 'ignore	
	Private Pages As List	
	Private PageNeedsUpload As List
	Private ABMPageId As String = ""
	
	
End Sub

Public Sub Initialize
Pages.Initialize	
	PageNeedsUpload.Initialize
	' add your icons
	ABM.AddAppleTouchIcon("apple-touch-icon-152x152.png", "152x152")
	ABM.AddMSTileIcon("mstile-144x144.png", "144x144")
	ABM.AddFavorityIcon("favicon-32x32.png", "32x32")	
	ABM.AppVersion=ABMShared.AppVersion
	
	ABMShared.NeedsAuthorization = False
	
	ABM.AppPublishedStartURL = ABM.AppPublishedStartURL

	' turn this mis-guided feature OFF - doesn't play well with others....  will be removed in future updates...
'	ABM.EnablePassiveEventListeners=False
	
	ABMShared.AppName = "tripinspect"
'	ABMShared.AppName = "feedback"
	
	
	
	ABM.PreloadAllJavascriptAndCSSFiles=True	' NEW
	#if release
		ABM.ActivateGZip("Gh2TwFJAyTAIJnb", 1000) ' NEW
	
		Dim folders As List ' NEW
		folders.Initialize
		folders.Add(File.DirApp & "/www/" & ABMShared.AppName & "/images")	
		ABM.ActivatePNGOptimize("Gh2TwFJAyTAIJnb", folders, False , 9, False,  False)
	#end if
		
	
'	Pages.Initialize	
'	PageNeedsUpload.Initialize
'	
'	
'	ABM.AddAppleTouchIcon("apple-touch-icon-57x57.png", "57x57")
'	ABM.AddAppleTouchIcon("apple-touch-icon-60x60.png", "60x60")
'	ABM.AddAppleTouchIcon("apple-touch-icon-72x72.png", "72x72")
'	ABM.AddAppleTouchIcon("apple-touch-icon-76x76.png", "76x76")
'	ABM.AddAppleTouchIcon("apple-touch-icon-114x114.png", "114x114")
'	ABM.AddAppleTouchIcon("apple-touch-icon-120x120.png", "120x120")
'	ABM.AddAppleTouchIcon("apple-touch-icon-144x144.png", "144x144")
'	ABM.AddAppleTouchIcon("apple-touch-icon-152x152.png", "152x152")
'	ABM.AddAppleTouchIcon("apple-touch-icon-180x180.png", "180x180")
'	ABM.AddMSTileIcon("mstile-70x70.png", "70x70")
'	ABM.AddMSTileIcon("mstile-144x144.png", "144x144")
'	ABM.AddMSTileIcon("mstile-150x150.png", "150x150")
'	ABM.AddMSTileIcon("mstile-310x150.png", "310x150")
'	ABM.AddMSTileIcon("mstile-310x310.png", "310x310")
''   ABM.AddFavorityIcon("favicon-16x16.png", "16x16")	
'	ABM.AddFavorityIcon("favicon-32x32.png", "32x32")	
''	ABM.AddFavorityIcon("favicon-96x96.png", "96x96")
''	ABM.AddFavorityIcon("favicon-128x128.png", "128x128")
''	ABM.AddFavorityIcon("favicon-194x194.png", "194x194")		
''	ABM.Manifest = "manifest.json"
'	ABM.MaskIcon = "safari-pinned-tab.svg"
'	ABM.MaskIconColor = ABM.COLOR_RED
'	ABM.MaskIconColorIntensity = ABM.INTENSITY_DARKEN4
'	ABM.MSTileColor = ABM.COLOR_RED
'	ABM.MSTileColorIntensity = ABM.INTENSITY_DARKEN4
'	ABM.AndroidChromeThemeColor = ABM.COLOR_RED
'	ABM.AndroidChromeThemeColorIntensity = ABM.INTENSITY_DARKEN4
''	ABM.BrowserConfig = "browserconfig.xml"
'	ABM.AppVersion = ABMShared.AppVersion
''	
'   #If RELEASE
'        ABM.PreloadAllJavascriptAndCSSFiles=True ' NEW, When the WebApp start, ALL JS/CSS files are pre-loaded 
'        ABM.ActivateGZip("O0boYmck1B0Zurj", 1000) ' NEW, All files bigger than 1000bytes will be pre GZipped
'        ABM.AppDefaultPageCSSInline=True ' NEW, generated CSS included in the HTML, not in seperate files
'        ABM.AppDefaultPageJSInline=True ' NEW, generated JS included in the HTML, not in seperate files
'    
'        Dim folders As List ' NEW, add the folders where your images are (PNG files) and they will be optimized for you
'        folders.Initialize
'        folders.Add( File.DirApp & "/www/" & AppName & "/images")   
'   '     folders.Add( File.DirApp & "/www/" & AppName & "/images/pics")   
'		 
'        ABM.ActivatePNGOptimize("O0boYmck1B0Zurj", folders,  False , 9, False,True)
'    #End If

	BuildPage
End Sub

Private Sub WebSocket_Connected (WebSocket1 As WebSocket)
	Log(" tripinspect application Connected")
	ws = WebSocket1
	' connect our page with the websocket	
	
'----------------------MODIFICATION-------------------------------
	ABMPageId = ABM.GetPageID(AppPage, ABMShared.AppName,ws)
	If AppPage.WebsocketReconnected Then
		ABMShared.NavigateToPage(ws, "", "./")
		Return
	End If
	
	Dim session As HttpSession = ABM.GetSession(ws, ABMShared.SessionMaxInactiveIntervalSeconds) 'ignore
	If session.IsNew Then
		session.Invalidate
		ABMShared.NavigateToPage(ws, "", "./")
		Return
	End If
	
	
	
	
	'----------------------MODIFICATION-------------------------------	
	
	
'	AppPage.SetWebSocket(ws)
	' Prepare the page IMPORTANT!
	AppPage.Prepare	
'	ABMShared.NavigateToPage(ws, "./" & hPage)
  '   Return
	 
	' navigate to the first page

'	ws.Session.SetAttribute("IsAuthorized", "true")
	
	If ABMShared.NeedsAuthorization  Then
		If ws.Session.GetAttribute2("IsAuthorized", "") = "" Then
			Dim loginpwd As String = ABM.LoadLogin ( AppPage,  AppName)
			If loginpwd <> "" Then
				Dim SQL As SQL = DBM.GetSQL
				Dim split() As String = Regex.Split(";", loginpwd)
				
				Dim users As List = DBM.SQLSelect(SQL, "SELECT * FROM Users WHERE UserLogin='" & split(0) & "' AND UserPassword='" & split(1) & "'")
				If users.Size > 0 Then	
					Dim user As Map = users.Get(0)
					ws.Session.SetAttribute("authType", "local")
					ws.Session.SetAttribute("authName", split(0))
					ws.Session.SetAttribute("IsAuthorized", "true")
					ws.Session.SetAttribute("UserType", "" & user.Get("usertype") )	' lowercase!				
					ws.Session.SetAttribute("UserID", "" & user.Get("userid") ) ' lowercase!
					ws.Session.SetAttribute("UserRows",  user.Get("userrows") ) ' lowercase!
					Main.comp_id = user.Get("comp_id")	

					ABMShared.NavigateToPage(ws,ABMPageId, "./" & InitialPage)
					DBM.CloseSQL(SQL)
					Return	
				End If
				DBM.CloseSQL(SQL)
			End If
			AppPage.ShowModalSheet("login")
			Return
		End If
	End If
	
	Log(" Calling connect to home page: " & InitialPage)
	ABMShared.NavigateToPage(ws,ABMPageId, "./" & InitialPage)
End Sub

Public Sub DoLogin
	If ABMShared.NeedsAuthorization = False  Then
'		If ws.Session.GetAttribute2("IsAuthorized", "") = "" Then
			Dim loginpwd As String = ABM.LoadLogin( AppPage, AppName)
			If loginpwd <> "" Then
				Dim SQL As SQL = DBM.GetSQL
				Dim split() As String = Regex.Split(";", loginpwd)
				
				Dim users As List = DBM.SQLSelect(SQL, "SELECT * FROM Users WHERE UserLogin='" & split(0) & "' AND UserPassword='" & split(1) & "'")
				If users.Size > 0 Then	
					Dim user As Map = users.Get(0)
					ws.Session.SetAttribute("authType", "local")
					ws.Session.SetAttribute("authName", split(0))
					ws.Session.SetAttribute("IsAuthorized", "true")
					ws.Session.SetAttribute("UserType", "" & user.Get("usertype") )	' lowercase!				
					ws.Session.SetAttribute("UserID", "" & user.Get("userid") ) ' lowercase!
					ws.Session.SetAttribute("UserRows",  user.Get("userrows") ) ' lowercase!
					Main.comp_id = user.Get("comp_id")	
					
					ABMShared.NavigateToPage(ws,ABMPageId, "./" & InitialPage)
					DBM.CloseSQL(SQL)
					Return	
				End If
				DBM.CloseSQL(SQL)
			End If
			AppPage.ShowModalSheet("login")
			Return
		'End If
	End If
'	ABMShared.NavigateToPage(ws, "./" & hPage)
	
	
	
End Sub

Private Sub WebSocket_Disconnected
	Log("application App Disconnected")
End Sub


Sub Page_ParseEvent(Params As Map) 
    Dim eventName As String = Params.Get("eventname")
    Dim eventParams() As String = Regex.Split(",",Params.Get("eventparams"))
    If eventName = "beforeunload" Then ' NEW 2.01
        Log("preparing for url refresh")
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

'old page parse 2.00
'Sub Page_ParseEvent(Params As Map) 
'	Dim eventName As String = Params.Get("eventname")
'	Dim eventParams() As String = Regex.Split(",",Params.Get("eventparams"))
'	If SubExists(Me, eventName) Then
'		Params.Remove("eventname")
'		Params.Remove("eventparams")
'		Select Case Params.Size
'			Case 0
'				CallSub(Me, eventName)
'			Case 1
'				CallSub2(Me, eventName, Params.Get(eventParams(0)))					
'			Case 2
'				If Params.get(eventParams(0)) = "abmistable" Then
'					Dim PassedTables As List = ABM.ProcessTablesFromTargetName(Params.get(eventParams(1)))
'					CallSub2(Me, eventName, PassedTables)
'				Else
'					CallSub3(Me, eventName, Params.Get(eventParams(0)), Params.Get(eventParams(1)))
'				End If
'			Case Else
'				' cannot be called diretly, to many param
'				CallSub2(Me, eventName, Params)				
'		End Select
'	End If
'End Sub

public Sub AddPage(page As ABMPage)
	Pages.Add(page.Name)
	page.PageTitle = Title
	page.PageDescription = Description
	PageNeedsUpload.Add(ABM.WritePageToDisk(page, File.DirApp & "/www/" & AppName & "/" & page.Name & "/", "index.html", ABMShared.NeedsAuthorization))
End Sub

public Sub StartServer(srvr As Server, srvrName As String, srvrPort As Int)
	ABM.WriteAppLauchPageToDisk(AppPage, File.DirApp & "/www/" & ABMShared.AppName, "index.html", ABMShared.NeedsAuthorization)

	' start the server
	srvr.Initialize(srvrName)
	' uncomment this if you want to directly access the app in the url without having to add the app name
	' e.g. 192.168.1.105:51042 or 192.168.1.105 if you are using port 80
	'srvr.AddFilter( "/", "ABMRootFilter", False )
	' NEW V3 Cache Control
	srvr.AddFilter("/*", "ABMCacheControl", False)
	' NEW 4.00 custom error pages (optional) Needs the ABMErrorHandler class
	srvr.SetCustomErrorPages(CreateMap("org.eclipse.jetty.server.error_page.global": "/" & ABMShared.AppName & "/error")) ' OPTIONAL
	srvr.AddHandler("/" & ABMShared.AppName & "/error", "ABMErrorHandler", False) ' OPTIONAL
'	srvr.AddHandler("/js/b4j_ws.min.js", "ABMSessionCreator", False)
	
	
	srvr.AddWebSocket("/ws/" & ABMShared.AppName, "ABMApplication")

	srvr.AddHandler("/devicetoken", "DeviceToken", False)
	
	For i =0 To Pages.Size - 1
		srvr.AddWebSocket("/ws/" & ABMShared.AppName & "/" & Pages.Get(i) , Pages.Get(i))
		If PageNeedsUpload.Get(i) Then			
			srvr.AddHandler("/" & ABMShared.AppName & "/" & Pages.Get(i) & "/abmuploadhandler", "ABMUploadHandler", False)
		End If
	Next	
	srvr.AddBackgroundWorker("ABMCacheScavenger")
	srvr.Port = srvrPort
	
	srvr.LogWaitingMessages = False
	
	#If RELEASE
		srvr.SetStaticFilesOptions(CreateMap("gzip":True,"dirAllowed":False))
	#Else
		srvr.SetStaticFilesOptions(CreateMap("gzip":False,"dirAllowed":False))
	#End If	
	
'	#If RELEASE
'		srvr.SetStaticFilesOptions(CreateMap("cacheControl": "max-age=604800,public","gzip":True,"dirAllowed":False))
'	#Else
'		srvr.SetStaticFilesOptions(CreateMap("cacheControl": "max-age=604800,public","gzip":False,"dirAllowed":False))
'	#End If
	
' possible problem here...
ABMShared.NeedsAuthorization = False



	File.MakeDir(File.DirApp, "/www/tripinspect/campicshist")
	File.MakeDir(File.DirApp, "/www/tripinspect/campics")
	File.MakeDir(File.DirApp, "/www/tripinspect/inspects")
	File.MakeDir(File.DirApp, "/www/tripinspect/ecmfiles")
	File.MakeDir(File.DirApp, "/www/tripinspect/inecm")

	srvr.AddFilter( "/", "RootFilter", False )

	srvr.AddHandler( "/inspects", "inspectsIN", False)
	srvr.AddHandler( "/campics", "campicsIN", False)
	srvr.AddHandler( "/ecmfiles", "ecmIN", False)  ' old folder for ecm files
'	srvr.AddHandler(  "/inecm", "ecmIN", False)

	srvr.Start	
	
	
'	--------------------------------------------- BEGIN SNIPPET -------------------------------------------------------
	Dim joServer As JavaObject = srvr
	joServer.GetFieldJO("server").RunMethod("stop", Null)
	joServer.GetFieldJO("context").RunMethodJO("getSessionHandler", Null).RunMethodJO("getSessionCookieConfig", Null).RunMethod("setMaxAge", Array(31536000)) ' 1 year
	
	' NEW FEATURE! Each App has its own Session Cookie
	joServer.GetFieldJO("context").RunMethodJO("getSessionHandler", Null).RunMethodJO("getSessionCookieConfig", Null).RunMethod("setName", Array(ABMShared.AppName.ToUpperCase))
	joServer.GetFieldJO("server").RunMethod("start", Null)
	
	Dim secs As Long = ABMShared.CacheScavengePeriodSeconds ' must be defined as a long, else you get a 'java.lang.RuntimeException: Method: setIntervalSec not matched.' error
	joServer.GetFieldJO("context").RunMethodJO("getSessionHandler", Null).RunMethodJO("getSessionIdManager", Null).RunMethodJO("getSessionHouseKeeper", Null).RunMethod("setIntervalSec", Array As Object(secs))
'	--------------------------------------------- END SNIPPET ---------------------------------------------------------
	
	Dim jo As JavaObject = srvr
	Dim connectors() As Object = jo.GetFieldJO("server").RunMethod("getConnectors", Null)
	Dim timeout As Long = ABMShared.SessionMaxInactiveIntervalSeconds*1000
	For Each c As JavaObject In connectors
		c.RunMethod("setIdleTimeout", Array(timeout))
	Next

	ABMShared.CachedPages = srvr.CreateThreadSafeMap
	
	
	
		
End Sub


public Sub StartServerHTTP2(srvr As Server, srvrName As String, srvrPort As Int, SSLsvrPort As Int,  SSLKeyStoreFileName As String, SSLKeyStorePassword As String, SSLKeyManagerPassword As String)
	ABM.WriteAppLauchPageToDisk(AppPage, File.DirApp & "/www/" & ABMShared.AppName, "index.html", ABMShared.NeedsAuthorization)

	Dim ssl As SslConfiguration
	ssl.Initialize
	ssl.SetKeyStorePath(File.DirApp, SSLKeyStoreFileName) 'path to keystore file
	ssl.KeyStorePassword = SSLKeyStorePassword
	ssl.KeyManagerPassword = SSLKeyManagerPassword
	srvr.SetSslConfiguration(ssl, SSLsvrPort)

	' start the server
	srvr.Initialize(srvrName)
	' uncomment this if you want to directly access the app in the url without having to add the app name
	' e.g. 192.168.1.105:51042 or 192.168.1.105 if you are using port 80
	'srvr.AddFilter( "/", "ABMRootFilter", False )
	' NEW V3 Cache Control
	srvr.AddFilter("/*", "ABMCacheControl", False)
	' NEW 4.00 custom error pages (optional) Needs the ABMErrorHandler class
	srvr.SetCustomErrorPages(CreateMap("org.eclipse.jetty.server.error_page.global": "/" & ABMShared.AppName & "/error")) ' OPTIONAL
	srvr.AddHandler("/" & ABMShared.AppName & "/error", "ABMErrorHandler", False) ' OPTIONAL
	
'	srvr.AddHandler("/js/b4j_ws.min.js", "ABMSessionCreator", False)
	srvr.AddWebSocket("/ws/" & ABMShared.AppName, "ABMApplication")
	
	
	For i =0 To Pages.Size - 1
		srvr.AddWebSocket("/ws/" & ABMShared.AppName & "/" & Pages.Get(i) , Pages.Get(i))
		If PageNeedsUpload.Get(i) Then			
			srvr.AddHandler("/" & ABMShared.AppName & "/" & Pages.Get(i) & "/abmuploadhandler", "ABMUploadHandler", False)
		End If
	Next	
	srvr.AddBackgroundWorker("ABMCacheScavenger")
	srvr.Port = srvrPort
	srvr.Http2Enabled = True
	
	
	#If RELEASE
		srvr.SetStaticFilesOptions(CreateMap("gzip":True,"dirAllowed":False))
	#Else
		srvr.SetStaticFilesOptions(CreateMap("gzip":False,"dirAllowed":False))
	#End If	
	
	
'	#If RELEASE
'		srvr.SetStaticFilesOptions(CreateMap("cacheControl": "max-age=604800,public","gzip":True,"dirAllowed":False))
'	#Else
'		srvr.SetStaticFilesOptions(CreateMap("cacheControl": "max-age=604800,public","gzip":False,"dirAllowed":False))
'	#End If

	srvr.Start	
	


'	--------------------------------------------- BEGIN SNIPPET -------------------------------------------------------
	Dim joServer As JavaObject = srvr
	joServer.GetFieldJO("server").RunMethod("stop", Null)
	joServer.GetFieldJO("context").RunMethodJO("getSessionHandler", Null).RunMethodJO("getSessionCookieConfig", Null).RunMethod("setMaxAge", Array(31536000)) ' 1 year
	
	' NEW FEATURE! Each App has its own Session Cookie
	joServer.GetFieldJO("context").RunMethodJO("getSessionHandler", Null).RunMethodJO("getSessionCookieConfig", Null).RunMethod("setName", Array(ABMShared.AppName.ToUpperCase))
	joServer.GetFieldJO("server").RunMethod("start", Null)
	
	Dim secs As Long = ABMShared.CacheScavengePeriodSeconds ' must be defined as a long, else you get a 'java.lang.RuntimeException: Method: setIntervalSec not matched.' error
	joServer.GetFieldJO("context").RunMethodJO("getSessionHandler", Null).RunMethodJO("getSessionIdManager", Null).RunMethodJO("getSessionHouseKeeper", Null).RunMethod("setIntervalSec", Array As Object(secs))
'	--------------------------------------------- END SNIPPET ---------------------------------------------------------
	
	
	Dim jo As JavaObject = srvr
	Dim connectors() As Object = jo.GetFieldJO("server").RunMethod("getConnectors", Null)
	Dim timeout As Long = ABMShared.SessionMaxInactiveIntervalSeconds*1000
	For Each c As JavaObject In connectors
		c.RunMethod("setIdleTimeout", Array(timeout))
	Next

	ABMShared.CachedPages = srvr.CreateThreadSafeMap
End Sub


'public Sub StartServerHTTP2(srvr As Server, srvrName As String, srvrPort As Int, SSLsvrPort As Int,  SSLKeyStoreFileName As String, SSLKeyStorePassword As String, SSLKeyManagerPassword As String)
'	ABM.WriteAppLauchPageToDisk(AppPage, File.DirApp & "/www/" & ABMShared.AppName, "index.html", ABMShared.NeedsAuthorization)
'
'	Dim ssl As SslConfiguration
'	ssl.Initialize
'	ssl.SetKeyStorePath(File.DirApp, SSLKeyStoreFileName) 'path to keystore file
'	ssl.KeyStorePassword = SSLKeyStorePassword
'	ssl.KeyManagerPassword = SSLKeyManagerPassword
'	srvr.SetSslConfiguration(ssl, SSLsvrPort)
'
'	' start the server
'	srvr.Initialize(srvrName)
'
'	srvr.AddFilter("/js/b4j_ws.min.js", "ABMSessionCreator", False)
'	srvr.AddWebSocket("/ws/" & ABMShared.AppName, "ABMApplication")
'	For i =0 To Pages.Size - 1
'		srvr.AddWebSocket("/ws/" & ABMShared.AppName & "/" & Pages.Get(i) , Pages.Get(i))
'		If PageNeedsUpload.Get(i) Then			
'			srvr.AddHandler("/" & ABMShared.AppName & "/" & Pages.Get(i) & "/abmuploadhandler", "ABMUploadHandler", False)
'		End If
'	Next	
'	srvr.AddBackgroundWorker("ABMCacheScavenger")
'	srvr.Port = srvrPort
'	srvr.Http2Enabled = True
'	#If RELEASE
'		srvr.SetStaticFilesOptions(CreateMap("cacheControl": "max-age=604800,public","gzip":True,"dirAllowed":False))
'	#Else
'		srvr.SetStaticFilesOptions(CreateMap("cacheControl": "max-age=604800,public","gzip":False,"dirAllowed":False))
'	#End If
'	srvr.Start	
'	Dim jo As JavaObject = srvr
'	Dim connectors() As Object = jo.GetFieldJO("server").RunMethod("getConnectors", Null)
'	Dim timeout As Long = ABMShared.SessionMaxInactiveIntervalSeconds*1000
'	For Each c As JavaObject In connectors
'		c.RunMethod("setIdleTimeout", Array(timeout))
'	Next
'
'	ABMShared.CachedPages = srvr.CreateThreadSafeMap
'End Sub
'


'public Sub StartServerHTTP2(srvr As Server, srvrName As String, srvrPort As Int, SSLsvrPort As Int,  SSLKeyStoreFileName As String, SSLKeyStorePassword As String, SSLKeyManagerPassword As String)
''	AppPage.Title = Title
''	AppPage.Description = Description
'
'	AppPage.PageTitle = Title
'	AppPage.PageDescription = Description
'
'	ABM.WriteAppLauchPageToDisk(AppPage, File.DirApp & "/www/" & AppName, "index.html", ABMShared.NeedsAuthorization)
'	
'	Dim ssl As SslConfiguration
'	ssl.Initialize
'	ssl.SetKeyStorePath(File.DirApp, SSLKeyStoreFileName) 'path to keystore file
'	ssl.KeyStorePassword = SSLKeyStorePassword
'	ssl.KeyManagerPassword = SSLKeyManagerPassword
'	srvr.SetSslConfiguration(ssl, SSLsvrPort)
'	
'	' start the server
'	srvr.Initialize(srvrName)
'	srvr.AddFilter("/js/b4j_ws.js", "ABMSessionCreator", False) ' <----- Add this line
'	srvr.AddWebSocket("/ws/" & AppName, "ABMApplication")
'	For i =0 To Pages.Size - 1
'		srvr.AddWebSocket("/ws/" & AppName & "/" & Pages.Get(i) , Pages.Get(i))
'		If PageNeedsUpload.Get(i) Then			
'			srvr.AddHandler("/" & AppName & "/" & Pages.Get(i) & "/abmuploadhandler", "ABMUploadHandler", False)
'		End If
'	Next	
'	srvr.Port = srvrPort
'	srvr.Http2Enabled = True
'	Dim options As Map
'	options.Initialize
'	options.Put("dirAllowed", False)
'	srvr.Start		
'End Sub
'
public Sub BuildTheme()
	' start with the base theme defined in ABMShared
	theme.Initialize("pagetheme")
	theme.AddABMTheme(ABMShared.MyTheme)
	
	' add additional themes specific for this page
	
End Sub

public Sub BuildPage()
	' initialize the theme
	BuildTheme
	
	' initialize this page using our theme
'	AppPage.InitializeWithTheme(AppName, "/ws/" & AppName,  False, theme)
	AppPage.InitializeWithTheme(ABMShared.AppName, "/ws/" & ABMShared.AppName, False, ABMShared.SessionMaxInactiveIntervalSeconds, theme)
	
	AppPage.ShowLoader=True
'	AppPage.ShowLoaderType=ABM.LOADER_TYPE_MANUAL ' NEW
	AppPage.PageTitle = "TripInspect"
		
	' adding a navigation bar
	
			
	' create the page grid
	AppPage.AddRows(1,True, "").AddCells12(1,"")
	AppPage.BuildGrid 'IMPORTANT once you loaded the complete grid AND before you start adding components
	
	' add a modal sheet template to enter contact information
	AppPage.AddModalSheetTemplate(BuildLoginSheet)
	
	' add a error box template if the name is not entered
	AppPage.AddModalSheetTemplate(BuildWrongInputModalSheet)
	
End Sub


'Sub ConnectPage()
'	
'	
'	Dim btntruck As ABMButton
'	btntruck.InitializeFlat( AppPage , "btntruck", "mdi-maps-local-shipping", "LEFT", "Login","")
'	AppPage.Cell(2,1).AddComponent(btntruck)
'	
'AppPage.FinishedLoading
'
'Log(" waiting to finish loading")
''	ABMShared.NavigateToPage(ws, "./" & InitialPage)
'
'
'End Sub
'	


Sub msbtn2_Clicked(Target As String)

If Main.isReddog = False Then
	ABMShared.NavigateToPage(ws,ABMPageId, "http://www.tripinspect.com")
End If

End Sub


Sub msbtn1_Clicked(Target As String)
	Dim SQL As SQL = DBM.GetSQL
	Dim mymodal As ABMModalSheet = AppPage.ModalSheet("login")	
	Dim inp1 As ABMInput = mymodal.Content.Component("inp1")
	Dim inp2 As ABMInput = mymodal.Content.Component("inp2")
	' here check the login a page against your login database
	
	Dim users As List = DBM.SQLSelect(SQL, "SELECT * FROM Users WHERE UserLogin='" & inp1.Text & "' AND UserPassword='" & inp2.Text & "'")
	If users.Size = 0 Then	
		AppPage.ShowModalSheet("wronginput")
		Return
	End If
	Dim user As Map = users.Get(0)
	DBM.CloseSQL(SQL)
	ABM.SaveLogin(AppPage, AppName, inp1.Text, inp2.Text)
	ws.Session.SetAttribute("authType", "local")
	ws.Session.SetAttribute("authName", inp1.Text)
	ws.Session.SetAttribute("IsAuthorized", "true")
	ws.Session.SetAttribute("UserType", "" & user.Get("usertype") )	' lowercase!				
	ws.Session.SetAttribute("UserID", "" & user.Get("userid") ) ' lowercase!
	ABMShared.NavigateToPage(ws, ABMPageId,"./" & InitialPage)		
End Sub

Sub inp2_EnterPressed()
	Dim SQL As SQL = DBM.GetSQL
	Dim mymodal As ABMModalSheet = AppPage.ModalSheet("login")	
	Dim inp1 As ABMInput = mymodal.Content.Component("inp1")
	Dim inp2 As ABMInput = mymodal.Content.Component("inp2")
	' here check the login a page against your login database
	Dim users As List = DBM.SQLSelect(SQL, "SELECT * FROM Users WHERE UserLogin='" & inp1.Text & "' AND UserPassword='" & inp2.Text & "'")
	If users.Size = 0 Then	
		AppPage.ShowModalSheet("wronginput")
		Return
	End If
	Dim user As Map = users.Get(0)
	DBM.CloseSQL(SQL)
	ABM.SaveLogin(AppPage, AppName, inp1.Text, inp2.Text)
	ws.Session.SetAttribute("authType", "local")
	ws.Session.SetAttribute("authName", inp1.Text)
	ws.Session.SetAttribute("IsAuthorized", "true")
	ws.Session.SetAttribute("UserType", "" & user.Get("usertype") )	' lowercase!				
	ws.Session.SetAttribute("UserID", "" & user.Get("userid") ) ' lowercase!
	ABMShared.NavigateToPage(ws, ABMPageId,"./" & InitialPage)	
End Sub

Sub BuildLoginSheet() As ABMModalSheet
	Dim myModal As ABMModalSheet
	myModal.Initialize(AppPage, "login", False,  False,"")
	myModal.Content.UseTheme("modalcontent")
	myModal.Footer.UseTheme("modalfooter")
	myModal.IsDismissible = False
	
	' create the grid for the content
	myModal.Content.AddRowsM(4,True,  -10, 0,"").AddCells12MP(1, 0,0,0,0,"")	
	myModal.Content.BuildGrid 'IMPORTANT once you loaded the complete grid AND before you start adding components
	
	' add paragraph	
	myModal.Content.Cell(1,1).AddComponent(ABMShared.BuildParagraphBQWithZDepth( AppPage,"par1","Welcome to TripInspect!  -  Login = demo  -  Password = demo  (or use your own provided by your company/organization)") )
'	myModal.Content.Cell(2,1).AddComponent(ABMShared.BuildParagraphBQWithZDepth( AppPage,"par2","Login = demo  -  Password = demo") )
	
	' create the input fields for the content
	Dim inp1 As ABMInput
	inp1.Initialize(AppPage, "inp1", ABM.INPUT_TEXT, "Login",  False, "lightblue")	
	myModal.Content.Cell(3,1).AddComponent(inp1)
	
	Dim inp2 As ABMInput
	inp2.Initialize(AppPage, "inp2", ABM.INPUT_PASSWORD, "Password", False, "lightblue")
	myModal.Content.Cell(3,1).AddComponent(inp2)
	
	' via social network
'	Dim sOAuth As ABMSocialOAuth
'	sOAuth.Initialize(AppPage, "sOAuth")
'	sOAuth.AddFacebookButton("YOURDOMAIN.COM","YOURKEY", "Sign on with Facebook")		
		
'	myModal.Content.Cell(3,1).AddComponent(sOAuth)
		
	' create the grid for the footer
	' we add a row without the default 20px padding so we need to use AddRowsM().  If we do not use this method, a scrollbar will appear to the sheet.
	'myModal.Footer.AddRowsM(1,True,0,0, "").AddCellsOS(1, 9,9,9,3,3,3, "")
	myModal.Footer.AddRowsM( 2,True,0,0, "").AddCells12(1,"")
	myModal.Footer.BuildGrid 'IMPORTANT once you loaded the complete grid AND before you start adding components
	
	
	' create the button for the footer
	Dim msbtn1 As ABMButton
	msbtn1.InitializeFlat(AppPage, "msbtn1", "", "", "Login", "transparent")
	myModal.Footer.Cell(1,1).AddComponent(msbtn1)	

	Dim msbtn2 As ABMButton
	msbtn2.InitializeFlat(AppPage, "msbtn2", "", "", "Cancel", "transparent")
	myModal.Footer.Cell(1,1).AddComponent(msbtn2)	
	
	Return myModal
End Sub

Sub BuildWrongInputModalSheet() As ABMModalSheet
	Dim myModalError As ABMModalSheet
	myModalError.Initialize(AppPage, "wronginput", False, False,"")
	myModalError.Content.UseTheme("modalcontent")
	myModalError.Footer.UseTheme("modalcontent")
	myModalError.IsDismissible = True
	
	' create the grid for the content
	myModalError.Content.AddRows(1,True, "").AddCells12(1,"")	
	myModalError.Content.BuildGrid 'IMPORTANT once you loaded the complete grid AND before you start adding components
	
	Dim lbl1 As ABMLabel
	lbl1.Initialize(AppPage, "contlbl1", "The login or password are incorrect!",ABM.SIZE_PARAGRAPH, False, "")
	myModalError.Content.Cell(1,1).AddComponent(lbl1)
	
	Return myModalError
End Sub


' clicked on the navigation bar
Sub Page_NavigationbarClicked(Action As String, Value As String)
	AppPage.SaveNavigationBarPosition	
End Sub

Sub Page_FileUploaded(FileName As String, success As Boolean)	
	
End Sub

Sub Page_ToastClicked(ToastId As String, Action As String)
		
End Sub

Sub Page_ToastDismissed(ToastId As String)
	
End Sub

Sub Page_Ready()
	Log("abm application is ready!")
	AppPage.RestoreNavigationBarPosition
	'ConnectPage
End Sub

Sub Page_Authenticated(Params As Map)
	Dim Name As String = Params.Get("name")
	Log("Authenticated " & Name)
	
	Dim CurrentFields, WhereFields As Map
	CurrentFields.Initialize
	WhereFields.Initialize
	
	CurrentFields.Put("UserType", 0)
	CurrentFields.Put("UserName", DBM.SetQuotes(Name))
	CurrentFields.Put("UserLogin", DBM.SetQuotes(Name))
	CurrentFields.Put("UserPassword", DBM.SetQuotes(""))	
	CurrentFields.Put("UserActive", 0)
	
	' build the where values
	WhereFields.Put("UserLogin", DBM.SetQuotes(Name))
	
	Dim SQL As SQL = DBM.GetSQL
	
	Dim SQL_Select As String = "SELECT UserID FROM Users WHERE UserLogin='" & Name & "'"
	Dim SQL_Insert As String = DBM.BuildInsertQuery("Users", CurrentFields)
	Dim SQL_Update As String = DBM.BuildUpdateQuery("Users", CurrentFields, WhereFields)
	Dim newID As Int = DBM.SQLInsertOrUpdate(SQL, SQL_Select, SQL_Insert, SQL_Update )

	
	DBM.CloseSQL(SQL)
	
	ws.Session.SetAttribute("authType", Params.Get("network"))
	ws.Session.SetAttribute("authName", Name)
	ws.Session.SetAttribute("IsAuthorized", "true")
	ws.Session.SetAttribute("UserType", "0" )
	ws.Session.SetAttribute("UserID", "" & newID )
	ABMShared.NavigateToPage(ws,ABMPageId, "./" & InitialPage)
End Sub

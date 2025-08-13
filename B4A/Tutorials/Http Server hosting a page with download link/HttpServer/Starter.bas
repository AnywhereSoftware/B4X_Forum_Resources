B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=9.9
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
	'#ExcludeFromLibrary: True
#End Region

Sub Process_Globals
	Private Server As HttpServer
	Private su As StringUtils
	Public port As Int = 5566
End Sub

Sub Service_Create
	Server.Initialize("Server")
	Server.Start(port)
	Dim n As Notification
	n.Initialize
	n.Icon = "icon"
	n.SetInfo("Http Server is running", "", Main)
	Service.StartForeground(1, n)
End Sub

Sub Service_Start (StartingIntent As Intent)
	Service.StopAutomaticForeground 'Starter service can start in the foreground state in some edge cases.
End Sub

Sub Service_TaskRemoved
	'This event will be raised when the user removes the app from the recent apps list.
End Sub

'Return true to allow the OS default exceptions handler to handle the uncaught exception.
Sub Application_Error (Error As Exception, StackTrace As String) As Boolean
	Return True
End Sub

Sub Service_Destroy
	Server.Stop
	Service.StopForeground(1)
End Sub


Sub Server_HandleRequest (Request As ServletRequest, Response As ServletResponse)
	Try
		Log("Client: " & Request.RemoteAddress)
		Log(Request.RequestURI) 'handle the request based on the URL
		Select True
			Case Request.RequestURI = "/"
				HandleMainPage (Response)
			Case Else
				'send a file as a response (this section is enough in order to host a site)
				SetContentType(Request.RequestURI, Response)
				'Response.SendFile(File.DirAssets, DecodePath(Request.RequestURI.SubString(1)))
				Dim www As String = File.Combine(File.DirInternal, "www")
				
				Dim ph As String = DecodePath( Request.RequestURI.SubString(1) )
				Log(ph)
				Dim fn As String = File.Combine(www, ph)
				Log(fn)
				Log( File.Exists(www, ph) )
				
				Response.SendFile(www, ph)
		End Select
	Catch
		Response.Status = 500
		Log("Error serving request: " & LastException)
		Response.SendString("Error serving request: " & LastException)
	End Try
End Sub

Sub HandleMainPage (Response As ServletResponse)
	Dim MainPage As String = $"<html>
	<body>
		<p>
			This page is served from an Android device!<br/>
			The time here is: $TIME$<br/>
			<a href="/examples/models/gcode/benchy.gcode" target="_blank">/examples/models/gcode/benchy.gcode</a>
		</p>
	</body>
</html>"$
	MainPage = MainPage.Replace("$TIME$", DateTime.Time(DateTime.Now))
	Response.SetContentType("text/html")
	Response.SendString(MainPage)
End Sub

'Sub EncodePath (P As String) As String
'	Return su.EncodeUrl(P, "UTF8")
'End Sub

Sub DecodePath (S As String) As String
	Return su.DecodeUrl(S, "UTF8")
End Sub

Sub SetContentType (FileName As String, Response As ServletResponse)
	Dim extension, ContentType As String
	Dim m As Matcher = Regex.Matcher("\.([^\.]*)$", FileName) 'find the file extension
	If m.Find Then
		extension = m.Group(1).ToLowerCase
		Select extension
			Case "html", "htm"
				ContentType = "text/html"
			Case "js"
				ContentType = "text/javascript"
			Case "gif", "png"
				ContentType = "image/" & extension
			Case "jpeg", "jpg"
				ContentType = "image/jpeg"
			Case "css", "xml"
				ContentType = "text/" & extension
			Case "ico"
				ContentType = "image/vnd.microsoft.icon"
			Case "txt"
				ContentType = "text/plain"
			Case Else
				ContentType = "application/octet-stream"
		End Select
		Response.SetContentType(ContentType)
	End If
End Sub
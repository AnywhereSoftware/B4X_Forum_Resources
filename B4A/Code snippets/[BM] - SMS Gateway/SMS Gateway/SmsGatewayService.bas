B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=13.3
@EndOfDesignText@
#Region  Service Attributes
#StartAtBoot: False
#End Region

Sub Process_Globals
	Private server As HttpServer
	Public port As Int = 5557
	Public SQL1 As SQL
	Public rp As RuntimePermissions
End Sub

Sub Service_Create
	If File.Exists(rp.GetSafeDirDefaultExternal(""), "kredito_sms.db") = False Then
		SQL1.Initialize(rp.GetSafeDirDefaultExternal(""), "kredito_sms.db", True)
		CreateTables
	Else
		SQL1.Initialize(rp.GetSafeDirDefaultExternal(""), "kredito_sms.db", True)
	End If

	server.Initialize("Server")
	server.Start(port)

	Dim n As Notification
	n.Initialize
	n.Icon = "icon"
	n.SetInfo("SMS Gateway", "", Main)
	Service.StartForeground(1, n)
End Sub

Sub CreateTables
	SQL1.ExecNonQuery("CREATE TABLE IF NOT EXISTS messages (id INTEGER PRIMARY KEY AUTOINCREMENT, apikey TEXT, number TEXT, message TEXT, ip TEXT, status TEXT, date TEXT)")
	SQL1.ExecNonQuery("CREATE TABLE IF NOT EXISTS apikeys (apikey TEXT PRIMARY KEY, max_per_month INTEGER)")
End Sub

Sub Server_HandleRequest (Request As ServletRequest, Response As ServletResponse)
	Response.SetContentType("application/json")
	
	Try
		Select True
			Case Request.RequestURI.StartsWith("/addkey")
				HandleAddKey(Request, Response)
			Case Request.RequestURI.StartsWith("/removekey")
				HandleRemoveKey(Request, Response)
			Case Request.RequestURI.StartsWith("/listkeys")
				HandleListKeys(Response)
				
				' Las siguientes rutas requieren API Key:
			Case Request.RequestURI.StartsWith("/sendsms"), _
				 Request.RequestURI.StartsWith("/logs"), _
				 Request.RequestURI.StartsWith("/stats"), _
				 Request.RequestURI.StartsWith("/messages")

				Dim apikey As String = Request.GetParameter("apikey")
				If apikey = "" Or Not (ValidateApiKey(apikey)) Then
					Response.Status = 401
					Response.SendString($"{"status":"error","message":"API KEY inválida"}"$)
					Return
				End If
				
				Select True
					Case Request.RequestURI.StartsWith("/sendsms")
						HandleSendSMS(Request, Response, apikey)
					Case Request.RequestURI.StartsWith("/logs")
						HandleLogs(Request, Response, apikey)
					Case Request.RequestURI.StartsWith("/stats")
						HandleStats(Response, apikey)
					Case Request.RequestURI.StartsWith("/messages")
						HandleMessages(Request, Response, apikey)
				End Select

			Case Else
				Response.Status = 404
				Response.SendString($"{"status":"error","message":"Can't found route ${Request.RequestURI}"}"$)
		End Select

	Catch
		Response.Status = 500
		Response.SendString($"{"status":"error","message":"${LastException.Message}"}"$)
	End Try
End Sub


Sub ValidateApiKey(key As String) As Boolean
	Dim rs As ResultSet = SQL1.ExecQuery2("SELECT apikey FROM apikeys WHERE apikey = ?", Array As String(key))
	Dim exists As Boolean = rs.NextRow
	rs.Close
	Return exists
End Sub

Sub HandleSendSMS(Request As ServletRequest, Response As ServletResponse, apikey As String)
	Dim toNumber As String = Request.GetParameter("to")
	Dim message As String = Request.GetParameter("message")
	If toNumber = "" Or message = "" Then
		Response.Status = 400
		Response.SendString($"{"status":"error","message":"Missing parameters 'to' or 'message'"}"$)
		Return
	End If

	Dim sms As PhoneSms
	sms.Send(toNumber, message)
	Dim now As String = DateTime.Date(DateTime.Now) & " " & DateTime.Time(DateTime.Now)
	SQL1.ExecNonQuery2("INSERT INTO messages (apikey, number, message, ip, status, date) VALUES (?, ?, ?, ?, ?, ?)", _
		Array As Object(apikey, toNumber, message, Request.RemoteAddress, "ENVIADO", now))
	Response.SendString($"{"status":"success","to":"${toNumber}","message":"${message}","date":"${now}"}"$)
End Sub

Sub HandleLogs(Request As ServletRequest, Response As ServletResponse, apikey As String) 'ignore
	Dim rs As ResultSet = SQL1.ExecQuery2("SELECT * FROM messages WHERE apikey = ? ORDER BY id DESC LIMIT 100", Array As String(apikey))
	Dim logs As List
	logs.Initialize
	Do While rs.NextRow
		Dim m As Map
		m.Initialize
		m.Put("number", rs.GetString("number"))
		m.Put("message", rs.GetString("message"))
		m.Put("status", rs.GetString("status"))
		m.Put("date", rs.GetString("date"))
		logs.Add(m)
	Loop
	rs.Close
	Response.SendString($"{"status":"success","logs":${logs}}"$)
End Sub

Sub HandleStats(Response As ServletResponse, apikey As String)
	Dim rs As ResultSet = SQL1.ExecQuery2("SELECT count(*) FROM messages WHERE apikey = ?", Array As String(apikey))
	rs.NextRow
	Dim count As Int = rs.GetInt2(0)
	rs.Close
	Response.SendString($"{"status":"success","apikey":"${apikey}","messages_sent":${count}}"$)
End Sub

Sub HandleMessages(Request As ServletRequest, Response As ServletResponse, apikey As String)
	Dim filters As List = Array As String("number", "status", "date")
	Dim query As String = "SELECT * FROM messages WHERE apikey = ?"
	Dim args As List
	args.Initialize
	args.Add(apikey)

	For Each f As String In filters
		Dim v As String = Request.GetParameter(f)
		If v <> "" Then
			query = query & $" AND ${f} LIKE ?"$
			args.Add("%" & v & "%")
		End If
	Next
	query = query & " ORDER BY id DESC LIMIT 100"
	
	Dim a() As String
	
	Dim i As Int = 0
	
	For Each entry As String In args
		a(i) = entry
		i = i + 1
	Next

	Dim rs As ResultSet = SQL1.ExecQuery2(query, a)
	
	
	Dim list As List
	list.Initialize
	Do While rs.NextRow
		Dim item As Map
		item.Initialize
		item.Put("number", rs.GetString("number"))
		item.Put("message", rs.GetString("message"))
		item.Put("status", rs.GetString("status"))
		item.Put("date", rs.GetString("date"))
		list.Add(item)
	Loop
	rs.Close
	Response.SendString($"{"status":"success","data":${list}}"$)
End Sub

Sub HandleAddKey(Request As ServletRequest, Response As ServletResponse)
	Dim newKey As String = Request.GetParameter("apikey")
	Dim maxMonthly As String = Request.GetParameter("max_per_month")
	If newKey = "" Or maxMonthly = "" Then
		Response.Status = 400
		Response.SendString($"{"status":"error","message":"Missing parameters 'apikey' or 'max_per_month'"}"$)
		Return
	End If

	Try
		SQL1.ExecNonQuery2("INSERT INTO apikeys (apikey, max_per_month) VALUES (?, ?)", Array As Object(newKey, maxMonthly))
		Response.SendString($"{"status":"success","message":"API Key agregada"}"$)
	Catch
		Response.Status = 500
		Response.SendString($"{"status":"error","message":"${LastException.Message}"}"$)
	End Try
End Sub

Sub HandleRemoveKey(Request As ServletRequest, Response As ServletResponse)
	Dim delKey As String = Request.GetParameter("apikey")
	If delKey = "" Then
		Response.Status = 400
		Response.SendString($"{"status":"error","message":"Parameter 'apikey' required"}"$)
		Return
	End If

	Try
		SQL1.ExecNonQuery2("DELETE FROM apikeys WHERE apikey = ?", Array As String(delKey))
		Response.SendString($"{"status":"success","message":"API Key deleted"}"$)
	Catch
		Response.Status = 500
		Response.SendString($"{"status":"error","message":"${LastException.Message}"}"$)
	End Try
End Sub

Sub HandleListKeys(Response As ServletResponse)
	Try
		Dim rs As ResultSet = SQL1.ExecQuery("SELECT apikey, max_per_month FROM apikeys")
		Dim keys As List
		keys.Initialize
		Do While rs.NextRow
			Dim m As Map
			m.Initialize
			m.Put("apikey", rs.GetString("apikey"))
			m.Put("max_per_month", rs.GetInt("max_per_month"))
			keys.Add(m)
		Loop
		rs.Close
		Response.SendString($"{"status":"success","apikeys":${keys}}"$)
	Catch
		Response.Status = 500
		Response.SendString($"{"status":"error","message":"${LastException.Message}"}"$)
	End Try
End Sub


Sub Service_Destroy
	server.Stop
	Service.StopForeground(1)
End Sub

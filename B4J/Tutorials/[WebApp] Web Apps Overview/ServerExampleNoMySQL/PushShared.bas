B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=4
@EndOfDesignText@

Sub Process_Globals
	Public PushDB As SQL
	Private ActiveConnections As Map
	Private ConnectedBrowsers As List
	Private lastMsgId As Long
	Private DAYS_TO_KEEP_MESSSAGES As Int = 2
End Sub


Public Sub Init
	PushDB.InitializeSQLite(File.DirApp, "push.db", True)
	CreatePushTables
	ActiveConnections.Initialize
	Dim res As Object = PushDB.ExecQuerySingleResult("SELECT max(msg_id) FROM messages")
	If res = Null Then lastMsgId = 0 Else lastMsgId = res
	ConnectedBrowsers.Initialize
End Sub

Public Sub NewBrowserConnection (pb As PushBrowser)
	ConnectedBrowsers.Add(pb)
	UpdateBrowsers
End Sub

Public Sub BrowserDisconnected(pb As PushBrowser)
	Dim i As Int = ConnectedBrowsers.IndexOf(pb)
	If i > -1 Then ConnectedBrowsers.RemoveAt(i)
End Sub

Public Sub UpdateBrowsers
	Dim sb As StringBuilder
	sb.Initialize
	For Each id As String In ActiveConnections.Keys
		Dim pb As PushB4A = ActiveConnections.Get(id)
		sb.Append(WebUtils.ReplaceMap("<li>$ID$, Last Ping: $TIME$</li>", _
			CreateMap("ID": id, "TIME": DateTime.Time(pb.lastPingTime))))
	Next
	Dim total As Int = PushDB.ExecQuerySingleResult("SELECT Count(*) FROM users")
	sb.Append(WebUtils.ReplaceMap("<li>Total number of users: $TOTAL$</li>", CreateMap("TOTAL": total)))
	For Each pbr As PushBrowser In ConnectedBrowsers
		CallSubDelayed2(pbr, "UpdateConnectedIds", sb.ToString)
	Next
End Sub

Public Sub NewConnection(Id As String, pb As PushB4A)
	Log("NewConnection: " & Id)
	ActiveConnections.Put(Id, pb)
	If PushDB.ExecQuerySingleResult2("SELECT count(id) FROM users WHERE id = ?", Array As String(Id)) = 0 Then
		'new id. Insert it to the database
		DBUtils.InsertMaps(PushDB, "users", Array As Object(CreateMap("id": Id, "last_access": DateTime.Now)))
		NewMessage("Hello device #" & Id & "!!!", Array As Object(Id))
	Else
		'send queued messages
		SendUserMessages(Id, pb)
	End If
	UpdateBrowsers
End Sub

Private Sub SendSingleMessage(MsgId As String, Msg As String, pb As PushB4A)
	Dim msgs As List = Array (MsgId, Msg)
	CallSubDelayed2(pb, "SendMessages", msgs)
End Sub

Private Sub SendUserMessages(id As String, pb As PushB4A)
	Dim table As List = DBUtils.ExecuteMemoryTable(PushDB, _
		"SELECT messages.msg_id, text FROM messages, messages_to_deliver WHERE messages.msg_id = messages_to_deliver.msg_id AND user_id = ?", _
			Array As String(id), 0)
	If table.Size > 0 Then
		Dim msgs As List
		msgs.Initialize
		For Each row() As String In table
			msgs.Add(row(0))
			msgs.Add(row(1))
		Next
		CallSubDelayed2(pb, "SendMessages", msgs)
	End If
End Sub

Public Sub NewMessage(Text As String, target As List)
	lastMsgId = lastMsgId + 1
	DBUtils.InsertMaps(PushDB, "messages", _
		Array As Object(CreateMap("text": Text, "msg_id": lastMsgId, "time": DateTime.Now)))
	If target = Null OR target.IsInitialized = False Then
		'get all
		Dim t As List = DBUtils.ExecuteMemoryTable(PushDB, "SELECT id FROM users", Null, 0)
		Dim target As List
		target.Initialize
		For Each row() As String In t
			target.Add(row(0))
		Next
	End If
	Dim ListOfMaps As List
	ListOfMaps.Initialize
	For Each id As String In target
		ListOfMaps.Add(CreateMap("msg_id": lastMsgId, "user_id": id))
	Next
	DBUtils.InsertMaps(PushDB, "messages_to_deliver", ListOfMaps)
	For Each id As String In target
		If ActiveConnections.ContainsKey(id) Then
			SendSingleMessage(lastMsgId, Text, ActiveConnections.Get(id))
		End If
	Next
	For Each pb As PushBrowser In ConnectedBrowsers
		CallSubDelayed(pb, "UpdateMessagesTable")
	Next
End Sub

Public Sub RemoveConnection(Id As String, pb As PushB4A)
	If pb <> ActiveConnections.Get(Id) Then Return 'this can happen if there was a "phantom" connection
	Log("Removing: " & Id)
	DBUtils.UpdateRecord(PushDB, "users", "last_access", DateTime.Now, CreateMap("id": Id))
	ActiveConnections.Remove(Id)
	
	'clean up procedures
	Dim p As Period
	p.Initialize
	p.Days = -DAYS_TO_KEEP_MESSSAGES
	Dim old As Long = DateUtils.AddPeriod(DateTime.Now, p)
	Dim table As List = DBUtils.ExecuteMemoryTable(PushDB, "SELECT msg_id FROM messages WHERE time < ?", _
		Array As String(old), 0)
	If table.Size > 0 Then
		PushDB.BeginTransaction
		Try
			For Each row() As String In table
				DBUtils.DeleteRecord(PushDB, "messages_to_deliver", CreateMap("msg_id": row(0)))
			Next
			PushDB.ExecNonQuery2("DELETE FROM messages WHERE time < ?", Array As Object(old))
			PushDB.TransactionSuccessful
		Catch
			Log(LastException)
			PushDB.Rollback
		End Try
	End If
	UpdateBrowsers
End Sub

Private Sub CreatePushTables
	'create the tables if they do not exist
	If PushDB.ExecQuerySingleResult( _
		"SELECT count(name) FROM sqlite_master WHERE type='table' AND name='users'") = 0 Then
		PushDB.ExecNonQuery("PRAGMA journal_mode = wal") 'best mode for multithreaded apps.
		DBUtils.CreateTable(PushDB, "users", CreateMap("id": DBUtils.DB_TEXT, "last_access": DBUtils.DB_INTEGER), "users")
		DBUtils.CreateTable(PushDB, "messages", _ 
			CreateMap("msg_id": DBUtils.DB_INTEGER, "text": DBUtils.DB_TEXT, "time": DBUtils.DB_INTEGER), "msg_id")
		DBUtils.CreateTable(PushDB, "messages_to_deliver", CreateMap("user_id": DBUtils.DB_TEXT, "msg_id": DBUtils.DB_INTEGER), "")
	End If
End Sub
B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=12.5
@EndOfDesignText@
Sub Class_Globals
	
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	
	Private m_RealTime As SupabaseRealtime
	#If SupabaseRealTime
	#If B4J
	Private ws As WebSocketClient
	#Else
	Private ws As WebSocket
	#End IF
	#End If
	
	Private m_Supabase As Supabase
	
	Private tmr_Heartbeat As Timer
	
	Private Channels As List
	Private m_isConnected As Boolean = False
	Private m_FilterString As String
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(Callback As Object, EventName As String,ThisSupabase As Supabase,RealTime As SupabaseRealtime)
	m_RealTime = RealTime
	mEventName = EventName
	mCallBack = Callback
	Channels.Initialize
	m_Supabase = ThisSupabase
	#If SupabaseRealTime
	ws.Initialize("ws")
	#End If
	tmr_Heartbeat.Initialize("tmr_Heartbeat",30000)
	
End Sub

'SchemaName - public
'Available Events:
'"*" | "INSERT" | "UPDATE" | "DELETE"
'Default: *
Public Sub Channel(SchemaName As String,TableName As String,Filter As String) As SupabaseRealtime_Channel
	
	Dim Topic As String = BuildTopic(SchemaName,TableName,Filter)
	
	Dim ThisChannel As SupabaseRealtime_Channel = GetChannel(Topic)
	If ThisChannel = Null Then
		Dim ThisChannel As SupabaseRealtime_Channel
		ThisChannel.Initialize(Me,Topic,SchemaName,TableName,Filter,m_Supabase)
		Channels.Add(ThisChannel)
	End If
	RefreshAccessToken(Topic)
	Return ThisChannel
	
End Sub

'Public Sub Filter(FilterString As String)
'	m_FilterString = FilterString
'End Sub

Private Sub BuildTopic(SchemaName As String,TableName As String,FilterString As String) As String 'Ignore
	Dim Topic As String = "realtime:" & SchemaName
	If TableName <> "" Then Topic = Topic & ":" & TableName
	If FilterString <> "" Then Topic = Topic & ":" & FilterString
	Return Topic
End Sub

Private Sub GetChannel(TopicName As String) As SupabaseRealtime_Channel
	For Each ThisChannel As SupabaseRealtime_Channel In Channels
		If ThisChannel.Topic = TopicName Then
			Return ThisChannel
			Exit
		End If
	Next
	Return Null
End Sub

Public Sub SendMessage(jSonMessage As String)
	#If SupabaseRealTime
	
	Do While ws.Connected = False
		Connect
		wait for SendMessage_Connected
	Loop
	
	ws.SendText(jSonMessage)
	#End If
End Sub

Public Sub RemoveChannel(ThisChannel As SupabaseRealtime_Channel)
	For i = 0 To Channels.Size -1
		If Channels.Get(i) = ThisChannel Then
			Channels.RemoveAt(i)
			Exit
		End If
	Next
End Sub

Public Sub Connect
	#If SupabaseRealTime
	
	Dim NewUrl As String = m_Supabase.URL.Replace("http://","").Replace("https://","")
	ws.Connect($"wss://${NewUrl}/realtime/v1/websocket?apikey=${m_Supabase.ApiKey}&vsn=1.0.0"$)
	Wait For ws_Connected
	m_isConnected = True
	Connected
	tmr_Heartbeat.Enabled = True
	CallSubDelayed(Me,"SendMessage_Connected")
	#End If
End Sub

Public Sub Close
	tmr_Heartbeat.Enabled = False
	#If SupabaseRealTime
	If ws.Connected Then ws.Close
	#End If
End Sub

Public Sub getisConnected As Boolean
	Return m_isConnected
End Sub

Private Sub ws_Closed (Reason As String)
	m_isConnected = False
	tmr_Heartbeat.Enabled = False
	Disconnected
	Log("SupabaseRealtimeClient: Socket closed reason: " & Reason)
End Sub

Private Sub ws_TextMessage (Message As String)
	'Log("ws_TextMessage: " & Message)
	If m_Supabase.LogEvents Then Log("SupabaseRealtimeClient: " & Message)
	
	Dim parser As JSONParser
	parser.Initialize(Message)
	Dim jRoot As Map = parser.NextObject
	Dim payload As Map = jRoot.Get("payload")
	
	If jRoot.ContainsKey("event") And jRoot.Get("event") = "phx_reply" Then
		
		Subscribed
		
	Else If jRoot.ContainsKey("event") And (jRoot.Get("event") = m_RealTime.Event_UPDATE Or jRoot.Get("event") = m_RealTime.Event_INSERT Or jRoot.Get("event") = m_RealTime.Event_DELETE Or jRoot.Get("event") = m_RealTime.Event_ALL) Then
			
		Dim Data As SupabaseRealtime_Data
		Data.Initialize
			
		'Dim Schema As String = payload.Get("schema")
		Data.CommitTimestamp = Supabase_Functions.ParseDateTime(payload.Get("commit_timestamp"))
		Dim columns As List = payload.Get("columns")
		For Each colcolumns As Map In columns
			columns.Add(CreateMap("Name":colcolumns.Get("name"),"Type":colcolumns.Get("type")))
		Next
		Data.Columns = columns
		Data.Records = payload.Get("record")
		If Data.Records.IsInitialized = False Then Data.Records.Initialize
		Data.OldRecord = payload.Get("old_record")
		If Data.OldRecord.IsInitialized = False Then Data.OldRecord.Initialize
		Data.EventType = payload.Get("type")
		Data.Table = payload.Get("table")
		
		'Dim errors As String = payload.Get("errors")
		
		Dim DatabaseError As SupabaseError
		DatabaseError.Initialize
		DatabaseError.Success = payload.Get("errors").As(String) = ""
		If DatabaseError.Success = False Then
			DatabaseError.StatusCode = 401
			DatabaseError.ErrorMessage = "User not Authenticated or check your RLS policy!"
		End If
		Data.DatabaseError = DatabaseError
		
		DataReceived(Data)
		
	Else If jRoot.ContainsKey("event") And jRoot.Get("event") = m_RealTime.SubscribeType_Broadcast Then
		
		Dim BroadcastData As SupabaseRealtime_BroadcastData
		BroadcastData.Initialize
		BroadcastData.Event = payload.Get("event")
		
'		Dim json As JSONParser
'		json.Initialize(payload.Get("payload"))
'		BroadcastData.Payload = json.NextObject
		BroadcastData.Payload = payload.Get("payload")
		
		Dim DatabaseError As SupabaseError
		DatabaseError.Initialize
		DatabaseError.Success = payload.Get("errors").As(String) = ""
		If DatabaseError.Success = False Then
			DatabaseError.StatusCode = 401
			DatabaseError.ErrorMessage = "User not Authenticated or check your RLS policy!"
		End If
		BroadcastData.DatabaseError = DatabaseError
		
		BroadcastDataReceived(BroadcastData)
		
	Else If jRoot.ContainsKey("event") And jRoot.Get("event") = "presence_diff" Then
		
		Dim PresenceData As SupabaseRealtime_PresenceData
		PresenceData.Initialize
		PresenceData.Event = payload.Get("event")
		
		Dim json As JSONParser
		json.Initialize(payload.Get("joins"))
		PresenceData.Joins = json.NextObject
		
		json.Initialize(payload.Get("leaves"))
		PresenceData.Leaves = json.NextObject
		
		Dim DatabaseError As SupabaseError
		DatabaseError.Initialize
		DatabaseError.Success = payload.Get("errors").As(String) = ""
		If DatabaseError.Success = False Then
			DatabaseError.StatusCode = 401
			DatabaseError.ErrorMessage = "User not Authenticated or check your RLS policy!"
		End If
		PresenceData.DatabaseError = DatabaseError
		
		PresenceDataReceived(PresenceData)
		
	End If
	
End Sub

Private Sub ws_BinaryMessage (Data() As Byte)
	'Log("ws_BinaryMessage")
End Sub

Private Sub RefreshAccessToken(Topic As String)
	
	Dim DatabaseError As SupabaseError
	DatabaseError.Initialize
	
	Wait For (m_Supabase.Auth.GetAccessToken) Complete (AccessToken As String)
	If AccessToken = "" Then
		DatabaseError.StatusCode = 401
		DatabaseError.ErrorMessage = "Unauthorized"
		'Return DatabaseError
	End If
	
	Dim m As Map
	m.Initialize
	m.Put("event", "access_token")
	m.Put("topic", Topic)
	m.Put("ref", "")
	m.Put("payload", CreateMap("access_token":AccessToken))
	'"Authorization":"Bearer " & AccessToken
	Dim jg As JSONGenerator
	jg.Initialize(m)
	SendMessage(jg.ToString)
	
End Sub

Private Sub tmr_Heartbeat_Tick
	Heartbeat
End Sub

Private Sub Heartbeat
	'Log("Heartbeat")
	
	Dim DatabaseError As SupabaseError
	DatabaseError.Initialize
	
	Wait For (m_Supabase.Auth.GetAccessToken) Complete (AccessToken As String)
	If AccessToken = "" Then
		DatabaseError.StatusCode = 401
		DatabaseError.ErrorMessage = "Unauthorized"
		'Return DatabaseError
	End If
	
	Dim m As Map
	m.Initialize
	m.Put("event", "heartbeat")
	m.Put("topic", "phoenix")
	m.Put("payload", CreateMap("access_token":AccessToken))
	m.Put("ref", "")
	'm.Put("payload", CreateMap("postgres_changes":CreateMap("event":"*","table":"dt_Tasks","schema":"public")))
	Dim jg As JSONGenerator
	jg.Initialize(m)
	SendMessage(jg.ToString)
	
End Sub

#Region Events

Private Sub Connected 'Ignore
	If Supabase_Functions.SubExists2(mCallBack,mEventName & "_Connected",0) Then
		CallSub(mCallBack,mEventName & "_Connected")
	End If
End Sub

Private Sub Disconnected 'Ignore
	If Supabase_Functions.SubExists2(mCallBack,mEventName & "_Disconnected",0) Then
		CallSub(mCallBack,mEventName & "_Disconnected")
	End If
End Sub

Private Sub Subscribed
	If Supabase_Functions.SubExists2(mCallBack,mEventName & "_Subscribed",0) Then
		CallSub(mCallBack,mEventName & "_Subscribed")
	End If
End Sub

Private Sub DataReceived(Data As SupabaseRealtime_Data)
	If Supabase_Functions.SubExists2(mCallBack,mEventName & "_DataReceived",1) Then
		CallSub2(mCallBack,mEventName & "_DataReceived",Data)
	End If
End Sub

Private Sub BroadcastDataReceived(BroadcastData As SupabaseRealtime_BroadcastData)
	If Supabase_Functions.SubExists2(mCallBack,mEventName & "_BroadcastDataReceived",1) Then
		CallSub2(mCallBack,mEventName & "_BroadcastDataReceived",BroadcastData)
	End If
End Sub

Private Sub PresenceDataReceived(PresenceData As SupabaseRealtime_PresenceData)
	If Supabase_Functions.SubExists2(mCallBack,mEventName & "_PresenceDataReceived",1) Then
		CallSub2(mCallBack,mEventName & "_PresenceDataReceived",PresenceData)
	End If
End Sub


#End Region
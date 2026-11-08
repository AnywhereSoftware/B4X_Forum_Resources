B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=12.5
@EndOfDesignText@
Sub Class_Globals
	
	Private m_Client As SupabaseRealtime_Client
	Private m_Topic As String
	Private m_SchemaName As String = "public"
	Private m_TableName As String
	Private m_Filter As String = ""
	Private m_Subscribed As Boolean
	
	'Private m_Event As String = "*"
	'Private m_SubscribeType As String
	                                    
	Private m_Supabase As Supabase
	Private m_Actions As List
	
	Private Const PhxEvents_JOIN As String = "phx_join"    'ignore
	Private Const PhxEvents_REPLY  As String = "phx_reply" 'ignore
	Private Const PhxEvents_LEAVE  As String = "phx_leave" 'ignore
	Private Const PhxEvents_ERROR  As String = "phx_error" 'ignore
	Private Const PhxEvents_Close  As String = "phx_close" 'ignore
	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(Client As SupabaseRealtime_Client,Topic As String, SchemaName As String, TableName As String, Filter As String,ThisSupabase As Supabase)
	m_Supabase = ThisSupabase
	m_Topic = Topic
	m_Client = Client
	m_SchemaName = SchemaName
	m_TableName = TableName
	'm_Event = EventName
	m_Filter = Filter
	m_Actions.Initialize
End Sub

Public Sub getTopic As String
	Return ""
End Sub

'Broadcast - Send ephemeral messages from client to clients with low latency
'Presence - Track and synchronize shared state between clients
'Postgres_Changes - Listen to Postgres database changes and send them to authorized clients
'<code>Realtime.SubscribeType_Broadcast</code>
'<code>Realtime.SubscribeType_Presence</code>
'<code>Realtime.SubscribeType_PostgresChanges</code>
Public Sub On(SubscribeType As String) As SupabaseRealtime_Channel
	m_Actions.Add(CreateMap("SubscribeType":SubscribeType,"Event":"*","ReceiveOwnBroadcasts":False,"AcknowledgeBroadcasts":False))
	'm_SubscribeType = SubscribeType
	Return Me
End Sub

'<code>Realtime.Event_DELETE</code>
'<code>Realtime.Event_INSERT</code>
'<code>Realtime.Event_UPDATE</code>
'<code>Realtime.Event_ALL</code>
'<code>Realtime.Event_Sync</code>
'<code>Realtime.Event_Join</code>
'<code>Realtime.Event_Leave</code>
Public Sub Event(EventName As String) As SupabaseRealtime_Channel
	m_Actions.Get(m_Actions.Size -1).As(Map).Put("Event",EventName)
	'm_Event = EventName
	Return Me
End Sub

'Whether you should receive your own broadcasts
Public Sub ReceiveOwnBroadcasts(Enabled As Boolean) As SupabaseRealtime_Channel
	m_Actions.Get(m_Actions.Size -1).As(Map).Put("ReceiveOwnBroadcasts",Enabled)
	Return Me
End Sub

'Whether the server should send an acknowledgment message for each broadcast message
Public Sub AcknowledgeBroadcasts(Enabled As Boolean) As SupabaseRealtime_Channel
	m_Actions.Get(m_Actions.Size -1).As(Map).Put("AcknowledgeBroadcasts",Enabled)
	Return Me
End Sub

'Public Sub Publish(Message As String)
'	
'	If m_Subscribed = False Then Return
'	
''	Select Message
''		Case m_Client.Event_DELETE
''			
''		Case m_Client.Event_UPDATE
''			
''		Case m_Client.Event_INSERT
''			
''		Case m_Client.Event_ALL
''			
''	End Select
'	
'End Sub

Public Sub Subscribe As SupabaseRealtime_Channel
	If m_Subscribed Then
		Log("SupabaseRealtimeChannel: Already subscribed to topic: " & m_Topic)
		Return Me
	Else
		
		Dim DatabaseError As SupabaseError
		DatabaseError.Initialize
	
		If m_Supabase.Auth.TokenInformations.AccessToken = "" Then
			DatabaseError.StatusCode = 401
			DatabaseError.ErrorMessage = "Unauthorized"
			'Return DatabaseError
		End If
		
		For Each Properties As Map In m_Actions
				
			Dim m As Map
			m.Initialize
			m.Put("event", PhxEvents_JOIN)
			m.Put("topic", m_Topic)
			m.Put("ref", "")
			
			Select Properties.Get("SubscribeType")
				Case "postgres_changes"
					Dim mPayload As Map = CreateMap("event":Properties.Get("Event"),"table":m_TableName,"schema":m_SchemaName)
					If m_Filter <> "" Then mPayload.Put("filter",m_Filter)
					m.Put("payload", CreateMap(Properties.Get("SubscribeType"):mPayload,"user_token":m_Supabase.Auth.TokenInformations.AccessToken))
				Case "presence"
					Dim mPayload As Map = CreateMap("key":Properties.Get("Event"))
					m.Put("payload", CreateMap("config": CreateMap(Properties.Get("SubscribeType"):mPayload,"user_token":m_Supabase.Auth.TokenInformations.AccessToken)))
				Case "broadcast"
					Dim mPayload As Map = CreateMap("ack":Properties.Get("AcknowledgeBroadcasts"),"self":Properties.Get("ReceiveOwnBroadcasts"))
					m.Put("payload", CreateMap("config": CreateMap(Properties.Get("SubscribeType"):mPayload,"user_token":m_Supabase.Auth.TokenInformations.AccessToken)))
			End Select
			
			Dim jg As JSONGenerator
			jg.Initialize(m)
			'Log(jg.ToString)
			m_Client.SendMessage(jg.ToString)
		
		Next
		
	End If
	m_Subscribed = True
	Return Me
End Sub

Public Sub Unsubscribe As SupabaseRealtime_Channel
	If m_Subscribed = False Then
		Log("SupabaseRealtimeChannel: Already unsubscribed from topic: " & m_Topic)
		Return Me
	Else
		Dim m As Map
		m.Initialize
		m.Put("event", PhxEvents_LEAVE)
		m.Put("topic", m_Topic)
		m.Put("ref", "")
		m.Put("payload", "")
		Dim jg As JSONGenerator
		jg.Initialize(m)
		
		m_Client.SendMessage(jg.ToString)
	End If
	m_Subscribed = False
	Return Me
End Sub

Public Sub Close
	m_Client.RemoveChannel(Me)
End Sub

'<code>Channel1.SendBroadcast("cursor-pos",CreateMap("x":"198","y":"50"))</code>
Public Sub SendBroadcast(EventName As String,Payload As Map)
	
	Dim m As Map
	m.Initialize
	m.Put("event", "broadcast")
	m.Put("topic", m_Topic)
	m.Put("payload", CreateMap("event":EventName,"payload":Payload,"type":"broadcast"))
	m.Put("user_token",m_Supabase.Auth.TokenInformations.AccessToken)
	m.Put("ref","")
	
	Dim jg As JSONGenerator
	jg.Initialize(m)
	'Log(jg.ToString)
	m_Client.SendMessage(jg.ToString)

	
End Sub

'Presence only
'A client will receive state from any other client that is subscribed to the same topic. 
'It will also automatically trigger its own sync and join event handlers.
Public Sub Track(UserStatus As Map)
	
	Dim m As Map
	m.Initialize
	m.Put("event", "track")
	m.Put("type", "presence")
	m.Put("topic", m_Topic)
	m.Put("payload", UserStatus)
	m.Put("user_token",m_Supabase.Auth.TokenInformations.AccessToken)
	m.Put("ref","")
	
	Dim jg As JSONGenerator
	jg.Initialize(m)
	'Log(jg.ToString)
	m_Client.SendMessage(jg.ToString)
	
End Sub

'Presence only
'You can stop tracking presence using the untrack() method. This will trigger the sync and leave event handlers.
Public Sub Untrack
	
	Dim m As Map
	m.Initialize
	m.Put("event", "untrack")
	m.Put("type", "presence")
	m.Put("topic", m_Topic)
	m.Put("user_token",m_Supabase.Auth.TokenInformations.AccessToken)
	m.Put("ref","")
	
	Dim jg As JSONGenerator
	jg.Initialize(m)
	'Log(jg.ToString)
	m_Client.SendMessage(jg.ToString)
	
End Sub
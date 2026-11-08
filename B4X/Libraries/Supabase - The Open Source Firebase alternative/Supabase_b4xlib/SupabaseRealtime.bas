B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=12.5
@EndOfDesignText@

#Event: Connected
#Event: Disconnected
#Event: Subscribed
#Event: DataReceived(Data As SupabaseRealtime_Data)
#Event: BroadcastDataReceived(BroadcastData As SupabaseRealtime_BroadcastData)
#Event: PresenceDataReceived(PresenceData As SupabaseRealtime_PresenceData)

Private Sub Class_Globals
	
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	
	Public Const SubscribeType_Broadcast As String = "broadcast"
	Public Const SubscribeType_Presence As String = "presence"
	Public Const SubscribeType_PostgresChanges As String = "postgres_changes"
	
	Public Const Filter_Equal As String = "eq"
	Public Const Filter_NotEqual As String = "neq"
	Public Const Filter_GreatherThan As String = "gt"
	Public Const Filter_GreatherThanOrEqual As String = "gte"
	Public Const Filter_LessThan As String = "lt"
	Public Const Filter_LessThanOrEqual As String = "lte"
	Public Const Filter_In As String = "in"
	
	Private m_Client As SupabaseRealtime_Client
	
End Sub

'B4J: https://www.b4x.com/android/forum/threads/jwebsocketclient-library.40985/#content

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(Callback As Object, EventName As String,ThisSupabase As Supabase)
	mEventName = EventName
	mCallBack = Callback
	m_Client.Initialize(Callback,EventName,ThisSupabase,Me)
End Sub

Public Sub Connect
	m_Client.Connect
End Sub

Public Sub Close
	m_Client.Close
End Sub

'Creates an realtime channel
'Postgres changes example:
'<code>
'	Realtime _
'	.Channel("public","dt_Chat",Realtime.BuildFilter("room_id",Realtime.Filter_Equal,"3")) _
'	.On(Realtime.SubscribeType_PostgresChanges) _
'	.Event(Realtime.Event_ALL) _
'	.Subscribe
'</code>
'Broadcast example:
'<code>
'	Realtime _
'	.Channel("Room1","","") _
'	.On(Realtime.SubscribeType_Broadcast) _
'	.ReceiveOwnBroadcasts(False) _
'	.AcknowledgeBroadcasts(False) _
'	.Subscribe
'</code>
'Presence example:
'<code>
'	Realtime _
'	.Channel("Room1","","") _
'	.On(Realtime.SubscribeType_Presence) _
'	.Event(Realtime.Event_Sync) _
'	.On(Realtime.SubscribeType_Presence) _
'	.Event(Realtime.Event_Join) _
'	.On(Realtime.SubscribeType_Presence) _
'	.Event(Realtime.Event_Leave) _
'	.Subscribe
'</code>
Public Sub Channel(Schema As String,Table As String,Filter As String) As SupabaseRealtime_Channel
	Return m_Client.Channel(Schema,Table,Filter)
End Sub

Public Sub BuildFilter(Column As String,FilterName As String,Value As String) As String
	If FilterName.ToLowerCase = "in" Then
		Return Column & "=" & FilterName & ".(" & Value & ")"
	Else
		Return Column & "=" & FilterName & "." & Value
	End If
End Sub

Public Sub RemoveChannel(ThisChannel As SupabaseRealtime_Channel)
	m_Client.RemoveChannel(ThisChannel)
End Sub

'Returns true if the websocket is connected to the database
Public Sub getisConnected As Boolean
	Return m_Client.isConnected
End Sub

'PostgresChanges only
Public Sub getEvent_DELETE As String
	Return "DELETE"
End Sub

'PostgresChanges only
Public Sub getEvent_UPDATE As String
	Return "UPDATE"
End Sub


Public Sub getEvent_INSERT As String
	Return "INSERT"
End Sub

'PostgresChanges only
Public Sub getEvent_ALL As String
	Return "*"
End Sub

'Presence only
Public Sub getEvent_Sync As String
	Return "sync"
End Sub

'Presence only
Public Sub getEvent_Join As String
	Return "join"
End Sub

'Presence only
Public Sub getEvent_Leave As String
	Return "leave"
End Sub

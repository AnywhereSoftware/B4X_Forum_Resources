B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=2.18
@EndOfDesignText@
'WebSocket class
Sub Class_Globals
	Private ws As WebSocket
	Private id As String
	Public lastPingTime As Long
End Sub

Public Sub Initialize
	
End Sub

Private Sub WebSocket_Connected (WebSocket1 As WebSocket)
	ws = WebSocket1
	ws.RunFunction("ServerReady", Null)
	lastPingTime = DateTime.Now
End Sub

Public Sub Device_Id (Data As Map)
	id = Data.Get("id")
	Dim version As Double = Data.Get("version") 'ignore
	CallSubDelayed3(PushShared, "NewConnection", id, Me)
End Sub

'not used. Allows the device to send messages
Public Sub Device_MessageFrom(Data As Map)
	CallSubDelayed3(PushShared, "NewMessage", Data.Get("text"), Null)
End Sub

Public Sub Device_Ping(Data As Map)
	lastPingTime = DateTime.Now
	CallSubDelayed(PushShared, "UpdateBrowsers")
	ws.RunFunction("Pong", Null)
End Sub

Public Sub Device_MessageDelivered(Data As Map)
	PushShared.PushDB.BeginTransaction
	Try
		Dim ids As List = Data.Get("ids")
		For Each mid As String In ids
			DBUtils.DeleteRecord(PushShared.PushDB, "messages_to_deliver", _
				CreateMap("user_id": id, "msg_id": mid))
		Next
		PushShared.PushDB.TransactionSuccessful
	Catch
		Log(LastException)
		PushShared.PushDB.Rollback
	End Try
End Sub


Public Sub SendMessages(Messages As List)
	ws.RunFunction("NewMessage", Messages)
	ws.Flush
	
End Sub

Private Sub WebSocket_Disconnected
	If id <> "" Then CallSubDelayed3(PushShared, "RemoveConnection", id, Me)
End Sub
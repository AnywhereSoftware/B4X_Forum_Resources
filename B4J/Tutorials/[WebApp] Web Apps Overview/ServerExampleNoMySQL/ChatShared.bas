B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=4
@EndOfDesignText@
	
Sub Process_Globals
	Public AvoidDuplicates As Map
	Private connections As Map
	Private LastMessages As List
	
End Sub

Public Sub Init
	'this map is accessed from other threads so it needs to be a thread safe map
	AvoidDuplicates = Main.srvr.CreateThreadSafeMap
	connections.Initialize
	LastMessages.Initialize
End Sub

Public Sub NewConnection(cht As Chat, name As String)
	connections.Put(name, cht)
	Log("NewConnection: " & name)
	'update the users liss
	UpdateUsersList
	'send the messages history to the new user
	Dim sb As StringBuilder
	sb.Initialize
	For Each s As String In LastMessages
		sb.Append(s)
	Next
	CallSubDelayed2(cht, "NewMessage", sb.ToString)
End Sub

Public Sub NewMessage(Name As String, msg As String)
	LastMessages.Add(msg)
	If LastMessages.Size > 10 Then
		LastMessages.RemoveAt(0)
	End If
	'notify each of the connected users about the new message
	For Each c As Chat In connections.Values
		CallSubDelayed2(c, "NewMessage", msg)
	Next
End Sub

Private Sub UpdateUsersList
	Dim sb As StringBuilder
	sb.Initialize
	For Each u As String In connections.Keys
		sb.Append("<li>").Append(u).Append("</li>")
	Next
	Dim data As String = sb.ToString
	For Each c As Chat In connections.Values
		CallSubDelayed2(c, "UpdateMembersList", data)
	Next
	
End Sub

Public Sub Disconnect(cht As Chat, name As String)
	If connections.ContainsKey(name) = False OR connections.Get(name) <> cht Then Return
	connections.Remove(name)
	AvoidDuplicates.Remove(name.ToLowerCase)
	UpdateUsersList
End Sub



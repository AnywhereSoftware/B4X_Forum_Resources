B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
' BroadcastBuddyNotification.bas
Private Sub Class_Globals
	Private base As BroadcastBuddyBase
End Sub

Public Sub Initialize(apiKey As String)
	base.Initialize(apiKey)
End Sub

'Sends notification to desktop devices
Public Sub SendPushNotification(website As String, icon As String, title As String, description As String, click As String) As ResumableSub
	Dim data As Map
	data.Initialize
	data.Put("website", website)
	data.Put("icon", icon)
	data.Put("title", title)
	data.Put("click", click)
	data.Put("description", description)
	Dim sf as Object = base.MakeRequest("notification/push", "POST", data)
	Wait For(sf) Complete(response As Object)
	Return response
End Sub

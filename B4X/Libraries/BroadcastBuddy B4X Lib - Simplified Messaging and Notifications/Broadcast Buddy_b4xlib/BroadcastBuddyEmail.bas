B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
' BroadcastBuddyEmail.bas
Private Sub Class_Globals
	Private base As BroadcastBuddyBase
End Sub

Public Sub Initialize(apiKey As String)
	base.Initialize(apiKey)
End Sub

Public Sub ComposeEmail(recipient As String, subject As String, message As String) As ResumableSub
	Dim data As Map
	data.Initialize
	data.Put("receiver", recipient)
	data.Put("subject", subject)
	data.Put("message", message)
'	data.Put("template", template)
	Dim sf as Object = base.MakeRequest("email/send", "POST", data)
	Wait For(sf) Complete(response As Object)
	Return response
End Sub

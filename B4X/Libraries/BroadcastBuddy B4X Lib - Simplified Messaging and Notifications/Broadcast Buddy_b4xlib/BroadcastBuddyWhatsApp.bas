B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
' BroadcastBuddyWhatsApp.bas
Private Sub Class_Globals
	Private base As BroadcastBuddyBase
End Sub

Public Sub Initialize(apiKey As String)
	base.Initialize(apiKey)
End Sub

'Gets your WhatsApp instance status
Public Sub SessionStatus As ResumableSub
	Dim sf As Object = base.MakeRequest("whatsapp/session/status", "GET", Null)
	Wait For(sf) Complete(response As Object)
	Return response
End Sub

'Sends message to a WhatsApp contact
Public Sub SendMessage(recipient As String, message As String) As ResumableSub
	Dim data As Map
	data.Initialize
	data.Put("receiver_type", "user")
	data.Put("recipient", recipient)
	data.Put("message", message)
	Dim sf As Object = base.MakeRequest("whatsapp/compose/text", "POST", data)
	Wait For(sf) Complete(response As Object)
	Return response
End Sub

'Sends media to a WhatsApp contact
Public Sub SendMedia(recipient As String, caption As String, media_url As String) As ResumableSub
	Dim data As Map
	data.Initialize
	data.Put("receiver_type", "user")
	data.Put("recipient", recipient)
	data.Put("caption", caption)
	data.Put("media_url", media_url)
	Dim sf As Object = base.MakeRequest("whatsapp/compose/image", "POST", data)
	Wait For(sf) Complete(response As Object)
	Return response
End Sub

'Sends docuemtn to a WhatsApp contact
Public Sub SendDocument(recipient As String, caption As String, media_url As String) As ResumableSub
	Dim data As Map
	data.Initialize
	data.Put("receiver_type", "user")
	data.Put("recipient", recipient)
	data.Put("caption", caption)
	data.Put("media_url", media_url)
	Dim sf As Object = base.MakeRequest("whatsapp/compose/document", "POST", data)
	Wait For(sf) Complete(response As Object)
	Return response
End Sub

'Sends location to a WhatsApp contact
Public Sub SendLocation(recipient As String, message As String, latitude As String, longitude As String) As ResumableSub
	Dim data As Map
	data.Initialize
	data.Put("receiver_type", "user")
	data.Put("recipient", recipient)
	data.Put("latitude", latitude)
	data.Put("longitude", longitude)
	Dim sf As Object = base.MakeRequest("whatsapp/compose/location", "POST", data)
	Wait For(sf) Complete(response As Object)
	Return response
End Sub

'Sends poll to a WhatsApp contact
Public Sub SendPoll(recipient As String, poll_name As String, poll_options As String, allow_multiple_answers As String) As ResumableSub
	Dim data As Map
	data.Initialize
	data.Put("receiver_type", "user")
	data.Put("recipient", recipient)
	data.Put("poll_name", poll_name)
	data.Put("poll_options", poll_options)
	data.Put("allow_multiple_answers", allow_multiple_answers)
	Dim sf As Object = base.MakeRequest("whatsapp/compose/poll", "POST", data)
	Wait For(sf) Complete(response As Object)
	Return response
End Sub


'Sends contact to a WhatsApp contact
Public Sub SendContact(recipient As String, contact As String) As ResumableSub
	Dim data As Map
	data.Initialize
	data.Put("receiver_type", "user")
	data.Put("recipient", recipient)
	data.Put("contact", contact)
	Dim sf As Object = base.MakeRequest("whatsapp/compose/location", "POST", data)
	Wait For(sf) Complete(response As Object)
	Return response
End Sub

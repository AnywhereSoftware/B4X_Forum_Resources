B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
' BroadcastBuddySMS.bas
Private Sub Class_Globals
	Private base As BroadcastBuddyBase
	Private api_key As String
End Sub

Public Sub Initialize(apiKey As String)
	api_key = apiKey	
	base.Initialize(apiKey)
End Sub

'Checks SMS Balance
Public Sub CheckBalance As ResumableSub
	Dim sf As Object = base.MakeRequest("sms/balance?api_key="&api_key, "GET", Null)
	Wait For(sf) Complete(response As Object)
	Return response
End Sub

'Sends bulk SMS
Public Sub BulkSMS(recipients As String, message As String, senderId As String) As ResumableSub
	Dim data As Map
	data.Initialize
	data.Put("contacts", recipients)
	data.Put("message", message)
	data.Put("sender_id", senderId)
	Dim sf As Object = base.MakeRequest("sms/compose", "POST", data)
	Wait For(sf) Complete(response As Object)
	Return response
End Sub

'Sends a single SMS
Public Sub SendSMS(recipient As String, message As String, senderId As String) As ResumableSub
	Dim data As Map
	data.Initialize
	data.Put("contacts", recipient)
	data.Put("message", message)
	data.Put("sender_id", senderId)
	Dim sf As Object = base.MakeRequest($"sms/send?api_key=${api_key}&contact=${recipient}&message=${message}&sender_id=${senderId}"$, "GET", Null)
	Wait For(sf) Complete(response As Object)
	Return response
End Sub

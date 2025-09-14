B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
' BroadcastBuddyAccount.bas
Private Sub Class_Globals
	Private base As BroadcastBuddyBase
End Sub

Public Sub Initialize(apiKey As String)
	base.Initialize(apiKey)
End Sub

'Adds a contact to your subscription
Public Sub AddContact(first_name As String,last_name As String, email As String, birthday As String, group_id As String, contact As String) As ResumableSub
	Dim data As Map
	data.Initialize
	data.Put("first_name", first_name)
	data.Put("last_name", last_name)
	data.Put("email", email)
	data.Put("birthday", birthday)
	data.Put("group_id", group_id)
	data.Put("contact", contact)
	Dim sf As Object = base.MakeRequest("contacts/add", "POST", data)
	Wait For(sf) Complete(response As Object)
	Return response
End Sub

B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Receiver
Version=13.4
@EndOfDesignText@
Sub Process_Globals
End Sub

Sub Receiver_Receive (FirstTime As Boolean, StartingIntent As Intent)

	' "req" is the internal request id used to correlate the SMS
	' "ev"  indicates the event type: SENT or DELIVERED
	Dim req As Int = -1
	Dim ev As String = ""

	' Extract extras from the Intent
	If StartingIntent.IsInitialized Then
		If StartingIntent.HasExtra("req") Then req = StartingIntent.GetExtra("req")
		If StartingIntent.HasExtra("ev") Then ev = StartingIntent.GetExtra("ev")
	End If

	ev = ev.Trim.ToUpperCase

	' Basic validation: if no request id or event, exit
	If req = -1 Or ev = "" Then Return

	' Make sure the correlation Map exists
	If Starter.SmsPending.IsInitialized = False Then Return

	' If this req is not known, ignore it
	If Starter.SmsPending.ContainsKey(req) = False Then Return

	' Retrieve your internal SMS id (for example, DB id)
	Dim idsms As String = Starter.SmsPending.Get(req)

	' Get Android result code from the broadcast
	Dim rc As Int = GetResultCode

	Dim status As String = ""
	Dim err As String = ""

	If ev = "SENT" Then

		' SENT = message accepted by the modem/network (not yet delivered to recipient)
		If rc = -1 Then
			status = "SENT"
			err = "Accepted by the network"
		Else
			status = "FAILED"
			err = "Send failed: " & TranslateResultCodeEn(rc)
		End If

		' IMPORTANT:
		' Do NOT remove the Map entry here.
		' We wait for DELIVERED to finally clean it.

	Else If ev = "DELIVERED" Then

		' DELIVERED = carrier delivery confirmation (if supported)
		If rc = -1 Then
			status = "DELIVERED"
			err = "Delivered (carrier confirmation)"
		Else
			status = "FAILED"
			err = "Not confirmed / possibly not delivered: " & TranslateResultCodeEn(rc)
		End If

		' Now we can safely remove the correlation entry
		Starter.SmsPending.Remove(req)

	Else
		' Unknown event type
		Return
	End If

	' Here you would normally update your backend / database
	' For this minimal example we just log the values
	Log(idsms)
	Log(status)
	Log(err)

End Sub


Private Sub GetResultCode As Int
	' Retrieves the broadcast result code from Android
	Dim jo As JavaObject
	jo.InitializeContext
	Try
		Return jo.RunMethod("getResultCode", Null)
	Catch
		' Fallback value (treated as success in this simplified example)
		Return -1
	End Try
End Sub


Private Sub TranslateResultCodeEn(rc As Int) As String
	' Standard Android SmsManager result codes
	' These codes are mainly relevant for the SENT event
	Select rc
		Case 1
			Return "generic modem failure (RC=1)"
		Case 2
			Return "radio off / airplane mode (RC=2)"
		Case 3
			Return "invalid message (null PDU) (RC=3)"
		Case 4
			Return "no service / no coverage (RC=4)"
		Case Else
			Return "unknown failure (RC=" & rc & ")"
	End Select
End Sub
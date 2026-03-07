B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.4
@EndOfDesignText@
Sub Class_Globals
	Private fm As FirebaseMessaging
	Private sms_number, sms_message, id_sms As String
End Sub

' Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	Try
		If fm.IsInitialized = False Then fm.Initialize("fm")
		' Subscribe to the topic used to trigger SMS sending
		fm.SubscribeToTopic("enviarsms")
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub Receiver_Receive (FirstTime As Boolean, StartingIntent As Intent)
	' This receiver is used to handle Firebase intents.
	If FirstTime Then
		Try
			fm.Initialize("fm")
		Catch
			Log(LastException)
		End Try
	End If
	fm.HandleIntent(StartingIntent)
End Sub

Sub fm_TokenRefresh (Token As String)
	Log("Firebase_TokenRefresh: " & Token)
End Sub

Sub SendSmsImmutable(idsms As String, Number As String, Body As String)
	' Map used to correlate "req" => idsms (your DB id or internal id)
	If Starter.SmsPending.IsInitialized = False Then Starter.SmsPending.Initialize

	' Random request id (used as a key to match SENT/DELIVERED callbacks)
	Dim req As Int = Rnd(1, 0x7fffffff)
	Starter.SmsPending.Put(req, idsms)

	' Android SmsManager
	Dim jo As JavaObject
	jo.InitializeStatic("android.telephony.SmsManager")
	Dim sm As JavaObject = jo.RunMethod("getDefault", Null)

	Dim ctxt As JavaObject
	ctxt.InitializeContext

	Dim PendingIntent As JavaObject
	PendingIntent.InitializeStatic("android.app.PendingIntent")

	' PendingIntent flags: ONE_SHOT + IMMUTABLE (Android 12+ requirement in many cases)
	Dim FLAG_ONE_SHOT As Int = 1073741824
	Dim FLAG_IMMUTABLE As Int = 67108864
	Dim flags As Int = Bit.Or(FLAG_ONE_SHOT, FLAG_IMMUTABLE)

	' Single receiver component (your SmsStatusReceiver)
	Dim comp As String = Application.PackageName & "/.smsstatusreceiver"

	' SENT intent
	Dim intentSent As Intent
	intentSent.Initialize("", "")
	intentSent.SetComponent(comp)
	intentSent.PutExtra("req", req)
	intentSent.PutExtra("ev", "SENT")
	Dim piSent As Object = PendingIntent.RunMethod("getBroadcast", Array(ctxt, req, intentSent, flags))

	' DELIVERED intent
	Dim intentDel As Intent
	intentDel.Initialize("", "")
	intentDel.SetComponent(comp)
	intentDel.PutExtra("req", req)
	intentDel.PutExtra("ev", "DELIVERED")
	Dim piDel As Object = PendingIntent.RunMethod("getBroadcast", Array(ctxt, req + 1, intentDel, flags))

	' Send SMS with both status PendingIntents
	sm.RunMethod("sendTextMessage", Array(Number, Null, Body, piSent, piDel))
End Sub

Sub fm_MessageArrived (Message As RemoteMessage)
	Log("Message arrived")

	' Check if it comes from a notification, and if it is not the current user then ignore it
	' (Your actual filtering logic would go here)

	sms_number  = Message.GetData.GetDefault("sms_number", "")
	sms_message = Message.GetData.GetDefault("sms_message", "")
	id_sms      = Message.GetData.GetDefault("id_sms", "")

	SendSmsImmutable(id_sms, sms_number, sms_message)
End Sub
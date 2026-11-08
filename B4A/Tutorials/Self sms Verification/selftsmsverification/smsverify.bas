B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=10.7
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
	
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Type Message (Address As String, Body As String)
	Public smsVerified As Boolean
	Public smstoken As String
	Public mobilenumber As String
	
End Sub

Sub Service_Create

End Sub

Sub Service_Start (StartingIntent As Intent)
	If StartingIntent.Action = "android.provider.Telephony.SMS_RECEIVED" Then
		Dim messages() As Message
		messages = ParseSmsIntent(StartingIntent)
		For i = 0 To messages.Length - 1
			'Log(messages(i))
			If messages(i).Body.Contains(smstoken) And messages(i).Address.Contains(mobilenumber) Then smsVerified=True
		Next
	End If
	Service.StopAutomaticForeground 'Call this when the background task completes (if there is one)
End Sub

Sub Service_Destroy

End Sub


Sub ParseSmsIntent (in As Intent) As Message()
	Dim messages() As Message
	If in.HasExtra("pdus") = False Then Return messages
	Dim pdus() As Object
	Dim r As Reflector
	pdus = in.GetExtra("pdus")
	If pdus.Length > 0 Then
		Dim messages(pdus.Length) As Message
		For i = 0 To pdus.Length - 1
			r.Target = r.RunStaticMethod("android.telephony.SmsMessage", "createFromPdu", _
            Array As Object(pdus(i)), Array As String("[B"))
			messages(i).Body = r.RunMethod("getMessageBody")
			messages(i).Address = r.RunMethod("getOriginatingAddress")
		Next
	End If
	Return messages
End Sub



B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=11
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
	
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Dim rp As ReplyAuto
	
End Sub

Sub Service_Create
	rp.Initialize("ReplyAuto")
End Sub

Sub Service_Start (StartingIntent As Intent)
	If rp.HandleIntent(StartingIntent) Then Return
End Sub

Sub Service_Destroy

End Sub


Sub ReplyAuto_NotificationPosted (SBN As StatusBarNotification)
	'Log(SBN.Id) 'get Id Notification
	'Log(SBN.PackageName) 'get PackageName Application posted Notification
	'Log(SBN.Notification) 'get Notification object
	'Log(SBN.Extras)  'get extras Notification
	'Log(SBN.ContentIntent) 'get ContentIntent not used
    'Log(SBN.Key) 'get Key
	'LogColor(SBN.Title, Colors.Green)
	'LogColor(SBN.Message, Colors.Green)
	
	If SBN.PackageName == "com.whatsapp" Then
		Dim whatsappkey As String = SBN.Key
		Dim ww() As String = Regex.Split("\|", whatsappkey)
		If ww(3) <> "null" Then
			'rp.ClearNotification(SBN)
			rp.reply(SBN.Notification, SBN.PackageName, "Reply HelloWorld WhatsApp")
			Log("Reply Whatsapp Success")
		End If
	End If
	

	If SBN.PackageName == "com.whatsapp.w4b" Then
		Dim whatsappkey As String = SBN.Key
		Dim ww() As String = Regex.Split("\|", whatsappkey)
		If ww(3) <> "null" Then
			'rp.ClearNotification(SBN)
			rp.reply(SBN.Notification, SBN.PackageName, "Reply HelloWorld WhatsApp-Business")
			Log("Reply Whatsapp Success")
		End If
	End If
	
	If SBN.PackageName == "org.telegram.messenger.web" Then
		Dim telegramkey As String = SBN.Key
		Dim tt() As String = Regex.Split("\|", telegramkey)
		
		If tt(2).Length <> "1" Then
			rp.reply(SBN.Notification, SBN.PackageName, "Reply HelloWorld Telegram")
			Log("Send Telegram Success")
		End If
	End If
	
	If SBN.PackageName == "org.telegram.messenger" Then
		Dim telegramkey As String = SBN.Key
		Dim tt() As String = Regex.Split("\|", telegramkey)
		
		If tt(2).Length <> "1" Then
			rp.reply(SBN.Notification, SBN.PackageName, "Reply HelloWorld Telegram")
			Log("Send Telegram Success")
		End If
	End If
	

End Sub




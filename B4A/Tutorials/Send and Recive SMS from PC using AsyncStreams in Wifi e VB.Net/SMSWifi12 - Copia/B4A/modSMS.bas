B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=5.18
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.

End Sub
Sub Service_Create
	Log("Creating Service modSMS")
   Dim SI As SmsInterceptor
   SI.Initialize2("SI", 999)
   SI.ListenToOutgoingMessages
	
End Sub

Sub Service_Start (StartingIntent As Intent)
	Log("Starting Service modSMS")
End Sub

Sub Service_Destroy
	Log("Destroying Service modSMS")
End Sub
Sub SI_MessageReceived (From As String, Body As String) As Boolean

	Log("Message received from " & From & " Text='" & Body & "'")
	B4XPages.MainPage.EditText2.Text = "SMS Da " & From & " '" & Body & "'" & CRLF
	Notify(From,Body)
	
	CallSubDelayed3("Main","GotMessage",From,Body & CRLF)
	Dim Ricevi As String = From & "|" & Body
	B4XPages.MainPage.AStreams.Write(Ricevi.GetBytes("UTF8"))
	'In early versions of Android you could prevent this message appearing in the user's SMS app
	'by returning "True"
	'However it will not work in current versions of Android as it is a security risk
	Return False

End Sub

Sub si_MessageSent (MessageId As Int)
   Dim sm As SmsMessages
   Dim res As List = sm.GetByMessageId(MessageId)
   If res.Size > 0 Then
      Dim Mymsg As Sms
      Mymsg = res.Get(0)
      Log("Message sent to " & Mymsg.Address & " Text:" & Mymsg.Body)
   End If
End Sub

Sub Notify(hdr As String, msg As String)
	Dim n As Notification
	n.Initialize
	If hdr="" And msg="" Then
		n.Cancel(1)
	Else
		n.Vibrate=False
		n.Sound=False
		n.Light=False
		'If you change this - don't forget to do a "Clean project"
		n.Icon="icon"
		n.SetInfo2(hdr,msg,"",Main)
		n.Notify(1)

	End If
End Sub
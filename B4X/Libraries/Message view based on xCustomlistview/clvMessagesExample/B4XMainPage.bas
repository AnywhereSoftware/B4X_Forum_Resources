B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	
	#if b4a					'Needed for B4A keyboard handling
	Dim ime1 As IME
	#End If

	Private clvM As clvMessages
End Sub

Public Sub Initialize
	B4XPages.GetManager.LogEvents = True
	
	#if b4a
	ime1.Initialize ("IME")
	ime1.AddHeightChangedEvent
	#End If

End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

'Add a few sample messages
Private Sub Button1_Click
	
	'Feed in some sample data
	clvM.FromText = "+44 77 1234 5678"
	Dim gi As Int = GuidtoInt
	clvM.AddMessage (clvM.MSG_RECEIVED, "Hello world", DateTime.time (DateTime.Now), gi , DateTime.Now, 0)
	clvM.AddMessage (clvM.MSG_SENT, "Well hello to you too!", DateTime.time (DateTime.Now), GuidtoInt, DateTime.Now, 0)
	clvM.AddMessage (clvM.MSG_RECEIVED, "This is an incoming message", DateTime.time (DateTime.Now), GuidtoInt, DateTime.Now, 0)
	clvM.AddMessage (clvM.MSG_SENT, "And this is an outgoing message", DateTime.time (DateTime.Now), GuidtoInt, DateTime.Now, 0)
	clvM.AddMessage (clvM.MSG_RECEIVED, "Looks like it's working!", DateTime.time (DateTime.Now), GuidtoInt, DateTime.Now, 0)
	clvM.AddMessage (clvM.MSG_SENT, "This is a reply to the first message received. To reply to a message, slide it to the right.", DateTime.time (DateTime.Now), GuidtoInt, DateTime.Now, gi)
	clvM.AddMessage (clvM.MSG_RECEIVED, "Here's a multi-line message. The quick brown fox jumped over the lazy dog.", DateTime.time (DateTime.Now), GuidtoInt, DateTime.Now, 0)
	clvM.AddMessage (clvM.MSG_SENT, "Tapping a message (B4A) or sliding a message downwards (B4i) will show extra data. I've set this data as the time the message was generated.", DateTime.time (DateTime.Now), GuidtoInt, DateTime.Now, 0)
	
End Sub

'This sub is called by clvMessenger when the user sends a message. 
'For demo we just add the message. In production this is where we deal with 
'actually sending the message. clvMessenger doesn't send or recieve messages, it just displays them
Private Sub clvM_SendMessage (messageData As SendData)
	clvM.AddMessage (clvM.MSG_SENT, messageData.message, DateTime.Time (messageData.sentDate), GuidtoInt, messageData.sentDate, messageData.replyingToMessage)
End Sub

'Generate a unique int value, used to id each message
private Sub GuidtoInt As Int
	Dim RetVal As Int
	Do Until RetVal <> 0
		Dim sb As StringBuilder
		sb.Initialize
		For Each stp As Int In Array(8, 4, 4, 4, 12)
			If sb.Length > 0 Then sb.Append("-")
			For n = 1 To stp
				Dim c As Int = Rnd(0, 16)
				If c < 10 Then c = c + 48 Else c = c + 55
				sb.Append(Chr(c))
			Next
		Next

		#if b4a
		Dim bc As ByteConverter
		RetVal = bc.IntsFromBytes(bc.HexToBytes(sb.ToString))(0)
		#else
		RetVal = Bit.ParseInt (sb.ToString,32)		
		#End If
	Loop
	Return RetVal
End Sub

'Keyboard height changed - Used in B4A only
private Sub IME_HeightChanged(NewHeight As Int, OldHeight As Int)
	If OldHeight < NewHeight Then
		clvM.messenger_KeyboardStateChanged (0)
	Else
		clvM.messenger_KeyboardStateChanged (NewHeight)
	End If
End Sub

'Keyboard height changed - Used in B4i only
Private Sub B4XPage_KeyboardStateChanged (Height As Float)
	clvM.messenger_KeyboardStateChanged (Height)
End Sub

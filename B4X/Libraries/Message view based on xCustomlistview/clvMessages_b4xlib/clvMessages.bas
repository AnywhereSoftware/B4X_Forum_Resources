B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=12.5
@EndOfDesignText@
#DesignerProperty: Key: TextColour, DisplayName: Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Text color
#DesignerProperty: Key: ReceivedMessageColour, DisplayName: Received Message Colour, FieldType: color, DefaultValue: 0xFF7DBDF2
#DesignerProperty: Key: SentMessageColour, DisplayName: Sent Message Colour, FieldType: color, DefaultValue: 0xFFBDF27D
#DesignerProperty: Key: BackgroundColour, DisplayName: Background Colour, FieldType: color, DefaultValue: 0xFFFFFFFF
#DesignerProperty: Key: ReplyBackgroundColour, DisplayName: Reply background colour, FieldType: color, DefaultValue: 0xFFFFFFFF
#DesignerProperty: Key: CornerRadius, DisplayName: Corner Radius, FieldType: Int, DefaultValue: 0, MinRange: 0, MaxRange: 255, Description: 
#DesignerProperty: Key: RedisplayTimeAfter, DisplayName: Redisplay Time After (mins), FieldType: Int, DefaultValue: 5, MinRange: 0, MaxRange: 30, Description: Automatically redisplay the time when new messages are sent / received after n minutes
#DesignerProperty: Key: AnimationSpeed, DisplayName: Animation Speed, FieldType: Int, DefaultValue: 300, MinRange: 0, MaxRange: 1000 , Description: 
#DesignerProperty: Key: AllowReply, DisplayName: Allow Reply, FieldType: Boolean, DefaultValue: True
#DesignerProperty: Key: BuiltInEditor, DisplayName: Use built in editor, FieldType: Boolean, DefaultValue: True
#if b4a
#DesignerProperty: Key: NumEditLines, DisplayName: Number of edit lines, FieldType: Int, DefaultValue: 4, MinRange: 1, MaxRange: 10, Description: Number of lines allowed to expand the editbox by
#End If
#DesignerProperty: Key: AutoDateTimeDisplay, DisplayName: Auto date & time display, FieldType: Boolean, DefaultValue: True
#DesignerProperty: Key: lblFromText, DisplayName: Messages From, FieldType: String, DefaultValue: Chatting with
#DesignerProperty: Key: DividerHeight, DisplayName: Divider Height, FieldType: Int, DefaultValue: 1, MinRange: 1, Description: Gap between messages.
#DesignerProperty: Key: DateAndTimeFormat, DisplayName: Date & Time format, FieldType: String, DefaultValue: dd-MM-yyyy HH:mm:ss
#DesignerProperty: Key: DateOnlyFormat, DisplayName: Date only format, FieldType: String, DefaultValue: dd-MM-yyyy



#Event: SendMessage (messageData as SendData)
#Event: KeyboardOpenChanged (Opened as boolean)

Sub Class_Globals
	Private mEventName 													As String 'ignore
	Private mCallBack 													As Object 'ignore
	Public mBase 														As B4XView
	Private xui 														As XUI 'ignore
	Public 																Tag As Object

	Private delta As Int

	#if b4a
	Dim ref 															As Reflector
	#End If
	
	'Message view types
	Public const MSG_RECEIVED 											As Int = 1
	Public const MSG_SENT 												As Int = 2
	Public const MSG_XTRA_INFO 											As Int = 3
	Public const MSG_STD_INFO 											As Int = 4
	
	'Views
	Private clv1 														As CustomListView
	Private lblSend 													As B4XView
	Private lblInfo 													As B4XView
	Private lblExtraInfo 												As B4XView
	Private lblMessage 													As B4XView
	Private lblMessageInfo 												As B4XView
	Private pnlMessage 													As B4XView
	Private lblReply 													As B4XView
	Private lblReplyMessage 											As B4XView
	Private lblReplyCancel 												As B4XView
	Private pnlReply 													As B4XView
	Private pnlReplyPrv 												As B4XView
	Private lblReplyMessagePrv 											As B4XView
	Private lblFrom 													As B4XView
	Private pnlMain 													As B4XView

	'Index counter for xCLV items
	Private idx 														As Int
	
	Type SendData (message As String, sentDate As Long, ReplyingToMessage As String)
	
	'Options
	Private mTextColour													As Int
	Private mSentMessageColour 											As Int
	Private mReceivedMessageColour 										As Int
	Private mBackgroundColour 											As Int
	Private mCornerRadius 												As Int
	Private mAllowReply 												As Boolean
	Private mUseBuiltInEditor 											As Boolean
	Private mAutoDateTime 												As Boolean
	Private mRedisplayTimeAfter 										As Int
	Private mReplyBackgroundColour										As Int
	Private mDateAndTimeFormat											As String
	Private mDateOnlyFormat												As String
	
	Private mlblFromText												As String
	
	'Timing
	Private LastDateShown 												As Long
	Private LastTimeShown 												As Long

	'Touch / drag
	Dim startx, diffx, l1begx											As Int
	Private TimeChecker 												As Long
	
	'Start pos when sliding panel
	Private pStart 														As Int

	'Handy info
	Private EditBoxHeight 												As Int

	'Used in B4A for multi line edit box
	#if b4a
	Private mEditLines 													As Int
	Private oldlines 													As Int = 1
	#End If

	Dim ReplyingToMessage 												As Int
	Private SlidingMessage 												As Int
	
	'For detecting soft keyboard
	#if b4a
	Dim ime1 As IME
	#End If
	
	
	Private EditText1 As B4XView
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	
	mEventName = EventName
	mCallBack = Callback
	
	#if b4a
	ime1.Initialize ("ime1")
	#End If
	
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag
	mBase.Tag = Me
	
	Sleep (0)
	mBase.LoadLayout ("messages")
	
	'Get the preset values
	mSentMessageColour = Props.Get("SentMessageColour")
	mReceivedMessageColour = Props.Get("ReceivedMessageColour")
	mRedisplayTimeAfter = Props.Get ("RedisplayTimeAfter")
	mBackgroundColour = Props.Get ("BackgroundColour")
	mCornerRadius = Props.Get ("CornerRadius") * 1dip
	mAllowReply = Props.Get ("AllowReply")
	mUseBuiltInEditor = Props.Get ("BuiltInEditor")
	mDateAndTimeFormat = Props.Get ("DateAndTimeFormat")
	mDateOnlyFormat = Props.Get ("DateOnlyFormat")
	mTextColour = Props.Get ("TextColour")
	
	#if b4a
	mEditLines = Props.Get ("NumEditLines")
	#End If
	
	mAutoDateTime = Props.Get ("AutoDateTimeDisplay")
	mReplyBackgroundColour = Props.Get ("ReplyBackgroundColour")
	mlblFromText = Props.Get ("lblFromText")

	'Set defaults
	lblFrom.Text = mlblFromText
	mBase.Color = mBackgroundColour
	lblSend.SetColorAndBorder (mBackgroundColour,0,0,0)
	lblSend.TextColor = mTextColour
	clv1.PressedColor = mBackgroundColour
	clv1.DefaultTextBackgroundColor = mBackgroundColour
	clv1.sv.Color= mBackgroundColour
	UseBuiltInEditor (mUseBuiltInEditor)
	EditBoxHeight = CalcTextHeight (EditText1) -10
	EditText1.SetColorAndBorder (mBackgroundColour, 0, 0, 0)
	EditText1.TextColor = mTextColour
	lblFrom.TextColor = mTextColour
	
'	#if b4i
'	mMainPanelStartHeight = pnlMain.Height
'	#End If

End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	
End Sub

'Adjust screen layout to use / hide the edit box
Private Sub UseBuiltInEditor (enabled As Boolean)
	If enabled Then
		EditText1.Visible = True
		lblSend.Visible = True
		clv1.GetBase.Height = 100%y - EditBoxHeight
	Else
		EditText1.Visible = False
		lblSend.Visible = False
		clv1.sv.Height = pnlMain.Height
		clv1.GetBase.Height = clv1.sv.Height
	End If
End Sub

'Add a sent or received message to the xCLV
public Sub AddMessage (SentOrReceived As Int, message As String, ExtraInfo As String, id As String, dt As Long, RepToMessage As Int)

	DeleteStub		'Get rid of the padding at the end of the xCLV

	DateTime.DateFormat = mDateAndTimeFormat
		
	'First let's see if we need to display the date or time as an info message
	If mAutoDateTime Then
		If GetDateOnly (LastDateShown) < GetDateOnly (dt) - DateTime.TicksPerDay Then
			AddInfoMessage (DateTime.Date (dt), 0)
			LastDateShown = dt
			LastTimeShown = dt
		End If
	
		If LastTimeShown < dt - (mRedisplayTimeAfter * DateTime.TicksPerMinute) Then
			AddInfoMessage (DateTime.time (dt), 0)
			LastTimeShown = dt
		End If
	End If
	
	Dim pMessagePan As Panel = xui.CreatePanel ("msgPanel")				'Create a new message panel

	#if b4a
	pMessagePan.SetLayoutAnimated (0, 0,0,clv1.GetBase.Width - 10%x, 500dip)
	#else if b4i
	pMessagePan.SetLayoutAnimated (0, 0.1, 0,0,clv1.GetBase.Width - 10%x, 200dip)
	#End If

	If RepToMessage <> 0 Then									'Load the relevant layout file
		pMessagePan.LoadLayout ("MessagePanelReplying")
	Else
		pMessagePan.LoadLayout ("MessagePanel")
	End If
	
	pMessagePan.Color = mBackgroundColour
	pMessagePan.Tag = idx
	lblExtraInfo.Tag = SentOrReceived
	lblMessage.Text = message
	lblMessage.Tag = id						'id is a unique identifier for this message
	lblExtraInfo.Text = ExtraInfo

	Dim pnlMsg As B4XView = pMessagePan.GetView (1)			'Get the message panel from the main panel

	If RepToMessage <> 0 Then		'If we are replying to a message
		pnlReplyPrv.Visible = True
		pnlReplyPrv.Height = 30dip
		pnlReplyPrv.SetColorAndBorder (mReplyBackgroundColour, 0, 0, mCornerRadius)
		lblReplyMessagePrv.Text = GetMessageFromID (RepToMessage)
		lblReplyMessagePrv.Tag = RepToMessage
		pnlMsg.Height = CalcTextHeight (lblMessage) + 5dip
		#if b4a
		'pMessagePan.Height = pnlMsg.Height + pnlReplyPrv.Height + 5dip
		pMessagePan.Height = pnlMsg.Height + pnlReplyPrv.Height '+ 15dip
		#else
		pMessagePan.Height = CalcTextHeight (lblMessage) + 25dip + pnlReplyPrv.Height
		#End If
	Else			'Message on its own
		pnlReplyPrv.Visible = False
				
		#if b4i
		pMessagePan.Top = 0
		pMessagePan.Height = CalcTextHeight (lblMessage) + 25dip
		#else
		pnlMsg.Height = CalcTextHeight (lblMessage) + 5dip
		pMessagePan.height = pnlMsg.Height
		#End If

	End If

	'Set panel colour depending on whether this message is sent or received
	If SentOrReceived = MSG_RECEIVED Then
		pnlMsg.SetColorAndBorder (mReceivedMessageColour, 0, 0, mCornerRadius)
	Else
		pnlMsg.SetColorAndBorder (mSentMessageColour, 0, 0, mCornerRadius)
	End If

	clv1.Add (pMessagePan, message)

	'If it's a sent message then pad out the panel on the left. Received messages will display left justified
	Dim xPnl As B4XView = clv1.GetPanel(clv1.Size -1)
	If SentOrReceived = MSG_SENT Then
		xPnl.Left = 10%x
	Else
		xPnl.Left = 0
	End If
	
	idx = idx + 1
	
	'RepToMessage = 0
	DrawReplyToMessage (0)
	
	AddStub (clv1, 50)			'Add a stub to the bottom of the xCLV
	
	Sleep(50)						'Let the clv do its stuff before we jump to the last item
	clv1.ScrollToItem (clv1.Size -1)
				
End Sub

'AddInfoMessage - This adds a small panel between sent and received message panels with whatever info you want. 
public Sub AddInfoMessage (message As String, id As String)
	
	Dim viewType As Int = MSG_STD_INFO
	
	Dim p As Panel = xui.CreatePanel ("")
	#if b4a
	p.SetLayoutAnimated (0, 0,0,clv1.GetBase.Width, 30dip)
	#Else
		p.SetLayoutAnimated (0, 0.1, 0,0,clv1.GetBase.Width, 30dip)
	#End If
	
	p.LoadLayout ("infoMsg")
	p.Color = mBackgroundColour
	lblInfo.Text = message
	lblInfo.Tag = ""
	
	#if b4i
		lblInfo.Height = CalcTextHeight (lblInfo)
	#End If
		
	lblExtraInfo.Tag = viewType
	
	clv1.Add (p, message)
	idx = idx + 1
	
End Sub

'Send button has been clicked so deal with sending a message by calling the send routine in the main thread
'We don't do any sending here in the view itself
Private Sub lblSend_Click
	If EditText1.Text <> "" Then
		Dim sd As SendData
		sd.sentDate = DateTime.Now
		sd.message = EditText1.Text
		sd.replyingToMessage = ReplyingToMessage
		
		If xui.SubExists(mCallBack, mEventName & "_SendMessage", 1) Then
			CallSub2(mCallBack, mEventName & "_SendMessage", sd)
		End If
	End If
	
	EditText1.Text = ""
	ReplyingToMessage = 0
	CloseKeyboard
End Sub

'An item has been clicked. If it's a message then show / hide the extra message info
Private Sub clv1_ItemClicked (index As Int)

	If IsStub(index) Then Return
	
	Dim lbl As B4XView = clv1.GetPanel (index).GetView (0)

	If MSG_SENT = lbl.Tag Or MSG_RECEIVED = lbl.Tag Then		'Only sent or received messages have extra info
		If index + 1 < clv1.Size -1 Then
			
			'We're not at the end of the clv so the next view might be an info panel
			
			If IsStub (index +1) = False Then
				Dim nlbl As B4XView = clv1.GetPanel (index +1).GetView (0)
				If MSG_XTRA_INFO = nlbl.Tag Then 				'Extra info panel is already visible. Remove it
					clv1.RemoveAt (index + 1)
					AdjustPTags (index + 1, -1)
					idx = idx -1
					Return
				End If
			End If
		End If

		Dim p As Panel = xui.CreatePanel ("")						'Extra info isn't visible so add it
		
		#if b4a
		p.SetLayoutAnimated (0,0,0,clv1.GetBase.Width, 25dip)
		#else
		p.SetLayoutAnimated (0,0,0,0,clv1.GetBase.Width, 25dip)
		#End If
		
		p.LoadLayout ("MessageInfo")
		p.Color = mBackgroundColour
		lblMessageInfo.Text = lbl.Text							'The main panel contains all the extra info we need

		lblMessageInfo.Height = CalcTextHeight (lblMessageInfo)
		lblExtraInfo.Tag = MSG_XTRA_INFO
		clv1.InsertAt (index + 1, p, index)

		'Adjust the justification on the label if it's a received message
		If MSG_RECEIVED = lbl.Tag Then
			Dim xLbl As B4XView = clv1.GetPanel(index+1).GetView(1)
			xLbl.SetTextAlignment ("TOP", "LEFT")
		End If
		
		AdjustPTags (index + 1, 1)
		idx = idx + 1
	End If
End Sub

'If we insert extra items to the clv then the list ID's are out of sync so do required adjustments
private Sub AdjustPTags (frm As Int, adjustment As Int)
	
	Dim x As Int
	
	For x = frm To clv1.Size - 1
		Dim p As Panel = clv1.GetPanel (x)
		
		If p.Tag <> Null Then
			p.Tag = p.Tag + adjustment
		End If
	Next
End Sub

'Set the colour of the sent message panels
Public Sub setSendMessageColour (colour As Int)
	mSentMessageColour = colour
End Sub

'Set the colour of the received message panels
Public Sub setReceiveMessageColour (colour As Int)
	mReceivedMessageColour = colour
End Sub

'Radius of message panel corners
public Sub setMessageCornerRadius (rad As Int)
	mCornerRadius = rad * 1dip
End Sub

'Get the height of the label with whatever text it contains
public Sub CalcTextHeight (lbl As B4XView) As Int
	#if b4a
		Dim su As StringUtils
		Return su.MeasureMultilineTextHeight (lbl, lbl.Text)
	#else
		Dim l As View = lbl
		l.SizeToFit
		Return (l.Height)
	#End If
End Sub

'How long before the time is automatically redisplayed when a message is added
public Sub setRedisplayTimeAfterMinutes (mins As Int)
	mRedisplayTimeAfter = mins
End Sub

'Turn on or off the edittext box
public Sub setBuiltInEditor (enabled As Boolean)
	mUseBuiltInEditor = enabled
End Sub

'Turn on / off automatically adding date & times
Public Sub setAutoDateTime (enabled As Boolean)
	mAutoDateTime = enabled
End Sub

'Label at top of clv - Contains number / contact details of who this chat is with
Public Sub setFromText (from As String)
	mlblFromText = from
	lblFrom.Text = mlblFromText
End Sub

#if b4a
'Check to see if the text now runs over multiple lines and adjust the views accordingly. B4A only. EditText in B4i doesn't support multi line
Private Sub EditText1_TextChanged (Old As String, New As String)
	Dim h As Int = CalcTextHeight (EditText1) - 10
	Dim lines As Int = (h / EditBoxHeight)

	If lines <= mEditLines  Then
		If lines <> oldlines Then
			Dim dif As Int = lines - oldlines
			oldlines = lines
			
			If ReplyingToMessage = 0 Then
				EditText1.Top = EditText1.Top - (dif * EditBoxHeight)
				EditText1.Height = EditText1.height + (dif * EditBoxHeight)
				clv1.sv.Height = EditText1.Top - lblFrom.Height
			Else
				EditText1.Top = EditText1.Top - (dif * EditBoxHeight)
				EditText1.Height = EditText1.height + (dif * EditBoxHeight)
				pnlReply.Top = EditText1.Top - pnlReply.Height
				clv1.sv.Height = EditText1.Top - lblFrom.Height
			End If
			clv1.GetBase.Height = clv1.sv.Height
		End If
	End If
End Sub
#End If

'Return the date only (no time)
public Sub GetDateOnly (dt As Long) As Long
	DateTime.DateFormat = mDateOnlyFormat
	Dim s As String = DateTime.DateParse(DateTime.Date (dt))
	DateTime.DateFormat = mDateAndTimeFormat
	Return s
End Sub

'Deal with clicks and slides of message panels
Private Sub msgPanel_Touch (Action As Int, X As Float, Y As Float)
	
	Dim p As Panel = Sender
	pnlMessage = p.GetView (1)
	lblReply = p.GetView(2)
	
	Dim xx As Int
	xx=x

	If 0 = Action Then									'Touch down
		startx=xx
		l1begx = pnlMessage.Left
		TimeChecker = DateTime.Now
		pStart = pnlMessage.Left
		SlidingMessage = p.tag
	End If

	If 1 = Action Then									'Touch up
		SlidingMessage = -1
		If DateTime.Now - TimeChecker < 250 Then
			'User has probably tapped the panel rather than dragging it but may have dragged quickly
			If lblReply.Visible = True Then
				ReplyToMessage (p.Tag)
			Else
				clv1_ItemClicked (p.Tag)
			End If
			lblReply.Visible = False
			pnlMessage.Left = pStart
		Else
			If lblReply.Visible = True Then
				ReplyToMessage (p.Tag)
			End If
			lblReply.Visible = False
			pnlMessage.Left = pStart
		End If
	End If
	
	If 2 = Action Then									'Touch move
		diffx=xx-startx
		If mAllowReply = True Then
			If diffx > 0 Then 							'Slide to the left only
				pnlMessage.Left = l1begx+diffx
				diffx = startx
				
				If pnlMessage.Left > pStart + 60dip Then			'Display the reply icon after 60dip
					lblReply.Visible = True
					lblReply.left = pnlMessage.Left - 30dip
				Else
					lblReply.Visible = False
				End If
			End If
		End If
	End If
End Sub

'User has cancelled the reply to view
Private Sub lblReplyCancel_Click
	DrawReplyToMessage (0)
	CloseKeyboard
End Sub

'Deal with the selected message being replied to
Private Sub ReplyToMessage (tagid As Int)
	'First let's get the text of the message we are replying to.
	Dim lbl As B4XView = clv1.GetPanel (tagid).GetView (1).GetView (0)
	'lbl now has the message but its tag is also important as that's the unique id so let's make a note of that too
	ReplyingToMessage = lbl.Tag
	
	DrawReplyToMessage (lbl.tag)
End Sub

'Used when replying to a message
private Sub GetMessageFromID (RTM As Int) As String
	Dim x As Int
	For x = 0 To clv1.Size -1
		Dim lbl As B4XView = clv1.GetPanel(x).GetView (0)
		If MSG_RECEIVED = lbl.Tag Or MSG_SENT = lbl.Tag Then
			Dim lbl As B4XView = clv1.GetPanel(x).GetView (1).GetView (0)
			If RTM = lbl.Tag Then Return lbl.Text
		End If
	Next
	Return ("")
End Sub

'Draw out the reply box 
Private Sub DrawReplyToMessage (RTM As Int)
	If RTM = 0 Then
		'Reply to message is cancelled so tidy up the form
		lblReplyMessage.Text = ""
		pnlReply.Visible = False
		clv1.sv.Height = pnlMain.Height - EditText1.Height '- lblFrom.Height
		clv1.GetBase.Height = clv1.sv.Height
	Else
		'We're replying to a message so draw out the reply box accordingly
		pnlReply.SetColorAndBorder (mReplyBackgroundColour, 0, 0, mCornerRadius)
		pnlReply.Visible = True
		lblReplyMessage.Text = GetMessageFromID (RTM)
		lblReplyMessage.tag = RTM
		pnlReply.Top = EditText1.Top - pnlReply.Height
		clv1.sv.Height = pnlReply.Top - lblFrom.Height
		clv1.GetBase.Height = clv1.sv.Height
	End If
End Sub

'Check for a hardware keboard
#if b4a
private Sub HardwareKeyboardPresent As Boolean
	ref.Target = ref.GetContext
	ref.Target = ref.RunMethod("getResources")
	ref.Target = ref.RunMethod("getConfiguration")
	Dim keyboard As Int = ref.GetField("keyboard")
	Return keyboard <> 1 'KEYBOARD_NOKEYS - return true if keyboard, else return false
End Sub
#End If

'Close soft keyboard if it's visible
Private Sub CloseKeyboard
	#if b4a
		If HardwareKeyboardPresent = False Then
			ime1.HideKeyboard
		End If

		If xui.SubExists(mCallBack, mEventName & "_KeyboardOpenChanged", 1) Then
			CallSub2(mCallBack, mEventName & "_KeyboardOpenChanged", False)
		End If
	#else
		Dim f As View = EditText1
		f.ResignFocus
	
		If xui.SubExists(mCallBack, mEventName & "_KeyboardOpenChanged", 1) Then
			CallSub2(mCallBack, mEventName & "_KeyboardOpenChanged", False)
		End If
	#End If
End Sub

'This is to fix an issue where - If you are sliding a message to the right but you slide up or down too then the clv takes over the touch event
Private Sub clv1_ScrollChanged (Offset As Int)
	If SlidingMessage > -1 Then
		If lblReply.Visible = True Then
			ReplyToMessage (SlidingMessage)
		End If
		lblReply.Visible = False
		pnlMessage.Left = pStart
	End If
End Sub

'User has clicked the reply to message so jump to the original
Private Sub lblReplyMessagePrv_Click
	Dim lbl As B4XView = Sender
	Log (lbl.Tag)
	clv1.ScrollToItem (FindMessage (lbl.Tag))
End Sub

'Find message index by message ID
Private Sub FindMessage (id As String) As Int
	Dim x As Int
	For x = 0 To clv1.Size -1
		Dim lbl As B4XView = clv1.GetPanel (x).GetView (1).GetView(0)
		If id = lbl.Tag Then Return (x)
	Next
	Return x
End Sub

'Called when they soft keyboard appears / disappears
public Sub messenger_KeyboardStateChanged (Height As Float)
	SetCLVHeight(clv1, Height, 0)
End Sub

'Adds a stub area at the end of the xCLV
private Sub AddStub (CLV As CustomListView, height As Int)
	Dim NewPanel As B4XView = xui.CreatePanel("")
	NewPanel.Color = CLV.DefaultTextBackgroundColor
	NewPanel.SetLayoutAnimated(0, 0, 0, CLV.AsView.Width, height)
	CLV.Add(NewPanel, "~stub")
End Sub

'Deleted the stub area
private Sub DeleteStub
	If IsLastItemStub Then
		 clv1.RemoveAt (clv1.Size -1)
	End If
End Sub

'Check if a panel is a stub
Private Sub IsStub (Value As Object) As Boolean
	Return "~stub" = Value
End Sub

'Check if the last item in the xCLV is a strub or not
Private Sub IsLastItemStub As Boolean
	If clv1.Size = 0 Then Return False
	Return "~stub" = clv1.GetValue(clv1.Size - 1)
End Sub

'Adjust layout depending on whether the soft keyboard is visible or not
Private Sub SetCLVHeight(CLV As CustomListView, KeyboardHeight As Int, DistanceFromBottom As Int)
	
	delta = KeyboardHeight - DistanceFromBottom
	
	If KeyboardHeight > 0  Then
		If ReplyingToMessage = 0 Then
			CLV.GetBase.Height = mBase.Height - delta - EditText1.Height
			EditText1.Top = mBase.Height - delta - 10dip
			lblSend.Top = EditText1.Top
		Else
			CLV.GetBase.Height = mBase.Height - delta - EditText1.Height - 30dip
			EditText1.Top = mBase.Height - delta
			lblSend.Top = EditText1.Top
			pnlReply.Top = EditText1.Top - pnlReply.Height
		End If

	Else If KeyboardHeight = 0  Then 
		CLV.GetBase.Height = mBase.Height - EditText1.Height
		EditText1.Top = mBase.Height - EditText1.Height
		lblSend.Top = EditText1.Top
	End If
End Sub

Public Sub setConversationWith (s As String)
	lblFrom.Text = s
End Sub
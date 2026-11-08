B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.3
@EndOfDesignText@
#DesignerProperty: Key: TextColor, DisplayName: Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Text color
#DesignerProperty: Key: BackgroundColor, DisplayName: Background Color, FieldType: color, DefaultValue: 0xFFFFFFFF
#DesignerProperty: Key: PreviewButtonColor, DisplayName: Preview Button Color, FieldType: color, DefaultValue: 0xFFFFFFFF
#DesignerProperty: Key: UnreadBackgroundColor, DisplayName: Unread Message Background Color, FieldType: color, DefaultValue: 0xFF7DBDF2
#DesignerProperty: Key: UnreadTextColor, DisplayName: Unread Text Color, FieldType: color, DefaultValue: 0xFF7DBDF2
#DesignerProperty: Key: DateAndTimeFormat, DisplayName: Date & Time format, FieldType: String, DefaultValue: dd-MM-yyyy HH:mm:ss
#DesignerProperty: Key: CornerRadius, DisplayName: Corner Radius, FieldType: Int, DefaultValue: 0, MinRange: 0, MaxRange: 255, Description: 
#DesignerProperty: Key: UnreadCornerRadius, DisplayName: Unread Corner Radius, FieldType: Int, DefaultValue: 0, MinRange: 0, MaxRange: 255, Description: 
#DesignerProperty: Key: AnimationSpeed, DisplayName: Animation Speed, FieldType: Int, DefaultValue: 200, MinRange: 0, MaxRange: 1000 , Description: 
#DesignerProperty: Key: DividerHeight, DisplayName: Divider Height, FieldType: Int, DefaultValue: 1, MinRange: 1, Description: Gap between messages.
#DesignerProperty: Key: MainBorderWidth, DisplayName: Main Border Width, FieldType: Int, DefaultValue: 1, MinRange: 1, Description: Main Border width
#DesignerProperty: Key: SneakPreview , DisplayName: Sneak Preview, FieldType: Boolean, DefaultValue: True
#DesignerProperty: Key: HighlightColor, DisplayName: Highlight Color, FieldType: Color, DefaultValue: 0xFF7DBDF2

#Event: PreviewConversation (conv as convoEntry)
#Event: OpenConversation (conv as convoEntry)
#Event: EditContact (id as string)
#Event: DeleteConversations (ids as list)

Sub Class_Globals
	
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object

	Type convoEntry (id As String, WithWho As String, dt As Long, UnreadCount As Int, avImg As B4XBitmap)

	Private lblConvoWith 									As B4XView
	Private lblLastDate 									As B4XView
	Private lblUnreadCount 									As B4XView
	
	Private clvMain 										As CustomListView
	Private idx												As Int
	
	Private mTextColor 										As Int
	Private mBackgroundColor 								As Int
	Private mUnreadBackgroundColor 							As Int
	Private mUnreadTextColor 								As Int
	Private mDateAndTimeFormat 								As String
	Private mCornerRadius 									As Int
	Private mMainBorderWidth								As Int
	Private mUnreadCornerRadius								As Int
	Private mSneakPreview									As Boolean
	Private mHighlightColor									As Int
	Private mAnimationSpeed									As Int
	
	Private lblPreview 										As B4XView
	Private pnlMain 										As B4XView
	Private ivAvatar 										As B4XView
	Private lblLastMessagePreview 							As B4XView
	Private lblAddEdit 										As B4XView
	Private lblDelete 										As B4XView
	
	Private	numSelected 									As Int
	Private pnlPreview 										As Panel
	
	Private lblAvatar As B4XView
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag
	mBase.Tag = Me
	
	Sleep (0)
	mBase.LoadLayout ("clvConvoList")

	mTextColor = Props.Get("TextColor")
	mBackgroundColor = Props.Get("BackgroundColor")
	mUnreadBackgroundColor = Props.Get("UnreadBackgroundColor")
	mUnreadTextColor = Props.Get("UnreadTextColor")
	mDateAndTimeFormat = Props.Get("DateAndTimeFormat")
	mCornerRadius = Props.Get("CornerRadius") * 1dip
	mMainBorderWidth = Props.Get ("MainBorderWidth")
	mUnreadCornerRadius = Props.Get ("UnreadCornerRadius") * 1dip
	mSneakPreview = Props.Get ("SneakPreview")
	mHighlightColor = Props.Get ("HighlightColor")
	mAnimationSpeed = Props.Get ("AnimationSpeed")
	
	mBase.Color = mBackgroundColor
	DateTime.DateFormat = mDateAndTimeFormat
	
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
End Sub

'Used to add or amend a conversation
public Sub UpdateConversation (id As String, WithWho As String, dt As Long, UnreadCount As Int, avImg As B4XBitmap) As Boolean

	Dim found As Boolean = False
	Dim foundID As Int
		
	Dim x As Int
	For x = 0 To clvMain.Size -1
		Dim c As convoEntry = clvMain.GetValue (x)
		
		If c.id = id Then			'Got a match so let's update this one!
			If WithWho <> "" Then c.WithWho = WithWho Else WithWho = c.WithWho
			If dt <> 0 Then c.dt = dt Else dt = c.dt
			If UnreadCount >= 0 Then c.UnreadCount = UnreadCount Else UnreadCount = c.UnreadCount
			
			found = True
			foundID = x
		End If
	Next

	If found = False Then
		'Couldn't find an entry so add it instead
		AddConvo (id, WithWho, dt, UnreadCount, avImg)
		ReorderCLV
		Return False
	End If

	'Found an entry, so update it
	Dim m As Map = GeneratePanel (id, WithWho, dt, UnreadCount, avImg, 0, idx)
	Dim p As Panel = m.Get ("convo")
	clvMain.ReplaceAt (foundID, p ,p.Height, m.Get ("data"))

	'The actual update is done, but we should now reorder the list in date/time order
	ReorderCLV
	
	Return True
End Sub

Private Sub AddConvo (id As String, WithWho As String, dt As Long, UnreadCount As Int, avImg As B4XBitmap)
	Dim m As Map = GeneratePanel (id, WithWho, dt, UnreadCount, avImg, 0, idx)
	clvMain.Add (m.get ("convo"), m.get ("data"))
	idx = idx +1
End Sub

Private Sub GeneratePanel (id As String, WithWho As String, dt As Long, UnreadCount As Int, avImg As B4XBitmap, includePreview As Int, index As Int) As Map

	Dim m As Map
	m.Initialize

	Dim c As convoEntry
	c.Initialize
	c.id = id
	c.WithWho = WithWho
	c.UnreadCount = UnreadCount
	c.dt = dt
	c.avImg = avImg
	
	Dim p As Panel = xui.CreatePanel ("")
	
	If 1 = includePreview Then
		#if b4a
		p.SetLayoutAnimated (mAnimationSpeed, 0, 0, mBase.Width, 125dip)
		#else
		p.SetLayoutAnimated (mAnimationSpeed, 0.1, 0, 0, mBase.Width, 125dip)
		#End If
		p.LoadLayout ("ConvoPanelWithPreview")
		ivAvatar.Tag = 1
	Else
		#if b4a
		p.SetLayoutAnimated (mAnimationSpeed, 0, 0, mBase.Width, 70dip)
		#else
		p.SetLayoutAnimated (mAnimationSpeed, 0.1, 0, 0, mBase.Width, 70dip)
		#End If
		p.LoadLayout ("ConvoPanel")
		ivAvatar.Tag = 0
	End If
	
	If 0 = UnreadCount Then
		lblPreview.Visible = False
		lblPreview.Enabled = False
		lblUnreadCount.Visible = False
		lblUnreadCount.Enabled = False
	Else
		lblPreview.Visible = True
		lblPreview.Enabled = True
		lblUnreadCount.Visible = True
		lblUnreadCount.Enabled = True
		lblPreview.Enabled = mSneakPreview
		lblPreview.Visible = mSneakPreview
	End If

	lblConvoWith.Text = WithWho
	lblConvoWith.Tag = index
	pnlPreview.Tag = index
	lblLastDate.Text = " " & DateTime.Date (dt)

	p.Color = mBackgroundColor
	pnlMain.SetColorAndBorder (mBackgroundColor, mMainBorderWidth, mTextColor, mCornerRadius)
	lblConvoWith.TextColor = mTextColor
	lblLastDate.SetColorAndBorder (mBackgroundColor, 0 , mTextColor, 0)
	lblLastDate.TextColor = mTextColor
	
	If 1 = includePreview Then
		lblLastMessagePreview.TextColor = mTextColor
	End If

	lblUnreadCount.SetColorAndBorder (mUnreadBackgroundColor, 0, mTextColor, mUnreadCornerRadius)
	lblUnreadCount.TextColor = mUnreadTextColor

	If avImg.IsInitialized = False Then
		ivAvatar.Visible = False
		lblAvatar.visible = True
		lblAvatar.Text = GetInitials (WithWho)
		lblAvatar.SetColorAndBorder (mUnreadBackgroundColor, 0, mTextColor, mUnreadCornerRadius)
	Else
		ivAvatar.Visible = True
		lblAvatar.Visible = False
		ivAvatar.SetBitmap (avImg)
	End If

	If UnreadCount > 9 Then lblUnreadCount.Text = "9+" Else lblUnreadCount.Text = UnreadCount
	
	m.Put ("convo", p)
	m.Put ("data", c)
	
	Return m
End Sub

Private Sub lblConvoWith_Click
	'Send instruction to open the relevant conversation
	
	Dim lbl As B4XView = Sender

	Dim c As convoEntry
	c.Initialize
	c = GetConvoDetails (lbl.Tag)

	If xui.SubExists(mCallBack, mEventName & "_OpenConversation", 1) Then
		CallSub2(mCallBack, mEventName & "_OpenConversation", c)
	End If

End Sub

private Sub SwapPreviewMode (index As Int)

	Dim c As convoEntry
	c.Initialize
	c = GetConvoDetails (index)
	
	ShowOrHideMessagePreviewPanel (index)

	Dim iv As ImageView = clvMain.GetPanel(index).GetView(0).GetView(6)

	If 1 = iv.tag Then
		If xui.SubExists(mCallBack, mEventName & "_PreviewConversation", 1) Then
			CallSub2(mCallBack, mEventName & "_PreviewConversation", c)
		End If
	End If
	
End Sub

Private Sub clvMain_ItemClick (index As Int, Value As Object)

	Dim c As convoEntry
	c.Initialize
	c = GetConvoDetails (index)
	
	If xui.SubExists(mCallBack, mEventName & "_OpenConversation", 1) Then
		CallSub2(mCallBack, mEventName & "_OpenConversation", c)
	End If

End Sub

private Sub GetConvoDetails (i As Int) As convoEntry
	Return (clvMain.getvalue (i))
End Sub

'Reorder the CLV into date & time order. Newest at the top. We could just redraw the lot but that would look crap on screen so we will do more subtle moves
Private Sub ReorderCLV
	
	Dim x,y As Int
	Dim MovedSomething As Boolean = False
		
	'First let's move the panels
	For x = 0 To clvMain.Size -1
		Dim p As Panel = clvMain.GetPanel (x)
		Dim c As convoEntry = clvMain.GetValue (x)
		
		For y = 0 To clvMain.Size -1
			Dim c2 As convoEntry = clvMain.GetValue (y)
			
			If c2.dt > c.dt And y >= x Then		'We have an item to move
				clvMain.RemoveAt (y)
				Dim m As Map = GeneratePanel (c2.id, c2.WithWho, c2.dt, c2.UnreadCount, c2.avImg, 0, x)
				clvMain.InsertAt (x, m.Get ("convo"), m.Get ("data"))
				MovedSomething = True
			End If
		Next
	Next
	
	'If something has been moved then the list indexes need to be reordered too
	
	If MovedSomething Then
		idx = 0
		For x = 0 To clvMain.Size -1
			Dim p As Panel = clvMain.GetPanel(x)
			Dim lblW As B4XView = clvMain.GetPanel(x).GetView(0).GetView(2)
			lblW.Tag = x
			p.Tag = x
			Dim pnlPre As Panel = clvMain.GetPanel(x).GetView(1)
			pnlPre.Tag = x
		Next
	End If
End Sub

public Sub setSneakPreviewVisible (visible As Boolean)
	mSneakPreview = visible
	lblPreview.Visible = visible
End Sub

public Sub getSneakPreviewVisible As Boolean
	Return mSneakPreview
End Sub

private Sub GetInitials (name As String) As String
	Dim RetVal As String
	
	If name.Contains (" ") Then
		RetVal = name.SubString2 (0,1)
		Do While name.Contains (" ")
			name = name.SubString (name.IndexOf(" ") +1)
		Loop
		RetVal = RetVal & name.SubString2 (0,1)
	Else
		RetVal = name.SubString2 (0,1)
	End If
	Return RetVal
End Sub

Private Sub ShowOrHideMessagePreviewPanel (index As Int)
	Dim c As convoEntry = clvMain.GetValue (index)
	
	Dim iv As ImageView = clvMain.GetPanel (index).GetView(0).GetView(6)
	If 0 = iv.Tag Then iv.Tag = 1 Else iv.Tag = 0
	Dim m As Map = GeneratePanel (c.id, c.WithWho, c.dt, c.UnreadCount, c.avImg, iv.tag, index)
	Dim p As Panel = M.Get ("convo")
	clvMain.ReplaceAt (index, p, p.Height, m.Get ("data"))
End Sub

public Sub SetMessagePreview (id As String, previewText As String)
	Dim x As Int
	For x = 0 To clvMain.Size -1
		Dim c As convoEntry = clvMain.GetValue (x)
		Dim iv As ImageView = clvMain.GetPanel(x).GetView (0).Getview(6)
		If c.id = id And 1 = iv.tag Then
			Dim lbl As B4XView = clvMain.GetPanel(x).GetView (0).GetView(8)
			lbl.Text = previewText
			Exit
		End If
	Next
End Sub

'Long click on name / phone number. User wants to add/edit/delete contact or whole conversation. Let's find out which!
private Sub lblConvoWith_LongClick
	Dim lbl As B4XView = Sender

	HighlightConvo (lbl.Tag)
	
	Dim c As convoEntry
	c.Initialize
	c = GetConvoDetails (lbl.Tag)

	If xui.SubExists(mCallBack, mEventName & "_EditContactDetails", 1) Then
		CallSub2(mCallBack, mEventName & "_EditContactDetails", c)
	End If
End Sub

Private Sub HighlightConvo (index As Int)

	Dim p As Panel = clvMain.GetPanel (index)
	Dim p2 As Panel = p.GetView (0)
	Dim lbl As B4XView = clvMain.GetPanel(index).GetView(0).GetView(5)
	Dim selected As B4XView = clvMain.GetPanel (index).GetView(0).GetView(6)
		 
	If 0 = selected.Tag Then
		selected.Tag = 1
		p2.Color = mHighlightColor
		lbl.Color = mHighlightColor
		lblDelete.Visible=True
		lblDelete.Enabled=True
		lblAddEdit.Visible=True
		lblAddEdit.Enabled=True
		numSelected = numSelected + 1
		lblDelete.Color = mHighlightColor
		lblAddEdit.Color = mHighlightColor
		
		If numSelected > 1 Then
			lblAddEdit.Visible=False
			lblAddEdit.Enabled=False
		End If
	Else
		selected.Tag = 0
		p2.Color =mBackgroundColor
		lbl.Color = mBackgroundColor
		numSelected = numSelected - 1
		
		If numSelected = 0 Then
			lblDelete.Visible=False
			lblDelete.Enabled=False
			lblAddEdit.Visible=False
			lblAddEdit.Enabled=False
		End If
		
		If numSelected = 1 Then
			lblAddEdit.Visible=True
			lblAddEdit.Enabled=True
		End If
	End If
End Sub

private Sub GetSelected As List
	Dim l As List
	l.Initialize
	Dim x As Int
	
	For x = 0 To clvMain.Size -1
		Dim selected As B4XView = clvMain.GetPanel (x).GetView(0).GetView(6)
		If 1 = selected.Tag Then
			Dim c As convoEntry = clvMain.GetValue (x)
			l.Add (c.id)
		End If
	Next
	Return l
End Sub

Private Sub lblDelete_Click
	Dim l As List = GetSelected
	
	If xui.SubExists(mCallBack, mEventName & "_DeleteConversations", 1) Then
		CallSub2(mCallBack, mEventName & "_DeleteConversations", l)
	End If
End Sub

Private Sub lblAddEdit_Click
	Dim l As List = GetSelected
	
	If xui.SubExists(mCallBack, mEventName & "_EditContact", 1) Then
		CallSub2(mCallBack, mEventName & "_EditContact", l.Get (0))
	End If
End Sub

public Sub RemoveConversation (id As String)
	Dim x As Int
	
	For x = clvMain.Size -1 To 0 Step -1
		Dim c As convoEntry = clvMain.GetValue (x)
		If c.id = id Then
			clvMain.RemoveAt (x)
			ReorderCLV
		End If
	Next
End Sub

Private Sub pnlPreview_Click
	Dim i As Int = Sender.As(Panel).tag
	Dim lblp As B4XView = clvMain.GetPanel (i).GetView(0).GetView(2)
	
	If lblp.Visible Then
		SwapPreviewMode (i)
	End If
End Sub


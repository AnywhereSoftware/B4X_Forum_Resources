B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=12.5
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	Private xui As XUI
	Private CLV As CustomListView
	Private BBCodeView1 As BBCodeView
	Private Engine As BCTextEngine
	Private bc As BitmapCreator
	Private ArrowWidth As Int = 10dip
	Private Gap As Int = 6dip
	Private pnlBottom As B4XView
	#if b4a
	Private ime As IME
	#end if
	
	Private Realtime As SupabaseRealtime
	Private CurrentChannel As SupabaseRealtime_Channel
	Private m_RoomId As Int
	Private AS_TextFieldAdvanced1 As AS_TextFieldAdvanced
End Sub

'You can add more parameters here.
Public Sub Initialize As Object
	Return Me
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	'load the layout to Root
	Root.LoadLayout("frm_Chat")
	
	#if b4a
	ime.Initialize("ime")
	ime.AddHeightChangedEvent
	#Else If B4J
	CLV.sv.As(ScrollPane).Style="-fx-background:transparent;-fx-background-color:transparent;"
	#end if
	
	Engine.Initialize(Root)
	bc.Initialize(300, 300)
	
	Realtime.Initialize(Me,"Realtime",B4XPages.MainPage.xSupabase)
	
End Sub

Public Sub ShowDialog(RoomId As Int,RoomName As String)
	m_RoomId = RoomId
	B4XPages.SetTitle(Me,RoomName)
	GetMessages
End Sub

Private Sub B4XPage_Disappear
	Realtime.RemoveChannel(CurrentChannel)
End Sub

Private Sub B4XPage_Appear
	
	If Realtime.isConnected = False Then Realtime.Connect
	
	Do While Realtime.isConnected = False
		Sleep(0)
	Loop
	
	CurrentChannel = Realtime _
.Channel("public","dt_Chat",Realtime.BuildFilter("room_id",Realtime.Filter_Equal,m_RoomId)) _
.On(Realtime.SubscribeType_PostgresChanges) _
.Event(Realtime.Event_INSERT) _
.Subscribe

End Sub

Private Sub B4XPage_Resize (Width As Int, Height As Int)
	#If B4I
	pnlBottom.Top = Height - pnlBottom.Height - B4XPages.GetNativeParent(Me).SafeAreaInsets.Bottom
	CLV.AsView.Height = pnlBottom.Top
	CLV.Base_Resize(CLV.AsView.Width,CLV.AsView.Height)
	#End If
End Sub

Private Sub GetMessages
	
	CLV.Clear
	
	Wait For (B4XPages.MainPage.xSupabase.Auth.GetUser) Complete (User As SupabaseUser)
	
	Dim Query As Supabase_DatabaseSelect = B4XPages.MainPage.xSupabase.Database.SelectData
	Query.Columns("message,created_by,id, users(username)")
	Query.From("dt_Chat")
	Query.Filter_Equal(CreateMap("room_id":m_RoomId))

	Wait For (Query.Execute) Complete (DatabaseResult As SupabaseDatabaseResult)
	
	For Each Row As Map In  DatabaseResult.Rows
		
		AddItem(Row.Get("message"), Row.Get("created_by") = User.Id,Row.Get("users.username"))
		
	Next
	
End Sub

Private Sub Realtime_DataReceived(Data As SupabaseRealtime_Data)
	
	Wait For (B4XPages.MainPage.xSupabase.Auth.GetUser) Complete (User As SupabaseUser)
	
	If Data.EventType = Realtime.Event_INSERT Then 'A record in the database was changed
	  
		If Data.Records.Get("created_by") = User.Id Then
			AddItem(Data.Records.Get("message") , True,User.Metadata.Get("username"))
			Else
			'Get the Username of the sender
			Wait For (B4XPages.MainPage.xSupabase.Database.SelectData.Columns("username").From("users").Filter_Equal(CreateMap("id":Data.Records.Get("created_by"))).Execute) Complete (DatabaseResult As SupabaseDatabaseResult)
			AddItem(Data.Records.Get("message") , False,DatabaseResult.Rows.Get(0).As(Map).Get("username"))
		End If
      
	End If
	
End Sub

Private Sub IME_HeightChanged (NewHeight As Int, OldHeight As Int)
	HeightChanged(NewHeight)
End Sub

Private Sub B4XPage_KeyboardStateChanged (Height As Float)
	HeightChanged(Root.Height - Height - 10dip)
End Sub

Private Sub lblSend_Click
	If AS_TextFieldAdvanced1.Text.Length > 0 Then
'		LastUserLeft = Not(LastUserLeft)
'		AddItem(AS_TextFieldAdvanced1.Text, LastUserLeft)

		Dim Insert As Supabase_DatabaseInsert = B4XPages.MainPage.xSupabase.Database.InsertData
		Insert.From("dt_Chat")
		Wait For (Insert.Insert(CreateMap("room_id":m_RoomId,"message":AS_TextFieldAdvanced1.Text)).Upsert.Execute) Complete (DatabaseResult As SupabaseDatabaseResult)
	
		If DatabaseResult.Error.Success Then
			'Log("Erfolgreich")
		End If

	End If
	AS_TextFieldAdvanced1.Focus
	#if B4J
	Dim ta As TextArea = AS_TextFieldAdvanced1.NativeTextFieldMultiline
	ta.SelectAll
	#else if B4A
	Dim et As EditText = AS_TextFieldAdvanced1.NativeTextFieldMultiline
	et.SelectAll
	#else if B4i
	Dim ta As TextView = AS_TextFieldAdvanced1.NativeTextFieldMultiline
	ta.SelectAll
	#end if
	
End Sub

'Modifies the layout when the keyboard state changes.
Public Sub HeightChanged (NewHeight As Int)
	Dim c As B4XView = CLV.AsView
	c.Height = NewHeight - pnlBottom.Height
	CLV.Base_Resize(c.Width, c.Height)
	pnlBottom.Top = NewHeight - pnlBottom.Height
	ScrollToLastItem
End Sub

Private Sub AddItem (Text As String, Right As Boolean, Username As String)
	Dim p As B4XView = xui.CreatePanel("")
	p.Color = xui.Color_ARGB(255,32,33,37)
	BBCodeView1.ExternalRuns = BuildMessage(Text, Username)
	BBCodeView1.ParseAndDraw
	Dim ivText As B4XView = CreateImageView
	'get the bitmap from BBCodeView1 foreground layer.
	Dim bmpText As B4XBitmap = GetBitmap(BBCodeView1.ForegroundImageView)
	'the image might be scaled by Engine.mScale. The "correct" dimensions are:
	Dim TextWidth As Int = bmpText.Width / Engine.mScale
	Dim TextHeight As Int = bmpText.Height / Engine.mScale
	'bc is not really used here. Only the utility method.
	bc.SetBitmapToImageView(bmpText, ivText)
	Dim ivBG As B4XView = CreateImageView
	'Draw the bubble.
	Dim bmpBG As B4XBitmap = DrawBubble(TextWidth, TextHeight, Right)
	bc.SetBitmapToImageView(bmpBG, ivBG)
	p.SetLayoutAnimated(0, 0, 0, CLV.sv.ScrollViewContentWidth - 2dip, TextHeight + 3 * Gap)
	If Right Then
		p.AddView(ivBG, p.Width - bmpBG.Width * xui.Scale, Gap, bmpBG.Width * xui.Scale, bmpBG.Height * xui.Scale)
		p.AddView(ivText, p.Width - Gap - ArrowWidth - TextWidth, 2 * Gap, TextWidth, TextHeight)
	Else
		p.AddView(ivBG, 0, Gap, bmpBG.Width * xui.Scale, bmpBG.Height * xui.Scale)
		p.AddView(ivText, Gap + ArrowWidth, 2 * Gap, TextWidth, TextHeight)
	End If
	CLV.Add(p, Null)
	ScrollToLastItem
End Sub

Private Sub ScrollToLastItem
	Sleep(50)
	If CLV.Size > 0 Then
		If CLV.sv.ScrollViewContentHeight > CLV.sv.Height Then
			CLV.ScrollToItem(CLV.Size - 1)
		End If
	End If
End Sub

Private Sub DrawBubble (Width As Int, Height As Int, Right As Boolean) As B4XBitmap
	'The bubble doesn't need to be high density as it is a simple drawing.
	Width = Ceil(Width / xui.Scale)
	Height = Ceil(Height / xui.Scale)
	Dim ScaledGap As Int = Ceil(Gap / xui.Scale)
	Dim ScaledArrowWidth As Int = Ceil(ArrowWidth / xui.Scale)
	Dim nw As Int = Width + 2 * ScaledGap + ScaledArrowWidth
	Dim nh As Int = Height + 2 * ScaledGap
	If bc.mWidth < nw Or bc.mHeight < nh Then
		bc.Initialize(Max(bc.mWidth, nw), Max(bc.mHeight, nh))
	End If
	bc.DrawRect(bc.TargetRect, xui.Color_Transparent, True, 0)
	Dim r As B4XRect
	Dim path As BCPath
	Dim clr As Int
	If Right Then clr = 0xFFEFEFEF Else clr = 0xFFC1F7A3
	If Right Then
		r.Initialize(0, 0, nw - ScaledArrowWidth, nh)
		path.Initialize(nw - 1, 1)
		path.LineTo(nw - 1 - (10 + ScaledArrowWidth), 1)
		path.LineTo(nw - 1 - ScaledArrowWidth, 10)
		path.LineTo(nw - 1, 1)
	Else
		r.Initialize(ScaledArrowWidth, 1dip, nw, nh)
		path.Initialize(1, 1)
		path.LineTo((10 + ScaledArrowWidth), 1)
		path.LineTo(ScaledArrowWidth, 10)
		path.LineTo(1, 1)
	End If
	bc.DrawRectRounded(r, clr, True, 0, 10)
	bc.DrawPath(path, clr, True, 0)
	bc.DrawPath(path, clr, False, 2)
	Dim b As B4XBitmap = bc.Bitmap
	Return b.Crop(0, 1, nw, nh)
End Sub

Private Sub BuildMessage (Text As String, User As String) As List
	Dim title As BCTextRun = Engine.CreateRun(User & CRLF)
	title.TextFont  = BBCodeView1.ParseData.DefaultBoldFont
	Dim TextRun As BCTextRun = Engine.CreateRun(Text & CRLF)
	Dim time As BCTextRun = Engine.CreateRun(DateTime.Time(DateTime.Now))
	time.TextFont = xui.CreateDefaultFont(10)
	time.TextColor = xui.Color_Gray
	Return Array(title, TextRun, time)
End Sub

Private Sub GetBitmap (iv As ImageView) As B4XBitmap
	#if B4J
	Return iv.GetImage
	#Else If B4A or B4i
	Return iv.Bitmap
	#End If
End Sub

Private Sub CLV_ItemClick (Index As Int, Value As Object)
	#if B4i
	Dim tf As View = AS_TextFieldAdvanced1.TextField
	tf.ResignFocus
	#End If
End Sub

Private Sub CreateImageView As B4XView
	Dim iv As ImageView
	iv.Initialize("")
	Return iv
End Sub

#if B4J
Sub lblSend_MouseClicked (EventData As MouseEvent)
	lblSend_Click
	EventData.Consume
End Sub
#end if